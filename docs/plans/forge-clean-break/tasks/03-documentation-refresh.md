# Task 3: Documentation Refresh & README Rewrite

**Depends on:** Task 2 (URLs and naming must be updated before README rewrite references them)
**Produces:** Rewritten README.md reflecting Forge MVP, deleted stale docs

## Goal

Rewrite README.md to describe the actual Forge MVP (21 skills, .forge/ infrastructure, risk engine, packs), and delete stale pre-Forge documentation.

## Acceptance Criteria

- [ ] README.md title is "Forge (working title)"
- [ ] README.md describes 21 skills in 6 categories
- [ ] README.md has sections for Forge infrastructure (.forge/, risk engine, packs)
- [ ] README.md has "Attribution" section linking to NOTICE.md and ORIGINS.md
- [ ] README.md installation section uses rahulsc/superpowers URLs and forge naming in paths
- [ ] README.md no longer has sponsorship section or obra-specific references
- [ ] `docs/superpowers/` directory deleted (6 files: 3 plans + 3 specs)
- [ ] `docs/research/` directory deleted (5 files)

## Test Expectations

- **Test:** README contains Forge identity and attribution
- **Verification:** `grep -c "Attribution" README.md` >= 1; `grep -c "NOTICE.md" README.md` >= 1
- **Test:** README lists all skill categories
- **Verification:** `grep -c "forge-routing\|adopting-forge\|forge-packs\|forge-viz" README.md` >= 4
- **Test:** Stale docs deleted
- **Verification:** `test ! -d docs/superpowers && test ! -d docs/research`

## Files

- Rewrite: `README.md` — full rewrite for Forge MVP identity
- Delete: `docs/superpowers/plans/2026-01-22-document-review-system.md`
- Delete: `docs/superpowers/plans/2026-02-19-visual-brainstorming-refactor.md`
- Delete: `docs/superpowers/plans/2026-03-11-zero-dep-brainstorm-server.md`
- Delete: `docs/superpowers/specs/2026-01-22-document-review-system-design.md`
- Delete: `docs/superpowers/specs/2026-02-19-visual-brainstorming-refactor-design.md`
- Delete: `docs/superpowers/specs/2026-03-11-zero-dep-brainstorm-server-design.md`
- Delete: `docs/research/e2e-workflow-audit.md`
- Delete: `docs/research/upstream-closed-issues.md`
- Delete: `docs/research/upstream-forks-survey.md`
- Delete: `docs/research/upstream-open-issues-prs.md`
- Delete: `docs/research/upstream-unmerged-prs.md`

## Implementation Notes

**README.md structure:**

```
# Forge (working title)

Forge is a structured operating mode for AI-assisted software development —
an independent evolution of [Superpowers](https://github.com/obra/superpowers)
by Jesse Vincent.

## What is Forge?

[2-3 paragraphs: durable project memory, risk-scaled ceremony, evidence-gated
completion, multi-agent teams, pack protocol. What makes Forge different.]

## How it works

[Same brainstorming → planning → execution flow, framed as Forge's approach]

## Installation

[All platforms: Claude Code Official Marketplace, Claude Code Plugin Marketplace,
Cursor, Codex, OpenCode, Gemini CLI — with rahulsc/superpowers URLs and
forge naming in paths. Keep Verify Installation section.]

## Skills Library (21 skills)

**Routing**
- forge-routing — Determines workflow phase before any action

**Adoption & Setup**
- adopting-forge — First-time Forge setup in a repository
- setting-up-project — Bridges design approval to execution strategy
- syncing-forge — Regenerate adapters after config changes
- diagnosing-forge — Health checks for .forge/ state

**Design & Planning**
- brainstorming — Socratic design refinement
- writing-plans — Detailed implementation plans
- composing-teams — Assemble specialist agent teams

**Execution**
- subagent-driven-development — Fresh subagent per task with two-stage review
- agent-team-driven-development — Persistent specialists in parallel waves
- test-driven-development — RED-GREEN-REFACTOR cycle
- using-git-worktrees — Isolated development workspaces
- validating-wave-compliance — Between-wave verification gates

**Review & Completion**
- requesting-code-review — Pre-review checklist
- receiving-code-review — Responding to feedback with rigor
- verification-before-completion — Evidence-gated completion claims
- finishing-a-development-branch — Merge/PR decision workflow

**Meta & Extensibility**
- writing-skills — Create new skills following TDD methodology
- forge-packs — Install and manage reusable skill/policy bundles
- forge-viz — Browser dashboard for workflow visualization

## Forge Infrastructure

[.forge/ directory: project.yaml, risk classification engine, persistent state
(SQLite/JSON backends), evidence collection, cross-session memory, pack protocol,
shared knowledge templates, workflow definitions]

## Agent Definitions

[5 specialists: architect, implementer, QA engineer, code reviewer, security reviewer]

## Philosophy

- Test-Driven Development — Write tests first, always
- Systematic over ad-hoc — Process over guessing
- Complexity reduction — Simplicity as primary goal
- Evidence over claims — Verify before declaring success

## Contributing

[Fork from rahulsc/superpowers, follow writing-skills]

## Updating

[Plugin update instructions]

## License

MIT License — see [LICENSE](LICENSE) file for details.

## Attribution

Forge is derived from [Superpowers](https://github.com/obra/superpowers),
originally created by Jesse Vincent. See [NOTICE.md](NOTICE.md) for formal
attribution and [ORIGINS.md](ORIGINS.md) for the full story.

## Support

- **Issues**: https://github.com/rahulsc/superpowers/issues
```

**DO NOT include:** obra blog link, marketplace link, sponsorship section.

**Stale doc deletion:** Use `git rm -r docs/superpowers/ docs/research/`. These are available in the frozen fork at rahulsc/superpowers (main branch).

## Commit

`docs: rewrite README for Forge MVP identity, delete stale pre-Forge documentation`
