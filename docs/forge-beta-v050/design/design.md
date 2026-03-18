# Forge v0.5.0 Design Document — Beta Completion

**Version:** Draft 1
**Date:** 2026-03-17
**Status:** Awaiting review
**Scope:** v0.5.0 — Documentation, adoption fixes, deviation closure, platform verification
**Parent design:** [design-v3.md](../../forge-beta/design/design-v3.md)

---

## 1. Summary

v0.5.0 closes the Beta. All 3 reference project baselines pass. The system works. What remains is: documenting how to use it, fixing known adoption gaps, mitigating the agent idle loop, verifying non-Claude-Code platforms, and processing every deviation entry.

This is not a feature release — it's a polish and documentation release that makes Forge ready for v1.0 development.

### Exit Criteria

- [ ] Usage guide exists (practical, 500-800 lines)
- [ ] README reviewed and updated for accuracy
- [ ] Formatting audit complete — all skill outputs use consistent tables/icons
- [ ] Adoption fixes #22-25 implemented (prior orchestration, design docs, .gitignore, cleanup)
- [ ] Convention auto-detection #26 implemented
- [ ] Agent idle loop #16 mitigated (timed nudge + user escalation)
- [ ] Platform smoke tests pass on Cursor, Codex, OpenCode, Gemini CLI
- [ ] All 26 deviation entries have final status (fixed, deferred with rationale, or closed)
- [ ] Final Beta audit analysis run
- [ ] Version 0.5.0 in all manifests

### Deferred to v1.0

- 3 remaining reference projects (Deploy Pipeline, Auth Service, Full-Stack Notes App)
- Runtime isolation (#21)
- Controlled auto mode at full scale
- Comprehensive operations manual (upgrade usage guide from B to A)
- Budget caps, community audit submission, regression CI, pack registry
- Per-model cost optimization

---

## 2. Work Stream 1: Documentation Overhaul

### 2.1 Usage Guide

Create `docs/usage-guide.md` — a practical guide (500-800 lines) covering:

**Section 1: Day-to-Day Workflows**
- How each of the 8 workflows actually works in practice
- What the user says, what happens, what to expect
- When to use each workflow (decision tree)

**Section 2: Working with Agents**
- How agents are dispatched and managed
- Understanding the task list (Ctrl+T)
- What to do when agents get stuck
- Permission approval flow

**Section 3: Risk-Scaled Ceremony**
- What each tier means in practice
- How to change risk tiers for specific paths
- When ceremony feels too heavy — how to adjust

**Section 4: Audit and Analysis**
- Enabling audit mode
- Reading audit JSONL
- Running `forge:analyze-audit`
- Understanding the analysis report

**Section 5: State and Configuration**
- `.forge/` directory structure explained
- `forge-state` commands for inspection
- `forge-evidence` for tracking verification
- Policy files and risk classification

**Section 6: Extending Forge**
- Writing new skills (overview, link to forge:writing-skills)
- Adding agents (pattern, conventions)
- Creating packs (overview, link to forge:forge-packs)

**Section 7: Troubleshooting**
- Common issues and fixes
- `forge:diagnosing-forge` for health checks
- Platform-specific notes

### 2.2 README Review

Audit the current README for:
- Accuracy (skill count, agent count, workflow descriptions)
- Completeness (does it reference the usage guide?)
- Freshness (any v0.4.x changes that need reflecting?)
- Link to usage guide from README

### 2.3 Formatting Audit (Deviation #14)

Review ALL skill outputs for formatting consistency. Standardize on:

| Element | Format |
|---------|--------|
| Risk assessment | Table: Dimension / Value / Justification |
| Team criteria | Table: Criterion / Threshold / Value / Met? |
| Status reporting | Wave-grouped with icons (✅ 🔄 ⏭️ ⏳ ◻️) |
| Readiness summary | Table: Item / Value |
| Adoption Step 2 | Tables with risk tier legend (already fixed in v0.4.4) |
| Code review results | Table: # / Severity / Area / Description |
| Validation results | Table: # / Check / Result |
| Audit analysis | Tables per dimension |

Create a formatting reference section in the usage guide that documents these conventions.

---

## 3. Work Stream 2: Adoption Fixes (#22-26)

### 3.1 Prior Orchestration Detection (#22)

Update `skills/adopting-forge/SKILL.md` Step 1 to scan for:
- `.superpowers/` — Superpowers state directory
- `.aider/` — Aider configuration
- `.copilot-workspace/` — GitHub Copilot workspace
- `.continue/` — Continue.dev configuration
- `.cursor/` — Cursor rules (already detected, but note as AI surface)

When found: report with action recommendation (migrate, preserve, remove).

### 3.2 Design Doc Discovery (#23)

Update `skills/adopting-forge/SKILL.md` Step 1 to scan for:
- `docs/plans/` or `docs/*/design/` — existing design documents
- `docs/*/plans/` — existing implementation plans
- `ARCHITECTURE.md`, `DESIGN.md`, `SPEC.md` — common doc patterns

When found: report count and offer to register with forge-state.

### 3.3 Root .gitignore Migration (#24)

Update `skills/adopting-forge/SKILL.md` Step 5 to:
- Check root `.gitignore` for stale orchestration entries (`.superpowers/`, etc.)
- Add `.forge/local/` if not present
- Preview changes before modifying

### 3.4 Stale State Cleanup (#25)

Update `skills/adopting-forge/SKILL.md` to offer cleanup:
> "Found `.superpowers/` (prior orchestration state, currently idle). Remove it? (y/n)"

Only for directories that are confirmed inactive (no running processes).

### 3.5 Convention Auto-Detection (#26)

Update `skills/brainstorming/SKILL.md` and `skills/adopting-forge/SKILL.md` to detect and record:

| Convention | Detection Method | Recorded As |
|-----------|-----------------|-------------|
| Test import pattern | Read 3+ existing test files, extract common imports | `.forge/shared/conventions.md` Testing section |
| CSS design tokens | Scan for `:root` or CSS custom property definitions | `.forge/shared/conventions.md` Style section |
| Linter config | Detect `.eslintrc*`, `ruff.toml`, `.golangci.yml` | `.forge/shared/conventions.md` Style section |
| Commit format | Read last 10 git log messages, detect pattern | `.forge/shared/conventions.md` Commit section |
| File naming | Scan src/ for kebab-case vs camelCase vs PascalCase | `.forge/shared/conventions.md` Naming section |

Write detected conventions to `.forge/shared/conventions.md` during adoption or brainstorming. Agents read this before working.

---

## 4. Work Stream 3: Agent Idle Loop Mitigation (#16)

Update `skills/agent-team-driven-development/SKILL.md` with timed monitoring:

**Report timeout (60 seconds):**
After dispatching an agent, if no response within 60 seconds:
1. Send nudge message to agent: "Status check — have you completed the task?"
2. Wait 30 more seconds
3. If still no response, alert user: "Agent `<name>` appears stuck. Check its pane and press Esc if cycling idle."

**Shutdown timeout (30 seconds):**
After sending structured shutdown_request, if no confirmation within 30 seconds:
1. Alert user: "Agent `<name>` hasn't confirmed shutdown. Check its pane."
2. Proceed with next wave regardless (don't block on stuck agents)

Add these as numbered steps in the Wave Cleanup Routine.

---

## 5. Work Stream 4: Platform Smoke Tests

Quick verification on each non-Claude-Code platform:

| Platform | Test | Pass Criteria |
|----------|------|---------------|
| Cursor | Install plugin, start session, say "start a feature" | forge-routing triggers, brainstorming skill loads |
| Codex | Install per `.codex/INSTALL.md`, run basic command | Skills load, state init works |
| OpenCode | Install per `.opencode/INSTALL.md`, run basic command | Skills load |
| Gemini CLI | Install extension, verify context loads | GEMINI.md context visible |

Document results and known limitations per platform.

---

## 6. Work Stream 5: Deviation Worklog Closure

Process every entry (#1-26) to final status:

| Status | Meaning |
|--------|---------|
| fixed (vN) | Implemented and verified in version N |
| closed | Addressed by design change or no longer applicable |
| deferred (v1.0) | Explicitly deferred with documented rationale |
| mitigated (vN) | Can't fully fix but has workaround in version N |

Every entry must have one of these statuses. No "open" entries remain after v0.5.0.

---

## 7. Work Stream 6: Final Beta Audit

Run `forge:analyze-audit` on the complete Beta development history (v0.2.0 through v0.5.0):
- All deviation patterns
- Skill coverage (which of 22 skills were invoked?)
- Agent utilization (which of 10 agents were dispatched?)
- Reference project comparison (3 baselines)
- Recommendations for v1.0

Store results in `docs/forge-beta/audits/analysis-final.md`.

---

## 8. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Convention auto-detection (#26) too complex | Medium | Medium | Start with simple pattern detection; defer sophisticated inference |
| Platform smoke tests reveal incompatibilities | Medium | Medium | Document as known limitations, not blockers |
| Usage guide takes too long | Low | Medium | Scope to 500-800 lines; defer comprehensive manual to v1.0 |
| Formatting audit scope creep | Medium | Low | Fix top 5 worst offenders; document standard for future |
| Agent idle loop can't be fully mitigated | High | Low | Timed messages are best-effort; document the Esc workaround |
