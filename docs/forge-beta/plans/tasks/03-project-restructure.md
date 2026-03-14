# Task 3: Project Structure Restructure

**Specialist:** implementer
**Depends on:** Task 1 (identity cleanup), Task 2 (skill convention audit)
**Produces:** Product artifacts at top level; `.forge/` contains only project config; all references updated; ADR documenting the decision

## Goal

Move product infrastructure from `.forge/` to top-level directories, matching the existing pattern of `agents/`, `skills/`, `hooks/`. Update all internal references. Create templates directory for user project scaffolding.

## Acceptance Criteria

- [ ] `bin/` exists at top level with all tools from `.forge/bin/` (classify-risk, forge-state, forge-evidence, forge-memory, forge-pack, backend-sqlite.sh, backend-json.sh)
- [ ] `policies/` exists at top level with default.yaml from `.forge/policies/`
- [ ] `adapters/` exists at top level with contents from `.forge/adapters/`
- [ ] `workflows/` exists at top level with contents from `.forge/workflows/`
- [ ] `packs/` exists at top level with contents from `.forge/packs/`
- [ ] `templates/` exists with architecture.md, conventions.md, decisions/ templates (copies of the blank templates, not Forge's filled-in versions)
- [ ] `.forge/bin/`, `.forge/policies/`, `.forge/adapters/`, `.forge/workflows/`, `.forge/packs/` no longer exist
- [ ] `.forge/` contains only: `project.yaml`, `shared/` (Forge's own docs), `local/` (gitignored)
- [ ] All skills referencing `.forge/bin/` updated to reference `bin/`
- [ ] All skills referencing `.forge/policies/` updated to reference `policies/`
- [ ] All hooks referencing `.forge/bin/` or `.forge/policies/` updated
- [ ] All bin tools that reference `.forge/` paths internally updated
- [ ] All test scripts updated for new paths
- [ ] `forge-pack` tool updated to install packs to `packs/` not `.forge/packs/`
- [ ] `adopting-forge` skill updated to create `.forge/` in user repos using templates from `templates/` and defaults from `policies/`
- [ ] ADR written at `.forge/shared/decisions/001-product-artifacts-top-level.md`
- [ ] `.forge/shared/architecture.md` updated to reflect new structure
- [ ] Existing test suite passes with new paths
- [ ] Plugin manifests still work (skills, agents, hooks paths unchanged)

## Test Expectations

- **Test:** `bin/forge-state --help` (or equivalent) executes successfully from top-level
- **Expected red failure:** `bin/forge-state` doesn't exist (still at `.forge/bin/forge-state`)
- **Expected green:** tool runs and shows usage

- **Test:** `ls bin/ policies/ adapters/ workflows/ packs/ templates/` all succeed
- **Expected red failure:** directories don't exist yet
- **Expected green:** all directories present with expected contents

- **Test:** `test ! -d .forge/bin && test ! -d .forge/adapters` (old dirs removed)
- **Expected red failure:** old directories still exist
- **Expected green:** directories are gone

- **Test:** run `tests/forge-state/test-get-set.sh` with new paths
- **Expected red failure:** test references `.forge/bin/forge-state` which no longer exists
- **Expected green:** test passes using `bin/forge-state`

## Files

**Move operations:**
- Move: `.forge/bin/*` → `bin/`
- Move: `.forge/policies/*` → `policies/`
- Move: `.forge/adapters/*` → `adapters/`
- Move: `.forge/workflows/*` → `workflows/`
- Move: `.forge/packs/*` → `packs/`

**Create:**
- Create: `templates/architecture.md` (blank template version)
- Create: `templates/conventions.md` (blank template version)
- Create: `templates/decisions/000-template.md` (ADR template)
- Create: `.forge/shared/decisions/001-product-artifacts-top-level.md`

**Update references (skills — grep for `.forge/bin/` and `.forge/policies/`):**
- Modify: `skills/adopting-forge/SKILL.md`
- Modify: `skills/adopting-forge/references/generated-claude-md-template.md`
- Modify: `skills/forge-routing/SKILL.md`
- Modify: `skills/forge-packs/SKILL.md`
- Modify: `skills/syncing-forge/SKILL.md`
- Modify: `skills/diagnosing-forge/SKILL.md`
- Modify: `skills/setting-up-project/SKILL.md`
- Modify: `skills/writing-plans/SKILL.md`
- Modify: `skills/finishing-a-development-branch/SKILL.md`

**Update references (hooks):**
- Modify: `hooks/forge-session-start`
- Modify: `hooks/forge-task-completed`
- Modify: `hooks/forge-pre-commit`

**Update references (tests):**
- Modify: `tests/forge-state/test-get-set.sh`
- Modify: `tests/forge-state/test-memory.sh`
- Modify: `tests/forge-state/test-backend-detection.sh`
- Modify: `tests/forge-state/test-evidence.sh`
- Modify: `tests/forge-state/test-init.sh`
- Modify: `tests/forge-skills/test-forge-packs.sh`
- Modify: `tests/forge-pack/install-remove-cycle.test.sh`
- Modify: `tests/forge-pack/invalid-manifest.test.sh`
- Modify: `tests/forge-pack/policy-merge.test.sh`
- Modify: `tests/forge-risk/test-policy-matching.sh`
- Modify: `tests/forge-risk/test-scope-matrix.sh`
- Modify: `tests/forge-risk/test-multi-policy.sh`
- Modify: `tests/forge-risk/test-override.sh`
- Modify: `tests/forge-hooks/test-state-gates.sh`
- Modify: `tests/forge-hooks/test-pre-commit.sh`
- Modify: `tests/forge-hooks/test-task-completed.sh`
- Modify: `tests/forge-structure/validate-directory.sh`
- Modify: `tests/forge-structure/validate-schemas.sh`

**Update references (bin tools — internal paths):**
- Modify: `bin/classify-risk` (if it references `.forge/policies/`)
- Modify: `bin/forge-pack` (if it references `.forge/packs/`)
- Modify: `bin/forge-state` (if it references `.forge/local/`)

**Update references (other):**
- Modify: `README.md` (infrastructure section)
- Modify: `.forge/shared/architecture.md` (module map)
- Modify: `.forge/shared/conventions.md` (if paths mentioned)

**Do NOT modify (historical):**
- `docs/plans/forge-v0/tasks/*.md` — historical plan references
- `docs/forge-beta/design/*.md` — design docs describe the change, not the result

## Implementation Notes

- This is the single largest task in v0.2.0. Take care with the reference updates — a missed reference will break tools or tests.
- The `bin/` tools internally reference `.forge/local/` for state storage — this path stays the same (it's project config, not product infrastructure). Only references to `.forge/bin/`, `.forge/policies/`, `.forge/adapters/`, `.forge/workflows/`, `.forge/packs/` need updating.
- The `classify-risk` tool reads policies from `.forge/policies/` — it needs to be updated to read from `policies/` (for product defaults) and optionally `.forge/policies/` (for project-specific overrides).
- The `forge-pack` tool installs packs to `.forge/packs/` — update to `packs/`.
- Plugin manifests (`.claude-plugin/plugin.json`, `.cursor-plugin/plugin.json`) reference `skills/`, `agents/`, `hooks/` — these paths are UNCHANGED. Do not modify plugin manifests for this task.
- After moving files, verify with `git status` that moves are tracked correctly.
- Run the full test suite after all updates to catch any missed references.

## Commit

`refactor: move product artifacts from .forge/ to top-level directories`
