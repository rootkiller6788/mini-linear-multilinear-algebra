import MiniDeterminantTheory

open MiniDeterminantTheory

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniDeterminantTheory v0.1.0"
  IO.println "  Determinant Theory Sub-Package"
  IO.println "═══════════════════════════════════════"
  IO.println s!"  determinant: linear operator → field element (multilinear alternating form)"
  IO.println s!"  det(A): n×n matrix determinant via Leibniz/Laplace expansion"
  IO.println s!"  charPoly: characteristic polynomial p_A(λ) = det(λI - A)"
  IO.println s!"  eigenvalues: λ such that det(λI - A) = 0"
  IO.println s!"  eigenvectors: nonzero v such that Av = λv"
  IO.println s!"  trace: sum of diagonal entries; invariant under similarity"
  IO.println s!"  det(AB) = det(A)·det(B): multiplicativity of determinant"
  IO.println s!"  Cayley-Hamilton: p_A(A) = 0 (every matrix satisfies its characteristic polynomial)"
  IO.println s!"  Cramer's rule: solving linear systems via determinants"
  IO.println ""
  IO.println "  Depends on: mini-vector-space-core, mini-linear-transformation"
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
