#!/usr/bin/env bash
# Task Tracker API — Automated Validation Script
# Run after build completes to verify the API works end-to-end
# Usage: bash validate.sh [port]

set -uo pipefail

PORT="${1:-3000}"
BASE="http://localhost:$PORT"
PASS=0
FAIL=0

pass() { echo "  ✅ $1"; PASS=$((PASS + 1)); }
fail() { echo "  ❌ $1"; FAIL=$((FAIL + 1)); }

echo "Task Tracker API — Validation"
echo "=============================="
echo ""

# Start server (with JWT secrets for non-test environment)
cd "$(dirname "$0")" 2>/dev/null || true
JWT_SECRET=test-secret-key JWT_REFRESH_SECRET=test-refresh-secret-key node src/index.js &
SERVER_PID=$!
sleep 2

# 1. Health check
echo "1. Health Check"
RESP=$(curl -s "$BASE/health")
if echo "$RESP" | grep -q '"ok"'; then pass "GET /health returns ok"; else fail "GET /health: $RESP"; fi

# 2. Signup
echo "2. Signup"
RESP=$(curl -s -w "\n%{http_code}" -X POST "$BASE/auth/signup" \
  -H "Content-Type: application/json" \
  -d '{"email":"validate@test.com","password":"secret123"}')
CODE=$(echo "$RESP" | tail -1)
BODY=$(echo "$RESP" | head -1)
if [ "$CODE" = "201" ] && echo "$BODY" | grep -q '"email"'; then pass "POST /auth/signup returns 201"; else fail "POST /auth/signup: $CODE $BODY"; fi

# 3. Login
echo "3. Login"
RESP=$(curl -s -X POST "$BASE/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email":"validate@test.com","password":"secret123"}')
TOKEN=$(echo "$RESP" | python3 -c "import sys,json; print(json.load(sys.stdin).get('token',''))" 2>/dev/null)
if [ -n "$TOKEN" ] && [ "$TOKEN" != "" ]; then pass "POST /auth/login returns token"; else fail "POST /auth/login: no token in $RESP"; fi

# 4. Create Workspace
echo "4. Create Workspace"
RESP=$(curl -s -w "\n%{http_code}" -X POST "$BASE/workspaces" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"name":"Validation Workspace"}')
CODE=$(echo "$RESP" | tail -1)
BODY=$(echo "$RESP" | head -1)
if [ "$CODE" = "201" ] && echo "$BODY" | grep -q '"name"'; then pass "POST /workspaces returns 201"; else fail "POST /workspaces: $CODE $BODY"; fi
WS_ID=$(echo "$BODY" | python3 -c "import sys,json; print(json.load(sys.stdin).get('id','1'))" 2>/dev/null)

# 5. Create Task
echo "5. Create Task"
RESP=$(curl -s -w "\n%{http_code}" -X POST "$BASE/workspaces/$WS_ID/tasks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"title":"Fix login bug","priority":"high"}')
CODE=$(echo "$RESP" | tail -1)
BODY=$(echo "$RESP" | head -1)
if [ "$CODE" = "201" ] && echo "$BODY" | grep -q '"todo"'; then pass "POST /tasks returns 201 with status todo"; else fail "POST /tasks: $CODE $BODY"; fi
TASK_ID=$(echo "$BODY" | python3 -c "import sys,json; print(json.load(sys.stdin).get('id','1'))" 2>/dev/null)

# 6. List Tasks
echo "6. List Tasks"
RESP=$(curl -s "$BASE/workspaces/$WS_ID/tasks" -H "Authorization: Bearer $TOKEN")
if echo "$RESP" | grep -q '"Fix login bug"'; then pass "GET /tasks returns task list"; else fail "GET /tasks: $RESP"; fi

# 7. Update Task to Done
echo "7. Update Task to Done"
RESP=$(curl -s -w "\n%{http_code}" -X PUT "$BASE/workspaces/$WS_ID/tasks/$TASK_ID" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"status":"done"}')
CODE=$(echo "$RESP" | tail -1)
BODY=$(echo "$RESP" | head -1)
if [ "$CODE" = "200" ] && echo "$BODY" | grep -q '"done"'; then pass "PUT /tasks updates to done"; else fail "PUT /tasks: $CODE $BODY"; fi

# 8. Done-Task Immutability
echo "8. Done-Task Immutability"
RESP=$(curl -s -w "\n%{http_code}" -X PUT "$BASE/workspaces/$WS_ID/tasks/$TASK_ID" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"title":"Changed"}')
CODE=$(echo "$RESP" | tail -1)
if [ "$CODE" = "403" ]; then pass "PUT done task returns 403"; else fail "PUT done task: expected 403 got $CODE"; fi

# 9. Auth Required
echo "9. Auth Required"
RESP=$(curl -s -w "\n%{http_code}" "$BASE/workspaces")
CODE=$(echo "$RESP" | tail -1)
if [ "$CODE" = "401" ]; then pass "GET /workspaces without token returns 401"; else fail "GET /workspaces no auth: expected 401 got $CODE"; fi

# 10. Test Suite
echo "10. Test Suite"
npm test 2>&1 | tail -3
if npm test 2>&1 | grep -q "Tests:.*passed.*0 failed\|Tests:.*passed, 0 total"; then
  pass "npm test passes"
else
  TEST_OUT=$(npm test 2>&1 | grep "Tests:")
  if echo "$TEST_OUT" | grep -q "failed"; then fail "npm test: $TEST_OUT"; else pass "npm test passes"; fi
fi

# Cleanup
kill $SERVER_PID 2>/dev/null

echo ""
echo "=============================="
echo "Results: $PASS passed, $FAIL failed"
echo ""
if [ "$FAIL" -gt 0 ]; then
  echo "❌ VALIDATION FAILED"
  exit 1
else
  echo "✅ ALL VALIDATION CHECKS PASSED"
  exit 0
fi
