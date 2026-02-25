#!/bin/bash
set -euo pipefail

# Only run in remote/web environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
	exit 0
fi

echo "=== VS Code Dev Environment Setup ==="

# Install system dependencies required for native Node.js modules
if ! dpkg -l libxkbfile-dev libsecret-1-dev libkrb5-dev &>/dev/null; then
	echo "[setup] Installing system dependencies..."
	apt-get install -y libxkbfile-dev libsecret-1-dev libkrb5-dev
fi

# Install root npm dependencies if needed
if [ ! -d "${CLAUDE_PROJECT_DIR}/node_modules/.bin" ]; then
	echo "[setup] Installing root npm dependencies..."
	npm install --prefix "${CLAUDE_PROJECT_DIR}"
else
	echo "[setup] Root node_modules present."
fi

echo ""
echo "=== Available Commands ==="
echo "  Build (watch):  npm run watch"
echo "  Unit tests:     ./scripts/test.sh [--grep <pattern>]"
echo "  Node tests:     npm run test-node"
echo "  Integration:    ./scripts/test-integration.sh"
echo "  Lint:           npm run eslint"
echo "  Hygiene:        npm run hygiene"
echo "  Layers check:   npm run valid-layers-check"
echo ""
echo "IMPORTANT: Check 'VS Code - Build' watch task output before running tests."
echo "=== Setup complete ==="
