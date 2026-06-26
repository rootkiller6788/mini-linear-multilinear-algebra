#!/bin/bash
# Lint script for mini-dual-quotient
set -e

echo "Linting mini-dual-quotient..."
lake build --no-build

echo "Lint complete."
