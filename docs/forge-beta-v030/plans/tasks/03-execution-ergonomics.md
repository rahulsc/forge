# Task 3: Update Execution Ergonomics

**Specialist:** forge-author
**Depends on:** Task 1 (forge-author must exist)
**Produces:** Updated setting-up-project and agent-team-driven-development skills with lighter ceremony for low-risk work
**Complexity:** standard

## Goal

Make execution lighter when risk is low: optional worktrees for minimal-risk, review tiers based on task complexity.

## Acceptance Criteria

- [ ] `setting-up-project/SKILL.md` worktree table updated: minimal = "Not created", standard = "Optional (default no)", elevated = "Recommended (default yes)", critical = "Required"
- [ ] `agent-team-driven-development/SKILL.md` contains a review tier table with mechanical/standard/complex categories
- [ ] Plan task spec template mentions `complexity` field
- [ ] Mechanical tasks skip subagent review — single verification check only

## Test Expectations

- **Test:** grep for "Not created" in setting-up-project worktree table
- **Expected red failure:** table shows "Optional" for minimal tier
- **Expected green:** table shows "Not created" for minimal

- **Test:** grep for "mechanical" in agent-team-driven-development review section
- **Expected red failure:** no review tier concept exists
- **Expected green:** review tier table with mechanical/standard/complex

## Files

- Modify: `skills/setting-up-project/SKILL.md` (worktree requirement table, ~lines 95-105)
- Modify: `skills/agent-team-driven-development/SKILL.md` (add review tier section near the review ceremony section)

## Implementation Notes

**Worktree tier update** (setting-up-project):
Change the existing table from:
```
| minimal | Optional |
| standard | Recommended |
| elevated | Required |
| critical | Required |
```
To:
```
| minimal | Not created (work directly on branch) |
| standard | Optional (offer, default to no) |
| elevated | Recommended (offer, default to yes) |
| critical | Required |
```

**Review tier** (agent-team-driven-development):
Add a new subsection near the risk-tier-aware review ceremony:
```
| Task complexity | Review approach |
|----------------|----------------|
| Mechanical (find-replace, config, scaffolding) | Single verification check (e.g., grep passes) — no subagent review |
| Standard (implementation with tests) | Two-stage review (spec + quality) |
| Complex (architecture, cross-cutting) | Two-stage review + lead review |
```

Note: the `complexity` field should be included in the task spec template in the plan. The lead uses this to decide review depth.

## Commit

`fix: add execution ergonomics — optional worktrees, review tiers`
