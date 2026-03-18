# Platform Smoke Tests — v0.5.0

Test each platform to verify Forge loads and basic skill invocation works.
Results feed into v0.5.1 or v1.0 fixes.

## Test Protocol

For each platform:
1. Install Forge per the platform's install docs
2. Open a new session in any project directory
3. Say: "I'd like to start a new feature"
4. Verify: forge-routing triggers → brainstorming skill loads
5. Record result

## Results

| Platform | Installed? | Skills Load? | Routing Works? | Notes |
|----------|-----------|-------------|----------------|-------|
| Claude Code | ✅ | ✅ | ✅ | Primary dogfood platform |
| Cursor | | | | |
| Codex | | | | |
| OpenCode | | | | |
| Gemini CLI | | | | |

## Known Limitations (to be discovered)

| Platform | Limitation | Impact |
|----------|-----------|--------|
| | | |

## Test Date

**Tested by:**
**Date:**
**Forge version:** 0.5.0
