# Forge v0.4.1 Design Document

**Version:** Draft 1
**Date:** 2026-03-15
**Status:** Awaiting review
**Scope:** v0.4.1 — Agent shutdown fix + reference project infrastructure + first reference project run
**Parent design:** [design-v3.md](../../forge-beta/design/design-v3.md)

---

## 1. Summary

v0.4.1 fixes the agent idle loop (deviation #12), enhances audit UX, creates the reference project infrastructure, and executes the first reference project (Task Tracker API) end-to-end using Forge.

This is the first time Forge runs a complete workflow on real code — exercising TDD, verification, code review, and finishing skills that have never been invoked.

### Deliverables

1. **Agent shutdown fix** — update `agent-team-driven-development` skill to prevent idle loops
2. **Audit UX enhancements** — better description in brainstorming, end-of-workflow analysis prompt
3. **Reference project infrastructure** — `reference-projects/` directory with spec files, scaffold scripts, measurement scripts, runbook
4. **Task Tracker API run** — first reference project executed end-to-end
5. **Version bump** — 0.4.1

---

## 2. Part 1: Forge Fixes

### 2.1 Agent Shutdown Fix (Deviation #12)

**Problem:** Wave 0 agents entered idle/ready loop after being replaced by later wave instances. Plain text broadcasts don't terminate agents. Structured shutdown requests arrived too late.

**Root causes:**
1. Plain text "shut down" broadcasts don't trigger agent termination
2. Agent names reused across waves (forge-author → forge-author in Wave 1 = name collision)
3. Shutdown sent at end of version instead of after each wave

**Fix in `agent-team-driven-development` SKILL.md:**

Add to Wave Cleanup Routine:
```
6. Send structured shutdown_request (NOT plain text) to each agent that is
   not needed for subsequent waves. Use SendMessage with
   {"type": "shutdown_request"} — never plain text.
7. Wait for shutdown_approved response. If no response within 30 seconds,
   log the issue and proceed.
```

Add to "Red Flags — never" section:
```
- Use plain text messages to request shutdown (only structured shutdown_request works)
- Reuse agent names across waves (use unique names: forge-author-w0, forge-author-w1)
- Batch all shutdowns at the end — shut down agents immediately after their wave completes
```

Add naming convention:
```
Agent names must be unique across the entire execution. Use wave-suffixed names:
  Wave 0: qa-w0, forge-author-w0
  Wave 1: shell-eng-w1, forge-author-w1
  Wave 2: shell-eng-w2, forge-author-w2

Never reuse a name from an earlier wave, even for the same role.
```

### 2.2 Audit Description Enhancement

**In `brainstorming` SKILL.md**, update the audit opt-in question to include more context:

```markdown
**Audit opt-in (ask once per project):**

Check first: `forge-state get audit.enabled` — if already set, skip.

If not set, ask:
> "Would you like to enable audit mode for this project?
>
> **What it does:** Records workflow events (which skills ran, gate check
> results, token counts, durations) as JSONL in `.forge/local/audit/`.
> This data stays local — it's never sent anywhere.
>
> **What it's used for:** Run `forge:analyze-audit` after your project to
> see which skills were invoked, how much each cost in tokens, where
> deviations occurred, and what could improve. Helps Forge get better
> over time.
>
> Default: no"

If yes: `forge-state set audit.enabled true`
If no: do nothing.
```

### 2.3 End-of-Workflow Audit Prompt

**In `finishing-a-development-branch` SKILL.md**, add at the end (after merge/PR decision):

```markdown
## Audit Summary (if enabled)

Check: `forge-state get audit.enabled`

If audit was enabled for this project, display:

> "Audit data was recorded for this project at `.forge/local/audit/`.
>
> To analyze your workflow data, run: `forge:analyze-audit`
>
> This will produce a report showing skill coverage, token costs,
> deviation patterns, and improvement recommendations."
```

---

## 3. Part 2: Reference Project Infrastructure

### 3.1 Directory Structure

```
reference-projects/
  runbook.md                         — execution protocol
  task-tracker-api/
    spec.yaml                        — fixed inputs
    scaffold.sh                      — creates clean project directory
    measure.sh                       — collects metrics after execution
    runs/                            — timestamped result files
  dashboard-ui/
    spec.yaml
    scaffold.sh
    measure.sh
    runs/
  cli-migration-tool/
    spec.yaml
    scaffold.sh
    measure.sh
    runs/
  deploy-pipeline/
    spec.yaml
    scaffold.sh
    measure.sh
    runs/
  auth-service/
    spec.yaml
    scaffold.sh
    measure.sh
    runs/
  full-stack-notes-app/
    spec.yaml
    scaffold.sh
    measure.sh
    runs/
```

### 3.2 Spec File Format (spec.yaml)

```yaml
name: task-tracker-api
inspired_by: Linear / Asana
version_introduced: v0.4.1

ideation: |
  Build the MVP backend for a project management tool. Teams need to
  create workspaces, track tasks with priorities and assignees, and
  authenticate via tokens. The API should be clean enough that a
  frontend team could build against it. Focus on the core task
  lifecycle — no integrations, no real-time updates, no notifications.

starting_state: empty_directory
project_directory: ~/Projects/forge-ref-projects/task-tracker-api

expectations:
  risk_tiers: [standard, elevated]
  workflows: [adopt, start-feature, fix-bug]
  agents: [backend-engineer, qa-engineer, security-reviewer]

metrics:
  # Measurable now
  compiles: null          # true/false after run
  tests_pass: null        # true/false after run
  test_count: null        # number of tests
  deviation_count: null   # deviations logged during run
  tdd_compliance: null    # RED/GREEN evidence present?
  skills_invoked: []      # which skills fired
  duration_minutes: null  # wall clock

  # Measurable when audit JSONL works
  total_tokens: null
  token_cost_usd: null
  gate_pass_rate: null
  agents_dispatched: []

baseline: null  # set after first successful run
```

### 3.3 Scaffold Script (scaffold.sh)

```bash
#!/usr/bin/env bash
set -euo pipefail

# Read spec
SPEC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$HOME/Projects/forge-ref-projects/task-tracker-api"

# Clean start
rm -rf "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Initialize git
git init
echo "node_modules/" > .gitignore
git add .gitignore
git commit -m "initial commit"

# Print instructions
echo "Reference project scaffolded at: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_DIR"
echo "  2. Start a new Claude Code session"
echo "  3. Say: 'Set up Forge in this project' (runs forge:adopting-forge)"
echo "  4. When asked about audit, say 'yes'"
echo "  5. Then paste the ideation text from spec.yaml"
```

### 3.4 Measurement Script (measure.sh)

```bash
#!/usr/bin/env bash
set -euo pipefail

SPEC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$HOME/Projects/forge-ref-projects/task-tracker-api"
RUN_DATE=$(date +%Y-%m-%d)
FORGE_VERSION=$(cat "$SPEC_DIR/../../.claude-plugin/plugin.json" | grep version | head -1 | sed 's/.*: "//;s/".*//')

echo "# Reference Project Run: task-tracker-api"
echo "**Date:** $RUN_DATE"
echo "**Forge version:** $FORGE_VERSION"
echo ""

# Check if project exists
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Project directory not found: $PROJECT_DIR"
  exit 1
fi

cd "$PROJECT_DIR"

# Compiles/runs
echo "## Build"
if [ -f package.json ]; then
  npm test 2>&1 && echo "**Tests:** PASS" || echo "**Tests:** FAIL"
elif [ -f requirements.txt ] || [ -f pyproject.toml ]; then
  pytest 2>&1 && echo "**Tests:** PASS" || echo "**Tests:** FAIL"
fi

# Git stats
echo ""
echo "## Git Stats"
echo "- Commits: $(git rev-list --count HEAD)"
echo "- Files: $(git ls-files | wc -l)"

# Audit data (if available)
if [ -d .forge/local/audit ]; then
  echo ""
  echo "## Audit Data"
  JSONL_FILES=$(ls .forge/local/audit/*.jsonl 2>/dev/null | wc -l)
  echo "- Audit files: $JSONL_FILES"
  if [ "$JSONL_FILES" -gt 0 ]; then
    echo "- Total events: $(cat .forge/local/audit/*.jsonl | wc -l)"
  fi
fi

echo ""
echo "## Manual Assessment (fill in after run)"
echo "- [ ] TDD compliance: RED/GREEN evidence in commits?"
echo "- [ ] Deviations logged: (count)"
echo "- [ ] Skills invoked: (list)"
echo "- [ ] Agents dispatched: (list)"
echo "- [ ] Duration: (minutes)"
```

### 3.5 Runbook (runbook.md)

The runbook documents the complete execution protocol:

1. **Prep:** Run `scaffold.sh` to create clean project directory
2. **Adopt:** Open new Claude Code session in project dir, run `forge adopt`, enable audit
3. **Build:** Paste ideation text from spec.yaml, let brainstorming determine MVP scope
4. **Execute:** Follow Forge workflow through plan → TDD → implement → verify → review → finish
5. **Measure:** Run `measure.sh`, fill in manual assessment
6. **Store:** Save results to `runs/<date>-<forge-version>.md`
7. **Compare:** If baseline exists, compare current metrics against it

### 3.6 Metrics Tiers

| Tier | Metrics | Available When |
|------|---------|---------------|
| **Now** | compiles, tests_pass, test_count, deviation_count, duration_minutes, skills_invoked | Manual observation |
| **With audit** | tdd_compliance (from commit messages) | v0.4.0+ with audit enabled |
| **Future** | total_tokens, token_cost_usd, gate_pass_rate, agents_dispatched | When audit JSONL captures token data from host |
| **After multiple runs** | Regression trends, baseline comparison | After 2+ runs stored |

---

## 4. Part 3: Task Tracker API Execution

### 4.1 What This Tests

First end-to-end Forge workflow on real code. Expected to exercise:

| Skill | First Time? | What It Tests |
|-------|------------|---------------|
| `forge:adopting-forge` | On external project | Adoption flow with LLM warning, stack inference, managed blocks |
| `forge:brainstorming` | With real code scope | MVP scoping from ideation text |
| `forge:test-driven-development` | **Yes — first time** | RED/GREEN/REFACTOR on actual code |
| `forge:verification-before-completion` | **Yes — first time** | Evidence-gated completion |
| `forge:requesting-code-review` | **Yes — first time** | Code review dispatch |
| `forge:finishing-a-development-branch` | **Yes — first time** | Merge/PR decision |

### 4.2 Execution Plan

1. Run `reference-projects/task-tracker-api/scaffold.sh`
2. Open new Claude Code session in the scaffolded directory
3. Run `forge adopt` — test adoption flow
4. Enable audit when asked
5. Paste: the ideation text from spec.yaml
6. Let Forge run: brainstorm → plan → execute → verify → review → finish
7. After completion, run `measure.sh`
8. Store results in `reference-projects/task-tracker-api/runs/`
9. Log any deviations found during the run

### 4.3 Expected Outcomes

- Working REST API with task CRUD + JWT auth
- Tests exist and pass (TDD — written before implementation)
- At least standard + elevated risk tiers exercised
- Audit JSONL recorded (if infrastructure works on external project)
- Deviations logged for any workflow friction

### 4.4 What We're NOT Measuring Yet

- Code quality (subjective — no automated quality score)
- Architecture fitness (brainstorming determines this)
- Token cost (audit JSONL may not capture host-level token data yet)

---

## 5. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Forge skills fail on external project (different from self-development) | Medium | High | The whole point — find what breaks |
| TDD skill never tested, may have bugs | Medium | High | Log deviations, fix in v0.4.2 |
| Audit JSONL doesn't capture useful data on external project | Medium | Low | Manual metrics work regardless |
| Agent shutdown fix doesn't fully solve the idle loop | Medium | Medium | Wave-suffixed names + immediate shutdown should help; log if not |
| Reference project takes much longer than expected | Medium | Low | Accept it — learning what takes long is valuable data |

---

## 6. Deviation Worklog

| # | Version | Skill | Expected | Actual | Severity | Root Cause | Fix Target | Status |
|---|---------|-------|----------|--------|----------|------------|------------|--------|

(Continued from v0.4.0 — deviation #12 being fixed in this version)
