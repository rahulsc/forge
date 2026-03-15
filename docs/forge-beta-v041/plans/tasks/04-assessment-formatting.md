# Task 4: Fix Assessment Output Formatting in setting-up-project

**Specialist:** forge-author
**Depends on:** None
**Produces:** Updated setting-up-project SKILL.md with table-based output format guidance
**Tests:** N/A — documentation-only task

## Goal

The assessment output in Step 1c is a wall of text. Add table format guidance so the output is consistently readable.

## Acceptance Criteria

- [ ] Step 1c assessment template uses markdown tables instead of plain text block
- [ ] Risk assessment uses table: Dimension | Value | Justification
- [ ] Team criteria uses table: Criterion | Threshold | Value | Met?
- [ ] Readiness summary (Step 5) uses table format
- [ ] Both templates shown as examples in the skill text

## Files

- Modify: `skills/setting-up-project/SKILL.md` (Step 1c and Step 5)

## Implementation Notes

Replace the current Step 1c code block with:

```markdown
Present the assessment using tables:

**Risk and Execution Assessment:**

| Dimension | Value | Justification |
|-----------|-------|---------------|
| **Files affected** | <list> | <what areas> |
| **Scope** | <N> tasks | <from design> |
| **Risk tier** | <tier> | <reason> |

**Team criteria:**

| Criterion | Threshold | Value | Met? |
|-----------|-----------|-------|------|
| Task count | ≥4 | <N> | Yes/No |
| Independence | ≥2 parallel | <assessment> | Yes/No |
| Specialist domains | ≥2 | <N> — <list> | Yes/No |

**Execution strategy:** <solo|team> (<justification>)
**Worktree:** <recommendation>
```

Similarly update Step 5 readiness summary to use a table.

## Commit

`fix: add table format guidance for assessment and readiness outputs`
