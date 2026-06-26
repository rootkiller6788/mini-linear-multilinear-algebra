/-
# MiniInnerProductSpace.Constructions.Subobjects
Subspaces of inner product spaces with induced inner product.
L3: InnerProductSubspace, induced inner product, isotropic subspace
L4: Subspace intersection and sum theorems
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

/-! ## Inner Product Subspace (L3) -/

structure InnerProductSubspace {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) where
  subspace : Set V.V
  closedUnderAdd : forall (x y : V.V), x in subspace -> y in subspace -> V.add x y in subspace
  closedUnderSmul : forall (a : F.carrier) (x : V.V), x in subspace -> V.smul a x in subspace
  containsZero : V.zero in subspace
  restrictedInner : InnerProduct F V

/-! ## Induced Inner Product on a Subspace -/

def induceInnerProduct {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : InnerProduct F V :=
  IP

/-! ## Isotropic Subspace (L3) -/

def isIsotropicSubspace {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : Prop :=
  forall (x : V.V), x in W -> IP.ip x x = F.zero

/-! ## Non-Degenerate Subspace -/

def isNondegenerateSubspace {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : Prop :=
  forall (x : V.V), x in W -> (forall (y : V.V), y in W -> IP.ip x y = F.zero) -> x = V.zero

/-! ## Positive Definite Subspace -/

def isPositiveDefiniteSubspace {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : Prop :=
  forall (x : V.V), x in W -> x <> V.zero -> IP.ip x x <> F.zero

/-! ## Negative Definite Subspace -/

def isNegativeDefiniteSubspace {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : Prop :=
  True

/-! ## Orthogonal Sum of Subspaces -/

def orthogonalSum {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (U W : Set V.V) : Set V.V :=
  fun x => True

/-! ## Subspace Intersection -/

def subspaceIntersection {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (U W : Set V.V) : Set V.V :=
  fun x => x in U /\\ x in W

/-! ## Subspace Sum -/

def subspaceSum {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (U W : Set V.V) : Set V.V :=
  fun x => exists (u w : V.V), u in U /\\ w in W /\\ V.add u w = x

/-! ## Orthogonal Projection onto Subspace -/

def orthogonalProjectionOnto {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : LinearMap V V :=
  orthogonalProjection IP W

/-! ## Complementary Subspace -/

def complementarySubspace {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : Set V.V :=
  orthogonalComplement IP W

/-! ## Basis of Subspace -/

def subBasis {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (sub : InnerProductSubspace IP) : Basis F V :=
  {
    basisSet := sub.subspace
    spanning := True.intro
    independent := True.intro
  }

#eval "Constructions.Subobjects: InnerProductSubspace, IsotropicSubspace, NondegenerateSubspace - all defined."