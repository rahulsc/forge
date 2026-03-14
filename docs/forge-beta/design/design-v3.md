# Forge Beta Design Document

**Version:** Draft 3
**Date:** 2026-03-14
**Status:** Awaiting review
**Scope:** MVP (v0.1.x) → Beta (v0.2.0 → v0.5.0) → v1.0

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Product Thesis and Current State](#2-product-thesis-and-current-state)
3. [Competitive Landscape](#3-competitive-landscape)
4. [Versioning Strategy](#4-versioning-strategy)
5. [Beta Goals and Non-Goals](#5-beta-goals-and-non-goals)
6. [Work Stream 1: Identity, Trust, and Public Surface](#6-work-stream-1-identity-trust-and-public-surface)
7. [Work Stream 2: Outcome-First Documentation and Onboarding](#7-work-stream-2-outcome-first-documentation-and-onboarding)
8. [Work Stream 3: Brownfield Adoption Core](#8-work-stream-3-brownfield-adoption-core)
9. [Work Stream 4: Agent Roster and Execution Ergonomics](#9-work-stream-4-agent-roster-and-execution-ergonomics)
10. [Work Stream 5: Audit, Deviation Logging, and Analysis](#10-work-stream-5-audit-deviation-logging-and-analysis)
11. [Work Stream 6: Reference Project Suite and Controlled Auto Mode](#11-work-stream-6-reference-project-suite-and-controlled-auto-mode)
12. [Work Stream 7: Reliability, Verification, and Beta Hardening](#12-work-stream-7-reliability-verification-and-beta-hardening)
13. [Post-Beta Features (v0.5+)](#13-post-beta-features-v05)
14. [v1.0 Production Vision](#14-v10-production-vision)
15. [Comparison Chart](#15-comparison-chart)
16. [Metrics, Testing Strategy, and Exit Criteria](#16-metrics-testing-strategy-and-exit-criteria)
17. [Risk Register](#17-risk-register)
18. [Appendix A: Immediate Cleanup Audit](#appendix-a-immediate-cleanup-audit)
19. [Appendix B: Competitive Analysis Detail](#appendix-b-competitive-analysis-detail)
20. [Appendix C: Issue and PR Signal Summary](#appendix-c-issue-and-pr-signal-summary)
21. [Appendix D: Audit Event Schema](#appendix-d-audit-event-schema)
22. [Appendix E: Reference Project Specifications](#appendix-e-reference-project-specifications)
23. [Appendix F: Agent Gap Analysis](#appendix-f-agent-gap-analysis)
24. [Appendix G: Deviation Worklog](#appendix-g-deviation-worklog)

---

## 1. Executive Summary

Forge v0.1.x is a shipped MVP with 21 skills, 5 agent definitions, a risk classification engine, evidence gates, and multi-platform support. It works. But it has rough edges that prevent adoption:

- **Stale identity:** 15+ files still link to `rahulsc/superpowers`; plugin manifests point to the wrong repo
- **No onboarding path:** A new user who installs Forge has no idea what to do next
- **Agent roster gaps:** `composing-teams` references agent roles (frontend-engineer, backend-engineer) that don't exist as definitions
- **README is a feature list, not a usage guide:** 21 skills are listed but never shown working together
- **Skill bugs:** The brainstorming skill writes design docs to the wrong path convention
- **Ideation gaps:** The v1 ideation doc proposed 8 outcome-level workflows, operating modes, intelligent adoption — most are unbuilt

The Beta should be staged rather than treated as one monolithic jump:

| Version | Theme | Primary Outcome |
|---------|-------|-----------------|
| **v0.2.0** | Trust and identity | Forge looks, installs, and documents like Forge |
| **v0.3.0** | Adoption and workflow surface | Forge can adopt a real repo and guide work by outcomes |
| **v0.4.0** | Audit and self-analysis | Forge can observe and analyze how Forge is being used |
| **v0.5.0** | Hardening and controlled automation | Forge Beta is reliable, measurable, and dogfood-proven |

The Beta goal:

> Forge Beta should make the product understandable, adoptable, and analyzable in real repositories.

### Beta Exit Criteria

A user who has never seen Forge can:
1. Install it on any supported platform
2. Understand what it does from the README alone
3. Run `forge adopt` on an existing repo and get a working `.forge/` setup
4. Complete a feature workflow (brainstorm → plan → execute → verify) without reading skill source code
5. Understand the skill flow from a visual diagram in the README

All 6 reference projects complete successfully in controlled auto mode. Run-over-run metrics show no regression from first to final Beta run.

### Distribution Model

Forge is currently installed as a Claude Code plugin directly from the `main` branch on GitHub, with auto-update on new versions. Versions follow semver in plugin manifests (`package.json`). No git tags for now. No migration path is needed — there are no external users until Beta is finished. Bugs in v0.1.x are fixed as part of v0.2.0, not backported.

---

## 2. Product Thesis and Current State

### 2.1 Product Thesis

Forge is an **adoptable operating mode** for AI-assisted software development.

It is not a marketplace of skills, and it is not an autonomous production operator.

Its value is:

- structured workflows instead of ad hoc prompting
- durable project memory instead of blank-slate sessions
- risk-scaled ceremony instead of one heavy workflow for every task
- evidence-gated completion instead of ungrounded completion claims
- generated harness guidance instead of hand-maintained per-tool drift
- outcome-first user verbs instead of exposing internal implementation details

### 2.2 What Already Exists and Should Be Preserved

| Area | Status | Why it matters |
|------|--------|----------------|
| Workflow backbone | Strong | Design → plan → execute → verify is the right spine |
| Evidence direction | Strong | Verification and evidence are the sharpest differentiators |
| Multi-agent primitives | Strong | Team composition and specialist execution are real product assets |
| Cross-harness ambition | Strong | Claude Code, Cursor, Codex, OpenCode, and Gemini are part of the wedge |
| Early state model | Promising | `.forge/` already points toward durable memory as a product concept |
| Test infrastructure | Promising | Real evaluation and regression support is unusual and valuable |

### 2.3 What Is Weak or Misleading Today

| Area | Current state | Product consequence |
|------|---------------|--------------------|
| Public identity | Still reads like a transitional fork in several places | Undermines trust before a user starts |
| README and onboarding | Feature-heavy, workflow-light | Users see mechanics, not outcomes |
| Brownfield adoption | Incomplete | Existing repos are the real wedge, but the path is not yet complete |
| Skill exposure | Too visible as product surface | Users think in verbs, not skill names |
| Agent definitions | Incomplete relative to team composition examples | Team mode promises more than it can safely dispatch |
| Self-documentation | Partial | Forge is not yet describing itself with Forge artifacts |
| Audit model | Missing | Dogfooding loses its most valuable signal |
| Low-risk path | Not yet visibly light | The product can feel heavier than it should |
| Skill conventions | Inconsistent | Brainstorming skill writes to wrong doc path; other skills may have similar issues |

---

## 3. Competitive Landscape

### 3.1 Positioning

Forge competes indirectly with two classes of products:

1. **Structured workflow systems** — Superpowers (82k stars), Spec Kit (77k stars), Gastown (12k stars)
2. **General-purpose coding agents** — Claude Code (78k stars), OpenHands (69k stars), Codex CLI (65k stars), Cline (59k stars), Aider (42k stars), Goose (33k stars)

Forge should win by occupying the space between them:

- more structured than general-purpose agents
- less document-heavy than spec-first frameworks
- safer and more reviewable than high-autonomy agents
- more brownfield-friendly than greenfield-first toolkits

### 3.2 Forge's Unique Position

**What no other tool combines:**

- Structured phases WITH enforcement gates (Spec Kit has phases but no gates; Codex has sandboxing but no phases)
- Risk-scaled ceremony (4 tiers from minimal to critical) — nobody else offers this
- Evidence-gated completion — no competitor requires structured evidence as a completion gate
- Multi-agent teams WITH structured SDLC workflow (Claude Code has experimental teams; Gastown has teams; neither combines them with a full SDLC workflow)
- Pipelined TDD as part of the development workflow
- Pack protocol for distributing workflow bundles

### 3.3 Signals from Competitor Issues and PRs

From analyzing 10,000+ issues across 15+ projects:

| Signal | Source | Forge Implication |
|--------|--------|-------------------|
| Brownfield adoption is highest-value problem | Spec Kit #164, #1436; superpowers multiple | `forge adopt`, `forge sync` are the product wedge, not secondary features |
| Users want less ceremony for low-risk work | superpowers worktree complaints, review overhead | Risk-scaled depth must be real in practice |
| Reliability beats ambition | Install failures across all tools | Beta should bias toward correctness before advanced autonomy |
| Generated context must not clobber user files | Spec Kit CLAUDE.md overwrite reports | Safe update semantics are mandatory |
| Audit and evaluation are becoming table stakes | Multiple projects adding telemetry, evals | File-first audit belongs in Beta |
| Multi-agent teams are the #1 feature request | superpowers #429 (88 reactions) | Already built — our advantage |
| Cost/usage visibility is #2 concern | Claude Code 5k+ issues | Fold into audit, not a separate product |

### 3.4 Ideas Worth Borrowing

| Source | Idea | Application |
|--------|------|------------|
| GNAP | Cost/token tracking per run | Fold into audit events |
| GNAP | Human-AI parity in team protocol | Humans as team members, not just approvers |
| Spec Kit | Constitution (immutable project principles) | Promote `.forge/shared/conventions.md` |
| Gastown | OpenTelemetry-style observability | Lightweight version via audit JSONL |
| Codex CLI | AGENTS.md as emerging standard | Generate during `forge adopt` |

### 3.5 Competitive Design Principle

- Borrow reliability ideas aggressively
- Borrow interop ideas early
- Borrow observability ideas carefully
- Avoid becoming a browser-automation race or benchmark vanity project during Beta

Full per-project competitive analysis with star counts, issue themes, and feature matrices is in [Appendix B](#appendix-b-competitive-analysis-detail).

---

## 4. Versioning Strategy

### 4.1 Why a Staged Beta

A staged Beta:

1. Creates a realistic path for shipping visible progress
2. Separates trust work from deeper orchestration work
3. Lets audit and dogfooding improve the next Beta cut instead of arriving too late

### 4.2 Beta Sequence

| Version | Focus | Must be true at release |
|---------|-------|-------------------------|
| **v0.2.0** | Trust and packaging | Canonical identity, install docs, README with workflows, verify path, self-description, skill convention fixes |
| **v0.3.0** | Adoption and workflow surface | `forge adopt` works on real repos, 8 workflows routed, `CLAUDE.md`/`AGENTS.md` generation, full agent roster |
| **v0.4.0** | Audit and analysis | Audit JSONL exists, analysis skill works, 3 reference projects runnable, cost/duration tracking |
| **v0.5.0** | Beta hardening | 6 reference projects, controlled auto mode, all blockers closed, regression-tested |

### 4.3 Feature Placement Rule

- If a feature is required for **adoption** → early Beta (v0.2.0–v0.3.0)
- If a feature is required for **learning from dogfood usage** → Beta (v0.4.0)
- If a feature is required for **proving reliability** → late Beta (v0.5.0)
- If a feature is required for **unbounded autonomy or ecosystem scale** → v0.5+ or v1.0

### 4.4 Release Mechanics

- **Versioning:** Semver in plugin manifests (`plugin.json`). No git tags for now.
- **Distribution:** Claude Code plugin installed from `main` branch on GitHub, auto-updates.
- **Upgrades:** No migration path needed. No external users until Beta is finished.
- **v0.1.x bugs:** Fixed as part of v0.2.0, not backported.

### 4.5 Bootstrapping Note

Forge v0.2.0 is built using Forge v0.1.x. Known v0.1.x bugs (e.g., brainstorming skill writes to wrong path) will cause friction during v0.2.0 development. This is accepted — deviations are logged manually (see §10.4) and the fixes are part of v0.2.0's deliverables.

---

## 5. Beta Goals and Non-Goals

### 5.1 Goals

1. **Canonical Forge identity** — zero stale public references except explicit attribution
2. **Adoptable public surface** — a new user can understand Forge from the README and run a first workflow
3. **Brownfield-first adoption** — Forge can infer repo basics, generate safe project artifacts, avoid destructive overwrites
4. **Outcome-first workflow UX** — users see verbs (adopt, start feature, fix bug), not skill names
5. **Real risk-scaled execution** — low-risk tasks stay light; high-risk tasks stay structured and evidence-gated
6. **Sufficient agent roster** — all agent roles referenced by skills actually exist
7. **Audit and self-analysis** — Forge can record, inspect, and analyze its own behavior
8. **Self-improvement loop** — analysis skill + 6 reference projects + run-over-run comparison
9. **Controlled auto mode** — permission manifests enable unattended reference-suite execution
10. **Dogfood-validated** — Forge Beta was built using Forge; all deviations logged and resolved

### 5.2 Non-Goals

- Becoming an autonomous production operator
- IDE extensions beyond current host platforms
- Browser automation
- Dashboard-first observability
- General-purpose uncontrolled auto mode for arbitrary repos
- Remote pack registry or marketplace
- Semantic repo mapping
- Benchmark marketing
- Supporting external users or migration paths before Beta completion

### 5.3 Cross-Cutting Principle: Data Sensitivity and LLM Exposure

Forge workflows send project content to LLM providers. This is inherent to how AI-assisted development works, but Forge should make its best effort to minimize unnecessary exposure of sensitive data.

**Guiding principle:** Avoid sending sensitive or secure information (passwords, API keys, tokens, PII, credentials) upstream to LLM providers. This will not always be possible — LLMs need to read code to assist with it — but Forge should never be careless about what it sends.

**Concrete requirements:**

1. **Adoption warnings:** `forge adopt` scans the entire project. Before scanning, Forge must display a clear warning explaining that project contents will be sent to the LLM provider. Users must understand the consequences before proceeding.

2. **Sensitive file detection:** During adoption and execution, Forge should detect and flag likely-sensitive files (`.env`, `credentials.*`, `secrets.*`, `**/private_key*`, `.ssh/`, `*.pem`) and either exclude them from LLM context or warn before inclusion.

3. **Risk policy integration:** Files matching sensitive patterns should default to `critical` risk tier in `.forge/policies/default.yaml`, which triggers the heaviest review ceremony including security-reviewer dispatch.

4. **Skill guidance:** Skills that involve reading project files should include guidance about avoiding unnecessary inclusion of credential files, environment configs, and secret stores.

5. **Audit trail:** When audit mode is enabled, log which files were sent to the LLM context so users can review what was exposed.

This is a best-effort principle, not an absolute guarantee. LLMs inherently receive whatever context the host platform sends. Forge's role is to guide the host toward better defaults and ensure users are informed.

---

## 6. Work Stream 1: Identity, Trust, and Public Surface

**Target:** v0.2.0

### 6.1 Objective

Make Forge look like a real product before asking anyone to trust it with a real repository.

### 6.2 Identity Cleanup

All user-facing references to `rahulsc/superpowers` must point to the canonical Forge repository. Full audit with file paths and line numbers in [Appendix A](#appendix-a-immediate-cleanup-audit).

**15 must-fix items** across plugin manifests, README, install docs, test files, and HTML templates.

Attribution materials (NOTICE.md, ORIGINS.md, LICENSE, RELEASE-NOTES.md, historical planning docs) remain intact.

### 6.3 Skill Convention Audit

The brainstorming skill writes design docs to `docs/plans/<project>/design.md` instead of the correct `docs/<project>/design/design.md`. Other skills may have similar convention mismatches.

**v0.2.0 task:** Audit all 21 skills for path conventions, artifact naming, and cross-skill references. Fix inconsistencies.

### 6.4 Repo Metadata and Trust Surface

Add missing signals that tell a user this is a canonical project:

- Repo description and topics
- Issue templates and PR template
- Support path pointing to Forge itself
- Release tagging discipline (semver in manifests, tags when ready)

### 6.5 Forge Self-Description

Forge should describe itself with Forge artifacts:

- Fill `.forge/shared/architecture.md` with Forge's actual architecture
- Fill `.forge/shared/conventions.md` with Forge's coding conventions
- Add at least one real ADR in `.forge/shared/decisions/`

This is not only documentation — it is a dogfooding requirement.

### 6.6 Product Artifacts vs Project Config: `.forge/` Restructure

The Forge repo currently mixes **product infrastructure** (tools, default policies, adapters) and **project-specific configuration** (Forge's own setup when dogfooding) inside the `.forge/` directory. This creates confusion about what ships to users vs what's local dev state.

The product already follows the right pattern for its main artifacts — `agents/`, `skills/`, `hooks/` are top-level directories. But `bin/`, `policies/`, `adapters/`, `workflows/`, and `packs/` are inconsistently nested inside `.forge/`.

#### Current structure (inconsistent)

```
agents/              ← top-level product artifact ✓
skills/              ← top-level product artifact ✓
hooks/               ← top-level product artifact ✓
.forge/bin/          ← product tools, but nested in .forge/ ✗
.forge/policies/     ← default policies, nested in .forge/ ✗
.forge/adapters/     ← platform adapters, nested in .forge/ ✗
.forge/workflows/    ← workflow definitions, nested in .forge/ ✗
.forge/packs/        ← pack protocol, nested in .forge/ ✗
.forge/shared/       ← mixed: templates AND Forge's own self-description ✗
.forge/project.yaml  ← mixed: product default AND Forge's own config ✗
.forge/local/        ← dev state (gitignored) ✓
```

#### Proposed structure (clean separation)

```
# Product artifacts (ship to users, top-level)
agents/              ← agent definitions
skills/              ← skill definitions
hooks/               ← hook scripts and registry
bin/                 ← product tools (classify-risk, forge-state, forge-evidence, etc.)
policies/            ← default risk policies
adapters/            ← platform-specific adapters
workflows/           ← workflow definitions
packs/               ← pack protocol and installed packs
templates/           ← templates for .forge/shared/ files created in user repos

# Project config (Forge's own Forge setup — dogfooding)
.forge/
  project.yaml                ← describes Forge-the-project
  policies/                   ← Forge-specific policy overrides (if any)
  shared/architecture.md      ← Forge's own architecture
  shared/conventions.md       ← Forge's own coding conventions
  shared/decisions/            ← Forge's own ADRs
  local/                      ← gitignored dev state (DB, memory, evidence, audit, cache)
```

#### What this achieves

1. **`.forge/` means exactly one thing everywhere:** "this project's Forge configuration." In the Forge repo, it's Forge's own config. In a user's repo, it's their config.
2. **Product artifacts follow the existing pattern:** `bin/`, `policies/`, `adapters/` join `agents/`, `skills/`, `hooks/` at the top level.
3. **No more confusion:** Contributors know that top-level directories are product artifacts; `.forge/` is project config.
4. **Dev state stays isolated:** `.forge/local/` remains gitignored for all session-generated artifacts.

#### Migration for v0.2.0

- Move `.forge/bin/` → `bin/`
- Move `.forge/policies/` → `policies/` (as defaults/templates)
- Move `.forge/adapters/` → `adapters/`
- Move `.forge/workflows/` → `workflows/`
- Move `.forge/packs/` → `packs/`
- Create `templates/` with templates for `shared/architecture.md`, `shared/conventions.md`, etc.
- Keep `.forge/` with only Forge's own project config and `local/`
- Update all skills, hooks, and bin tools that reference `.forge/` paths for product artifacts
- Update `forge:adopting-forge` to create `.forge/` in user repos using templates from `templates/` and defaults from `policies/`

### 6.7 Stale Plan Status

Update completed plans to reflect reality:

| Plan | Current Status | Correct Status |
|------|---------------|----------------|
| `docs/plans/forge-v0/plan.md` | pending | completed |
| `docs/plans/forge-clean-break/plan.md` | pending | completed |

### 6.8 Exit Criteria

- No stale public install/support links remain outside allowed attribution/history exceptions
- All 21 skills audited for convention consistency; mismatches fixed
- Repo metadata is canonical
- Forge contains real architecture doc, conventions doc, and at least one ADR for itself
- Completed plans marked as such
- Product artifacts moved to top-level (`bin/`, `policies/`, `adapters/`, `workflows/`, `packs/`, `templates/`)
- `.forge/` contains only Forge's own project config and `local/` (dev state)
- All skills, hooks, and bin tools updated for new paths

---

## 7. Work Stream 2: Outcome-First Documentation and Onboarding

**Target:** v0.2.0

### 7.1 Objective

Explain Forge the way users think, not the way the implementation is arranged.

### 7.2 README Restructure

The current README is 251 lines listing features. The Beta README should be structured for adoption:

```
# Forge
One-paragraph product pitch

## Why Forge (comparison chart)
## Quick Start (3 steps: install → adopt → first workflow)
## The 8 Workflows
## Risk-Scaled Ceremony (visual)
## How Forge Adopts a Repo
## Installation (per platform, collapsed/tabbed)
## Verify Installation
## Infrastructure (.forge/ directory)
## Agent Roster (table)
## Extending Forge (skills, packs, agents)
## Philosophy
## Attribution
```

### 7.3 The 8 Outcome Workflows

Users think in outcomes, not skills. These should be the public UX layer:

| Workflow | User Says | Skill Pipeline |
|----------|-----------|---------------|
| **Adopt a repo** | "Set up Forge here" | `forge-routing` → `adopting-forge` → `syncing-forge` |
| **Start a feature** | "Add X", "Build Y" | `forge-routing` → `brainstorming` → `setting-up-project` → `writing-plans` → execution → `verification-before-completion` → `requesting-code-review` → `finishing-a-development-branch` |
| **Fix a bug** | "X is broken" | `forge-routing` → `systematic-debugging` → (optional: `writing-plans`) → `test-driven-development` → `verification-before-completion` |
| **Refactor safely** | "Refactor X" | `forge-routing` → `brainstorming` → `writing-plans` → `test-driven-development` → `verification-before-completion` → `requesting-code-review` |
| **Review a change** | "Review PR #N" | `forge-routing` → `requesting-code-review` or `receiving-code-review` |
| **Resume work** | (session start) | `forge-session-start` hook → `forge-state` restoration → resume at last skill |
| **Prepare a release** | "Ship it" | `verification-before-completion` → `finishing-a-development-branch` |
| **Investigate an incident** | "Why is X failing?" | `forge-routing` → `systematic-debugging` |

Each workflow in the README should show: what the user says, what Forge does, what artifacts appear, what verification is required.

### 7.4 Skill Flow Diagram (Metro Map)

A visual metro map showing how skills compose into pipelines. Each "line" is a workflow, each "station" is a skill. Transfer stations show where workflows share skills.

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

Implementation: Mermaid flowchart with color-coded lines, rendered as SVG for non-GitHub contexts.

### 7.5 Comparison Chart in README

A feature comparison table (see [§15](#15-comparison-chart) for the full chart).

### 7.6 Verify Installation

Replace vague verification guidance with a concrete check:

- A specific test prompt per supported host that users can copy-paste
- Expected visible behavior showing the skill activated
- Troubleshooting for common failures (hooks not loading, plugin not detected)

### 7.7 Getting Started Walkthrough

A first-10-minutes walkthrough in the README:

1. Install Forge (platform-specific, already documented)
2. Navigate to your project: `cd my-project`
3. Say: "Set up Forge in this project"
   → `forge:adopting-forge` runs, creates `.forge/`, populates `project.yaml`
4. Say: "Add a health check endpoint"
   → `forge:brainstorming` → `forge:writing-plans` → implementation
5. Observe: risk classification, evidence collection, verification gate

Concrete walkthrough with expected outputs at each step.

### 7.8 FAQ / Troubleshooting

| Question | Answer |
|----------|--------|
| What if a skill doesn't activate? | Run `forge:diagnosing-forge`, verify hooks loaded |
| How do I change the risk tier for a file? | Edit `.forge/policies/default.yaml` |
| Can I use Forge with a different LLM? | Forge is platform-agnostic; works with whatever your host supports |
| How do I skip a workflow step? | Risk tier determines required steps; lower the tier for less ceremony |
| How do I resume after a crash? | Session start hook restores state; say "where was I?" |

### 7.9 Exit Criteria

- A new user can understand Forge from the README alone
- The 8 workflows are documented publicly with skill pipelines and expected artifacts
- Concrete verify-install flow for each supported host
- One tested first-run walkthrough
- FAQ covers common questions

---

## 8. Work Stream 3: Brownfield Adoption Core

**Target:** v0.3.0

### 8.1 Objective

Make `forge adopt` the core product capability, not a shell around templates.

### 8.2 Product Contract for `forge adopt`

`forge adopt` should:

1. **Warn about LLM exposure** — before scanning, display a clear notice that project contents will be sent to the LLM provider for analysis. The user must acknowledge this before proceeding.
2. Inspect the repo
3. **Detect and flag sensitive files** — identify `.env`, `credentials.*`, `secrets.*`, private keys, etc. Warn the user and exclude from LLM context where possible.
4. Infer stack, commands, and risk areas conservatively
5. Detect existing AI-facing files and docs
6. Preview generated changes
7. Preserve user-owned context whenever possible
8. Create a working Forge surface, not a blank scaffold

### 8.3 Generated Artifact Model

When `forge adopt` runs on a user's repo, it creates a `.forge/` directory for that project's configuration. Default policies and templates come from Forge's top-level `policies/` and `templates/` directories.

**Created in user's repo (checked in):**

- `.forge/project.yaml` — populated with inferred values
- `.forge/policies/default.yaml` — risk tiers based on detected file patterns (seeded from Forge's `policies/`)
- `.forge/shared/architecture.md` — project architecture (seeded from Forge's `templates/`)
- `.forge/shared/conventions.md` — coding conventions (seeded from Forge's `templates/`)
- `.forge/shared/decisions/` — ADR directory
- Generated `CLAUDE.md` or managed Forge section
- Generated `AGENTS.md` or managed Forge section

**Created in user's repo (gitignored):**

- `.forge/local/state/` — workflow state
- `.forge/local/checkpoints/` — resume points
- `.forge/local/memory/` — cross-session memory
- `.forge/local/audit/` — audit trails
- `.forge/local/permissions/` — auto-mode permission manifests

### 8.4 Safe Update Semantics

Generated context files must not clobber user-written project guidance. Two acceptable strategies:

1. **Managed block strategy** — update only within explicit generated markers:
   ```markdown
   <!-- forge:begin - DO NOT EDIT THIS BLOCK -->
   ... generated content ...
   <!-- forge:end -->
   ```

2. **Split file strategy** — generate `CLAUDE.forge.md` and `AGENTS.forge.md`, then reference them

For Beta, either approach is acceptable. Full-file overwrite is not.

### 8.5 Inference Scope for Beta

**Required:**

| Signal | Detection Method |
|--------|-----------------|
| Package manager | `package.json` (npm/yarn/pnpm), `pyproject.toml`/`requirements.txt` (pip/poetry/uv), `Cargo.toml`, `go.mod` |
| Test runner | package.json scripts, Makefile targets, CI config |
| Linter | `.eslintrc*`, `ruff.toml`, `.golangci.yml`, etc. |
| CI surface | `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile` |
| Language/stack | File extensions, manifest files |
| Critical paths | `db/migrations/`, `auth/`, `**/secrets*`, `**/payments*` |

**Deferred to v1.0:** Confidence scoring, semantic architecture inference, repo topology classification.

### 8.6 Routing and Resume Improvements

`forge-routing` should be upgraded to support all 8 public workflows:

- **Resume work** — detect existing forge-state and resume at last skill
- **Prepare release** — explicit routing for release workflows
- **Adopt repo** — direct to `adopting-forge`
- **Ambiguous intent** — ask the user instead of guessing

### 8.7 `forge sync` and `forge doctor`

Adoption is not enough. Users need maintenance commands:

- `forge sync` — regenerates managed artifacts safely (respects managed blocks)
- `forge doctor` — validates state, adapters, generated files, and common misconfiguration

### 8.8 Exit Criteria

- `forge adopt` works on representative existing repos and fills `project.yaml` with useful defaults
- `CLAUDE.md` and `AGENTS.md` generation exists in a non-destructive form
- All 8 workflows route correctly
- `forge sync` has safe update semantics
- `forge doctor` can diagnose common installation and state problems

---

## 9. Work Stream 4: Agent Roster and Execution Ergonomics

**Target:** v0.3.0

### 9.1 Objective

Make team mode honest, useful, and lighter where it should be lighter.

### 9.2 Required Agent Additions

The roster should cover the specialist roles already implied by workflows.

**Required for Beta:**

| Agent | Justification | Referenced By |
|-------|--------------|---------------|
| **frontend-engineer** | `composing-teams` lists as example team member; modern projects split FE/BE | composing-teams, agent-team-driven-development |
| **backend-engineer** | `composing-teams` lists as example team member | composing-teams, agent-team-driven-development |
| **database-specialist** | `adopting-forge` flags `db/migrations/` as CRITICAL risk; no agent can review migration evidence | adopting-forge, risk classification |
| **devops-engineer** | `adopting-forge` detects `.github/workflows/` but no agent reviews CI/CD | adopting-forge, infrastructure at elevated/critical risk |

**Useful if time permits:**

| Agent | Justification |
|-------|--------------|
| **technical-writer** | Design docs, API docs, user guides authored frequently; no quality gate for documentation |

**Deferred to v1.0:**

| Agent | Justification |
|-------|--------------|
| **performance-engineer** | Useful but not referenced by any existing skill |
| **data-engineer** | ETL/pipeline specialist; too niche for Beta |
| **compliance-specialist** | Domain-specific; too niche for Beta |

**Agent definition template:** Each new agent follows the existing pattern with `model: opus`, appropriate tools, and a system prompt defining role, responsibilities, and quality standards. Cost optimization (sonnet/haiku for focused tasks) is deferred.

Full gap analysis with current coverage map and workflow-to-agent mapping in [Appendix F](#appendix-f-agent-gap-analysis).

### 9.3 Execution Ergonomics

Forge should respond to real user friction around ceremony:

- **Make worktrees optional** for minimal-risk work — don't force isolation for a CSS change
- **Single-agent execution path** for small tasks — don't spin up a team for a one-file fix
- **Reduce review chatter** between subagents when risk doesn't justify it
- **Keep heavy review loops** for elevated and critical work
- **Conservative multi-repo support** — don't pretend it's solved

### 9.4 Public Principle

> Forge is strict when the work is risky and light when the work is small.

This should be true in both documentation and implementation.

### 9.5 Exit Criteria

- Every documented specialist role exists as a real agent definition
- Minimal-risk work can run without mandatory worktree creation
- Users can choose between lighter and deeper execution strategies within policy
- Multi-agent execution feels purposeful rather than performative

---

## 10. Work Stream 5: Audit, Deviation Logging, and Analysis

**Target:** v0.4.0 (automated infrastructure); v0.2.0–v0.3.0 (manual deviation tracking)

### 10.1 Objective

Make Forge capable of explaining how it behaved while building Forge.

### 10.2 Why This Belongs in Beta

Forge is being built with Forge inside Claude Code. Audit is not a vanity feature — it is the shortest path to finding workflow drift, tool friction, host-specific failures, and prompt non-compliance before v1.0.

### 10.3 Audit Layers

#### Layer 1: Deviation Log (Manual — v0.2.0 onward)

A lightweight log of places where expected and actual behavior diverged. Maintained manually during v0.2.0 and v0.3.0 development, before automated audit infrastructure exists.

Fields:

| Field | Description |
|-------|-------------|
| `#` | Sequential number |
| `Version` | Which Beta version was being developed when deviation occurred |
| `Skill` | Which skill or workflow misbehaved |
| `Expected` | What should have happened |
| `Actual` | What actually happened |
| `Severity` | blocker / friction / cosmetic |
| `Root cause` | Best guess at why |
| `Fix target` | Which version will fix this |
| `Status` | open / fixed / deferred |

Stored in the design doc itself (see [Appendix G](#appendix-g-deviation-worklog)). The automated audit system replaces this manual process in v0.4.0.

#### Layer 2: Structured Event Audit (Automated — v0.4.0)

Append-only JSONL events for significant workflow actions.

Required event types for Beta:

- `session_start`
- `routing_decision`
- `skill_enter` / `skill_exit`
- `gate_check` (pass/fail/skip)
- `approval_request` / `approval_resolution`
- `agent_dispatch` / `agent_join`
- `verification_result`
- `task_completion_summary`

Storage: `.forge/local/audit/<session-id>.jsonl`. One line per action. Machine-readable, append-only.

Full event schema in [Appendix D](#appendix-d-audit-event-schema).

#### Layer 3: Analysis Outputs

Machine-readable metrics plus human-readable reports:

- `docs/<project>/audits/<date>-<run>.md` — human-readable analysis
- `.forge/local/audit/metrics.jsonl` — machine-readable trend data

### 10.4 Enablement

```yaml
# .forge/project.yaml
audit:
  enabled: true
  retention: 30  # days, 0 = forever
```

### 10.5 Token Tracking Integration Points

Cost and duration tracking sits inside audit, not as a separate feature.

| Hook/Skill | What to Track | Event Type |
|------------|--------------|------------|
| `forge-session-start` | Session start timestamp, host platform | `session_start` |
| `forge-routing` | Intent detected, risk tier, pipeline selected | `routing_decision` |
| Each skill entry/exit | Tokens in/out, duration, artifacts produced | `skill_enter` / `skill_exit` |
| `forge-gate` | Gate name, result (pass/fail/skip), evidence cited | `gate_check` |
| `forge-task-completed` | Task duration, total tokens, outcome | `task_completion_summary` |
| `verification-before-completion` | Accumulated cost for current task, evidence summary | `verification_result` |
| `forge-viz` | Display cost data in dashboard | (reads audit data) |

Minimum viable fields per event:

- `tokens_in` — estimated or reported input tokens
- `tokens_out` — estimated or reported output tokens
- `duration_ms` — wall clock time
- `cost_estimate_usd` — optional, when host data is available

### 10.6 Self-Improvement Skill: `forge:analyzing-audit`

A new skill that reads audit trails and produces improvement recommendations.

**Inputs:**

- One or more audit JSONL files
- Optional: previous analysis results (for trend comparison)
- Optional: deviation log entries

**Analysis dimensions:**

| Dimension | What It Measures | Example Finding |
|-----------|-----------------|-----------------|
| **Workflow compliance** | Did skills execute in expected order? Were gates respected? | "brainstorming was skipped in 3/5 runs — routing didn't trigger" |
| **Permission friction** | How many approval requests? How many redundant? | "42 approvals, 38 were `git commit` — should be pre-approved" |
| **Token efficiency** | Token cost per workflow phase, per skill, per project | "brainstorming consumed 45% of total tokens — consider shorter designs" |
| **Deviation patterns** | Recurring deviation types across runs | "LLM skips verification 60% of the time" |
| **Duration analysis** | Time per phase, time waiting for approvals vs working | "70% of wall clock time was approval waits" |
| **Agent utilization** | In multi-agent runs, which agents were underused? | "security-reviewer dispatched but trivial findings in 4/5 runs" |
| **Skill effectiveness** | Did invocations produce expected artifacts? | "writing-plans produced plans in 5/5 runs but 2 had no wave analysis" |
| **Regression detection** | Did metrics get worse compared to previous runs? | "Token cost for 'start feature' increased 30% since last run" |

**Outputs:**

- `docs/<project>/audits/analysis-<date>.md` — human-readable report
- `.forge/local/audit/metrics.jsonl` — machine-readable metrics for trend tracking
- List of recommended skill/workflow changes with priority

### 10.7 Audit Design Constraints

Audit in Beta should be:

- local-first
- file-first
- append-only
- opt-in where appropriate
- cheap to record
- analyzable by Forge itself

Audit in Beta should **not** require:

- a hosted backend
- a dashboard service
- cross-user telemetry collection
- auto-submitted data

### 10.8 Exit Criteria

- Audit events exist for major workflow transitions
- Deviation logging is standardized (automated replaces manual)
- Token and duration data are captured
- `forge:analyzing-audit` can summarize at least one real Forge-on-Forge run
- Verification can surface a task-level audit summary

---

## 11. Work Stream 6: Reference Project Suite and Controlled Auto Mode

**Target:** v0.4.0 (core suite + auto mode preview) and v0.5.0 (expanded suite + stable auto mode)

### 11.1 Objective

Validate Forge on a fixed set of representative repos instead of relying only on the Forge repo itself.

### 11.2 Reference Project Selection Criteria

- Together, projects must cover all 8 outcome workflows
- Each risk tier (minimal → critical) must be exercised
- Each agent role (including new Beta agents) must be dispatched at least once
- Projects should be small enough to complete in a single session (~30-60 min each in auto mode)
- Projects must be reproducible — same spec produces comparable results across runs

### 11.3 Staged Reference Suite

#### v0.4.0: Core Suite (3 projects)

| # | Project | Type | Workflows | Risk Tiers | Agents |
|---|---------|------|-----------|-----------|--------|
| 1 | **Task Tracker API** | Backend | adopt, start feature, fix bug | standard, elevated (auth) | backend-engineer, qa-engineer, security-reviewer |
| 2 | **Dashboard UI** | Frontend | adopt, start feature, review | minimal, standard | frontend-engineer, qa-engineer, code-reviewer |
| 3 | **CLI Migration Tool** | CLI + Database | adopt, start feature, fix bug | elevated (migrations), critical (data) | database-specialist, implementer, qa-engineer |

#### v0.5.0: Expanded Suite (6 projects)

Add three more:

| # | Project | Type | Workflows | Risk Tiers | Agents |
|---|---------|------|-----------|-----------|--------|
| 4 | **Deploy Pipeline** | Infrastructure | adopt, start feature, investigate incident | elevated (infra), critical (secrets) | devops-engineer, security-reviewer, architect |
| 5 | **Auth Service** | Security-critical backend | adopt, start feature, refactor safely | critical (auth, tokens, encryption) | security-reviewer, backend-engineer, architect, qa-engineer |
| 6 | **Full-Stack Notes App** | End-to-end | all 8 workflows | all 4 tiers | all agents |

Full project specifications with starting states, exact prompts, expected workflows, and estimated durations in [Appendix E](#appendix-e-reference-project-specifications).

### 11.4 Coverage Matrix

| Workflow | P1 | P2 | P3 | P4 | P5 | P6 |
|----------|:--:|:--:|:--:|:--:|:--:|:--:|
| Adopt a repo | x | x | x | x | x | x |
| Start a feature | x | x | x | x | x | x |
| Fix a bug | x | | x | | | x |
| Refactor safely | | | | | x | x |
| Review a change | | x | | | | x |
| Resume work | | | | | | x |
| Prepare a release | | | | | | x |
| Investigate incident | | | | x | | x |

| Risk Tier | P1 | P2 | P3 | P4 | P5 | P6 |
|-----------|:--:|:--:|:--:|:--:|:--:|:--:|
| minimal | | x | | | | x |
| standard | x | x | | | | x |
| elevated | x | | x | x | | x |
| critical | | | x | x | x | x |

### 11.5 Controlled Auto Mode

Auto mode is scoped to trusted reference-suite runs during Beta, not general use.

#### Permission Manifest

During brainstorming, Forge builds a list of permissions the workflow will need and requests them upfront:

```yaml
# Generated during brainstorming, approved by user once
permissions:
  file_operations:
    create_files: true
    edit_files: true
    delete_files: false  # still requires approval

  git_operations:
    commit: true
    create_branch: true
    push: false  # still requires approval

  shell_commands:
    allow_patterns:
      - "npm install*"
      - "npm test*"
      - "npm run lint*"
      - "pytest*"
      - "cargo test*"
      - "go test*"
    deny_patterns:
      - "rm -rf*"
      - "sudo*"

  agent_operations:
    spawn_agents: true
    replicate_permissions: true  # agents inherit same permission set
```

#### How It Works

1. **Brainstorming generates permission manifest** — based on detected stack, planned operations, and risk tier
2. **User reviews and approves once** — "These are the permissions for this workflow. Approve?"
3. **Manifest stored** in `.forge/local/permissions/<session-id>.yaml`
4. **Gates consult the manifest** — if the action matches an approved pattern, auto-approve
5. **Unapproved actions still prompt** — safety net for unexpected operations
6. **Agents inherit permissions** — dispatched agents receive the same permission set

#### Auto Mode Activation

```
User: "Run in full auto mode"
→ forge-routing detects auto mode intent
→ brainstorming includes permission manifest generation
→ user approves manifest once
→ all subsequent steps auto-approve matching actions
```

#### Reference Suite Runner

Each reference project spec includes a pre-built permission manifest:

```bash
forge-run-suite --auto --projects all
forge-run-suite --auto --projects "task-tracker,dashboard-ui"
```

### 11.6 Run-Over-Run Comparison

Each suite run produces comparable metrics:

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
                    Run #3 (2026-04-15)    Run #2 (2026-04-10)    Delta
total_tokens        45,200                 52,100                 -13.2% (better)
total_duration      12m 30s                18m 45s                -33.3% (better)
approval_count      3                      42                     -92.9% (better)
gate_pass_rate      100%                   80%                    +20.0% (better)
deviation_count     1                      4                      -75.0% (better)
```

Stored at: `.forge/local/audit/runs/<project>/<run-id>.json`

### 11.7 Design Rule

Reference projects exist to improve Forge, not to turn Forge into benchmark theater. The suite should be small, repeatable, and directly tied to product decisions.

### 11.8 Regression CI

Once the reference suite is stable, it can run in CI on every Forge commit. A PR that causes a reference project to regress (more tokens, more deviations, lower gate pass rate) gets flagged automatically. Not in Beta scope to build the CI integration, but the audit format and comparison tooling should support it.

### 11.9 Exit Criteria

**v0.4.0:**
- 3 reference projects exist and can be run repeatedly
- Audit and comparison work on those runs
- Controlled auto mode exists in preview form for the suite

**v0.5.0:**
- 6 reference projects cover all workflows and risk tiers
- Coverage spans all public workflows, all risk tiers, all Beta agent roles
- Run-over-run comparison is stable enough to catch regressions
- Controlled auto mode works reliably for trusted suite runs

---

## 12. Work Stream 7: Reliability, Verification, and Beta Hardening

**Target:** v0.5.0

### 12.1 Objective

Turn the staged Beta work into a trustworthy Beta release.

### 12.2 Hardening Priorities

1. Install and verify flow per host
2. Safe adoption on existing repos
3. Safe regeneration of managed artifacts
4. State restoration and resume behavior
5. Audit completeness for key workflow transitions
6. Routing correctness for public workflows
7. Risk-policy and evidence gate correctness

### 12.3 Beta Test Matrix

Forge should be tested across:

- All supported hosts (Claude Code, Cursor, Codex, OpenCode, Gemini CLI)
- Representative repo types (frontend, backend, full-stack, infra)
- All 4 risk tiers (minimal, standard, elevated, critical)
- Single-agent and multi-agent execution paths
- Resumed sessions
- Safe sync updates

### 12.4 Deviation Analysis Gate

Before calling Beta complete:

1. **Collect** all deviations logged during v0.2.0–v0.5.0 development (manual + automated)
2. **Categorize** by root cause (skill bug, missing convention, unclear instruction, LLM non-compliance)
3. **Fix** all blocker and friction items
4. **Document** patterns for skill authors (what instructions LLMs ignore, what phrasing works)
5. **Update** affected skills with fixes
6. **Verify** fixes with targeted tests

### 12.5 Exit Criteria

- A new user can install Forge and verify it quickly on any supported host
- A real repo can be adopted without destructive context overwrite
- Public workflows route correctly in representative scenarios
- Audit and analysis work on real dogfood runs
- Reference-suite runs provide stable regression signal
- All known Beta blockers are closed or explicitly deferred with rationale
- Deviation worklog is fully processed

---

## 13. Post-Beta Features (v0.5+)

Features that are valuable but should not block Beta completion. Target version is post-v0.5.0, not necessarily v1.0.

| Feature | Description | Why Defer |
|---------|-------------|-----------|
| **Budget caps** | Per-workflow token/cost limits with alerts when exceeded | Needs audit cost data from Beta runs to set meaningful baselines |
| **Community audit submission** | Users opt in to submitting anonymized audit logs for their projects | Needs stable audit format from Beta; privacy design required |
| **Regression CI** | Reference suite runs in CI on every Forge commit | Needs stable suite from Beta; CI pipeline design required |

---

## 14. v1.0 Production Vision

### 14.1 Vision Statement

Forge v1.0 should be the production-ready operating mode for AI-assisted software development in real repositories.

It should be trusted for day-to-day engineering work because it is understandable, adoptable, resumable, auditable, policy-aware, evidence-backed, and cross-harness compatible.

### 14.2 v1.0 User Promise

A team should be able to bring Forge into an existing repository and get:

- Project-aware setup and generated context files
- Reliable workflow routing for common engineering outcomes
- Durable local memory and resumable checkpoints
- Explicit risk and evidence policies
- Safe updates to generated artifacts
- Analysis of how work actually proceeded
- Enough interop to work across major supported coding hosts

### 14.3 Required v1.0 Capabilities

| Capability | Description |
|-----------|-------------|
| **Stable operating modes** | Ephemeral, project, and adopted modes formalized |
| **Canonical model and renderers** | Generate `CLAUDE.md`, `AGENTS.md`, and other host adapters from canonical model |
| **Safe adoption and sync lifecycle** | `forge adopt`, `forge sync`, `forge doctor` feel production-safe |
| **Mature risk and evidence model** | Customizable, explicit, and stable policies |
| **Mature audit and analysis loop** | Supports retrospectives, regression detection, and product improvement |
| **Production support matrix** | Per-host install path, verify path, known limitations, tested guarantees |
| **Upgrade and migration story** | Versioned artifact expectations, safe upgrade for existing Forge repos |
| **Per-model cost optimization** | Use sonnet/haiku for focused tasks based on audit cost data |
| **Budget caps** | Per-workflow token/cost limits |

### 14.4 What v1.0 Is Not

Even at production readiness, Forge should remain:

- Not an autonomous production operator
- Not a prompt marketplace
- Not a document bureaucracy
- Not a telemetry-first SaaS platform
- Not a browser automation product with workflow features attached later

### 14.5 Production Readiness Criteria

| Area | v1.0 bar |
|------|----------|
| Public identity | Canonical and consistent |
| Installation | Reliable and documented across supported hosts |
| Adoption | Safe on real existing repos |
| Generated files | Non-destructive and maintainable |
| Workflow routing | Predictable for public outcomes |
| Evidence model | Stable and customizable |
| Audit model | Useful for real retrospectives and regressions |
| Storage and migration | Versioned and upgradeable |
| Test coverage | Host, workflow, and fixture based |
| Supportability | Clear docs, known limits, and release notes |

---

## 15. Comparison Chart

To be included in the Beta README. Based on verifiable, conservative claims.

### Feature-Level Matrix

| Feature | Forge | Superpowers | Spec Kit | Gastown | Claude Code | Aider | Cline | OpenHands |
|---------|:-----:|:-----------:|:--------:|:-------:|:-----------:|:-----:|:-----:|:---------:|
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
| **Cost tracking** | Beta (audit) | — | — | — | — | — | — | — |
| **Platform support** | 5 platforms | 5 platforms | 20+ agents | Multi-runtime | Terminal | Terminal + IDE | VS Code | CLI + GUI + Cloud |
| **Semantic repo mapping** | — | — | — | — | — | Full | Context cmds | RepoMap |
| **Browser automation** | — | — | — | — | — | — | Full | Full |
| **Benchmarking (SWEBench)** | — | — | — | — | — | Leaderboard | — | 77.6% |

### Capability-Level Matrix

| Capability | Forge | Superpowers | Spec Kit | Claude Code | Codex | Aider | Cline | OpenHands |
|-----------|:-----:|:-----------:|:--------:|:-----------:|:-----:|:-----:|:-----:|:---------:|
| Brownfield adoption as core UX | **Yes** | Partial | Partial | No | Partial | Yes | Partial | Partial |
| Outcome-first workflows | **Yes** | Partial | Yes | No | No | No | No | No |
| Risk-scaled ceremony | **Yes** | — | — | No | No | No | No | No |
| Evidence-gated completion | **Yes** | Partial | Partial | No | No | Partial | Partial | Partial |
| Generated harness guidance | **Beta** | Partial | Partial | No | Partial | No | No | No |
| Durable local project state | **Yes** | Partial | Partial | Limited | Limited | Limited | Partial | Partial |
| Audit trail for workflow behavior | **Beta** | — | — | — | — | Partial | Partial | Partial |
| Structured multi-agent execution | **Yes** | Partial | Emerging | Limited | Limited | No | Limited | Yes |
| Safe sync/update of generated context | **Beta** | — | Partial | No | No | No | No | No |
| Reference-suite dogfooding | **Beta** | — | Emerging | No | No | Benchmarks | — | Yes |

---

## 16. Metrics, Testing Strategy, and Exit Criteria

### 16.1 Testing Strategy per Version

| Version | Testing Approach |
|---------|-----------------|
| **v0.2.0** | Manual verification of identity cleanup (grep for stale refs). Test install flow on Claude Code. Run existing test suite. Manual skill audit. |
| **v0.3.0** | Test `forge adopt` on 3+ real repos of different stacks. Test routing for all 8 workflows with prompt fixtures. Test `CLAUDE.md`/`AGENTS.md` generation with safe update semantics. Agent dispatch tests. |
| **v0.4.0** | Run 3 reference projects end-to-end. Verify audit JSONL completeness. Run `forge:analyzing-audit` on real output. Token/duration tracking verification. |
| **v0.5.0** | Run full 6-project suite in controlled auto mode. Run-over-run comparison. Host compatibility matrix testing. Deviation worklog analysis and closure. |

### 16.2 Exit Criteria by Version

#### v0.2.0

- Zero stale public install/support references outside allowed attribution/history files
- All 21 skills audited for convention consistency; mismatches fixed
- README rewrite complete with 8 workflows, metro map, comparison chart, getting started
- One tested verify-install prompt per supported host
- Forge self-doc artifacts exist (architecture, conventions, 1+ ADR)
- Existing test suite passes

#### v0.3.0

- `forge adopt` fills `project.yaml` with useful defaults on representative repos
- `CLAUDE.md` and `AGENTS.md` generation avoid full-file overwrite
- All 8 workflows route correctly in representative scenarios
- All required agent definitions exist (frontend, backend, database, devops)
- Minimal-risk work can avoid unnecessary worktree ceremony
- `forge sync` and `forge doctor` work

#### v0.4.0

- Audit JSONL exists for key workflow events
- Token and duration tracking exist in lightweight form
- `forge:analyzing-audit` can summarize at least one real Forge-on-Forge run
- 3 reference projects are runnable and comparable
- Controlled auto mode exists in preview form for the suite

#### v0.5.0

- 6 reference projects cover all workflows and risk tiers
- Blocker and friction deviations are resolved or explicitly deferred
- Controlled auto mode works reliably for trusted suite runs
- Routing, adoption, sync, resume, and verification are regression-tested
- Deviation worklog is fully processed
- Run-over-run comparison is stable

---

## 17. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| **Identity cleanup slips behind new feature work** | High | High | Make v0.2.0 a packaging release with explicit stop-ship rules |
| **`forge adopt` overwrites user context** | Medium | Critical | Use managed blocks or split-file generation; never full overwrite |
| **Audit becomes too heavy** | Medium | Medium | Keep audit local-first, append-only, schema-minimal |
| **Multi-agent execution still feels too ceremonial** | High | Medium | Add light execution paths; make worktrees optional for minimal risk |
| **Dogfood bias hides external adoption issues** | Medium | High | Use reference projects and external fixture repos |
| **Controlled auto mode expands too early** | Medium | High | Scope to trusted reference-suite runs during Beta |
| **Host-specific behavior diverges** | High | High | Maintain per-host verify flows and known limitations |
| **Audit data becomes noisy** | Medium | Medium | Standardize deviation fields; build analysis around repeated patterns |
| **Scope creep pushes Beta forever** | High | High | Keep version boundaries explicit; defer ecosystem-scale ideas |
| **Name collision around "Forge"** | Medium | Medium | Final naming decision before or during Beta hardening |
| **LLM ignores skill instructions** | High | Critical | Enforcement gates catch skipped steps; can't fully solve at prompt level |
| **Reference projects too slow** | Medium | Medium | Keep projects small (~30 min each); parallelize with auto mode |
| **Full auto mode enables unsafe actions** | Medium | High | Permission manifest is explicit; deny-by-default for destructive ops |
| **Self-improvement skill produces noise** | Medium | Low | Human reviews recommendations; skill suggests, doesn't auto-apply |
| **v0.1.x bugs cause friction during v0.2.0 dev** | High | Low | Accepted; deviations logged manually; fixes are v0.2.0 deliverables |
| **Sensitive data sent to LLM during adoption/execution** | High | High | Warn before scanning; detect and flag sensitive files; exclude where possible; log exposure in audit |
| **Dev .forge/ state leaks into published product** | Medium | High | Verify gitignore coverage; add pre-commit check; document separation in conventions |

---

## Appendix A: Immediate Cleanup Audit

### Must Fix (15 items)

| # | File | Lines | Issue |
|---|------|-------|-------|
| 1 | `.claude-plugin/plugin.json` | 8-9 | homepage + repository URLs → `rahulsc/superpowers` |
| 2 | `.cursor-plugin/plugin.json` | 9-10 | homepage + repository URLs → `rahulsc/superpowers` |
| 3 | `README.md` | 95 | Codex install URL → `rahulsc/superpowers` |
| 4 | `README.md` | 105 | OpenCode install URL → `rahulsc/superpowers` |
| 5 | `README.md` | 113 | Gemini install URL → `rahulsc/superpowers` |
| 6 | `README.md` | 224 | Fork link → `rahulsc/superpowers` |
| 7 | `README.md` | 251 | Issues link → `rahulsc/superpowers` |
| 8 | `.codex/INSTALL.md` | 13, 125-126 | Clone URL, issues/docs links |
| 9 | `.opencode/INSTALL.md` | 13, 118-119 | Clone URL, issues/docs links |
| 10 | `docs/README.codex.md` | 10, 24, 125-126 | Install URLs, clone URL, links |
| 11 | `docs/README.opencode.md` | 10, 27, 69 | Clone URLs |
| 12 | `skills/brainstorming/scripts/frame-template.html` | 199 | Companion link |
| 13 | `.github/workflows/test.yml.disabled` | 1, 55 | Workflow name "Superpowers Tests", test path |
| 14 | `tests/integration/no-superpowers-references.sh` | 15 | Hardcoded WORKTREE path (broken) |
| 15 | `tests/explicit-skill-requests/prompts/use-superpowers-direct.txt` | 1 | References obsolete skill name |

### Preserve As Attribution/History

- `NOTICE.md` — Legal attribution to Jesse Vincent / obra/superpowers
- `ORIGINS.md` — Fork narrative and history
- `LICENSE` — Derived work attribution
- `RELEASE-NOTES.md` — Historical context
- `docs/forge_ideation_v1.md` — Ideation document
- `docs/plans/forge-v0/` — Archived planning documents
- `docs/plans/forge-clean-break/` — Archived planning documents

---

## Appendix B: Competitive Analysis Detail

### B.1 Direct Competitors (Structured Workflow Systems)

#### obra/superpowers

- **Stars:** 82,000 | **Forks:** 6,400 | **Open Issues:** 53
- **What it does:** Agentic skills framework with 7-phase workflow
- **Active:** 355 commits, 81 open PRs, 266 closed PRs. Active work on Copilot CLI support, TDD completion, multi-agent research, validation, i18n.
- **Top issues:** Skill invocation failures, installation problems, Windows compatibility, hook reliability. Agent Teams (#429, 88 reactions) is the most-requested feature.
- **What it has that Forge lacks:** Massive community, broad contribution pipeline
- **What Forge has that it lacks:** Persistent state, multi-agent teams, evidence gates, risk-scaled ceremony, pack protocol, intent routing, policy engine. Bus factor = 1 (obra has 304/355 commits), community PRs pile up unmerged.

#### GitHub Spec Kit

- **Stars:** 76,600 | **Forks:** 6,500 | **Open Issues:** 528
- **What it does:** Specification-driven development: Constitution → Specify → Plan → Tasks → Implement. 20+ agent support.
- **Top issues:** CLI failures, tool integration requests, monorepo support, brownfield adoption pain, release stability.
- **What it has that Forge lacks:** GitHub backing, Constitution concept, massive cross-agent compatibility, Python CLI tooling.
- **What Forge has that it lacks:** Enforcement (specs are advisory), evidence gates, state management, post-implementation quality gates, risk tiers, multi-agent execution, TDD enforcement. Brownfield adoption documented weakness (#164, #1436).

#### Gastown (Steve Yegge)

- **Stars:** 12,000 | **Forks:** 1,000 | **Open Issues:** 108
- **What it does:** Multi-agent orchestration: Mayor coordinates Polecats via Convoys of Beads. Persistent agent identity.
- **What it has that Forge lacks:** Persistent agent identity across crashes, OpenTelemetry, 20-30+ agent scale, versioned SQL state.
- **What Forge has that it lacks:** Lightweight infrastructure, stability (documented fragility in 9 categories), simpler adoption path, risk-scaled ceremony, evidence gates.

#### GNAP (Git-Native Agent Protocol)

- **Stars:** 14 | Created March 2026
- **What it does:** Protocol specification for coordinating AI agents through shared git repos. 4 JSON entities in `.gnap/`. Zero infrastructure.
- **Assessment:** Coordination protocol, not methodology — complementary to Forge, not competitive.
- **Ideas to borrow:** Cost/token tracking per run, git-native audit trail, human-AI parity.

### B.2 General-Purpose Coding Agents

| Project | Stars | Key Strength | What Forge Has That It Lacks |
|---------|-------|-------------|------------------------------|
| **Claude Code** | 77,600 | First-party Anthropic, hooks, experimental teams | Structured phases, risk-scaled ceremony, evidence gates, persistent state |
| **OpenHands** | 69,100 | SWEBench 77.6%, composable SDK, cloud scaling | Workflow phases, enforcement, TDD |
| **Codex CLI** | 65,100 | Kernel sandboxing, AGENTS.md standard | Phases, enforcement, evidence model |
| **Cline** | 59,000 | VS Code native, browser automation, enterprise SSO | Structured workflow, TDD enforcement |
| **Aider** | 41,900 | Semantic repo mapping, 100+ languages, 5.3M installs | Phases, enforcement, multi-agent teams |
| **Goose** | 33,000 | Rust performance, MCP-native, desktop app | Phases, TDD, evidence, risk classification |
| **Plandex** | 15,100 | Cumulative diff sandbox, version branching | Multi-agent, enforcement, risk tiers |

### B.3 Feature Comparison (Detailed)

| Feature | Forge | Superpowers | Spec Kit | Gastown | Claude Code | Aider | Cline | OpenHands |
|---------|:-----:|:-----------:|:--------:|:-------:|:-----------:|:-----:|:-----:|:---------:|
| Structured phases | 6 | 7 | 5 | 3 | — | — | — | — |
| Enforcement gates | Evidence | — | — | Partial | Hooks | — | Approval | — |
| Risk tiers | 4 | — | — | — | — | — | — | — |
| Multi-agent teams | Persistent | — | — | 20-30+ | Experimental | — | — | SDK |
| TDD enforcement | RED/GREEN/REFACTOR | Prompt | — | — | — | Lint/test | — | — |
| Persistent state | SQLite+JSON | — | — | Dolt+Git | Task list | — | Checkpoints | Sessions |
| Extensibility | Packs | — | — | Formulas | Plugins | — | MCP | Python SDK |
| Intent routing | Auto | — | Slash cmds | Mayor | — | — | — | — |
| Verification | Connected | Orphaned | — | Fragile | — | — | — | — |
| Platform support | 5 | 5 | 20+ | Multi | Terminal | Terminal+IDE | VS Code | CLI+GUI+Cloud |
| Repo mapping | — | — | — | — | — | Full | Context | RepoMap |
| Browser automation | — | — | — | — | — | — | Full | Full |

---

## Appendix C: Issue and PR Signal Summary

### C.1 Superpowers Signals

| Signal | Examples | Forge Implication |
|--------|----------|-------------------|
| Users want lighter ceremony | Worktrees optional, review overhead, overlong plans | Risk-scaled depth must be real |
| Users want broader host support | Codex plugin, Cursor interest, Gemini issues | Interop must stay first-class |
| Reliability matters | Windows hooks, startup freeze, incorrect success reporting | Beta must over-invest in correctness |
| Hardening contributions | Windows fixes, install fixes, skill review automation | Prioritize boring productization |

### C.2 Spec Kit Signals

| Signal | Examples | Forge Implication |
|--------|----------|-------------------|
| Brownfield adoption is a pain point | Initialize in current repo, brownfield analysis, sync without overwrite | `forge adopt` and `forge sync` are core |
| Generated context can be destructive | `CLAUDE.md` overwrite reports | Safe update semantics mandatory |
| Post-implementation repair flows | Debugging after implementation | Bug fix and incident workflows matter |
| Eval and agent support investment | Eval infra, PR evals, more agents, shell support | Audit/eval infrastructure in Beta |

### C.3 Cline and Codex Signals

| Signal | Examples | Forge Implication |
|--------|----------|-------------------|
| Provider and auth friction | Provider selection, auth loops, endpoint fixes | Host-specific docs and diagnostics |
| Workspace topology matters | Path separators, multi-root workspace issues | Brownfield adoption must be conservative |
| Telemetry/bridge work ongoing | Telemetry and host bridge PRs | Audit should stay host-aware |

### C.4 Aider and OpenHands Signals

| Signal | Examples | Forge Implication |
|--------|----------|-------------------|
| Provider/model churn is constant | Model support PRs, cost calc updates | Stay host-agnostic where possible |
| Robustness is continuous work | Retries, model listing, startup failures | Bias toward safe degradation |
| Eval/observability interest rising | Benchmark work, observability integrations | Keep audit schema stable |

---

## Appendix D: Audit Event Schema

### D.1 Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `timestamp` | string | ISO 8601 |
| `session_id` | string | Unique session identifier |
| `host` | string | claude-code, cursor, codex, opencode, gemini |
| `workflow` | string | Public workflow name (adopt-repo, start-feature, etc.) |
| `skill` | string | Active skill, if any |
| `action_type` | enum | session_start, routing_decision, skill_enter, skill_exit, gate_check, approval_request, approval_resolution, agent_dispatch, agent_join, verification_result, task_completion_summary |
| `action_detail` | object | Structured payload (varies by action_type) |
| `risk_tier` | enum | minimal, standard, elevated, critical |
| `outcome` | enum | success, failure, skipped, denied |
| `duration_ms` | int | Wall-clock duration if applicable |
| `tokens_in` | int | Estimated or reported input tokens |
| `tokens_out` | int | Estimated or reported output tokens |
| `cost_estimate_usd` | float? | Optional cost estimate when available |
| `deviation_id` | string? | Optional link to deviation record |
| `repo_state_ref` | string? | Optional checkpoint or branch identifier |

### D.2 Example Event

```json
{
  "timestamp": "2026-03-14T18:12:04Z",
  "session_id": "sess_20260314_181204_01",
  "host": "claude-code",
  "workflow": "adopt-repo",
  "skill": "adopting-forge",
  "action_type": "skill_exit",
  "action_detail": {
    "generated_files": [
      ".forge/project.yaml",
      ".forge/policies/default.yaml",
      "CLAUDE.md"
    ]
  },
  "risk_tier": "standard",
  "outcome": "success",
  "duration_ms": 48213,
  "tokens_in": 10244,
  "tokens_out": 3611,
  "cost_estimate_usd": null,
  "deviation_id": null,
  "repo_state_ref": "branch:main"
}
```

---

## Appendix E: Reference Project Specifications

### E.1 Task Tracker API

**Type:** Backend REST API (Node.js or Python)
**Starting state:** Empty directory
**Feature requests:**
1. "Create a task tracker API with CRUD endpoints for tasks (title, description, status, assignee)"
2. "Add JWT authentication — only authenticated users can create/update tasks"
3. Bug: "Tasks with status 'done' can still be updated — they should be immutable"

**Workflows exercised:** Adopt repo, Start feature (x2), Fix bug
**Risk tiers:** standard (CRUD), elevated (auth/JWT)
**Agents needed:** backend-engineer, qa-engineer, security-reviewer
**Estimated duration:** 30-45 min (auto mode)

---

### E.2 Dashboard UI

**Type:** Frontend SPA (React or Vue)
**Starting state:** Empty directory
**Feature requests:**
1. "Build a dashboard with a sidebar nav, header, and main content area showing a card grid"
2. "Add a dark mode toggle that persists to localStorage"
3. Review: "Review the component structure for accessibility and reusability"

**Workflows exercised:** Adopt repo, Start feature (x2), Review change
**Risk tiers:** minimal (UI), standard (state management)
**Agents needed:** frontend-engineer, qa-engineer, code-reviewer
**Estimated duration:** 20-30 min (auto mode)

---

### E.3 CLI Migration Tool

**Type:** CLI tool with database migrations (Python or Go)
**Starting state:** Empty directory
**Feature requests:**
1. "Create a CLI tool that manages database schema migrations — up, down, status commands"
2. "Add a 'seed' command that populates test data from a YAML fixture file"
3. Bug: "Running 'down' twice on the same migration causes a crash instead of a no-op"

**Workflows exercised:** Adopt repo, Start feature (x2), Fix bug
**Risk tiers:** elevated (migrations), critical (data integrity on rollback)
**Agents needed:** database-specialist, implementer, qa-engineer
**Estimated duration:** 30-40 min (auto mode)

---

### E.4 Deploy Pipeline

**Type:** Infrastructure (Docker + GitHub Actions)
**Starting state:** Provided skeleton (simple Node.js app with no deployment)
**Feature requests:**
1. "Add a Dockerfile and docker-compose.yml for local development"
2. "Create a GitHub Actions CI pipeline: lint, test, build, and deploy to staging"
3. Incident: "The staging deploy is failing because the health check endpoint returns 503 after deploy — investigate"

**Workflows exercised:** Adopt repo, Start feature (x2), Investigate incident
**Risk tiers:** elevated (infrastructure), critical (secrets in CI config)
**Agents needed:** devops-engineer, security-reviewer, architect
**Estimated duration:** 25-35 min (auto mode)

---

### E.5 Auth Service

**Type:** Security-critical backend (Node.js or Go)
**Starting state:** Empty directory
**Feature requests:**
1. "Build an auth service with signup, login, token refresh, and logout endpoints"
2. "Add role-based access control (RBAC) with admin, editor, and viewer roles"
3. Refactor: "The password hashing uses MD5 — refactor to bcrypt with proper salt rounds"

**Workflows exercised:** Adopt repo, Start feature (x2), Refactor safely
**Risk tiers:** critical (auth, tokens, password handling, encryption)
**Agents needed:** security-reviewer, backend-engineer, architect, qa-engineer
**Estimated duration:** 35-50 min (auto mode)

---

### E.6 Full-Stack Notes App

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
**Estimated duration:** 60-90 min (auto mode, multi-session)

---

## Appendix F: Agent Gap Analysis

### F.1 Current Agent Coverage Map

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

Legend: dispatch = agent is spawned for this skill
        ref = agent is referenced but not spawned
        scan = agent definition is discovered
        · = not involved
```

### F.2 Referenced but Undefined Agents

| Referenced Role | Referenced In | Agent Exists? |
|----------------|--------------|---------------|
| frontend-engineer | composing-teams (example) | **No** |
| backend-engineer | composing-teams (example) | **No** |
| database-specialist | risk policy (db/migrations/ = critical) | **No** |
| devops-engineer | adopting-forge (.github/workflows/) | **No** |

### F.3 Proposed New Agent Capabilities

| Agent | Model | Tools | Key Responsibilities |
|-------|-------|-------|---------------------|
| **frontend-engineer** | opus | Read, Write, Edit, Bash, Glob, Grep | Component design, accessibility (WCAG), browser compat, UI testing, rendering/bundle performance |
| **backend-engineer** | opus | Read, Write, Edit, Bash, Glob, Grep | API design, database integration, scalability patterns, error handling, auth integration |
| **database-specialist** | opus | Read, Write, Edit, Bash, Glob, Grep | Schema design, migration safety, backward compat, rollback plans, query performance, data integrity |
| **devops-engineer** | opus | Read, Write, Edit, Bash, Glob, Grep | CI/CD pipelines, container config, secrets management, infrastructure-as-code, deployment verification |
| **technical-writer** | opus | Read, Write, Edit, Bash, Glob, Grep | Design doc clarity, API documentation, user guides, changelog quality |

### F.4 Risk Tier Coverage After Expansion

| Risk Tier | Current Coverage | After Expansion |
|-----------|-----------------|-----------------|
| **Critical** | security-reviewer | + database-specialist (migrations), devops-engineer (secrets), backend-engineer (auth) |
| **Elevated** | code-reviewer, qa-engineer | + frontend-engineer (accessibility), backend-engineer (API contracts), database-specialist (schema) |
| **Standard** | implementer, code-reviewer | Adequate |
| **Minimal** | implementer | Adequate |

---

## Appendix G: Deviation Worklog

This log tracks all deviations from expected Forge behavior observed during Beta development. Entries are added as they occur. The log is maintained manually during v0.2.0–v0.3.0 development and transitions to automated audit in v0.4.0.

| # | Version | Skill | Expected | Actual | Severity | Root Cause | Fix Target | Status |
|---|---------|-------|----------|--------|----------|------------|------------|--------|
| 1 | v0.2.0-dev | `brainstorming` | Design doc written to `docs/<project>/design/design.md` | Skill hardcodes `docs/plans/<project>/design.md` — wrong directory structure | friction | Skill text uses incorrect path convention | v0.2.0 | open |
| 2 | v0.2.0-dev | repo structure | Product artifacts at top level (like `agents/`, `skills/`, `hooks/`) | Product tools (`bin/`, `policies/`, `adapters/`, `workflows/`, `packs/`) nested inside `.forge/`, mixing product infra with per-project config | friction | Inherited from upstream; `.forge/` was treated as a catch-all | v0.2.0 | open |
| 3 | v0.2.0-dev | `setting-up-project` | Elevated tier requires worktree creation | Skipped worktree — developing Beta directly on main with backup branch `forge-v0.1.1-baseline` instead. Worktree adds complexity without benefit when there are no external users. | cosmetic | Skill assumes all elevated work needs isolation; dogfooding on own repo is a special case | v0.3.0 | deferred |
| 4 | v0.2.0-dev | `setting-up-project` | When team criteria met, invoke `forge:composing-teams` for structured team composition with specialist recommendations | Skipped composing-teams entirely. Set `team.decision = team` and improvised team structure during plan execution. No agent-to-task mapping was presented, no specialist suggestions, no user review of team composition. | friction | Lead skipped the composition step, likely because the skill says "invoke composing-teams" but there was no enforcement gate. The composing-teams skill should present agent options and get user approval before planning. | v0.3.0 | open |
| 5 | v0.2.0-dev | `agent-team-driven-development` | Two-stage review (spec + code quality) dispatched as subagents per task | Skipped subagent reviews for Wave 0. Tasks were mechanical (find-replace, grep-verified) — spawning 4 review subagents for 14 line changes would be pure overhead. | cosmetic | Review ceremony doesn't scale down for mechanical tasks. Risk-tier-aware review should allow lighter ceremony when verification is grep-based and evidence is clear. | v0.3.0 | deferred |
| 6 | v0.2.0-dev | `agent-team-driven-development` | Clean, minimal commit history | Multi-agent execution produces excessive commits (40-50 for complex features). Each agent working commit pollutes git history. | friction | No squash-on-merge strategy exists. Agents commit freely in worktrees and all commits land on main. Need one commit per complete change. | v0.3.0 | open |
| 7 | v0.2.0-dev | `agent-team-driven-development` | Completed tasks and shutdown agents show clean state — no stale `in_progress` tasks, no orphaned agents | After Wave 0, T1/T2 tasks and agent tasks (#8/#9) remained `in_progress` despite work being done and merged. Shutdown requests were sent but task status wasn't fully cleaned up. Lead had to manually reconcile. | friction | Task cleanup sequence is fragile. Shutdown + TaskUpdate + agent-specific task cleanup need to be atomic or at least reliably sequenced. The skill says to clean up tasks before shutdown but this didn't happen cleanly. | v0.3.0 | open |
| 8 | v0.2.0-dev | `agent-team-driven-development` | Clear status visibility during multi-agent execution | Status line shows only "Idle/teammates running" with no detail on which agents are working on which tasks, or which are done. No way to see progress at a glance. | friction | The skill has no status reporting mechanism. Need a checklist-style status view showing agent-to-task mapping with WIP/done indicators. | v0.3.0 | open |

---

## Closing Note

This draft synthesizes the best of drafts 1 and 2:

- From draft 1: detailed competitive analysis, full reference project specs, permission manifest schema, running deviation log, token tracking integration points
- From draft 2: staged versioning, product thesis clarity, safe update semantics, execution ergonomics, controlled auto mode framing, hardening phase, v1.0 vision

The sequence is:

1. Make Forge look trustworthy (v0.2.0)
2. Make Forge adopt real repos (v0.3.0)
3. Make Forge observe itself (v0.4.0)
4. Harden the loop (v0.5.0)
5. Ship a production-ready v1.0

That sequence matches both the current repo state and the learning loop now that Forge is building Forge.
