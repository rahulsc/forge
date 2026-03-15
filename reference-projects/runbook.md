# Reference Project Runbook

How to run Forge reference projects reproducibly and measure results.

## Purpose

Reference projects validate that Forge workflows work on real code. Each project is run from scratch using Forge's full lifecycle (brainstorm → plan → TDD → implement → verify → review → finish). Results are compared across Forge versions to detect improvements and regressions.

## Directory Structure

```
reference-projects/
  runbook.md                          ← this file
  <project-name>/
    spec.yaml                         ← fixed inputs (ideation, expectations)
    scaffold.sh                       ← creates clean project directory
    measure.sh                        ← collects metrics after execution
    runs/
      <date>-v<forge-version>.md      ← timestamped results
```

Projects are built in `~/Projects/forge-ref-projects/<name>/` — outside the Forge repo.

## Execution Protocol

### 1. Prep

```bash
cd /path/to/forge
bash reference-projects/<project-name>/scaffold.sh
```

This creates a clean directory with git init and appropriate .gitignore.

### 2. Adopt

Open a NEW Claude Code session in the scaffolded project directory:
```bash
cd ~/Projects/forge-ref-projects/<project-name>
claude
```

Say: "Set up Forge in this project"

This triggers `forge:adopting-forge`. When asked:
- Accept the LLM exposure warning
- Enable audit mode (say yes)
- Review and confirm generated artifacts

### 3. Build

Paste the ideation text EXACTLY as written in spec.yaml:

```
<paste ideation field from spec.yaml>
```

Let brainstorming determine the MVP scope. Do NOT guide or constrain the brainstorming — let Forge work autonomously. Record any deviations where Forge doesn't behave as expected.

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

After completion, run the measurement script:
```bash
bash reference-projects/<project-name>/measure.sh
```

Fill in the manual assessment items in the output.

### 6. Store

Save the measurement output to:
```
reference-projects/<project-name>/runs/<date>-v<forge-version>.md
```

### 7. Compare

If a baseline exists, compare current metrics against it:
- Did tests pass? (same or better)
- Deviation count (fewer = better)
- Skills invoked (expected coverage maintained?)
- Duration (trending?)
- Token cost (when available — trending?)

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
