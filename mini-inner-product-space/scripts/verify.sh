#!/bin/bash
# Verify MiniInnerProductSpace package integrity

set -e

cd "$(dirname "$0")/.."

echo "========================================"
echo "  Verifying MiniInnerProductSpace"
echo "========================================"

PASS=0
FAIL=0

check() {
    local label="$1"
    local file="$2"
    if [ -f "$file" ]; then
        echo "  [PASS] $label: $file"
        PASS=$((PASS + 1))
    else
        echo "  [FAIL] $label: $file (NOT FOUND)"
        FAIL=$((FAIL + 1))
    fi
}

echo ""
echo "--- Root Files ---"
check "lakefile" "lakefile.lean"
check "lean-toolchain" "lean-toolchain"
check "Main" "Main.lean"
check "Module entry" "MiniInnerProductSpace.lean"
check "README" "README.md"

echo ""
echo "--- MiniInnerProductSpace/Core ---"
check "Core.Basic" "MiniInnerProductSpace/Core/Basic.lean"
check "Core.Objects" "MiniInnerProductSpace/Core/Objects.lean"
check "Core.Laws" "MiniInnerProductSpace/Core/Laws.lean"

echo ""
echo "--- MiniInnerProductSpace/Morphisms ---"
check "Morphisms.Hom" "MiniInnerProductSpace/Morphisms/Hom.lean"
check "Morphisms.Iso" "MiniInnerProductSpace/Morphisms/Iso.lean"
check "Morphisms.Equivalence" "MiniInnerProductSpace/Morphisms/Equivalence.lean"

echo ""
echo "--- MiniInnerProductSpace/Constructions ---"
check "Constructions.Products" "MiniInnerProductSpace/Constructions/Products.lean"
check "Constructions.Universal" "MiniInnerProductSpace/Constructions/Universal.lean"
check "Constructions.Subobjects" "MiniInnerProductSpace/Constructions/Subobjects.lean"
check "Constructions.Quotients" "MiniInnerProductSpace/Constructions/Quotients.lean"

echo ""
echo "--- MiniInnerProductSpace/Properties ---"
check "Properties.Invariants" "MiniInnerProductSpace/Properties/Invariants.lean"
check "Properties.Preservation" "MiniInnerProductSpace/Properties/Preservation.lean"
check "Properties.ClassificationData" "MiniInnerProductSpace/Properties/ClassificationData.lean"

echo ""
echo "--- MiniInnerProductSpace/Theorems ---"
check "Theorems.Basic" "MiniInnerProductSpace/Theorems/Basic.lean"
check "Theorems.UniversalProperties" "MiniInnerProductSpace/Theorems/UniversalProperties.lean"
check "Theorems.Classification" "MiniInnerProductSpace/Theorems/Classification.lean"
check "Theorems.Main" "MiniInnerProductSpace/Theorems/Main.lean"

echo ""
echo "--- MiniInnerProductSpace/Examples ---"
check "Examples.Standard" "MiniInnerProductSpace/Examples/Standard.lean"
check "Examples.Counterexamples" "MiniInnerProductSpace/Examples/Counterexamples.lean"

echo ""
echo "--- MiniInnerProductSpace/Bridges ---"
check "Bridges.ToAlgebra" "MiniInnerProductSpace/Bridges/ToAlgebra.lean"
check "Bridges.ToTopology" "MiniInnerProductSpace/Bridges/ToTopology.lean"
check "Bridges.ToGeometry" "MiniInnerProductSpace/Bridges/ToGeometry.lean"
check "Bridges.ToComputation" "MiniInnerProductSpace/Bridges/ToComputation.lean"

echo ""
echo "--- Test ---"
check "Test.Smoke" "Test/Smoke.lean"
check "Test.Basic" "Test/Basic.lean"
check "Test.Properties" "Test/Properties.lean"
check "Test.Examples" "Test/Examples.lean"

echo ""
echo "--- Benchmark ---"
check "Benchmark.Basic" "Benchmark/Basic.lean"
check "Benchmark.Core" "Benchmark/Core.lean"
check "Benchmark.Comparison" "Benchmark/Comparison.lean"

echo ""
echo "--- docs ---"
check "docs/index" "docs/index.md"
check "docs/api" "docs/api.md"
check "docs/guide" "docs/guide.md"

echo ""
echo "--- scripts ---"
check "scripts/build" "scripts/build.sh"
check "scripts/run" "scripts/run.sh"
check "scripts/verify" "scripts/verify.sh"

echo ""
echo "--- Computation ---"
check "notebooks/exploration" "Computation/notebooks/exploration.ipynb"
check "notebooks/verification" "Computation/notebooks/verification.ipynb"
check "python/helper" "Computation/python/helper.py"
check "sage/verify" "Computation/sage/verify.sage"

echo ""
echo "========================================"
echo "  Verification Complete: $PASS passed, $FAIL failed"
echo "========================================"

if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
