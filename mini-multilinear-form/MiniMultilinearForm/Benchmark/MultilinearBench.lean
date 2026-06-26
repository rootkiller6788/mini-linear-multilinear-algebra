import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm.Benchmark

open MiniMultilinearForm

variable {F : Field} {n : Nat}

/-- Complexity of evaluating an n-linear form: O(m^n) where m = dim(V).
    For a 3-linear form on an m-dimensional space: m³ operations. -/
def complexityMultilinear (arity dim : Nat) : Nat :=
  match arity with
  | 0 => 1
  | k+1 => dim * complexityMultilinear k dim

/-- For arity 3, dim 10: 10³ = 1000 operations. -/
example : complexityMultilinear 3 10 = 1000 := by
  unfold complexityMultilinear; rfl

/-- For arity 2, dim n: n² operations (falls back to bilinear case). -/
theorem complexityMultilinear_bilinear (n : Nat) : complexityMultilinear 2 n = n * n := by
  unfold complexityMultilinear; rfl

/-- Arity 0 (scalar): constant time O(1). -/
theorem complexityMultilinear_arity0 (dim : Nat) : complexityMultilinear 0 dim = 1 := by
  unfold complexityMultilinear; rfl

/-- Determinant computation (arity n on F^n): naive O(n!·n) via Leibniz formula. -/
def complexityDeterminant (n : Nat) : Nat :=
  -- n! * n for Leibniz expansion
  match n with
  | 0 => 1
  | k+1 => (k+1) * complexityDeterminant k

end MiniMultilinearForm.Benchmark
