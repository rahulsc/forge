# Task 2: Create 4 New Specialist Agents

**Specialist:** forge-author
**Depends on:** Task 1 (forge-author must exist)
**Produces:** `agents/frontend-engineer.md`, `agents/backend-engineer.md`, `agents/database-specialist.md`, `agents/devops-engineer.md`
**Complexity:** standard

## Goal

Create 4 specialist agent definitions that are currently referenced by composing-teams but don't exist.

## Acceptance Criteria

- [ ] `agents/frontend-engineer.md` exists with frontmatter and system prompt
- [ ] `agents/backend-engineer.md` exists with frontmatter and system prompt
- [ ] `agents/database-specialist.md` exists with frontmatter and system prompt
- [ ] `agents/devops-engineer.md` exists with frontmatter and system prompt
- [ ] Each agent follows the same pattern as existing agents (architect.md, implementer.md)
- [ ] Each agent has: description, model (opus), tools list, and domain-specific quality standards
- [ ] `ls agents/` shows 10 agent files (5 existing + 4 new + forge-author)

## Test Expectations

- **Test:** `ls agents/*.md | wc -l` returns 10
- **Expected red failure:** returns 6 (5 existing + forge-author)
- **Expected green:** returns 10

- **Test:** each new agent file contains `description:` and `model:` in frontmatter
- **Expected red failure:** files don't exist
- **Expected green:** all 4 files have valid frontmatter

## Files

- Create: `agents/frontend-engineer.md`
- Create: `agents/backend-engineer.md`
- Create: `agents/database-specialist.md`
- Create: `agents/devops-engineer.md`

## Implementation Notes

Use the design doc §3.1 for the description and key system prompt elements for each agent. Follow the exact pattern of existing agents — read `agents/architect.md` and `agents/implementer.md` for the format.

Key system prompt elements per agent (from design):

**frontend-engineer:** Component design/reusability, accessibility (WCAG 2.1 AA), responsive design, browser compat, client-side performance, UI testing

**backend-engineer:** RESTful API design, database integration, error handling/resilience, auth integration, input validation at boundaries

**database-specialist:** Schema design, migration safety (backward compatible, reversible), rollback plans, data integrity constraints, query performance

**devops-engineer:** CI/CD pipeline design, container config, secrets management, infrastructure-as-code, deployment verification, monitoring

All agents use `model: opus` and tools: `Read, Write, Edit, Bash, Glob, Grep`.

## Commit

`feat: add 4 specialist agent definitions (frontend, backend, database, devops)`
