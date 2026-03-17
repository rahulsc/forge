#!/usr/bin/env bash
# Dashboard UI — Automated Validation Script
set -uo pipefail

cd "$(dirname "$0")" 2>/dev/null || true
PASS=0; FAIL=0
pass() { echo "  ✅ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ❌ $1"; FAIL=$((FAIL + 1)); }

echo "Dashboard UI — Validation"
echo "========================="
echo ""

# 1. Tests pass
echo "1. Tests"
if npm test -- --watchAll=false 2>&1 | grep -q "Tests:.*passed"; then
  pass "npm test passes"
else
  fail "npm test failed"
fi

# 2. Build (if applicable)
echo "2. Build"
if npm run build 2>&1; then
  pass "npm run build succeeds"
else
  fail "npm run build failed"
fi

echo ""
echo "========================="
echo "Results: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then echo "❌ VALIDATION FAILED"; exit 1
else echo "✅ ALL VALIDATION CHECKS PASSED"; exit 0; fi
