# Task 4: Rewrite Adopting-Forge Skill

**Specialist:** forge-author
**Depends on:** Task 2 (new agents must exist for AGENTS.md generation template)
**Produces:** Updated `skills/adopting-forge/SKILL.md` with LLM warning, sensitive file detection, stack inference, and managed-block CLAUDE.md/AGENTS.md generation
**Complexity:** complex

## Goal

Make `forge adopt` a complete adoption flow: warn about LLM exposure, detect sensitive files, infer stack, generate safe CLAUDE.md/AGENTS.md with managed blocks, and preview everything before creation.

## Acceptance Criteria

- [ ] SKILL.md starts with LLM exposure warning (displayed before scanning)
- [ ] Sensitive file detection patterns listed (`.env`, `credentials.*`, `*.pem`, etc.)
- [ ] Stack inference table (package manager, test runner, linter, CI, language, critical paths)
- [ ] CLAUDE.md generation uses `<!-- forge:begin/end -->` managed block markers
- [ ] AGENTS.md generation uses same managed block pattern
- [ ] Existing CLAUDE.md content is preserved (append block if no markers, replace between markers if they exist)
- [ ] Generated block template includes: project name, stack, commands, risk policy, workflow reference
- [ ] AGENTS.md template lists all 9 agents (5 existing + 4 new)
- [ ] Preview step shows all generated files before creation
- [ ] `references/generated-claude-md-template.md` updated with managed block format

## Test Expectations

- **Test:** grep for "forge:begin" in adopting-forge SKILL.md
- **Expected red failure:** no managed block markers in skill
- **Expected green:** `<!-- forge:begin` pattern found

- **Test:** grep for "LLM" or "exposure" warning in adopting-forge SKILL.md
- **Expected red failure:** no warning text
- **Expected green:** warning section found

- **Test:** grep for ".env" in sensitive file detection section
- **Expected red failure:** no sensitive file patterns
- **Expected green:** `.env` pattern in detection table

## Files

- Modify: `skills/adopting-forge/SKILL.md` (major rewrite of adoption steps)
- Modify: `skills/adopting-forge/references/generated-claude-md-template.md` (update to managed block format)

## Implementation Notes

Read the current `skills/adopting-forge/SKILL.md` first — it has a 6-step process. Enhance the existing steps rather than replacing the entire structure:

1. **Add LLM warning as step 0** (before the current step 1). Use the exact warning text from design §4.1. Must require user acknowledgment.

2. **Add sensitive file detection to step 1** (repo inspection). Add the patterns from design §4.2. Flag but don't block — list excluded files to user.

3. **Enhance stack inference in step 1** with the detection methods from design §4.3 (package manager → package.json/pyproject.toml/Cargo.toml/go.mod, test runner, linter, CI surface, critical paths).

4. **Replace CLAUDE.md generation with managed block approach** from design §4.4:
   - If CLAUDE.md exists with markers → replace between markers
   - If CLAUDE.md exists without markers → append block
   - If CLAUDE.md doesn't exist → create with block
   - Never modify content outside markers

5. **Add AGENTS.md generation** with the same pattern, using the template from design §4.5. List all 9 agents.

6. **Update `references/generated-claude-md-template.md`** to use the managed block format with `forge:begin/end` markers. This template is referenced by the SKILL.md.

The current skill has references to `.forge/bin/` which were already updated to `bin/` in v0.2.0. Verify these are correct.

## Commit

`feat: rewrite adopting-forge with LLM warning, sensitive file detection, managed-block generation`
