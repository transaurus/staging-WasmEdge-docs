#!/usr/bin/env bash
set -euo pipefail

# Rebuild script for WasmEdge/docs
# Runs on existing source tree (no clone). Installs deps, runs pre-build steps, builds.

# --- Node version ---
# Docusaurus 2.4.0 requires Node >=16.14.0; Node 20 is compatible
if [ -f "$HOME/.nvm/nvm.sh" ]; then
    # shellcheck source=/dev/null
    source "$HOME/.nvm/nvm.sh"
    nvm install 20 --no-progress
    nvm use 20
fi

NODE_MAJOR=$(node --version | sed 's/v//' | cut -d. -f1)
if [ "$NODE_MAJOR" -lt 16 ]; then
    echo "[ERROR] Node $NODE_MAJOR detected; Node 16+ required for Docusaurus 2.4.x"
    exit 1
fi
echo "[INFO] Using $(node --version)"

# --- Package manager: npm ---
npm ci

# --- Build ---
npm run build

echo "[DONE] Build complete."
