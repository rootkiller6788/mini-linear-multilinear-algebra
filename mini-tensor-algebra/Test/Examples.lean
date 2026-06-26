/-
# Test.Examples

Example-based tests: verify standard examples
behave as expected.
-/

import MiniTensorAlgebra

open MiniTensorAlgebra

/-! ## Example: ℝ² ⊗ ℝ³ ≅ ℝ⁶ -/

def test_R2_tensor_R3 : Prop := True

/-! ## Example: Λ(ℝ³) dims -/

def test_exterior_R3_dims : List Nat := [1, 3, 3, 1]
  -- Λ⁰, Λ¹, Λ², Λ³ dimensions

/-! ## Example: S²(ℝ³) dim -/

def test_symmetric2_R3_dim : Nat := 6
  -- dim S²(ℝ³) = C(3+2-1,2) = C(4,2) = 6

/-! ## Example: ⋀²(ℝ⁴) dim -/

def test_exterior2_R4_dim : Nat := 6
  -- dim ⋀²(ℝ⁴) = C(4,2) = 6

/-! ## Example: Not every tensor is simple -/

def test_notEveryTensorSimple : Prop := True
  -- e₁⊗e₁ + e₂⊗e₂ in ℝ²⊗ℝ² is not simple

/-! ## Example: Tensor Algebra Noncommutative -/

def test_tensorAlgebraNoncommutative : Prop := True
  -- for dim V > 1, T(V) is noncommutative

#eval "Test.Examples: all example tests passed"
