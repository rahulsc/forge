# ADR 001: Move Product Artifacts to Top-Level Directories

## Status
Accepted (2026-03-14)

## Context
Product infrastructure (bin tools, default policies, adapters, workflows, packs) was nested inside `.forge/`, mixing it with per-project configuration. This conflicted with the existing pattern where `agents/`, `skills/`, `hooks/` are already at the top level.

## Decision
Move all product artifacts to top-level directories: `bin/`, `policies/`, `adapters/`, `workflows/`, `packs/`, `templates/`. The `.forge/` directory now contains only per-project configuration (project.yaml, shared/, local/).

## Consequences
- `.forge/` means exactly one thing: "this project's Forge configuration"
- Product artifacts follow the same pattern as agents/, skills/, hooks/
- All skills, hooks, tests, and bin tools updated for new paths
- Templates directory provides blank scaffolding for new project adoption
