# Task 2: Skill Convention Audit

**Specialist:** implementer (skill authoring)
**Depends on:** None
**Produces:** All 21 skills use consistent path conventions, artifact naming, and cross-skill references

## Goal

Audit all 21 skills for convention mismatches and fix them. The known bug is the brainstorming skill's design doc path; there may be others.

## Acceptance Criteria

- [ ] Brainstorming SKILL.md uses `docs/<project>/design/design.md` path (not `docs/plans/<project>/design.md`)
- [ ] All skills that reference design doc paths use the correct convention
- [ ] All skills that reference plan paths use `docs/<project>/plans/plan.md`
- [ ] Cross-skill references use correct skill names (no stale `superpowers:` namespace)
- [ ] No skill references non-existent skills or tools
- [ ] Audit results documented (which skills were checked, what was found, what was fixed)

## Test Expectations

- **Test:** grep for `docs/plans/<project>/design.md` pattern in skill files returns zero matches
- **Expected red failure:** brainstorming/SKILL.md contains `docs/plans/<project>/design.md`
- **Expected green:** all skill files use `docs/<project>/design/design.md` for design references

- **Test:** grep for `superpowers:` namespace in skill files returns zero matches (outside historical references)
- **Expected red failure:** some skills may still use `superpowers:` prefix
- **Expected green:** all skills use `forge:` prefix

## Files

- Modify: `skills/brainstorming/SKILL.md` (fix design doc path references)
- Modify: Any other skill SKILL.md files with convention mismatches (discovered during audit)
- Create: Audit notes in commit message (what was checked, what was found)

## Implementation Notes

- Read each of the 21 skills in `skills/*/SKILL.md`
- Check for:
  1. Design doc path references (should be `docs/<project>/design/`)
  2. Plan path references (should be `docs/<project>/plans/`)
  3. Cross-skill references (should use `forge:` namespace, not `superpowers:`)
  4. References to `.forge/bin/` tools (will be updated in Task 3, but note them)
  5. References to non-existent skills or agent definitions
- Fix issues found in each skill
- Do NOT fix `.forge/bin/` path references — Task 3 handles that
- The 21 skills: adopting-forge, brainstorming, composing-teams, diagnosing-forge, finishing-a-development-branch, forge-packs, forge-routing, forge-viz, receiving-code-review, requesting-code-review, setting-up-project, subagent-driven-development, agent-team-driven-development, syncing-forge, systematic-debugging, test-driven-development, using-git-worktrees, validating-wave-compliance, verification-before-completion, writing-plans, writing-skills

## Commit

`fix: audit and fix skill convention mismatches across all 21 skills`
