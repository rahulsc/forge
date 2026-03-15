# Task 3: Add Audit Prompt + Stale Task Cleanup to finishing-a-development-branch

**Specialist:** forge-author
**Depends on:** None
**Produces:** Updated finishing SKILL.md with end-of-workflow audit prompt and task cleanup
**Tests:** N/A — documentation-only task

## Goal

When audit was enabled, show how to analyze the data at the end of the workflow. Also add stale task cleanup as part of closeout.

## Acceptance Criteria

- [ ] "Audit Summary" section added at end of skill (after merge/PR decision)
- [ ] Checks `forge-state get audit.enabled` — only shows prompt if audit was on
- [ ] Tells user to run `forge:analyze-audit`
- [ ] Mentions data location (`.forge/local/audit/`)
- [ ] Stale task cleanup step: check TaskList, delete any remaining in_progress tasks before finishing

## Files

- Modify: `skills/finishing-a-development-branch/SKILL.md`

## Implementation Notes

Add at the end of the skill, after the merge/PR/cleanup decision:

```markdown
## Closeout Cleanup

Before finishing:
1. Check TaskList for any remaining in_progress tasks
2. Delete stale tasks via TaskUpdate with status=deleted
3. Verify TaskList is clean

## Audit Summary (if enabled)

Check: `forge-state get audit.enabled`

If true:
> "Audit data was recorded for this project at `.forge/local/audit/`.
>
> To analyze your workflow data, run: `forge:analyze-audit`
>
> This produces a report showing skill coverage, token costs,
> deviation patterns, and improvement recommendations."
```

## Commit

`feat: add audit prompt and stale task cleanup to finishing-a-development-branch`
