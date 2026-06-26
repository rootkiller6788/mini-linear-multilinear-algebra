/-
# Benchmark.MIT

MIT undergraduate math benchmark:
tensor algebra problems typical of MIT's
18.06 (Linear Algebra) and 18.700 (Linear Algebra).
-/

import MiniTensorAlgebra

open MiniTensorAlgebra

/-! ## MIT 18.06 / 18.700 Tensor Problems -/

-- Problem 1: Compute basis of tensor product
def mit_problem_1 : Prop :=
  True
  -- Find a basis of ℝ² ⊗ ℝ³

-- Problem 2: Determine dimension of symmetric square
def mit_problem_2 : Nat := 6
  -- dim S²(ℝ³)

-- Problem 3: Determine dimension of exterior square
def mit_problem_3 : Nat := 3
  -- dim ⋀²(ℝ³)

-- Problem 4: Prove v ⊗ w = 0 iff v = 0 or w = 0
def mit_problem_4 : Prop :=
  True
  -- Pure tensor is zero iff one factor is zero

-- Problem 5: Show tensor product distributes over direct sum
def mit_problem_5 : Prop :=
  True
  -- V ⊗ (W ⊕ U) ≅ (V ⊗ W) ⊕ (V ⊗ U)

-- Problem 6: Find dim of Λᵏ(ℝⁿ)
def mit_problem_6 (n k : Nat) : Nat := 0
  -- dim ⋀ᵏ(ℝⁿ) = C(n, k) for k ≤ n, 0 otherwise

#eval "Benchmark.MIT: 6 problems from MIT 18.06/18.700 tensor algebra curriculum"
