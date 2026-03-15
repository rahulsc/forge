#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$HOME/Projects/forge-ref-projects/task-tracker-api"

# Clean start
rm -rf "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Initialize git
git init

# Create .gitignore
cat > .gitignore << 'GITIGNORE'
node_modules/
__pycache__/
.env
GITIGNORE

git add .gitignore
git commit -m "initial commit"

echo "Reference project scaffolded at: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_DIR"
echo "  2. Start a new Claude Code session"
echo "  3. Say: 'Set up Forge in this project'"
echo "  4. When asked about audit, say 'yes'"
echo "  5. Paste the ideation text from spec.yaml"
