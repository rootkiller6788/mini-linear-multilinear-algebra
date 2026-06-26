#!/bin/bash
# Build script for mini-dual-quotient
set -e

echo "Building mini-dual-quotient..."
lake build

echo "Running smoke tests..."
lake env lean --run Test/Smoke.lean

echo "Build complete."
