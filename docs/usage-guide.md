# Forge Usage Guide

A practical guide to using Forge for AI-assisted software development. This guide assumes Forge is installed — see the [README](../README.md) for installation.

---

## 1. Day-to-Day Workflows

Forge organizes work into 8 outcome-based workflows. You don't need to know which skills run — just describe what you want to do.

### Starting a Feature

**Say:** "Add user notifications" or "Build a payment form"

**What happens:**
1. `forge:brainstorming` — explores the problem, proposes approaches, produces a design doc
2. `forge:setting-up-project` — classifies risk, decides solo vs team execution
3. `forge:writing-plans` — breaks the design into tasks with TDD expectations
4. Execution (solo or team) — implements with tests first
5. `forge:verification-before-completion` — verifies with evidence
6. `forge:requesting-code-review` — reviews for quality and security
7. `forge:finishing-a-development-branch` — merges or creates PR

**What you do:** Approve the design, confirm risk assessment, answer clarifying questions. Forge handles the rest.

### Fixing a Bug

**Say:** "Login is returning 500 errors" or "Users can't update their profile"

**What happens:**
1. `forge:systematic-debugging` — structured root-cause analysis
2. Write a test that reproduces the bug (RED)
3. Fix the code (GREEN)
4. Verify the fix doesn't break anything

**Tip:** Describe symptoms, not your theory about the cause. Let debugging follow its process.

**Example session:**
```
You: "The checkout endpoint returns 500 when the cart has more than 10 items"
Forge: Applies systematic debugging:
  1. Reproduces with test (cart with 11 items → 500)
  2. Traces: SQL query has no LIMIT, loads all line items into memory
  3. Fix: Add pagination to the cart query
  4. Verify: test passes with 11, 50, 100 items
```

### Refactoring Safely

**Say:** "Refactor the auth module to use middleware" or "Clean up the API error handling"

**What happens:** Same as starting a feature, but with emphasis on preserving behavior:
1. Brainstorming scopes the refactor
2. Tests are written/verified BEFORE changing code
3. Refactor happens with continuous test verification
4. Code review confirms nothing was lost

### Reviewing a Change

**Say:** "Review PR #42" or "Review the auth changes"

**What happens:** `forge:requesting-code-review` dispatches a reviewer that checks:
- Security (injection, auth bypass, data leaks)
- Code quality (error handling, naming, DRY)
- Test coverage (critical paths tested?)
- Plan compliance (does it match the design?)

### Resuming Work

**Say:** "Where was I?" or "Continue"

**What happens:** Forge reads its state (`.forge/local/`) and resumes at the last active phase. If you were mid-plan execution, it picks up at the current wave.

### Preparing a Release

**Say:** "Ship it" or "Prepare a release"

**What happens:**
1. `forge:verification-before-completion` — final evidence check
2. `forge:finishing-a-development-branch` — version bump, changelog, merge decision

### Adopting a Repo

**Say:** "Set up Forge in this project"

**What happens:**
1. `forge:adopting-forge` scans the repo (with LLM exposure warning)
2. Detects stack, test runner, linter, CI, risk areas
3. Detects prior orchestration systems (.superpowers/, .aider/, etc.) and existing design docs
4. Auto-detects project conventions (test patterns, CSS tokens, commit format) and records them
5. Creates `.forge/` configuration with your approval
6. Generates managed CLAUDE.md/AGENTS.md sections (within `<!-- forge:begin/end -->` markers)
7. Updates root `.gitignore` for `.forge/local/`

**Important:** Forge never overwrites your existing CLAUDE.md content — it appends a managed block. Run `forge sync` later to regenerate without losing your content.

### Investigating an Incident

**Say:** "Why is the API returning timeouts?" or "Investigate the deploy failure"

**What happens:** `forge:systematic-debugging` applies 4-phase root cause analysis: observe → hypothesize → test → conclude.

---

### Workflow Decision Tree

Not sure which workflow to use? Follow this:

```
Is something broken?
  → Yes: "Fix a bug" (systematic-debugging)
  → No: ↓

Are you improving existing code without adding features?
  → Yes: "Refactor safely" (brainstorming → TDD → review)
  → No: ↓

Are you adding new functionality?
  → Yes: "Start a feature" (brainstorming → plan → implement)
  → No: ↓

Are you checking someone's work?
  → Yes: "Review a change" (requesting-code-review)
  → No: ↓

Are you shipping?
  → Yes: "Prepare a release" (verification → finishing)
  → No: ↓

Are you setting up Forge for the first time?
  → Yes: "Adopt a repo" (adopting-forge)
  → No: ↓

Need to understand what happened?
  → Yes: "Investigate" (systematic-debugging) or "Audit" (analyze-audit)
```

If your intent is ambiguous, Forge will ask: "That could be a feature or a refactor. Which fits better?"

### What Happens Between Sessions

Forge state persists in `.forge/local/`. When you start a new session:
- The session-start hook reads your last state (phase, plan progress, risk tier)
- If you were mid-execution, Forge offers to resume: "You were in wave 2 of the plan. Continue?"
- Audit events continue appending to the same session file
- Team decisions and worktree paths are restored

You don't need to re-explain what you were doing — Forge remembers.

---

## 2. Working with Agents

### How Agents Work

Forge has 10 specialist agents that can be dispatched for tasks:

| Agent | Specialty | When Used |
|-------|-----------|-----------|
| architect | System design, API design | Architecture decisions |
| implementer | Feature implementation | General coding |
| qa-engineer | Test design, coverage | Pipelined TDD |
| code-reviewer | Code quality, plan compliance | Post-implementation review |
| security-reviewer | Vulnerability assessment | Critical-tier security audit |
| forge-author | Skill/agent authoring | Writing Forge skills |
| frontend-engineer | UI, accessibility, CSS | Frontend tasks |
| backend-engineer | API, database, error handling | Backend tasks |
| database-specialist | Schema, migrations, rollback | Database changes |
| devops-engineer | CI/CD, containers, secrets | Infrastructure |

### Team vs Solo Execution

Forge decides automatically based on three criteria:
- **4+ tasks** — enough work to justify team overhead
- **2+ can run in parallel** — real parallelism exists
- **2+ specialist domains** — different expertise needed

If all three are met → team execution with parallel waves. Otherwise → solo.

### Monitoring Agent Progress

During multi-agent execution, the lead displays progress:

```
**Project Name** — 3/7 tasks | 25/25 tests implemented | 25/25 passing

 ● ✅ Wave 0: Scaffolding (1/1 tests passing)
 ● ✅ Wave 1: Auth (12/12 tests passing)

 ● 🔄 Wave 2: Workspaces
    • ⏳ T3  agent-w2 — CRUD + middleware (tests: 14 RED)

 ● ⏭️ Wave 3: Tasks
    • ◻️ T4  — CRUD scoped to workspace
```

Press **Ctrl+T** to toggle the task list at any time.

### When Agents Get Stuck

Agents occasionally enter an idle loop (cycling "Standing by" / "Idle"). This is a platform behavior, not a Forge bug.

**What to do:**
1. Switch to the agent's pane (if using split view)
2. Press **Esc** to interrupt the loop
3. The agent will process its pending shutdown or report

Forge's lead agent will alert you: "Agent `<name>` appears stuck. Check its pane."

### Permission Approval

For reference projects and automated runs, Forge uses approval manifests (`approvals.yaml`) — you approve permissions once at the start, and routine operations don't prompt again. Only unexpected operations ask for approval during the run.

---

## 3. Risk-Scaled Ceremony

### The 4 Tiers

| Tier | Icon | When | What's Required |
|------|------|------|----------------|
| 🟢 minimal | Low risk, small changes | Tests pass | Fix a typo, update config |
| 🟡 standard | Normal development | + plan + build clean | New endpoint, component |
| 🟠 elevated | Important, cross-cutting | + design doc + TDD evidence + review | Auth refactor, API redesign |
| 🔴 critical | High-stakes, irreversible | + rollback plan + security review | DB migration, payment flow |

### How Risk Is Determined

Risk is classified automatically based on file paths:

```yaml
# policies/default.yaml
critical:
  - "db/migrations/**"
  - "**/auth/**"
  - "**/payments/**"
elevated:
  - "**/api/**"
  - ".github/workflows/**"
standard:
  - "src/**"
minimal:
  - "docs/**"
  - "*.md"
```

### Adjusting Risk

Edit `policies/default.yaml` to change which paths trigger which tier. You can also override during `setting-up-project` when asked "Does this assessment look correct?"

### When Ceremony Feels Too Heavy

If Forge is requiring a design doc for a one-line fix:
- Check the risk tier — is it elevated when it should be standard?
- Adjust `policies/default.yaml` for that path
- Override during the risk assessment prompt

Forge is strict when the work is risky and light when the work is small. If it's wrong, adjust the policies.

---

## 4. Audit and Analysis

### Enabling Audit Mode

During brainstorming, Forge asks:
> "Would you like to enable audit mode for this project?"

Say yes to record workflow events (which skills ran, gate checks, token counts) as JSONL. Data stays local in `.forge/local/audit/`.

You can also enable manually:
```bash
bin/forge-state set audit.enabled true --project-dir .
```

### What Gets Recorded

| Event Type | When |
|-----------|------|
| `session_start` | Session begins |
| `task_start` / `task_completion` | Each task boundary |
| `skill_enter` / `skill_exit` | Skill invocations |
| `gate_check` | Evidence gate pass/fail |
| `verification_result` | Verification outcomes |

### Running Analysis

After a project completes:
```
"Run an audit analysis" or "How did this project go?"
```

This triggers `forge:analyze-audit` which reads your JSONL events + deviation log and produces:
- Skill coverage (which skills ran vs available)
- Deviation patterns (recurring root causes)
- Token efficiency (cost per skill/workflow)
- Recommendations for improvement

Results are saved to `docs/<project>/audits/analysis-<date>.md`.

---

## 5. State and Configuration

### The `.forge/` Directory

```
.forge/
  project.yaml              ← Project name, stack, commands
  policies/default.yaml     ← Risk tier classification rules (if project-specific)
  shared/
    architecture.md          ← Project architecture overview
    conventions.md           ← Coding conventions (detected or manual)
    decisions/               ← Architectural Decision Records (ADRs)
  local/                     ← Gitignored runtime state
    state.json               ← Current phase, risk tier, plan progress
    audit/                   ← JSONL event files (if audit enabled)
```

### Inspecting State

```bash
# Current phase
bin/forge-state get phase --project-dir .

# Risk tier
bin/forge-state get risk.tier --project-dir .

# Plan progress
bin/forge-state get plan.completed_tasks --project-dir .

# Audit enabled?
bin/forge-state get audit.enabled --project-dir .
```

### Product Artifacts (Top Level)

These are Forge's tools and definitions — not project-specific:

| Directory | Purpose |
|-----------|---------|
| `skills/` | 22 skill definitions (SKILL.md each) |
| `agents/` | 10 specialist agent definitions |
| `hooks/` | Lifecycle hooks for Claude Code/Cursor |
| `bin/` | CLI tools (forge-state, forge-audit, classify-risk, etc.) |
| `policies/` | Default risk classification rules |
| `templates/` | Blank templates for project adoption |

---

## 6. Extending Forge

### Writing New Skills

Use `forge:writing-skills` to create a new skill:
1. Define what the skill does and when to use it
2. Write the SKILL.md with frontmatter (name, description)
3. Structure: Overview → Checklist → Process Flow → Integration
4. Test with real usage before deploying

Skills are prompt-only — no compiled code. The LLM reads and follows SKILL.md instructions.

**Key patterns:**
- Use `<HARD-GATE>` tags for steps that must not be skipped
- Include a process flow diagram (dot or mermaid)
- Document state reads/writes in an Integration section
- Keep under 500 lines — use reference files for detail

### Adding Agents

Create a new file in `agents/`:
```markdown
---
name: my-specialist
description: One-line description. Use for [use cases].
model: opus
tools: [Read, Write, Edit, Bash, Glob, Grep]
---

You are a [role] specializing in [domain].

## Your Role
- [3-5 responsibilities]

## Workflow
1. [Steps]

## Principles
- [Quality standards]
```

Keep under 40 lines. The agent knows its domain — don't over-explain.

### Mono-Repo Support

Forge supports multiple projects in one repo via subfolder `.forge/` directories:

```
my-monorepo/
  .forge/project.yaml          ← repo-wide config
  services/
    api/
      .forge/project.yaml      ← api service config (independent state)
    web/
      .forge/project.yaml      ← web frontend config (independent state)
```

When you `cd services/api/`, Forge's state resolves to that subfolder's `.forge/`. Each service gets independent risk tiers, phases, and audit trails. Skills and agents are shared from the repo root.

### Creating Packs

Packs bundle skills, policies, and shared knowledge for distribution:
1. Create a directory with `pack.yaml` manifest
2. Include skills, policies, and/or shared docs
3. Install with `forge:forge-packs`

See `forge-pack-hello-world/` for an example.

---

## 7. Troubleshooting

### Skills Don't Activate

1. Run `forge:diagnosing-forge` — checks hooks, state, adapters
2. Verify the plugin is installed: check your platform's plugin list
3. Restart your session — hooks initialize on session start
4. Try explicit invocation: "Use the forge:brainstorming skill"

### Risk Tier Seems Wrong

- Check `policies/default.yaml` for the file path rules
- The most specific glob match wins
- Override during the risk assessment prompt
- Run `bin/classify-risk <path> --scope 1` to test

### State Seems Corrupted

```bash
# Reset to clean state
bin/forge-state init --project-dir .

# Or inspect what's there
cat .forge/local/state.json
```

### Agent Won't Shut Down

1. Switch to the agent's pane
2. Press **Esc** to break the idle loop
3. The shutdown should process after the interrupt
4. If not, exit the session — agents terminate with the session

### Forge Doesn't Follow Project Conventions

If agents aren't matching your project's test patterns, CSS conventions, or naming:
1. Check `.forge/shared/conventions.md` — does it have real content or just template placeholders?
2. If placeholder: run `forge:adopting-forge` again or tell brainstorming to detect conventions
3. If already populated but wrong: edit conventions.md directly — agents read it before every task

### Audit Data Missing

- Check `bin/forge-state get audit.enabled --project-dir .`
- Audit events go to `.forge/local/audit/` of the **current working directory's** nearest `.forge/`
- If running in a subfolder, events may go to that subfolder's `.forge/` instead of the root

### Platform-Specific Issues

| Platform | Known Issue | Workaround |
|----------|-------------|------------|
| Claude Code | Agent idle loop | Press Esc in agent pane |
| Cursor | Skills may not auto-trigger | Use explicit "Use forge:skill-name" |
| Codex | Hooks may not fire | Check .codex/INSTALL.md setup |
| OpenCode | Limited plugin support | Follow .opencode/INSTALL.md carefully |
| Gemini CLI | Context-only (no hooks) | Skills work but hooks are limited |
