#!/usr/bin/env bash
# Test: forge-audit does not record when audit is disabled
# RED phase: fails until bin/forge-audit is implemented

set -uo pipefail

PASS=0
FAIL=0

pass() { echo "  PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL: $1"; FAIL=$((FAIL + 1)); }

FORGE_BIN="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/bin"
export PATH="$FORGE_BIN:$PATH"

TMPDIR=$(mktemp -d /tmp/forge-audit-disabled-XXXXXX)
trap "rm -rf '$TMPDIR'" EXIT

echo "=== test-audit-disabled: no recording when audit is off ==="
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

# --- Case 1: audit never enabled (no audit.enabled key) ---
forge-state init --project-dir "$TMPDIR" > /dev/null 2>&1

forge-audit record --type session_start --host claude-code --project-dir "$TMPDIR" > /dev/null 2>&1

AUDIT_DIR="$TMPDIR/.forge/local/audit"
JSONL_COUNT=$(find "$AUDIT_DIR" -name '*.jsonl' 2>/dev/null | wc -l)
if [ "$JSONL_COUNT" -eq 0 ]; then
    pass "no .jsonl files when audit is not enabled"
else
    fail "found $JSONL_COUNT .jsonl file(s) when audit was never enabled"
fi

# --- Case 2: audit explicitly disabled ---
TMPDIR2=$(mktemp -d /tmp/forge-audit-disabled2-XXXXXX)
trap "rm -rf '$TMPDIR' '$TMPDIR2'" EXIT

forge-state init --project-dir "$TMPDIR2" > /dev/null 2>&1
forge-state set "audit.enabled" "false" --project-dir "$TMPDIR2" > /dev/null 2>&1

forge-audit record --type session_start --host claude-code --project-dir "$TMPDIR2" > /dev/null 2>&1

AUDIT_DIR2="$TMPDIR2/.forge/local/audit"
JSONL_COUNT2=$(find "$AUDIT_DIR2" -name '*.jsonl' 2>/dev/null | wc -l)
if [ "$JSONL_COUNT2" -eq 0 ]; then
    pass "no .jsonl files when audit.enabled=false"
else
    fail "found $JSONL_COUNT2 .jsonl file(s) when audit.enabled=false"
fi

echo ""
echo "============================================"
echo "Results: $PASS passed, $FAIL failed"
echo "============================================"

if [ $FAIL -gt 0 ]; then
    exit 1
fi
exit 0
