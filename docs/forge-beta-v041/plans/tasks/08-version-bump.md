# Task 8: Deviation Log + Version Bump to 0.4.1

**Specialist:** Lead
**Depends on:** Tasks 1-7
**Produces:** Updated deviation log, v0.4.1 in manifests, release notes

## Goal

Update deviation log with entries #12-14, bump version, write release notes.

## Acceptance Criteria

- [ ] Deviation #12 marked as fixed (agent shutdown)
- [ ] Deviation #13 status updated (stale task cleanup added to brainstorming + finishing)
- [ ] Deviation #14 logged (formatting audit for v0.5.0)
- [ ] `.claude-plugin/plugin.json` version is `0.4.1`
- [ ] `.cursor-plugin/plugin.json` version is `0.4.1`
- [ ] `gemini-extension.json` version is `0.4.1`
- [ ] `RELEASE-NOTES.md` has v0.4.1 section
- [ ] `.forge/shared/architecture.md` updated if needed

## Test Expectations

- **Test:** grep for `"version": "0.4.1"` in manifests
- **Expected red failure:** manifests show 0.4.0
- **Expected green:** all show 0.4.1

## Files

- Modify: `docs/forge-beta-v040/design/design.md` (deviation statuses)
- Modify: `.claude-plugin/plugin.json`
- Modify: `.cursor-plugin/plugin.json`
- Modify: `gemini-extension.json`
- Modify: `RELEASE-NOTES.md`

## Commit

`chore: bump version to 0.4.1`
