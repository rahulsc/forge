---
status: pending
risk_tier: elevated
---

# Forge v0.2.1 Implementation Plan — Execution Fixes

> See [v0.3.0 design](../../forge-beta-v030/design/design.md) §2 for context and rationale.
> **Risk tier:** elevated — design doc reference required
> **For Claude:** Use `forge:subagent-driven-development` to execute this plan.

**Goal:** Fix 4 execution machinery bugs (deviations #4, #6, #7, #8) so that v0.3.0 can use reliable multi-agent execution.

**Architecture:** All 4 fixes are edits to existing skill SKILL.md files. No new infrastructure, no new skills, no code changes. Pure skill prompt updates.

**Tech Stack:** Markdown (SKILL.md files)

**Working directory:** `/home/rahulsc/Projects/forge` (main branch)

---

## Tasks

1. Task 1: Enforce composing-teams in setting-up-project
2. Task 2: Add squash-on-merge to agent-team-driven-development
3. Task 3: Add reliable task cleanup routine to agent-team-driven-development
4. Task 4: Add status visibility to agent-team-driven-development
5. Task 5: Version bump to 0.2.1

---

## Task 1: Enforce composing-teams in setting-up-project

**Depends on:** None
**Produces:** Updated setting-up-project SKILL.md with enforcement gate

### Goal

When `team.decision = team`, the skill must invoke `forge:composing-teams` and block until the user approves a roster. The lead must not improvise team structure.

### Acceptance Criteria

- [ ] Step 4 in SKILL.md explicitly states: "Do NOT proceed to writing-plans until composing-teams has run and team.roster is written to state"
- [ ] A new sub-step is added: "Write team.roster to state after user approves"
- [ ] The handoff to writing-plans references team.roster as a prerequisite
- [ ] The composing-teams invocation includes presenting available agents, recommending specialists per task domain, and getting explicit user approval

### Test Expectations

- **Test:** grep for "Do NOT proceed to writing-plans until composing-teams" in the SKILL.md
- **Expected red failure:** string not found
- **Expected green:** string found in Step 4

### Files

- Modify: `skills/setting-up-project/SKILL.md` (Step 4 — Team Decision section, ~lines 107-133)

### Implementation Notes

- The current text says "invoke forge:composing-teams" but has no enforcement gate — add one
- Add explicit instruction: composing-teams must present available agents from `agents/` directory, recommend specialist-to-task mapping, show model tier per role, and get user approval
- After approval, write: `forge-state set team.roster "<approved roster JSON>"`
- Update the State Written section to include `team.roster`
- Update the Integration section to note that writing-plans reads `team.roster`
- Do NOT change the team criteria evaluation logic (4+ tasks, 2+ parallel, 2+ domains) — only add enforcement after the decision

### Commit

`fix: enforce composing-teams gate in setting-up-project skill`

---

## Task 2: Add squash-on-merge to agent-team-driven-development

**Depends on:** None
**Produces:** Updated agent-team-driven-development SKILL.md with squash-on-merge default

### Goal

When merging implementer worktree branches between waves, default to `git merge --squash` so each task produces one clean commit on main.

### Acceptance Criteria

- [ ] "Between waves" section specifies `git merge --squash` as the default merge strategy
- [ ] Instruction to use the task's commit message from the plan spec
- [ ] Explicit note that the lead can opt out of squash when a task has genuinely distinct logical changes
- [ ] The merge step in the process flow diagram reflects squash

### Test Expectations

- **Test:** grep for "merge --squash" in the SKILL.md
- **Expected red failure:** string not found
- **Expected green:** string found in the between-waves section

### Files

- Modify: `skills/agent-team-driven-development/SKILL.md` (Between waves section, ~lines 275-288; Git Isolation section, ~lines 110-140)

### Implementation Notes

- Current text at line 124 says "lead merges implementer branches into main worktree" — update to specify `--squash`
- Add to between-waves instructions (after line 277): "Use `git merge --squash <branch>` followed by `git commit -m '<task commit message from plan>'`"
- Add a note: "If a task genuinely has multiple distinct logical changes, the lead may use regular merge instead — but squash is the default"
- Update the dot graph node label at line 193 to mention squash: `"Between Waves:\nSquash-merge worktree branches,\nverify integration"`
- Do NOT change anything about how implementers commit within their worktrees — they can still make multiple working commits

### Commit

`fix: default to squash-on-merge for multi-agent worktree branches`

---

## Task 3: Add reliable task cleanup routine to agent-team-driven-development

**Depends on:** None
**Produces:** Updated agent-team-driven-development SKILL.md with a structured cleanup routine

### Goal

Replace the fragile cleanup sequence with a single reliable routine that runs after each wave and at completion. No stale `in_progress` tasks, no orphaned agents.

### Acceptance Criteria

- [ ] A named cleanup routine is defined (e.g., "Wave Cleanup Routine") with numbered steps
- [ ] The routine runs BEFORE the next wave starts, not after shutdown
- [ ] Steps: mark tasks complete → mark sub-tasks complete → verify no stale tasks → send shutdown to unneeded agents
- [ ] If stale tasks found after verification, force-complete them with a note
- [ ] Phase 3 (Completion) references the same cleanup routine
- [ ] The Red Flags / Cleanup section references the routine

### Test Expectations

- **Test:** grep for "Wave Cleanup Routine" (or equivalent named routine) in the SKILL.md
- **Expected red failure:** no named cleanup routine exists
- **Expected green:** routine found with numbered steps

### Files

- Modify: `skills/agent-team-driven-development/SKILL.md` (Phase 2 between-waves section, ~lines 275-288; Phase 3 Completion, ~lines 288-297; Red Flags Cleanup section, ~lines 357-365)

### Implementation Notes

- Current Phase 3 says: "3. Clean up task list — mark all remaining in_progress tasks as completed via TaskUpdate" — this is correct but not enforced as a routine
- Create a named, reusable block like:
  ```
  ## Wave Cleanup Routine
  Run this routine after each wave completes and during Phase 3:
  1. TaskList — get current state
  2. For each task in current wave: TaskUpdate status=completed (if not already)
  3. For each agent-created sub-task: TaskUpdate status=completed
  4. TaskList — verify zero in_progress tasks remain
  5. If stale tasks found: force-complete with note "cleaned up by lead"
  6. Send shutdown to agents no longer needed for subsequent waves
  ```
- Reference this routine in the between-waves section: "Run Wave Cleanup Routine before starting next wave"
- Reference in Phase 3: "Run Wave Cleanup Routine for final wave"
- The key insight: cleanup happens BEFORE next wave, not as an afterthought

### Commit

`fix: add reliable wave cleanup routine to agent-team-driven-development`

---

## Task 4: Add status visibility to agent-team-driven-development

**Depends on:** None
**Produces:** Updated agent-team-driven-development SKILL.md with status reporting convention

### Goal

The lead posts a text-based status summary after each task completion and between waves, so progress is visible.

### Acceptance Criteria

- [ ] A "Status Reporting" section exists in the SKILL.md
- [ ] After each task completion, lead posts a per-wave status (task name, agent, done/WIP)
- [ ] Between waves, lead posts a full progress summary (all tasks, done/next/blocked)
- [ ] Format is specified with examples
- [ ] The process flow references status reporting at the right points

### Test Expectations

- **Test:** grep for "Status Reporting" section header in the SKILL.md
- **Expected red failure:** section not found
- **Expected green:** section found with format examples

### Files

- Modify: `skills/agent-team-driven-development/SKILL.md` (add new section after "State Tracking" ~line 155; update between-waves to reference it)

### Implementation Notes

- Add a new `## Status Reporting` section with two formats:

  **Per-task completion:**
  ```
  Wave N Status:
    T1 [done]  agent-name — task title (commit abc1234)
    T2 [WIP]   agent-name — task title
    T3 [WIP]   agent-name — task title
  ```

  **Between-waves summary:**
  ```
  Progress: N/M tasks complete (Waves 0-1 done, starting Wave 2)
    T1 [done] T2 [done] T3 [done]
    T4 [next] T5 [next] T6 [next]
    T7 [blocked by T4,T5,T6]
  ```

- Reference status reporting in the between-waves instructions: "Post between-waves summary before starting next wave"
- Reference in Phase 2 per-task flow: "After marking task complete, post per-wave status"
- This is a convention, not tooling — the lead formats and outputs the text

### Commit

`fix: add status reporting convention to agent-team-driven-development`

---

## Task 5: Version Bump to 0.2.1

**Depends on:** Tasks 1-4
**Produces:** v0.2.1 in all plugin manifests, release notes

### Goal

Bump version to 0.2.1, write release notes summarizing the 4 execution fixes.

### Acceptance Criteria

- [ ] `.claude-plugin/plugin.json` version is `0.2.1`
- [ ] `.cursor-plugin/plugin.json` version is `0.2.1`
- [ ] `gemini-extension.json` version is `0.2.1`
- [ ] `RELEASE-NOTES.md` has v0.2.1 section listing the 4 fixes

### Test Expectations

- **Test:** grep for `"version": "0.2.1"` in plugin manifests
- **Expected red failure:** manifests show `0.2.0`
- **Expected green:** all manifests show `0.2.1`

### Files

- Modify: `.claude-plugin/plugin.json` (version field)
- Modify: `.cursor-plugin/plugin.json` (version field)
- Modify: `gemini-extension.json` (version field)
- Modify: `RELEASE-NOTES.md` (add v0.2.1 section)

### Commit

`chore: bump version to 0.2.1`

---

## Test Expectations Summary

| Task | What to test | Expected red failure |
|------|-------------|----------------------|
| 1 | composing-teams enforcement gate in setting-up-project | No enforcement text exists |
| 2 | squash-on-merge in between-waves section | No "merge --squash" in skill |
| 3 | Named cleanup routine with numbered steps | No cleanup routine exists |
| 4 | Status Reporting section with format examples | No status section exists |
| 5 | Plugin manifests show 0.2.1 | Manifests show 0.2.0 |
