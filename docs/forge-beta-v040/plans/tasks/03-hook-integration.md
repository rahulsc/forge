# Task 3: Integrate forge-audit into Hooks

**Specialist:** implementer (shell engineer)
**Depends on:** Task 2 (bin/forge-audit must work)
**Produces:** Hooks emit JSONL events when audit is enabled

## Goal

Add `forge-audit record` calls to existing hooks so workflow events are automatically recorded.

## Acceptance Criteria

- [ ] `hooks/forge-session-start` calls `forge-audit record --type session_start` after state init
- [ ] `hooks/forge-task-completed` calls `forge-audit record --type task_completion` with available token/duration data
- [ ] `hooks/forge-pre-commit` (or `pre-commit-gate`) calls `forge-audit record --type gate_check` with result
- [ ] Events only recorded when audit is enabled (no overhead otherwise)
- [ ] Hook failures from forge-audit do not block the main hook action (audit is best-effort)

## Test Expectations

- **Test:** Enable audit, trigger session start hook, check JSONL file exists with session_start event
- **Expected red failure:** No JSONL file created (hooks don't call forge-audit yet)
- **Expected green:** JSONL file contains session_start event

## Files

- Modify: `hooks/forge-session-start`
- Modify: `hooks/forge-task-completed`
- Modify: `hooks/forge-pre-commit` (or `hooks/pre-commit-gate`)

## Implementation Notes

Each hook modification follows the same pattern:
```bash
# At end of hook (after main logic), add:
if bin/forge-state get audit.enabled --project-dir . 2>/dev/null | grep -q "true"; then
  bin/forge-audit record --type <event_type> [--args] 2>/dev/null || true
fi
```

The `|| true` ensures audit failures never block the hook's primary function.

For `forge-task-completed`: if token/duration data is available in environment variables (e.g., from Claude Code), pass it via `--tokens-in` / `--tokens-out` / `--duration-ms`. If not available, omit — fields will be null.

## Commit

`feat: integrate forge-audit recording into session, task, and gate hooks`
