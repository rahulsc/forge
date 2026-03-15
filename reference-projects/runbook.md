# Reference Project Runbook

How to run Forge reference projects reproducibly and measure results.

## Purpose

Reference projects validate that Forge workflows work on real code. Each project is run from scratch using Forge's full lifecycle (brainstorm → plan → TDD → implement → verify → review → finish). Results are compared across Forge versions to detect improvements and regressions.

## Directory Structure

```
reference-projects/
  .gitignore                          ← ignores generated code, tracks specs/results
  runbook.md                          ← this file
  <project-name>/
    spec.yaml                         ← fixed inputs (ideation, expectations)
    .forge/project.yaml               ← minimal config (enables state isolation)
    measure.sh                        ← collects metrics after execution
    runs/
      <date>-v<forge-version>.md      ← timestamped results
```

Projects run IN-REPO as subfolders. Each has its own `.forge/project.yaml` so Forge state resolves locally (not to the repo root). Generated code, node_modules, etc. are gitignored — only specs, measurement scripts, and run results are tracked.

## How State Isolation Works

Forge's session hook walks up from `pwd` looking for `.forge/project.yaml`. The nearest one wins:
- At repo root → Forge's own `.forge/project.yaml` (development mode)
- In `reference-projects/task-tracker-api/` → that project's `.forge/project.yaml`

This means you can develop Forge at the repo root AND run reference projects in subfolders without state collision. See `docs/forge-beta/design/mono-repo-notes.md` for v1.0 implications.

## Execution Protocol

### 1. Create Worktree (isolates git history)

```bash
cd /path/to/forge
git worktree add .worktrees/ref-run-<date> -b ref/run-<date>
cd .worktrees/ref-run-<date>
```

### 2. Start Session

Navigate to the reference project subfolder and start Claude Code:
```bash
cd reference-projects/<project-name>
claude
```

Forge's plugin loads from the repo root. State resolves to the subfolder's `.forge/`.

### 3. Build

Tell Claude to read the spec and build:
```
Read spec.yaml and use the ideation text to start building this project.
```

Let brainstorming determine the MVP scope. Do NOT guide or constrain — let Forge work autonomously. Record any deviations where Forge doesn't behave as expected.

### 4. Execute

Follow the Forge workflow through:
- Plan → TDD → Implement → Verify → Review → Finish

Observe and note:
- Which skills were invoked
- Which agents were dispatched
- Whether TDD was followed (RED → GREEN)
- Any approval friction or unexpected behavior
- Output formatting quality (deviation #14 — log for v0.5.0)

### 5. Measure

After completion, run the measurement script from the project dir:
```bash
bash measure.sh <forge-version>
```

Fill in the manual assessment items in the output.

### 6. Store

Save the measurement output to:
```
runs/<date>-v<forge-version>.md
```

Commit the results file (it's tracked by .gitignore rules).

### 7. Compare

If a baseline exists, compare current metrics against it:
- Did tests pass? (same or better)
- Deviation count (fewer = better)
- Skills invoked (expected coverage maintained?)
- Duration (trending?)
- Token cost (when available — trending?)

### 8. Cleanup

After storing results, the worktree can be deleted:
```bash
cd /path/to/forge
git worktree remove .worktrees/ref-run-<date>
git branch -d ref/run-<date>
```

Generated code is gitignored and stays in the worktree until removal. Only the results file needs to be cherry-picked or committed to main.

## Running Multiple Projects

You can run multiple projects in the same worktree session. Each has its own `.forge/` state:
```bash
cd reference-projects/task-tracker-api && claude   # run project 1
cd ../dashboard-ui && claude                       # run project 2
```

State isolation is per-subfolder — no collision between projects.

## Metric Tiers

| Tier | Metrics | Available When |
|------|---------|---------------|
| **Now** | compiles, tests_pass, test_count, deviation_count, duration_minutes, skills_invoked | Manual observation during run |
| **With audit** | tdd_compliance, gate_pass_rate | v0.4.0+ with audit enabled |
| **Future** | total_tokens, token_cost_usd, agents_dispatched | When audit captures host token data |
| **After 2+ runs** | Regression trends, baseline comparison | After baseline established |

## Formatting Audit (v0.5.0)

During each reference project run, note any skill outputs that could benefit from better formatting. Log these observations for the v0.5.0 formatting audit (deviation #14). Examples:
- Assessment output as wall-of-text instead of tables
- Status summaries without structure
- Unclear prompts or confusing output

## What NOT to Do

- Don't pre-design the project — let brainstorming do it
- Don't override agent selection — let composing-teams decide
- Don't skip steps to speed things up — the point is testing the full workflow
- Don't fix Forge bugs during the run — log them as deviations
- Don't compare code quality across runs — it's non-deterministic; compare process metrics instead
