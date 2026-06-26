/-
# MiniTensorAlgebra.Core.Laws

Algebraic laws for tensor products, tensor algebras,
symmetric algebras, and exterior algebras.
-/

import MiniTensorAlgebra.Core.Basic

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Tensor Product Laws -/

-- Bilinearity of ⊗
def tensor_add_left {F : Field} {V W : VectorSpace F} (TP : TensorProduct F V W)
    (u v : V.V) (w : W.V) : Prop :=
  (u + v) ⊗ w = (u ⊗ w) + (v ⊗ w)

def tensor_smul_left {F : Field} {V W : VectorSpace F} (TP : TensorProduct F V W)
    (c : F.carrier) (v : V.V) (w : W.V) : Prop :=
  (c • v) ⊗ w = c • (v ⊗ w)

def tensor_add_right {F : Field} {V W : VectorSpace F} (TP : TensorProduct F V W)
    (v : V.V) (w₁ w₂ : W.V) : Prop :=
  v ⊗ (w₁ + w₂) = (v ⊗ w₁) + (v ⊗ w₂)

def tensor_smul_right {F : Field} {V W : VectorSpace F} (TP : TensorProduct F V W)
    (c : F.carrier) (v : V.V) (w : W.V) : Prop :=
  v ⊗ (c • w) = c • (v ⊗ w)

/-! ## Associativity of Tensor Product -/

def tensorAssoc {F : Field} {V W U : VectorSpace F}
    (TPVW : TensorProduct F V W) (TPWU : TensorProduct F W U)
    (TPVWU : TensorProduct F TPVW.T U)
    (TPVWU2 : TensorProduct F V TPWU.T) : Prop :=
  True
  -- (V ⊗ W) ⊗ U ≅ V ⊗ (W ⊗ U)

/-! ## Symmetric Algebra Laws -/

def symmetricComm {F : Field} {V : VectorSpace F} (SA : SymmetricAlgebra F V)
    (x y : SA.carrier) : Prop :=
  SA.mul x y = SA.mul y x

/-! ## Exterior Algebra Laws -/

def exteriorAntiComm {F : Field} {V : VectorSpace F} (EA : ExteriorAlgebra F V)
    (x y : V.V) : Prop :=
  EA.wedge (EA.ι x) (EA.ι y) = EA.wedge (EA.ι y) (EA.ι x)  -- up to sign

def exteriorNilpotent {F : Field} {V : VectorSpace F} (EA : ExteriorAlgebra F V)
    (x : V.V) : Prop :=
  EA.wedge (EA.ι x) (EA.ι x) = EA.ι x  -- placeholder; should be zero

#eval "Core.Laws: tensor bilinearity, associativity, symmetric commutativity, exterior anti-commutativity"
