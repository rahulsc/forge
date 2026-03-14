# Task 2: Full Identity Rename + URL Rewrite

**Depends on:** Task 1 (attribution files must exist before URLs reference them)
**Produces:** All obra/superpowers URLs replaced; all "superpowers" renamed to "forge" across hooks, commands, manifests, adapters, tests

## Goal

Complete the superpowers → forge rename across every remaining file and rewrite all obra/superpowers URLs to rahulsc/superpowers.

## Acceptance Criteria

- [ ] Zero `obra/superpowers` URLs in any actionable file
- [ ] Zero `superpowers` references outside of: NOTICE.md, ORIGINS.md, LICENSE, RELEASE-NOTES.md, docs/research/, docs/forge_*.md, docs/plans/, .superpowers/state.yml
- [ ] All 4 plugin manifests: name=forge, version=0.1.0, author=Rahul Singh Chauhan, URLs=rahulsc/superpowers
- [ ] `.opencode/plugins/superpowers.js` renamed to `.opencode/plugins/forge.js` with updated internals
- [ ] `hooks/session-start` references forge-routing, not using-superpowers
- [ ] All 3 commands reference `forge:` skill names
- [ ] `GEMINI.md` points to `forge-routing/SKILL.md`
- [ ] All test files updated from superpowers to forge references

## Test Expectations

- **Test:** No superpowers in actionable files
- **Verification:** `grep -rl "superpowers" . --include="*.json" --include="*.js" --include="*.html" --include="*.sh" --include="*.cmd" --include="*.yaml" --include="*.yml" --include="*.txt" | grep -v ".git/" | grep -v ".superpowers/" | grep -v "docs/research" | grep -v "docs/forge_" | grep -v "docs/plans" | grep -v NOTICE | grep -v ORIGINS | grep -v LICENSE | grep -v RELEASE-NOTES` returns empty
- **Test:** Plugin manifests consistent
- **Verification:** `grep -r '"name"' .claude-plugin/plugin.json .cursor-plugin/plugin.json gemini-extension.json` all show "forge"
- **Test:** No Jesse Vincent in manifests
- **Verification:** `grep -r "Jesse Vincent" --include="*.json" .` returns zero

## Files

### Plugin manifests (4 files)

- `.claude-plugin/plugin.json` — name→forge, version→0.1.0, author→Rahul Singh Chauhan (remove email), URLs→rahulsc/superpowers
- `.claude-plugin/marketplace.json` — name→forge-dev, owner→Rahul Singh Chauhan (remove email), plugin name→forge, version→0.1.0, author→Rahul Singh Chauhan
- `.cursor-plugin/plugin.json` — name→forge, displayName→Forge, version→0.1.0, author→Rahul Singh Chauhan (remove email), URLs→rahulsc/superpowers
- `gemini-extension.json` — name→forge, version→0.1.0

### URL rewrites in docs (5 files)

- `README.md` — all obra/superpowers URLs → rahulsc/superpowers; remove sponsorship section
- `.opencode/INSTALL.md` — clone URLs + help links
- `.codex/INSTALL.md` — clone URL
- `docs/README.opencode.md` — all clone URLs + help links (~8 URLs)
- `docs/README.codex.md` — clone URLs + help links (~4 URLs)

### Platform adapter rename (1 file)

- `.opencode/plugins/superpowers.js` → `.opencode/plugins/forge.js`
  - Rename file (git mv)
  - Update internal code: load `forge-routing` instead of `using-superpowers`
  - Update variable names, comments, paths from superpowers to forge
  - Update symlink path references

### Hooks (2 files)

- `hooks/session-start`:
  - `using-superpowers` → `forge-routing` (skill path reference)
  - `superpowers:using-superpowers` → `forge:forge-routing` (injection text)
  - `"You have superpowers"` → `"You have Forge"` or equivalent
  - `~/.config/superpowers/skills` → `~/.config/forge/skills` (legacy path)
  - `superpowers` → `forge` in variable names and comments
- `hooks/run-tests` — update comment

### Commands (3 files)

- `commands/brainstorm.md` — `superpowers:brainstorming` → `forge:brainstorming`, "superpowers brainstorming" → "forge brainstorming"
- `commands/write-plan.md` — `superpowers:writing-plans` → `forge:writing-plans`, "superpowers writing-plans" → "forge writing-plans"
- `commands/execute-plan.md` — `superpowers:executing-plans` → `forge:subagent-driven-development`, update deprecation text

### Other single-file updates

- `GEMINI.md` — `using-superpowers/SKILL.md` → `forge-routing/SKILL.md`
- `skills/brainstorming/scripts/frame-template.html` — URL → rahulsc/superpowers, text → "Forge Brainstorming"
- `docs/testing.md` — update any superpowers references to forge

### Install doc path renames

In all install docs (`.opencode/INSTALL.md`, `.codex/INSTALL.md`, `docs/README.opencode.md`, `docs/README.codex.md`):
- Symlink paths referencing `superpowers` directories → `forge`
- Clone destination paths: `~/.config/opencode/superpowers` → `~/.config/opencode/forge`, `~/.codex/superpowers` → `~/.codex/forge`
- Skills symlink source: `superpowers/skills` → `forge/skills`
- Plugin file references: `superpowers.js` → `forge.js`

### Test files (~30 files)

All files listed below — replace `superpowers` with `forge` in plugin dir references, skill name patterns, assertion strings, and comments:

- `tests/claude-code/README.md`
- `tests/claude-code/test-subagent-driven-development-integration.sh`
- `tests/explicit-skill-requests/run-all.sh`
- `tests/explicit-skill-requests/run-claude-describes-sdd.sh`
- `tests/explicit-skill-requests/run-extended-multiturn-test.sh`
- `tests/explicit-skill-requests/run-haiku-test.sh`
- `tests/explicit-skill-requests/run-multiturn-test.sh`
- `tests/explicit-skill-requests/run-test.sh`
- `tests/explicit-skill-requests/prompts/use-superpowers-direct.txt`
- `tests/forge-skills/test-adopting-forge.sh` (and all 16 test-*.sh in this dir)
- `tests/integration/no-superpowers-references.sh`
- `tests/opencode/setup.sh`
- `tests/opencode/test-plugin-loading.sh`
- `tests/opencode/test-priority.sh`
- `tests/opencode/test-tools.sh`
- `tests/pressure-tests/test-helpers-pressure.sh`
- `tests/pressure-tests/tdd/test-t1-sunk-cost-short.sh` (and all test-t*.sh)
- `tests/pressure-tests/using-superpowers/test-s1-mid-task.sh` (and all test-s*.sh)
- `tests/pressure-tests/executing-plans/test-e1-stale-path.sh` (and all test-e*.sh)
- `tests/pressure-tests/writing-plans/test-p1-skip-plan.sh` (and all test-p*.sh)
- `tests/skill-triggering/run-test.sh`
- `tests/subagent-driven-dev/run-test.sh`
- `tests/subagent-driven-dev/go-fractals/plan.md`
- `tests/subagent-driven-dev/go-fractals/scaffold.sh`
- `tests/subagent-driven-dev/svelte-todo/plan.md`
- `tests/subagent-driven-dev/svelte-todo/scaffold.sh`
- `tests/workflow-chains/chain-a-team-lifecycle/run-chain.sh`
- `tests/workflow-chains/chain-b-solo-lifecycle/run-chain.sh`
- `tests/workflow-chains/chain-c-cold-resume/run-chain.sh`

### Test directory renames

- `tests/pressure-tests/using-superpowers/` — consider renaming to `tests/pressure-tests/using-forge/` or leaving as-is since these test the absence of the old skill (intent is to test "what happens when someone asks for the old superpowers skill"). If renaming, update `tests/pressure-tests/` runner scripts too.

### Intentionally unchanged

- `NOTICE.md`, `ORIGINS.md`, `LICENSE` — attribution files reference upstream by name
- `RELEASE-NOTES.md` — being replaced in Task 4
- `docs/research/*` — being deleted in Task 3
- `docs/forge_competitive_research.md`, `docs/forge_ideation_v1.md` — analytical context
- `docs/plans/*` — planning context
- `.superpowers/state.yml` — session state file, not pushed

## Implementation Notes

**This is the largest task.** The implementer should:
1. Start with the file rename (`git mv .opencode/plugins/superpowers.js .opencode/plugins/forge.js`)
2. Then do bulk text replacements across all files
3. Then handle the nuanced changes (hooks/session-start bootstrap rewrite, command deprecation updates)
4. Verify with the grep-based acceptance check before committing

**For the hooks/session-start bootstrap:** This is the most critical change. The current code reads `using-superpowers/SKILL.md` and injects it as the system prompt bootstrap. It must be rewritten to read `forge-routing/SKILL.md` instead. The injection text wrapper also changes from "superpowers" branding to "Forge" branding.

**For test files:** Many tests use `--plugin-dir` pointing to a superpowers plugin directory. These path references need updating. Some tests also grep for "superpowers" in output assertions — these need to match the new "forge" naming.

**For `tests/integration/no-superpowers-references.sh`:** This test explicitly checks that no superpowers references remain. After our rename, this test should pass more cleanly. Review and update its assertions to match the new expected state.

## Commit

`chore: complete superpowers→forge rename, rewrite obra URLs to rahulsc/superpowers, update all manifests to v0.1.0`
