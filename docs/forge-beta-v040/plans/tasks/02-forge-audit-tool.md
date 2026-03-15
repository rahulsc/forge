# Task 2: Implement bin/forge-audit Tool

**Specialist:** implementer (shell engineer)
**Depends on:** Task 1 (test suite must exist)
**Produces:** `bin/forge-audit` — all T1 tests must PASS (GREEN phase)

## Goal

Implement the `bin/forge-audit` shell script to make all tests from Task 1 pass.

## Acceptance Criteria

- [ ] `bin/forge-audit` exists and is executable
- [ ] `forge-audit record --type <type>` appends a JSON line to `.forge/local/audit/<session-id>.jsonl`
- [ ] `forge-audit list` outputs all events for current session
- [ ] `forge-audit list --session <id>` outputs events for a specific session
- [ ] No events recorded when `audit.enabled` is false or unset
- [ ] Session ID is consistent within a session (generated once, reused)
- [ ] Each event has: timestamp, session_id, action_type, outcome
- [ ] All tests from T1 PASS
- [ ] GREEN evidence provided: test output showing all pass

## Test Expectations

- **Test:** Run T1's test suite
- **Expected red failure:** Already demonstrated in T1
- **Expected green:** All tests pass — `N passed, 0 failed`

## Files

- Create: `bin/forge-audit`

## Implementation Notes

Follow the pattern of existing bin tools (`bin/forge-state`, `bin/forge-evidence`):
- `#!/usr/bin/env bash` + `set -euo pipefail`
- Source shared backend library if needed
- Use `forge-state get audit.enabled` to check if audit is on
- Session ID: use `FORGE_SESSION_ID` env var if set, otherwise generate from timestamp
- JSONL storage: `.forge/local/audit/<session-id>.jsonl`
- Use `jq` if available for JSON formatting, otherwise printf
- Ensure `.forge/local/audit/` directory exists before writing

**Command interface:**
```
forge-audit record --type <event_type> [options]
  --type         required: session_start, skill_enter, skill_exit, gate_check, task_completion, routing_decision
  --skill        skill name (for skill_enter/skill_exit)
  --workflow     workflow name
  --risk-tier    risk tier
  --outcome      success|failure|skipped (default: success)
  --tokens-in    input token count
  --tokens-out   output token count
  --duration-ms  duration in milliseconds
  --detail       JSON string for additional context

forge-audit list [--session <session-id>]
  Lists events as JSONL (one per line)
  Default: current session
```

**Do NOT add features beyond what the tests require.** YAGNI — the tests define the contract.

## Commit

`feat: implement bin/forge-audit tool (TDD GREEN phase — all tests pass)`
