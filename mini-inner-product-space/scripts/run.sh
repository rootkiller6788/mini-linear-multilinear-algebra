#!/bin/bash
# Run MiniInnerProductSpace main entry point and tests

set -e

cd "$(dirname "$0")/.."

echo "========================================"
echo "  Running MiniInnerProductSpace"
echo "========================================"

echo ""
echo "[Main]"
lake env lean --run Main.lean

echo ""
echo "[Smoke Test]"
lake env lean --run Test/Smoke.lean

echo ""
echo "[Basic Tests]"
lake env lean --run Test/Basic.lean

echo ""
echo "[Properties Tests]"
lake env lean --run Test/Properties.lean

echo ""
echo "[Examples Tests]"
lake env lean --run Test/Examples.lean

echo ""
echo "========================================"
echo "  All Tests Complete"
echo "========================================"
