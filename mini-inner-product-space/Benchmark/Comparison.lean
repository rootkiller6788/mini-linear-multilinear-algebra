/-
# Benchmark.Comparison
Comparison benchmarks: Classic vs Modified Gram-Schmidt, Normal Eq vs QR for least squares.
-/

import MiniInnerProductSpace.Bridges.ToComputation

open MiniInnerProductSpace

def main : IO Unit := do
  IO.println "Comparison Benchmarks"
  IO.println "====================="
  IO.println "[COMPARE] Gram-Schmidt:"
  IO.println "  Classic GS:    O(n^2) - faster, numerically unstable"
  IO.println "  Modified GS:   O(n^2) - slightly slower, more stable"
  IO.println "  Householder:   O(n^3) - slowest, most accurate"
  IO.println ""
  IO.println "[COMPARE] Least Squares:"
  IO.println "  Normal equations: O(n^3) - fast but ill-conditioned"
  IO.println "  QR via GS:        O(n^3) - better conditioning"
  IO.println "  SVD:              O(n^3) - best but most expensive"
  IO.println ""
  IO.println "[COMPARE] Eigenvalue methods:"
  IO.println "  Power iteration:    O(n^2/iter) - dominant eigenvalue only"
  IO.println "  QR algorithm:       O(n^3/iter) - all eigenvalues"
  IO.println "  Divide & Conquer:   O(n^2) - fast for symmetric tridiagonal"
  IO.println "====================="
  IO.println "[RESULT] Comparison benchmarks completed (stub)"

#eval "Benchmark.Comparison: Ready."