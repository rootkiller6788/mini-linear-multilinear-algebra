#!/bin/bash
# Build MiniInnerProductSpace package

set -e

echo "========================================"
echo "  Building MiniInnerProductSpace"
echo "========================================"

# Ensure dependencies are built
echo ""
echo "[1/3] Building mini-object-kernel..."
cd "../../0. mini-math-kernel/mini-object-kernel"
lake build || { echo "FAILED: mini-object-kernel"; exit 1; }

echo ""
echo "[2/3] Building mini-vector-space-core..."
cd "../../3. mini-linear-multilinear-algebra/mini-vector-space-core"
lake build || { echo "FAILED: mini-vector-space-core"; exit 1; }

echo ""
echo "[3/3] Building mini-linear-transformation..."
cd "../mini-linear-transformation"
lake build || { echo "FAILED: mini-linear-transformation"; exit 1; }

echo ""
echo "[4/4] Building mini-inner-product-space..."
cd "../mini-inner-product-space"
lake build || { echo "FAILED: mini-inner-product-space"; exit 1; }

echo ""
echo "========================================"
echo "  Build Complete"
echo "========================================"
