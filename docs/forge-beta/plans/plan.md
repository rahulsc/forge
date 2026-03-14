---
status: pending
risk_tier: elevated
---

# Forge Beta v0.2.0 Implementation Plan

> See [design](../design/design-v3.md) for context and rationale.
> **Risk tier:** elevated — requires design doc reference, wave analysis
> **For Claude:** Use `forge:agent-team-driven-development` to execute this plan.

**Goal:** Make Forge look, install, and document like Forge — establishing canonical identity, clean project structure, and outcome-first documentation before attempting adoption or audit features.

**Architecture:** v0.2.0 is a packaging and trust release. The primary structural change is moving product artifacts from `.forge/` to top-level directories, aligning `bin/`, `policies/`, `adapters/`, `workflows/`, `packs/` with the existing pattern of `agents/`, `skills/`, `hooks/`. All documentation is rewritten around 8 outcome workflows instead of 21 skill names. No new skills or features — only cleanup, restructure, and documentation.

**Tech Stack:** Shell scripts (bash), Markdown, YAML, Mermaid diagrams. No compiled code.

**Working directory:** `/home/rahulsc/Projects/forge` (main branch, backup at `forge-v0.1.1-baseline`)

---

## Roadmap Context

This plan covers v0.2.0 only. Subsequent plans will be written per-version:

| Version | Status | Focus |
|---------|--------|-------|
| **v0.2.0** | **This plan** | Trust, identity, project structure, documentation |
| v0.3.0 | Future plan | Adoption flow, agent roster, execution ergonomics |
| v0.4.0 | Future plan | Audit infrastructure, analysis skill, 3 reference projects |
| v0.5.0 | Future plan | Hardening, 6 reference projects, controlled auto mode |

### Inter-Version Workflow

Between each version:

1. **Version bump and release** — Task 7 of each version bumps plugin manifests and pushes to main. The plugin auto-updates on next Claude Code session launch.
2. **Brainstorming for next version** — After a version ships, run `forge:brainstorming` before writing the next plan. Each version's findings (deviation log, audit results, user feedback) should inform the next version's scope. The design-v3.md is the overall vision, but per-version brainstorming reviews what actually happened and adjusts priorities.
3. **Deviation review** — Before starting the next version's plan, review the deviation worklog from the current version. Patterns found during v0.2.0 may change v0.3.0's scope.

---

## Tasks

1. [Task 1: Identity Cleanup](tasks/01-identity-cleanup.md)
2. [Task 2: Skill Convention Audit](tasks/02-skill-convention-audit.md)
3. [Task 3: Project Structure Restructure](tasks/03-project-restructure.md)
4. [Task 4: Repo Metadata and Trust Surface](tasks/04-repo-metadata.md)
5. [Task 5: README Rewrite](tasks/05-readme-rewrite.md)
6. [Task 6: Platform Install Docs Update](tasks/06-platform-install-docs.md)
7. [Task 7: Version Bump and Release](tasks/07-version-bump.md)

---

## Wave Analysis

### Specialists

| Role | Expertise | Tasks |
|------|-----------|-------|
| implementer-1 | Shell scripts, file operations, git | Tasks 1, 3 |
| implementer-2 | Skill authoring, YAML, markdown conventions | Task 2 |
| implementer-3 | Documentation, technical writing, Mermaid | Tasks 5, 6 |
| implementer-4 | GitHub config, repo metadata | Task 4 |
| qa-engineer | Test scripts, verification, grep-based assertions | Pipelined TDD |

### Waves

**Wave 0: Cleanup**
- Task 1 (implementer-1) — Fix 15 stale superpowers references + update plan statuses
- Task 2 (implementer-2) — Audit 21 skills for convention mismatches, fix brainstorming path bug + any others
- *(parallel)* QA writes verification tests for Wave 1 (restructure validation scripts)

  *Parallel-safe because:* Task 1 touches user-facing files (README, plugin manifests, install docs, tests). Task 2 touches skill SKILL.md files. No overlap. QA writes test scripts in `tests/`.

**Wave 1: Restructure**
- Task 3 (implementer-1) — Move product artifacts from `.forge/` to top level, update all references, create templates dir, write ADR

  *Depends on Wave 0:* Identity cleanup must be done first so restructure doesn't have to fix stale refs in moved files. Skill audit must be done so convention fixes don't conflict with path updates.

  *QA parallel:* QA writes verification tests for Wave 2 (README content checks, metadata checks)

**Wave 2: Documentation**
- Task 4 (implementer-4) — Add repo description, topics, issue/PR templates
- Task 5 (implementer-3) — Complete README rewrite with outcome-first structure
- Task 6 (implementer-3 or separate) — Update all platform-specific install docs

  *Depends on Wave 1:* README and install docs must reference correct (post-restructure) file paths. Repo metadata needs canonical identity established.

  *Parallel-safe because:* Task 4 writes `.github/` templates. Task 5 writes `README.md`. Task 6 writes `.codex/INSTALL.md`, `.opencode/INSTALL.md`, `docs/README.codex.md`, `docs/README.opencode.md`. No file overlap.

**Wave 3: Release**
- Task 7 (implementer-1) — Version bump to 0.2.0, release notes, plugin update verification

  *Depends on Wave 2:* All content must be final before version bump.

### Dependency Graph

```
Wave 0: T1 (identity) + T2 (skill audit) + QA tests W1
                    │
                    ▼
Wave 1: T3 (restructure) + QA tests W2
                    │
                    ▼
Wave 2: T4 (metadata) + T5 (README) + T6 (install docs) + QA verify all
                    │
                    ▼
Wave 3: T7 (version bump + release verification)
```

---

## Test Expectations Summary

| Task | What to test | Expected red failure |
|------|-------------|----------------------|
| 1 | Zero stale superpowers refs in non-attribution files | grep finds matches before cleanup |
| 2 | Brainstorming skill uses correct design doc path | SKILL.md contains `docs/plans/<project>/design.md` before fix |
| 3 | bin/ tools work from new top-level location | `bin/forge-state --help` fails (path doesn't exist yet) |
| 3 | All .forge/bin/, .forge/policies/, .forge/adapters/ directories no longer exist | Directories still present before move |
| 3 | Existing test suite passes with new paths | Tests fail on old paths |
| 4 | Issue and PR templates exist | `.github/ISSUE_TEMPLATE/` doesn't exist |
| 5 | README contains all 8 workflow sections | Current README lacks workflow sections |
| 5 | README contains Mermaid skill flow diagram | Current README has no Mermaid diagram |
| 6 | Install docs reference correct repo and paths | Docs reference `rahulsc/superpowers` |
| 7 | Plugin manifests show version 0.2.0 | Manifests show 0.1.1 |
