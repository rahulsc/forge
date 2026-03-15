# Task 6: Add Audit Opt-In to Brainstorming

**Specialist:** forge-author
**Depends on:** None
**Produces:** Brainstorming skill asks about audit mode (default: no)

## Goal

Add a one-time audit opt-in question to the brainstorming skill so users can choose whether to record workflow events.

## Acceptance Criteria

- [ ] Brainstorming SKILL.md has audit opt-in question in Step 1 (after context exploration)
- [ ] Question text: "Would you like to enable audit mode for this project?" with explanation
- [ ] Default is no (explicit)
- [ ] If yes: `forge-state set audit.enabled true`
- [ ] If already set (true or false): skip the question (don't re-ask)
- [ ] Check uses `forge-state get audit.enabled` before asking

## Test Expectations

Tests: N/A — documentation-only task

## Files

- Modify: `skills/brainstorming/SKILL.md` (Step 1, after context exploration)

## Implementation Notes

Add after the "Explore project context" bullet in Step 1:

```markdown
**Audit opt-in (ask once per project):**

Check first: `forge-state get audit.enabled` — if already set, skip this question.

If not set, ask:
> "Would you like to enable audit mode for this project? Audit records
> workflow events (skill usage, gate checks, token counts) to
> `.forge/local/audit/` for later analysis with `forge:analyze-audit`.
> Default: no"

If yes: `forge-state set audit.enabled true`
If no (or skipped): do nothing — audit stays disabled.
```

This is a sub-step of Step 1, not a new top-level step. Don't renumber anything.

## Commit

`feat: add audit opt-in question to brainstorming skill (default: no)`
