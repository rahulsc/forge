# Forge Beta v0.3.0 Design Document

**Version:** Draft 1
**Date:** 2026-03-14
**Status:** Awaiting review
**Scope:** v0.3.0 — Adoption and Workflow Surface
**Parent design:** [design-v3.md](../../forge-beta/design/design-v3.md)

---

## 1. Executive Summary

v0.2.0 established trust: clean identity, restructured project, outcome-first README. But during v0.2.0 development, Forge's own execution machinery showed friction — composing-teams was skipped, commits were messy, task cleanup was fragile, and status was invisible.

v0.3.0 fixes the machinery first, then uses it to build the adoption flow and expand the agent roster. Three phases:

1. **Fix execution** — composing-teams enforcement, squash-on-merge, reliable cleanup, status visibility
2. **Expand agents** — 4 new specialist agents + execution ergonomics (lighter ceremony for low-risk work)
3. **Build adoption** — `forge adopt` with LLM exposure warnings, sensitive file detection, stack inference, managed-block CLAUDE.md/AGENTS.md generation, `forge sync`, `forge doctor`

### Exit Criteria

- `forge adopt` works on 3+ representative existing repos and produces a usable `.forge/` setup
- `CLAUDE.md` and `AGENTS.md` generation uses managed blocks (no full-file overwrite)
- All 8 workflows route correctly
- All 4 new agent definitions exist and are referenceable by composing-teams
- `forge sync` and `forge doctor` work
- Composing-teams is enforced before plan writing when team execution is warranted
- Multi-agent execution produces clean commit history (squash-on-merge)
- Task cleanup is reliable after agent shutdown

---

## 2. Phase 1: Execution Fixes

**Goal:** Fix the machinery before using it to build features. All 4 fixes are to existing skills — no new infrastructure.

### 2.1 Enforce composing-teams (Deviation #4)

**Problem:** `setting-up-project` skipped `forge:composing-teams` entirely. Team structure was improvised during plan execution with no user input on specialist selection.

**Fix:**

In `skills/setting-up-project/SKILL.md`, Step 4 (Team Decision):

1. When all three team criteria are met, invoke `forge:composing-teams` — do not skip
2. `composing-teams` must present: available agents, recommended specialist per task domain, model tier per role, team size
3. User approves the roster before proceeding
4. Write approved roster to state: `forge-state set team.roster "<json>"`
5. `writing-plans` reads `team.roster` from state and uses it for wave analysis

**Enforcement gate:** `writing-plans` should check `forge-state get team.roster` when `team.decision = team`. If roster is empty, block with: "Team roster not set — run forge:composing-teams first."

### 2.2 Squash-on-merge (Deviation #6)

**Problem:** Multi-agent execution produces excessive commits when each agent's working commits all land on main.

**Fix:**

In `skills/agent-team-driven-development/SKILL.md`, "Between waves" section:

1. When merging implementer worktree branches, use `git merge --squash` instead of regular merge
2. Each task produces one commit on main with the commit message from the task spec
3. Agents can still make multiple working commits in their worktrees for safety — those are collapsed on merge
4. If a task genuinely has multiple distinct logical changes, the lead can choose not to squash — but the default is squash

**Implementation:** Update the merge step in the skill:
```
# Instead of:
git merge <branch>
# Use:
git merge --squash <branch>
git commit -m "<task commit message>"
```

### 2.3 Reliable task cleanup (Deviation #7)

**Problem:** After Wave 0, completed tasks remained `in_progress`. Shutdown requests were sent but task status wasn't updated.

**Fix:**

In `skills/agent-team-driven-development/SKILL.md`, Phase 3 (Completion) and between-wave cleanup:

1. **Cleanup is a single routine, run after each wave and at completion:**
   ```
   cleanup_wave():
     1. Mark all wave tasks as completed (TaskUpdate)
     2. Mark all agent-created sub-tasks as completed
     3. Send shutdown to agents no longer needed
     4. Verify TaskList shows no stale in_progress tasks
     5. If stale tasks found, force-complete them with a note
   ```
2. **Cleanup runs before the next wave starts** — not after shutdown, not as an afterthought
3. **TeamDelete only after all agents confirm shutdown** — if agents don't respond within 30 seconds, proceed anyway and log the issue

### 2.4 Status visibility (Deviation #8)

**Problem:** During multi-agent execution, there's no way to see which agents are working on which tasks or what's done.

**Fix:**

In `skills/agent-team-driven-development/SKILL.md`, add status reporting:

1. **After each task completion**, the lead posts a status summary:
   ```
   Wave 1 Status:
     T3 [done]  restructurer — project restructure (commit 0d585c8)
     T4 [WIP]   metadata-agent — repo metadata
     T5 [WIP]   readme-writer — README rewrite
   ```
2. **Between waves**, post a full progress summary:
   ```
   Progress: 3/7 tasks complete (Wave 0-1 done, starting Wave 2)
     T1 [done] T2 [done] T3 [done]
     T4 [next] T5 [next] T6 [next]
     T7 [blocked by T4,T5,T6]
   ```
3. The status format is text-based (no special tooling needed) — just a convention in the skill.

---

## 3. Phase 2: Agent Roster and Execution Ergonomics

**Goal:** All agent roles referenced by skills actually exist. Execution is lighter for low-risk work.

### 3.1 New Agent Definitions

Four new agents following the existing pattern in `agents/`:

#### frontend-engineer.md

```yaml
description: Frontend development — component design, accessibility, browser compatibility, UI testing, rendering performance. Use for tasks involving user interfaces, client-side logic, and visual components.
model: opus
tools: Read, Write, Edit, Bash, Glob, Grep
```

Key system prompt elements:
- Component design and reusability (composition over inheritance)
- Accessibility (WCAG 2.1 AA minimum)
- Responsive design and browser compatibility
- Client-side performance (rendering, bundle size, lazy loading)
- UI testing (component tests, visual regression, interaction tests)
- Follow existing frontend patterns in the codebase

#### backend-engineer.md

```yaml
description: Backend development — API design, database integration, scalability patterns, error handling, auth integration. Use for tasks involving server-side logic, data access, and service architecture.
model: opus
tools: Read, Write, Edit, Bash, Glob, Grep
```

Key system prompt elements:
- RESTful API design and contract specification
- Database query optimization and connection management
- Error handling and resilience (retries, circuit breakers, graceful degradation)
- Authentication and authorization integration
- Input validation at system boundaries
- Follow existing backend patterns in the codebase

#### database-specialist.md

```yaml
description: Database and data modeling — schema design, migration safety, backward compatibility, rollback plans, query performance, data integrity. Use for tasks involving schema changes, migrations, or data-sensitive operations.
model: opus
tools: Read, Write, Edit, Bash, Glob, Grep
```

Key system prompt elements:
- Schema design and normalization decisions
- Migration safety (backward compatible, reversible, zero-downtime where possible)
- Rollback plan for every migration (down migration must be tested)
- Data integrity constraints (foreign keys, unique indexes, check constraints)
- Query performance (explain plans, index strategy, N+1 detection)
- Test with realistic data volumes, not just empty tables

#### devops-engineer.md

```yaml
description: Infrastructure and operations — CI/CD pipelines, container configuration, secrets management, infrastructure-as-code, deployment verification. Use for tasks involving build systems, deployment, monitoring, or infrastructure.
model: opus
tools: Read, Write, Edit, Bash, Glob, Grep
```

Key system prompt elements:
- CI/CD pipeline design (fast feedback, fail early, parallel stages)
- Container configuration (minimal images, multi-stage builds, health checks)
- Secrets management (never in code, environment-based, rotation-aware)
- Infrastructure-as-code (declarative, version-controlled, reviewable)
- Deployment verification (health checks, smoke tests, rollback triggers)
- Monitoring and observability (structured logging, metrics, alerts)

### 3.2 Execution Ergonomics

Updates to existing skills to make execution lighter when risk is low:

#### Optional worktrees for minimal-risk work (Deviation #3)

In `skills/setting-up-project/SKILL.md`, update worktree requirement table:

| Tier | Worktree |
|------|----------|
| minimal | Not created (work directly on branch) |
| standard | Optional (offer, default to no) |
| elevated | Recommended (offer, default to yes) |
| critical | Required |

#### Single-agent path for small tasks

In `skills/setting-up-project/SKILL.md`, update team decision:

When task count is < 4 OR all tasks are in the same domain, skip team composition entirely and set `team.decision = solo`. The implementer works directly, no team overhead.

#### Lighter review for mechanical tasks (Deviation #5)

In `skills/agent-team-driven-development/SKILL.md`, add a review tier:

| Task complexity | Review approach |
|----------------|----------------|
| Mechanical (find-replace, config, scaffolding) | Single verification check (e.g., grep passes) — no subagent review |
| Standard (implementation with tests) | Two-stage review (spec + quality) |
| Complex (architecture, cross-cutting) | Two-stage review + lead review |

The task spec in the plan should include a `complexity` field: `mechanical`, `standard`, or `complex`. The lead uses this to decide review depth.

---

## 4. Phase 3: Adoption Flow

**Goal:** `forge adopt` works on real repos, generates safe artifacts, and maintenance commands exist.

### 4.1 LLM Exposure Warning

Before `forge:adopting-forge` scans the repo, display:

```
⚠ Forge Adoption Notice

Forge will scan your project to detect your tech stack, commands, and
risk areas. Project contents will be sent to your LLM provider for
analysis.

Before proceeding:
- Review .gitignore to ensure sensitive files are excluded
- Forge will flag likely-sensitive files (.env, credentials, keys)
  and exclude them where possible
- No files are modified until you approve the preview

Continue? (y/n)
```

User must acknowledge before scanning proceeds.

### 4.2 Sensitive File Detection

During repo scanning, detect and flag:

| Pattern | Action |
|---------|--------|
| `.env`, `.env.*` | Exclude from LLM context; warn user |
| `credentials.*`, `secrets.*` | Exclude; warn |
| `*.pem`, `*.key`, `*.p12` | Exclude; warn |
| `.ssh/`, `.gnupg/` | Exclude; warn |
| `**/private_key*` | Exclude; warn |
| `**/password*`, `**/token*` | Flag for review (may be code, not actual secrets) |

Files matching these patterns should:
1. Be listed to the user with the warning: "These files were excluded from analysis"
2. Default to `critical` risk tier in the generated policy
3. Never be sent to LLM context during adoption scanning

### 4.3 Stack Inference

Detect and populate `.forge/project.yaml`:

| Signal | Detection Method | project.yaml Field |
|--------|-----------------|-------------------|
| Package manager | `package.json` → npm/yarn/pnpm; `pyproject.toml`/`requirements.txt` → pip/poetry/uv; `Cargo.toml` → cargo; `go.mod` → go | `stack.package_manager` |
| Test runner | package.json `scripts.test`; Makefile `test` target; CI config test steps | `commands.test` |
| Linter | `.eslintrc*` → eslint; `ruff.toml` → ruff; `.golangci.yml` → golangci-lint | `commands.lint` |
| Language/stack | File extensions, manifest files | `stack.languages`, `stack.frameworks` |
| CI surface | `.github/workflows/` → GitHub Actions; `.gitlab-ci.yml` → GitLab CI | `stack.ci` |
| Critical paths | `db/migrations/`, `auth/`, `**/secrets*`, `**/payments*` | Auto-added to `policies/default.yaml` as elevated/critical |

### 4.4 CLAUDE.md Generation (Managed Block Strategy)

When `forge adopt` runs:

**If CLAUDE.md exists:**
1. Read existing content
2. Check for existing `<!-- forge:begin -->` markers
3. If markers exist: replace content between them
4. If no markers: append the Forge block at the end
5. Never modify content outside the markers

**If CLAUDE.md does not exist:**
1. Create with the Forge block only

**Generated block format:**
```markdown
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
Use `forge:forge-routing` to determine the right workflow for your task.
Forge enforces: design → plan → TDD → implement → verify → review.

<!-- forge:end -->
```

### 4.5 AGENTS.md Generation

Same managed block strategy as CLAUDE.md. Content lists available specialist agents:

```markdown
<!-- forge:begin — DO NOT EDIT THIS BLOCK. Run `forge sync` to regenerate. -->

## Forge Agents

| Agent | Role | When Used |
|-------|------|-----------|
| architect | System design, API design | Architecture decisions, design review |
| implementer | Feature implementation | Writing code following TDD |
| qa-engineer | Test design, coverage | Pipelined TDD, test quality |
| code-reviewer | Code quality review | Post-implementation review |
| security-reviewer | Vulnerability assessment | Critical-tier security audit |
| frontend-engineer | UI development | Frontend tasks, accessibility |
| backend-engineer | API development | Backend tasks, data access |
| database-specialist | Schema, migrations | Database changes, migration review |
| devops-engineer | CI/CD, infrastructure | Deployment, pipeline review |

<!-- forge:end -->
```

### 4.6 `forge sync`

A maintenance command (invoked via `forge:syncing-forge`) that:

1. Reads current `.forge/project.yaml`
2. Re-infers stack if requested (`forge sync --re-infer`)
3. Regenerates the managed blocks in CLAUDE.md and AGENTS.md
4. Preserves all content outside `<!-- forge:begin/end -->` markers
5. Reports what changed

**Safety:** `forge sync` only touches content between markers. If markers are missing or corrupted, it warns and asks before proceeding.

### 4.7 `forge doctor`

A diagnostic command (invoked via `forge:diagnosing-forge`) that validates:

| Check | What It Validates | Fix Suggestion |
|-------|------------------|---------------|
| `.forge/project.yaml` exists | Forge is adopted | Run `forge adopt` |
| `project.yaml` has non-empty fields | Adoption was complete | Run `forge sync --re-infer` |
| CLAUDE.md has forge markers | Managed block exists | Run `forge sync` |
| Markers are well-formed | Open/close tags match | Fix manually or run `forge sync --force` |
| `bin/forge-state` is accessible | CLI tools work | Check installation |
| `.forge/local/` exists | State directory present | Run `bin/forge-state init` |
| Hooks are registered | Lifecycle hooks work | Check `hooks/hooks.json` |
| Policy file exists | Risk classification works | Run `forge adopt` |
| Agent definitions exist | Team composition works | Check `agents/` directory |

### 4.8 Routing Improvements

Update `skills/forge-routing/SKILL.md` to handle:

| Route | Signal | Current State | Fix |
|-------|--------|--------------|-----|
| Resume work | Session starts with existing forge-state showing in-progress plan | Not routed | Add: check `forge-state get phase` on session start; if `executing`, offer to resume |
| Prepare release | "ship it", "cut a release", "prepare release" | Not routed | Add intent signals to routing table |
| Ambiguous intent | User says something that could match multiple workflows | Guesses | Add: ask the user instead of guessing |

---

## 5. Testing Strategy

### Phase 1 (Execution Fixes)
- Verify composing-teams enforcement by running setting-up-project with `team.decision = team` and confirming it blocks without roster
- Verify squash-on-merge by running a multi-agent task and checking commit count on main
- Verify task cleanup by checking TaskList after a wave completes
- Status visibility is a convention — verify by reviewing skill text

### Phase 2 (Agent Roster)
- Verify each new agent definition loads correctly in Claude Code
- Verify `composing-teams` can discover and present the new agents
- Test execution ergonomics: run a minimal-risk task and confirm no worktree is created

### Phase 3 (Adoption Flow)
- Test `forge adopt` on 3 representative repos:
  1. A Node.js project with package.json, .eslintrc, jest config
  2. A Python project with pyproject.toml, ruff.toml, pytest
  3. A Go project with go.mod, golangci-lint
- Verify CLAUDE.md generation preserves existing content
- Verify `forge sync` regenerates only the managed block
- Verify `forge doctor` catches common issues
- Verify routing for resume and release workflows

---

## 6. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Managed block markers corrupted by user edits | Medium | Medium | `forge doctor` validates markers; `forge sync --force` can re-create |
| Stack inference wrong for unusual projects | Medium | Low | Conservative defaults; always preview before creating; user can edit project.yaml |
| Squash-on-merge loses useful commit granularity | Low | Low | Lead can opt out of squash for tasks with genuinely distinct changes |
| New agents too generic to be useful | Medium | Medium | Define with specific skill references; test on reference projects in v0.4.0 |
| Routing improvements break existing routes | Low | High | Test all 8 workflows with prompt fixtures after changes |
| Adoption flow too slow (scans entire repo) | Medium | Medium | Scan only manifest files and directory names, not file contents |

---

## 7. Deviation Worklog (Continued from v0.2.0)

Deviations from v0.2.0 being addressed in v0.3.0:

| # | Fix | Status |
|---|-----|--------|
| 3 | Worktree optional for minimal-risk → execution ergonomics | Addressed in §3.2 |
| 4 | Enforce composing-teams → skill gate | Addressed in §2.1 |
| 5 | Lighter review for mechanical tasks → review tiers | Addressed in §3.2 |
| 6 | Squash-on-merge → merge strategy | Addressed in §2.2 |
| 7 | Reliable task cleanup → cleanup routine | Addressed in §2.3 |
| 8 | Status visibility → status reporting convention | Addressed in §2.4 |

New deviations found during v0.3.0 development will be appended here.

---

## 8. Summary

| Phase | Tasks (estimated) | Key Deliverable |
|-------|-------------------|----------------|
| 1. Execution Fixes | 4 skill updates | Reliable multi-agent execution |
| 2. Agent Roster | 4 new agents + 3 ergonomics updates | Complete specialist coverage |
| 3. Adoption Flow | 8 components (warning, detection, inference, CLAUDE.md, AGENTS.md, sync, doctor, routing) | Working `forge adopt` on real repos |
| **Total** | **~15 tasks** | **Forge can adopt a real repo and guide work by outcomes** |
