# Task 8: Close Deviation #3 + README Update

**Specialist:** Lead
**Depends on:** None
**Produces:** Updated README, deviation #3 closed

## Goal

Close the last open deviation and update README to reflect current state.

## Acceptance Criteria

- [ ] Deviation #3 marked as `closed` in design-v3.md Appendix G (worktree cosmetic — addressed by execution ergonomics in v0.3.0)
- [ ] README skill count accurate (22 skills including analyze-audit)
- [ ] README reflects any other content drift from v0.3.0/v0.3.1 changes
- [ ] No stale information in README

## Test Expectations

Tests: N/A — documentation-only task

## Files

- Modify: `docs/forge-beta/design/design-v3.md` (deviation #3 status)
- Modify: `README.md` (skill count, any drift)

## Implementation Notes

Deviation #3 (worktree for dogfooding) was already addressed by v0.3.0 execution ergonomics — worktrees are now optional for minimal/standard tier. The deviation is cosmetic and the behavior is correct. Mark as `closed (v0.3.0 — execution ergonomics made worktrees optional)`.

For README: scan for "21 skills" or similar counts and update. The current skill set is 22 (21 original + analyze-audit).

## Commit

`docs: close deviation #3, update README skill count`
