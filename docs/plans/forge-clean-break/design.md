# Forge Clean Break — Design Document

**Date:** 2026-03-13
**Status:** Approved
**Branch:** worktree-forge-v0
**Approach:** Layered commits (Approach B)

## Problem

The Forge MVP (40 commits on worktree-forge-v0) still carries identity artifacts from the upstream obra/superpowers project: URLs, author metadata, sponsorship links, release history, licensing, filenames, hook bootstrap text, command references, and test assertions. Additionally, a full superpowers → forge rename is needed across hooks, commands, platform adapters, tests, and plugin manifests. This is a clean break — every file must reflect that Forge is an independent evolution.

## Scope

- Establish dual-MIT licensing and attribution files (NOTICE.md, ORIGINS.md)
- Rewrite all obra/superpowers URLs to rahulsc/superpowers
- Complete the superpowers → forge rename across all remaining files (hooks, commands, platform adapters, manifests, tests, HTML)
- Rewrite README.md to describe the actual Forge MVP (21 skills, .forge/ infrastructure, risk engine, packs)
- Delete stale pre-Forge documentation (available in frozen fork)
- Reset release notes to v0.1.0 describing the Forge MVP

## Out of Scope

- Code logic changes to skills, agents, hooks, or the .forge/ infrastructure
- Renaming the Git repository itself (deferred to product name finalization)
- Any changes to skill behavior or functionality

## Already Done (by MVP commits)

- Skill SKILL.md files already use `forge:` prefix
- Agent definitions already reference `forge:` skills
- `.forge/` directory already exists (replaces `.superpowers/` for infrastructure)
- 3 old skills removed (using-superpowers, executing-plans, dispatching-parallel-agents)
- Integration test `no-superpowers-references.sh` verifies skill/agent source cleanup

## Design

### Commit 1: Attribution Layer

**New files:**

**LICENSE** — Dual MIT license:
- Top: Copyright (c) 2026 Rahul Singh Chauhan, full MIT text
- Separator with attribution line
- Bottom: preserved upstream — Copyright (c) 2025 Jesse Vincent, full MIT text

**NOTICE.md** — Formal attribution:
- Forge derived from Superpowers by Jesse Vincent
- Independent project, not affiliated with upstream
- Original MIT license preserved in LICENSE

**ORIGINS.md** — Narrative (~200 words):
- What Superpowers was, what we built on top
- Why we diverged (structured operating mode, durable memory, risk-scaled ceremony)
- Frozen fork at rahulsc/superpowers as divergence point
- Original project at obra/superpowers

**Deleted:**
- `.github/FUNDING.yml`

### Commit 2: Full Identity Rename + URL Rewrite

**URL rewrite** — all `obra/superpowers` → `rahulsc/superpowers`:

| File | Count |
|------|-------|
| README.md | ~7 URLs |
| .claude-plugin/plugin.json | 2 |
| .cursor-plugin/plugin.json | 2 |
| .opencode/INSTALL.md | 3 |
| .codex/INSTALL.md | 1-2 |
| docs/README.opencode.md | 8 |
| docs/README.codex.md | 4 |

**Plugin manifest updates (4 files):**
- `"name": "forge"` (was "superpowers")
- `"displayName": "Forge"` (was "Superpowers")
- `"version": "0.1.0"` (was 6.1.0 / 5.0.0)
- `"author": {"name": "Rahul Singh Chauhan"}` (was Jesse Vincent)
- `"homepage"` / `"repository"`: `https://github.com/rahulsc/superpowers`

**Filename renames:**
- `.opencode/plugins/superpowers.js` → `.opencode/plugins/forge.js`
- Update all symlink path references in install docs from `superpowers` to `forge`

**Hook updates:**
- `hooks/session-start` — rewrite bootstrap:
  - Reference `forge-routing` instead of `using-superpowers`
  - Update injection text from "You have superpowers" / "superpowers:using-superpowers" to Forge equivalents
  - Update legacy path from `~/.config/superpowers/skills` to `~/.config/forge/skills`
- `hooks/run-tests` — update comment

**Command updates (3 files):**
- `commands/brainstorm.md` — `superpowers:brainstorming` → `forge:brainstorming`
- `commands/write-plan.md` — `superpowers:writing-plans` → `forge:writing-plans`
- `commands/execute-plan.md` — `superpowers:executing-plans` → `forge:subagent-driven-development`

**Other file updates:**
- `GEMINI.md` — `using-superpowers/SKILL.md` → `forge-routing/SKILL.md`
- `skills/brainstorming/scripts/frame-template.html` — URL + "Forge Brainstorming" text
- `.opencode/plugins/forge.js` (renamed) — update internal references to load `forge-routing` instead of `using-superpowers`

**Test files (~30 files):**
- Update plugin dir references, skill name patterns, assertion strings from `superpowers` to `forge`
- Update test helper functions
- Update scaffold/plan files in test fixtures

**Intentionally unchanged:**
- docs/research/* (analytical context, being deleted in commit 3)
- docs/forge_competitive_research.md, docs/forge_ideation_v1.md (analytical context)
- NOTICE.md, ORIGINS.md, LICENSE (attribution files)
- docs/plans/* (planning context)

### Commit 3: Documentation Refresh & README Rewrite

**README.md — full rewrite for Forge MVP:**
- Header: Forge (working title)
- What is Forge: structured operating mode with durable memory, risk-scaled ceremony, evidence-gated completion, multi-agent teams, pack protocol
- Installation: all platforms (Claude Code, Cursor, Codex, OpenCode, Gemini) with updated URLs
- 21 skills in 6 categories:
  - Routing: forge-routing
  - Adoption & Setup: adopting-forge, setting-up-project, syncing-forge, diagnosing-forge
  - Design & Planning: brainstorming, writing-plans, composing-teams
  - Execution: subagent-driven-development, agent-team-driven-development, test-driven-development, using-git-worktrees, validating-wave-compliance
  - Review & Completion: requesting-code-review, receiving-code-review, verification-before-completion, finishing-a-development-branch
  - Meta & Extensibility: writing-skills, forge-packs, forge-viz
- Forge infrastructure: .forge/ directory, risk engine, pack protocol, evidence/memory, persistent state
- 5 agent definitions
- Philosophy: TDD, systematic, complexity reduction, evidence over claims
- Attribution section linking to NOTICE.md and ORIGINS.md

**Stale docs deleted:**
- `docs/superpowers/plans/` (3 files)
- `docs/superpowers/specs/` (3 files)
- `docs/research/` (5 files)

### Commit 4: Release Notes Reset

**RELEASE-NOTES.md — replaced with v0.1.0:**
- Describes the full Forge MVP:
  - 21 skills (full list with categories)
  - .forge/ infrastructure (project.yaml, risk classification, persistent state, evidence, memory, packs, shared knowledge)
  - 4 Forge hooks
  - 5 agent definitions
  - Multi-platform support
  - Pack protocol with hello-world sample
  - What changed from upstream
- Footer: "For release history prior to the Forge divergence, see the frozen fork at rahulsc/superpowers."

## Testing Strategy

No unit/integration tests — documentation, metadata, and rename only.

**Verification per commit:**

1. **Attribution**: `grep -c "MIT License" LICENSE` returns 2; NOTICE.md and ORIGINS.md exist; FUNDING.yml gone
2. **Rename + URLs**: `grep -rl "superpowers"` returns hits ONLY in attribution files (NOTICE/ORIGINS/LICENSE/RELEASE-NOTES), analytical docs (research, competitive, ideation), and planning docs
3. **Docs**: README describes 21 skills and .forge/ infrastructure; stale docs/superpowers/ and docs/research/ deleted; attribution section present
4. **Release notes**: starts at v0.1.0; describes full Forge MVP; footer references frozen fork
