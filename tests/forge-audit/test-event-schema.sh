#!/usr/bin/env bash
# Test: each event type contains its required fields
# RED phase: fails until bin/forge-audit is implemented

set -uo pipefail

PASS=0
FAIL=0

pass() { echo "  PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL: $1"; FAIL=$((FAIL + 1)); }

FORGE_BIN="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/bin"
export PATH="$FORGE_BIN:$PATH"

TMPDIR=$(mktemp -d /tmp/forge-audit-schema-XXXXXX)
trap "rm -rf '$TMPDIR'" EXIT

echo "=== test-event-schema: required fields per event type ==="
echo ""

# Check forge-audit exists
if ! command -v forge-audit &>/dev/null; then
    fail "forge-audit not found — expected at bin/forge-audit"
    echo ""
    echo "============================================"
    echo "Results: $PASS passed, $FAIL failed"
    echo "============================================"
    exit 1
fi

# Setup: init state, enable audit
forge-state init --project-dir "$TMPDIR" > /dev/null 2>&1
forge-state set "audit.enabled" "true" --project-dir "$TMPDIR" > /dev/null 2>&1

# Helper: record event, read last line, check fields exist
check_event() {
    local event_type="$1"
    shift
    local extra_args=("$@")
    local required_fields=""

    case "$event_type" in
        session_start)   required_fields="timestamp session_id action_type host" ;;
        skill_enter)     required_fields="timestamp session_id action_type skill" ;;
        skill_exit)      required_fields="timestamp session_id action_type skill" ;;
        gate_check)      required_fields="timestamp session_id action_type outcome detail" ;;
        task_completion) required_fields="timestamp session_id action_type" ;;
        routing_decision) required_fields="timestamp session_id action_type detail" ;;
    esac

    # Record the event
    forge-audit record --type "$event_type" "${extra_args[@]}" --project-dir "$TMPDIR" > /dev/null 2>&1

    # Read last line from the JSONL file
    local AUDIT_DIR="$TMPDIR/.forge/local/audit"
    local JSONL_FILE
    JSONL_FILE=$(find "$AUDIT_DIR" -name '*.jsonl' 2>/dev/null | head -1)

    if [ -z "$JSONL_FILE" ]; then
        fail "[$event_type] no .jsonl file found"
        return
    fi

    local LAST_LINE
    LAST_LINE=$(tail -1 "$JSONL_FILE")

    for field in $required_fields; do
        if python3 -c "import json; d=json.loads('''$LAST_LINE'''); assert '$field' in d" 2>/dev/null; then
            pass "[$event_type] has field '$field'"
        else
            fail "[$event_type] missing field '$field'"
        fi
    done
}

# Test each event type
check_event "session_start" --host claude-code
check_event "skill_enter" --skill brainstorming
check_event "skill_exit" --skill brainstorming
check_event "gate_check" --outcome pass --detail "all checks passed"
check_event "task_completion"
check_event "routing_decision" --detail "routed to backend specialist"

echo ""
echo "============================================"
echo "Results: $PASS passed, $FAIL failed"
echo "============================================"

if [ $FAIL -gt 0 ]; then
    exit 1
fi
exit 0
