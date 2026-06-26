import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm.Benchmark

open MiniMultilinearForm

variable {F : Field}

/-- Symmetric bilinear form storage: only need upper triangular part.
    For an n×n symmetric matrix, store n(n+1)/2 entries instead of n². -/
def symmetricStorageSize (n : Nat) : Nat := n * (n + 1) / 2

/-- For n=10: 10*11/2 = 55 entries vs 100 for general matrix (45% savings). -/
example : symmetricStorageSize 10 = 55 := by
  unfold symmetricStorageSize; rfl

/-- Diagonalization of symmetric n×n matrix via Jacobi method:
    O(n³) operations per sweep, typically needs O(log(1/ε)) sweeps. -/
def diagonalizationComplexity (n : Nat) : Nat := n * n * n

/-- Cholesky decomposition complexity: (1/3)·n³ + O(n²) operations. -/
def choleskyComplexity (n : Nat) : Nat := n * n * n / 3

/-- LDL^T decomposition for symmetric indefinite: same as Cholesky but
    with pivoting, O(n³). -/
def ldltComplexity (n : Nat) : Nat := n * n * n

end MiniMultilinearForm.Benchmark
