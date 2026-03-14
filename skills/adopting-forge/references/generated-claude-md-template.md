# Generated File Templates

Templates used by `adopting-forge` when creating or appending AI surface files.
All generated content uses **managed blocks** (`<!-- forge:begin/end -->`) so that
`forge sync` can regenerate without touching user-written content.


## CLAUDE.md — Forge Managed Block

When `CLAUDE.md` already exists, find `<!-- forge:begin -->` / `<!-- forge:end -->`
markers and replace the content between them. If no markers exist, append the block
at the end. Never modify or remove content outside the markers.

When no `CLAUDE.md` exists, create a new file containing only this block.

~~~markdown
<!-- forge:begin — DO NOT EDIT THIS BLOCK. Run `forge sync` to regenerate. -->

## Forge

This project uses [Forge](https://github.com/rahulsc/forge) for structured AI-assisted development.

### Project
- **Name:** <repo-name>
- **Stack:** <stack>
- **Package manager:** <package-manager>

### Commands
- **Test:** `<test-cmd>`
- **Lint:** `<lint-cmd>`

### Risk Policy
High-risk paths requiring elevated review:
- `auth/**` — critical
- `db/migrations/**` — critical
- `src/**` — standard
- `docs/**` — minimal

### Workflow
Forge enforces: design → plan → TDD → implement → verify → review.

### State and Evidence

```bash
forge-state get <key>              # read project state
forge-state set <key> <value>      # write project state
forge-evidence add <task-id> <artifact>   # record evidence
forge-gate check <gate-name>       # check lifecycle gate
```

### Tools Location

```bash
export PATH=".forge/bin:$PATH"
```

<!-- forge:end -->
~~~


## AGENTS.md — Forge Managed Block

Same managed-block strategy as CLAUDE.md. When `AGENTS.md` exists, replace content
between markers (or append if no markers). When it does not exist, create with this block.

~~~markdown
<!-- forge:begin — DO NOT EDIT THIS BLOCK. Run `forge sync` to regenerate. -->

## Forge Agents

| Agent | Role | When Used |
|-------|------|-----------|
| architect | System design, API design | Architecture decisions |
| implementer | Feature implementation | Writing code following TDD |
| qa-engineer | Test design, coverage | Pipelined TDD, test quality |
| code-reviewer | Code quality review | Post-implementation review |
| security-reviewer | Vulnerability assessment | Critical-tier security audit |
| forge-author | Skill/agent authoring | Writing and editing Forge skills |
| frontend-engineer | UI development | Frontend tasks, accessibility |
| backend-engineer | API development | Backend tasks, data access |
| database-specialist | Schema, migrations | Database changes, migration review |
| devops-engineer | CI/CD, infrastructure | Deployment, pipeline review |

<!-- forge:end -->
~~~


## Substitution Variables

When generating from these templates, replace:

| Placeholder | Source |
|-------------|--------|
| `<repo-name>` | directory name of repo root |
| `<stack>` | detected from stack-detection heuristics |
| `<package-manager>` | detected package manager (npm, yarn, pip, cargo, etc.) |
| `<test-cmd>` | detected test command |
| `<lint-cmd>` | detected lint command |

Omit lines with undetected values rather than leaving placeholders in the output.
