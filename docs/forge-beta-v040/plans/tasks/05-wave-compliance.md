# Task 5: Fix Wave Compliance Invocation

**Specialist:** forge-author
**Depends on:** None
**Produces:** Clear, enforceable wave compliance invocation in agent-team-driven-development

## Goal

`validating-wave-compliance` was never invoked during elevated-tier team execution. Investigate why and fix.

## Acceptance Criteria

- [ ] Investigation documented: why was the skill not invoked?
- [ ] `agent-team-driven-development` between-waves section has clear, unambiguous instruction to invoke `forge:validating-wave-compliance` at elevated+ tiers
- [ ] The invocation is not buried in a sub-bullet — it's a numbered step
- [ ] The instruction includes what to do if validation fails (block next wave at critical, advisory at elevated)

## Test Expectations

Tests: N/A — documentation-only task

## Files

- Modify: `skills/agent-team-driven-development/SKILL.md` (between-waves section)

## Implementation Notes

Read the current between-waves section. The wave validation step (3.5) exists but may be:
1. Numbered oddly (3.5 instead of a full step)
2. Buried in a sub-note
3. Conditional text that's easy to skip

Fix: make it a full numbered step with clear instruction:
```
4. **Wave validation (elevated/critical tiers):**
   Invoke `forge:validating-wave-compliance`. Provide the completed wave's
   task list and the design doc path. At elevated tier, failures are advisory
   (note and proceed). At critical tier, failures BLOCK the next wave.
```

## Commit

`fix: make wave compliance invocation a clear numbered step`
