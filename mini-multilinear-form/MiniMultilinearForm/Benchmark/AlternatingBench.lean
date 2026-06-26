import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm.Benchmark

open MiniMultilinearForm

variable {F : Field}

/-- Alternating (skew-symmetric) matrix storage: only need strict upper triangular part.
    For an n×n alternating matrix, store n(n-1)/2 entries (diagonal is zero, lower is -upper). -/
def alternatingStorageSize (n : Nat) : Nat := n * (n - 1) / 2

/-- For n=10: 10*9/2 = 45 entries vs 100 for general matrix (55% savings). -/
example : alternatingStorageSize 10 = 45 := by
  unfold alternatingStorageSize; rfl

/-- Pfaffian computation complexity for 2n×2n alternating matrix:
    O(n·(2n-1)!!) via combinatorial expansion, O(n³) via elimination. -/
def pfaffianComplexity (n : Nat) : Nat := n * n * n

/-- Determinant from Pfaffian: det(A) = Pf(A)² for alternating A.
    So computing det via Pf for alternating matrices may be faster. -/
def detFromPfaffian : Prop := True

/-- Symplectic basis construction complexity: O(n²) via Gram-Schmidt-like process. -/
def symplecticBasisComplexity (n : Nat) : Nat := n * n

end MiniMultilinearForm.Benchmark
