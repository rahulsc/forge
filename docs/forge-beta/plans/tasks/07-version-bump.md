# Task 7: Version Bump and Release

**Specialist:** implementer
**Depends on:** Tasks 1-6 (all other tasks must be complete)
**Produces:** v0.2.0 version in all manifests, release notes, verification that plugin auto-updates correctly

## Goal

Bump version to 0.2.0 in all plugin manifests, write release notes, and verify the plugin auto-update flow works on Claude Code.

## Acceptance Criteria

- [ ] `.claude-plugin/plugin.json` version is `0.2.0`
- [ ] `.cursor-plugin/plugin.json` version is `0.2.0`
- [ ] `gemini-extension.json` version is `0.2.0`
- [ ] `RELEASE-NOTES.md` updated with v0.2.0 section documenting what changed
- [ ] Plugin auto-update works: after push to main, Claude Code picks up new version
- [ ] All v0.2.0 exit criteria from design-v3.md §16.2 verified

## Test Expectations

- **Test:** grep for `"version": "0.2.0"` in plugin manifests
- **Expected red failure:** manifests still show `0.1.1`
- **Expected green:** all manifests show `0.2.0`

## Files

- Modify: `.claude-plugin/plugin.json` (version field)
- Modify: `.cursor-plugin/plugin.json` (version field)
- Modify: `gemini-extension.json` (version field)
- Modify: `RELEASE-NOTES.md` (add v0.2.0 section)

## Implementation Notes

- Release notes should summarize: identity cleanup, project restructure, README rewrite, skill convention fixes
- After version bump and push, verify on a fresh Claude Code session that the plugin loads with v0.2.0
- This task also serves as the v0.2.0 verification gate — run through the design's exit criteria checklist before bumping

## Commit

`chore: bump version to 0.2.0`
