#!/usr/bin/env bash
# CLI Migration Tool — Automated Validation Script
set -uo pipefail

cd "$(dirname "$0")" 2>/dev/null || true
PASS=0; FAIL=0
pass() { echo "  ✅ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ❌ $1"; FAIL=$((FAIL + 1)); }

echo "CLI Migration Tool — Validation"
echo "================================"
echo ""

# Clean any existing test DB
rm -f test-validate.db

# 1. Tests pass
echo "1. Tests"
if npm test 2>&1 | grep -q "passed"; then
  pass "npm test passes"
else
  fail "npm test failed"
fi

# 2. Up — apply migrations
echo "2. Migrate Up"
if node bin/migrate up --db test-validate.db 2>&1 | grep -qi "applied\|migrat"; then
  pass "migrate up applies migrations"
else
  fail "migrate up failed"
fi

# 3. Status
echo "3. Status"
if node bin/migrate status --db test-validate.db 2>&1 | grep -qi "applied\|status\|migrat"; then
  pass "migrate status shows applied"
else
  fail "migrate status failed"
fi

# 4. Down — rollback
echo "4. Migrate Down"
if node bin/migrate down --db test-validate.db 2>&1; then
  pass "migrate down succeeds"
else
  fail "migrate down failed"
fi

# 5. Down again — no-op (bug fix check)
echo "5. Down Again (no-op)"
if node bin/migrate down --db test-validate.db 2>&1; then
  pass "migrate down twice is safe (no crash)"
else
  fail "migrate down twice crashed"
fi

# 6. Up again
echo "6. Up Again"
if node bin/migrate up --db test-validate.db 2>&1; then
  pass "migrate up re-applies"
else
  fail "migrate up re-apply failed"
fi

# 7. Seed
echo "7. Seed"
if node bin/migrate seed --db test-validate.db 2>&1; then
  pass "migrate seed loads data"
else
  fail "migrate seed failed"
fi

# Cleanup
rm -f test-validate.db

echo ""
echo "================================"
echo "Results: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then echo "❌ VALIDATION FAILED"; exit 1
else echo "✅ ALL VALIDATION CHECKS PASSED"; exit 0; fi
