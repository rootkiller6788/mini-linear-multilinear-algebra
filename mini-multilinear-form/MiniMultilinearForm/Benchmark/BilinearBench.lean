import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm.Benchmark

open MiniMultilinearForm

variable {F : Field}

/-- Benchmark: bilinear form evaluation timing is O(n²).
    For an n×n matrix, evaluating B(x,y) = ∑ B_{ij}·x_i·y_j requires n² multiplications and n²-1 additions. -/
def benchEvalComplexity (n : Nat) : Nat := n * n

/-- Count operations for evaluating a bilinear form: n² multiplications + (n²-1) additions. -/
def countOperationsEval (n : Nat) : Nat := 2 * n * n - 1

/-- For n=10, operation count = 2*100-1 = 199. -/
example : countOperationsEval 10 = 199 := by
  unfold countOperationsEval; rfl

/-- Memory usage for storing an n×n bilinear form matrix: n² field elements. -/
def memoryUsage (n : Nat) : Nat := n * n

/-- Benchmark: symmetric form evaluation can save ~50% operations by
    only computing the upper triangular part and doubling. -/
def countOperationsSymmetricEval (n : Nat) : Nat := n + (n * (n - 1)) / 2

end MiniMultilinearForm.Benchmark
