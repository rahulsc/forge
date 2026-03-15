#!/usr/bin/env bash
# Test: forge-audit list returns recorded events
# RED phase: fails until bin/forge-audit is implemented

set -uo pipefail

PASS=0
FAIL=0

pass() { echo "  PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL: $1"; FAIL=$((FAIL + 1)); }

FORGE_BIN="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/bin"
export PATH="$FORGE_BIN:$PATH"

TMPDIR=$(mktemp -d /tmp/forge-audit-list-XXXXXX)
trap "rm -rf '$TMPDIR'" EXIT

echo "=== test-list-events: list returns recorded events ==="
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

# Record 3 events
forge-audit record --type session_start --host claude-code --project-dir "$TMPDIR" > /dev/null 2>&1
forge-audit record --type skill_enter --skill brainstorming --project-dir "$TMPDIR" > /dev/null 2>&1
forge-audit record --type skill_exit --skill brainstorming --project-dir "$TMPDIR" > /dev/null 2>&1

# List all events
LIST_OUTPUT=$(forge-audit list --project-dir "$TMPDIR" 2>/dev/null)
LINE_COUNT=$(echo "$LIST_OUTPUT" | wc -l)

if [ "$LINE_COUNT" -eq 3 ]; then
    pass "list returns 3 lines for 3 events"
else
    fail "list returned $LINE_COUNT lines, expected 3"
fi

# Assert: each line is valid JSON
ALL_VALID=true
while IFS= read -r line; do
    if ! python3 -c "import json; json.loads('''$line''')" 2>/dev/null; then
        ALL_VALID=false
        break
    fi
done <<< "$LIST_OUTPUT"

if [ "$ALL_VALID" = true ]; then
    pass "all listed lines are valid JSON"
else
    fail "one or more listed lines are not valid JSON"
fi

# Extract session_id from the first event
SESSION_ID=$(python3 -c "import json; print(json.loads('''$(echo "$LIST_OUTPUT" | head -1)''')['session_id'])" 2>/dev/null)

# List filtered by session
FILTERED_OUTPUT=$(forge-audit list --session "$SESSION_ID" --project-dir "$TMPDIR" 2>/dev/null)
FILTERED_COUNT=$(echo "$FILTERED_OUTPUT" | wc -l)

if [ "$FILTERED_COUNT" -eq 3 ]; then
    pass "list --session returns 3 lines for matching session"
else
    fail "list --session returned $FILTERED_COUNT lines, expected 3"
fi

echo ""
echo "============================================"
echo "Results: $PASS passed, $FAIL failed"
echo "============================================"

if [ $FAIL -gt 0 ]; then
    exit 1
fi
exit 0
