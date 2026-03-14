# Forge Release Notes

## v0.3.0 (2026-03-14)

### Adoption, Agents, and Execution

The second staged Beta milestone. Forge can now adopt real repos, has a complete specialist agent roster, and execution is lighter for low-risk work.

#### forge-author Agent (New)
- Created `forge-author` specialist for writing and editing Forge skills and agent definitions
- Informed by Anthropic best practices: concise prompts, appropriate freedom levels, progressive disclosure, HARD-GATEs

#### 4 New Specialist Agents
- `frontend-engineer` — component design, accessibility, browser compatibility, UI testing
- `backend-engineer` — API design, database integration, scalability, error handling
- `database-specialist` — schema design, migration safety, rollback plans, data integrity
- `devops-engineer` — CI/CD pipelines, container config, secrets management, deployment

#### Adoption Flow Rewrite
- LLM exposure warning displayed before repo scanning (user must acknowledge)
- Sensitive file detection (.env, credentials, keys) — excluded from LLM context
- Stack inference: package manager, test runner, linter, CI surface, critical paths
- CLAUDE.md generation with `<!-- forge:begin/end -->` managed blocks (never overwrites user content)
- AGENTS.md generation with same managed block strategy (lists all 10 agents)

#### forge sync and forge doctor Updates
- `forge sync` regenerates managed blocks preserving content outside markers
- `forge sync --re-infer` re-detects stack from repo
- `forge sync --force` re-creates markers from scratch
- `forge doctor` validates 9 health checks with pass/fail report and fix suggestions

#### Routing Improvements
- Resume work route: detects existing forge-state, offers to continue
- Prepare release route: "ship it", "cut a release", "prepare release"
- Ambiguous intent handling: asks user instead of guessing

#### Execution Ergonomics
- Worktrees optional for minimal-risk work (not created for minimal tier)
- Review tiers: mechanical (single check), standard (two-stage), complex (two-stage + lead)

---

## v0.2.1 (2026-03-14)

### Execution Fixes

Patch release fixing 4 multi-agent execution issues discovered during v0.2.0 dogfooding.

- **Composing-teams enforcement** — `setting-up-project` now blocks with a HARD-GATE until `forge:composing-teams` has run and the user approves the team roster. Prevents improvised team structure.
- **Squash-on-merge** — `agent-team-driven-development` defaults to `git merge --squash` when merging worktree branches, producing one clean commit per task on main.
- **Wave cleanup routine** — Named routine runs before each new wave: marks tasks complete, cleans sub-tasks, verifies no stale state, sends shutdown to unneeded agents.
- **Status reporting** — Per-task and between-wave status summaries make multi-agent execution visible at a glance.

---

## v0.2.0 (2026-03-14)

### Trust, Identity, and Documentation

The first staged Beta release. Forge now looks, installs, and documents like Forge.

#### Identity Cleanup
- All 15 stale references to `rahulsc/superpowers` replaced with `rahulsc/forge`
- Plugin manifests, install docs, tests, and HTML templates updated
- Completed plan statuses corrected (forge-v0, forge-clean-break)

#### Skill Convention Audit
- All 21 skills audited for path conventions, artifact naming, and cross-skill references
- Brainstorming skill fixed: design doc path corrected from `docs/plans/<project>/design.md` to `docs/<project>/design/design.md`

#### Project Structure Restructure
- Product artifacts moved from `.forge/` to top-level directories: `bin/`, `policies/`, `adapters/`, `workflows/`, `packs/`
- New `templates/` directory with blank scaffolding for project adoption
- `.forge/` now contains only per-project configuration (project.yaml, shared/, local/)
- 39 files updated with new paths across skills, hooks, tests, and bin tools
- ADR 001 documents the restructure decision

#### README Rewrite
- Complete rewrite with outcome-first structure (416 lines)
- 8 outcome workflows documented: adopt, start feature, fix bug, refactor, review, resume, release, investigate
- Skill flow metro map (Mermaid diagram) showing how skills compose into pipelines
- Capability-level comparison chart vs 7 competing tools
- Getting started walkthrough, verify installation guide, FAQ
- Risk-scaled ceremony explained visually

#### Platform Install Docs
- All platform docs updated with correct post-restructure paths
- Verify Installation sections added to each platform
- Troubleshooting sections added to each platform

#### Repo Metadata
- GitHub description and topics set
- Issue templates (bug report, feature request) added
- PR template added

#### Forge Self-Documentation
- `.forge/shared/architecture.md` filled with Forge's actual architecture
- `.forge/shared/conventions.md` filled with Forge's coding conventions
- First ADR written (001: Product Artifacts Top-Level)

#### Beta Design Document
- Comprehensive design-v3.md covering 8 work streams for v0.2.0–v0.5.0
- Full competitive analysis of 15+ tools
- 6 reference project specifications for dogfooding
- Deviation worklog with 8 entries from v0.2.0 development

---

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

**Debugging:** systematic-debugging

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
