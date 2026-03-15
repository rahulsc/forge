# Mono-Repo / Multi-Project .forge/ Resolution Notes

**Date:** 2026-03-15
**Context:** Discovered during v0.4.1 reference project infrastructure design
**Status:** Notes for v1.0 brainstorming

## How .forge/ Resolution Works

The `forge-session-start` hook resolves the project directory using this logic:

1. Check `FORGE_PROJECT_DIR` env var — if set, use it
2. Check `pwd` for `.forge/project.yaml` — if found, use it
3. Walk UP the directory tree from `pwd` until `.forge/project.yaml` is found
4. If nothing found, exit gracefully (not a Forge project)

This means **the nearest `.forge/project.yaml` wins**. Subfolder projects shadow parent projects automatically.

## Mono-Repo Pattern

```
my-mono-repo/
  .forge/project.yaml          ← root-level Forge config (for repo-wide work)
  services/
    api/
      .forge/project.yaml      ← api service config (independent state)
    web/
      .forge/project.yaml      ← web frontend config (independent state)
  packages/
    shared/
      .forge/project.yaml      ← shared library config
```

When working at repo root: root .forge/ is active.
When cd'd into `services/api/`: api's .forge/ takes over — independent state, policies, risk tiers.

## What This Enables

- Independent risk classification per service
- Independent state/phase per service (one service in planning, another in execution)
- Shared skills/agents/hooks from the repo root (plugin installed once)
- Per-service audit trails in each `.forge/local/audit/`
- Per-service policies (e.g., `services/api/.forge/policies/` can override root defaults)

## What Needs v1.0 Work

1. **Policy inheritance** — should a subfolder project inherit the root's policies? Currently it only uses its own. May want a merge strategy.
2. **Cross-project awareness** — if working on service A, should Forge know about service B's architecture? Currently each .forge/ is isolated.
3. **Shared conventions** — mono-repos often have repo-wide conventions (commit format, CI). Currently each .forge/shared/conventions.md is independent.
4. **forge adopt for mono-repos** — should `forge adopt` detect it's inside a mono-repo and offer to set up per-service .forge/ directories?
5. **forge doctor for mono-repos** — should it validate all .forge/ directories, not just the nearest one?

## Validated By

Reference project infrastructure in v0.4.1 — 6 projects coexist under `reference-projects/` with independent `.forge/project.yaml` files, while the repo root maintains its own `.forge/` for Forge development.
