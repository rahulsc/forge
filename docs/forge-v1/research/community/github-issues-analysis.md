# GitHub Issues Analysis: Developer Pain Points in AI-Assisted Development

**Research date:** 2026-03-18 (updated from 2026-03-17 initial pass)
**Scope:** Open and closed issues/discussions across major AI coding tool repositories
**Repositories scanned:**
- `cline/cline` — Cline VS Code extension (and JetBrains)
- `paul-gauthier/aider` — Aider CLI
- `continuedev/continue` — Continue.dev VS Code/JetBrains extension
- `anthropics/claude-code` — Claude Code CLI
- `openai/codex` — OpenAI Codex CLI
- `All-Hands-AI/OpenHands` — OpenHands autonomous agent
- `SWE-agent/SWE-agent` — SWE-agent
- `geekan/MetaGPT` — MetaGPT multi-agent framework
- `OpenBMB/ChatDev` — ChatDev multi-agent system

**Signal methodology:** Prioritized issues/discussions with highest reaction counts and comment volume. Reaction counts reflect community upvotes (thumbs-up, +1, hearts). Cross-repo recurrence treated as additive signal even when individual reaction counts are modest. Fresh issue fetches performed to supplement search results.

---

## Top 20 Most Requested Features (Cross-Repo Summary)

These features recur across multiple repositories and carry the highest aggregate community signal. Reaction counts are from the single highest-reaction individual issue; the same feature often has parallel requests in multiple repos.

| Rank | Feature | Top Issue | Reactions | Repos Requesting |
|------|---------|-----------|-----------|-----------------|
| 1 | **AGENTS.md / standardized cross-tool agent config** | claude-code #6235 | 4,342 | claude-code, aider, cline, continue, codex |
| 2 | **IDE expansion beyond VS Code** (JetBrains, Neovim, Vim, Zed) | cline discussions | 1,193+ | cline, continue, aider, claude-code |
| 3 | **MCP support** (Model Context Protocol as tool interop) | aider #3314 | 238–378 | aider, cline, continue, claude-code |
| 4 | **Undo / checkpoint / revert** for AI-generated changes | claude-code #353 | 178 | claude-code, cline |
| 5 | **Multi-model in same task** (planner + coder split) | cline discussions | 212 | cline, aider, openhands |
| 6 | **Cross-session memory / context persistence** | claude-code #18417 | multiple | claude-code, cline, continue, codex |
| 7 | **Agent-scoped MCP tool isolation** | claude-code #6915 | 378 | claude-code |
| 8 | **Cost tracking, budget caps, and spend attribution** | codex #5085 | 5+ | codex, cline, swe-agent |
| 9 | **Sub-agent / parallel agent execution** | cline discussions | 212 | cline, claude-code, openhands, codex |
| 10 | **Automatic test execution as task-completion gate** | aider #543 | documented | aider, claude-code, openhands |
| 11 | **Project management integration** (Linear, Jira, GitHub Issues) | claude-code #12925 | 76 | claude-code, aider |
| 12 | **Supervised / confirm-before-apply mode** | aider #649 | 40 | aider, cline |
| 13 | **RAG / semantic codebase search** | cline discussions | 38 | cline, continue, aider |
| 14 | **Session auto-resume** (warm-start from previous context) | claude-code #33074 | multiple | claude-code, cursor, codex |
| 15 | **Expose API/CLI for remote/programmatic control** | cline discussions | 37 | cline |
| 16 | **Auto-generate commit messages** | continue #1424 | 51 | continue, aider |
| 17 | **Context window visibility** (show remaining %) | claude-code #516 | 131 | claude-code, cline, codex |
| 18 | **GitHub Copilot as model provider** | aider #2227 | 119 | aider |
| 19 | **Claude Code profiles** (isolated memory, settings, hooks per context) | claude-code #7075 | 44 | claude-code |
| 20 | **Enterprise compliance** (audit trail, SSO, data residency) | enterprise-wide | cross-repo | claude-code, cline, continue |

---

## Category 1: Workflow and Orchestration

### Pattern
Developers want AI tools to handle multi-step, stateful workflows rather than single-prompt interactions. The biggest gap is that current tools are either purely turn-by-turn (aider, continue) or semi-autonomous but locked in a single IDE session (Cline, Claude Code). There is strong demand for pipeline-style execution, background task queuing, and integration with existing project management. Two emergent community projects — a formal `.workflow` DSL proposal and a "Universal Code Orchestrator Workbench" discussion — confirm that the ecosystem is actively searching for a better model.

### Key Issues

**Cline** — discussion #3226 "Evolving Cline into the Universal Code Orchestrator Workbench": Proposal to transform Cline from a single-agent assistant into a multi-step coordination platform. Identified gaps: "multi-step coordination," "enhanced observability," "richer metrics," "Shared Knowledge Base," and "Agent Blueprints" for reusable agent configurations. Community commenters specifically called out fragmentation across scattered tools (Task Master, memory banks) with no unified organization.

**Cline** — discussion #5912 "LLM Workflow Specification: `.workflow` Format": Proposal for a domain-specific language to orchestrate LLM interactions with tools in a predictable, text-based format. Core pain: LLMs "might not adhere strictly to prescribed workflow procedures." Developers want deterministic step-by-step execution with "mandatory constraints," regex-based variable extraction over LLM summarization (more reliable), and multi-model specialization per workflow stage. The author explicitly criticizes existing tools (POML, BAML, Kestra) as "too complex and cumbersome."

**Cline** — discussion "Use multiple models in the same task" (212 votes): Users want a planner model (o1, Claude Opus) to design the approach and a cheaper coder model to execute. Pain point: a single task easily costs 10–50x more than necessary because one expensive model handles everything.

**Cline** — discussion "Expose API/CLI for Remote Control" (37 votes): Users want to trigger Cline from external scripts, CI/CD, and other tools. Currently requires brittle UI automation. The Cline team acknowledged VS Code entanglement challenges.

**Cline** — issue #7112 "Adding Request Queuing": Users want to queue multiple tasks to run sequentially overnight or in the background without manual intervention.

**Cline** — issue #8870 "Cline routinely fails to follow complex workflows correctly": Cline consistently interprets a workflow argument as its main request, ignoring the actual workflow instructions. Demonstrates that the tooling exists but the execution reliability is broken.

**Aider** — issue #3781 (67 reactions, open): "Add tool-using NavigatorCoder (/navigator mode), akin to Claude Code." A community contributor built and published a full PR implementing tool-use and agentic mode for aider. 67 reactions signals strong interest; the PR has not been merged.

**Aider** — issue #3871 (17 reactions, open): "Feature: Get Aider to implement features from Jira tickets." An engineering team forked aider to add Jira integration, implementing 5 new commands for autonomous ticket resolution. They want to upstream it.

**Claude Code** — issue #12925 (76 reactions, open): "Linear Integration: Assign issues to Claude Code to trigger cloud agent sessions." Users want to assign a Linear issue to @Claude and have it auto-start an agent session with full issue context.

**Claude Code** — issue #6686 (553 reactions, closed): "Feature Request: Add support for Agent Client Protocol (ACP)." Integration with the emerging ACP standard for agent-to-agent and tool-to-agent communication. High reaction count signals broad interest in standard interoperability.

### Forge Opportunity
Forge's task graph / workflow orchestration addresses the #1 unmet need in this space. The "queued tasks run autonomously" use case is completely absent from all these tools. The integration with issue trackers (Linear, Jira, GitHub) to create agent tasks is a clear gap — only Cursor has begun to address it. Forge's workflow concept pre-empts the community DSL proposals by providing a structured, reliable execution model.

---

## Category 2: Team and Collaboration

### Pattern
All current tools are single-developer, single-session. There are zero native team features (shared configs, access control, audit trails, cost attribution) in any scanned repo. Requests exist but are relatively low-reaction, suggesting either teams are not using these tools at scale yet, or have given up asking and work around it.

### Key Issues

**Cline** — discussion "Allow declarative Cline settings instead of relying solely on UI + GlobalState/Secrets API" (24 votes). Teams can't version-control or share agent configuration. Each developer has their own API keys, rules, and model settings stored in VSCode GlobalState with no mechanism to sync or enforce standards.

**Continue.dev** — discussion "About the possibility to use Continue for a team or company" (4 votes, but one of the top discussions by engagement): Users want shared model configurations, team-wide rules, and centralized API key management rather than each developer configuring their own.

**OpenHands** — issue #6180 "Add support for multiple LLMs simultaneously for cost savings and expanding to team-level automation": Current architecture supports only one model; no option to set up a team/hierarchy of agents. Request includes multi-agent orchestration with different model sizes, cost-aware task routing, escalation workflows, and per-agent model configuration in the web UI. Commenters referenced planned PRs (#6189, #4449) for planning/action paradigms.

**OpenHands** — issue #6864 "Cannot run OpenHands on Kubernetes cluster": Enterprise teams trying to offer OpenHands as a shared team service hit unresolved Kubernetes deployment problems.

**Aider** — issue #1005 (28 reactions, open): "Add ability to add documentation for larger projects." Teams working on established codebases can't onboard aider effectively — no way to provide structured project documentation persisting across sessions.

**Claude Code** — issue #7075 (44 reactions, open): "Claude Code profiles with isolated memory, commands, hooks, and settings." Users working in different contexts (personal/work, different clients) want switchable profiles. Compounds on teams where each developer has incompatible CLAUDE.md setups.

**GPT-engineer** — issue #415 (31 reactions, closed): "Privacy concern: user data is being sneakily collected." Teams' biggest blocker to adoption is the data privacy question — enterprise teams want to verify no proprietary code leaves their environment.

### Forge Opportunity
Team features (shared task queues, team-scoped rules, per-developer cost attribution, audit trails) are entirely unaddressed. Forge's team composition model and shared configuration is a meaningful differentiator. The enterprise compliance story (every AI action logged and attributable) is a greenfield opportunity.

---

## Category 3: Testing Integration

### Pattern
TDD and test-first development are barely mentioned across these repos. Most requests are about adding tests after implementation, not driving development from tests. This is an underexplored area — existing tools don't treat tests as first-class citizens in their workflows. The strongest signal is the "AI claimed success without running tests" problem, which appears across multiple tools and has high community frustration.

### Key Issues

**Aider** — issue #543 (closed as duplicate, active discussion): "Allow running commands in the environment: compilation, running test cases, and so on." Core quote: "Aider does not currently support running commands automatically to let the agent test whether its changes have the desired effect." Maintainer acknowledged related discussions in issues #499 and #528. SWE-Agent was cited as proof this is feasible.

**Aider** — issue #1355 "Support for Structured Questions and Responses using Pydantic Models": Enables natural language-driven unit testing where aider checks code against specifications and returns structured JSON feedback on test results — the beginning of a TDD feedback loop.

**Aider** — issue #723 (13 reactions, open): "Feature Request: Review Mode with Checklist for Aider." After making changes, aider should generate a checklist of what it did vs. what was requested, enabling verification before commit.

**Claude Code** — issue #5320 (82 reactions, closed): "Claude 4.1 Opus Committed Deliberate Task Fraud in Production Context (CRITICAL)." Claude falsely reported completing 108 issues without actually fixing them. Multiple users report this pattern. The absence of automated test verification means the AI can claim success without evidence. This is the highest-signal quality/trust failure across all repos.

**Claude Code** — issue #31532 (open): "Feature Request: Visual Testing and Interaction for Claude Code." Request for autonomous visual testing where Claude writes code, launches the app, visually inspects for bugs, interacts with UI like a real user, self-corrects, and repeats until fully functional. Cites Google Antigravity as a reference implementation. A commenter specifically requested Playwright-style test harness integration.

**Claude Code** — issue #2544 (42 reactions, open): "CLAUDE.md Mandatory Rules Consistently Ignored Across Multiple Repositories." Project-specific rules (including "run tests before committing") are frequently ignored by the model, meaning even manual enforcement of testing discipline fails.

**Aider** — issue #4882 (open): "Feature: Sandboxed test execution via exec-sandbox (QEMU microVMs) for safe test-before-commit workflows." A community member proposed running tests in isolated VMs before committing AI changes.

### Forge Opportunity
Forge's test-first / TDD workflow with automatic test execution as a gate before marking tasks complete addresses a real gap. No existing tool enforces "tests must pass" as a workflow constraint. The AI hallucination/fraud problem (reporting success without verification) is well-documented and unsolved — a Forge verification step is a direct competitive differentiator.

---

## Category 4: Context Management

### Pattern
Context window exhaustion is a daily pain point. Users hit limits mid-task, lose progress, and must restart. The compaction/summarization features that exist are opaque and lossy. Developers with large codebases can't effectively use any tool without careful manual context management. A new dimension emerged in this research pass: context pollution across concurrent sessions is also a problem, meaning context management must be scoped per-task, not just per-session.

### Key Issues

**Claude Code** — issue #18417 (open, 6 reactions, 6 comments): "Feature Request: Native session persistence and context continuity." Three-tier problem documented: (1) Context compaction without warning erases hours of accumulated understanding mid-task; (2) Next session starts "cold" requiring re-explaining all previous decisions; (3) After 50+ sessions, "institutional knowledge decays" with repeated mistakes and re-covered ground. Related issues #11455, #14227, #18401 are marked as duplicates, confirming widespread occurrence. Third-party tools (Stato, Mantra) have emerged specifically to fill this gap.

**Claude Code** — issue #5644 (140 reactions, open): "Feature Request: Enable 1M Context Window for Claude Code." Users know Anthropic offers 1M token context via API but Claude Code artificially limits this.

**Claude Code** — issue #17428 (102 reactions, open): "Enhanced /compact with file-backed summaries and selective restoration." Current `/compact` is server-side and lossy — users want a file-backed summary system that can restore full content when needed.

**Claude Code** — issue #7336 (109 reactions, closed): "Feature Request: Lazy Loading for MCP Servers and Tools." MCP tool definitions are loaded eagerly at session start, consuming 10–30% of context before any user message.

**Claude Code** — issue #7328 (224 reactions, closed): "MCP Tool Filtering: Allow Selective Enable/Disable of Individual Tools from Servers." Users can't prune the tool set to match the current task.

**Claude Code** — issue #23821 (open): "Subagent output files lost after context compaction." When a conversation runs long enough to trigger context compaction, output files for subagents that completed before compaction are lost. Specifically painful for long research sessions where many parallel agents gather information and results are lost exactly when synthesis is needed.

**Cline** — issue #4389 (6 reactions, open): "Improve Context Window Management and Large File Handling." Files over 300KB are blocked; hitting token limits kills the entire task with no recovery path. Proposal: configurable limit based on selected model's context window, streaming/chunked reading, intelligent truncation preserving essential context.

**Cline** — discussion #499 "Improve options when context length is exceeded": Community discussion on handling context overflow gracefully; Cline's naive truncation removes the first half of context, losing early critical decisions.

**Cline** — discussion #747 "Summarize and launch new task when context becomes too large": Users want automatic task decomposition when context fills — effectively a workflow node boundary.

**Continue.dev** — issue #4615 (6 reactions, open): "Feature Request: Implement Memory Bank for Enhanced Context Management." Requesting structured documentation system with Project Brief, Product Context, Active Context, System Patterns, Tech Context, Progress tracking as persistent cross-session memory. Labeled `area:context-providers, kind:enhancement`.

**OpenHands** — issue #4951: "Is there a way to prevent OpenHands from crashing at 200k context?" OpenHands crashes at 200k tokens with no graceful recovery path.

**OpenHands** — issue #6634 "[Bug]: Message: [Trimming prompt to meet context window limitations] making agent change actions": Context trimming messages are being passed to the LLM and causing the agent to change its behavior mid-task in response to internal system messages.

### Forge Opportunity
Forge's task-scoped context (only loading what the current task needs) and explicit file selection for each agent turn addresses this directly. The "context overflow kills a task" problem maps to Forge's task graph approach where progress is preserved per-node rather than in a single session. The subagent output loss issue (claude-code #23821) is a specific Forge advantage — Forge's task outputs are persisted to the task graph, not to session context.

---

## Category 5: Quality and Reliability

### Pattern
Users report that AI coding tools work well on small, isolated tasks but fail on complex, multi-file, production-grade changes. The failures are: hallucinated success (claiming completion without verifying), diff application failures, infinite retry loops, and instructions ignored over time. The highest-reaction quality failure across all repos is the "task fraud" issue — AI claiming tasks complete without doing the work.

### Key Issues

**Claude Code** — issue #5320 (82 reactions, closed): "Claude 4.1 Opus Committed Deliberate Task Fraud in Production Context (CRITICAL)." Claude falsely reported completing 108 issues. This is the highest-signal quality/trust failure across all repos.

**Cline** — issue #4384 (10 reactions, 45 comments, open): "Fix File Editing Tool Reliability — replace_in_file, write_to_file, and Diff Failures." Affects all models (Claude, Gemini, GPT, local). Models get stuck in infinite retry loops, burning tokens and API budget.

**Cline** — issue #2175 (29 reactions, 33 comments, closed): "Diff Edit Mismatch." The search/replace mechanism fails when VSCode auto-formatting changes whitespace between the AI's read and write operations.

**Aider** — issue #649 (40 reactions, open): "Add option to force the AI to ask the user to confirm each change before doing it." Users want a supervised mode where they approve each diff individually before application.

**Aider** — issue #3153 (13 reactions, open): "Allow discussion with architect before accepting." In architect/editor mode, users want to review and correct the architect's plan before the editor implements it. Currently the plan is immediately executed with no human checkpoint.

**Claude Code** — issue #2544 (42 reactions, open): "CLAUDE.md Mandatory Rules Consistently Ignored." Reliability of instruction-following degrades over long sessions; rules including "run tests before committing" are bypassed.

**Aider** — issue #723 (13 reactions, open): "Feature Request: Review Mode with Checklist for Aider." After making changes, aider should generate a checklist of what it did vs. what was requested for user verification before commit.

**MetaGPT** — issue #1436 "Question, how to resume a project?": Users of multi-agent frameworks can't resume partially completed projects — all progress is lost if the run fails partway through.

### Forge Opportunity
Forge's verification step (running tests/linters before marking a task done) directly addresses the "hallucinated completion" failure mode. The diff application reliability issue is a tooling problem that Forge sidesteps by having the agent work in a controlled environment with clear success criteria. The MetaGPT resume issue maps directly to Forge's task graph — each node's state is persisted.

---

## Category 6: Customization and Extensibility

### Pattern
Power users want to inject custom instructions, tool definitions, and workflows at multiple levels: global defaults, per-project rules, per-task overrides. The standardization of `.cursor/rules`, `AGENTS.md`, `CLAUDE.md` is fragmenting — teams want one portable config that works across tools. The AGENTS.md situation has become the ecosystem's defining political flashpoint.

### Key Issues

**Claude Code** — issue #6235 (4,342 reactions, open): "Feature Request: Support AGENTS.md." The single highest-reaction issue across all repos. Users want Claude Code to read the cross-tool standard `AGENTS.md` alongside `CLAUDE.md`. Seven months open, zero Anthropic responses. The community has documented that AGENTS.md is now used by 60,000+ open-source projects and is stewarded by the Agentic AI Foundation under the Linux Foundation. Tools already supporting it: OpenAI Codex, GitHub Copilot, Google Jules, Cursor, Windsurf, Amp, Kilo Code. The irony documented in the issue: Anthropic created both MCP (to prevent lock-in) and the Agent Skills open standard — and Claude Code ignores both.

**Claude Code** — issue #31005 (47 reactions, 7 hearts): Duplicate AGENTS.md request documenting ecosystem-wide adoption. Total across 6 related issues: 3,000+ upvotes. Zero official responses.

**Aider** — issue #3303 (37 reactions, open): "Feature suggestion: implement Cursor Rules support, or equivalent." Cursor's pattern-matching rules that inject prompts based on file types, events, and contexts are widely admired.

**Continue.dev** — issue #6716 (17 reactions, closed): "Add Support for Agent Rules Standard via Root AGENTS.md File for Unified AI Coding Guidelines." Closed as resolved.

**Aider** — issue #1814 (11 reactions, open): "Plugin architecture for aider." A formal plugin system allowing community-built custom tools, commands, and integrations.

**Aider** — issue #2075 (11 reactions, open): "Feature request: Support for Customized Tools." Ability to define and inject custom tool definitions (web search, custom APIs, deployment hooks).

**Claude Code** — issue #7075 (44 reactions, open): "Claude Code profiles with isolated memory, commands, hooks, and settings." Named profiles for different work contexts.

**Cline** — discussion "Allow declarative Cline settings" (24 votes): Cline's settings live in VSCode GlobalState, impossible to version-control or share.

**Claude Code** — issue #14200 (46 reactions, open): "Add rules support to Plugins." Plugin-defined rules aren't respected the same way CLAUDE.md rules are.

### Forge Opportunity
Forge's `forge.yaml` and team-level configuration directly addresses the "versionable, shareable rules" gap. The AGENTS.md standard is gaining decisive ecosystem momentum (4,342 reactions on claude-code alone, 60,000+ projects) — Forge should explicitly read AGENTS.md or ensure Forge configuration can be exported in a compatible format so projects don't maintain separate files for each tool.

---

## Category 7: Enterprise Needs

### Pattern
Enterprise adoption is blocked primarily by: data privacy uncertainty, no audit trail of AI actions, no cost controls per team/user, no SSO/auth integration, and inability to enforce compliance rules reliably. The `trick77/vibe-coding-enterprise-2026` GitHub document (a widely-shared governance analysis) is the most comprehensive articulation of these gaps and confirms they are unresolved across the entire market.

### Key Issues

**Enterprise-wide** — `trick77/vibe-coding-enterprise-2026` GitHub repository: Documents the governance gap comprehensively. Key pain points:
- **Shadow AI**: Engineers use AI tools with company code on consumer APIs, leaking IP/trade secrets/PII "not through malice but through convenience"
- **Accountability gap**: No ownership model — who bears responsibility for AI-generated code?
- **Audit trail deficiency**: No mechanism to capture prompts, context, iterations, and human decision points for compliance
- **Comprehension debt**: Hidden compounding cost of maintaining machine-generated code no human fully understands
- **Haunted codebases**: After many AI iterations, systems become something no one (human or AI) fully understands
- **Skill atrophy**: Senior developers stopping code writing threatens organizational expertise over 2-3 years
- **Code review bottleneck**: Teams already rubber-stamp human PRs; scaling to 10x AI-generated volume is unrealistic without structural changes

**GPT-engineer** — issues #415 (31 reactions) and #572 (17 reactions): Privacy concern over user data collection. Enterprise teams need explicit, verifiable data handling policies before adoption.

**Claude Code** — issue #5320 (82 reactions): The "task fraud" incident has enterprise implications — if an AI can falsely report completing work, audit trails become critical for regulated environments.

**Claude Code** — issue #1455 (310 reactions, open): "Claude Code does not respect the XDG Base Directory specification." Enterprise environments enforce strict file system conventions; tools that write dotfiles in home root fail security reviews.

**Claude Code** — issue #1454 (73 reactions, closed): "Feature Request: Machine to Machine Authentication for Claude Max Subscriptions." Enterprise CI/CD pipelines need service account authentication, not OAuth flows requiring human interaction.

**Continue.dev** — issue #1173 (19 reactions): "Support OAuth 2.0 Authorization Code Flow." Enterprise identity providers (Okta, Azure AD, Entra ID) use OAuth — tools requiring plain API keys can't integrate with enterprise SSO.

**OpenHands** — PR #7754 "Add base_domain parameter for GitHub Enterprise support": Work underway but not complete for GitHub Enterprise and GitLab on-premises support.

**Cline** — issue #7714 (45 comments, closed): "Enterprise docs." High comment count on a docs-only issue signals enterprise users are actively trying to deploy Cline and running into undocumented friction.

**Aider** — issue #1085 (6 reactions, closed): "Adding default git config user.name, user.email is too aggressive." Aider modifies local git config without permission, violating enterprise git configuration governance policies.

### Forge Opportunity
Forge's explicit audit trail (what task, what agent, what changes, what tests passed) is enterprise-critical and completely absent from all competitors. The compliance story (every AI action logged and attributable to a human decision) is a greenfield opportunity. The governance analysis in `trick77/vibe-coding-enterprise-2026` reads like a requirements doc for enterprise Forge.

---

## Category 8: Multi-Agent

### Pattern
The concept of specialized agents working in parallel or in sequence is actively requested but nowhere implemented reliably. The most common pattern users describe: a "planner" agent designs the approach, multiple "worker" agents implement specific parts, and a "reviewer" agent checks the output. A newly identified pain point in this cycle: sub-agent costs are opaque and can spiral rapidly, and parallel agent output files are lost when context compacts.

### Key Issues

**Cline** — discussion "Use multiple models in the same task" (212 votes): The clearest articulation of the planner/executor split.

**Cline** — discussion #5582 "Feature Request: Support for Sub Agents" (6 reactions): Asking for hierarchical agent workflows where sub-agents handle specialized sub-tasks. An early-stage signal.

**Cline** — discussion #1007 "Multi-Agent Software Development with Cline" (20 votes): Coordinated multi-Cline-instance workflows for parallel feature development.

**Claude Code** — issue #6915 (378 reactions, closed): "Allow MCP tools to be available only to subagent." Even where subagents exist, tool isolation doesn't work — the main agent sees and uses subagent tools, wasting context and creating security concerns.

**Claude Code** — issue #4476 (183 reactions, closed): "Implement Agent-Scoped MCP Configuration with Strict Isolation." Same problem — MCP server configuration and tool visibility needs per-agent scoping.

**OpenAI Codex** — issue #3280 (7 upvotes, 5 comments): "Orchestration of multiple agents." Documents the core friction: manual context passing between agents (copy/pasting responses between sessions), agents unable to see cross-domain information (e.g., frontend agent needing backend contract details). Core request: agents should communicate directly "the same way human coders communicate inside a company." Closed as duplicate of "Subagent Support" discussion.

**OpenAI Codex** — issue #12488 (open): "Sub-agent costs are too high and too opaque." User reports being "$350 over Pro Plan for a week." Sub-agents multiply spending rapidly without clear visibility. Request: "a global session budget that hard-stops execution" before costs spiral, and "a post-run cost breakdown by sub-agent."

**Claude Code** — issue #23821 (open): "Subagent output files lost after context compaction." Parallel agent results disappear exactly when synthesis is needed, breaking the entire parallel research pattern.

**Aider** — issue #3781 (67 reactions, open): "Add tool-using NavigatorCoder (/navigator mode), akin to Claude Code." A community PR implementing a navigator agent orchestrating aider's capabilities. Unmerged despite 67 reactions.

**Aider** — issue #2672 (42 reactions, open): "Feature Request: Integration of LLM-Supported Tools and Function Calls in Aider." Aider doesn't support tool/function calling at all — a prerequisite for any multi-agent coordination.

**Google Gemini CLI** — issue #14963 "[Feat] Support parallel subagent execution": Tool call sequential execution prevents parallel sub-agent calls; implementing parallel changes would allow multiple agents in parallel.

### Forge Opportunity
Forge's multi-agent model (composer assigning tasks to specialized agents) is ahead of every scanned tool. The specific gaps Forge solves: task isolation, different models per agent, typed handoff between agents, cost attribution per sub-agent, and persisted outputs that survive context resets. The MCP tool isolation issue (claude-code #6915, 378 reactions) validates that users understand per-agent tool scoping and want it.

---

## Category 9: Onboarding and UX

### Pattern
First-run experience is poor across all tools. Users report confusion about what files to add to context, how configuration works, and why costs are high. The biggest UX problems are invisible progress, unexplained token consumption, and no guidance on workflow best practices. OpenHands has the most documented onboarding friction due to Docker complexity; aider has the best onboarding due to simple `pip install`.

### Key Issues

**Claude Code** — issue #516 (131 reactions, closed): "Always show available context percentage." Users can't see how much context is left; they hit limits unexpectedly.

**Claude Code** — issue #21151 (180 reactions, open): "No indication of WHICH file for READ tool." When the agent reads a file, the terminal output doesn't show which file — users can't track what the agent is doing.

**Claude Code** — issue #33819 (open): "Feature Request: Token/context usage display in VS Code extension status bar." Same visibility problem in the IDE integration.

**Claude Code** — issue #6814 (198 reactions, closed): "Turn off annoying progress messages." Verbose progress output obscures actual content; users want cleaner signal-to-noise.

**Claude Code** — issues #33074 and #33131 (open): "Resume last conversation session automatically on startup" and "Allow customizing the .claude/ directory location." Users need session continuity and configuration portability — neither exists natively.

**OpenHands** — issue #5878 (2 reactions): "Enhance on-boarding documentation & workflow for new users." Documents specific OpenHands friction: setup instructions "split across multiple documentation sections" leading to "unstable states"; missing Python package requirements; JWT secrets only in `config.toml` not environment variables; Docker fails silently when mount paths don't exist. Maintainers acknowledged the documentation site should suffice — users shouldn't need to reference code documentation.

**Aider** — issue #3104 (20 reactions, closed): "Add busy indicator / spinner / progress bar." Basic visual feedback that aider is working and not stuck.

**Aider** — issue #3030 (30 reactions, open): "Add a way to uninstall in your docs." Uninstallation is a frequent first question not covered in documentation.

**Cline** — issue #1157 (41 reactions, 86 comments, closed): "API Request loading indefinitely, not completing." New users frequently hit this; the lack of clear error messaging makes them think the tool is broken.

**Cline** — PR #7088 (38 comments): "feat: new onboarding flow." Active development on onboarding, showing the Cline team recognizes this gap.

**Continue.dev** — issue #1729 (30 reactions, open): "storing api keys in plain text." New users immediately concerned about security when they see API keys in a JSON file — undermines trust from first run.

**Aider** — issue #216 (77 reactions, open): "Config file location should follow 'modern' specifications." Aider writes dotfiles to home root instead of `~/.config/aider/`, cluttering home directories.

### Forge Opportunity
Forge's structured onboarding (adopting-forge.md, etc.) is a meaningful differentiator. The pattern across all tools: documentation is reactive (written after users ask questions) rather than proactive. Forge should provide a zero-to-first-task flow that is self-contained and doesn't require external reading.

---

## Category 10: Integration (CI/CD, Project Management, Communication Tools)

### Pattern
Developers want AI coding tools embedded in their existing workflows — triggered from CI failures, PR reviews, issue assignments — rather than requiring them to manually invoke the tool. This is an emerging category; requests are lower-volume relative to IDE/UX issues but growing as the tools mature. The ecosystem of community-built MCP servers for Jira, Linear, and GitHub Issues signals that users are solving this themselves, pointing to where native integration should go.

### Key Issues

**Claude Code** — issue #12925 (76 reactions, open): "Linear Integration: Assign issues to Claude Code to trigger cloud agent sessions." Most concrete integration request — assign a Linear ticket to @Claude, agent picks it up automatically with full issue context.

**Aider** — issue #3871 (17 reactions, open): "Feature: Get Aider to implement features from Jira tickets." A team built and wants to upstream a 5-command end-to-end Jira → code → PR workflow.

**Claude Code** — issue #1454 (73 reactions, closed): "Feature Request: Machine to Machine Authentication." Enterprise CI/CD pipelines need service account authentication, not OAuth flows requiring human interaction.

**OpenAI Codex** — issue #5085 (5 reactions, closed): "Cost Tracking & Usage Analytics." No way to set usage limits or track costs by project. Codex analytics dashboard implemented as resolution.

**OpenAI Codex** — issue #5372 "Remove 5h and weekly limits, instead have a monthly pool": Users want predictable monthly allocation over time-gated limits that interrupt workflows.

**SWE-agent** — issue #23 (6 reactions, closed): "SWE-agent as a GitHub action or bot." Early request for CI integration; subsequently implemented by the team.

**Continue.dev** — reusable GitHub Actions workflow PR (47 comments, closed): The team built a reusable GitHub Actions workflow, showing demand for CI integration.

**Claude Code** — issue #6686 (553 reactions, closed): "Feature Request: Add support for Agent Client Protocol (ACP)." Integration with the ACP standard for agent-to-agent and tool-to-agent communication — the protocol layer for future integrations.

**Aider** — issue #879 (24 reactions, open): "Enhancement: Only commit staged files if files have been staged." Basic git workflow friction — aider doesn't respect staged files, breaking integration with pre-commit hooks and standard review workflows.

**Community ecosystem**: Multiple independent GitHub repos have been built to address the MCP integration gap: `tom28881/mcp-jira-server`, `MankowskiNick/jira-mcp`, `SpillwaveSolutions/jira` (Claude Skill For JIRA), Linear MCP integrations. Volume of independent solutions confirms demand is real and unmet natively.

### Forge Opportunity
Forge's integration model (tasks triggered by external events, results written back to issue trackers) is the direction the entire ecosystem is moving toward but hasn't arrived at yet. The Linear integration request (76 reactions) is a direct validation of Forge's task-trigger concept. Forge should have a first-class webhook/integration layer so teams can assign tickets that automatically become Forge tasks.

---

## Cross-Cutting Observations

### 1. The AGENTS.md Moment
The AGENTS.md issue in claude-code (4,342 reactions, 7+ months open, zero official response) is the most-reacted single issue across all repos. It signals an ecosystem-level shift: developers want their AI coding configuration to be **tool-agnostic**. The standard is stewarded by the Linux Foundation, used by 60,000+ GitHub projects, and adopted by every major competitor except Claude Code. Any tool that reads AGENTS.md gains instant adoption credibility. Forge should have an explicit AGENTS.md compatibility story.

### 2. The Cost Spiral Is a Real and Growing Problem
Across all tools, users report AI tools consuming tokens unexpectedly and running up costs without visible progress. Cline's file editing infinite retry loops, Claude Code's opaque context compaction, and codex's sub-agent cost explosions ($350 overages reported) all contribute to cost unpredictability. Users want: (a) token budget controls with hard stops, (b) cost attribution by task/subagent, (c) interruption without losing progress. Forge's task graph approach naturally scopes cost to individual tasks with clear boundaries.

### 3. Quality Verification Is Absent Everywhere
Not a single tool enforces "the code must pass tests before marking complete." The closest is aider's `--auto-test` flag which is underdocumented. Claude Code's "task fraud" issue (82 reactions) demonstrates that without automated verification, AI tools will claim success without evidence. This is a solvable problem and an unoccupied competitive position. Forge's verification gate is the most important differentiator that doesn't exist anywhere in the current ecosystem.

### 4. Session Continuity Is a Universal Failure
Context loss is not just an individual-task problem — it's a multi-session, multi-week problem. Developers report "institutional knowledge decay" across 50+ sessions, with repeated mistakes and re-covered ground. Three separate issues in claude-code alone (#11455, #14227, #18401) address this. Third-party tools (Stato, Mantra) have emerged specifically to fill this gap. Forge's task graph inherently preserves cross-session state at the task level.

### 5. IDE Fragmentation Is the #1 Adoption Blocker by Raw Volume
By raw reaction count, IDE expansion (JetBrains: 1,193 votes in Cline discussions alone; Neovim: 244 reactions in continue.dev; Vim/Emacs: 97 votes in Cline) dominates all other categories. Tools that are only VS Code-native are excluded from a large share of the developer market. Forge's CLI-first approach sidesteps this entirely — it works in any editor environment.

### 6. The Orchestration Gap Is Massive and Real
No tool today handles: multi-step task queues, parallel agent execution, progress preservation across context resets, or integration with external triggers. This is Forge's entire value proposition, and the data confirms it is unoccupied territory with clear demand signals (Cline discussions: 212 votes for multi-model; Aider #3781: 67 reactions for navigator mode; Claude Code #12925: 76 reactions for Linear integration; Codex #3280: direct agent-to-agent communication request).

### 7. Team Features Have Low Reaction Counts But High Strategic Value
Team/collaboration features have relatively low reaction counts because the current user base is overwhelmingly individual developers. This is a leading indicator, not a lagging one — enterprise teams are evaluating these tools now, and the features they need (shared config, audit trails, cost controls) don't exist anywhere. The `trick77/vibe-coding-enterprise-2026` document is a market readiness signal: enterprises are aware of the problem and waiting for a solution. First-mover advantage in enterprise AI dev tooling is available.

### 8. Multi-Agent Cost Opacity Is an Emerging Crisis
As multi-agent usage grows, cost explodes in ways users don't anticipate. Codex issue #12488 ($350 overage from sub-agents) and SWE-agent issue #1285 (provider-agnostic model registry with cost governance) both document a pattern: multi-agent systems need per-agent cost tracking and hard budget limits or they become commercially unviable. Forge's task-scoped billing model (each task has a defined scope) is an architectural advantage over session-scoped tools.

---

## Appendix: Issue Reference Table

### claude-code (anthropics/claude-code)

| # | Title | State | Reactions |
|---|-------|-------|-----------|
| 6235 | Feature Request: Support AGENTS.md | Open | 4,342 |
| 17118 | Support for OpenCode and Max plan | Closed | 1,418 |
| 3382 | Claude says "You're absolutely right!" about everything | Closed | 1,376 |
| 826 | Console scrolling to top when Claude adds text | Open | 726 |
| 6686 | Feature Request: Add support for Agent Client Protocol (ACP) | Closed | 553 |
| 6915 | Allow MCP tools to be available only to subagent | Closed | 378 |
| 2511 | Feature request: Connect Claude code to Claude projects | Open | 365 |
| 1455 | Claude Code does not respect XDG Base Directory specification | Open | 310 |
| 7328 | MCP Tool Filtering: Allow Selective Enable/Disable | Closed | 224 |
| 6814 | Turn off annoying progress messages | Closed | 198 |
| 21151 | No indication of WHICH file for READ tool | Open | 180 |
| 353 | Undo/Checkpoint Feature for Correcting AI-Generated Code | Closed | 178 |
| 4476 | Implement Agent-Scoped MCP Configuration | Closed | 183 |
| 516 | Always show available context percentage | Closed | 131 |
| 5644 | Feature Request: Enable 1M Context Window for Claude Code | Open | 140 |
| 5320 | Claude 4.1 Opus Committed Deliberate Task Fraud | Closed | 82 |
| 1454 | Machine to Machine Authentication for Claude Max | Closed | 73 |
| 12925 | Linear Integration: trigger sessions from issue assignment | Open | 76 |
| 17428 | Enhanced /compact with file-backed summaries | Open | 102 |
| 7075 | Claude Code profiles with isolated memory, commands, hooks | Open | 44 |
| 2544 | CLAUDE.md Mandatory Rules Consistently Ignored | Open | 42 |
| 14200 | Add rules support to Plugins | Open | 46 |
| 18417 | Native session persistence and context continuity | Open | 6 |
| 23821 | Subagent output files lost after context compaction | Open | — |
| 31005 | Support AGENTS.md and .agents/skills/ | Open | 47 |
| 31532 | Visual Testing and Interaction for Claude Code | Open | 1 |
| 33074 | Resume last conversation session automatically on startup | Open | — |
| 33819 | Token/context usage display in VS Code extension status bar | Open | — |

### aider (paul-gauthier/aider → Aider-AI/aider)

| # | Title | State | Reactions |
|---|-------|-------|-----------|
| 3314 | MCP SUPPORT | Open | 238 |
| 3937 | Add MCP Support with LiteLLM (PR) | Closed | 226 |
| 2525 | Please add support for model context protocol | Open | 139 |
| 2227 | Feature: Add GitHub Copilot as model provider | Open | 119 |
| 3672 | Add MCP support (PR) | Closed | 83 |
| 216 | Config file location should follow modern specifications | Open | 77 |
| 3781 | Add tool-using NavigatorCoder (/navigator mode) (PR) | Open | 67 |
| 3362 | Inspiration From Claude Code | Open | 57 |
| 68 | Feature request: vscode extension | Open | 56 |
| 2672 | Feature Request: Integration of LLM-Supported Tools and Function Calls | Open | 42 |
| 649 | Add option to force AI to ask user to confirm each change | Open | 40 |
| 483 | PyCharm Support | Open | 40 |
| 3303 | Feature suggestion: implement Cursor Rules support | Open | 37 |
| 3030 | Add a way to uninstall in your docs | Open | 30 |
| 1005 | Add ability to add documentation for larger projects | Open | 28 |
| 879 | Enhancement: Only commit staged files if files have been staged | Open | 24 |
| 3871 | Feature: Get Aider to implement features from Jira tickets | Open | 17 |
| 3153 | Allow discussion with architect before accepting | Open | 13 |
| 723 | Feature Request: Review Mode with Checklist for Aider | Open | 13 |
| 1814 | Plugin architecture for aider | Open | 11 |
| 2754 | FEATURE REQUEST: WEB SEARCH INTEGRATION | Open | 14 |
| 543 | Allow running commands: compilation, running test cases | Closed | discussed |
| 1355 | Support for Structured Questions and Responses in Scripted Aider | Open | — |
| 4882 | Sandboxed test execution via exec-sandbox | Open | — |

### cline (cline/cline)

| # | Title | State | Reactions |
|---|-------|-------|-----------|
| 3510 | Licensing Conflict: Apache 2.0 vs Terms of Service | Closed | 87 |
| 1972 | Cline 3.7 NOT Working with Copilot integration | Closed | 83 |
| 63 | Other IDE support (JetBrains, VS2022, etc) | Closed | 69 |
| 3413 | feat: support streameable http transport | Closed | 47 |
| 3528 | Collapsible Panel for MCP Responses | Closed | 43 |
| 1157 | API Request loading indefinitely, not completing | Closed | 41 |
| 5405 | feat: Add AGENTS.md external instructions support | Closed | 37 |
| 1959 | MCP servers: no way to see logs | Closed | 34 |
| 4356 | Improve Terminal Integration Reliability | Open | 29 |
| 2175 | Diff Edit Mismatch | Closed | 29 |
| 4523 | MCP servers are not allowed to use oauth | Open | 17 |
| 4384 | Fix File Editing Tool Reliability | Open | 10 |
| 4389 | Improve Context Window Management and Large File Handling | Open | 6 |
| 7112 | Adding Request Queuing | Open | — |
| 8870 | Cline routinely fails to follow complex workflows correctly | Open | — |
| 9278 | use_subagents tool fails with HTTP 400 when extended thinking enabled | Open | — |
| Disc. 3226 | Evolving Cline into Universal Code Orchestrator Workbench | Discussion | — |
| Disc. 5912 | LLM Workflow Specification: .workflow Format | Discussion | — |
| Disc. 5582 | Feature Request: Support for Sub Agents | Discussion | 6 |
| Disc. | JetBrains plugin request | Discussion | 1,193 votes |
| Disc. | Use multiple models in the same task | Discussion | 212 votes |
| Disc. | Zed extension | Discussion | 158 votes |
| Disc. | Tab Autocomplete | Discussion | 123 votes |
| Disc. | Allow claude to return diffs instead of whole code | Discussion | 103 votes |
| Disc. | Auto Approve Mode | Discussion | 84 votes |
| Disc. | Add RAG Support for Enhanced Codebase Understanding | Discussion | 38 votes |
| Disc. | Expose API/CLI for Remote Control | Discussion | 37 votes |

### continue.dev (continuedev/continue)

| # | Title | State | Reactions |
|---|-------|-------|-----------|
| 917 | Neovim support needed | Open | 244 |
| 759 | Visual Studio (not Code) Continue extension? | Open | 111 |
| 1889 | Continue on Zed | Closed | 57 |
| 1424 | Auto Generate Commit Messages | Open | 51 |
| 758 | Tab Autocomplete | Closed | 51 |
| 1729 | storing api keys in plain text | Open | 30 |
| 3832 | Support `<think />` tags from R1 | Closed | 29 |
| 3768 | Feature Request: Automatic File Creation/Editing | Open | 26 |
| 1440 | Support Sublime Text | Open | 24 |
| 6716 | Add Support for AGENTS.md | Closed | 17 |
| 8085 | JetBrains Sidebar panel frequently freezes | Open | 17 |
| 4615 | Implement Memory Bank for Enhanced Context Management | Open | 6 |
| 8290 | How to create a multi user input prompt in continue? | Open | — |
| 4691 | Multi code-server share the Continue history | Open | — |
| 1173 | Support OAuth 2.0 Authorization Code Flow | Open | 19 |

### openai/codex

| # | Title | State | Reactions |
|---|-------|-------|-----------|
| 3280 | Orchestration of multiple agents | Closed (dup) | 7 |
| 5085 | Cost Tracking & Usage Analytics | Closed | 5 |
| 5372 | Remove 5h and weekly limits, instead have monthly pool | Open | — |
| 12488 | Sub-agent costs are too high and too opaque | Open | 1 |
| 13195 | Codex as an App on ChatGPT | Open | — |
| 14073 | Feature Request: Version Control for Codex Threads | Open | — |

### All-Hands-AI/OpenHands

| # | Title | State | Notes |
|---|-------|-------|-------|
| 6180 | Add support for multiple LLMs simultaneously for team-level automation | Open | — |
| 6864 | Cannot run OpenHands on Kubernetes cluster | Open | — |
| 5191 | Publicize feature development plans for future versions | Closed | — |
| 5878 | Enhance on-boarding documentation & workflow for new users | Open | 2 reactions |
| 4951 | Prevent OpenHands from crashing at 200k context | Open | — |
| 6468 | Add GitHub Copilot provider | Open | — |
| 7175 | Context window "resets" to earlier points rather than later | Open | — |
| 6634 | Trimming prompt message being passed to LLM, causing agent to change actions | Open | — |
| 7575 | First-class CLI mode | Open | — |
| PR 7754 | Add base_domain parameter for GitHub Enterprise support | Merged | — |

### SWE-agent/SWE-agent

| # | Title | State | Reactions |
|---|-------|-------|-----------|
| 1285 | Provider-agnostic Model Registry with Budget, Rate Limits, and Fallback Routing | Open | 0 |
| 23 | SWE-agent as a GitHub action or bot | Closed | 6 |
| 57 | Apply fix to local repository instead of opening PR | Closed | 7 |
| 303 | Better support for local models (mini-swe-agent) | Open | — |

### geekan/MetaGPT

| # | Title | State | Notes |
|---|-------|-------|-------|
| 1436 | Question, how to resume a project? | Open | Resume after partial failure |

---

*Research conducted 2026-03-18. Reaction counts reflect GitHub state at time of research. Issues marked "closed" may have been resolved or closed as out-of-scope. Reaction counts of "—" indicate the issue was found but reactions were not visible at time of fetch.*
