# Task 1: R&D + Create forge-author Agent

**Specialist:** Lead
**Depends on:** None
**Produces:** `agents/forge-author.md` — a specialist agent for writing and editing Forge skills and agent definitions
**Complexity:** complex

## Goal

Research best practices for AI skill/agent authoring, then create a forge-author agent definition informed by that research.

## R&D Phase

Before writing the agent definition, research:

1. **Anthropic's official best practices** — read `skills/writing-skills/anthropic-best-practices.md` (already in repo)
2. **Existing Forge skill patterns** — analyze 3-4 well-structured skills (brainstorming, agent-team-driven-development, writing-plans) for common structure
3. **Existing agent definition patterns** — analyze current 5 agents for frontmatter, system prompt structure, quality standards
4. **Web search** — search for best practices on writing AI agent system prompts, structured skill definitions, and prompt engineering for coding agents
5. **Competitor approaches** — how do other projects (superpowers, spec kit) structure their skill/rule definitions?

Synthesize findings into a set of authoring principles that the forge-author agent will follow.

## Acceptance Criteria

- [ ] R&D findings documented in the commit message (what was learned, what principles were derived)
- [ ] `agents/forge-author.md` exists with frontmatter (description, model, tools)
- [ ] System prompt covers: skill SKILL.md authoring, agent definition authoring, Forge conventions, quality standards
- [ ] Agent definition references `.forge/shared/conventions.md` for naming/style rules
- [ ] Agent understands: process flow diagrams, state contracts, integration sections, HARD-GATEs, checklist patterns

## Test Expectations

- **Test:** `agents/forge-author.md` exists and contains frontmatter
- **Expected red failure:** file doesn't exist
- **Expected green:** file exists with `description:`, `model:`, and tools list

## Files

- Create: `agents/forge-author.md`
- Read (R&D): `skills/writing-skills/anthropic-best-practices.md`
- Read (R&D): `skills/brainstorming/SKILL.md` (exemplar skill)
- Read (R&D): `skills/agent-team-driven-development/SKILL.md` (exemplar skill)
- Read (R&D): `agents/architect.md`, `agents/security-reviewer.md` (exemplar agents)
- Read (R&D): `.forge/shared/conventions.md`

## Implementation Notes

- The forge-author agent should be usable for ALL future skill and agent work — not just v0.3.0
- Key authoring principles to embed:
  - Skills are prompt-only — no compiled code, no API contracts
  - Every skill needs: overview, checklist/steps, process flow, integration section, state contracts
  - Agent definitions need: clear description line, model selection rationale, tool list, quality standards
  - HARD-GATEs prevent skipping critical steps
  - Skills chain via explicit handoff instructions, not implicit imports
  - Convention adherence: kebab-case naming, `docs/<project>/design/` paths, `forge:` namespace
- This agent will be spawned via the Agent tool with `subagent_type: "forge:forge-author"`

## Commit

`feat: create forge-author agent for skill and agent definition authoring`
