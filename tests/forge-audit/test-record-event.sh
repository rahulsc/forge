#!/usr/bin/env bash
# Test: forge-audit record creates JSONL entries with correct schema
# RED phase: fails until bin/forge-audit is implemented

set -uo pipefail

PASS=0
FAIL=0

pass() { echo "  PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL: $1"; FAIL=$((FAIL + 1)); }

FORGE_BIN="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/bin"
export PATH="$FORGE_BIN:$PATH"

TMPDIR=$(mktemp -d /tmp/forge-audit-record-XXXXXX)
trap "rm -rf '$TMPDIR'" EXIT

echo "=== test-record-event: record creates JSONL entries ==="
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

# Action: record a session_start event
forge-audit record --type session_start --host claude-code --project-dir "$TMPDIR" > /dev/null 2>&1

# Assert: .forge/local/audit/ directory has a .jsonl file
AUDIT_DIR="$TMPDIR/.forge/local/audit"
JSONL_FILES=$(find "$AUDIT_DIR" -name '*.jsonl' 2>/dev/null | head -1)
if [ -n "$JSONL_FILES" ]; then
    pass "audit directory contains a .jsonl file"
else
    fail "no .jsonl file found in $AUDIT_DIR"
    echo ""
    echo "============================================"
    echo "Results: $PASS passed, $FAIL failed"
    echo "============================================"
    exit 1
fi

# Assert: last line is valid JSON
LAST_LINE=$(tail -1 "$JSONL_FILES")
if python3 -c "import json; json.loads('''$LAST_LINE''')" 2>/dev/null; then
    pass "last line is valid JSON"
else
    fail "last line is not valid JSON: $LAST_LINE"
fi

# Assert: JSON has required fields: timestamp, session_id, action_type
for field in timestamp session_id action_type; do
    if python3 -c "import json,sys; d=json.loads('''$LAST_LINE'''); assert '$field' in d" 2>/dev/null; then
        pass "JSON contains field '$field'"
    else
        fail "JSON missing field '$field'"
    fi
done

# Assert: action_type == "session_start"
ACTION=$(python3 -c "import json; print(json.loads('''$LAST_LINE''')['action_type'])" 2>/dev/null)
if [ "$ACTION" = "session_start" ]; then
    pass "action_type is 'session_start'"
else
    fail "action_type is '$ACTION', expected 'session_start'"
fi

echo ""
echo "============================================"
echo "Results: $PASS passed, $FAIL failed"
echo "============================================"

if [ $FAIL -gt 0 ]; then
    exit 1
fi
exit 0
