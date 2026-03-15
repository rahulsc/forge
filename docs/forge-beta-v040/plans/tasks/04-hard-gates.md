# Task 4: Add HARD-GATEs to Verification/Finishing/Composing Skills

**Specialist:** forge-author
**Depends on:** None
**Produces:** Updated skills with enforcement gates where skipping causes damage

## Goal

The audit found 36% of deviations caused by missing enforcement. Add HARD-GATEs to skills that have critical steps without enforcement.

## Acceptance Criteria

- [ ] `verification-before-completion` has HARD-GATE: "Do NOT claim completion without evidence"
- [ ] `finishing-a-development-branch` has HARD-GATE: "Do NOT merge without verification passing"
- [ ] `composing-teams` has HARD-GATE: "Do NOT finalize roster without user approval"
- [ ] Each HARD-GATE is justified — only added where skipping causes real damage
- [ ] Existing HARD-GATEs in other skills reviewed and confirmed appropriate

## Test Expectations

Tests: N/A — documentation-only task (skill prompt edits)

## Files

- Modify: `skills/verification-before-completion/SKILL.md`
- Modify: `skills/finishing-a-development-branch/SKILL.md`
- Modify: `skills/composing-teams/SKILL.md`

## Implementation Notes

Read each skill first. Identify the critical step that must not be skipped. Add a `<HARD-GATE>` tag wrapping the enforcement instruction.

**verification-before-completion:** The skill should enforce that evidence (command output + diff) exists before allowing any completion claim. If evidence is missing, block.

**finishing-a-development-branch:** The skill should enforce that verification-before-completion has passed before allowing merge/PR. If verification hasn't run, block.

**composing-teams:** The skill should enforce that the user explicitly approves the proposed roster before it's written to state. If user hasn't confirmed, block.

Don't over-gate. The forge-author quality principle: "Use HARD-GATEs sparingly — only for steps where skipping causes real damage."

## Commit

`fix: add HARD-GATEs to verification, finishing, and composing-teams skills`
