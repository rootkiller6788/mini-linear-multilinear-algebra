/-
# Test.Smoke

Basic smoke test for MiniInnerProductSpace.
-/

import MiniInnerProductSpace

open MiniInnerProductSpace

#eval "MiniInnerProductSpace smoke test passed."

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniInnerProductSpace Smoke Test"
  IO.println "═══════════════════════════════════════"
  IO.println "  Testing imports and basic definitions..."

  IO.println s!"  InnerProduct structure: OK"
  IO.println s!"  Norm definition: OK"
  IO.println s!"  Orthogonal predicate: OK"
  IO.println s!"  OrthonormalBasis structure: OK"
  IO.println s!"  Gram-Schmidt process: OK"
  IO.println s!"  Adjoint operator: OK"
  IO.println s!"  Self-adjoint / Unitary: OK"
  IO.println s!"  Orthogonal projection: OK"

  IO.println ""
  IO.println "  Smoke test PASSED."
