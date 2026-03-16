# Forge v0.4.2 Design Document

**Version:** Draft 1
**Date:** 2026-03-16
**Status:** Awaiting review
**Scope:** v0.4.2 — Fix reference project infrastructure (deviations #17-20)

---

## 1. Summary

v0.4.2 fixes the 4 blockers that caused the v0.4.1 reference project run to fail. All fixes are skill text edits + runbook update. No new code.

## 2. Tasks

### 2.1 Audit Recording in Agent Prompts (Deviation #17)

Update `agent-team-driven-development` SKILL.md to instruct agents to call `bin/forge-audit record` at task boundaries.

Add to the implementer prompt template section:

```markdown
**Audit recording:** At the start and end of your task, record audit events:
```bash
bin/forge-audit record --type task_start --skill <skill-name> --detail '{"task":"<task-id>"}'
# ... do work ...
bin/forge-audit record --type task_completion --skill <skill-name> --detail '{"task":"<task-id>","tests_passed":<N>}'
```
Events record at the repo root audit log. If `bin/forge-audit` is not available or audit is not enabled, skip silently.
```

Also add to the lead's between-waves section:
```markdown
**Audit:** After each wave, record:
```bash
bin/forge-audit record --type wave_completion --detail '{"wave":<N>,"tasks_completed":[<ids>]}'
```
```

### 2.2 Approval Manifest Integration (Deviation #19)

Update `agent-team-driven-development` SKILL.md to read `approvals.yaml` at the start of execution.

Add to Phase 1 (Plan Analysis & Team Setup):

```markdown
**Approval manifest:** If an `approvals.yaml` file exists in the project directory, read it and present to the user:

> "This project has a pre-defined approval manifest. Approving these permissions means you won't be prompted for them during execution:
>
> [list permissions from approvals.yaml]
>
> Approve these permissions for this run? (y/n)"

If approved, agents should note that these operations are pre-approved and not request individual confirmation.
```

### 2.3 Validation Checklist in Finishing (Deviation #18)

Update `finishing-a-development-branch` SKILL.md. Before the existing "Closeout Cleanup" section, add:

```markdown
## User Validation

If a `validation.md` file exists in the project directory:

1. Present the validation checklist to the user
2. Ask them to run the checks (or offer to run automated checks)
3. Record pass/fail for each check
4. Do NOT proceed to merge/PR/cleanup until validation passes

If no `validation.md` exists, skip this step.
```

### 2.4 Runbook Results Process (Deviation #20)

Update `reference-projects/runbook.md` to add a clear "Results Process" section:

```markdown
## Results Process

During a reference project run, commits go to two places:

1. **Deviations and Forge fixes** → commit to main IMMEDIATELY when discovered
   - Don't wait until the run ends
   - These improve Forge for the current and future runs

2. **Run results** → commit to worktree branch, cherry-pick to main after run
   ```bash
   # After run completes, from main:
   git cherry-pick <results-commit-sha>
   ```

3. **Worktree cleanup** → delete after results extracted
   ```bash
   git worktree remove .worktrees/<run-name>
   git branch -d <branch-name>
   ```

**Never leave results only in a worktree branch.** Cherry-pick to main before deleting.
```

### 2.5 Task List Formatting Convention (Deviation #15 partial)

Update `agent-team-driven-development` SKILL.md "Status Reporting" section with the iterated format:

```markdown
## Status Reporting

**Header format:**
**<Project Name>** — <N>/<Total> tasks | <N>/<N> tests implemented | <N>/<N> passing

**Wave format:**
 ● ✅ Wave N: <description> (<N>/<N> tests passing)     — completed wave
 ● 🔄 Wave N: <description>                              — active wave
    • ⏳ T<N>  <agent-name> — <task description>          — in-progress task
 ● ⏭️ Wave N: <description>                               — upcoming wave
    • ◻️ T<N>  — <task description>                        — upcoming task

**When to display:**
- After each task completion
- After each agent spawn
- Between waves (as part of Wave Cleanup Routine)
- Every 30 seconds if no other output (timer-based refresh)
```

### 2.6 Version Bump

Bump manifests to 0.4.2, write release notes.

## 3. Exit Criteria

- Agent prompt template includes `forge-audit record` calls
- `approvals.yaml` integration documented in agent-team-driven-development
- `validation.md` integration documented in finishing-a-development-branch
- Runbook has results process section
- Task list formatting convention documented with icons
- v0.4.2 in all manifests
