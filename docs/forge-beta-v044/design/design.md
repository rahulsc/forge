# Forge v0.4.4 Design Document

**Version:** Draft 1
**Date:** 2026-03-16
**Status:** Awaiting review
**Scope:** v0.4.4 — Dashboard UI + CLI Migration Tool reference project runs

---

## 1. Summary

v0.4.4 runs the remaining 2 reference projects from the v0.4.0 core suite. Wave 0 prepares all infrastructure (approvals, validation, measurement scripts). Waves 1-2 run each project through the full Forge workflow. Lessons from v0.4.3 (3 attempts) are applied upfront.

## 2. Lessons Applied from v0.4.3

| Lesson | Applied How |
|--------|------------|
| Explicit `--project-dir` on all audit calls | All agent prompts include AUDIT_DIR and FORGE_BIN constants |
| Pre-approved permissions in agent prompts | Per-agent scoped permissions block in every prompt |
| validation.md + validate.sh before run | Created in Wave 0 |
| approvals.yaml with per-agent scoping | Created in Wave 0 with agent-level permission breakdown |
| Full workflow: build → verify → review → fix → validate → finish → analyze | Planned as explicit steps, not afterthoughts |
| measure.sh path fix | Updated in Wave 0 |
| Code review → fix → re-verify loop | Built into the workflow |

## 3. Wave 0: Prep (before any builds)

### 3.1 Fix measure.sh for both projects

Update `reference-projects/dashboard-ui/measure.sh` and `reference-projects/cli-migration-tool/measure.sh` to use script-relative path resolution (same fix as task-tracker-api).

### 3.2 Per-agent scoped approvals

Each project gets an `approvals.yaml` with permissions broken down by agent role:

**Dashboard UI agents:**

| Agent | Files | Shell | Notes |
|-------|-------|-------|-------|
| scaffolder | create: package.json, src/**, public/**, tests/setup.js | npm install | One-time setup |
| frontend-engineer | create/edit: src/**/*.{js,jsx,css}, tests/**/*.test.js | npm test | Component work |
| code-reviewer | read: src/**, tests/** | npm test | Review only |

**CLI Migration Tool agents:**

| Agent | Files | Shell | Notes |
|-------|-------|-------|-------|
| scaffolder | create: package.json, src/**, tests/setup.js, bin/* | npm install, chmod +x | One-time setup |
| implementer | create/edit: src/**/*.js, tests/**/*.test.js, migrations/**/*.sql | npm test, node, sqlite3 | Implementation |
| code-reviewer | read: src/**, tests/** | npm test | Review only |

Common to all agents: `bin/forge-audit record --project-dir <path>`, `git add`, `git commit` (in worktree only)

### 3.3 Validation checklists

**Dashboard UI validation.md:**
1. `npm test` passes
2. `npm start` launches dev server
3. Sidebar renders with navigation items
4. Card grid renders with mock data
5. Dark mode toggle works and persists to localStorage
6. Responsive layout works at mobile width

**CLI Migration Tool validation.md:**
1. `npm test` passes
2. `node bin/migrate up` applies migrations
3. `node bin/migrate status` shows applied migrations
4. `node bin/migrate down` rolls back last migration
5. `node bin/migrate seed` populates test data from fixture
6. Running `down` twice doesn't crash (no-op)
7. Database is consistent after failed migration rollback

### 3.4 Validate.sh scripts

Automated versions of the validation checklists, similar to task-tracker-api's.

## 4. Wave 1: Dashboard UI

**Inspired by:** Grafana / Datadog dashboard view
**Stack:** React (manual setup), CSS modules, localStorage for dark mode, Jest + React Testing Library
**Risk tiers:** minimal (UI layout), standard (state management)

**Tasks:**
1. Scaffolding — React app setup, test infrastructure
2. Sidebar component — navigation with route items (TDD)
3. Card grid component — responsive grid with mock metric cards (TDD)
4. Dark mode — toggle + localStorage persistence (TDD)
5. Layout integration — compose sidebar + grid + header (TDD)
6. Verification → Code review → Fix → Re-verify → Validate → Finish → Analyze

**Bug to introduce and fix:** Dark mode toggle doesn't persist after page refresh (the bug is omitting the localStorage read on mount).

## 5. Wave 2: CLI Migration Tool

**Inspired by:** Flyway / golang-migrate
**Stack:** Node.js, better-sqlite3, Commander.js (CLI framework), Jest
**Risk tiers:** elevated (migrations), critical (data integrity on rollback)

**Tasks:**
1. Scaffolding — CLI setup with Commander.js, test infrastructure
2. Migration discovery — find .sql files by naming convention (TDD)
3. Up command — apply pending migrations in order, track in version table (TDD)
4. Down command — rollback last applied migration (TDD)
5. Status command — show applied/pending migrations (TDD)
6. Seed command — populate test data from YAML fixture (TDD)
7. Verification → Code review → Fix → Re-verify → Validate → Finish → Analyze

**Bug to introduce and fix:** Running `down` twice crashes instead of being a no-op.

## 6. Exit Criteria

- Both projects: all tests pass, all validation checks pass
- Both projects: full audit trail with explicit --project-dir
- Both projects: code review completed with fix loop
- Both projects: verification-before-completion invoked
- Both projects: finishing-a-development-branch invoked with validation gate
- Both projects: analyze-audit run with results
- All results cherry-picked to main
- Version bumped to 0.4.4
