# Task 7: Upgrade analyze-audit for JSONL

**Specialist:** forge-author
**Depends on:** Task 2 (needs to know JSONL schema from forge-audit implementation)
**Produces:** Updated analyze-audit skill that reads JSONL + produces cost analysis

## Goal

Upgrade `forge:analyze-audit` to read JSONL audit files and produce token/cost analysis alongside the existing deviation analysis.

## Acceptance Criteria

- [ ] Skill checks for `.forge/local/audit/*.jsonl` files and reads them if present
- [ ] New "Cost Analysis" section in report output when JSONL data exists
- [ ] Token cost per skill dimension added
- [ ] Token cost per workflow dimension added
- [ ] Gate pass rate dimension added
- [ ] Session duration dimension added
- [ ] Skill gracefully handles missing JSONL (falls back to manual-only analysis)

## Test Expectations

Tests: N/A — documentation-only task (skill prompt edits)

## Files

- Modify: `skills/analyze-audit/SKILL.md`

## Implementation Notes

Update the "Input Sources" section to show JSONL as "Available Now" (not "Future"):

```markdown
### Available Now (v0.4.0)
| Source | Location | What It Contains |
|--------|----------|-----------------|
| Audit JSONL | `.forge/local/audit/<session-id>.jsonl` | Structured events with token counts |
| Deviation worklog | Design doc Appendix G | Expected vs actual behavior |
| Git history | `git log` | Commits, patterns, timestamps |
| Plan documents | `docs/*/plans/plan.md` | Task specs, wave structure |
```

Add new analysis dimensions:

```markdown
| **Token cost per skill** | Total tokens by skill | JSONL skill_enter/skill_exit |
| **Token cost per workflow** | Total tokens by workflow | JSONL grouped by workflow |
| **Gate pass rate** | % gates passed first attempt | JSONL gate_check events |
| **Session duration** | Wall clock per session | JSONL session_start to last event |
```

Add Cost Analysis report section:

```markdown
## Cost Analysis (from audit JSONL)

| Skill | Invocations | Avg Tokens In | Avg Tokens Out | Avg Duration |
|-------|-------------|---------------|----------------|-------------|
```

## Commit

`feat: upgrade analyze-audit to read JSONL and produce cost analysis`
