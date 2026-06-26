#!/bin/bash
# Build MiniDeterminantTheory
set -euo pipefail
echo "Building MiniDeterminantTheory..."
cd "$(dirname "$0")/.."
lake build "$@"
echo "MiniDeterminantTheory build complete."
