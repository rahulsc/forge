# Task 5: README Rewrite

**Specialist:** implementer (documentation/technical writing)
**Depends on:** Task 3 (restructure — all paths must be final)
**Produces:** Complete README.md rewritten around outcomes, with skill flow diagram and comparison chart

## Goal

Rewrite the README from a feature list into an outcome-first guide that a new user can follow to understand, install, and use Forge.

## Acceptance Criteria

- [ ] README opens with a one-paragraph product pitch
- [ ] "Why Forge" section with comparison chart (from design-v3.md §15)
- [ ] "Quick Start" section with 3-step path: install → adopt → first workflow
- [ ] All 8 outcome workflows documented with: user prompt, what Forge does, artifacts produced, verification required
- [ ] Skill flow metro map as Mermaid diagram showing how skills compose into pipelines
- [ ] Risk-scaled ceremony explained visually (minimal → standard → elevated → critical)
- [ ] Installation section for all 5 platforms (Claude Code, Cursor, Codex, OpenCode, Gemini CLI) with correct post-restructure paths
- [ ] Verify installation section with concrete test prompt per host
- [ ] Getting started walkthrough (first 10 minutes)
- [ ] Infrastructure section (`.forge/` directory, briefly)
- [ ] Agent roster table (current 5 agents)
- [ ] "Extending Forge" section (skills, packs, agents — brief)
- [ ] FAQ / troubleshooting section (5+ common questions)
- [ ] Philosophy section (brief)
- [ ] Attribution section (linking to ORIGINS.md, NOTICE.md)
- [ ] All URLs point to `rahulsc/forge` (not superpowers)
- [ ] All file paths reflect post-restructure layout (bin/, policies/, etc.)

## Test Expectations

- **Test:** README contains section headers for all 8 workflows
- **Expected red failure:** current README has no workflow sections
- **Expected green:** grep for "Start a feature", "Fix a bug", "Refactor safely", "Review a change", "Resume work", "Prepare a release", "Adopt a repo", "Investigate an incident" all match

- **Test:** README contains a Mermaid diagram
- **Expected red failure:** no `mermaid` code block in current README
- **Expected green:** README contains ````mermaid` block with skill flow diagram

- **Test:** README contains comparison chart table
- **Expected red failure:** no comparison table in current README
- **Expected green:** README contains table with "Forge", "Superpowers", "Spec Kit" headers

- **Test:** README references correct paths (bin/ not .forge/bin/)
- **Expected red failure:** README references `.forge/bin/`
- **Expected green:** README references `bin/`

## Files

- Modify: `README.md` (complete rewrite — preserve nothing from current version except what's still accurate)

## Implementation Notes

- The current README is 251 lines. The new README will be significantly longer (estimated 400-600 lines) due to workflow descriptions and getting started guide.
- The 8 workflows and their skill pipelines are defined in design-v3.md §7.3. Use that as the source.
- The comparison chart is in design-v3.md §15. Use the capability-level matrix (more strategic than feature checkboxes).
- The metro map concept is in design-v3.md §7.4. Implement as a Mermaid flowchart with labeled lines per workflow.
- The Mermaid diagram should render natively on GitHub. Test by previewing.
- For the "Quick Start" section, the walkthrough should match what `forge:adopting-forge` actually does today (not the future v0.3.0 version).
- For verify installation, provide a specific prompt like: `"I'd like to start a new feature"` and explain what the user should see (forge-routing triggers, brainstorming skill loads).
- FAQ answers should be actionable, not vague. Example: "Run `forge:diagnosing-forge`" not "check your configuration."
- Keep the README scannable — use tables, collapsible sections (details/summary), and short paragraphs.

## Commit

`docs: rewrite README with outcome-first structure, workflow guides, and comparison chart`
