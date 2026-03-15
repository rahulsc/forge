---
status: pending
risk_tier: standard
---

# Forge v0.3.1 Implementation Plan — Audit Analysis + Fixes

> See [design](../design/design.md) for context and rationale.
> **Risk tier:** standard — goal + tasks + test expectations required
> **For Claude:** Use `forge:subagent-driven-development` to execute this plan.

**Goal:** Add the `forge:analyzing-audit` skill, fix README agent roster, enforce TDD where applicable, merge risk/team steps in setting-up-project, update plan task table format in writing-plans, update deviation statuses, and bump version.

**Architecture:** 1 new skill (analyzing-audit), 4 skill text updates (writing-plans, agent-team-driven-development, subagent-driven-development, setting-up-project), 1 README edit, 1 deviation log update, version bump. All markdown edits.

**Tech Stack:** Markdown

**Working directory:** `/home/rahulsc/Projects/forge` (main branch)

---

## Tasks

| # | Task | Depends On | Verify |
|---|------|-----------|--------|
| 1 | Create `forge:analyzing-audit` skill | — | grep: frontmatter exists, routing entry exists |
| 2 | Update README agent roster (5→10) | — | grep: forge-author in roster table |
| 3 | TDD enforcement in execution skills | — | grep: N/A guidance, solo TDD fallback |
| 4 | Merge risk/team steps in setting-up-project | — | grep: team criteria in Step 1 |
| 5 | Update plan task table format in writing-plans | — | grep: Depends On and Verify columns in template |
| 6 | Update deviation worklog statuses | 1-5 | grep: no stale "open" entries |
| 7 | Version bump to 0.3.1 | 1-6 | grep: version 0.3.1 in manifests |

---

## Task 1: Create `forge:analyzing-audit` Skill

**Depends on:** None
**Produces:** `skills/analyzing-audit/SKILL.md`
**Complexity:** standard

### Goal

Create a skill that reads manual deviation logs and git history to produce analysis reports with improvement recommendations.

### Acceptance Criteria

- [ ] `skills/analyzing-audit/SKILL.md` exists with frontmatter (name, description)
- [ ] Skill reads deviation worklog from design docs (Appendix G pattern)
- [ ] Skill reads git history (`git log`, commit patterns)
- [ ] Analyzes: deviation patterns, fix velocity, workflow compliance, commit hygiene, skill coverage, agent utilization
- [ ] Outputs human-readable report to `docs/<project>/audits/analysis-<date>.md`
- [ ] Prints summary to conversation
- [ ] Lists recommended improvements with priority
- [ ] Integration section notes: future v0.4.0 upgrade will add JSONL audit input
- [ ] Added to forge-routing intent table (signals: "analyze", "audit", "what deviations")

### Test Expectations

- **Test:** `skills/analyzing-audit/SKILL.md` exists and contains frontmatter
- **Expected red failure:** file doesn't exist
- **Expected green:** file exists with `name:` and `description:` fields

- **Test:** grep for "deviation" in the skill's analysis dimensions
- **Expected red failure:** no deviation analysis documented
- **Expected green:** deviation patterns dimension documented

### Files

- Create: `skills/analyzing-audit/SKILL.md`
- Modify: `skills/forge-routing/SKILL.md` (add "audit/analyze" route to intent table)

### Implementation Notes

- Follow the forge-author agent's quality checklist: description enables discovery, process flow diagram, integration section with state reads/writes, under 500 lines
- The skill works with MANUAL sources today (deviation worklog markdown, git log). Design it so v0.4.0 can add JSONL input without rewriting — use an "Input Sources" section that lists current sources and notes future additions
- Analysis dimensions from design §2.2: deviation patterns, fix velocity, workflow compliance, commit hygiene, skill coverage, agent utilization
- Output format: markdown report with sections per dimension, summary table, prioritized recommendations
- Add to forge-routing: `| Audit | "analyze", "audit", "deviations", "how did it go" | forge:analyzing-audit |`

### Commit

`feat: create forge:analyzing-audit skill for deviation analysis`

---

## Task 2: Update README Agent Roster

**Depends on:** None
**Produces:** Updated README.md with 10 agents listed
**Complexity:** mechanical

### Goal

Update the agent roster section to show all 10 agents instead of the original 5.

### Acceptance Criteria

- [ ] README agent roster table lists 10 agents
- [ ] Each new agent has role and use case columns filled
- [ ] Agent count matches `ls agents/*.md | wc -l`

### Test Expectations

- **Test:** grep for "forge-author" in README agent roster section
- **Expected red failure:** forge-author not listed
- **Expected green:** forge-author listed with other new agents

### Files

- Modify: `README.md` (agent roster section, ~lines 329-341)

### Implementation Notes

Replace the 5-agent table with the 10-agent table from design §3. Keep the same column format (Agent | Role | Use Case).

### Commit

`docs: update README agent roster to show all 10 agents`

---

## Task 3: TDD Enforcement in Execution Skills

**Depends on:** None
**Produces:** Updated writing-plans, agent-team-driven-development, and subagent-driven-development skills with TDD enforcement guidance
**Complexity:** standard

### Goal

Ensure execution skills enforce interleaved TDD where testable work exists. Don't force tests where there's nothing testable.

### Acceptance Criteria

- [ ] `writing-plans` SKILL.md clarifies: tasks with testable code MUST include test expectations; documentation-only tasks may note `Tests: N/A`
- [ ] `agent-team-driven-development` SKILL.md adds: if plan includes test expectations and no QA agent, lead follows solo TDD
- [ ] `subagent-driven-development` SKILL.md adds: same solo TDD check
- [ ] Clear distinction between "testable work" (code, scripts, verifiable behavior) and "non-testable work" (documentation, skill prompts, config)

### Test Expectations

- **Test:** grep for "N/A" or "documentation-only" in writing-plans test expectations section
- **Expected red failure:** no guidance for non-testable tasks
- **Expected green:** explicit guidance that documentation-only tasks can note `Tests: N/A`

- **Test:** grep for "solo TDD" in agent-team-driven-development
- **Expected red failure:** no solo TDD fallback when QA absent
- **Expected green:** solo TDD guidance present

### Files

- Modify: `skills/writing-plans/SKILL.md` (Plan-Level Test Expectations section)
- Modify: `skills/agent-team-driven-development/SKILL.md` (Pipelined TDD section)
- Modify: `skills/subagent-driven-development/SKILL.md` (execution section)

### Implementation Notes

The key principle: "Enforce TDD where possible. Don't force meaningless tests where there's nothing testable. But don't skip TDD when testable work exists."

For writing-plans, add after the existing "Every task MUST include test expectations" line:
```
Tasks that are purely documentation, configuration, or prompt edits may note:
`Tests: N/A — documentation-only task`

This is NOT a free pass to skip tests for code changes. If a task produces
testable code or verifiable behavior, test expectations are mandatory.
```

For execution skills, add a TDD check:
```
If the plan includes tasks with test expectations and no QA agent is in
the roster, the lead or implementer follows solo TDD:
1. Write failing test based on plan's test expectations
2. Verify test fails (RED)
3. Implement to make test pass
4. Verify test passes (GREEN)
5. Refactor if needed
```

### Commit

`fix: enforce TDD where testable work exists, allow N/A for documentation tasks`

---

## Task 4: Merge Risk/Team Steps in setting-up-project

**Depends on:** None
**Produces:** Updated setting-up-project skill with combined risk+team presentation
**Complexity:** standard

### Goal

Fix deviations #10 and #11: merge risk classification (Step 1) and team decision (Step 4) into a single step that shows the full picture with justification, then asks for user confirmation once.

### Acceptance Criteria

- [ ] Step 1 now includes: risk tier with justification, team criteria table, and resulting execution strategy — all presented together
- [ ] User is asked to confirm the combined risk+team assessment once
- [ ] Old Step 4 content is merged into Step 1 (subsequent steps renumbered)
- [ ] Risk justification includes: what files/dirs are affected, scope (task count), why the tier was chosen
- [ ] Process flow diagram updated to reflect merged step

### Test Expectations

- **Test:** grep for "team criteria" or "Task count" in Step 1 of setting-up-project
- **Expected red failure:** team criteria table is in Step 4, not Step 1
- **Expected green:** team criteria table appears in Step 1

- **Test:** grep for "## Step 4" — should be "Update Shared Docs" not "Team Decision"
- **Expected red failure:** Step 4 is still "Team Decision"
- **Expected green:** Step 4 is "Update Shared Docs" (renumbered from old Step 5)

### Files

- Modify: `skills/setting-up-project/SKILL.md` (merge Steps 1+4, renumber, update flow diagram)

### Implementation Notes

The merged Step 1 should present something like:

```
Risk and Execution Assessment:

  Files affected:  skills/, agents/, README.md
  Scope:           5 tasks
  Risk tier:       standard (no critical paths, small scope)

  Team criteria:
    Task count:       5 (≥4 ✓)
    Independence:     Borderline — mostly serial edits
    Specialist domains: 1 — all markdown/skill edits (needs 2+)

  Execution strategy: solo (team criteria not fully met)

Does this assessment look correct?
```

After merging, the steps become:
1. Risk + Team Assessment (merged, with confirmation)
2. Initialize State
3. Worktree Setup
4. Update Shared Docs (was Step 5)
5. Readiness Summary (was Step 6)

Update the process flow diagram, State Written section, and Integration section to match.

### Commit

`fix: merge risk and team steps in setting-up-project with justification`

---

## Task 5: Update Plan Task Table Format in writing-plans

**Depends on:** None
**Produces:** Updated writing-plans SKILL.md with new task summary table format
**Complexity:** standard

### Goal

Replace the old `complexity` column in the plan task summary table with `Depends On` and `Verify` columns. Add a legend. Document cost-per-task column as a v1.0 enhancement.

### Acceptance Criteria

- [ ] Plan task summary table template in writing-plans uses `| # | Task | Depends On | Verify |` format
- [ ] Old `complexity` column (mechanical/standard/complex) removed from the summary table template
- [ ] Legend added explaining Verify values: `grep` (pattern match), `test` (run test suite), `review` (manual review), `N/A` (not applicable)
- [ ] Note added: "Future enhancement (v1.0): add cost-per-task column once audit cost tracking is available"
- [ ] The review tier table in agent-team-driven-development still uses complexity for review depth decisions — that stays separate

### Test Expectations

- **Test:** grep for "Depends On" in writing-plans plan.md template section
- **Expected red failure:** template uses old complexity column
- **Expected green:** template uses Depends On and Verify columns

### Files

- Modify: `skills/writing-plans/SKILL.md` (plan.md template section and Test Expectations Summary table)

### Implementation Notes

The `complexity` field (mechanical/standard/complex) still serves a purpose in `agent-team-driven-development` for determining review depth. Don't remove it from there. Only update the plan summary table template in writing-plans.

Replace the current summary table template:
```
| Task | What to test | Expected red failure |
```

With:
```
| # | Task | Depends On | Verify |
```

Add a legend:
```
**Verify legend:** `grep` = pattern match confirms change; `test` = run test suite; `review` = manual review; `N/A` = not verifiable (documentation only)
```

Add a future enhancement note near the summary table:
```
> Future enhancement (v1.0): add estimated cost column once audit cost tracking provides per-task baselines.
```

### Commit

`fix: update plan task table format — replace complexity with Depends On + Verify columns`

---

## Task 6: Update Deviation Worklog Statuses

**Depends on:** Tasks 1-5 (need to know what was fixed)
**Produces:** Updated deviation statuses in design-v3.md Appendix G
**Complexity:** mechanical

### Goal

Update all deviation entries to reflect their current status accurately.

### Acceptance Criteria

- [ ] Deviations #1, #2 marked as `fixed` (v0.2.0)
- [ ] Deviations #4, #6, #7, #8 marked as `fixed` (v0.2.1)
- [ ] Deviation #3 remains `deferred` (cosmetic)
- [ ] Deviation #5 marked as `fixed` (v0.3.0 — review tiers)
- [ ] Deviation #9 marked as `fixed` (v0.3.1 — TDD enforcement)
- [ ] Deviations #10, #11 marked as `fixed` (v0.3.1 — risk/team confirmation)

### Test Expectations

- **Test:** grep for "open" in deviation worklog — should return only new entries from this version (if any)
- **Expected red failure:** multiple entries still show "open"
- **Expected green:** only genuinely open entries remain

### Files

- Modify: `docs/forge-beta/design/design-v3.md` (Appendix G status column)

### Commit

`docs: update deviation worklog — mark fixed entries through v0.3.1`

---

## Task 7: Version Bump to 0.3.1

**Depends on:** Tasks 1-6
**Produces:** v0.3.1 in all manifests, release notes
**Complexity:** mechanical

### Goal

Bump to 0.3.1, write release notes.

### Acceptance Criteria

- [ ] `.claude-plugin/plugin.json` version is `0.3.1`
- [ ] `.cursor-plugin/plugin.json` version is `0.3.1`
- [ ] `gemini-extension.json` version is `0.3.1`
- [ ] `RELEASE-NOTES.md` has v0.3.1 section

### Test Expectations

- **Test:** grep for `"version": "0.3.1"` in plugin manifests
- **Expected red failure:** manifests show `0.3.0`
- **Expected green:** all show `0.3.1`

### Files

- Modify: `.claude-plugin/plugin.json`
- Modify: `.cursor-plugin/plugin.json`
- Modify: `gemini-extension.json`
- Modify: `RELEASE-NOTES.md`

### Commit

`chore: bump version to 0.3.1`

---

## Test Expectations Summary

| # | Task | Depends On | Verify |
|---|------|-----------|--------|
| 1 | analyzing-audit skill | — | grep: frontmatter exists, routing entry exists |
| 2 | README agent roster | — | grep: forge-author in roster table |
| 3 | TDD enforcement | — | grep: N/A guidance, solo TDD fallback |
| 4 | Merge risk/team steps | — | grep: team criteria in Step 1 |
| 5 | Plan task table format | — | grep: Depends On and Verify in template |
| 6 | Deviation worklog | 1-5 | grep: no stale "open" entries |
| 7 | Version bump | 1-6 | grep: version 0.3.1 in manifests |
