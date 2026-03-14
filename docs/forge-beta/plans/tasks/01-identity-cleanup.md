# Task 1: Identity Cleanup

**Specialist:** implementer
**Depends on:** None
**Produces:** Clean repo with zero stale superpowers references in user-facing files

## Goal

Fix all 15 stale references to `rahulsc/superpowers` in user-facing files and update completed plan statuses.

## Acceptance Criteria

- [ ] Zero matches for `rahulsc/superpowers` in non-attribution files (plugin manifests, README, install docs, tests, HTML)
- [ ] Attribution files preserved unchanged (NOTICE.md, ORIGINS.md, LICENSE, RELEASE-NOTES.md)
- [ ] Historical planning docs preserved unchanged (docs/plans/forge-v0/, docs/plans/forge-clean-break/)
- [ ] docs/plans/forge-v0/plan.md status updated to `completed`
- [ ] docs/plans/forge-clean-break/plan.md status updated to `completed`
- [ ] Plugin manifests homepage/repository point to `rahulsc/forge`

## Test Expectations

- **Test:** grep for `rahulsc/superpowers` in non-attribution files returns zero matches
- **Expected red failure:** grep finds 15+ matches across plugin manifests, README, install docs, tests
- **Expected green:** grep returns empty (exit code 1) after excluding NOTICE.md, ORIGINS.md, LICENSE, RELEASE-NOTES.md, docs/forge_ideation_v1.md, docs/plans/forge-v0/, docs/plans/forge-clean-break/

## Files

- Modify: `.claude-plugin/plugin.json` (lines 8-9: homepage, repository)
- Modify: `.cursor-plugin/plugin.json` (lines 9-10: homepage, repository)
- Modify: `README.md` (lines 95, 105, 113, 224, 251)
- Modify: `.codex/INSTALL.md` (lines 13, 125-126)
- Modify: `.opencode/INSTALL.md` (lines 13, 118-119)
- Modify: `docs/README.codex.md` (lines 10, 24, 125-126)
- Modify: `docs/README.opencode.md` (lines 10, 27, 69)
- Modify: `skills/brainstorming/scripts/frame-template.html` (line 199)
- Modify: `.github/workflows/test.yml.disabled` (lines 1, 55: rename "Superpowers Tests" → "Forge Tests", fix path)
- Modify: `tests/integration/no-superpowers-references.sh` (line 15: fix hardcoded WORKTREE path)
- Modify: `tests/explicit-skill-requests/prompts/use-superpowers-direct.txt` (line 1: update skill reference)
- Modify: `docs/plans/forge-v0/plan.md` (status field)
- Modify: `docs/plans/forge-clean-break/plan.md` (status field)
- Test: `tests/integration/no-superpowers-references.sh` (should pass after fixes)

## Implementation Notes

- The canonical repo URL is `https://github.com/rahulsc/forge`
- Replace `rahulsc/superpowers` → `rahulsc/forge` in URLs
- Replace `superpowers.git` → `forge.git` in clone commands
- The `no-superpowers-references.sh` test has a hardcoded WORKTREE path to a non-existent directory — fix the path to point to the current repo
- `use-superpowers-direct.txt` references the old `using-superpowers` skill — update to reference `forge-routing` or remove if obsolete
- Do NOT touch: NOTICE.md, ORIGINS.md, LICENSE, RELEASE-NOTES.md, docs/forge_ideation_v1.md, any file in docs/plans/forge-v0/ or docs/plans/forge-clean-break/ (except status fields)

## Commit

`fix: replace all stale superpowers references with canonical Forge URLs`
