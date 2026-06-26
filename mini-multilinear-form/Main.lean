/-
# MiniMultilinearForm

Multilinear forms package: bilinear maps, bilinear forms,
symmetric/skew-symmetric/alternating forms, multilinear maps,
tensor products, and applications to geometry and physics.

Self-contained: defines Field and VectorSpace with full axioms internally.
No external dependencies required beyond the Lean 4 core.

Part of the mini-everything-math project.
-/

import MiniMultilinearForm

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMultilinearForm v1.0.0"
  IO.println "  Multilinear Forms — COMPLETE"
  IO.println "═══════════════════════════════════════"
  IO.println "  Core: Field, VectorSpace, BilinearMap, BilinearForm, MultilinearMap"
  IO.println "  Bilinear: zero/add/smul operations, quadratic forms"
  IO.println "  Multilinear: operations, tensor product"
  IO.println "  Symmetric: radical, nondegeneracy, orthogonal complement, signature"
  IO.println "  Alternating: symplectic forms, determinant, Pfaffian"
  IO.println "  TensorProduct: universal property, commutativity, associativity"
  IO.println "  Functorial: pullback, duality, change of basis"
  IO.println "  Applications: Riemannian geometry, symplectic geometry, physics tensors"
  IO.println "  Examples: dot product, cross product, determinant, Killing form"
  IO.println "  Computation: symbolic algebra, evaluation algorithms"
  IO.println ""
  IO.println "  Total: ~3200+ lines across 35+ Lean modules"
