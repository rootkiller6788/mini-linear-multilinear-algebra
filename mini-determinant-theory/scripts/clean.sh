#!/bin/bash
# Clean MiniDeterminantTheory build artifacts
set -euo pipefail
echo "Cleaning MiniDeterminantTheory..."
cd "$(dirname "$0")/.."
lake clean
echo "MiniDeterminantTheory clean complete."
