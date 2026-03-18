---
status: pending
risk_tier: standard
---

# Forge v0.5.0 Implementation Plan — Beta Completion

> See [design](../design/design.md) for context and rationale.
> **Risk tier:** standard
> **For Claude:** Use `forge:agent-team-driven-development` to execute this plan.

**Goal:** Close the Beta — usage guide, adoption fixes, formatting audit, deviation closure, platform verification, final audit.

**Architecture:** Wave 0 parallelizes skill fixes (forge-author) with documentation (lead). Wave 1 completes remaining lead tasks sequentially.

**Tech Stack:** Markdown (skills, docs, agents)

**Working directory:** `/home/rahulsc/Projects/forge` (main branch)

---

## Tasks

| # | Task | Depends On | Verify |
|---|------|-----------|--------|
| 1 | Write usage guide (docs/usage-guide.md) | — | review: 500-800 lines, 7 sections |
| 2 | Adoption fixes: prior orchestration detection (#22-25) | — | grep: `.superpowers/` detection in adopting-forge |
| 3 | Convention auto-detection (#26) | — | grep: convention detection in brainstorming + adopting-forge |
| 4 | Agent idle loop mitigation (#16) | — | grep: timed nudge in agent-team-driven-development |
| 5 | Formatting audit (#14) | — | grep: formatting reference in usage guide |
| 6 | README review + updates | 1 | review: link to usage guide, counts accurate |
| 7 | Platform smoke tests | — | review: results documented |
| 8 | Deviation worklog closure (all 26 entries) | 2-5 | grep: no "open" status remaining |
| 9 | Final Beta audit analysis | 1-8 | review: analysis-final.md exists |
| 10 | Version bump to 0.5.0 | 1-9 | grep: version 0.5.0 in manifests |

**Verify legend:** `grep` = pattern match; `review` = manual review; `test` = run test

---

## Wave Analysis

### Specialists

| Role | Agent | Model | Tasks |
|------|-------|-------|-------|
| Lead | — | opus | T1 (usage guide), T6 (README), T7 (platform tests), T8 (deviations), T9 (audit), T10 (version bump) |
| Forge Author | `forge-author` | sonnet | T2 (adoption fixes), T3 (convention detection), T4 (idle loop), T5 (formatting audit) |

### Waves

**Wave 0: Skill Fixes + Usage Guide (parallel)**
- T1 (Lead) — Write usage guide
- T2 (Forge Author) — Adoption fixes in adopting-forge (#22-25)
- T3 (Forge Author) — Convention auto-detection in brainstorming + adopting-forge (#26)
- T4 (Forge Author) — Agent idle loop timed nudge in agent-team-driven-development (#16)
- T5 (Forge Author) — Formatting audit — review top skill outputs, standardize (#14)

  *Parallel-safe because:* Lead writes docs/usage-guide.md. Forge Author edits different SKILL.md files (adopting-forge, brainstorming, agent-team-driven-development). No overlap.

  *Note:* T2-T5 are serial within the Forge Author agent but parallel with T1.

**Wave 1: Completion (sequential, lead only)**
- T6 (Lead) — README review + link to usage guide
- T7 (Lead) — Platform smoke tests (Cursor, Codex, OpenCode, Gemini CLI)
- T8 (Lead) — Deviation worklog closure (all 26 → final status)
- T9 (Lead) — Final Beta audit analysis
- T10 (Lead) — Version bump + release notes

  *Depends on Wave 0:* Usage guide must exist for README to link. Skill fixes must be done for deviation closure.

### Dependency Graph

```
Wave 0: T1 (lead: usage guide) + T2-T5 (forge-author: skill fixes)
                    │
                    ▼
Wave 1: T6 → T7 → T8 → T9 → T10 (lead: completion sequence)
```

---

## Task Details

### T1: Usage Guide

**Specialist:** Lead
**Tests:** N/A — documentation

Create `docs/usage-guide.md` (500-800 lines) with 7 sections:
1. Day-to-day workflows (the 8 workflows with practical examples)
2. Working with agents (dispatch, task list, stuck agents, permissions)
3. Risk-scaled ceremony (tiers in practice, adjusting)
4. Audit and analysis (enabling, reading JSONL, running analyze-audit)
5. State and configuration (.forge/ explained, forge-state commands, policies)
6. Extending Forge (writing skills, adding agents, packs — overview + links)
7. Troubleshooting (common issues, diagnosing-forge, platform notes)

**Commit:** `docs: create practical usage guide for Forge`

### T2: Adoption Fixes (#22-25)

**Specialist:** forge-author
**Tests:** N/A — skill text

Update `skills/adopting-forge/SKILL.md`:
- Step 1: scan for `.superpowers/`, `.aider/`, `.copilot-workspace/`, `.continue/` (#22)
- Step 1: scan for existing design docs in `docs/plans/`, `docs/*/design/` (#23)
- Step 5: check root `.gitignore` for stale entries, add `.forge/local/` (#24)
- After detection: offer cleanup of stale orchestration directories (#25)

**Commit:** `fix: adopting-forge detects prior orchestration, design docs, updates .gitignore`

### T3: Convention Auto-Detection (#26)

**Specialist:** forge-author
**Tests:** N/A — skill text

Update `skills/brainstorming/SKILL.md` and `skills/adopting-forge/SKILL.md`:
- Detect test import patterns (read 3+ existing test files)
- Detect CSS design tokens (scan for `:root` custom properties)
- Detect linter config files
- Detect commit message format (read git log)
- Detect file naming conventions (scan src/)
- Write findings to `.forge/shared/conventions.md`

**Commit:** `feat: auto-detect project conventions during adoption and brainstorming`

### T4: Agent Idle Loop Mitigation (#16)

**Specialist:** forge-author
**Tests:** N/A — skill text

Update `skills/agent-team-driven-development/SKILL.md` Wave Cleanup Routine:
- Report timeout: 60s no response → nudge agent → 30s more → alert user
- Shutdown timeout: 30s no confirmation → alert user → proceed regardless

**Commit:** `fix: add timed nudge and user escalation for stuck agents`

### T5: Formatting Audit (#14)

**Specialist:** forge-author
**Tests:** N/A — skill text

Review and standardize output formatting across skills:
- Verify adopting-forge Step 2 uses tables (already fixed in v0.4.4)
- Verify setting-up-project assessment uses tables (fixed in v0.4.2)
- Check remaining skills for wall-of-text outputs
- Document formatting conventions (table styles, icon usage) — add to forge-author agent quality checklist

**Commit:** `fix: formatting audit — standardize skill outputs across remaining skills`

### T6: README Review

**Specialist:** Lead
**Tests:** N/A — documentation

- Verify skill count (22), agent count (10)
- Add link to usage guide
- Check all 8 workflow descriptions for accuracy
- Verify installation instructions still work
- Update any stale content from v0.4.x changes

**Commit:** `docs: README review and usage guide link for v0.5.0`

### T7: Platform Smoke Tests

**Specialist:** Lead
**Tests:** review — results documented

Quick verify on each non-Claude-Code platform:
- Cursor: install plugin, verify skills load
- Codex: install per .codex/INSTALL.md
- OpenCode: install per .opencode/INSTALL.md
- Gemini CLI: install extension, verify context

Document results and known limitations.

**Commit:** `docs: platform smoke test results for v0.5.0`

### T8: Deviation Worklog Closure

**Specialist:** Lead
**Tests:** grep — no "open" remaining

Process all 26 entries to final status:
- Every entry gets: fixed (vN), closed, deferred (v1.0), or mitigated (vN)
- No "open" entries remain
- Add rationale for any deferred items

**Commit:** `docs: close all deviation worklog entries for Beta completion`

### T9: Final Beta Audit

**Specialist:** Lead
**Tests:** N/A

Run `forge:analyze-audit` on full Beta history:
- Deviation patterns across all 26 entries
- Skill coverage (22 skills, which invoked?)
- Agent utilization (10 agents, which dispatched?)
- Reference project comparison (3 baselines)
- Recommendations for v1.0

Save to `docs/forge-beta/audits/analysis-final.md`.

**Commit:** `docs: final Beta audit analysis`

### T10: Version Bump

**Specialist:** Lead
**Depends on:** T1-T9
**Tests:** grep — version 0.5.0

- Bump all manifests to 0.5.0
- Write release notes (Beta completion milestone)
- Update architecture.md if needed

**Commit:** `chore: bump version to 0.5.0 — Beta complete`
