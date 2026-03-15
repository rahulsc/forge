---
name: analyze-audit
description: Analyze Forge workflow deviations, git history, and audit data to identify improvement patterns. Use when reviewing how a project went, analyzing deviations, or running a retrospective.
---

# Analyzing Audit Data

Produce actionable improvement recommendations by analyzing deviation logs, git history, and (in v0.4.0+) structured audit JSONL.

**Announce at start:** "I'm using the analyzing-audit skill to review workflow data and identify improvements."

## Input Sources

### Available Now (v0.3.1)

| Source | Location | What It Contains |
|--------|----------|-----------------|
| Deviation worklog | Design doc Appendix G (search for "Deviation Worklog") | Expected vs actual behavior, severity, root cause, fix status |
| Git history | `git log` | Commits, file change patterns, timestamps, authorship |
| Plan documents | `docs/*/plans/plan.md` | Task specs, wave structure, dependencies |
| Release notes | `RELEASE-NOTES.md` | What was delivered per version |

### Structured Audit Data (v0.4.0+)

| Source | Location | What It Contains |
|--------|----------|-----------------|
| Audit JSONL | `.forge/local/audit/<session-id>.jsonl` | Structured events: skill enter/exit, gate checks, token counts, durations |
| Metrics JSONL | `.forge/local/audit/metrics.jsonl` | Run-over-run comparison data |

When JSONL sources exist, read them automatically. When they don't, work with the manual sources above.

## Analysis Dimensions

Analyze each dimension and report findings:

| Dimension | What to Measure | How |
|-----------|----------------|-----|
| **Deviation patterns** | Recurring root causes across entries | Group deviations by root cause; count frequency |
| **Fix velocity** | How quickly deviations get resolved | Compare fix target version to actual fix version |
| **Workflow compliance** | Did planned workflows actually execute? | Compare plan task list to git commits; check for skipped skills |
| **Commit hygiene** | Commits per task, squash usage, message quality | Analyze `git log --oneline` for commit count per version |
| **Skill coverage** | Which skills were invoked vs available | List all skills; check git/plan history for invocation evidence |
| **Agent utilization** | Which agents were used vs defined | List all agents; check plan wave analysis for dispatch evidence |
| **Token cost per skill** | Total tokens consumed by each skill | JSONL skill_enter/skill_exit events |
| **Token cost per workflow** | Total tokens for each workflow type | JSONL events grouped by workflow field |
| **Gate pass rate** | % of gates passed on first attempt | JSONL gate_check events |
| **Session duration** | Wall clock time per session | JSONL session_start to last event timestamp |

## Process

1. **Locate sources** — find deviation worklog, recent git history, plan documents
2. **Read and parse** — extract deviation entries, commit data, plan tasks
   - If `.forge/local/audit/*.jsonl` files exist, parse structured events
   - Extract token counts, durations, and event types from JSONL
   - Merge with manual deviation data for combined analysis
3. **Analyze each dimension** — produce findings per dimension
4. **Identify patterns** — cross-dimension patterns (e.g., "enforcement gates" as recurring fix)
5. **Prioritize recommendations** — high (blocking adoption), medium (friction), low (cosmetic)
6. **Write report** — save to `docs/<project>/audits/analysis-<date>.md`
7. **Present summary** — show key findings and top recommendations in conversation

## Report Format

```markdown
# Forge Audit Analysis — <date>

## Summary
- Deviations analyzed: N
- Fixed: N | Open: N | Deferred: N
- Top pattern: [most common root cause]

## Deviation Analysis
### Patterns
[grouped by root cause with counts]

### Fix Velocity
[average versions to fix, outliers]

## Workflow Compliance
[which skills ran vs which were planned]

## Commit Hygiene
[commits per task per version, trend]

## Skill Coverage
[invoked vs available, gaps]

## Agent Utilization
[dispatched vs defined, gaps]

## Cost Analysis (from audit JSONL)

*This section appears only when JSONL audit data is available.*

| Skill | Invocations | Avg Tokens In | Avg Tokens Out | Avg Duration |
|-------|-------------|---------------|----------------|-------------|
| [skill] | [count] | [avg] | [avg] | [avg] |

**Total session cost:** ~$X.XX (estimated)
**Most expensive skill:** [skill] ([%] of total tokens)
**Most expensive workflow:** [workflow] ([%] of total tokens)

## Recommendations
| Priority | Recommendation | Based On |
|----------|---------------|----------|
| high | [action] | [which findings] |
| medium | [action] | [which findings] |
| low | [action] | [which findings] |
```

## Integration

**Called by:** `forge:forge-routing` (audit/analyze intents)

**Before this skill:** Project has deviation logs and/or audit data to analyze

**After this skill:** Recommendations inform next version's brainstorming

**Reads from:** Deviation worklog (design docs), git history, plan documents, `.forge/local/audit/` (when available)

**Writes to:** `docs/<project>/audits/analysis-<date>.md`
