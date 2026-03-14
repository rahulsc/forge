#!/usr/bin/env bash
# Test: project directory structure exists with required files
# Product artifacts are at top level; .forge/ contains only project config.

set -uo pipefail

PASS=0
FAIL=0

pass() { echo "  PASS: $1"; PASS=$((PASS + 1)); }
fail() { echo "  FAIL: $1"; FAIL=$((FAIL + 1)); }

check_file_exists() {
    local label="$1"
    local path="$2"
    if [ -f "$path" ]; then
        pass "$label"
    else
        fail "$label — expected file: $path"
    fi
}

check_dir_exists() {
    local label="$1"
    local path="$2"
    if [ -d "$path" ]; then
        pass "$label"
    else
        fail "$label — expected directory: $path"
    fi
}

# Use the actual project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
FORGE_ROOT="$PROJECT_ROOT/.forge"

echo "=== validate-directory: project directory structure ==="
echo "Checking: $PROJECT_ROOT"
echo ""

echo "--- Top-level product directories ---"
check_dir_exists "bin/" "$PROJECT_ROOT/bin"
check_dir_exists "policies/" "$PROJECT_ROOT/policies"
check_dir_exists "workflows/" "$PROJECT_ROOT/workflows"
check_dir_exists "packs/" "$PROJECT_ROOT/packs"
check_dir_exists "adapters/" "$PROJECT_ROOT/adapters"
check_dir_exists "templates/" "$PROJECT_ROOT/templates"

echo ""
echo "--- .forge/ project config directories ---"
check_dir_exists ".forge/ root directory" "$FORGE_ROOT"
check_dir_exists ".forge/shared/" "$FORGE_ROOT/shared"
check_dir_exists ".forge/shared/decisions/" "$FORGE_ROOT/shared/decisions"
check_dir_exists ".forge/local/" "$FORGE_ROOT/local"

echo ""
echo "--- Required files (top-level) ---"
check_file_exists "policies/default.yaml" "$PROJECT_ROOT/policies/default.yaml"
check_file_exists "workflows/example.yaml" "$PROJECT_ROOT/workflows/example.yaml"
check_file_exists "packs/.gitkeep" "$PROJECT_ROOT/packs/.gitkeep"
check_file_exists "adapters/.gitkeep" "$PROJECT_ROOT/adapters/.gitkeep"

echo ""
echo "--- Required files (.forge/ config) ---"
check_file_exists ".forge/project.yaml" "$FORGE_ROOT/project.yaml"
check_file_exists ".forge/shared/architecture.md" "$FORGE_ROOT/shared/architecture.md"
check_file_exists ".forge/shared/conventions.md" "$FORGE_ROOT/shared/conventions.md"
check_file_exists ".forge/shared/decisions/000-template.md" "$FORGE_ROOT/shared/decisions/000-template.md"
check_file_exists ".forge/local/.gitignore" "$FORGE_ROOT/local/.gitignore"

echo ""
echo "--- local/ is git-ignored ---"
GITIGNORE_PATH="$FORGE_ROOT/local/.gitignore"
if [ -f "$GITIGNORE_PATH" ]; then
    if grep -q '\*' "$GITIGNORE_PATH" 2>/dev/null || grep -q '\.db' "$GITIGNORE_PATH" 2>/dev/null; then
        pass ".forge/local/.gitignore ignores local state files"
    else
        fail ".forge/local/.gitignore exists but doesn't ignore local state files"
    fi
else
    fail ".forge/local/.gitignore missing — local state files would be committed"
fi

echo ""
echo "============================================"
echo "Results: $PASS passed, $FAIL failed"
echo "============================================"

if [ $FAIL -gt 0 ]; then
    exit 1
fi
exit 0
