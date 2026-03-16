# Task Tracker API — User Validation Checklist

Run these checks AFTER the reference project build completes to verify the output works.

## Prerequisites

From the reference project directory:
```bash
cd <worktree>/reference-projects/task-tracker-api
npm install  # if not already done
```

Start the server in background:
```bash
node src/index.js &
SERVER_PID=$!
```

## 1. Health Check

```bash
curl -s http://localhost:3000/health | jq .
```

**Expected:**
```json
{ "status": "ok" }
```

## 2. Signup

```bash
curl -s -X POST http://localhost:3000/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"secret123"}' | jq .
```

**Expected:** 201 with `{ "id": 1, "email": "test@example.com" }`

## 3. Login

```bash
TOKEN=$(curl -s -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"secret123"}' | jq -r '.token')
echo "Token: $TOKEN"
```

**Expected:** Token string printed (JWT format)

## 4. Create Workspace

```bash
curl -s -X POST http://localhost:3000/workspaces \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"name":"My Project"}' | jq .
```

**Expected:** 201 with workspace object including `id`, `name`, `owner_id`

## 5. Create Task

```bash
curl -s -X POST http://localhost:3000/workspaces/1/tasks \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"title":"Fix login bug","priority":"high"}' | jq .
```

**Expected:** 201 with task object including `id`, `title`, `status: "todo"`, `priority: "high"`

## 6. List Tasks

```bash
curl -s http://localhost:3000/workspaces/1/tasks \
  -H "Authorization: Bearer $TOKEN" | jq .
```

**Expected:** Array with 1 task

## 7. Update Task to Done

```bash
curl -s -X PUT http://localhost:3000/workspaces/1/tasks/1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"status":"done"}' | jq .
```

**Expected:** 200 with updated task, `status: "done"`

## 8. Verify Done-Task Immutability (Bug Fix)

```bash
curl -s -X PUT http://localhost:3000/workspaces/1/tasks/1 \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"title":"Changed title"}' | jq .
```

**Expected:** 403 with `{ "error": "Done tasks are immutable" }`

## 9. Auth Required (No Token)

```bash
curl -s http://localhost:3000/workspaces | jq .
```

**Expected:** 401 with error about missing/invalid token

## 10. Run Test Suite

```bash
npm test
```

**Expected:** All tests pass, 0 failures

## Cleanup

```bash
kill $SERVER_PID
```

## Pass/Fail Summary

| # | Check | Pass? |
|---|-------|-------|
| 1 | Health check | |
| 2 | Signup | |
| 3 | Login + token | |
| 4 | Create workspace | |
| 5 | Create task | |
| 6 | List tasks | |
| 7 | Update task to done | |
| 8 | Done-task immutability (403) | |
| 9 | Auth required (401) | |
| 10 | Test suite passes | |
