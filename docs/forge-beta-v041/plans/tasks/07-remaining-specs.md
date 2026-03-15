# Task 7: Create Remaining 5 Project Specs

**Specialist:** implementer (shell engineer)
**Depends on:** Task 5 (runbook), Task 6 (pattern to follow)
**Produces:** spec.yaml + scaffold.sh + measure.sh for 5 remaining projects

## Goal

Create reference project infrastructure for Dashboard UI, CLI Migration Tool, Deploy Pipeline, Auth Service, and Full-Stack Notes App.

## Acceptance Criteria

- [ ] `reference-projects/dashboard-ui/spec.yaml` exists with ideation from Appendix E.2
- [ ] `reference-projects/cli-migration-tool/spec.yaml` exists with ideation from Appendix E.3
- [ ] `reference-projects/deploy-pipeline/spec.yaml` exists with ideation from Appendix E.4
- [ ] `reference-projects/auth-service/spec.yaml` exists with ideation from Appendix E.5
- [ ] `reference-projects/full-stack-notes-app/spec.yaml` exists with ideation from Appendix E.6
- [ ] Each has scaffold.sh (adapted for its stack) and measure.sh (copy of task-tracker pattern)
- [ ] Each has runs/.gitkeep
- [ ] All scaffold.sh files are executable

## Test Expectations

Tests: N/A — files only, not executed yet (these projects run in v0.4.2+)

## Files

- Create: `reference-projects/dashboard-ui/{spec.yaml,scaffold.sh,measure.sh,runs/.gitkeep}`
- Create: `reference-projects/cli-migration-tool/{spec.yaml,scaffold.sh,measure.sh,runs/.gitkeep}`
- Create: `reference-projects/deploy-pipeline/{spec.yaml,scaffold.sh,measure.sh,runs/.gitkeep}`
- Create: `reference-projects/auth-service/{spec.yaml,scaffold.sh,measure.sh,runs/.gitkeep}`
- Create: `reference-projects/full-stack-notes-app/{spec.yaml,scaffold.sh,measure.sh,runs/.gitkeep}`

## Implementation Notes

Follow the exact pattern from Task 6. Each project differs in:
- Ideation text (from Appendix E)
- Starting state (most are empty_directory, deploy-pipeline has a provided skeleton)
- Project directory path (`~/Projects/forge-ref-projects/<name>/`)
- .gitignore content (node_modules/ for JS, __pycache__/ for Python, etc.)
- Expected risk tiers, workflows, agents (from Appendix E)

scaffold.sh for deploy-pipeline is special — it needs to create a basic Node.js app skeleton as the starting state, not just an empty directory.

## Commit

`feat: create 5 remaining reference project specs with scaffold and measure scripts`
