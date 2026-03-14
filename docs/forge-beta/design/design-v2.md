# Forge Beta Design Document

**Version:** Draft 2
**Date:** 2026-03-14
**Status:** Awaiting review
**Scope:** MVP (v0.1.x) -> Beta (v0.2.0, v0.3.0, v0.4.0, v0.5.0) -> v1.0

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Product Thesis and Current State Assessment](#2-product-thesis-and-current-state-assessment)
3. [Competitive Landscape and External Signals](#3-competitive-landscape-and-external-signals)
4. [Versioning Strategy](#4-versioning-strategy)
5. [Beta Goals and Non-Goals](#5-beta-goals-and-non-goals)
6. [Work Stream 1: Identity, Trust, and Public Surface](#6-work-stream-1-identity-trust-and-public-surface)
7. [Work Stream 2: Outcome-First Documentation and Onboarding](#7-work-stream-2-outcome-first-documentation-and-onboarding)
8. [Work Stream 3: Brownfield Adoption Core](#8-work-stream-3-brownfield-adoption-core)
9. [Work Stream 4: Agent Roster and Execution Ergonomics](#9-work-stream-4-agent-roster-and-execution-ergonomics)
10. [Work Stream 5: Audit, Deviation Logging, and Analysis](#10-work-stream-5-audit-deviation-logging-and-analysis)
11. [Work Stream 6: Reference Project Suite and Controlled Auto Mode](#11-work-stream-6-reference-project-suite-and-controlled-auto-mode)
12. [Work Stream 7: Reliability, Verification, and Beta Hardening](#12-work-stream-7-reliability-verification-and-beta-hardening)
13. [Forge v1.0 Production Vision](#13-forge-v10-production-vision)
14. [Comparison Chart](#14-comparison-chart)
15. [Metrics and Exit Criteria by Version](#15-metrics-and-exit-criteria-by-version)
16. [Risk Register](#16-risk-register)
17. [Appendix A: Immediate Cleanup Audit](#appendix-a-immediate-cleanup-audit)
18. [Appendix B: Issue and PR Signal Summary](#appendix-b-issue-and-pr-signal-summary)
19. [Appendix C: Proposed Audit Event Schema](#appendix-c-proposed-audit-event-schema)
20. [Appendix D: Reference Project Roadmap](#appendix-d-reference-project-roadmap)

---

## 1. Executive Summary

Forge v0.1.x proves that the core product direction is real. The repo already contains a strong workflow backbone, early evidence gates, risk classification, persistent state, multi-agent primitives, and multi-harness ambition.

What it does not yet provide is a complete product experience for someone who is not already inside the project. Today, Forge is credible as an internal MVP, but not yet trustworthy as a public operating mode.

The Beta should therefore be staged rather than treated as one monolithic jump to v0.5.0.

The recommended Beta progression is:

| Version | Theme | Primary Outcome |
|---------|-------|-----------------|
| **v0.2.0** | Trust and identity | Forge looks and installs like Forge |
| **v0.3.0** | Adoption and workflow packaging | Forge can adopt a real repo and guide work by outcomes |
| **v0.4.0** | Audit and self-analysis | Forge can observe and analyze how Forge is being used |
| **v0.5.0** | Hardening and controlled automation | Forge Beta is reliable, measurable, and dogfood-proven |

This sequencing keeps the plan ambitious without forcing every future idea into the first Beta milestone.

A key adjustment from Draft 1 is that **audit and analysis remain Beta-critical**, not because Forge should become a dashboard product, but because Forge is now building Forge inside Claude Code. If the product cannot explain what it did, where it deviated, and why a workflow succeeded or failed, it will not improve fast enough.

The Beta goal can be stated simply:

> Forge Beta should make the product understandable, adoptable, and analyzable in real repositories.

And v1.0 can be stated just as clearly:

> Forge v1.0 should be the production-ready operating mode for AI-assisted software development in real repos, with durable memory, risk-scaled ceremony, generated harness guidance, and reviewable evidence.

---

## 2. Product Thesis and Current State Assessment

### 2.1 Product Thesis

Forge is an **adoptable operating mode** for AI-assisted software development.

It is not primarily a marketplace of skills, and it is not an autonomous production operator.

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
| Workflow backbone | Strong | Design -> plan -> execute -> verify is the right spine |
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
| Audit model | Missing as a stable product abstraction | Dogfooding loses its most valuable signal |
| Low-risk path | Not yet visibly light | The product can feel heavier than it should |

### 2.4 Product Interpretation of the Current Repo

The current repo should be understood as a **foundation release**, not as an almost-finished public product.

That is good news. It means the next step is not random feature accumulation. The next step is packaging the foundation into a trustworthy system:

1. a canonical public surface
2. a real repo adoption flow
3. a stable artifact model
4. measurable audit and analysis
5. a phased Beta plan that respects scope

---

## 3. Competitive Landscape and External Signals

### 3.1 The Field

Forge competes indirectly with two classes of products:

1. **Structured workflow systems** such as Superpowers and Spec Kit
2. **General-purpose coding agents** such as Claude Code, Codex, Cline, Aider, and OpenHands

Forge should not try to win by matching every feature in those systems.

Forge should win by occupying the space between them:

- more structured than general-purpose agents
- less document-heavy than spec-first frameworks
- safer and more reviewable than high-autonomy agents
- more brownfield-friendly than greenfield-first toolkits

### 3.2 Forge Positioning

Forge's durable position is:

> the risk-aware, evidence-first operating mode for AI-assisted engineering in real repositories.

That means the most important product tasks are:

- brownfield adoption
- safe update and sync behavior
- explicit risk and evidence policies
- resumable state and durable project memory
- auditability of real work

### 3.3 Signals from Issue and PR Traffic

The strongest product signals do not come from Forge's own queue yet. They come from adjacent ecosystems.

#### Signal 1: Brownfield adoption is one of the highest-value problems

Users repeatedly ask how to use structured AI workflows on existing repositories, how to keep generated artifacts synchronized, and how to avoid overwriting local project context.

**Implication for Forge:** `forge adopt`, `forge sync`, and safe context generation are not secondary features. They are the product wedge.

#### Signal 2: Users want less mandatory ceremony for low-risk work

Requests around optional worktrees, overlong plans, and excessive subagent review loops show that users want structure, but not maximum ceremony for every task.

**Implication for Forge:** risk-scaled workflow depth must be real in practice, not just a philosophy section.

#### Signal 3: Reliability beats ambition

Installation failures, startup freezes, provider selection bugs, path handling issues, and context corruption appear across many tools.

**Implication for Forge:** Beta should bias toward install correctness, host compatibility, state integrity, and safe update behavior before chasing advanced autonomy.

#### Signal 4: Interoperability and generated context matter

Across adjacent projects, contributors are investing in support for new agents, shells, providers, and integration surfaces.

**Implication for Forge:** generated `CLAUDE.md` and `AGENTS.md` should move into Beta, not wait for v1.0.

#### Signal 5: Audit and evaluation are becoming table stakes

Multiple projects are moving toward telemetry, eval runs, PR evals, or explicit observability features.

**Implication for Forge:** file-first audit, deviation analysis, and reference project comparisons are worth pulling into Beta, as long as the implementation stays lightweight and local-first.

### 3.4 Competitive Design Principle

The right competitive behavior for Forge is:

- borrow reliability ideas aggressively
- borrow interop ideas early
- borrow observability ideas carefully
- avoid becoming a browser-automation race or a benchmark vanity project during Beta

---

## 4. Versioning Strategy

Draft 1 treated Beta as one large bucket. Draft 2 breaks Beta into progressive releases.

### 4.1 Why a Staged Beta

A staged Beta does three useful things:

1. It creates a realistic path for shipping visible progress.
2. It separates trust work from deeper orchestration work.
3. It lets audit and dogfooding improve the next Beta cut instead of arriving too late.

### 4.2 Recommended Beta Sequence

| Version | Focus | Must be true at release |
|---------|-------|-------------------------|
| **v0.2.0** | Trust and packaging | Canonical Forge identity, install docs, README, verify path, self-description |
| **v0.3.0** | Adoption and workflow surface | `forge adopt` works on real repos, 8 workflows are surfaced, `CLAUDE.md` and `AGENTS.md` generation exists |
| **v0.4.0** | Audit and analysis | Audit JSONL exists, deviation logging is formalized, analysis skill works on real Forge runs |
| **v0.5.0** | Beta hardening | Reference suite is stable, controlled auto mode exists for dogfood runs, blockers are closed |
| **v1.0** | Production-ready release | Stable operating modes, safe update paths, documented support matrix, reliable upgrade story |

### 4.3 Feature Placement Philosophy

The rule for placement should be:

- if a feature is required for **adoption**, it belongs in early Beta
- if a feature is required for **learning from dogfood usage**, it belongs in Beta
- if a feature is required for **unbounded autonomy or ecosystem scale**, it can wait for v1.0 or later

Under that rule:

- `forge adopt` belongs in Beta
- `CLAUDE.md` generation belongs in Beta
- `AGENTS.md` generation belongs in Beta
- audit mode belongs in Beta
- analysis of audit logs belongs in Beta
- general-purpose full-auto mode does **not** belong in early Beta
- browser automation does **not** belong in Beta
- pack registry does **not** belong in Beta

---

## 5. Beta Goals and Non-Goals

### 5.1 Beta Goals

1. **Canonical Forge identity**
   - Zero stale public references to the old repo, except explicit attribution and historical materials.

2. **Adoptable public surface**
   - A new user can understand Forge from the README and run a concrete first workflow.

3. **Brownfield-first adoption**
   - Forge can infer repo basics, generate safe project artifacts, and avoid destructive overwrites.

4. **Outcome-first workflow UX**
   - Users see Forge as verbs such as adopt repo, start feature, fix bug, review change, and resume work.

5. **Real risk-scaled execution**
   - Low-risk tasks can stay light; high-risk tasks stay structured and evidence-gated.

6. **Audit and analysis as core dogfood tooling**
   - Forge can record, inspect, and analyze its own behavior while building Forge.

7. **Sufficient agent roster and execution ergonomics**
   - Team composition references only real agents, and multi-agent execution is not needlessly heavy.

8. **Reference-suite validation**
   - Beta quality is tested on a repeatable set of representative projects, not only on Forge itself.

### 5.2 Non-Goals for Beta

- Becoming an autonomous production operator
- Shipping dedicated IDE extensions outside current host environments
- Browser automation as a flagship feature
- Dashboard-first observability architecture
- General-purpose uncontrolled auto mode for arbitrary repos
- Remote pack registry or marketplace expansion
- Semantic repo mapping as a prerequisite for core adoption
- Benchmark marketing as the central product story

---

## 6. Work Stream 1: Identity, Trust, and Public Surface

**Primary release target:** v0.2.0

### 6.1 Objective

Make Forge look like a real product before asking anyone to trust it with a real repository.

### 6.2 Identity Cleanup

All user-facing references to old repo paths, install surfaces, support links, and contribution instructions must point to Forge.

This includes:

- plugin manifests
- README install paths
- Codex and OpenCode install documents
- docs references
- tests that still encode old paths
- contributor and support pointers

Attribution materials and historical planning artifacts should remain intact.

### 6.3 Repo Metadata and Trust Surface

Add the missing signals that tell a user this is a canonical project, not a private branch:

- repo description
- website or docs landing page when available
- topics
- issue templates
- PR template
- release tagging discipline
- support path that points to Forge itself

### 6.4 Forge Self-Description

Forge should describe itself with Forge artifacts:

- fill `.forge/shared/architecture.md`
- fill `.forge/shared/conventions.md`
- add at least one real ADR in `.forge/shared/decisions/`

This is not only documentation. It is a dogfooding requirement.

### 6.5 Exit Criteria for v0.2.0 Under This Work Stream

- No stale public install/support links remain outside approved attribution/history exceptions.
- Contributors can follow Forge-native contribution guidance.
- The repo metadata looks canonical.
- Forge contains a real architecture doc, conventions doc, and at least one ADR for itself.

---

## 7. Work Stream 2: Outcome-First Documentation and Onboarding

**Primary release target:** v0.2.0

### 7.1 Objective

Explain Forge the way users think, not the way the implementation is arranged.

### 7.2 README Restructure

The README should be rewritten around outcomes.

**Recommended structure:**

```text
# Forge
One-paragraph product pitch

## Why Forge
## Quick Start
## The 8 Workflows
## Risk-Scaled Ceremony
## How Forge Adopts a Repo
## Installation
## Verify Installation
## Infrastructure and Artifacts
## Agent Roster
## Extending Forge
## Philosophy
## Attribution
```

### 7.3 The 8 Outcome Workflows

These should be the public UX layer:

1. Adopt a repo
2. Start a feature
3. Fix a bug
4. Refactor safely
5. Review a change
6. Resume work
7. Prepare a release
8. Investigate an incident

Each workflow should show:

- what the user says
- what Forge does
- what artifacts appear
- what verification is required

### 7.4 Visual Flow

A workflow map should show how shared skills compose into visible outcomes.

A Mermaid diagram is sufficient for Beta. The point is clarity, not design polish.

### 7.5 Verify Installation

Replace vague verification guidance with a real check:

- a copy-paste prompt per host
- expected visible behavior
- troubleshooting for common failures

### 7.6 Onboarding Walkthrough

The README should include a first 10 minute walkthrough:

1. install Forge
2. open an existing project
3. say "Set up Forge in this repo"
4. review generated artifacts
5. say "Add X" or "Fix Y"
6. observe design, plan, execution, and verification

### 7.7 Exit Criteria for v0.2.0 Under This Work Stream

- A new user can understand Forge from the README alone.
- The 8 workflows are documented publicly.
- There is a concrete verify-install flow for each supported host.
- There is one concrete first-run walkthrough that can be tested.

---

## 8. Work Stream 3: Brownfield Adoption Core

**Primary release target:** v0.3.0

### 8.1 Objective

Make `forge adopt` the core product capability, not a shell around templates.

### 8.2 Product Contract for `forge adopt`

`forge adopt` should:

1. inspect the repo
2. infer stack, commands, and risk areas conservatively
3. detect existing AI-facing files and docs
4. preview generated changes
5. preserve user-owned context whenever possible
6. create a working Forge surface, not a blank scaffold

### 8.3 Generated Artifact Model

**Shared checked-in surface:**

- `.forge/project.yaml`
- `.forge/policies/default.yaml`
- `.forge/shared/architecture.md`
- `.forge/shared/conventions.md`
- `.forge/shared/decisions/`
- generated `CLAUDE.md` or managed Forge section
- generated `AGENTS.md` or managed Forge section

**Local non-checked-in surface:**

- `.forge/local/state/`
- `.forge/local/checkpoints/`
- `.forge/local/memory/`
- `.forge/local/audit/`
- `.forge/local/permissions/`

### 8.4 Safe Update Semantics

One of the most important product lessons from adjacent tools is that generated context files must not clobber user-written project guidance.

Forge should therefore adopt one of two safe strategies:

1. **managed block strategy**
   - update only within explicit generated markers
2. **split file strategy**
   - generate `CLAUDE.forge.md` and `AGENTS.forge.md`, then include or reference them

For Beta, either approach is acceptable. Full-file overwrite is not.

### 8.5 Inference Scope for Beta

Required inference for Beta:

- package manager
- test command
- lint command
- formatter if obvious
- CI surface if obvious
- repo type and major language stack
- elevated or critical paths such as migrations, auth, secrets, workflows, infra

Nice-to-have but not required for Beta:

- confidence scoring
- repo topology classification beyond basic use
- semantic architecture inference

### 8.6 Routing and Resume Behavior

`forge-routing` should be upgraded to support the public workflows, including:

- resume work when state exists
- prepare release
- adopt repo
- safer behavior when intent is ambiguous

### 8.7 `forge sync` and `forge doctor`

Adoption is not enough. Users need maintenance commands:

- `forge sync` regenerates managed artifacts safely
- `forge doctor` validates state, adapters, generated files, and common misconfiguration

### 8.8 Exit Criteria for v0.3.0 Under This Work Stream

- `forge adopt` works on representative existing repos.
- `project.yaml` is populated with useful defaults.
- `CLAUDE.md` and `AGENTS.md` generation exist in a non-destructive form.
- `forge sync` has safe update semantics.
- `forge doctor` can diagnose common installation and state problems.

---

## 9. Work Stream 4: Agent Roster and Execution Ergonomics

**Primary release target:** v0.3.0

### 9.1 Objective

Make team mode honest, useful, and lighter where it should be lighter.

### 9.2 Required Agent Additions

The roster should cover the specialist roles already implied by the workflows.

**Required for Beta:**

- frontend-engineer
- backend-engineer
- database-specialist
- devops-engineer

**Useful if time permits in Beta:**

- technical-writer

**Likely v1.0 or later:**

- performance-engineer
- data-engineer
- compliance-specialist

### 9.3 Execution Ergonomics

Forge should respond to real user friction around ceremony.

Recommended Beta adjustments:

- make worktrees optional for minimal-risk work
- provide a clear single-agent execution path for small tasks
- reduce review chatter between subagents when risk does not justify it
- keep heavy review loops for elevated and critical work
- support multi-repo workflows conservatively rather than pretending they are already solved

### 9.4 Public Principle

The public message should become:

> Forge is strict when the work is risky and light when the work is small.

That should be true in both docs and implementation.

### 9.5 Exit Criteria for v0.3.0 Under This Work Stream

- Every documented specialist role exists as a real agent definition.
- Minimal-risk work can run without mandatory worktree creation.
- Users can choose between lighter and deeper execution strategies within policy.
- Multi-agent execution feels purposeful rather than performative.

---

## 10. Work Stream 5: Audit, Deviation Logging, and Analysis

**Primary release target:** v0.4.0

### 10.1 Objective

Make Forge capable of explaining how it behaved while building Forge.

### 10.2 Why This Belongs in Beta

Forge is currently being built with Forge inside Claude Code.

That changes the priority of audit work. Audit is not a vanity feature. It is the shortest path to finding workflow drift, tool friction, host-specific failures, and prompt non-compliance before v1.0.

### 10.3 Audit Layers

Forge should treat audit as three related layers.

#### Layer 1: Deviation log

A lightweight log of places where expected and actual behavior diverged.

Fields:

- skill or workflow
- expected behavior
- actual behavior
- severity
- root cause guess
- fix target
- status

#### Layer 2: Structured event audit

Append-only JSONL events for significant workflow actions.

Required event types for Beta:

- session start
- routing decision
- skill enter
- skill exit
- gate check
- approval request
- approval resolution
- agent dispatch
- agent join
- verification result
- task completion summary

Tool-level audit can start conservative in Beta and expand later.

#### Layer 3: Analysis outputs

Machine-readable metrics plus human-readable reports that summarize:

- workflow compliance
- approval friction
- token and time use
- repeated deviations
- agent utilization
- regression across runs

### 10.4 Design Constraints

Audit in Beta should be:

- local-first
- file-first
- append-only
- opt-in where appropriate
- cheap to record
- easy to analyze with Forge itself

Audit in Beta should **not** require:

- a hosted backend
- a dashboard service
- cross-user telemetry collection
- auto-submitted data

### 10.5 Proposed Beta Outputs

- `.forge/local/audit/<session-id>.jsonl`
- `.forge/local/audit/metrics.jsonl`
- `docs/forge-beta/audits/<date>-<run>.md`
- deviation log in repo or local state, depending on privacy choice

### 10.6 Analysis Skill

Add a new skill such as `forge:analyzing-audit`.

Inputs:

- one or more audit JSONL files
- optional previous run metrics
- optional deviation log

Outputs:

- summary of workflow compliance
- top friction sources
- missing or skipped artifacts
- suggested skill and workflow fixes
- regression comparison when prior runs exist

### 10.7 Cost and Duration Tracking

Cost and duration tracking should sit inside audit rather than arrive as a separate half-feature.

Minimum viable fields:

- tokens_in
- tokens_out
- duration_ms
- optional cost_estimate_usd when host data is available

### 10.8 Exit Criteria for v0.4.0 Under This Work Stream

- Audit events exist for major workflow transitions.
- Deviation logging is standardized.
- A Forge analysis skill can summarize at least one real Forge-on-Forge run.
- Token and duration data are captured in a lightweight way.
- Verification can surface a task-level audit summary.

---

## 11. Work Stream 6: Reference Project Suite and Controlled Auto Mode

**Primary release target:** v0.4.0 and v0.5.0

### 11.1 Objective

Validate Forge on a fixed set of representative repos instead of relying only on the Forge repo itself.

### 11.2 Staged Reference Suite

Draft 1 proposed six reference projects immediately. Draft 2 keeps the six-project target but stages it.

#### v0.4.0 core suite

Three projects are enough to start learning:

1. backend service
2. frontend app
3. migration or infra-heavy repo

#### v0.5.0 expanded suite

Expand to six projects:

1. task tracker API
2. dashboard UI
3. CLI migration tool
4. deploy pipeline project
5. auth service
6. full-stack notes app

### 11.3 Controlled Auto Mode

Full auto mode is valuable for the reference suite, but too risky to position as a general Beta promise.

For Beta, it should be framed as:

> controlled auto mode for trusted dogfood and reference-suite runs

Key constraints:

- permission manifest is explicit
- deny-by-default for destructive actions
- approvals are still required outside approved patterns
- manifests are repo- and workflow-scoped
- agents inherit only the approved permission set

### 11.4 Run Comparison

Each suite run should produce comparable metrics:

- total tokens
- total duration
- approval count
- gate pass rate
- deviation count
- workflow compliance
- agent utilization
- verification success rate

### 11.5 Design Rule

Reference projects exist to improve Forge, not to turn Forge into a benchmark theater.

The suite should be small, repeatable, and directly tied to product decisions.

### 11.6 Exit Criteria

**v0.4.0**

- Three reference projects exist and can be run repeatedly.
- Audit and comparison work on those runs.
- Controlled auto mode exists in preview form for the suite.

**v0.5.0**

- Six reference projects exist.
- Coverage spans all public workflows and all risk tiers.
- Run-over-run comparison is stable enough to catch regressions.

---

## 12. Work Stream 7: Reliability, Verification, and Beta Hardening

**Primary release target:** v0.5.0

### 12.1 Objective

Turn the staged Beta work into a trustworthy Beta release.

### 12.2 Hardening Priorities

1. install and verify flow per host
2. safe adoption on existing repos
3. safe regeneration of managed artifacts
4. state restoration and resume behavior
5. audit completeness for key workflow transitions
6. routing correctness for public workflows
7. risk-policy and evidence gate correctness

### 12.3 Beta Test Matrix

Forge should be tested across:

- supported hosts
- representative repo types
- minimal, standard, elevated, and critical changes
- single-agent and multi-agent execution paths
- resumed sessions
- safe sync updates

### 12.4 Beta Gate

Before calling Beta complete:

- blocker and friction deviations must be processed
- install docs must be verified against reality
- reference project regressions must be understood
- public docs must match actual behavior
- risky Beta-only experimental behavior must be clearly labeled

### 12.5 Exit Criteria for v0.5.0

- A new user can install Forge and verify it quickly.
- A real repo can be adopted without destructive context overwrite.
- Public workflows route correctly in representative scenarios.
- Audit and analysis work on real dogfood runs.
- Reference-suite runs provide stable regression signal.
- All known Beta blockers are closed or explicitly deferred with rationale.

---

## 13. Forge v1.0 Production Vision

### 13.1 Vision Statement

Forge v1.0 should be the production-ready operating mode for AI-assisted software development in real repositories.

It should be trusted for day-to-day engineering work because it is:

- understandable
- adoptable
- resumable
- auditable
- policy-aware
- evidence-backed
- cross-harness compatible

### 13.2 v1.0 User Promise

A team should be able to bring Forge into an existing repository and get:

- project-aware setup and generated context files
- reliable workflow routing for common engineering outcomes
- durable local memory and resumable checkpoints
- explicit risk and evidence policies
- safe updates to generated artifacts
- analysis of how work actually proceeded
- enough interop to work across major supported coding hosts

### 13.3 Required v1.0 Capabilities

#### 1. Stable operating modes

Formalize:

- ephemeral mode
- project mode
- adopted mode

#### 2. Stable canonical model and renderers

Forge should maintain a canonical internal model and render concise host-facing files such as:

- `CLAUDE.md`
- `AGENTS.md`
- other host-specific adapters where useful

#### 3. Safe adoption and sync lifecycle

`forge adopt`, `forge sync`, and `forge doctor` must feel production-safe.

#### 4. Mature risk and evidence model

Policy and evidence should be customizable, explicit, and stable.

#### 5. Mature audit and analysis loop

Audit must be useful enough to support product improvement, project retrospectives, and regression detection.

#### 6. Production-quality support matrix

Each supported host should have:

- documented install path
- verify path
- known limitations
- tested behavior guarantees

#### 7. Upgrade and migration story

v1.0 should include versioned artifact expectations and a safe path for upgrading existing Forge repos.

### 13.4 What v1.0 Is Not

Even at production readiness, Forge should remain:

- not an autonomous prod operator
- not a prompt marketplace
- not a document bureaucracy
- not a telemetry-first SaaS platform
- not a browser automation product with workflow features attached later

### 13.5 Production Readiness Criteria

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

## 14. Comparison Chart

This chart should stay capability-based and conservative.

| Capability | Forge | Superpowers | Spec Kit | Claude Code | Codex | Aider | Cline | OpenHands |
|-----------|:-----:|:-----------:|:--------:|:-----------:|:-----:|:-----:|:-----:|:---------:|
| Brownfield adoption as core UX | **Yes** | Partial | Partial | No | Partial | Yes | Partial | Partial |
| Outcome-first workflows | **Yes** | Partial | Yes | No | No | No | No | No |
| Risk-scaled ceremony | **Yes** | Limited | Limited | No | No | No | No | No |
| Evidence-gated completion | **Yes** | Partial | Partial | No | No | Partial | Partial | Partial |
| Generated harness guidance | **Yes** | Partial | Partial | No | Partial | No | No | No |
| Durable local project state | **Yes** | Partial | Partial | Limited | Limited | Limited | Partial | Partial |
| Audit trail for workflow behavior | **Beta** | Limited | Limited | Limited | Limited | Partial | Partial | Partial |
| Structured multi-agent execution | **Yes** | Partial | Emerging | Limited | Limited | No | Limited | Yes |
| Safe sync/update of generated context | **Planned core** | Limited | Partial | No | No | No | No | No |
| Reference-suite dogfooding | **Beta** | Limited | Emerging | No | No | Yes (benchmarks) | Limited | Yes |

---

## 15. Metrics and Exit Criteria by Version

### 15.1 v0.2.0 Metrics

- zero stale public install/support references outside allowed attribution/history files
- README rewrite complete
- one tested verify-install prompt per supported host
- Forge self-doc artifacts exist and are real

### 15.2 v0.3.0 Metrics

- `forge adopt` fills `project.yaml` with useful defaults on representative repos
- `CLAUDE.md` and `AGENTS.md` generation avoid full-file overwrite
- all 8 workflows are routed and documented
- required agent definitions exist
- minimal-risk work can avoid unnecessary worktree ceremony

### 15.3 v0.4.0 Metrics

- audit JSONL exists for key workflow events
- token and duration tracking exist in lightweight form
- at least one real Forge-on-Forge run analyzed by `forge:analyzing-audit`
- three reference projects are runnable and comparable

### 15.4 v0.5.0 Metrics

- six reference projects cover all workflows and risk tiers
- blocker and friction deviations are resolved or explicitly deferred
- controlled auto mode works for trusted suite runs
- routing, adoption, sync, resume, and verification are regression-tested

### 15.5 v1.0 Metrics

- stable support matrix published
- safe upgrade path documented
- operating modes formalized
- audit/analyze loop is useful for production teams, not only internal dogfooding

---

## 16. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Identity cleanup slips behind new feature work | High | High | Make v0.2.0 a packaging release with explicit stop-ship rules |
| `forge adopt` overwrites user context | Medium | Critical | Use managed blocks or split-file generation; never full overwrite |
| Audit becomes too heavy | Medium | Medium | Keep audit local-first, append-only, and schema-minimal in Beta |
| Multi-agent execution still feels too ceremonial | High | Medium | Add light execution paths and make worktrees optional for minimal risk |
| Dogfood bias hides external adoption issues | Medium | High | Use reference projects and external fixture repos, not only Forge |
| Controlled auto mode expands too early | Medium | High | Scope it to trusted reference-suite runs during Beta |
| Host-specific behavior diverges | High | High | Maintain per-host verify flows and known limitations |
| Audit data becomes noisy and not actionable | Medium | Medium | Standardize deviation fields and build analysis around repeated patterns |
| Scope creep pushes Beta forever | High | High | Keep version boundaries explicit and defer ecosystem-scale ideas |
| Name collision around "Forge" creates confusion | Medium | Medium | Final naming decision should happen before or during Beta hardening |

---

## Appendix A: Immediate Cleanup Audit

### Must Fix in Early Beta

| File | Issue |
|------|-------|
| `.claude-plugin/plugin.json` | homepage and repository URLs must point to Forge |
| `.cursor-plugin/plugin.json` | homepage and repository URLs must point to Forge |
| `README.md` | install URLs, fork guidance, and support links must point to Forge |
| `.codex/INSTALL.md` | clone URL, docs links, and issue links must point to Forge |
| `.opencode/INSTALL.md` | clone URL, docs links, and issue links must point to Forge |
| `docs/README.codex.md` | install and support links must point to Forge |
| `docs/README.opencode.md` | install and support links must point to Forge |
| `skills/brainstorming/scripts/frame-template.html` | companion link must point to Forge or a Forge-owned docs surface |
| `.github/workflows/test.yml.disabled` | workflow naming and repo-path references must be updated |
| `tests/integration/no-superpowers-references.sh` | encoded paths must be corrected |
| any support pointer to old issue tracker | must point to Forge issue tracker |

### Preserve As Historical or Attribution Materials

- `NOTICE.md`
- `ORIGINS.md`
- `LICENSE`
- `RELEASE-NOTES.md`
- historical planning docs that intentionally preserve lineage

---

## Appendix B: Issue and PR Signal Summary

This appendix is not a full market census. It is a product signal summary drawn from representative open and closed issues and PRs in adjacent repos.

### B.1 Superpowers Signals

| Signal | Examples | Forge implication |
|-------|----------|-------------------|
| Users want lighter ceremony | worktrees optional, review overhead, overlong plans | risk-scaled workflow depth must be real |
| Users want broader host support | Codex plugin requests, Cursor interest, Gemini issues | interop must stay first-class |
| Reliability matters | Windows hook issues, startup freeze, incorrect success reporting | Beta must over-invest in install and host correctness |
| Contributors are hardening the product | Windows fixes, install fixes, skill review automation, opt-in activation mode | Forge should prioritize boring productization work too |

### B.2 Spec Kit Signals

| Signal | Examples | Forge implication |
|-------|----------|-------------------|
| Existing repo adoption is a major pain point | initialize in current repo, brownfield analysis, sync without overwrite | `forge adopt` and `forge sync` are core product work |
| Generated context can be destructive | `CLAUDE.md` overwrite reports | safe update semantics are mandatory |
| Users need post-implementation repair flows | debugging after implementation | bug fix and incident workflows matter as much as feature start |
| Contributors are investing in evals and agent support | eval infra, PR eval runs, more agent support, shell support | Beta should include audit/eval infrastructure, but scoped |

### B.3 Cline and Codex Signals

| Signal | Examples | Forge implication |
|-------|----------|-------------------|
| Provider and auth flows are a persistent source of friction | provider selection, auth loops, endpoint fixes | host-specific docs and diagnostics matter |
| Workspace topology matters | path separator fixes, multi-root workspace issues | brownfield and multi-repo support must be conservative and explicit |
| Telemetry and host-bridge work are ongoing | telemetry and host bridge PRs | Forge audit should stay practical and host-aware |

### B.4 Aider and OpenHands Signals

| Signal | Examples | Forge implication |
|-------|----------|-------------------|
| Provider/model churn is constant | model support PRs, cost calculation updates | Forge should stay host-agnostic where possible |
| Robustness and failure handling are continuous work | retries, model listing, startup failures | Forge should bias toward safe degradation and diagnosis |
| Eval and observability interest is rising | benchmark work, observability integrations | Forge should keep audit schema stable enough to support real evaluation |

---

## Appendix C: Proposed Audit Event Schema

### C.1 Required Fields

| Field | Description |
|------|-------------|
| `timestamp` | ISO 8601 timestamp |
| `session_id` | unique session identifier |
| `host` | claude-code, cursor, codex, opencode, gemini |
| `workflow` | public workflow name |
| `skill` | active skill, if any |
| `action_type` | session_start, route, skill_enter, skill_exit, gate_check, approval_request, approval_resolution, agent_dispatch, agent_join, verification, task_complete |
| `action_detail` | short structured payload or summary |
| `risk_tier` | minimal, standard, elevated, critical |
| `outcome` | success, failure, skipped, denied |
| `duration_ms` | wall-clock duration if applicable |
| `tokens_in` | estimated or reported input tokens |
| `tokens_out` | estimated or reported output tokens |
| `cost_estimate_usd` | optional cost estimate when available |
| `deviation_id` | optional link to deviation record |
| `repo_state_ref` | optional checkpoint or branch identifier |

### C.2 Example Event

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

## Appendix D: Reference Project Roadmap

### D.1 v0.4.0 Core Suite

| Project | Primary purpose |
|--------|-----------------|
| Backend service | exercise feature start, bug fix, verification, and security review |
| Frontend app | exercise UI workflow, review flow, and lighter-risk tasks |
| Migration or infra project | exercise elevated and critical policy paths |

### D.2 v0.5.0 Expanded Suite

| Project | Workflows covered |
|--------|-------------------|
| Task Tracker API | adopt, start feature, fix bug, refactor |
| Dashboard UI | adopt, start feature, review change |
| CLI Migration Tool | adopt, feature, bug fix, migration review |
| Deploy Pipeline | adopt, feature, incident investigation |
| Auth Service | feature, refactor, security-critical verification |
| Full-Stack Notes App | all 8 public workflows |

### D.3 Coverage Goal

By v0.5.0, the suite should collectively cover:

- all 8 public workflows
- all 4 risk tiers
- all Beta agent roles
- resumed sessions
- audit and analysis passes
- controlled auto mode in trusted environments

---

## Closing Note

This draft intentionally narrows the Beta promise while strengthening the product path.

Draft 1 was directionally right, but too willing to treat every good idea as immediate Beta scope.

Draft 2 keeps the ambition, but turns it into a sequence:

- first, make Forge look trustworthy
- then, make Forge adopt real repos
- then, make Forge observe itself
- then, harden the loop
- then, ship a production-ready v1.0

That sequence better matches both the current repo and the actual learning loop now that Forge is building Forge.
