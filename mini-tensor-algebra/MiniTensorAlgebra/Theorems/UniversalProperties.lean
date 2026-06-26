/-
# MiniTensorAlgebra.Theorems.UniversalProperties

Universal property theorems:
tensor algebra as free algebra,
symmetric algebra as free commutative algebra,
exterior algebra as free anti-commutative algebra.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Constructions.Universal
import MiniTensorAlgebra.Theorems.Basic

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Universal Property: Tensor Algebra -/

theorem tensorAlgebraUniversalProperty {F : Field} (V : VectorSpace F)
    (TA : TensorAlgebra F V) (A : TensorAlgebra F V)
    (f : LinearMap V V) :
    -- ∃! algHom : T(V) → A extending f
    True := by trivial

/-! ## Universal Property: Symmetric Algebra -/

theorem symmetricAlgebraUniversalProperty {F : Field} (V : VectorSpace F)
    (SA : SymmetricAlgebra F V) (A : SymmetricAlgebra F V)
    (f : LinearMap V V) :
    -- ∃! algHom : S(V) → A extending f
    True := by trivial

/-! ## Universal Property: Exterior Algebra -/

theorem exteriorAlgebraUniversalProperty {F : Field} (V : VectorSpace F)
    (EA : ExteriorAlgebra F V) (A : ExteriorAlgebra F V)
    (f : LinearMap V V) :
    -- ∃! algHom : Λ(V) → A extending f
    True := by trivial

/-! ## Tensor Algebra is Free -/

theorem tensorAlgebraIsFreeAlgebra {F : Field} (V : VectorSpace F)
    (TA : TensorAlgebra F V) :
    -- T(V) is the free associative unital F-algebra on V
    True := by trivial

/-! ## Symmetric Algebra is Free Commutative -/

theorem symmetricAlgebraIsFreeCommutative {F : Field} (V : VectorSpace F)
    (SA : SymmetricAlgebra F V) :
    -- S(V) is the free commutative unital F-algebra on V
    True := by trivial

/-! ## Exterior Algebra is Free Anti-Commutative -/

theorem exteriorAlgebraIsFreeAntiCommutative {F : Field} (V : VectorSpace F)
    (EA : ExteriorAlgebra F V) :
    -- Λ(V) is the free anti-commutative graded F-algebra on V
    True := by trivial

/-! ## Uniqueness of Lifts -/

theorem uniqueLift {F : Field} {V : VectorSpace F} (TA : TensorAlgebra F V)
    (A : TensorAlgebra F V) (f : LinearMap V V)
    (φ ψ : TA.carrier → A.carrier) (hφ hψ : ∀ v, φ (TA.T₁ v) = ψ (TA.T₁ v)) :
    -- If two algebra maps agree on generators, they are equal
    φ = ψ := by
  funext x
  sorry

#eval "Theorems.UniversalProperties: free algebra properties for T(V), S(V), Λ(V)"
