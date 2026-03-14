# Task 6: Platform Install Docs Update

**Specialist:** implementer (documentation)
**Depends on:** Task 3 (restructure — paths must be final)
**Produces:** Updated platform-specific install docs with correct paths, verify prompts, and troubleshooting

## Goal

Update all platform-specific installation documents to reflect the post-restructure project layout, add verification prompts, and add troubleshooting guidance.

## Acceptance Criteria

- [ ] `.codex/INSTALL.md` uses correct repo URLs and file paths
- [ ] `.opencode/INSTALL.md` uses correct repo URLs and file paths
- [ ] `docs/README.codex.md` uses correct repo URLs and file paths
- [ ] `docs/README.opencode.md` uses correct repo URLs and file paths
- [ ] Each install doc includes a "Verify Installation" section with a specific test prompt
- [ ] Each install doc includes a "Troubleshooting" section with 3+ common issues
- [ ] All clone URLs point to `rahulsc/forge.git`
- [ ] All support/issues links point to `rahulsc/forge`
- [ ] File path references match post-restructure layout

## Test Expectations

- **Test:** grep for `rahulsc/superpowers` in install docs returns zero matches
- **Expected red failure:** install docs contain old repo URLs (fixed in Task 1, but verify post-restructure paths are also correct)
- **Expected green:** all URLs point to `rahulsc/forge`

- **Test:** each install doc contains "Verify Installation" section
- **Expected red failure:** section header not found
- **Expected green:** all 4 docs contain the section

- **Test:** each install doc contains "Troubleshooting" section
- **Expected red failure:** section header not found
- **Expected green:** all 4 docs contain the section

## Files

- Modify: `.codex/INSTALL.md`
- Modify: `.opencode/INSTALL.md`
- Modify: `docs/README.codex.md`
- Modify: `docs/README.opencode.md`

## Implementation Notes

- Task 1 (identity cleanup) will have already fixed the repo URLs. This task focuses on:
  1. Verifying paths match post-restructure layout (bin/ not .forge/bin/, etc.)
  2. Adding verify installation sections
  3. Adding troubleshooting sections
- Verify prompt for each platform should be something like: "I'd like to start a new feature" — the user should see forge-routing activate
- Common troubleshooting items:
  1. Plugin not detected (hooks not loading)
  2. Skills not triggering (routing not working)
  3. Permission errors on hook scripts
  4. State initialization failures
- Keep platform-specific docs concise. The main README is the comprehensive guide; these are install-and-verify only.

## Commit

`docs: update platform install docs with verify prompts and troubleshooting`
