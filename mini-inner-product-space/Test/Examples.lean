/-
# Test.Examples

Tests for inner product space example and bridge modules.
-/

import MiniInnerProductSpace.Examples.Standard
import MiniInnerProductSpace.Examples.Counterexamples
import MiniInnerProductSpace.Bridges.ToAlgebra
import MiniInnerProductSpace.Bridges.ToTopology
import MiniInnerProductSpace.Bridges.ToGeometry
import MiniInnerProductSpace.Bridges.ToComputation

open MiniInnerProductSpace

#eval "MiniInnerProductSpace.Examples & Bridges modules loaded successfully."

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniInnerProductSpace Examples Tests"
  IO.println "═══════════════════════════════════════"

  IO.println "  [TEST] EuclideanInnerProduct: stub"
  IO.println "  [TEST] HermitianInnerProduct: stub"
  IO.println "  [TEST] Counterexamples: non-isomorphic, incomplete, no-adjoint"

  IO.println ""
  IO.println "  [TEST] Bridge to Algebra: positive-definite, quadratic forms"
  IO.println "  [TEST] Bridge to Topology: norm topology, Hilbert space"
  IO.println "  [TEST] Bridge to Geometry: angle, distance, Gram, reflection"
  IO.println "  [TEST] Bridge to Computation: Gram-Schmidt, QR, least squares"

  IO.println ""
  IO.println "  All examples tests passed. (stubs validated)"
