# Task 2: Enhance Audit Description + Stale Task Cleanup in Brainstorming

**Specialist:** forge-author
**Depends on:** None
**Produces:** Updated brainstorming SKILL.md with better audit opt-in text and stale task check
**Tests:** N/A — documentation-only task

## Goal

Improve the audit opt-in question with clear explanation of what it does and what it's used for. Add stale task cleanup check at session start.

## Acceptance Criteria

- [ ] Audit opt-in includes "What it does" and "What it's used for" descriptions
- [ ] Mentions data stays local, never sent anywhere
- [ ] Mentions `forge:analyze-audit` as the analysis tool
- [ ] Before Step 1, add a stale task check: run TaskList, if stale in_progress tasks exist, ask user if safe to clean up (delete)

## Files

- Modify: `skills/brainstorming/SKILL.md`

## Implementation Notes

Replace the current audit opt-in text with the enhanced version from design §2.2.

For stale task cleanup, add before Step 1:
```markdown
**Stale task cleanup:**
Check TaskList for any in_progress tasks from previous sessions. If found, present them and ask:
> "Found N stale tasks from a previous session. Safe to clean these up? (y/n)"
If yes, delete them via TaskUpdate with status=deleted.
```

## Commit

`fix: enhance audit description and add stale task cleanup to brainstorming`
