#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$HOME/Projects/forge-ref-projects/deploy-pipeline"
FORGE_VERSION="${1:-unknown}"
RUN_DATE=$(date +%Y-%m-%d)

echo "# Reference Project Run: deploy-pipeline"
echo "**Date:** $RUN_DATE"
echo "**Forge version:** $FORGE_VERSION"
echo ""

if [ ! -d "$PROJECT_DIR" ]; then
  echo "Project directory not found: $PROJECT_DIR"
  exit 1
fi

cd "$PROJECT_DIR"

# Build/test check
echo "## Build & Tests"
if [ -f package.json ]; then
  if npm test 2>&1; then echo "**Tests:** PASS"; else echo "**Tests:** FAIL"; fi
elif [ -f pyproject.toml ] || [ -f requirements.txt ]; then
  if pytest 2>&1; then echo "**Tests:** PASS"; else echo "**Tests:** FAIL"; fi
elif [ -f go.mod ]; then
  if go test ./... 2>&1; then echo "**Tests:** PASS"; else echo "**Tests:** FAIL"; fi
fi

# Git stats
echo ""
echo "## Git Stats"
echo "- Commits: $(git rev-list --count HEAD 2>/dev/null || echo 0)"
echo "- Files: $(git ls-files 2>/dev/null | wc -l)"

# Audit data
if [ -d .forge/local/audit ]; then
  echo ""
  echo "## Audit Data"
  JSONL_COUNT=$(find .forge/local/audit -name "*.jsonl" 2>/dev/null | wc -l)
  echo "- Audit files: $JSONL_COUNT"
  if [ "$JSONL_COUNT" -gt 0 ]; then
    echo "- Total events: $(cat .forge/local/audit/*.jsonl 2>/dev/null | wc -l)"
  fi
fi

echo ""
echo "## Manual Assessment (fill in after run)"
echo "- [ ] TDD compliance: RED/GREEN evidence in commits?"
echo "- [ ] Deviations logged: (count)"
echo "- [ ] Skills invoked: (list)"
echo "- [ ] Agents dispatched: (list)"
echo "- [ ] Duration: (minutes)"
echo "- [ ] Formatting issues noted: (list for v0.5.0)"
