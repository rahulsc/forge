# Forge Release Notes

## v0.4.3 (2026-03-16)

### First Successful Reference Project Run

Task Tracker API (inspired by Linear/Asana) built end-to-end with full Forge workflow.

- **56 tests**, 13 validation checks, 23 audit events — all passing
- **TDD** exercised: RED/GREEN on all 5 build tasks + 3 code review fixes
- **Code review** found 5 critical + 7 suggestions; 3 must-fix issues resolved
- **Full skill coverage:** verification-before-completion, requesting-code-review, receiving-code-review, finishing-a-development-branch, analyze-audit — all invoked for the first time on real code
- **Explicit `--project-dir`** for all audit calls ensures events go to correct location
- **3 attempts** to reach clean run — each exposed infrastructure gaps (audit capture, validation checklist, approval manifest) that were fixed in v0.4.1 and v0.4.2 before retrying

---

## v0.4.2 (2026-03-16)

### Reference Project Infrastructure Fixes

Fixes 4 blockers from the failed v0.4.1 reference project run:

- **Audit recording in agent prompts** — agents call `bin/forge-audit record` at task start/end. Lead records wave_completion between waves. All calls best-effort.
- **Approval manifest** — `agent-team-driven-development` reads `approvals.yaml` at execution start for one-time approval.
- **Validation checklist** — `finishing-a-development-branch` reads `validation.md` with HARD-GATE preventing completion without validation.
- **Results process** — runbook documents: deviations to main immediately, results cherry-picked, worktree deleted.
- **Task list formatting** — wave-grouped format with icons (✅ 🔄 ⏭️ ⏳ ◻️), test counts, 30s timer refresh.
- Deviations #15, #17-20 fixed.

---

## v0.4.1 (2026-03-15)

### Agent Shutdown Fix + Reference Project Infrastructure

- **Agent shutdown fix** — wave-suffixed agent names (`forge-author-w0`, `shell-eng-w1`) prevent name collisions across waves. Structured `shutdown_request` only — never plain text. Immediate shutdown after wave completion, not batched at end.
- **Audit UX** — enhanced audit opt-in description ("What it does", "What it's used for"). End-of-workflow audit prompt in finishing-a-development-branch tells users to run `forge:analyze-audit`.
- **Stale task cleanup** — brainstorming checks TaskList at session start and offers to clean orphaned tasks. finishing-a-development-branch cleans remaining tasks at closeout.
- **Assessment formatting** — setting-up-project now uses table format for risk/team assessment and readiness summary.
- **Reference project infrastructure** — `reference-projects/` directory with runbook, 6 project specs (spec.yaml + scaffold.sh + measure.sh). Projects: Task Tracker API, Dashboard UI, CLI Migration Tool, Deploy Pipeline, Auth Service, Full-Stack Notes App.
- **Deviations #12-13 fixed**, #14 (formatting audit) logged for v0.5.0.

---

## v0.4.0 (2026-03-15)

### Audit Infrastructure (TDD Milestone)

The first version built with test-driven development — tests written before implementation.

#### bin/forge-audit (TDD)
- New CLI tool for JSONL event recording (165 lines)
- 5 test scripts written first (RED), implementation made them pass (GREEN) — 37/37 assertions
- Events: session_start, skill_enter, skill_exit, gate_check, task_completion, routing_decision
- Opt-in via `.forge/project.yaml` (`audit.enabled: true`) — default off, no overhead when disabled

#### Hook Integration
- `forge-session-start` records session_start events
- `forge-task-completed` records task_completion events
- `forge-pre-commit` records gate_check events with pass/fail outcome
- All audit calls are best-effort (`|| true`) — never block hook execution

#### Brainstorming Audit Opt-In
- Brainstorming skill asks "Enable audit mode?" once per project (default: no)
- Stored in forge-state, not re-asked on subsequent sessions

#### analyze-audit Upgrade
- Now reads JSONL audit files alongside manual deviation logs
- New dimensions: token cost per skill, token cost per workflow, gate pass rate, session duration
- Cost Analysis section in reports when JSONL data available

#### Audit Findings Fixes
- HARD-GATEs added to verification-before-completion, finishing-a-development-branch, composing-teams
- Wave compliance step renumbered from 3.5 to proper step 4 in agent-team-driven-development
- Deviation #3 closed — all 11 Beta deviations now resolved
- README skill count corrected to 22

---

## v0.3.1 (2026-03-14)

### Audit Analysis + Fixes

- **`forge:analyze-audit` skill** — reads deviation logs and git history to produce analysis reports with prioritized improvement recommendations
- **README agent roster** — updated from 5 to 10 agents
- **TDD enforcement** — mandatory where testable work exists, `Tests: N/A` for documentation-only tasks, solo TDD fallback when no QA agent
- **Setting-up-project** — merged risk + team into single Step 1 with justification and HARD-GATE user confirmation
- **Plan task table format** — `Depends On` + `Verify` columns replace undefined `complexity` column
- **Deviation worklog** — 10 of 11 deviations marked fixed

---

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
