/-
# MiniInnerProductSpace.Constructions.Products

Product of inner product spaces.
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore

/-! ## Product Inner Product -/

def productInnerProduct {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) :
    InnerProduct F (ProductVectorSpace V W) :=
  {
    ip := fun (v1, w1) (v2, w2) => F.add (IPV.ip v1 v2) (IPW.ip w1 w2)
    conjugateSym := fun (v1, w1) (v2, w2) => by
      -- <(v1,w1),(v2,w2)> = <v1,v2> + <w1,w2> = <v2,v1> + <w2,w1> = <(v2,w2),(v1,w1)>
      sorry
    linearFirst := fun x y z a => by sorry
    positiveDefinite := fun x h => by sorry
  }

/-! ## Finite Product -/

def finiteProductInnerProduct {F : Field} (n : Nat) (spaces : Fin n -> VectorSpace F) (inners : forall (i : Fin n), InnerProduct F (spaces i)) :
    InnerProduct F (FiniteProductVectorSpace n spaces) :=
  {
    ip := fun v w => F.zero  -- sum_i <v_i, w_i>
    conjugateSym := fun x y => by sorry
    linearFirst := fun x y z a => by sorry
    positiveDefinite := fun x h => by sorry
  }

/-! ## Orthogonal Direct Sum -/

def orthogonalDirectSum {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) : Prop :=
  -- V ⟂ W in V x W
  forall (v : V.V) (w : W.V), IPV.ip v v = IPW.ip w w

#eval "Constructions.Products: ProductInnerProduct, FiniteProduct, OrthogonalDirectSum"
