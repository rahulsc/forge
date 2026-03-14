# Forge Beta Design Document

**Version:** Draft 1
**Date:** 2026-03-13
**Status:** Awaiting review
**Scope:** MVP (v0.1.x) → Beta (v0.5.0) → v1.0

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Current State Assessment](#2-current-state-assessment)
3. [Competitive Landscape](#3-competitive-landscape)
4. [Beta Goals & Non-Goals](#4-beta-goals--non-goals)
5. [Work Stream 1: Housekeeping & Cleanup](#5-work-stream-1-housekeeping--cleanup)
6. [Work Stream 2: README & Documentation Overhaul](#6-work-stream-2-readme--documentation-overhaul)
7. [Work Stream 3: Agent Roster Expansion](#7-work-stream-3-agent-roster-expansion)
8. [Work Stream 4: Workflow Gaps & Feature Parity](#8-work-stream-4-workflow-gaps--feature-parity)
9. [Work Stream 5: Adoption & Onboarding Experience](#9-work-stream-5-adoption--onboarding-experience)
10. [Work Stream 6: Observability & Cost Tracking](#10-work-stream-6-observability--cost-tracking)
11. [Work Stream 7: MVP Deviation Audit](#11-work-stream-7-mvp-deviation-audit)
12. [Work Stream 8: Dogfooding Framework](#12-work-stream-8-dogfooding-framework)
13. [v1.0 Horizon (Out of Scope for Beta)](#13-v10-horizon-out-of-scope-for-beta)
14. [Comparison Chart](#14-comparison-chart)
15. [Risk Register](#15-risk-register)
16. [Appendix A: Full Audit Findings](#appendix-a-full-audit-findings)
17. [Appendix B: Competitor Issue Analysis](#appendix-b-competitor-issue-analysis)
18. [Appendix C: Agent Gap Analysis Detail](#appendix-c-agent-gap-analysis-detail)
19. [Appendix D: Reference Project Specifications](#appendix-d-reference-project-specifications)

---

## 1. Executive Summary

Forge v0.1.x is a shipped MVP with 21 skills, 5 agent definitions, a risk classification engine, evidence gates, and multi-platform support. It works. But it has rough edges that prevent adoption:

- **Stale identity:** 11+ files still link to `rahulsc/superpowers`; plugin manifests point to the wrong repo
- **No onboarding path:** A new user who installs Forge has no idea what to do next
- **Agent roster gaps:** `composing-teams` references agent roles (frontend-engineer, backend-engineer) that don't exist as definitions
- **README is a feature list, not a usage guide:** 21 skills are listed but never shown working together
- **Ideation gaps:** The v1 ideation doc proposed 8 outcome-level workflows, operating modes, intelligent adoption — most are unbuilt

The Beta (v0.5.0) should make Forge **adoptable by someone who isn't its author**. That means: clean identity, clear docs, sufficient agents, and a working "first 10 minutes" experience.

### Beta Exit Criteria

A user who has never seen Forge can:
1. Install it (any supported platform)
2. Understand what it does from the README alone
3. Run `forge adopt` on an existing repo and get a working `.forge/` setup
4. Complete a feature (brainstorm → plan → execute → verify) without reading skill source code
5. Understand the skill flow from a visual diagram in the README

---

## 2. Current State Assessment

### What's Working

| Area | Status | Notes |
|------|--------|-------|
| 21 skills | Functional | Full lifecycle coverage |
| Risk classification | Functional | 4-tier policy engine with file glob matching |
| Evidence gates | Functional | `forge-evidence` CLI, verification skill |
| Multi-agent teams | Functional | composing-teams + agent-team-driven-development |
| Pack protocol | Functional | Install/remove/list with hello-world example |
| Multi-platform install | Functional | Claude Code, Cursor, Codex, OpenCode, Gemini CLI |
| Hooks | Functional | Session start, task completion, pre-commit gate, evidence gate |
| Persistent state | Functional | SQLite + JSON backends |

### What's Broken or Missing

| Area | Status | Impact |
|------|--------|--------|
| Identity cleanup | 11 must-fix files | Plugin manifests link to wrong repo |
| README | No usage guide | New users bounce |
| Getting Started | Non-existent | No path from install → first workflow |
| Agent roster | 5 agents, 3+ referenced but undefined | composing-teams can't dispatch what it promises |
| Skill flow visualization | None | Users can't see how skills compose |
| Outcome workflows | Not surfaced | 21 skills overwhelm; 8 user-facing workflows hidden |
| Adoption intelligence | Skeleton only | project.yaml fields are blank templates |
| Cost/token tracking | Not implemented | No way to measure agent efficiency |
| Plan status tracking | Stale | Both completed plans still marked "pending" |
| Architecture.md | Template only | Not filled in for Forge itself |

---

## 3. Competitive Landscape

### Direct Competitors (Structured Workflow Systems)

| Project | Stars | Key Strength | Key Weakness vs Forge |
|---------|-------|-------------|----------------------|
| **obra/superpowers** | 82,000 | Community momentum, multi-platform | No enforcement gates, no evidence model, no risk tiers, no multi-agent teams, bus factor = 1 |
| **GitHub Spec Kit** | 76,600 | GitHub backing, 20+ agent support, Constitution concept | Specs are advisory (no enforcement), no post-implementation gates, brownfield adoption pain |
| **Gastown** (Yegge) | 12,000 | 20-30+ agent scale, persistent agent identity, OpenTelemetry | Heavy infra (Go+Dolt+Beads+tmux), documented fragility, metaphor overload |
| **GNAP** | 14 | Elegant git-native protocol, zero infrastructure | Specification only (no tooling), 1 day old, no workflow intelligence |

### AI Coding Agents (General Purpose)

| Project | Stars | Key Strength | Key Weakness vs Forge |
|---------|-------|-------------|----------------------|
| **Claude Code** | 77,600 | First-party Anthropic, hooks, experimental teams | No structured workflow, no risk-scaled ceremony |
| **OpenHands** | 69,100 | SWEBench 77.6%, composable SDK, cloud scaling | No workflow phases, no enforcement |
| **Codex CLI** | 65,100 | Kernel sandboxing, AGENTS.md standard | No phases, no enforcement, no evidence model |
| **Cline** | 59,000 | VS Code native, browser automation, enterprise SSO | No structured workflow, no TDD enforcement |
| **Aider** | 41,900 | Semantic repo mapping, 100+ languages, 5.3M installs | No phases, no enforcement, pair programmer not workflow |
| **Goose** | 33,000 | Rust performance, MCP-native, desktop app | No structured phases, no TDD, no evidence |
| **Plandex** | 15,100 | Cumulative diff sandbox, version branching | Self-host only, no multi-agent, no enforcement |

### Forge's Unique Position

**What no other tool combines:**
- Structured phases WITH enforcement gates
- Risk-scaled ceremony (4 tiers) — nobody else offers this
- Evidence-gated completion — no competitor requires structured evidence
- Multi-agent teams WITH structured SDLC workflow
- Pipelined TDD as part of the development workflow
- Pack protocol for distributing workflow bundles

**Forge's primary risks:**
- Zero community (vs 82k upstream, 77k Claude Code)
- No IDE integration (terminal-only via host platforms)
- No benchmarking story
- No browser automation
- No semantic repo mapping
- The instruction-following problem: prompt-based gates get ignored by LLMs

### What People Want (Cross-Competitor Issue Analysis)

From analyzing 10,000+ issues across all projects, the most requested capabilities:

| Request Category | Frequency | Forge Status |
|-----------------|-----------|-------------|
| More LLM provider support | #1 everywhere | N/A (platform-agnostic) |
| Usage limits / cost visibility | #2 (Claude Code 5k+ issues) | **Not built** |
| Instruction-following reliability | #3 (superpowers #696, #463, #485) | Partial (enforcement gates help) |
| Cross-session persistence | #4 | **Built** (forge-state) |
| Windows/Linux compatibility | #5 | Platform-dependent |
| Better onboarding / getting started | #6 | **Not built** |
| Multi-agent coordination | #7 (superpowers #429: 88 reactions) | **Built** |
| Review burden reduction | #8 | **Built** (two-stage review) |
| Brownfield adoption | #9 (Spec Kit #164, #1436) | **Partially built** |
| CI/CD integration | #10 | **Not built** |

### Ideas Worth Borrowing

| Source | Idea | Application to Forge |
|--------|------|---------------------|
| GNAP | Cost/token tracking per execution run | Add to evidence model |
| GNAP | Git-native audit trail (commit conventions) | Consider for evidence persistence |
| GNAP | Human-AI parity in team protocol | Humans as team members, not just approvers |
| Spec Kit | Constitution (immutable project principles) | Forge already has `.forge/shared/conventions.md` — promote it |
| Gastown | Persistent agent identity across crashes | Useful for long-running team sessions |
| Gastown | OpenTelemetry observability | Lightweight version for Forge |
| Cline | Workspace checkpoints/snapshots | Could complement worktree isolation |
| Aider | Semantic repo mapping | Context optimization for large codebases |
| Codex CLI | AGENTS.md as emerging standard | Consider generating AGENTS.md for interop |

---

## 4. Beta Goals & Non-Goals

### Goals (v0.5.0)

1. **Clean identity** — Zero stale superpowers references in user-facing files
2. **Adoptable README** — Usage guide, skill flow diagram, comparison chart, getting started
3. **Sufficient agent roster** — All agent roles referenced by skills actually exist
4. **Working adoption flow** — `forge:adopting-forge` produces a usable `.forge/` setup with intelligent defaults
5. **Outcome-level workflows** — Document the 8 user-facing workflows, not just 21 skills
6. **Cost/token tracking** — Basic observability for agent execution
7. **Audit mode** — Deep action tracing that any project can enable for self-analysis
8. **Self-improvement loop** — Analysis skill + 6 reference projects + run-over-run comparison
9. **Full auto mode** — Permission manifests enable unattended workflow execution
10. **Dogfood-validated** — Forge Beta was built using Forge; all deviations logged and resolved

### Non-Goals (defer to v1.0)

- IDE integration (VS Code extension, JetBrains plugin)
- SWEBench or other benchmarking
- Browser automation
- Semantic repo mapping
- Operating modes (ephemeral/project/adopted)
- Pack registry or remote pack distribution
- CI/CD pipeline integration
- AGENTS.md generation
- Cross-platform agent interop protocol

---

## 5. Work Stream 1: Housekeeping & Cleanup

### 5.1 Identity Cleanup

All references to `rahulsc/superpowers` in user-facing files must point to the canonical Forge repository.

**Must Fix (11 items):**

| File | Lines | Issue |
|------|-------|-------|
| `.claude-plugin/plugin.json` | 8-9 | homepage + repository URLs |
| `.cursor-plugin/plugin.json` | 9-10 | homepage + repository URLs |
| `README.md` | 95, 105, 113, 224, 251 | Install URLs, fork link, issues link |
| `.codex/INSTALL.md` | 13, 125-126 | Clone URL, issues link, docs link |
| `.opencode/INSTALL.md` | 13, 118-119 | Clone URL, issues link, docs link |
| `docs/README.codex.md` | 10, 24, 125-126 | Install URLs, clone URL, issues/docs links |
| `docs/README.opencode.md` | 10, 27, 69 | Clone URLs |
| `skills/brainstorming/scripts/frame-template.html` | 199 | Brainstorming companion link |
| `.github/workflows/test.yml.disabled` | 1, 55 | Workflow name "Superpowers Tests", path |
| `tests/integration/no-superpowers-references.sh` | 15 | Hardcoded WORKTREE path to non-existent directory |
| `tests/explicit-skill-requests/prompts/use-superpowers-direct.txt` | 1 | References obsolete skill name |

**Keep As-Is (legitimate attribution):**
- `NOTICE.md`, `ORIGINS.md`, `LICENSE`, `RELEASE-NOTES.md`
- `docs/plans/forge-v0/` and `docs/plans/forge-clean-break/` (historical)
- `docs/forge_ideation_v1.md` (ideation context)

### 5.2 Plan Status Updates

| Plan | Current Status | Correct Status |
|------|---------------|----------------|
| `docs/plans/forge-v0/plan.md` | pending | completed |
| `docs/plans/forge-clean-break/plan.md` | pending | completed |

### 5.3 Architecture Self-Documentation

Fill in `.forge/shared/architecture.md` with Forge's own architecture (currently a blank template). Forge should describe itself.

---

## 6. Work Stream 2: README & Documentation Overhaul

### 6.1 README Restructure

The current README is 251 lines listing features. The Beta README should be structured for adoption:

**Proposed structure:**

```
# Forge

One-paragraph pitch

## What Makes Forge Different (comparison chart — see §12)

## Quick Start (3 steps: install → adopt → first workflow)

## How It Works
  - Skill Flow Diagram (metro map — see §6.3)
  - The 8 Workflows (outcome-level, not 21 skills)
  - Risk-Scaled Ceremony (visual: minimal → standard → elevated → critical)

## Installation (per platform — collapsed/tabbed)

## The 8 Workflows
  1. Start a feature
  2. Fix a bug
  3. Refactor safely
  4. Review a change
  5. Resume work (cold start)
  6. Prepare a release
  7. Adopt a repo
  8. Investigate an incident

## Infrastructure (.forge/ directory — brief)

## Agent Roster (table with roles)

## Extending Forge
  - Writing skills
  - Creating packs
  - Adding agents

## Philosophy

## Attribution & Origins
```

### 6.2 The 8 Outcome Workflows

Each workflow maps to a skill pipeline. Users think in outcomes, not skills:

| Workflow | User Says | Skill Pipeline |
|----------|-----------|---------------|
| **Start a feature** | "Add X", "Build Y" | `forge-routing` → `brainstorming` → `setting-up-project` → `writing-plans` → `subagent-driven-development` or `agent-team-driven-development` → `verification-before-completion` → `requesting-code-review` → `finishing-a-development-branch` |
| **Fix a bug** | "X is broken", "Fix Y" | `forge-routing` → `systematic-debugging` → (optional: `writing-plans`) → `test-driven-development` → `verification-before-completion` |
| **Refactor safely** | "Refactor X", "Clean up Y" | `forge-routing` → `brainstorming` → `writing-plans` → `test-driven-development` → `verification-before-completion` → `requesting-code-review` |
| **Review a change** | "Review PR #N" | `forge-routing` → `requesting-code-review` or `receiving-code-review` |
| **Resume work** | (session start) | `forge-session-start` hook → `forge-state` restoration → resume at last skill |
| **Prepare a release** | "Ship it", "Cut a release" | `verification-before-completion` → `finishing-a-development-branch` |
| **Adopt a repo** | "Set up Forge here" | `forge-routing` → `adopting-forge` → `syncing-forge` |
| **Investigate an incident** | "Why is X failing?" | `forge-routing` → `systematic-debugging` |

### 6.3 Skill Flow Diagram (Metro Map)

A visual metro map showing how skills compose into pipelines. Each "line" is a workflow, each "station" is a skill. Transfer stations show where workflows share skills.

**Proposed format:** Mermaid diagram embedded in README (GitHub renders natively).

```
Design Line:    brainstorming ── setting-up-project ── writing-plans ─┐
                                                                      │
Execute Line:                         ┌── test-driven-development ────┤
                                      │                               │
                subagent-driven-dev ──┤── agent-team-driven-dev ──────┤
                                      │                               │
                                      └── validating-wave-compliance ─┤
                                                                      │
Verify Line:    verification-before-completion ── requesting-code-review ── finishing-branch
                                                                      │
Debug Line:     systematic-debugging ─────────────────────────────────┘

Meta Line:      forge-routing ── adopting-forge ── syncing-forge ── diagnosing-forge

Extend Line:    writing-skills ── forge-packs ── composing-teams
```

**Implementation:** Mermaid flowchart with color-coded lines, rendered as SVG for non-GitHub contexts.

### 6.4 Comparison Chart

A feature comparison table in the README (inspired by GNAP's approach but with credible, verifiable claims):

| Feature | Forge | Superpowers | Spec Kit | Gastown | Claude Code | Aider | Cline |
|---------|:-----:|:-----------:|:--------:|:-------:|:-----------:|:-----:|:-----:|
| Structured workflow phases | 6 phases | 7 phases | 5 phases | 3 phases | - | - | - |
| Enforcement gates | Evidence-gated | - | - | Partial | Hooks only | - | Approval |
| Risk-scaled ceremony | 4 tiers | - | - | - | - | - | - |
| Multi-agent teams | Persistent | - | - | 20-30+ | Experimental | - | - |
| TDD enforcement | RED/GREEN/REFACTOR | Prompt-only | - | - | - | Lint/test | - |
| Persistent state | SQLite/JSON | - | - | Dolt+Git | Task list | - | Checkpoints |
| Extensibility | Packs | - | - | Formulas | Plugins | - | MCP |
| Platform support | 5 platforms | 5 platforms | 20+ agents | Multi-runtime | Terminal+IDE | Terminal+IDE | VS Code |

---

## 7. Work Stream 3: Agent Roster Expansion

### 7.1 Current State

5 agents defined: architect, implementer, qa-engineer, code-reviewer, security-reviewer.

**Critical gap:** `composing-teams` and `agent-team-driven-development` reference specialist roles (frontend-engineer, backend-engineer) that have no agent definitions. Users can name these roles but the system can't dispatch agents for them.

### 7.2 New Agent Definitions

#### Priority 1: Required by Existing Skills

| Agent | Justification | Referenced By |
|-------|--------------|---------------|
| **frontend-engineer** | `composing-teams` lists as example team member; modern projects split FE/BE | composing-teams, agent-team-driven-development |
| **backend-engineer** | `composing-teams` lists as example team member | composing-teams, agent-team-driven-development |
| **database-specialist** | `adopting-forge` flags `db/migrations/` as CRITICAL risk; no agent can review migration evidence | adopting-forge, risk classification |

#### Priority 2: Needed for Workflow Completeness

| Agent | Justification | Use Case |
|-------|--------------|----------|
| **devops-engineer** | `adopting-forge` detects `.github/workflows/` but no agent reviews CI/CD; infrastructure code at elevated/critical risk gets no specialist review | CI/CD, deployment, infrastructure |
| **technical-writer** | Design docs, API docs, user guides are authored frequently; no quality gate for documentation | brainstorming (design review), writing-plans |

#### Priority 3: Defer to v1.0

| Agent | Justification |
|-------|--------------|
| **performance-engineer** | Useful for elevated/critical perf-critical tasks but not referenced by any skill |
| **data-engineer** | ETL/pipeline specialist; too niche for Beta |

### 7.3 Agent Definition Template

Each new agent follows the existing pattern:

```markdown
---
description: [Role description]. Use for [primary use cases].
model: opus
tools: [tool list]
---

[System prompt defining role, responsibilities, quality standards]
```

**Design decision:** All agents use `model: opus` for now. Cost optimization (using sonnet/haiku for focused tasks) is a v1.0 concern.

---

## 8. Work Stream 4: Workflow Gaps & Feature Parity

### 8.1 Ideation Features Not Yet Built

The v1 ideation document proposed features that remain unbuilt. The Beta should close the most impactful gaps:

| Feature | Ideation Vision | Beta Target |
|---------|----------------|-------------|
| **Intelligent adoption** | Repo inference with confidence levels, checkpoint/resume | Basic inference: detect package manager, test runner, linter, CI config. No confidence levels. |
| **Generated CLAUDE.md** | Auto-generated from canonical model | Generate `CLAUDE.md` during `forge:adopting-forge` with project-specific commands |
| **Outcome workflows** | 8 user-facing workflows as primary UX | Document all 8 in README; ensure forge-routing maps intents correctly |
| **Operating modes** | Ephemeral / Project / Adopted | Defer to v1.0 — Beta is "adopted" mode only |

### 8.2 Skill Routing Improvements

`forge-routing` currently routes by intent keywords. The Beta should:

1. **Validate all 8 outcomes route correctly** — test with prompt fixtures
2. **Add "resume work" routing** — detect when a session starts with existing forge-state
3. **Add "prepare release" routing** — currently no explicit route for release workflows
4. **Improve routing confidence** — when intent is ambiguous, ask the user instead of guessing

### 8.3 Adoption Flow Improvements

`forge:adopting-forge` should produce a *working* `.forge/` setup, not a blank template:

1. **Detect package manager** — npm/yarn/pnpm (package.json), pip/poetry/uv (pyproject.toml, requirements.txt), cargo (Cargo.toml), go (go.mod)
2. **Detect test runner** — from package.json scripts, Makefile targets, CI config
3. **Detect linter** — from config files (.eslintrc, ruff.toml, .golangci.yml)
4. **Pre-populate project.yaml** — fill in name, stack, test/lint commands
5. **Generate initial risk policy** — based on detected file patterns (e.g., if `db/migrations/` exists, add critical tier)
6. **Generate platform adapter** — CLAUDE.md with project-specific content

### 8.4 Forge Self-Documentation

Forge should use itself. The Beta should include:

1. **Filled-in `.forge/shared/architecture.md`** — Forge's own architecture
2. **Filled-in `.forge/shared/conventions.md`** — Forge's coding conventions
3. **At least one ADR** in `.forge/shared/decisions/` — documenting a real decision

---

## 9. Work Stream 5: Adoption & Onboarding Experience

### 9.1 Getting Started Guide

**Goal:** A new user goes from zero to completing their first Forge workflow in under 10 minutes.

**Proposed flow:**

```
1. Install Forge (platform-specific, already documented)
2. Navigate to your project: cd my-project
3. Say: "Set up Forge in this project"
   → forge:adopting-forge runs, creates .forge/, populates project.yaml
4. Say: "Add a health check endpoint"
   → forge:brainstorming → forge:writing-plans → implementation
5. Observe: risk classification, evidence collection, verification gate
```

This should be a concrete walkthrough in the README with expected outputs at each step.

### 9.2 Verify Installation

The current "verify installation" guidance is vague ("ask for something that should trigger a skill"). The Beta should provide:

1. **A specific test prompt** users can paste to verify skills are loading
2. **Expected output** showing the skill activated
3. **Troubleshooting** for common failures (hooks not loading, plugin not detected)

### 9.3 FAQ / Troubleshooting

Common questions derived from competitor issue analysis:

| Question | Answer |
|----------|--------|
| What if a skill doesn't activate? | Check `forge:diagnosing-forge`, verify hooks loaded |
| How do I change the risk tier for a file? | Edit `.forge/policies/default.yaml` |
| Can I use Forge with a different LLM? | Forge is platform-agnostic; it works with whatever your host supports |
| How do I skip a workflow step? | Risk tier determines required steps; lower the tier for less ceremony |
| How do I resume after a crash? | Session start hook restores state; say "where was I?" |

---

## 10. Work Stream 6: Observability & Cost Tracking

### 10.1 Motivation

Cost/token tracking is the #2 most-requested feature across competitors (Claude Code has 5k+ issues about usage/costs). GNAP's `runs/` entity with `input_tokens`, `output_tokens`, `cost_usd` is a clean model.

### 10.2 Beta Scope

**Minimal viable observability:**

1. **Track tokens per skill invocation** — log to forge-evidence when a skill completes
2. **Track execution duration** — wall clock time per skill
3. **Surface in verification** — `verification-before-completion` reports total cost of the current task

**Implementation:** Extend `forge-evidence` to accept a `cost` evidence type:

```bash
forge-evidence record cost \
  --skill brainstorming \
  --tokens-in 12000 \
  --tokens-out 4500 \
  --duration-ms 45000
```

**Not in Beta scope:** Per-model cost calculation, historical cost dashboards, budget caps.

### 10.3 Token Tracking Integration Points

| Hook/Skill | What to Track |
|------------|--------------|
| `forge-session-start` | Session start timestamp |
| `forge-task-completed` | Task duration, token estimate |
| `verification-before-completion` | Total accumulated cost for current task |
| `forge-viz` | Display cost data in dashboard |

---

## 11. Work Stream 7: MVP Deviation Audit

### 11.1 Motivation

Forge Beta is being built using Forge MVP. This is deliberate dogfooding — and the most valuable output isn't just the Beta itself, but a record of every place the MVP's skills, workflows, and conventions deviated from expectations during real use.

Without tracking deviations as they happen, we lose the signal. Post-hoc analysis misses the small frustrations that compound into adoption blockers.

### 11.2 What to Track

Every time a Forge skill or workflow doesn't behave as expected, log the deviation:

| Field | Description |
|-------|-------------|
| **Skill** | Which skill misbehaved |
| **Expected** | What should have happened |
| **Actual** | What actually happened |
| **Severity** | blocker / friction / cosmetic |
| **Fix target** | Beta (fix before shipping) or v1.0 (defer) |

### 11.3 Deviation Log (Running)

This log is maintained throughout Beta development and analyzed at the end.

| # | Skill | Expected | Actual | Severity | Fix Target |
|---|-------|----------|--------|----------|------------|
| 1 | `brainstorming` | Design doc written to `docs/<project>/design/design.md` | Skill hardcodes `docs/plans/<project>/design.md` — wrong directory structure | friction | Beta |

### 11.4 End-of-Beta Analysis

Before declaring Beta complete:

1. **Collect** all deviations logged during development
2. **Categorize** by root cause (skill bug, missing convention, unclear instruction, LLM non-compliance)
3. **Fix** all blocker and friction items
4. **Document** patterns for skill authors (what kinds of instructions LLMs ignore, what phrasing works)
5. **Update** affected skills with fixes
6. **Verify** fixes with targeted tests

This analysis is a gate — Beta is not done until the deviation log is processed.

---

## 12. Work Stream 8: Dogfooding Framework

### 12.1 Motivation

Building Forge with Forge is necessary but not sufficient. A single project (Forge itself) doesn't exercise enough of the workflow surface area to catch problems. Frontend skills, database migrations, infrastructure concerns, security review — these paths go untested if we only build a shell-based skill framework.

We need:
- **Audit mode** — a deep, machine-readable trail of every action Forge takes, analyzable by Forge itself
- **A self-improvement skill** — analyzes audit trails and produces actionable improvement recommendations
- **Reference projects** — a fixed set of projects that exercise the full breadth of Forge workflows, run every iteration
- **Full auto mode** — unattended execution with pre-approved permissions, so reference project runs don't require a human pressing "yes" 500 times
- **Run-over-run comparison** — did we do better or worse than last time?

This is how Forge becomes self-improving rather than manually tuned.

### 12.2 Audit Mode

A project-level flag that enables deep action tracing. Any project can opt in.

**What gets recorded (per action):**

| Field | Description |
|-------|-------------|
| `timestamp` | ISO 8601 |
| `session_id` | Unique session identifier |
| `skill` | Active skill at time of action |
| `action_type` | `tool_call`, `skill_transition`, `gate_check`, `user_prompt`, `agent_dispatch`, `approval_request` |
| `action_detail` | Tool name + parameters, skill name, gate result, etc. |
| `outcome` | `success`, `failure`, `skipped`, `user_denied` |
| `tokens_in` | Input tokens consumed |
| `tokens_out` | Output tokens produced |
| `duration_ms` | Wall clock time |
| `deviation` | If this action deviated from expected behavior (null if normal) |
| `context` | Current risk tier, workflow phase, agent role |

**Storage:** JSONL file at `.forge/local/audit/<session-id>.jsonl`. One line per action. Machine-readable, append-only.

**Enablement:**
```yaml
# .forge/project.yaml
audit:
  enabled: true
  retention: 30  # days, 0 = forever
```

**Implementation:** Extend hooks to emit audit events:
- `forge-session-start` → emit session start event
- `forge-gate` → emit gate check events (pass/fail/skip)
- `forge-task-completed` → emit task completion with token/duration summary
- New `forge-audit` hook on `PreToolUse` / `PostToolUse` → emit tool call events

### 12.3 Self-Improvement Skill: `forge:analyzing-audit`

A new skill that reads audit trails and produces improvement recommendations.

**Inputs:**
- One or more audit JSONL files
- Optional: previous analysis results (for trend comparison)

**Analysis dimensions:**

| Dimension | What It Measures | Example Finding |
|-----------|-----------------|-----------------|
| **Workflow compliance** | Did skills execute in expected order? Were gates respected? | "brainstorming was skipped in 3/5 runs — routing didn't trigger" |
| **Permission friction** | How many approval requests were made? How many were redundant? | "42 approval requests, 38 were `git commit` — should be pre-approved" |
| **Token efficiency** | Token cost per workflow phase, per skill, per project | "brainstorming consumed 45% of total tokens — consider shorter design docs" |
| **Deviation patterns** | Recurring deviation types across runs | "LLM skips verification-before-completion 60% of the time" |
| **Duration analysis** | Time per phase, time waiting for approvals vs working | "70% of wall clock time was waiting for user approval" |
| **Agent utilization** | In multi-agent runs, which agents were underused? | "security-reviewer was dispatched but returned trivial findings in 4/5 runs" |
| **Skill effectiveness** | Did skill invocations produce the expected artifacts? | "writing-plans produced a plan in 5/5 runs but 2 plans had no wave analysis" |
| **Regression detection** | Did metrics get worse compared to previous runs? | "Token cost for 'start a feature' workflow increased 30% since last run" |

**Outputs:**
- `docs/<project>/audit/analysis-<date>.md` — human-readable report
- `.forge/local/audit/metrics.jsonl` — machine-readable metrics for trend tracking
- List of recommended skill/workflow changes with priority

### 12.4 Reference Projects

A fixed set of projects that exercise the full breadth of Forge workflows. Each project is designed to hit specific workflow paths, risk tiers, and agent specializations.

**Selection criteria:**
- Together, the projects must cover all 8 outcome workflows
- Each risk tier (minimal → critical) must be exercised
- Each agent role (including new Beta agents) must be dispatched at least once
- Projects should be small enough to complete in a single session (~30-60 min each in full auto)
- Projects must be reproducible — same spec should produce comparable results across runs

**The Reference Project Suite:**

| # | Project | Type | Key Workflows Exercised | Risk Tiers Hit | Agents Required |
|---|---------|------|------------------------|----------------|-----------------|
| 1 | **Task Tracker API** | Backend (Node.js/Python) | Start feature, fix bug, refactor | standard, elevated (auth) | backend-engineer, qa-engineer, security-reviewer |
| 2 | **Dashboard UI** | Frontend (React/Vue) | Start feature, review change | minimal, standard | frontend-engineer, qa-engineer, code-reviewer |
| 3 | **CLI Migration Tool** | CLI + Database | Start feature, fix bug | elevated (migrations), critical (data) | database-specialist, implementer, qa-engineer |
| 4 | **Deploy Pipeline** | Infrastructure (Docker + CI/CD) | Start feature, investigate incident | elevated (infra), critical (secrets) | devops-engineer, security-reviewer, architect |
| 5 | **Auth Service** | Security-Critical Backend | Start feature, refactor safely | critical (auth, tokens, encryption) | security-reviewer, backend-engineer, architect, qa-engineer |
| 6 | **Full-Stack Notes App** | End-to-End (FE + BE + DB + Deploy) | All 8 workflows | all 4 tiers | all agents |

**Coverage matrix:**

| Workflow | P1 | P2 | P3 | P4 | P5 | P6 |
|----------|:--:|:--:|:--:|:--:|:--:|:--:|
| Start a feature | x | x | x | x | x | x |
| Fix a bug | x | | x | | | x |
| Refactor safely | x | | | | x | x |
| Review a change | | x | | | | x |
| Resume work | | | | | | x |
| Prepare a release | | | | | | x |
| Adopt a repo | x | x | x | x | x | x |
| Investigate incident | | | | x | | x |

| Risk Tier | P1 | P2 | P3 | P4 | P5 | P6 |
|-----------|:--:|:--:|:--:|:--:|:--:|:--:|
| minimal | | x | | | | x |
| standard | x | x | | | | x |
| elevated | x | | x | x | | x |
| critical | | | x | x | x | x |

Each reference project ships as a spec document in `docs/forge-beta/reference-projects/`. The spec defines the starting state (empty repo or provided skeleton), the feature requests to implement, and the expected workflow path. The projects themselves are built in temporary directories, not in the Forge repo.

### 12.5 Full Auto Mode

Unattended execution with pre-approved permissions. Critical for running reference projects without human babysitting.

**Permission manifest:** During brainstorming, Forge builds a list of permissions the workflow will need and requests them upfront:

```yaml
# Generated during brainstorming, approved by user once
permissions:
  file_operations:
    - create_files: true
    - edit_files: true
    - delete_files: false  # still requires approval
  git_operations:
    - commit: true
    - create_branch: true
    - push: false  # still requires approval
  shell_commands:
    - allow_patterns:
      - "npm install*"
      - "npm test*"
      - "npm run lint*"
      - "pytest*"
      - "cargo test*"
      - "go test*"
    - deny_patterns:
      - "rm -rf*"
      - "sudo*"
  agent_operations:
    - spawn_agents: true
    - replicate_permissions: true  # agents inherit the same permission set
```

**How it works:**

1. **Brainstorming generates permission manifest** — based on detected stack, planned operations, and risk tier
2. **User reviews and approves once** — "These are the permissions for this workflow. Approve? [y/n]"
3. **Forge stores approved manifest** in `.forge/local/permissions/<session-id>.yaml`
4. **Pre-commit gate and forge-gate consult the manifest** — if the action matches an approved pattern, auto-approve
5. **Unapproved actions still prompt** — safety net for unexpected operations
6. **Agents inherit permissions** — when dispatching subagents or team members, the permission manifest is forwarded

**Auto mode activation:**
```
User: "Run in full auto mode"
→ forge-routing detects auto mode intent
→ brainstorming includes permission manifest generation
→ user approves manifest once
→ all subsequent steps auto-approve matching actions
```

**For reference project runs:**
Each reference project spec includes a pre-built permission manifest. Running the suite is:
```bash
forge-run-suite --auto --projects all
# or
forge-run-suite --auto --projects "task-tracker,dashboard-ui"
```

### 12.6 Run-Over-Run Comparison

Each reference project run produces an audit trail. The self-improvement skill compares runs:

**Metrics tracked per run:**

| Metric | Description |
|--------|-------------|
| `total_tokens` | Total tokens consumed (in + out) |
| `total_duration_ms` | Wall clock time |
| `approval_count` | Number of user approval requests |
| `gate_pass_rate` | % of gates passed on first attempt |
| `deviation_count` | Number of logged deviations |
| `skill_compliance` | % of expected skills that actually ran |
| `agent_utilization` | % of dispatched agents that produced meaningful output |
| `test_pass_rate` | % of tests passing at verification |

**Comparison output:**

```
Run Comparison: Task Tracker API
================================
                    Run #3 (2026-03-15)    Run #2 (2026-03-10)    Delta
total_tokens        45,200                 52,100                 -13.2% (better)
total_duration      12m 30s                18m 45s                -33.3% (better)
approval_count      3                      42                     -92.9% (better)
gate_pass_rate      100%                   80%                    +20.0% (better)
deviation_count     1                      4                      -75.0% (better)
skill_compliance    100%                   85%                    +15.0% (better)
```

**Stored at:** `.forge/local/audit/runs/<project>/<run-id>.json`

### 12.7 What Else This Enables

Beyond the core dogfooding loop, this framework opens several doors:

**Community audit submission:** Users can opt in to submitting anonymized audit logs for their own projects. This builds a dataset of real-world Forge usage patterns without requiring us to anticipate every use case. Not in Beta scope to build the submission pipeline, but the audit format should be designed with this in mind.

**Skill authoring feedback loop:** When `forge:writing-skills` creates a new skill, the audit trail from the first few uses reveals whether the skill is actually invoked correctly, whether LLMs follow its instructions, and where they deviate. This closes the loop between "skill was written" and "skill actually works."

**Regression CI:** Once the reference project suite is stable, it can run in CI on every Forge commit. A PR that causes a reference project to regress (more tokens, more deviations, lower gate pass rate) gets flagged automatically. Not Beta scope for CI integration, but the audit format and comparison tooling should support it.

**Cost budgeting:** Audit data provides real per-workflow cost baselines. Future versions can set budget caps ("this workflow should cost < $2 in tokens") and alert when exceeded.

---

## 13. v1.0 Horizon (Out of Scope for Beta)

These are important but deliberately deferred:

| Feature | Why Defer | Dependency |
|---------|-----------|-----------|
| **Operating modes** (ephemeral/project/adopted) | Requires routing rework; Beta is "adopted" only | Adoption flow stability |
| **Pack registry** | Need real packs first; Beta ships the protocol | Community growth |
| **IDE integration** (VS Code, JetBrains) | Platform-dependent; large scope | Platform SDK maturity |
| **SWEBench benchmarking** | Requires test harness; measures the wrong thing for workflow tools | Benchmark design |
| **Browser automation** | Platform-dependent (Cline, OpenHands have this) | MCP or platform integration |
| **Semantic repo mapping** | Aider's differentiator; large scope | Research |
| **AGENTS.md generation** | Emerging standard (Codex CLI); wait for stabilization | Standard maturity |
| **CI/CD integration** | Continue.dev approach; requires pipeline tooling | DevOps agent + pipeline design |
| **Cross-platform interop** (GNAP-style) | Interesting but premature; wait for GNAP to mature | Protocol stabilization |
| **Persistent agent identity** | Gastown's approach; useful for long-running teams | Team execution maturity |
| **Per-model cost optimization** | Use sonnet/haiku for focused tasks | Cost tracking data |
| **Confidence levels on inference** | Ideation proposed; needs UX design | Adoption flow maturity |
| **Budget caps** | Set per-workflow token/cost limits with alerts when exceeded | Audit mode cost data from Beta |

---

## 14. Comparison Chart

To be included in the Beta README. Based on verifiable claims only.

### Forge vs. The Field

| Capability | Forge | obra/superpowers | GitHub Spec Kit | Gastown | Claude Code | Aider | Cline | OpenHands |
|-----------|:-----:|:----------------:|:---------------:|:-------:|:-----------:|:-----:|:-----:|:---------:|
| **Structured development phases** | 6 | 7 | 5 | 3 | — | — | — | — |
| **Enforcement gates** | Evidence-gated | — | — | Partial | Hooks | — | Approval | — |
| **Risk-scaled ceremony** | 4 tiers | — | — | — | — | — | — | — |
| **Multi-agent teams** | Persistent specialists | — | — | 20-30+ agents | Experimental | — | — | SDK-level |
| **TDD enforcement** | RED/GREEN/REFACTOR | Prompt-only | — | — | — | Lint/test | — | — |
| **Evidence collection** | Structured (cmd, cite, diff) | — | — | Implicit | — | Auto-commit | — | — |
| **Persistent state** | SQLite + JSON | — | — | Dolt + Git | Task list | — | Checkpoints | Sessions |
| **Extensibility model** | Pack protocol | — | — | Formulas | Plugins | — | MCP servers | Python SDK |
| **Intent-based routing** | Automatic | — | Slash commands | Mayor agent | — | — | — | — |
| **Verification wiring** | Connected | Orphaned | — | Fragile | — | — | — | — |
| **Cost tracking** | Beta | — | — | — | — | — | — | — |
| **Platform support** | 5 platforms | 5 platforms | 20+ agents | Multi-runtime | Terminal | Terminal + IDE | VS Code | CLI + GUI + Cloud |
| **Semantic repo mapping** | — | — | — | — | — | Full | Context cmds | RepoMap |
| **Browser automation** | — | — | — | — | — | — | Full | Full |
| **Benchmarking (SWEBench)** | — | — | — | — | — | Leaderboard | — | 77.6% |

---

## 15. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| **LLM ignores skill instructions** | High | Critical | Enforcement gates catch skipped steps; can't fully solve at prompt level |
| **README rewrite breaks install docs** | Medium | High | Test all install paths after rewrite |
| **New agents are too generic** | Medium | Medium | Define with specific workflow references; review against composing-teams |
| **Adoption inference is wrong** | Medium | Medium | Conservative defaults; always ask user to confirm |
| **Cost tracking adds overhead** | Low | Low | Make tracking opt-in; lightweight logging only |
| **Scope creep into v1.0 features** | High | Medium | This doc is the boundary; review against non-goals before each task |
| **Breaking changes to skill contracts** | Low | High | Skills are prompt-only; no API to break |
| **GitHub repo not yet created** | High | Critical | Must decide canonical repo URL before fixing references |
| **Reference projects too slow** | Medium | Medium | Keep projects small (~30 min each); parallelize with auto mode |
| **Audit overhead degrades performance** | Low | Medium | JSONL append is cheap; audit is opt-in; no synchronous processing |
| **Full auto mode enables unsafe actions** | Medium | High | Permission manifest is explicit; deny-by-default for destructive ops; agents inherit same constraints |
| **Self-improvement skill produces noise** | Medium | Low | Human reviews recommendations; skill suggests, doesn't auto-apply |

---

## Appendix A: Full Audit Findings

### Must Fix (User-Facing)

1. **`.claude-plugin/plugin.json:8-9`** — homepage/repository → `rahulsc/superpowers`
2. **`.cursor-plugin/plugin.json:9-10`** — homepage/repository → `rahulsc/superpowers`
3. **`README.md:95`** — Codex install URL → `rahulsc/superpowers`
4. **`README.md:105`** — OpenCode install URL → `rahulsc/superpowers`
5. **`README.md:113`** — Gemini install URL → `rahulsc/superpowers`
6. **`README.md:224`** — Fork link → `rahulsc/superpowers`
7. **`README.md:251`** — Issues link → `rahulsc/superpowers`
8. **`.codex/INSTALL.md:13,125-126`** — Clone URL, issues/docs links
9. **`.opencode/INSTALL.md:13,118-119`** — Clone URL, issues/docs links
10. **`docs/README.codex.md:10,24,125-126`** — Install URLs, clone URL, links
11. **`docs/README.opencode.md:10,27,69`** — Clone URLs
12. **`skills/brainstorming/scripts/frame-template.html:199`** — Companion link
13. **`.github/workflows/test.yml.disabled:1,55`** — Workflow name, test path
14. **`tests/integration/no-superpowers-references.sh:15`** — Hardcoded WORKTREE path (broken)
15. **`tests/explicit-skill-requests/prompts/use-superpowers-direct.txt:1`** — Obsolete skill reference

### Keep As-Is (Attribution)

- `NOTICE.md` — Legal attribution to Jesse Vincent / obra/superpowers
- `ORIGINS.md` — Fork narrative and history
- `LICENSE` — Derived work attribution
- `RELEASE-NOTES.md` — Historical context
- `docs/forge_ideation_v1.md` — Ideation document
- `docs/plans/forge-v0/` — Archived planning documents
- `docs/plans/forge-clean-break/` — Archived planning documents

---

## Appendix B: Competitor Issue Analysis

### Most Requested Features Across All Competitors

| Feature | Projects Requesting | Forge Status |
|---------|-------------------|-------------|
| Multi-agent teams | superpowers (#429, 88 reactions), Claude Code (experimental) | **Built** |
| Cost/usage visibility | Claude Code (5k+ issues), Aider, Claude Engineer | **Not built (Beta target)** |
| Better onboarding | Spec Kit (#164, #1436), superpowers (multiple) | **Not built (Beta target)** |
| Instruction following | superpowers (#696, #463, #147, #485, #528, #698) | **Partially addressed (gates)** |
| Cross-session persistence | All tools | **Built (forge-state)** |
| Plan-based execution | superpowers (#429), Plandex (core) | **Built** |
| TDD enforcement | superpowers (prompt-only) | **Built (RED/GREEN/REFACTOR)** |
| Risk awareness | Nobody else offers this | **Built (4 tiers)** |
| Review workflow | superpowers (orphaned), Cline (approval-only) | **Built (two-stage)** |
| Pack/extension protocol | Codex (skills), Claude Code (plugins), Goose (MCP) | **Built (pack protocol)** |

### Upstream superpowers Specific Issues

| Issue | Theme | Forge Relevance |
|-------|-------|----------------|
| #429 (88 reactions) | Agent Teams | Forge has this |
| #696, #463, #147 | Skills not being followed | Enforcement gates partially address |
| #642 | Verification skill orphaned | Forge's verification is wired in |
| #528, #698 | Skill invocation failures | forge-routing + hooks address this |
| #485 | LLM ignoring instructions | Fundamental LLM limitation |

---

## Appendix C: Agent Gap Analysis Detail

### Current Agent Coverage Map

```
                    architect  implementer  qa-engineer  code-reviewer  security-reviewer
                    ─────────  ───────────  ──────────  ─────────────  ─────────────────
brainstorming          ·            ·            ·            ·              ·
writing-plans          ·            ·           ref           ·              ·
subagent-driven-dev    ·          dispatch     dispatch    dispatch           ·
agent-team-driven-dev  ·          dispatch     dispatch    dispatch        dispatch
composing-teams      scan         scan         scan         scan           scan
requesting-code-review ·            ·            ·         dispatch       dispatch
systematic-debugging   ·            ·            ·            ·              ·
test-driven-dev        ·            ·           ref           ·              ·
verification           ·            ·            ·            ·              ·

Legend: dispatch = agent is spawned
        ref = agent is referenced but not spawned
        scan = agent definition is discovered
        · = not involved
```

### Gap: Referenced but Undefined Agents

| Referenced Role | Referenced In | Agent Exists? |
|----------------|--------------|---------------|
| frontend-engineer | composing-teams (example) | **No** |
| backend-engineer | composing-teams (example) | **No** |
| database-specialist | risk policy (db/migrations/ = critical) | **No** |
| devops-engineer | adopting-forge (.github/workflows/) | **No** |

### Proposed New Agent Capabilities

| Agent | Tools | Key Responsibilities |
|-------|-------|---------------------|
| **frontend-engineer** | Read, Write, Edit, Bash, Glob, Grep | Component design, accessibility (WCAG), browser compat, UI testing, performance (rendering, bundle size) |
| **backend-engineer** | Read, Write, Edit, Bash, Glob, Grep | API design, database integration, scalability patterns, error handling, auth integration |
| **database-specialist** | Read, Write, Edit, Bash, Glob, Grep | Schema design, migration safety, backward compat, rollback plans, query performance, data integrity |
| **devops-engineer** | Read, Write, Edit, Bash, Glob, Grep | CI/CD pipelines, container config, secrets management, infrastructure-as-code, deployment verification |
| **technical-writer** | Read, Write, Edit, Bash, Glob, Grep | Design doc clarity, API documentation, user guides, changelog quality, comment standards |

---

## Summary: Beta Work Streams

| # | Work Stream | Tasks | Priority |
|---|------------|-------|----------|
| 1 | **Housekeeping & Cleanup** | Identity fix (15 files), plan status, architecture self-doc | P0 — must do first |
| 2 | **README & Docs Overhaul** | Restructure, 8 workflows, metro map, comparison chart, getting started | P0 — core deliverable |
| 3 | **Agent Roster Expansion** | 5 new agents (frontend, backend, database, devops, technical-writer) | P1 — enables team workflows |
| 4 | **Workflow Gaps & Feature Parity** | Routing improvements, adoption intelligence, self-documentation | P1 — enables adoption |
| 5 | **Adoption & Onboarding** | Getting started guide, verify installation, FAQ | P1 — enables new users |
| 6 | **Observability & Cost Tracking** | Token/cost evidence type, duration tracking, verification display | P2 — nice to have for Beta |
| 7 | **MVP Deviation Audit** | Log deviations during dev, end-of-cycle analysis, fix before ship | P0 — runs throughout, gates completion |
| 8 | **Dogfooding Framework** | Audit mode, self-improvement skill, 6 reference projects, full auto mode, run comparison | P1 — core differentiator, enables self-improvement loop |

**Estimated scope:** ~35-40 discrete tasks across 8 work streams.

**Success metrics:**
1. A developer who has never seen Forge can install it, adopt it in their project, and complete one full feature workflow — without reading skill source code.
2. All 6 reference projects complete successfully in full auto mode with zero blockers.
3. Run-over-run metrics show improvement (or at minimum no regression) from first run to final Beta run.

---

## Appendix D: Reference Project Specifications

### P1: Task Tracker API

**Type:** Backend REST API (Node.js or Python)
**Starting state:** Empty directory
**Feature requests:**
1. "Create a task tracker API with CRUD endpoints for tasks (title, description, status, assignee)"
2. "Add JWT authentication — only authenticated users can create/update tasks"
3. Bug: "Tasks with status 'done' can still be updated — they should be immutable"

**Workflows exercised:** Start feature (x2), Fix bug
**Risk tiers:** standard (CRUD), elevated (auth/JWT)
**Agents needed:** backend-engineer, qa-engineer, security-reviewer
**Estimated duration:** 30-45 min (full auto)

---

### P2: Dashboard UI

**Type:** Frontend SPA (React or Vue)
**Starting state:** Empty directory
**Feature requests:**
1. "Build a dashboard with a sidebar nav, header, and main content area showing a card grid"
2. "Add a dark mode toggle that persists to localStorage"
3. Review: "Review the component structure for accessibility and reusability"

**Workflows exercised:** Start feature (x2), Review change
**Risk tiers:** minimal (UI), standard (state management)
**Agents needed:** frontend-engineer, qa-engineer, code-reviewer
**Estimated duration:** 20-30 min (full auto)

---

### P3: CLI Migration Tool

**Type:** CLI tool with database migrations (Python or Go)
**Starting state:** Empty directory
**Feature requests:**
1. "Create a CLI tool that manages database schema migrations — up, down, status commands"
2. "Add a 'seed' command that populates test data from a YAML fixture file"
3. Bug: "Running 'down' twice on the same migration causes a crash instead of a no-op"

**Workflows exercised:** Start feature (x2), Fix bug
**Risk tiers:** elevated (migrations), critical (data integrity on rollback)
**Agents needed:** database-specialist, implementer, qa-engineer
**Estimated duration:** 30-40 min (full auto)

---

### P4: Deploy Pipeline

**Type:** Infrastructure (Docker + GitHub Actions)
**Starting state:** Provided skeleton (simple Node.js app with no deployment)
**Feature requests:**
1. "Add a Dockerfile and docker-compose.yml for local development"
2. "Create a GitHub Actions CI pipeline: lint, test, build, and deploy to staging"
3. Incident: "The staging deploy is failing because the health check endpoint returns 503 after deploy — investigate"

**Workflows exercised:** Start feature (x2), Investigate incident
**Risk tiers:** elevated (infrastructure), critical (secrets in CI config)
**Agents needed:** devops-engineer, security-reviewer, architect
**Estimated duration:** 25-35 min (full auto)

---

### P5: Auth Service

**Type:** Security-critical backend (Node.js or Go)
**Starting state:** Empty directory
**Feature requests:**
1. "Build an auth service with signup, login, token refresh, and logout endpoints"
2. "Add role-based access control (RBAC) with admin, editor, and viewer roles"
3. Refactor: "The password hashing uses MD5 — refactor to bcrypt with proper salt rounds"

**Workflows exercised:** Start feature (x2), Refactor safely
**Risk tiers:** critical (auth, tokens, password handling, encryption)
**Agents needed:** security-reviewer, backend-engineer, architect, qa-engineer
**Estimated duration:** 35-50 min (full auto)

---

### P6: Full-Stack Notes App

**Type:** End-to-end application (Frontend + Backend + Database + Deployment)
**Starting state:** Empty directory
**Feature requests (multi-phase):**

*Phase 1 — Start feature:*
1. "Build a full-stack notes app: React frontend, Express API, SQLite database"

*Phase 2 — Fix bug:*
2. Bug: "Notes longer than 10,000 characters cause the API to return a 500 error"

*Phase 3 — Refactor:*
3. "Refactor the API from callback-style to async/await throughout"

*Phase 4 — Review:*
4. "Review the entire codebase for security, accessibility, and code quality"

*Phase 5 — Resume (simulate cold start):*
5. "I had to stop mid-refactor — pick up where I left off"

*Phase 6 — Release:*
6. "Prepare a v1.0 release — changelog, version bump, final verification"

*Phase 7 — Investigate:*
7. "After release, users report notes are sometimes duplicated on save — investigate"

**Workflows exercised:** All 8
**Risk tiers:** All 4 (minimal for CSS, standard for CRUD, elevated for API auth, critical for data integrity)
**Agents needed:** All (frontend-engineer, backend-engineer, database-specialist, devops-engineer, security-reviewer, architect, qa-engineer, code-reviewer, technical-writer)
**Estimated duration:** 60-90 min (full auto, multi-session)
