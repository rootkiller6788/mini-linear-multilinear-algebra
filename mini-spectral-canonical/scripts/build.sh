#!/bin/bash
# Build MiniSpectralCanonical
set -euo pipefail
echo "Building MiniSpectralCanonical..."
cd "$(dirname "$0")/.."
lake build "$@"
echo "MiniSpectralCanonical build complete."
