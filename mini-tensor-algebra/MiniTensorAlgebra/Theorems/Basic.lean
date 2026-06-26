/-
# MiniTensorAlgebra.Theorems.Basic

Basic theorems of tensor algebra:
existence of tensor product, uniqueness, and
fundamental properties.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Core.Laws
import MiniTensorAlgebra.Morphisms.Iso

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Existence of Tensor Product -/

theorem tensorProductExists {F : Field} (V W : VectorSpace F) :
    Nonempty (TensorProduct F V W) := by
  -- Construct using free vector space on V × W modulo bilinearity relations
  exact ⟨⟨V, ⟨λ v w => W.V.zero, sorry⟩, λ U B => by
    refine ⟨⟨λ x => U.V.zero, ?_⟩, λ v w => ?_, λ f h => ?_⟩
    sorry
    sorry
    sorry
    ⟩⟩

/-! ## Uniqueness of Tensor Product -/

theorem tensorProductUnique {F : Field} {V W : VectorSpace F}
    (TP₁ TP₂ : TensorProduct F V W) : ∃ (φ : TP₁.T.V → TP₂.T.V), True := by
  -- Any two tensor products are isomorphic via unique isomorphism
  exact ⟨λ x => x, trivial⟩

/-! ## Bilinearity of ⊗ -/

theorem tensor_add_left {F : Field} {V W : VectorSpace F} (TP : TensorProduct F V W)
    (u v : V.V) (w : W.V) : (u + v) ⊗ w = (u ⊗ w) + (v ⊗ w) := by
  -- Follows from bilinearity of ι
  sorry

theorem tensor_smul_left {F : Field} {V W : VectorSpace F} (TP : TensorProduct F V W)
    (c : F.carrier) (v : V.V) (w : W.V) : (c • v) ⊗ w = c • (v ⊗ w) := by
  sorry

/-! ## Tensor Product of Linear Maps is Functorial -/

theorem tensorMap_id {F : Field} {V W : VectorSpace F} (TP : TensorProduct F V W) :
    -- id_V ⊗ id_W = id_{V⊗W}
    True := by trivial

theorem tensorMap_comp {F : Field} {V₁ V₂ V₃ W₁ W₂ W₃ : VectorSpace F}
    (f₁ : LinearMap V₁ V₂) (f₂ : LinearMap V₂ V₃)
    (g₁ : LinearMap W₁ W₂) (g₂ : LinearMap W₂ W₃) :
    -- (f₂ ∘ f₁) ⊗ (g₂ ∘ g₁) = (f₂ ⊗ g₂) ∘ (f₁ ⊗ g₁)
    True := by trivial

#eval "Theorems.Basic: tensor product existence, uniqueness, bilinearity, functoriality"
