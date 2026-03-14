---
status: pending
risk_tier: elevated
---

# Forge v0.3.0 Implementation Plan — Adoption and Workflow Surface

> See [design](../design/design.md) for context and rationale.
> **Risk tier:** elevated — design doc reference, wave analysis required
> **For Claude:** Use `forge:agent-team-driven-development` to execute this plan.

**Goal:** Forge can adopt a real repo and guide work by outcomes — with a complete agent roster, lighter execution ergonomics, and safe CLAUDE.md/AGENTS.md generation.

**Architecture:** Wave 0 creates the forge-author agent (informed by R&D on authoring best practices). Subsequent waves use forge-author to create 4 new specialist agents, update execution ergonomics, rewrite the adoption flow, and improve routing. All work is skill/agent markdown edits — no compiled code.

**Tech Stack:** Markdown (SKILL.md, agent .md files), YAML (project.yaml, policies), Shell (bin/ tools if needed)

**Working directory:** `/home/rahulsc/Projects/forge` (main branch)

**Note:** Phase 1 (execution fixes — deviations #4, #6, #7, #8) was shipped in v0.2.1. This plan covers Phase 2 (agents + ergonomics) and Phase 3 (adoption flow) from the design.

---

## Tasks

1. [Task 1: R&D + Create forge-author Agent](tasks/01-forge-author.md)
2. [Task 2: Create 4 New Specialist Agents](tasks/02-specialist-agents.md)
3. [Task 3: Update Execution Ergonomics](tasks/03-execution-ergonomics.md)
4. [Task 4: Rewrite Adopting-Forge Skill](tasks/04-adopting-forge.md)
5. [Task 5: Update Syncing-Forge and Diagnosing-Forge Skills](tasks/05-sync-and-doctor.md)
6. [Task 6: Update Forge-Routing Skill](tasks/06-routing-improvements.md)
7. [Task 7: Architecture Update + Version Bump](tasks/07-version-bump.md)

---

## Wave Analysis

### Specialists

| Role | Agent | Model | Tasks |
|------|-------|-------|-------|
| Lead | — | opus | T1 (R&D + forge-author creation), T7 (architecture + release) |
| Forge Author A | `forge-author` | opus | T2 (specialist agents), T4 (adopting-forge), T6 (routing) |
| Forge Author B | `forge-author` | opus | T3 (ergonomics), T5 (sync + doctor) |

### Waves

**Wave 0: R&D + forge-author creation**
- T1 (Lead) — Research best practices for skill/agent authoring, then create `agents/forge-author.md`

  *Sequential:* R&D informs the agent definition. Must complete before forge-authors can be spawned.

**Wave 1: Agent definitions + Ergonomics**
- T2 (Forge Author A) — Create frontend-engineer.md, backend-engineer.md, database-specialist.md, devops-engineer.md
- T3 (Forge Author B) — Update worktree tiers in setting-up-project, add review tiers in agent-team-driven-development

  *Parallel-safe because:* T2 creates new files in `agents/`. T3 modifies `skills/setting-up-project/SKILL.md` and `skills/agent-team-driven-development/SKILL.md`. No file overlap.

**Wave 2: Adoption flow**
- T4 (Forge Author A) — Rewrite `skills/adopting-forge/SKILL.md` with LLM warning, sensitive file detection, stack inference, CLAUDE.md/AGENTS.md generation
- T5 (Forge Author B) — Update `skills/syncing-forge/SKILL.md` and `skills/diagnosing-forge/SKILL.md` with managed block sync and doctor checks

  *Parallel-safe because:* T4 modifies adopting-forge. T5 modifies syncing-forge and diagnosing-forge. Different skill directories.

**Wave 3: Routing + Release**
- T6 (Forge Author A) — Update `skills/forge-routing/SKILL.md` with resume, release, ambiguous intent handling
- T7 (Lead) — Update `.forge/shared/architecture.md`, version bump to 0.3.0, release notes

  *Parallel-safe because:* T6 modifies forge-routing skill. T7 modifies architecture.md, plugin manifests, and RELEASE-NOTES.md. No overlap.

### Dependency Graph

```
Wave 0: T1 (R&D + forge-author)
              │
              ▼
Wave 1: T2 (4 agents) + T3 (ergonomics)
              │
              ▼
Wave 2: T4 (adopting-forge) + T5 (sync + doctor)
              │
              ▼
Wave 3: T6 (routing) + T7 (version bump)
```

---

## Test Expectations Summary

| Task | What to test | Expected red failure |
|------|-------------|----------------------|
| 1 | `agents/forge-author.md` exists with skill/agent authoring expertise | File doesn't exist |
| 2 | All 4 new agent files exist in `agents/` | Files don't exist |
| 2 | `composing-teams` can discover the new agents | New agents not found in scan |
| 3 | Worktree tier table shows "Not created" for minimal | Current table shows "Optional" |
| 3 | Review tier table exists with mechanical/standard/complex | No review tier table |
| 4 | adopting-forge SKILL.md contains LLM exposure warning | No warning text |
| 4 | adopting-forge SKILL.md contains managed block template | No `forge:begin` marker template |
| 5 | syncing-forge SKILL.md references managed block markers | No marker reference |
| 5 | diagnosing-forge SKILL.md contains marker validation check | No marker check |
| 6 | forge-routing SKILL.md contains "resume" and "release" routes | Routes missing |
| 7 | Plugin manifests show 0.3.0 | Manifests show 0.2.1 |
