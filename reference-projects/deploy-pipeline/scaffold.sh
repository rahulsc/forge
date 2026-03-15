#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$HOME/Projects/forge-ref-projects/deploy-pipeline"

# Clean start
rm -rf "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Initialize git
git init

# Create .gitignore
cat > .gitignore << 'GITIGNORE'
node_modules/
.env
GITIGNORE

# Create basic Node.js app skeleton
cat > package.json << 'PACKAGE'
{
  "name": "deploy-pipeline",
  "version": "1.0.0",
  "description": "Simple Node.js app with no deployment story",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "test": "node test.js"
  },
  "dependencies": {
    "express": "^4.18.2"
  }
}
PACKAGE

cat > index.js << 'APP'
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({ message: 'Hello World' });
});

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
}

module.exports = app;
APP

cat > test.js << 'TEST'
const http = require('http');
const app = require('./index');

const server = app.listen(0, () => {
  const port = server.address().port;
  let passed = 0;
  let failed = 0;

  function check(name, condition) {
    if (condition) {
      console.log(`  PASS: ${name}`);
      passed++;
    } else {
      console.log(`  FAIL: ${name}`);
      failed++;
    }
  }

  function request(path, cb) {
    http.get(`http://localhost:${port}${path}`, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => cb(res.statusCode, JSON.parse(data)));
    });
  }

  request('/', (status, body) => {
    check('GET / returns 200', status === 200);
    check('GET / returns message', body.message === 'Hello World');

    request('/health', (status, body) => {
      check('GET /health returns 200', status === 200);
      check('GET /health returns ok status', body.status === 'ok');

      server.close(() => {
        console.log(`\nResults: ${passed} passed, ${failed} failed`);
        process.exit(failed > 0 ? 1 : 0);
      });
    });
  });
});
TEST

git add .
git commit -m "initial commit: basic Node.js app skeleton"

echo "Reference project scaffolded at: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_DIR"
echo "  2. Start a new Claude Code session"
echo "  3. Say: 'Set up Forge in this project'"
echo "  4. When asked about audit, say 'yes'"
echo "  5. Paste the ideation text from spec.yaml"
