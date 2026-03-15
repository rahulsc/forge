---
status: pending
risk_tier: elevated
---

# Forge v0.4.0 Implementation Plan — Audit Infrastructure + Fixes

> See [design](../design/design.md) for context and rationale.
> **Risk tier:** elevated — design doc reference, wave analysis required
> **For Claude:** Use `forge:agent-team-driven-development` to execute this plan.

**Goal:** Build audit JSONL infrastructure with TDD (first real test-driven code in Beta), add audit opt-in to brainstorming, fix audit findings, and upgrade analyze-audit to read JSONL.

**Architecture:** New `bin/forge-audit` shell tool records events as JSONL. Hooks call it when audit is enabled. Tests written first (RED), implementation makes them pass (GREEN). Skill updates for brainstorming opt-in, HARD-GATE additions, wave compliance fix, and analyze-audit JSONL support.

**Tech Stack:** Shell scripts (bash), JSONL, Markdown (SKILL.md)

**Working directory:** `/home/rahulsc/Projects/forge` (main branch)

---

## Tasks

| # | Task | Depends On | Verify |
|---|------|-----------|--------|
| 1 | Write TDD test suite for forge-audit | — | test: all tests fail (RED — tool doesn't exist yet) |
| 2 | Implement bin/forge-audit tool | 1 | test: all tests from T1 pass (GREEN) |
| 3 | Integrate forge-audit into hooks | 2 | test: hooks emit JSONL when audit enabled |
| 4 | Add HARD-GATEs to verification/finishing/composing skills | — | grep: HARD-GATE tags in target skills |
| 5 | Fix wave compliance invocation | — | grep: validating-wave-compliance invocation clear in skill |
| 6 | Add audit opt-in to brainstorming | — | grep: "audit mode" question in brainstorming skill |
| 7 | Upgrade analyze-audit for JSONL | 2 | grep: JSONL reading logic in skill |
| 8 | Close deviation #3 + README update | — | grep: agent count correct, deviation marked closed |
| 9 | Version bump to 0.4.0 | 1-8 | grep: version 0.4.0 in manifests |

---

## Wave Analysis

### Specialists

| Role | Agent | Model | Tasks |
|------|-------|-------|-------|
| Lead | — | opus | T8 (README + deviation), T9 (version bump), coordination |
| QA Engineer | `qa-engineer` | opus | T1 (TDD tests — RED phase) |
| Shell Engineer | `implementer` | opus | T2 (forge-audit implementation — GREEN phase), T3 (hook integration) |
| Forge Author | `forge-author` | opus | T4 (HARD-GATEs), T5 (wave compliance), T6 (brainstorming opt-in), T7 (analyze-audit upgrade) |

### Waves

**Wave 0: TDD RED + Independent Skill Fixes**
- T1 (QA Engineer) — Write forge-audit test suite. Tests must fail because `bin/forge-audit` doesn't exist yet. RED evidence required.
- T4 (Forge Author) — Add HARD-GATEs to verification-before-completion, finishing-a-development-branch, composing-teams
- T8 (Lead) — Close deviation #3, update README

  *Parallel-safe because:* T1 writes `tests/forge-audit/` (new directory). T4 modifies verification/finishing/composing skill files. T8 modifies README.md and design-v3.md. No file overlap.

  *QA writes tests for T2:* The test suite IS the deliverable — it defines what bin/forge-audit must do.

**Wave 1: TDD GREEN + More Skill Fixes**
- T2 (Shell Engineer) — Implement `bin/forge-audit` to make T1's tests pass. GREEN evidence required.
- T5 (Forge Author) — Fix wave compliance invocation in agent-team-driven-development
- T6 (Forge Author) — Add audit opt-in question to brainstorming skill

  *Depends on Wave 0:* T2 needs T1's test suite to exist. T5 and T6 are independent.

  *Parallel-safe because:* T2 creates `bin/forge-audit` (new file). T5 modifies agent-team-driven-development. T6 modifies brainstorming. No overlap.

**Wave 2: Integration + Upgrade**
- T3 (Shell Engineer) — Integrate forge-audit calls into hooks (forge-session-start, forge-task-completed, forge-gate)
- T7 (Forge Author) — Upgrade analyze-audit skill to read JSONL + add cost analysis

  *Depends on Wave 1:* T3 needs bin/forge-audit working. T7 needs to know the JSONL schema from T2.

  *Parallel-safe because:* T3 modifies hooks/. T7 modifies skills/analyze-audit/. No overlap.

**Wave 3: Release**
- T9 (Lead) — Version bump, release notes

  *Depends on Wave 2:* All work must be complete.

### Dependency Graph

```
Wave 0: T1 (QA: tests RED) + T4 (HARD-GATEs) + T8 (README + deviation)
                    │
                    ▼
Wave 1: T2 (impl: tests GREEN) + T5 (wave compliance) + T6 (brainstorming opt-in)
                    │
                    ▼
Wave 2: T3 (hook integration) + T7 (analyze-audit upgrade)
                    │
                    ▼
Wave 3: T9 (version bump)
```
