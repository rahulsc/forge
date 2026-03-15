# Task 1: Write TDD Test Suite for forge-audit

**Specialist:** qa-engineer
**Depends on:** None
**Produces:** `tests/forge-audit/` test suite — all tests must FAIL (RED phase)

## Goal

Write the test suite for `bin/forge-audit` BEFORE the tool exists. All tests must fail when run — proving they test real behavior, not just existence.

## Acceptance Criteria

- [ ] `tests/forge-audit/test-record-event.sh` exists — tests that `forge-audit record` creates a valid JSONL line
- [ ] `tests/forge-audit/test-audit-disabled.sh` exists — tests that no events are recorded when audit is disabled
- [ ] `tests/forge-audit/test-session-id.sh` exists — tests that session_id is consistent within a session
- [ ] `tests/forge-audit/test-event-schema.sh` exists — tests that each event type has required fields
- [ ] `tests/forge-audit/test-list-events.sh` exists — tests that `forge-audit list` returns recorded events
- [ ] All tests FAIL when run (bin/forge-audit doesn't exist yet)
- [ ] RED evidence provided: test output showing failures

## Test Expectations

- **Test:** Run the test suite — all tests should fail
- **Expected red failure:** `bin/forge-audit: command not found` or similar
- **Expected green:** N/A — this task produces RED only. GREEN comes in Task 2.

## Files

- Create: `tests/forge-audit/test-record-event.sh`
- Create: `tests/forge-audit/test-audit-disabled.sh`
- Create: `tests/forge-audit/test-session-id.sh`
- Create: `tests/forge-audit/test-event-schema.sh`
- Create: `tests/forge-audit/test-list-events.sh`

## Implementation Notes

Follow the existing test pattern from `tests/forge-state/test-get-set.sh`:
- `#!/usr/bin/env bash` + `set -uo pipefail`
- `FORGE_BIN` path resolution from script location
- `pass()` / `fail()` helper functions
- Temp project dir for each test run
- Cleanup on exit

**What each test should verify:**

**test-record-event.sh:**
```bash
# Setup: enable audit, init state
# Action: forge-audit record --type session_start --host claude-code
# Assert: .forge/local/audit/*.jsonl exists
# Assert: last line is valid JSON
# Assert: JSON has timestamp, session_id, action_type fields
# Assert: action_type == "session_start"
```

**test-audit-disabled.sh:**
```bash
# Setup: do NOT enable audit (or set audit.enabled=false)
# Action: forge-audit record --type session_start
# Assert: no .jsonl files created in .forge/local/audit/
```

**test-session-id.sh:**
```bash
# Setup: enable audit
# Action: forge-audit record --type skill_enter --skill brainstorming
# Action: forge-audit record --type skill_exit --skill brainstorming
# Assert: both events have the same session_id
```

**test-event-schema.sh:**
```bash
# For each event type (session_start, skill_enter, skill_exit, gate_check, task_completion):
# Action: forge-audit record --type <type> [--required-args]
# Assert: JSON line contains all required fields from schema
# Required: timestamp, session_id, action_type, outcome
# Type-specific: skill_enter needs skill field, gate_check needs detail field
```

**test-list-events.sh:**
```bash
# Setup: enable audit, record 3 events
# Action: forge-audit list
# Assert: output contains 3 lines
# Assert: each line is valid JSON
```

## Commit

`test: write RED test suite for bin/forge-audit (TDD first phase)`
