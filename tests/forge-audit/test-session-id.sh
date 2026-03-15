#!/usr/bin/env bash
# Test: forge-audit events in the same session share the same session_id
# RED phase: fails until bin/forge-audit is implemented

set -uo pipefail

PASS=0
FAIL=0

pass() { echo "  PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL: $1"; FAIL=$((FAIL + 1)); }

FORGE_BIN="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/bin"
export PATH="$FORGE_BIN:$PATH"

TMPDIR=$(mktemp -d /tmp/forge-audit-session-XXXXXX)
trap "rm -rf '$TMPDIR'" EXIT

echo "=== test-session-id: events share session_id ==="
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

# Record two events in the same session
forge-audit record --type skill_enter --skill brainstorming --project-dir "$TMPDIR" > /dev/null 2>&1
forge-audit record --type skill_exit --skill brainstorming --project-dir "$TMPDIR" > /dev/null 2>&1

# Find the JSONL file
AUDIT_DIR="$TMPDIR/.forge/local/audit"
JSONL_FILE=$(find "$AUDIT_DIR" -name '*.jsonl' 2>/dev/null | head -1)
if [ -z "$JSONL_FILE" ]; then
    fail "no .jsonl file found in $AUDIT_DIR"
    echo ""
    echo "============================================"
    echo "Results: $PASS passed, $FAIL failed"
    echo "============================================"
    exit 1
fi

# Extract session_id from both lines
SID1=$(python3 -c "
import json
with open('$JSONL_FILE') as f:
    lines = f.readlines()
print(json.loads(lines[0])['session_id'])
" 2>/dev/null)

SID2=$(python3 -c "
import json
with open('$JSONL_FILE') as f:
    lines = f.readlines()
print(json.loads(lines[1])['session_id'])
" 2>/dev/null)

# Assert: session_id is not empty
if [ -n "$SID1" ]; then
    pass "session_id is not empty"
else
    fail "session_id is empty"
fi

# Assert: both events share the same session_id
if [ "$SID1" = "$SID2" ]; then
    pass "both events have the same session_id"
else
    fail "session_ids differ: '$SID1' vs '$SID2'"
fi

echo ""
echo "============================================"
echo "Results: $PASS passed, $FAIL failed"
echo "============================================"

if [ $FAIL -gt 0 ]; then
    exit 1
fi
exit 0
