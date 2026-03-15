# Forge v0.4.0 Design Document

**Version:** Draft 1
**Date:** 2026-03-15
**Status:** Awaiting review
**Scope:** v0.4.0 — Audit Infrastructure + Fixes
**Parent design:** [design-v3.md](../../forge-beta/design/design-v3.md)

---

## 1. Summary

v0.4.0 builds the audit JSONL infrastructure using TDD — the first time Forge exercises test-driven development on real code. It also fixes audit findings, adds audit opt-in to brainstorming, and upgrades the analyze-audit skill to read JSONL.

This is the foundation for v0.4.1 (first reference project run) and v0.4.2 (remaining reference projects).

### Version Sequence

| Version | Focus |
|---------|-------|
| **v0.4.0** | Audit JSONL infrastructure (TDD), audit findings fixes, brainstorming opt-in, analyze-audit upgrade |
| v0.4.1 | Run 1st reference project end-to-end, collect deviations |
| v0.4.2 | Run remaining 2 reference projects with fixed machinery |
| v0.5.0 | Controlled auto mode + Beta hardening |

### Exit Criteria

- Audit JSONL events recorded for major workflow transitions (session start, routing, skill enter/exit, gate checks, task completion)
- Token and duration tracking captured in events
- Tests exist for JSONL event structure and hook behavior (written TDD-first)
- Brainstorming skill asks about audit mode (default: no)
- `forge:analyze-audit` reads JSONL files and produces token/cost analysis
- High-priority audit findings fixed (HARD-GATEs added, wave compliance investigated)
- README current

---

## 2. Work Stream 1: Audit JSONL Infrastructure (TDD)

### 2.1 Overview

The first real code in Forge's Beta — shell scripts that emit structured JSONL events from hooks. Built with TDD: tests first, then implementation.

### 2.2 Event Schema

Each event is one JSON line in `.forge/local/audit/<session-id>.jsonl`:

```json
{
  "timestamp": "2026-03-15T10:30:00Z",
  "session_id": "sess_20260315_103000",
  "host": "claude-code",
  "action_type": "skill_enter",
  "skill": "brainstorming",
  "workflow": "start-feature",
  "risk_tier": "standard",
  "outcome": "success",
  "duration_ms": null,
  "tokens_in": null,
  "tokens_out": null,
  "cost_estimate_usd": null,
  "detail": {}
}
```

### 2.3 Event Types

| Event Type | When Emitted | Hook/Source | Key Detail Fields |
|-----------|-------------|-------------|-------------------|
| `session_start` | Session begins | `forge-session-start` | host, project_name |
| `routing_decision` | Intent detected | `forge-routing` (via skill text, not hook) | intent, route_to, risk_tier |
| `skill_enter` | Skill invoked | Hook on skill load | skill_name |
| `skill_exit` | Skill completes | Hook on skill completion | skill_name, duration_ms, tokens_in, tokens_out |
| `gate_check` | Evidence gate evaluated | `forge-gate` | gate_name, result (pass/fail/skip) |
| `task_completion` | Task marked done | `forge-task-completed` | task_id, duration_ms, tokens_in, tokens_out |

**Deferred to v0.4.1+:** approval_request, approval_resolution, agent_dispatch, agent_join (these need real multi-agent execution to test properly — reference projects will exercise them).

### 2.4 Implementation: `bin/forge-audit`

New CLI tool at `bin/forge-audit` that handles event recording:

```bash
# Record an event
bin/forge-audit record \
  --type skill_enter \
  --skill brainstorming \
  --workflow start-feature \
  --risk-tier standard

# List events for current session
bin/forge-audit list

# List events for a specific session
bin/forge-audit list --session <session-id>
```

The tool:
1. Checks if audit is enabled (`forge-state get audit.enabled`)
2. If not enabled, exits silently (no event recorded)
3. Generates session_id from timestamp if not set
4. Appends one JSON line to `.forge/local/audit/<session-id>.jsonl`
5. Reads tokens/duration from environment or arguments when available

### 2.5 Hook Integration

| Hook | Current Behavior | Added Behavior |
|------|-----------------|----------------|
| `forge-session-start` | Init state, cleanup | + `forge-audit record --type session_start` |
| `forge-task-completed` | Update state | + `forge-audit record --type task_completion --tokens-in $TOKENS_IN --tokens-out $TOKENS_OUT` |
| `forge-gate` (pre-commit-gate) | Check evidence | + `forge-audit record --type gate_check --detail "$GATE_RESULT"` |

Skill-level events (skill_enter, skill_exit, routing_decision) are emitted by skill text instructions, not hooks — the LLM calls `forge-audit record` when entering/exiting a skill.

### 2.6 TDD Approach

**Tests written first:**

```
tests/forge-audit/
  test-record-event.sh      — forge-audit record creates valid JSONL line
  test-audit-disabled.sh     — no events when audit.enabled is false
  test-session-id.sh         — session_id is consistent within a session
  test-event-schema.sh       — each event type has required fields
  test-list-events.sh        — forge-audit list returns recorded events
```

Each test:
1. Sets up a temp project dir with `.forge/local/audit/`
2. Runs `forge-audit record` with specific arguments
3. Asserts the JSONL output has the expected structure
4. Cleans up

**RED phase:** Write tests, verify they fail (forge-audit doesn't exist yet).
**GREEN phase:** Implement `bin/forge-audit` to make tests pass.
**REFACTOR:** Clean up implementation.

### 2.7 Audit Enablement

Controlled by `.forge/project.yaml`:

```yaml
audit:
  enabled: true   # default: false
  retention: 30   # days, 0 = forever
```

When `audit.enabled` is false (or missing), `forge-audit record` exits silently. No overhead.

---

## 3. Work Stream 2: Brainstorming Audit Opt-In

### 3.1 Change

Add to `skills/brainstorming/SKILL.md` in the checklist, after "Explore project context":

```markdown
**Audit opt-in:** Ask the user once:
> "Would you like to enable audit mode for this project? Audit records
> workflow events (skill usage, gate checks, token counts) to
> `.forge/local/audit/` for later analysis. Default: no"

If yes: `forge-state set audit.enabled true`
If no (or skipped): do nothing (audit stays disabled)
```

### 3.2 Placement

This goes in Step 1 (Explore project context) as a sub-step, after the initial context exploration but before challenging assumptions. It's a one-time question — once set, subsequent brainstorming sessions for the same project don't re-ask.

Check first: `forge-state get audit.enabled` — if already set (true or false), skip the question.

---

## 4. Work Stream 3: Audit Findings Fixes

### 4.1 High Priority: Add HARD-GATEs Proactively

The audit found that 36% of deviations were caused by missing enforcement. Scan all skills for "should" or "must" instructions that lack HARD-GATEs and add gates where skipping would cause real damage.

**Candidate skills to audit:**
- `forge:verification-before-completion` — does it enforce evidence before completion claims?
- `forge:finishing-a-development-branch` — does it enforce verification before merge?
- `forge:writing-plans` — does it enforce design approval before writing?
- `forge:composing-teams` — does it enforce user approval of roster?

Don't add gates everywhere — only where skipping causes real damage (the forge-author quality principle).

### 4.2 Medium Priority: Wave Compliance Investigation

`forge:validating-wave-compliance` was never invoked during elevated-tier team execution. Investigate:
1. Is the skill referenced correctly in `agent-team-driven-development`?
2. Is the invocation conditional on risk tier as documented?
3. Is the instruction clear enough that the lead would actually invoke it?

Fix whatever is blocking invocation.

### 4.3 Medium Priority: README Update

- Skill count: currently says 21 in some places, actually 22 (added analyze-audit)
- Verify agent count still says 10
- Check that any other content drift from v0.3.0/v0.3.1 changes is corrected

### 4.4 Low Priority: Close Deviation #3

Deviation #3 (worktree for dogfooding) is cosmetic and was already addressed by execution ergonomics in v0.3.0 (worktrees optional for minimal/standard tier). Mark as closed — the behavior is now correct per the updated skill.

---

## 5. Work Stream 4: Upgrade analyze-audit

### 5.1 JSONL Input

Update `forge:analyze-audit` skill to read JSONL files when they exist:

```markdown
### Available Sources

Check for sources in this order:
1. `.forge/local/audit/*.jsonl` — if exists, read structured events
2. Deviation worklog in design docs — always read if present
3. Git history — always available
```

### 5.2 New Analysis Dimensions

Add when JSONL data is available:

| Dimension | What to Measure | Source |
|-----------|----------------|--------|
| **Token cost per skill** | Total tokens consumed by each skill | JSONL skill_enter/skill_exit events |
| **Token cost per workflow** | Total tokens for start-feature vs fix-bug etc | JSONL events grouped by workflow field |
| **Gate pass rate** | % of gates passed on first attempt | JSONL gate_check events |
| **Session duration** | Wall clock time per session | JSONL session_start to last event |

### 5.3 Report Additions

Add a "Cost Analysis" section to the report when JSONL data is available:

```markdown
## Cost Analysis (from audit JSONL)

| Skill | Invocations | Avg Tokens In | Avg Tokens Out | Avg Duration |
|-------|-------------|---------------|----------------|-------------|
| brainstorming | 3 | 15,000 | 8,000 | 45s |
| writing-plans | 3 | 12,000 | 6,000 | 30s |
| ... | ... | ... | ... | ... |

**Total session cost:** ~$X.XX (estimated)
**Most expensive skill:** brainstorming (45% of total tokens)
```

---

## 6. Testing Strategy

### TDD for audit infrastructure (Work Stream 1)

This is the first TDD exercise in the Beta. The test suite at `tests/forge-audit/` will:
1. Be written BEFORE `bin/forge-audit` exists
2. Verify all tests fail (RED)
3. Implementation makes them pass (GREEN)
4. Refactor if needed

Test categories:
- **Unit:** Does `forge-audit record` produce valid JSONL?
- **Integration:** Do hooks emit events when audit is enabled?
- **Negative:** No events when audit is disabled?

### Other work streams

- Work Stream 2 (brainstorming opt-in): grep verification — audit question present in skill
- Work Stream 3 (audit fixes): skill text review + grep for HARD-GATEs
- Work Stream 4 (analyze-audit upgrade): grep for JSONL reading logic in skill

---

## 7. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Token/duration data not available from host | High | Medium | Make these fields optional (null when unavailable); don't block on them |
| Audit overhead slows execution | Low | Low | Audit is opt-in; forge-audit exits silently when disabled; JSONL append is cheap |
| Skill-level events (enter/exit) unreliable via LLM instruction | Medium | Medium | Start with hook-level events only; add skill-level events when proven reliable |
| TDD on shell scripts is unfamiliar territory | Medium | Low | Follow existing test patterns in tests/forge-state/; simple assert-based scripts |
| HARD-GATE additions break existing workflows | Low | High | Only add gates where skipping causes damage; test after adding |

---

## 8. Deviation Worklog

Deviations from v0.4.0 development will be appended here.

| # | Version | Skill | Expected | Actual | Severity | Root Cause | Fix Target | Status |
|---|---------|-------|----------|--------|----------|------------|------------|--------|
| 12 | v0.4.0-dev | `agent-team-driven-development` | Agents shut down cleanly when work is complete | Wave 0 agents (qa-engineer, forge-author) entered idle loop after being replaced by Wave 1/2 instances. Plain text broadcast "shut down" didn't terminate them. Structured shutdown_request sent later but agents were stuck cycling idle/ready. TeamDelete blocked by 2 unkillable agents. | friction | Two issues: (1) plain text broadcasts don't terminate agents — only structured shutdown_request does. (2) When an agent with the same role name is respawned for a later wave, the original instance stays alive and can't be addressed cleanly. | v0.4.1 | fixed (v0.4.1 — wave-suffixed names, structured shutdown only, immediate after wave) |
| 13 | v0.4.1-dev | `agent-team-driven-development` | TaskUpdate with status=completed persists across sessions | TaskUpdate completed returns success but tasks remain in_progress in subsequent sessions. Orphaned team tasks from deleted teams can't be marked completed — only deleted. Zombie tasks accumulate across versions. | friction | Tasks tied to old team contexts don't honor completed status. The delete status works but completed doesn't stick. Need: brainstorming checks for stale tasks at session start and offers cleanup. Also finishing-a-development-branch should check for and clean stale tasks as part of closeout. | v0.4.1 | fixed (v0.4.1 — stale task check in brainstorming + closeout cleanup in finishing) |
| 14 | v0.4.1-dev | multiple skills | Skill outputs use consistent, readable formatting (tables, structured sections) | Several skills produce wall-of-text output where tables would be clearer: setting-up-project assessment, readiness summary, status reports. Format quality varies across skills. | cosmetic | No output formatting guidance in skills — each invocation improvises. Need a formatting audit across all skill outputs and standardized guidance. | v0.5.0 | open |
| 15 | v0.4.1-dev | `agent-team-driven-development` | Multi-agent work progress always visible during execution | Task list only visible via Ctrl+T toggle (ephemeral). Users lose visibility after next output. | cosmetic | Lead should print formatted task list: (1) after each major action (task completion, agent spawn, between waves), and (2) on a timer — if no output for 30 seconds, print current task status. Skill convention, not platform feature. | v0.5.0 | open |
