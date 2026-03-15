# Task 6: Create Task Tracker API Spec + Scaffold + Measure

**Specialist:** implementer (shell engineer)
**Depends on:** Task 5 (runbook defines the protocol)
**Produces:** `reference-projects/task-tracker-api/` with spec.yaml, scaffold.sh, measure.sh

## Goal

Create the complete reference project infrastructure for the Task Tracker API (inspired by Linear/Asana).

## Acceptance Criteria

- [ ] `reference-projects/task-tracker-api/spec.yaml` exists with ideation text from design-v3.md Appendix E
- [ ] `reference-projects/task-tracker-api/scaffold.sh` is executable and creates a clean project directory
- [ ] `reference-projects/task-tracker-api/measure.sh` is executable and collects available metrics
- [ ] `reference-projects/task-tracker-api/runs/` directory exists (empty, for future results)
- [ ] scaffold.sh creates `~/Projects/forge-ref-projects/task-tracker-api/` with git init
- [ ] spec.yaml includes expectations for risk tiers, workflows, agents

## Test Expectations

- **Test:** Run scaffold.sh — creates the directory with git init
- **Expected red failure:** directory doesn't exist
- **Expected green:** directory exists with .git/

## Files

- Create: `reference-projects/task-tracker-api/spec.yaml`
- Create: `reference-projects/task-tracker-api/scaffold.sh`
- Create: `reference-projects/task-tracker-api/measure.sh`
- Create: `reference-projects/task-tracker-api/runs/.gitkeep`

## Implementation Notes

Use the spec.yaml format from design §3.2. The ideation text comes from design-v3.md Appendix E.1.

scaffold.sh should:
1. Clean any existing directory
2. Create fresh directory
3. git init
4. Create .gitignore with node_modules/
5. Initial commit
6. Print instructions for next steps

measure.sh should:
1. Check if project exists
2. Run tests if test runner detected
3. Count git stats (commits, files)
4. Check for audit JSONL
5. Print manual assessment checklist

## Commit

`feat: create Task Tracker API reference project spec, scaffold, and measure scripts`
