# Installing Forge for Codex

Enable forge skills in Codex via native skill discovery. Just clone and symlink.

## Prerequisites

- Git

## Installation

1. **Clone the forge repository:**
   ```bash
   git clone https://github.com/rahulsc/forge.git ~/.codex/forge
   ```

2. **Create the skills symlink:**
   ```bash
   mkdir -p ~/.agents/skills
   ln -s ~/.codex/forge/skills ~/.agents/skills/forge
   ```

   **Windows (PowerShell):**
   ```powershell
   New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
   cmd /c mklink /J "$env:USERPROFILE\.agents\skills\forge" "$env:USERPROFILE\.codex\forge\skills"
   ```

3. **Restart Codex** (quit and relaunch the CLI) to discover the skills.

## Migrating from old bootstrap

If you installed forge before native skill discovery, you need to:

1. **Update the repo:**
   ```bash
   cd ~/.codex/forge && git pull
   ```

2. **Create the skills symlink** (step 2 above) -- this is the new discovery mechanism.

3. **Remove the old bootstrap block** from `~/.codex/AGENTS.md` -- any block referencing `forge-codex bootstrap` is no longer needed.

4. **Restart Codex.**

## Verify Installation

After installing, verify Forge is working:

1. Open a new session in Codex
2. Say: "I'd like to start a new feature"
3. You should see Forge activate with: "I'm using the brainstorming skill to explore and design before implementing."

If Forge doesn't activate:
- Check that the skills symlink is in place (see below)
- Restart your Codex session
- See Troubleshooting below

**Check symlink:**
```bash
ls -la ~/.agents/skills/forge
```

You should see a symlink (or junction on Windows) pointing to your forge skills directory.

## Updating

```bash
cd ~/.codex/forge && git pull
```

Skills update instantly through the symlink.

## Uninstalling

```bash
rm ~/.agents/skills/forge
```

Optionally delete the clone: `rm -rf ~/.codex/forge`.

## Troubleshooting

### Forge skills don't activate
- Verify the symlink is in place: `ls -la ~/.agents/skills/forge`
- Restart your session — skills are discovered at Codex startup
- Try explicitly: "Use the forge:brainstorming skill" to test direct invocation

### Permission errors on hook scripts
- Ensure hook scripts are executable: `chmod +x hooks/*`
- Check your Codex hook configuration in `~/.codex/`

### State initialization failures
- Forge stores state in `.forge/local/` — ensure the directory exists
- Try running: `bin/forge-state init --project-dir .`
- If sqlite3 is not available, Forge falls back to JSON storage automatically

### Skills not showing up after install
- Verify the symlink: `ls -la ~/.agents/skills/forge`
- Check skills exist in the clone: `ls ~/.codex/forge/skills`
- Restart Codex — skills are discovered at startup

### Windows junction issues
- Junctions normally work without special permissions
- If creation fails, try running PowerShell as Administrator
