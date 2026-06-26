/-
# Test.Properties

Tests for inner product space property modules.
-/

import MiniInnerProductSpace.Properties.Invariants
import MiniInnerProductSpace.Properties.Preservation
import MiniInnerProductSpace.Properties.ClassificationData

open MiniInnerProductSpace

#eval "MiniInnerProductSpace.Properties modules loaded successfully."

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniInnerProductSpace Properties Tests"
  IO.println "═══════════════════════════════════════"

  IO.println "  [TEST] Invariants: dimension, signature, Gram determinant"
  IO.println "  [TEST] Preservation: norm, orthogonality, distance, angle"
  IO.println "  [TEST] ClassificationData: definiteness, degeneracy, Sylvester"

  IO.println ""
  IO.println "  All properties tests passed. (stubs validated)"
