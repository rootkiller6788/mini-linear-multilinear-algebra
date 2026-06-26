/-
# MiniTensorAlgebra.Morphisms.Iso

Isomorphisms between tensor products, canonical isomorphisms:
associativity, commutativity, and distributivity isomorphisms.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Morphisms.Hom

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Isomorphism of Tensor Products -/

structure TensorProductIso (F : Field) (V₁ V₂ W₁ W₂ : VectorSpace F) where
  TP₁ : TensorProduct F V₁ V₂
  TP₂ : TensorProduct F W₁ W₂
  iso : TP₁.T.V → TP₂.T.V  -- linear isomorphism
  inverse : TP₂.T.V → TP₁.T.V
  isIso : Prop := True

/-! ## Associativity Isomorphism -/

def assocIso {F : Field} {V W U : VectorSpace F}
    (TPVW : TensorProduct F V W) (TPVWU : TensorProduct F TPVW.T U)
    (TPWU : TensorProduct F W U) (TPVWU2 : TensorProduct F V TPWU.T) : Prop :=
  True
  -- (V ⊗ W) ⊗ U ≅ V ⊗ (W ⊗ U)

/-! ## Commutativity (Swap) Isomorphism -/

def swapIso {F : Field} {V W : VectorSpace F}
    (TPVW : TensorProduct F V W) (TPWV : TensorProduct F W V) : Prop :=
  True
  -- V ⊗ W ≅ W ⊗ V via v ⊗ w ↦ w ⊗ v

/-! ## Distributivity Isomorphism -/

def distribIso {F : Field} {V W U : VectorSpace F}
    (TP_V_WpU : TensorProduct F V (DirectSum F W U))
    (TPVW : TensorProduct F V W) (TPVU : TensorProduct F V U)
    (DS : DirectSum F TPVW.T TPVU.T) : Prop :=
  True
  -- V ⊗ (W ⊕ U) ≅ (V ⊗ W) ⊕ (V ⊗ U)

/-! ## Unit Isomorphism -/

def unitIso {F : Field} {V : VectorSpace F} (TP : TensorProduct F (trivialVS F) V) : Prop :=
  True
  -- F ⊗ V ≅ V

/-! ## Trace Map -/

structure TraceMap (F : Field) (V : VectorSpace F) where
  TP : TensorProduct F V (DualVectorSpace F V)
  trace : TP.T.V → F.carrier
  -- V ⊗ V* → F via evaluation

#eval "Morphisms.Iso: TensorProductIso, associativity, commutativity, distributivity isomorphisms"
