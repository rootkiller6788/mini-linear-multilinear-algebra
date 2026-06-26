import MiniInnerProductSpace

open MiniInnerProductSpace

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniInnerProductSpace v0.1.0"
  IO.println "  Inner Product Space Sub-Package"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  InnerProduct: inner product on a vector space"
  IO.println s!"  Norm: induced norm from inner product"
  IO.println s!"  Orthogonality: orthogonal vectors and complements"
  IO.println s!"  OrthonormalBasis: basis with orthonormal vectors"
  IO.println s!"  Gram-Schmidt: orthonormalization process"
  IO.println s!"  Adjoint: adjoint (Hermitian conjugate) operator"
  IO.println s!"  SelfAdjoint: Hermitian operators"
  IO.println s!"  Unitary: orthogonal/unitary operators"
  IO.println s!"  OrthogonalProjection: projection onto subspace"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
