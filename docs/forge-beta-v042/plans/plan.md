---
status: pending
risk_tier: standard
---

# Forge v0.4.2 Implementation Plan — Reference Project Infrastructure Fixes

> See [design](../design/design.md) for context and rationale.
> **Risk tier:** standard
> **For Claude:** Use `forge:subagent-driven-development` to execute this plan.

**Goal:** Fix the 4 blockers from the failed v0.4.1 reference project run so v0.4.3 can re-run successfully.

**Architecture:** All skill text edits + runbook update. No new code.

**Working directory:** `/home/rahulsc/Projects/forge` (main branch)

---

## Tasks

| # | Task | Depends On | Verify |
|---|------|-----------|--------|
| 1 | Add audit recording to agent-team-driven-development | — | grep: `forge-audit record` in implementer prompt template |
| 2 | Add approval manifest integration to agent-team-driven-development | — | grep: `approvals.yaml` in Phase 1 |
| 3 | Add validation checklist step to finishing-a-development-branch | — | grep: `validation.md` in skill |
| 4 | Update runbook with results commit process | — | grep: `cherry-pick` in runbook |
| 5 | Add task list formatting convention to agent-team-driven-development | — | grep: `✅` and `🔄` in Status Reporting |
| 6 | Version bump to 0.4.2 | 1-5 | grep: version 0.4.2 in manifests |

**Verify legend:** `grep` = pattern match confirms change

---

## Task 1: Add Audit Recording to Agent Prompts

**Depends on:** None
**Tests:** N/A — documentation-only task

### Goal

Agents explicitly call `bin/forge-audit record` at task boundaries so audit JSONL captures events during reference project runs.

### Acceptance Criteria

- [ ] Implementer prompt template section includes `forge-audit record --type task_start` at task beginning
- [ ] Implementer prompt template section includes `forge-audit record --type task_completion` at task end
- [ ] Between-waves section includes `forge-audit record --type wave_completion`
- [ ] All audit calls are best-effort (skip silently if unavailable)

### Files

- Modify: `skills/agent-team-driven-development/SKILL.md`

### Implementation Notes

Add to the "Prompt Templates" section (or near the implementer-prompt.md reference):

```
**Audit recording (include in every agent prompt):**
At task start: `bin/forge-audit record --type task_start --skill <skill> --detail '{"task":"<id>"}'`
At task end: `bin/forge-audit record --type task_completion --skill <skill> --detail '{"task":"<id>","tests_passed":<N>}'`
If forge-audit is not available or audit is not enabled, skip silently — never fail on audit.
```

Add to between-waves section:
```
After wave cleanup: `bin/forge-audit record --type wave_completion --detail '{"wave":<N>,"tasks_completed":[<ids>]}'`
```

### Commit

`fix: add audit recording instructions to agent prompt template`

---

## Task 2: Add Approval Manifest Integration

**Depends on:** None
**Tests:** N/A — documentation-only task

### Goal

Lead reads `approvals.yaml` at execution start and presents to user for one-time approval.

### Acceptance Criteria

- [ ] Phase 1 (Plan Analysis & Team Setup) checks for `approvals.yaml` in project directory
- [ ] If found, presents permissions list to user for one-time approval
- [ ] Notes that approved operations don't need individual confirmation during the run
- [ ] If no `approvals.yaml`, proceeds normally (no change to existing behavior)

### Files

- Modify: `skills/agent-team-driven-development/SKILL.md`

### Implementation Notes

Add to Phase 1, after "Read plan" step:

```markdown
**Approval manifest (if available):**

Check for `approvals.yaml` in the project directory. If found:

1. Read the manifest
2. Present to user:
   > "This project has pre-defined permissions:
   >
   > **File operations:** [create/edit patterns from manifest]
   > **Shell commands:** [allowed commands]
   > **Agent operations:** [spawn types]
   >
   > Approve these for this run? Only unexpected operations will prompt."

3. If approved, note in context that listed operations are pre-approved
4. If declined, proceed with normal per-operation approval
```

### Commit

`fix: add approval manifest integration to agent-team-driven-development`

---

## Task 3: Add Validation Checklist to Finishing

**Depends on:** None
**Tests:** N/A — documentation-only task

### Goal

Before declaring work complete, check for `validation.md` and run user validation.

### Acceptance Criteria

- [ ] "User Validation" section added before "Closeout Cleanup" in finishing skill
- [ ] If `validation.md` exists, present checklist to user
- [ ] Offer to run automated checks (curl commands etc.)
- [ ] Record pass/fail per check
- [ ] Don't proceed to merge/PR until validation passes or user explicitly skips

### Files

- Modify: `skills/finishing-a-development-branch/SKILL.md`

### Implementation Notes

Add before the existing "Closeout Cleanup" section:

```markdown
## User Validation

If a `validation.md` file exists in the project directory:

1. Read the validation checklist
2. Present each check to the user with the commands to run
3. Offer: "Want me to run these validation checks? (y/n)"
4. If yes, run each check and report results
5. If no, present the checklist for manual verification
6. Record pass/fail in the run results

Do NOT proceed to merge/PR/cleanup until:
- All checks pass, OR
- User explicitly acknowledges failures and approves proceeding
```

### Commit

`fix: add validation checklist step to finishing-a-development-branch`

---

## Task 4: Update Runbook with Results Process

**Depends on:** None
**Tests:** N/A — documentation-only task

### Goal

Document the clear process for committing deviations and results during/after reference project runs.

### Acceptance Criteria

- [ ] "Results Process" section in runbook with 3 clear rules
- [ ] Rule 1: deviations/fixes → main immediately
- [ ] Rule 2: run results → cherry-pick to main after run
- [ ] Rule 3: worktree → delete after results extracted
- [ ] Commands provided for each step

### Files

- Modify: `reference-projects/runbook.md`

### Implementation Notes

Add after "Cleanup" section:

```markdown
## Results Process

During a reference project run, commits go to two places:

**1. Deviations and Forge fixes → commit to main IMMEDIATELY**
Don't wait until the run ends. Switch to main, commit the fix, push, switch back.
```bash
cd /path/to/forge  # main working tree
git add <files>
git commit -m "fix: <deviation description>"
git push
```

**2. Run results → commit in worktree, cherry-pick to main**
```bash
# In worktree: commit results
git add reference-projects/<project>/runs/<date>.md
git commit -m "docs: <project> run results v<version>"

# From main: cherry-pick
git cherry-pick <sha>
git push
```

**3. Worktree → delete after results extracted**
```bash
git worktree remove .worktrees/<name>
git branch -d <branch>
```
```

### Commit

`docs: add results commit process to reference project runbook`

---

## Task 5: Add Task List Formatting Convention

**Depends on:** None
**Tests:** N/A — documentation-only task

### Goal

Document the wave-grouped status format with icons that we iterated on during the v0.4.1 run.

### Acceptance Criteria

- [ ] Status Reporting section updated with header format including test counts
- [ ] Wave icons: ✅ (done), 🔄 (active), ⏭️ (upcoming)
- [ ] Task icons: ⏳ (in progress), ◻️ (upcoming)
- [ ] Bullet points: ● (wave), • (task)
- [ ] Example output shown
- [ ] Timer guidance: display every 30s if no output

### Files

- Modify: `skills/agent-team-driven-development/SKILL.md`

### Implementation Notes

Replace the existing Status Reporting section content with:

```markdown
## Status Reporting

Display task status after each major action (task completion, agent spawn, between waves) and every 30 seconds if no other output.

**Format:**

**<Project Name>** — <N>/<Total> tasks | <N>/<N> tests implemented | <N>/<N> passing

 ● ✅ Wave 0: <description> (<N>/<N> tests passing)
 ● ✅ Wave 1: <description> (<N>/<N> tests passing)

 ● 🔄 Wave 2: <description>
    • ⏳ T<N>  <agent-name> — <task> (tests: <N> RED | <N>/<N> GREEN)

 ● ⏭️ Wave 3: <description>
    • ◻️ T<N>  — <task>

**Icons:**
- ● = wave bullet (large)
- • = task bullet (small)
- ✅ = completed
- 🔄 = active
- ⏭️ = upcoming wave
- ⏳ = task in progress
- ◻️ = upcoming task

**In-progress task test status cycles:**
- `(tests: pending RED)` — tests not written yet
- `(tests: <N> RED)` — tests written, failing as expected
- `(tests: <N>/<N> GREEN)` — implementation done, tests passing
```

### Commit

`fix: add wave-grouped task list formatting convention with icons`

---

## Task 6: Version Bump to 0.4.2

**Depends on:** Tasks 1-5
**Tests:** N/A

### Acceptance Criteria

- [ ] `.claude-plugin/plugin.json` version is `0.4.2`
- [ ] `.cursor-plugin/plugin.json` version is `0.4.2`
- [ ] `gemini-extension.json` version is `0.4.2`
- [ ] `RELEASE-NOTES.md` has v0.4.2 section
- [ ] Deviations #17-20 marked as fixed in v0.4.0 design deviation log

### Files

- Modify: `.claude-plugin/plugin.json`
- Modify: `.cursor-plugin/plugin.json`
- Modify: `gemini-extension.json`
- Modify: `RELEASE-NOTES.md`
- Modify: `docs/forge-beta-v040/design/design.md` (deviation statuses)

### Commit

`chore: bump version to 0.4.2`
