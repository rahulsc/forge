# Conventions

> Agents read this before writing code, naming things, or creating commits.

## Naming

- **Skill directories:** kebab-case (`systematic-debugging/`, `writing-plans/`)
- **Skill files:** Always `SKILL.md` inside the skill directory
- **Agent definitions:** kebab-case markdown (`frontend-engineer.md`, `code-reviewer.md`)
- **Hook scripts:** kebab-case, no extension (`forge-session-start`, `pre-commit-gate`)
- **CLI tools:** kebab-case (`classify-risk`, `forge-state`, `forge-evidence`)
- **Design docs:** `docs/<project>/design/design.md`
- **Plans:** `docs/<project>/plans/plan.md`
- **Config files:** kebab-case YAML (`policies/default.yaml`)

## Style

- **Shell scripts:** Use `#!/usr/bin/env bash` shebang. Use `set -euo pipefail`. Quote all variables. Use `local` for function variables.
- **Skill SKILL.md files:** Structured with sections, tables, and dot/mermaid diagrams where helpful. Include process flow, integration notes, and state contracts.
- **Agent definitions:** Frontmatter with `description`, `model`, and tool list. System prompt body defines role, responsibilities, and quality standards.
- **No compiled code:** Forge is shell scripts + markdown. No TypeScript, Python, Go, or other compiled/interpreted languages in the product itself.
- **YAGNI:** Do not add features, abstractions, or configurability beyond what is directly needed. Three similar lines of code are better than a premature abstraction.

## Testing

- **Test directories:** `tests/<category>/` (e.g., `tests/forge-skills/`, `tests/forge-state/`, `tests/integration/`)
- **Test scripts:** Shell scripts that assert behavior. Exit 0 on pass, non-zero on fail.
- **Integration tests:** Run real Claude Code sessions with actual skill invocation. Documented in `docs/testing.md`.
- **Prompt fixtures:** Test prompts in `tests/skill-triggering/prompts/` to verify skill auto-triggering.
- **Pressure tests:** Edge case scenarios in `tests/pressure-tests/` (sunk cost, false green, production emergency, etc.)

## Commit Conventions

- **Format:** `type: short description` (lowercase, no period)
- **Types:** `feat`, `fix`, `chore`, `docs`, `test`, `refactor`
- **Body:** Explain WHY, not WHAT. The diff shows what.
- **Co-author:** Include `Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>` when AI-assisted.
- **No tags for now.** Versions tracked in plugin manifests only.

## Branch and PR Conventions

- **Main branch:** `main` — direct pushes during Beta development (no external users yet)
- **Backup branches:** Create baseline branches before major structural changes (e.g., `forge-v0.1.1-baseline`)
- **No PRs required during solo dogfooding.** PRs will be required once external contributors exist.

## Project-Specific Rules

- **`.forge/` separation:** `.forge/` contains only project-specific config when used in a repo. Product artifacts (`bin/`, `policies/`, `adapters/`, etc.) will move to top-level in v0.2.0.
- **Design docs are immutable:** Once approved, `design.md` files are not overwritten by later skills. Changes go through a new design iteration.
- **Deviation logging:** During Beta development, log all workflow deviations in the design doc's Appendix G worklog.
- **Security:** Avoid sending sensitive files (`.env`, credentials, keys) to LLM context. Warn users before scanning repos.
