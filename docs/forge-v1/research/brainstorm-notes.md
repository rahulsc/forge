# Forge v1.0 Brainstorming Notes

## Session: 2026-03-17

### Decisions Made

1. **v1.0 = feature milestone + product launch** (not just stability)
2. **Primary audience: engineering teams** (individuals and AI tool builders also supported)
3. **Distribution: plugin-first** but architecture for future standalone CLI
4. **Phased buildout** (v0.6 → v1.0, can include v0.10, v0.11, etc.)
5. **Research-first** — competitive analysis before finalizing version scoping
6. **Multi-LLM review** — GPT 5.4 and Qwen will review the design

### 11 Identified Pillars

| # | Pillar | Description |
|---|--------|-------------|
| 1 | Intelligent Orchestrator | Upgrade forge-routing to a Principal Engineer that owns project execution end-to-end. Not for unsupervised builds — a supervised, high-quality workflow leader. |
| 2 | Competitive Research | Deep scan of competitors, issues/PRs, blogs, forums. Expand comparison to include where competitors beat Forge. |
| 3 | Skill Streamlining | Consolidate redundant skills (e.g., TDD into subagent-driven-dev), break large ones into cleaner units. |
| 4 | Agent Evolution | More agents, better definitions, research-backed iteration on effectiveness. |
| 5 | Visualization Server | Serious investment in forge-viz as a real product feature. |
| 6 | Team Sharing | Shared conventions, policies, decisions via git for engineering teams. |
| 7 | Onboarding Wizard | Guided first-run that gets a team productive quickly. |
| 8 | Enterprise Workflow Packs | Mono/multi-repo support, Linear/Monday/Slack integrations — as installable packs. |
| 9 | Product Launch Polish | Distribution story, docs, community-facing quality. |
| 10 | Multi-LLM Support | ChatGPT manual workflow + API. Multi-LLM review panels. Both cheap manual and API-based paths. |
| 11 | Multi-Agent All Phases | Brainstorming with role-playing agents (different skill sets), parallel planning, team execution for all phases not just implementation. |

### Approach Selected

**Foundation-First (modified):** Competitive research runs first to inform version scoping, then orchestrator + skill streamlining as the architectural spine, then layer features on top.

### Key Architectural Constraints

- Plugin-first but harness-agnostic architecture
- Teams are primary audience — shared state, consistency, onboarding matter most
- Orchestrator differentiator: not unsupervised like Gastown's mayor — a supervised Principal Engineer
- Multi-LLM: must support manual (copy/paste to ChatGPT) workflow, not just API
- Packs for optional integrations to avoid out-of-the-box bloat
- Agent context must stay under 200k tokens

---

## Session Status (2026-03-18, end of day)

### Completed
1. **Competitive research** — 5 tracks complete, ~3,900 lines of research
   - `competitors/orchestrators.md` (26 projects, 1,356 lines)
   - `competitors/coding-assistants.md` (13 tools, 964 lines)
   - `community/github-issues-analysis.md` (9 repos, 553 lines)
   - `community/developer-sentiment.md` (10 topics, 405 lines)
   - Key finding: Forge occupies genuinely uncontested territory (risk-scaled + TDD + evidence-gated + team-first)

2. **Naming research** — 5 rounds, ~120 candidates evaluated
   - `naming-brief-for-review.md` — Final brief ready for GPT 5.4 / Qwen review
   - Top pick: **Arkwright** (brand) / **ark** (CLI)
   - Shortlist: Arkwright, Charter, Princeps, Boole, Archwright
   - All research in `naming-research*.md` files

### Next Steps (resume tomorrow)
1. **Send naming brief to GPT 5.4 and Qwen** for external input
2. **Draft v1.0 design document** with version phasing (v0.6 → v1.0)
   - Synthesize all research into design proposal
   - Cover: orchestrator design, skill streamlining, agent evolution, team sharing, onboarding, viz server, multi-LLM, enterprise packs
   - Include research-backed priority stack (Tier 1-4)
3. **Design review** — GPT 5.4 and Qwen review the design
4. **Finalize name** based on external feedback

### Research-Backed Priority Stack
**Tier 1 (Must-have):** Zero-config onboarding, AGENTS.md compatibility, intelligent orchestrator, cost transparency
**Tier 2 (Strong advantage):** Team sharing, named autonomy levels, CI-enforced evidence, skill streamlining
**Tier 3 (Differentiation):** Multi-LLM support, multi-agent all phases, viz server, enterprise packs
**Tier 4 (Watch):** Kiro compatibility, Augment Code, Claude Code native capabilities
