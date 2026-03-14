# Task 6: Update Forge-Routing Skill

**Specialist:** forge-author
**Depends on:** Task 4 (adopting-forge must be updated so routing can reference it correctly)
**Produces:** Updated forge-routing with resume, release, and ambiguous intent handling
**Complexity:** standard

## Goal

All 8 public workflows route correctly, including resume work and prepare release which are currently unrouted.

## Acceptance Criteria

- [ ] Routing table includes "resume" intent signals: session start with existing forge-state, "where was I?", "continue"
- [ ] Routing table includes "release" intent signals: "ship it", "cut a release", "prepare release", "tag a version"
- [ ] Ambiguous intent handling: when multiple workflows could match, ask the user instead of guessing
- [ ] All 8 workflows from the README are represented in the routing table
- [ ] Resume route checks `forge-state get phase` and offers to continue from last state

## Test Expectations

- **Test:** grep for "resume" in forge-routing intent detection table
- **Expected red failure:** no resume route
- **Expected green:** resume route with signals listed

- **Test:** grep for "release" or "ship" in forge-routing intent detection table
- **Expected red failure:** no release route
- **Expected green:** release route with signals listed

- **Test:** grep for "ambiguous" in forge-routing SKILL.md
- **Expected red failure:** no ambiguous intent handling
- **Expected green:** ambiguous handling documented

## Files

- Modify: `skills/forge-routing/SKILL.md` (intent detection table, routing logic)

## Implementation Notes

Current routing table has 6 intents: feature, bug, refactor, adoption, diagnosis, sync. Add:

**Resume work:**
```
| Resume | "where was I", "continue", "resume", session with existing forge-state | Check `forge-state get phase`; if executing, offer to resume at current wave |
```

**Prepare release:**
```
| Release | "ship it", "cut a release", "prepare release", "tag", "version bump" | `forge:verification-before-completion` → `forge:finishing-a-development-branch` |
```

**Ambiguous intent:**
Add a section after the routing table:
```
When intent is ambiguous (user says something that could match multiple workflows):
- Do NOT guess. Ask the user which workflow they intend.
- Present the top 2-3 matching workflows with one-line descriptions.
- Example: "That could be a new feature or a refactor. Which workflow fits better?"
```

Also update the Risk-Aware Routing section to reference all 8 workflows.

## Commit

`feat: add resume and release routes, ambiguous intent handling to forge-routing`
