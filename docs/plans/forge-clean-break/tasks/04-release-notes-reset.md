# Task 4: Release Notes Reset

**Depends on:** Task 3 (all docs must be final before release notes describe them)
**Produces:** Fresh RELEASE-NOTES.md describing Forge v0.1.0

## Goal

Replace the 1009-line upstream release notes with a fresh v0.1.0 entry describing the actual Forge MVP.

## Acceptance Criteria

- [ ] RELEASE-NOTES.md starts with "# Forge Release Notes" and v0.1.0
- [ ] v0.1.0 entry describes all 21 skills by category
- [ ] v0.1.0 entry describes .forge/ infrastructure (state, risk engine, packs, evidence, memory)
- [ ] v0.1.0 entry describes 4 Forge hooks, 5 agent definitions, multi-platform support
- [ ] v0.1.0 entry describes what changed from upstream
- [ ] Footer points to rahulsc/superpowers (frozen fork) and obra/superpowers (original)
- [ ] No upstream release history remains in the file

## Test Expectations

- **Test:** Release notes start at v0.1.0
- **Verification:** `head -5 RELEASE-NOTES.md` shows v0.1.0 as first version entry
- **Test:** Footer references frozen fork
- **Verification:** `grep "rahulsc/superpowers" RELEASE-NOTES.md` returns a hit
- **Test:** No old version entries
- **Verification:** `grep -c "^## v[0-9]" RELEASE-NOTES.md` returns exactly 1

## Files

- Rewrite: `RELEASE-NOTES.md`

## Implementation Notes

**RELEASE-NOTES.md — replace entirely with:**

```markdown
# Forge Release Notes

## v0.1.0 (2026-03-13)

### Initial Release — Clean Break from Superpowers

Forge is a structured operating mode for AI-assisted software development,
independently evolved from [Superpowers](https://github.com/obra/superpowers)
by Jesse Vincent.

#### 21 Skills

**Routing:** forge-routing

**Adoption & Setup:** adopting-forge, setting-up-project, syncing-forge, diagnosing-forge

**Design & Planning:** brainstorming, writing-plans, composing-teams

**Execution:** subagent-driven-development, agent-team-driven-development,
test-driven-development, using-git-worktrees, validating-wave-compliance

**Review & Completion:** requesting-code-review, receiving-code-review,
verification-before-completion, finishing-a-development-branch

**Meta & Extensibility:** writing-skills, forge-packs, forge-viz

#### Forge Infrastructure

- **`.forge/` directory** — project.yaml configuration, risk policies, shared
  knowledge templates, workflow definitions, adapter and pack directories
- **Risk classification engine** — Two-dimensional policy + scope matrix with
  four tiers (minimal/standard/elevated/critical), file-glob-based policy rules
- **Persistent state** — forge-state helper with SQLite and JSON backends for
  cross-session continuity
- **Evidence collection** — forge-evidence utility for structured verification output
- **Cross-session memory** — forge-memory for knowledge promotion and recall
- **Pack protocol** — forge-pack CLI for installing, removing, and listing
  reusable bundles of skills, policies, and shared knowledge
- **Sample pack** — forge-pack-hello-world demonstrating pack.yaml manifest format

#### 4 Forge Hooks

- forge-session-start — Session initialization, state cleanup, memory promotion
- forge-gate — Evidence verification gate before completion claims
- forge-pre-commit — Pre-commit validation
- forge-task-completed — Task completion handler, state updates, knowledge promotion

#### 5 Agent Definitions

Architect, implementer, QA engineer, code reviewer, security reviewer

#### Multi-Platform Support

Claude Code, Cursor, OpenAI Codex, OpenCode, Gemini CLI

#### What Changed from Upstream Superpowers

- Complete identity transition: superpowers → forge across all files
- 8 new skills (forge-routing, adopting-forge, setting-up-project, syncing-forge,
  diagnosing-forge, forge-packs, forge-viz, validating-wave-compliance)
- .forge/ directory with risk classification, persistent state, evidence collection,
  memory, and pack protocol
- 4 Forge-specific hooks replacing upstream session-start
- Multi-agent team composition and orchestration
- Verification wiring and evidence-gated completion
- Risk-scaled ceremony (scale process to match task complexity)
- Pipelined TDD (QA agents write tests ahead of implementers)
- Dual MIT licensing with proper attribution

---

*For release history prior to the Forge divergence, see the frozen fork at
[rahulsc/superpowers](https://github.com/rahulsc/superpowers). The original
project is at [obra/superpowers](https://github.com/obra/superpowers).*
```

## Commit

`chore: reset release notes to Forge v0.1.0`
