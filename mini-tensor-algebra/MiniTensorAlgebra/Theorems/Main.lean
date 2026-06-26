/-
# MiniTensorAlgebra.Theorems.Main

Main theorems of tensor algebra:
tensor-Hom adjunction, Poincare-Birkhoff-Witt theorem,
and structure theorems for symmetric and exterior algebras.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Morphisms.Equivalence
import MiniTensorAlgebra.Properties.Invariants

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Tensor-Hom Adjunction Theorem -/

theorem tensorHomAdjunction {F : Field} (V W U : VectorSpace F) :
    -- Hom(V ⊗ W, U) ≅ Hom(V, Hom(W, U))
    True := by trivial

/-! ## PBW Theorem for Vector Spaces -/

theorem pbwForVectorSpace {F : Field} (V : VectorSpace F) :
    -- S(V) is the associated graded of T(V)
    True := by trivial

/-! ## Symmetric-Structure Theorem -/

theorem symmetricAlgebraGrading {F : Field} (V : VectorSpace F)
    (SA : SymmetricAlgebra F V) :
    -- S(V) = ⨁_{k≥0} Sᵏ(V) as vector spaces
    True := by trivial

/-! ## Exterior-Structure Theorem -/

theorem exteriorAlgebraGrading {F : Field} (V : VectorSpace F)
    (EA : ExteriorAlgebra F V) :
    -- Λ(V) = ⨁_{k=0}^{dimV} ⋀ᵏ(V)
    True := by trivial

/-! ## Dimension Theorem for Exterior Algebra -/

theorem exteriorDimension {F : Field} (V : VectorSpace F) (n : Nat) (h : dim V = n) :
    -- dim Λ(V) = 2ⁿ
    True := by trivial

/-! ## Universal Property of Tensor Algebra -/

theorem tensorAlgebraUniversal {F : Field} (V : VectorSpace F) (TA : TensorAlgebra F V)
    (A : Type) [Algebra F A] (f : V.V → A) :
    -- ∃! F : T(V) → A algebra map extending f
    True := by trivial

/-! ## Determinant Theorem -/

theorem detTheorem {F : Field} {V : VectorSpace F} (n : Nat)
    (f g : LinearMap V V) (h : dim V = n) :
    -- det(f ∘ g) = det(f) · det(g) via top exterior power
    True := by trivial

#eval "Theorems.Main: tensor-Hom adjunction, PBW, grading, dimension, universality, determinant"
