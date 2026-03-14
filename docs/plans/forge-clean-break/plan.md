---
status: completed
---

# Forge Clean Break — Implementation Plan

> See [design](design.md) for context and rationale.
> **For Claude:** Use `forge:subagent-driven-development` to execute this plan.

**Goal:** Complete the identity transition from obra/superpowers to Forge (rahulsc/superpowers), with proper attribution, full superpowers→forge rename, updated documentation, and cleanup.

**Architecture:** Four layered commits on the `worktree-forge-v0` branch. Each commit depends on the previous. Documentation, metadata, and rename only — no code logic changes.

**Tech Stack:** Markdown, JSON, JavaScript (platform adapters), Bash (hooks, tests), HTML

**Worktree:** `/home/rahulsc/Projects/Superpowers/.claude/worktrees/forge-v0`

---

## Tasks

1. Task 1: Attribution Layer
2. Task 2: Full Identity Rename + URL Rewrite
3. Task 3: Documentation Refresh & README Rewrite
4. Task 4: Release Notes Reset

## Test Expectations Summary

| Task | What to test | Expected verification |
|------|-------------|----------------------|
| 1 | Dual MIT LICENSE; NOTICE.md + ORIGINS.md exist; FUNDING.yml gone | `grep -c "MIT License" LICENSE` = 2; files exist; FUNDING.yml absent |
| 2 | No "superpowers" in actionable files | `grep -rl "superpowers"` returns only attribution, analytical, and planning files |
| 3 | README describes 21 skills; stale docs deleted; attribution section present | grep checks + directory absence |
| 4 | RELEASE-NOTES starts at v0.1.0 with full Forge MVP description | `head -5 RELEASE-NOTES.md` shows v0.1.0 |
