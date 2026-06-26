import MiniVectorSpaceCore

open MiniVectorSpaceCore

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniVectorSpaceCore v0.1.0"
  IO.println "  Vector Space Sub-Package"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  Field: algebraic structure (carrier, add, mul, zero, one, neg, inv)"
  IO.println s!"  VectorSpace: V over a Field with add, smul satisfying module axioms"
  IO.println s!"  Subspace: closed under addition and scalar multiplication"
  IO.println s!"  LinearCombination: Σ c_i·v_i of vectors"
  IO.println s!"  Span: set of all linear combinations of a set"
  IO.println s!"  LinearIndependence: no nontrivial linear combination yields zero"
  IO.println s!"  Basis: spanning + linearly independent set"
  IO.println s!"  Dimension: cardinality of a basis"
  IO.println s!"  F^n: standard n-dimensional vector space over F"
  IO.println s!"  Object instance: VectorSpaceTheory via Object typeclass"
  IO.println ""
  IO.println "  Depends on: mini-object-kernel"
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
