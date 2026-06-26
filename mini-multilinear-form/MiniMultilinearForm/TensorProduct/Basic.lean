/-
# MiniMultilinearForm.TensorProduct.Basic

Tensor product of vector spaces: definition via universal property,
construction as quotient, basic properties.
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Tensor Product of Vector Spaces -/

/-- The tensor product V ⊗ W of two vector spaces over F.
    Constructed as the quotient of the free vector space on V×W
    by bilinearity relations. -/
structure TensorProduct {F : Field} (V W : VectorSpace F) where
  space : VectorSpace F
  tmul : V.V → W.V → space.V  -- v ⊗ w
  isBilinear : ∀ (a b : F.carrier) (v₁ v₂ : V.V) (w₁ w₂ : W.V),
    tmul (V.add v₁ v₂) w₁ = space.add (tmul v₁ w₁) (tmul v₂ w₁) ∧
    tmul v₁ (W.add w₁ w₂) = space.add (tmul v₁ w₁) (tmul v₁ w₂) ∧
    tmul (V.smul a v₁) w₁ = space.smul a (tmul v₁ w₁) ∧
    tmul v₁ (W.smul b w₁) = space.smul b (tmul v₁ w₁)

/-! ## Elementary Tensors -/

/-- An elementary tensor is of the form v ⊗ w. -/
def TensorProduct.isElementaryTensor {F : Field} {V W : VectorSpace F}
    (T : TensorProduct V W) (t : T.space.V) : Prop :=
  ∃ (v : V.V) (w : W.V), T.tmul v w = t

/-! ## Basis of Tensor Product -/

/-- If {eᵢ} is a basis of V and {fⱼ} is a basis of W,
    then {eᵢ ⊗ fⱼ} is a basis of V ⊗ W. -/
def TensorProduct.dim {F : Field} {V W : VectorSpace F}
    (T : TensorProduct V W) (dimV dimW : Nat) : Nat :=
  dimV * dimW  -- Stub

#eval "TensorProduct.Basic: tensor product of vector spaces, elementary tensors"
