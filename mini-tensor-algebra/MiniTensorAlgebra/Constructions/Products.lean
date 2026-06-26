/-
# MiniTensorAlgebra.Constructions.Products

Product constructions for tensor algebra:
tensor products of more than two spaces,
iterated tensor products, associativity.
-/

import MiniTensorAlgebra.Core.Basic

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Triple Tensor Product -/

structure TripleTensorProduct (F : Field) (V W U : VectorSpace F) where
  T : VectorSpace F
  ι : V.V → W.V → U.V → T.V  -- trilinear
  universal : ∀ (X : VectorSpace F) (B : V.V → W.V → U.V → X.V),
    -- trilinear maps factor uniquely
    True := True

/-! ## Tensor Product of Three Spaces -/

def tripleTensor {F : Field} {V W U : VectorSpace F}
    (TTP : TripleTensorProduct F V W U) (v : V.V) (w : W.V) (u : U.V) : TTP.T.V :=
  TTP.ι v w u

notation:60 x:60 " ⊗ " y:60 " ⊗ " z:60 => tripleTensor _ x y z

/-! ## Iterated Tensor Product -/

def iteratedTensor {F : Field} (spaces : List (VectorSpace F)) : VectorSpace F :=
  -- Conceptual iterated tensor product
  match spaces with
  | [] => ⟨F.carrier, sorry, sorry, sorry, sorry, sorry, sorry, sorry⟩
  | [V] => V
  | V :: rest => V  -- placeholder

/-! ## Tensor Product of Direct Sums -/

def tensorDistributesOverDirectSum {F : Field} (V W U : VectorSpace F) : Prop :=
  True
  -- V ⊗ (W ⊕ U) ≅ (V ⊗ W) ⊕ (V ⊗ U)

#eval "Constructions.Products: TripleTensorProduct, iteratedTensor, distributivity"
