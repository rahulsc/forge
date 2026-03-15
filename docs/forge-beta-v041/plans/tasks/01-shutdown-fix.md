# Task 1: Fix Agent Shutdown in agent-team-driven-development

**Specialist:** forge-author
**Depends on:** None
**Produces:** Updated SKILL.md with shutdown rules that prevent idle loops
**Tests:** N/A — documentation-only task

## Goal

Fix deviation #12: agents enter idle loop when replaced across waves. Add wave-suffixed naming convention, structured-only shutdown, immediate shutdown after wave.

## Acceptance Criteria

- [ ] Wave Cleanup Routine specifies: send structured `{"type": "shutdown_request"}` — never plain text
- [ ] Wave Cleanup Routine specifies: wait for shutdown_approved, proceed after 30 seconds if no response
- [ ] Red Flags section includes: never use plain text for shutdown, never reuse agent names across waves, never batch shutdowns at end
- [ ] Agent naming convention documented: `<role>-w<N>` (e.g., forge-author-w0, shell-eng-w1)
- [ ] Team Setup section specifies wave-suffixed names when spawning agents

## Files

- Modify: `skills/agent-team-driven-development/SKILL.md`

## Commit

`fix: prevent agent idle loops — wave-suffixed names, structured shutdown only`
