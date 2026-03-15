# Task 9: Version Bump to 0.4.0

**Specialist:** Lead
**Depends on:** Tasks 1-8
**Produces:** v0.4.0 in all manifests, release notes

## Goal

Bump to 0.4.0, write release notes covering audit infrastructure, TDD milestone, and fixes.

## Acceptance Criteria

- [ ] `.claude-plugin/plugin.json` version is `0.4.0`
- [ ] `.cursor-plugin/plugin.json` version is `0.4.0`
- [ ] `gemini-extension.json` version is `0.4.0`
- [ ] `RELEASE-NOTES.md` has v0.4.0 section
- [ ] `.forge/shared/architecture.md` updated to mention bin/forge-audit and audit infrastructure

## Test Expectations

- **Test:** grep for `"version": "0.4.0"` in manifests
- **Expected red failure:** manifests show 0.3.1
- **Expected green:** all show 0.4.0

## Files

- Modify: `.claude-plugin/plugin.json`
- Modify: `.cursor-plugin/plugin.json`
- Modify: `gemini-extension.json`
- Modify: `RELEASE-NOTES.md`
- Modify: `.forge/shared/architecture.md`

## Implementation Notes

Release notes should highlight:
- First TDD exercise in Beta (tests written before implementation)
- bin/forge-audit tool for JSONL event recording
- Hook integration for automatic event capture
- Brainstorming audit opt-in (default: no)
- HARD-GATEs added to verification, finishing, composing-teams
- Wave compliance fix
- analyze-audit JSONL + cost analysis upgrade
- Deviation #3 closed (all deviations now resolved)

## Commit

`chore: bump version to 0.4.0`
