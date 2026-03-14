# Installing Forge for OpenCode

## Prerequisites

- [OpenCode.ai](https://opencode.ai) installed
- Git installed

## Installation Steps

### 1. Clone Forge

```bash
git clone https://github.com/rahulsc/forge.git ~/.config/opencode/forge
```

### 2. Register the Plugin

Create a symlink so OpenCode discovers the plugin:

```bash
mkdir -p ~/.config/opencode/plugins
rm -f ~/.config/opencode/plugins/forge.js
ln -s ~/.config/opencode/forge/.opencode/plugins/forge.js ~/.config/opencode/plugins/forge.js
```

### 3. Symlink Skills

Create a symlink so OpenCode's native skill tool discovers forge skills:

```bash
mkdir -p ~/.config/opencode/skills
rm -rf ~/.config/opencode/skills/forge
ln -s ~/.config/opencode/forge/skills ~/.config/opencode/skills/forge
```

### 4. Restart OpenCode

Restart OpenCode. The plugin will automatically inject forge context.

## Verify Installation

After installing, verify Forge is working:

1. Open a new session in OpenCode
2. Say: "I'd like to start a new feature"
3. You should see Forge activate with: "I'm using the brainstorming skill to explore and design before implementing."

If Forge doesn't activate:
- Check that the plugin and skills symlinks are in place (see below)
- Restart your OpenCode session
- See Troubleshooting below

**Check symlinks:**
```bash
ls -l ~/.config/opencode/plugins/forge.js
ls -l ~/.config/opencode/skills/forge
```

## Usage

### Finding Skills

Use OpenCode's native `skill` tool to list available skills:

```
use skill tool to list skills
```

### Loading a Skill

Use OpenCode's native `skill` tool to load a specific skill:

```
use skill tool to load forge/brainstorming
```

### Personal Skills

Create your own skills in `~/.config/opencode/skills/`:

```bash
mkdir -p ~/.config/opencode/skills/my-skill
```

Create `~/.config/opencode/skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: Use when [condition] - [what it does]
---

# My Skill

[Your skill content here]
```

### Project Skills

Create project-specific skills in `.opencode/skills/` within your project.

**Skill Priority:** Project skills > Personal skills > Forge skills

## Updating

```bash
cd ~/.config/opencode/forge
git pull
```

## Troubleshooting

### Forge skills don't activate
- Verify the plugin is installed: check `ls -l ~/.config/opencode/plugins/forge.js`
- Restart your session — hooks initialize on session start
- Try explicitly: "Use the forge:brainstorming skill" to test direct invocation

### Plugin not loading
1. Check plugin symlink: `ls -l ~/.config/opencode/plugins/forge.js`
2. Check source exists: `ls ~/.config/opencode/forge/.opencode/plugins/forge.js`
3. Check OpenCode logs for errors

### Skills not found
1. Check skills symlink: `ls -l ~/.config/opencode/skills/forge`
2. Verify it points to: `~/.config/opencode/forge/skills`
3. Use `skill` tool to list what's discovered

### Permission errors on hook scripts
- Ensure hook scripts are executable: `chmod +x hooks/*`
- Check your OpenCode plugin configuration at `~/.config/opencode/`

### State initialization failures
- Forge stores state in `.forge/local/` — ensure the directory exists
- Try running: `bin/forge-state init --project-dir .`
- If sqlite3 is not available, Forge falls back to JSON storage automatically

### Plugin not detected
- Ensure your clone path is correct: `~/.config/opencode/forge`
- Check that the plugin manifest exists: `ls ~/.config/opencode/forge/.opencode/plugins/forge.js`
- Re-run the install commands (steps 2 and 3)

### Tool mapping

When skills reference Claude Code tools:
- `TodoWrite` → `todowrite`
- `Task` with subagents → `@mention` syntax
- `Skill` tool → OpenCode's native `skill` tool
- File operations → your native tools

## Getting Help

- Report issues: https://github.com/rahulsc/forge/issues
- Full documentation: https://github.com/rahulsc/forge/blob/main/docs/README.opencode.md
