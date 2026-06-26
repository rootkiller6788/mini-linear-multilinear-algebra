/-
# MiniInnerProductSpace.Constructions.Subobjects

Subspaces of inner product spaces with induced inner product.
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore

/-! ## Inner Product Subspace -/

structure InnerProductSubspace {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) where
  subspace : Set V.V
  closedUnderAdd : forall (x y), x in subspace -> y in subspace -> V.add x y in subspace
  closedUnderSmul : forall (a : F.carrier) (x), x in subspace -> V.smul a x in subspace
  containsZero : V.zero in subspace
  restrictedInner : InnerProduct F (SubVectorSpace V subspace)

/-! ## Orthogonal Subspace (Subspace with inherited inner product) -/

def induceInnerProduct {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : InnerProduct F V :=
  IP  -- restriction of inner product

/-! ## Subspace Determined by Orthogonal Complement -/

def subspaceByComplement {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : InnerProductSubspace IP :=
  {
    subspace := W
    closedUnderAdd := fun x y hx hy => hx  -- stub
    closedUnderSmul := fun a x hx => hx    -- stub
    containsZero := hx                     -- stub
    restrictedInner := IP
  }

/-! ## Isotropic Subspace -/

def isIsotropicSubspace {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : Prop :=
  forall (x, x in W), IP.ip x x = F.zero

#eval "Constructions.Subobjects: InnerProductSubspace, IsotropicSubspace"
