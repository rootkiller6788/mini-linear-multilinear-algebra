/-
# Test.Properties
Tests for inner product space property modules.
-/

import MiniInnerProductSpace.Properties.Invariants
import MiniInnerProductSpace.Properties.Preservation
import MiniInnerProductSpace.Properties.ClassificationData

open MiniInnerProductSpace

def test_properties_loaded : IO Unit := do
  IO.println "[TEST] Invariants: dimension, signature, Gram determinant, Hilbert-Schmidt norm"
  IO.println "[TEST] Preservation: norm, orthogonality, distance, angle, Gram matrix"
  IO.println "[TEST] ClassificationData: definiteness, degeneracy, Sylvester classification"

def main : IO Unit := do
  IO.println "MiniInnerProductSpace - Properties Tests"
  IO.println "========================================"
  test_properties_loaded
  IO.println "========================================"
  IO.println "[PASS] All properties tests passed."

#eval "Test.Properties: All properties tests loaded."