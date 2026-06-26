#!/bin/bash
# Clean MiniSpectralCanonical build artifacts
set -euo pipefail
echo "Cleaning MiniSpectralCanonical..."
cd "$(dirname "$0")/.."
lake clean
echo "MiniSpectralCanonical clean complete."
