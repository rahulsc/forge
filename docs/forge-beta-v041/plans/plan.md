---
status: pending
risk_tier: standard
---

# Forge v0.4.1 Implementation Plan — Shutdown Fix + Reference Project Infra

> See [design](../design/design.md) for context and rationale.
> **Risk tier:** standard — goal + tasks + test expectations required
> **For Claude:** Use `forge:agent-team-driven-development` to execute this plan.

**Goal:** Fix agent shutdown issues, enhance audit UX, create reference project infrastructure, and prepare for first reference project run.

**Architecture:** Skill text updates + new reference-projects/ directory with spec/scaffold/measure files. The Task Tracker API execution happens AFTER this version ships — it's a separate project in a separate directory.

**Tech Stack:** Markdown (SKILL.md), Shell (scaffold/measure scripts), YAML (spec files)

**Working directory:** `/home/rahulsc/Projects/forge` (main branch)

---

## Tasks

| # | Task | Depends On | Verify |
|---|------|-----------|--------|
| 1 | Fix agent shutdown in agent-team-driven-development | — | grep: wave-suffixed names, structured shutdown, no plain text |
| 2 | Enhance audit description in brainstorming + add stale task cleanup | — | grep: "What it does", "What it's used for", stale task check |
| 3 | Add end-of-workflow audit prompt to finishing-a-development-branch + stale task cleanup | — | grep: "Audit Summary", stale task cleanup |
| 4 | Fix assessment output formatting in setting-up-project | — | grep: table format guidance for assessment output |
| 5 | Create reference project runbook | — | review: runbook.md exists with complete protocol |
| 6 | Create Task Tracker API spec + scaffold + measure | 5 | test: scaffold.sh runs and creates directory |
| 7 | Create remaining 5 project specs (scaffold + measure stubs) | 5 | test: all 6 spec.yaml files exist |
| 8 | Commit deviation log updates + version bump to 0.4.1 | 1-7 | grep: version 0.4.1 in manifests |

**Verify legend:** `grep` = pattern match confirms change; `test` = run script; `review` = manual review

> Future enhancement (v1.0): add estimated cost column once audit cost tracking provides per-task baselines.

---

## Wave Analysis

### Specialists

| Role | Agent | Model | Tasks |
|------|-------|-------|-------|
| Lead | — | opus | T5 (runbook), T8 (deviations + version bump), coordination |
| Forge Author | `forge-author` | sonnet | T1 (shutdown fix), T2 (audit + task cleanup), T3 (finishing + task cleanup), T4 (formatting) |
| Shell Engineer | `implementer` | sonnet | T6 (task tracker spec/scaffold/measure), T7 (remaining 5 project specs) |

### Waves

**Wave 0: Skill Fixes + Runbook**
- T1 (Forge Author) — Fix agent shutdown rules in agent-team-driven-development
- T2 (Forge Author) — Enhance audit description + add stale task check to brainstorming
- T3 (Forge Author) — Add audit prompt + stale task cleanup to finishing-a-development-branch
- T4 (Forge Author) — Fix assessment output formatting in setting-up-project
- T5 (Lead) — Write reference project runbook

  *Parallel-safe because:* T1-T4 each modify different SKILL.md files. T5 creates a new file (runbook.md). No overlap.

  *Note:* T1-T4 are all Forge Author tasks — serial within one agent, but parallel with T5 (Lead).

**Wave 1: Reference Project Files**
- T6 (Shell Engineer) — Create Task Tracker API spec.yaml, scaffold.sh, measure.sh
- T7 (Shell Engineer) — Create remaining 5 project specs with scaffold/measure stubs

  *Depends on Wave 0:* T5 (runbook) defines the protocol that specs must follow.

  *Parallel-safe:* T6 and T7 create files in different subdirectories. But both are Shell Engineer tasks — serial within one agent.

**Wave 2: Release**
- T8 (Lead) — Update deviation log, version bump, release notes

  *Depends on Wave 1:* All work must be complete.

### Dependency Graph

```
Wave 0: T1+T2+T3+T4 (forge-author) + T5 (lead: runbook)
                    │
                    ▼
Wave 1: T6+T7 (shell-engineer: project specs)
                    │
                    ▼
Wave 2: T8 (lead: version bump)
```
