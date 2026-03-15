# Forge v0.3.1 Design Document

**Version:** Draft 1
**Date:** 2026-03-14
**Status:** Awaiting review
**Scope:** v0.3.1 — Audit Analysis Skill + Fixes
**Parent design:** [design-v3.md](../../forge-beta/design/design-v3.md)

---

## 1. Summary

v0.3.1 is a patch release adding the `forge:analyzing-audit` skill and fixing minor gaps from v0.3.0. The analysis skill works with what exists today (manual deviation logs, git history, commit patterns) — no JSONL infrastructure needed yet. That comes in v0.4.0.

### Deliverables

1. **`forge:analyzing-audit` skill** — reads deviation worklog and git history, produces analysis reports
2. **README fix** — agent roster shows 10 agents instead of 5
3. **TDD enforcement review** — ensure writing-plans and execution skills enforce interleaved TDD where testable work exists
4. **Version bump** — 0.3.1

---

## 2. `forge:analyzing-audit` Skill

### 2.1 What It Analyzes (v0.3.1 — Manual Sources)

| Source | Location | What It Contains |
|--------|----------|-----------------|
| Deviation worklog | `docs/forge-beta/design/design-v3.md` Appendix G | 9 entries with skill, expected/actual, severity, root cause, fix target, status |
| Git history | `git log` | Commit messages, file change patterns, author attribution, timestamps |
| Plan documents | `docs/*/plans/plan.md` | Task specs, wave analysis, test expectations |
| Release notes | `RELEASE-NOTES.md` | What was delivered per version |

In v0.4.0 this skill will additionally read audit JSONL files with token/duration data. The skill should be designed to accept both manual and automated inputs.

### 2.2 Analysis Dimensions

| Dimension | What It Measures | Example Output |
|-----------|-----------------|----------------|
| **Deviation patterns** | Recurring root causes across entries | "3/9 deviations caused by missing enforcement gates — add HARD-GATEs" |
| **Fix velocity** | How quickly deviations get resolved | "Average fix time: 1 version. 2 deviations deferred 2+ versions." |
| **Workflow compliance** | Did the planned workflow actually execute? | "composing-teams was skipped in v0.2.0 despite being in the skill" |
| **Commit hygiene** | Commit count per task, squash usage, message quality | "v0.2.0: 10 commits for 7 tasks (1.4/task). v0.3.0: 7 commits for 7 tasks (1.0/task — improved)" |
| **Skill coverage** | Which skills were invoked vs available | "forge:test-driven-development never invoked during Beta. forge:verification-before-completion never invoked." |
| **Agent utilization** | Which agents were used vs available | "10 agents defined, 3 used (implementer, forge-author, lead). 7 never dispatched." |

### 2.3 Skill Structure

```
skills/analyzing-audit/
  SKILL.md          — main skill definition
```

### 2.4 Inputs and Outputs

**Inputs (provided by user or auto-detected):**
- Path to deviation worklog (default: search for `Appendix G` in design docs)
- Git range to analyze (default: all commits since last version tag)
- Optional: path to plan documents

**Outputs:**
- Human-readable analysis report written to `docs/<project>/audits/analysis-<date>.md`
- Summary printed to conversation
- Recommended improvements with priority (high/medium/low)

### 2.5 Invocation

```
User: "Analyze how the Beta development went"
User: "Run an audit analysis"
User: "What deviations have we had?"
→ forge-routing → forge:analyzing-audit
```

---

## 3. README Fix

The agent roster section (lines ~329-341) lists 5 agents. Update to list all 10:

| Agent | Role | Use Case |
|-------|------|----------|
| architect | System design, API design | Architecture decisions |
| implementer | Feature implementation | Writing code following TDD |
| qa-engineer | Test design, coverage | Pipelined TDD, test quality |
| code-reviewer | Code quality review | Post-implementation review |
| security-reviewer | Vulnerability assessment | Critical-tier security audit |
| forge-author | Skill/agent authoring | Writing and editing Forge skills and agents |
| frontend-engineer | UI development | Frontend tasks, accessibility |
| backend-engineer | API development | Backend tasks, data access |
| database-specialist | Schema, migrations | Database changes, migration review |
| devops-engineer | CI/CD, infrastructure | Deployment, pipeline review |

---

## 4. TDD Enforcement Review

### 4.1 Problem

Deviation #9: TDD was never exercised during Beta development. All tasks were markdown/skill edits where tests weren't directly applicable. But TDD enforcement is a core Forge differentiator — if projects using Forge never get prompted to write tests, it's broken.

### 4.2 Fix

Review and update these skills to enforce TDD **where testable work exists**:

**`writing-plans` SKILL.md:**
- The plan already requires test expectations per task. Verify the language is clear: "Every task that produces testable code or verifiable behavior MUST include test expectations."
- Add guidance: "Tasks that are purely documentation, configuration, or skill-prompt edits may omit test expectations with an explicit note: `Tests: N/A — documentation-only task`"

**`agent-team-driven-development` SKILL.md:**
- The pipelined TDD section exists but was never triggered. Verify it activates when a QA agent is in the roster.
- Add a check: "If the plan includes tasks with test expectations and no QA agent is in the roster, the lead should follow solo TDD (write test → verify red → implement → verify green)."

**`subagent-driven-development` SKILL.md:**
- Same TDD check for solo execution.

### 4.3 Principle

> Enforce TDD where possible. Don't force meaningless tests where there's nothing testable. But don't skip TDD when testable work exists — that's the gap we're closing.

---

## 5. Deviation Worklog Update

Update deviation statuses in design-v3.md Appendix G:

| # | Current Status | Correct Status |
|---|---------------|----------------|
| 1 | open | **fixed** (v0.2.0 — skill convention audit) |
| 2 | open | **fixed** (v0.2.0 — project restructure) |
| 3 | deferred | deferred (cosmetic, addressed by ergonomics in v0.3.0) |
| 4 | open | **fixed** (v0.2.1 — composing-teams enforcement) |
| 5 | deferred | **fixed** (v0.3.0 — review tiers) |
| 6 | open | **fixed** (v0.2.1 — squash-on-merge) |
| 7 | open | **fixed** (v0.2.1 — wave cleanup routine) |
| 8 | open | **fixed** (v0.2.1 — status reporting) |
| 9 | open | open (TDD enforcement — addressed in this version) |

---

## 6. Testing Strategy

The analyzing-audit skill can be tested by running it against the actual Forge Beta deviation log and git history. Expected:
- It reads 9 deviation entries
- It produces an analysis report
- The report identifies patterns (e.g., "enforcement gates" as recurring root cause)
- The report lists skill coverage gaps

For the TDD enforcement review, verify by reading the updated skill text and confirming the guidance is clear.

For the README fix, verify agent count matches `ls agents/*.md | wc -l`.
