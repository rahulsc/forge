---
name: adopting-forge
description: Use when setting up Forge in an existing repository for the first time — installs .forge/ configuration, CLAUDE.md adapter, and hooks
---

# Adopting Forge

**Announce at start:** "I'm using the adopting-forge skill to set up Forge in this repository."

Forge adoption has seven steps (Step 0 through Step 6). Do not skip steps. Do not create files before Step 5.


## Step 0 — LLM Exposure Warning

Before scanning the repository, display this notice:

> **Forge Adoption Notice**
>
> Forge will scan your project to detect your tech stack, commands, and risk areas. Project contents will be sent to your LLM provider for analysis.
>
> Before proceeding:
> - Review .gitignore to ensure sensitive files are excluded
> - Forge will flag likely-sensitive files (.env, credentials, keys) and exclude them where possible
> - No files are modified until you approve the preview
>
> Continue? (y/n)

User must acknowledge before scanning proceeds. If they decline, stop and explain how to prepare their repo.


## Step 1 — Inspect Repository

Scan the repo at file and directory level (no AST analysis):

**Stack detection** — look for these signals (full heuristics in `references/stack-detection.md`):

| Signal file | Stack |
|-------------|-------|
| `package.json` | node / javascript |
| `tsconfig.json` | typescript |
| `Cargo.toml` | rust |
| `go.mod` | go |
| `pyproject.toml` / `requirements.txt` / `setup.py` | python |
| `Gemfile` | ruby |
| `pom.xml` / `build.gradle` | java / jvm |

**Command detection** — scan for test/lint/build commands:
- Check `package.json` scripts: `test`, `lint`, `build`
- Check `Makefile` targets: `test`, `lint`, `build`, `check`
- Check `pyproject.toml` `[tool.pytest]`, `[tool.ruff]` sections
- Check `Cargo.toml` for `cargo test`, `cargo clippy`
- Check `.github/workflows/` for CI steps (extracts actual commands)

**Risk area detection** — flag directories that need elevated/critical policies:
- `auth/`, `authentication/`, `login/` → critical
- `db/migrations/`, `database/migrations/` → critical
- `payment/`, `billing/`, `stripe/` → critical
- `api/public/`, `api/v*/` → elevated
- `admin/` → elevated
- `docs/`, `README*` → minimal

**AI surface detection:**
- `CLAUDE.md` (Claude Code), `.cursor/` (Cursor), `AGENTS.md` (Codex)
- Existing `.forge/` → re-adoption path (see below)

### Sensitive File Detection

During repo scanning, detect and flag files matching these patterns:

| Pattern | Action |
|---------|--------|
| `.env`, `.env.*` | Exclude from LLM context; warn user |
| `credentials.*`, `secrets.*` | Exclude; warn |
| `*.pem`, `*.key`, `*.p12` | Exclude; warn |
| `.ssh/`, `.gnupg/` | Exclude; warn |
| `**/private_key*` | Exclude; warn |
| `**/password*`, `**/token*` | Flag for review (may be code, not actual secrets) |

Report excluded files to the user: "These files were excluded from analysis: [list]"
Add matched patterns to the generated risk policy as `critical` tier.

### Stack Inference

| Signal | Detection Method | project.yaml Field |
|--------|-----------------|-------------------|
| Package manager | `package.json` → npm/yarn/pnpm; `pyproject.toml`/`requirements.txt` → pip/poetry/uv; `Cargo.toml` → cargo; `go.mod` → go | `stack.package_manager` |
| Test runner | package.json `scripts.test`; Makefile `test` target; CI config | `commands.test` |
| Linter | `.eslintrc*` → eslint; `ruff.toml` → ruff; `.golangci.yml` → golangci-lint | `commands.lint` |
| Language/stack | File extensions, manifest files | `stack.languages` |
| CI surface | `.github/workflows/` → GitHub Actions; `.gitlab-ci.yml` → GitLab CI | `stack.ci` |
| Critical paths | `db/migrations/`, `auth/`, `**/secrets*`, `**/payments*` | Auto-add to policies as elevated/critical |

Collect: stack, version manager, test command, lint command, build command, risk areas, sensitive files, existing AI surfaces.


## Step 2 — Propose Configuration

Present findings as a structured proposal using tables. Include confidence scores based on how many signals confirm each field.

**Project: `<repo-name>`**

**Stack & Commands:**

| Setting | Detected Value | Confidence | Source |
|---------|---------------|------------|--------|
| Stack | node / typescript | 🟢 high | package.json + tsconfig.json |
| Package manager | npm | 🟢 high | package-lock.json |
| Test command | `npm test` | 🟢 high | package.json scripts.test |
| Lint command | `npm run lint` | 🟡 medium | package.json scripts.lint |
| Build command | `npm run build` | 🟢 high | package.json scripts.build |
| CI | GitHub Actions | 🟢 high | .github/workflows/ |

**Risk Areas:**

| Path | Tier | Reason |
|------|------|--------|
| 🔴 src/auth/ | critical | Authentication — password handling, token management |
| 🔴 db/migrations/ | critical | Database migrations — data integrity, rollback safety |
| 🟠 src/api/ | elevated | Public API — input validation, error exposure |
| 🟢 docs/ | minimal | Documentation only |

**Risk Tier Legend:**

| Icon | Tier | What It Means |
|------|------|---------------|
| 🔴 | critical | Security-sensitive or irreversible. Requires design doc, TDD, rollback plan, security review. |
| 🟠 | elevated | Important, cross-cutting. Requires design doc, TDD, code review. |
| 🟡 | standard | Normal development. Requires plan, tests, review. |
| 🟢 | minimal | Low risk. Basic verification only. |

**Existing AI Surfaces:**

| File/Dir | Status | Action |
|----------|--------|--------|
| CLAUDE.md | exists | Append Forge section (not overwrite) |
| AGENTS.md | missing | Create for Codex compatibility |
| .claude/agents/ | 5 definitions | Preserve |

Ask: "Does this look correct? Any fields to adjust before I continue?"

Wait for confirmation before proceeding.


## Step 3 — Choose Mode

Offer two adoption modes:

| Mode | Creates | Best for |
|------|---------|----------|
| **Light touch** | `.forge/project.yaml` only | Solo developer, simple project |
| **Full adoption** | Complete `.forge/` layout + policies + hooks | Team workflows, elevated/critical risk areas |

If any critical risk areas were detected, recommend full adoption.

Present the choice and wait for selection.


## Step 4 — Preview Files

Show every file that will be created or modified. Do NOT create anything yet.

For **light touch**:
```
Files to create:
  .forge/project.yaml        — project config (name, stack, commands, storage)
  .forge/local/.gitignore    — gitignore for local state files

Files to modify:
  CLAUDE.md                  — append Forge section (existing content preserved)

Files to create (new):
  AGENTS.md                  — Codex compatibility adapter
```

For **full adoption**, additionally:
```
  policies/default.yaml           — risk tier rules for detected paths
  hooks registered in hooks.json via forge-routing
```

Show the content of each file that will be created (use code blocks).

Ask: "Shall I apply these changes?" — proceed only on explicit yes.


## Step 5 — Apply

Create files in this order:

1. **`.forge/project.yaml`** — use detected values:
   ```yaml
   name: <repo-name>
   version: "1.0"
   stack: <detected-stack>
   commands:
     test: <detected-test-cmd>
     lint: <detected-lint-cmd>
   storage: json
   ```
   Omit any field not detected with at least medium confidence.

2. **`policies/default.yaml`** (full adoption only) — generate rules from detected risk areas:
   ```yaml
   rules:
     - match: "auth/**"
       tier: critical
       require: [design-doc, plan, tdd, evidence, security-review]
     - match: "db/migrations/**"
       tier: critical
       require: [design-doc, risk-register, plan, tdd, rollback-evidence, review]
     - match: "src/**"
       tier: standard
       require: [plan, test-evidence, verification]
     - match: "docs/**"
       tier: minimal
       require: [verification]
   ```

3. **`CLAUDE.md`** — generate using managed block strategy (template in `references/generated-claude-md-template.md`):

   **If CLAUDE.md exists:**
   1. Read existing content
   2. Check for existing `<!-- forge:begin -->` markers
   3. If markers exist: replace content between them
   4. If no markers: append the Forge block at the end
   5. Never modify content outside the markers

   **If CLAUDE.md does not exist:**
   1. Create with the Forge block only

   **Generated block format:**
   ```
   <!-- forge:begin — DO NOT EDIT THIS BLOCK. Run `forge sync` to regenerate. -->

   ## Forge

   This project uses [Forge](https://github.com/rahulsc/forge) for structured AI-assisted development.

   ### Project
   - **Name:** {project_name}
   - **Stack:** {languages}, {frameworks}
   - **Package manager:** {package_manager}

   ### Commands
   - **Test:** `{test_command}`
   - **Lint:** `{lint_command}`

   ### Risk Policy
   High-risk paths requiring elevated review:
   {critical_paths_list}

   ### Workflow
   Forge enforces: design → plan → TDD → implement → verify → review.

   <!-- forge:end -->
   ```

4. **`AGENTS.md`** — generate using managed block strategy (same pattern as CLAUDE.md):

   **If AGENTS.md exists:**
   1. Read existing content
   2. Check for existing `<!-- forge:begin -->` markers
   3. If markers exist: replace content between them
   4. If no markers: append the Forge block at the end
   5. Never modify content outside the markers

   **If AGENTS.md does not exist:**
   1. Create with the Forge block only

   **Generated block format:**
   ```
   <!-- forge:begin — DO NOT EDIT THIS BLOCK. Run `forge sync` to regenerate. -->

   ## Forge Agents

   | Agent | Role | When Used |
   |-------|------|-----------|
   | architect | System design, API design | Architecture decisions |
   | implementer | Feature implementation | Writing code following TDD |
   | qa-engineer | Test design, coverage | Pipelined TDD, test quality |
   | code-reviewer | Code quality review | Post-implementation review |
   | security-reviewer | Vulnerability assessment | Critical-tier security audit |
   | forge-author | Skill/agent authoring | Writing and editing Forge skills |
   | frontend-engineer | UI development | Frontend tasks, accessibility |
   | backend-engineer | API development | Backend tasks, data access |
   | database-specialist | Schema, migrations | Database changes, migration review |
   | devops-engineer | CI/CD, infrastructure | Deployment, pipeline review |

   <!-- forge:end -->
   ```

5. **`.forge/local/.gitignore`** — `*` (gitignore all local state)

Run `forge-state init --project-dir .` to initialize state storage.


## Step 6 — Verify

Run health checks after applying:

```
forge-gate check design.approved --project-dir .    # expected: exit 2 (not yet set — normal)
forge-state get active.task --project-dir .         # expected: key not found — normal
ls .forge/                                          # should show: bin/ local/ policies/ project.yaml
```

Then invoke `diagnosing-forge` (or equivalent health check) to confirm Forge is functional.

Report to user:
```
Forge adoption complete for <repo-name>.

Created:
  ✓ .forge/project.yaml
  ✓ policies/default.yaml         (if full adoption)
  ✓ CLAUDE.md (appended / created)
  ✓ AGENTS.md

Next step: Run forge-routing when starting your first task.
```


## Re-adoption (`.forge/` Already Exists)

If `.forge/` already exists:
1. Read existing `project.yaml` — show current values
2. Diff proposed vs existing — only show what would change
3. Ask: "Update existing config?" before touching anything
4. Never overwrite `policies/` without explicit permission
5. Always preserve existing `local/` state (do not run `init` again unless asked)


## Scope Limits

- Do NOT implement syncing or diagnosing (separate skills)
- Do NOT detect packages inside `node_modules/` or build artifacts
- Do NOT parse ASTs or import graphs — file/directory level only
- Forge uses `.forge/` exclusively — do not create or modify other AI plugin directories
