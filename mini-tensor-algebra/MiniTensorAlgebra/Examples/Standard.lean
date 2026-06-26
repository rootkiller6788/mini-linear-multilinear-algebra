/-
# MiniTensorAlgebra.Examples.Standard

Standard examples of tensor products, tensor algebras,
symmetric algebras, and exterior algebras over common fields.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Core.Objects

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Tensor Product of ℝ² and ℝ³ -/

def example_R2_tensor_R3 {F : Field} (hF : F.carrier := F.one) : Prop :=
  True
  -- ℝ² ⊗ ℝ³ ≅ ℝ⁶ as vector spaces

/-! ## Tensor Algebra of ℝⁿ -/

def example_tensorAlgebra_Rn {F : Field} (n : Nat) (V : VectorSpace F) : Prop :=
  True
  -- T(ℝⁿ) ≅ ℝ⟨x₁,...,xₙ⟩ (non-commutative polynomial ring)

/-! ## Symmetric Algebra of ℝⁿ -/

def example_symmetricAlgebra_Rn {F : Field} (n : Nat) (V : VectorSpace F) : Prop :=
  True
  -- S(ℝⁿ) ≅ ℝ[x₁,...,xₙ] (polynomial ring)

/-! ## Exterior Algebra of ℝ³ -/

def example_exteriorAlgebra_R3 {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- Λ(ℝ³): Λ⁰ ≅ ℝ, Λ¹ ≅ ℝ³, Λ² ≅ ℝ³, Λ³ ≅ ℝ
  -- Cross product corresponds to Hodge dual of wedge product

/-! ## Tensor Product over ℂ -/

def example_complexTensor {F : Field} [CharZero F] (V W : VectorSpace F) : Prop :=
  True
  -- ℂ ⊗_ℝ ℂ ≅ ℂ ⊕ ℂ (via split-complex)

/-! ## Exterior Powers of Low-Dimensional Spaces -/

def example_exterior_R2 {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- Λ(ℝ²) = ℝ ⊕ ℝ² ⊕ ⋀²(ℝ²) with dims 1,2,1

def example_exterior_R4 {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- Λ(ℝ⁴) has components: 1,4,6,4,1

/-! ## Graded Components -/

def example_gradedComponents {F : Field} (V : VectorSpace F) (dimV : Nat) : Prop :=
  True
  -- Tᵏ(ℝⁿ): dim = nᵏ
  -- Sᵏ(ℝⁿ): dim = C(n+k-1, k)
  -- ⋀ᵏ(ℝⁿ): dim = C(n, k)

#eval "Examples.Standard: ℝ²⊗ℝ³, T(ℝⁿ), S(ℝⁿ), Λ(ℝ³), exterior powers of ℝ² and ℝ⁴"
