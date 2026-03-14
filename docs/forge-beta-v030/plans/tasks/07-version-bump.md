# Task 7: Architecture Update + Version Bump

**Specialist:** Lead
**Depends on:** Tasks 2-6 (all feature work must be complete)
**Produces:** Updated architecture.md, v0.3.0 in all manifests, release notes
**Complexity:** mechanical

## Goal

Update Forge's self-documentation to reflect new agents and adoption flow, bump version to 0.3.0, and write release notes.

## Acceptance Criteria

- [ ] `.forge/shared/architecture.md` module map lists all 10 agents (5 existing + forge-author + 4 new specialists)
- [ ] `.forge/shared/architecture.md` mentions managed block generation in key patterns
- [ ] `.claude-plugin/plugin.json` version is `0.3.0`
- [ ] `.cursor-plugin/plugin.json` version is `0.3.0`
- [ ] `gemini-extension.json` version is `0.3.0`
- [ ] `RELEASE-NOTES.md` has v0.3.0 section covering: new agents, adoption flow, ergonomics, routing

## Test Expectations

- **Test:** grep for `"version": "0.3.0"` in plugin manifests
- **Expected red failure:** manifests show `0.2.1`
- **Expected green:** all manifests show `0.3.0`

- **Test:** grep for "frontend-engineer" in architecture.md
- **Expected red failure:** not listed in module map
- **Expected green:** listed with other agents

## Files

- Modify: `.forge/shared/architecture.md` (module map, key patterns)
- Modify: `.claude-plugin/plugin.json` (version)
- Modify: `.cursor-plugin/plugin.json` (version)
- Modify: `gemini-extension.json` (version)
- Modify: `RELEASE-NOTES.md` (add v0.3.0 section)

## Implementation Notes

Release notes should cover:
- forge-author agent created (with R&D-informed authoring principles)
- 4 new specialist agents (frontend-engineer, backend-engineer, database-specialist, devops-engineer)
- Execution ergonomics (optional worktrees for minimal-risk, review tiers)
- Adoption flow rewrite (LLM warning, sensitive file detection, stack inference, managed blocks)
- forge sync and forge doctor updates
- Routing improvements (resume, release, ambiguous intent)

## Commit

`chore: bump version to 0.3.0`
