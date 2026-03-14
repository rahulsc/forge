# Task 5: Update Syncing-Forge and Diagnosing-Forge Skills

**Specialist:** forge-author
**Depends on:** Task 4 (adopting-forge defines the managed block format that sync must regenerate)
**Produces:** Updated syncing-forge and diagnosing-forge skills with managed block awareness and doctor checks
**Complexity:** standard

## Goal

`forge sync` regenerates managed blocks safely. `forge doctor` validates Forge health including marker integrity.

## Acceptance Criteria

**syncing-forge:**
- [ ] SKILL.md documents managed block regeneration: read project.yaml, regenerate content between `<!-- forge:begin/end -->` markers
- [ ] Preserves all content outside markers
- [ ] Warns if markers are missing or corrupted (asks before proceeding)
- [ ] Supports `--re-infer` flag to re-detect stack from repo
- [ ] Reports what changed after regeneration

**diagnosing-forge:**
- [ ] SKILL.md includes all 9 checks from design §4.7
- [ ] Each check has: what it validates, fix suggestion
- [ ] Marker validation check: open/close tags match, well-formed
- [ ] Reports pass/fail for each check with actionable fix suggestions

## Test Expectations

- **Test:** grep for "forge:begin" in syncing-forge SKILL.md
- **Expected red failure:** no managed block reference
- **Expected green:** managed block regeneration documented

- **Test:** grep for "marker" or "well-formed" in diagnosing-forge SKILL.md
- **Expected red failure:** no marker validation
- **Expected green:** marker check documented

## Files

- Modify: `skills/syncing-forge/SKILL.md`
- Modify: `skills/diagnosing-forge/SKILL.md`

## Implementation Notes

**syncing-forge** already has some managed section logic (it references `<!-- forge:start/end -->` markers at line ~90). Update to use the consistent `<!-- forge:begin/end -->` format from the adopting-forge rewrite. Add:
- Read `.forge/project.yaml` for current values
- Regenerate the CLAUDE.md managed block with current values
- Regenerate the AGENTS.md managed block listing all agents in `agents/`
- `--re-infer` mode: re-scan the repo for stack/commands before regenerating
- Report diff: "Updated CLAUDE.md: changed test command from 'jest' to 'vitest'"

**diagnosing-forge** needs the checks table from design §4.7:
1. `.forge/project.yaml` exists → fix: run `forge adopt`
2. project.yaml has non-empty fields → fix: run `forge sync --re-infer`
3. CLAUDE.md has forge markers → fix: run `forge sync`
4. Markers well-formed (open/close match) → fix: manual fix or `forge sync --force`
5. `bin/forge-state` accessible → fix: check installation
6. `.forge/local/` exists → fix: `bin/forge-state init`
7. Hooks registered → fix: check `hooks/hooks.json`
8. Policy file exists → fix: run `forge adopt`
9. Agent definitions exist → fix: check `agents/` directory

## Commit

`feat: update syncing-forge and diagnosing-forge with managed block support and doctor checks`
