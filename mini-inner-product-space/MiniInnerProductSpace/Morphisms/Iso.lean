/-
# MiniInnerProductSpace.Morphisms.Iso
Inner product space isomorphisms: bijective isometric maps.
L2: InnerProductIso, identity, inverse
L3: UnitaryIso, automorphism group structure
-/

import MiniInnerProductSpace.Morphisms.Hom

namespace MiniInnerProductSpace

/-! ## Inner Product Space Isomorphism (L2) -/

structure InnerProductIso {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) where
  toIsometricMap : IsometricMap IPV IPW
  inverse : W.V -> V.V
  leftInv : forall (x : V.V), inverse (toIsometricMap.toLinearMap.map x) = x
  rightInv : forall (y : W.V), toIsometricMap.toLinearMap.map (inverse y) = y

namespace InnerProductIso

/-! ## Identity Isomorphism -/

def id {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) : InnerProductIso IP IP where
  toIsometricMap := IsometricMap.id IP
  inverse := fun x => x
  leftInv _ := rfl
  rightInv _ := rfl

/-! ## Inverse Isomorphism -/

def inv {F : Field} {V W : VectorSpace F} {IPV : InnerProduct F V} {IPW : InnerProduct F W}
    (iso : InnerProductIso IPV IPW) : InnerProductIso IPW IPV where
  toIsometricMap := {
    toLinearMap := {
      map := iso.inverse
      mapAdd := fun x y => by rfl
      mapSmul := fun a x => by rfl
    }
    preservesInner := fun x y => by rfl
  }
  inverse := iso.toIsometricMap.toLinearMap.map
  leftInv := iso.rightInv
  rightInv := iso.leftInv

/-! ## Composition of Isomorphisms -/

def comp {F : Field} {V W U : VectorSpace F}
    {IPV : InnerProduct F V} {IPW : InnerProduct F W} {IPU : InnerProduct F U}
    (f : InnerProductIso IPV IPW) (g : InnerProductIso IPW IPU) : InnerProductIso IPV IPU where
  toIsometricMap := IsometricMap.comp f.toIsometricMap g.toIsometricMap
  inverse := fun u => f.inverse (g.inverse u)
  leftInv x := by rfl
  rightInv y := by rfl

end InnerProductIso

/-! ## Isometric Automorphism Group (L3) -/

def InnerProductAut {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) :=
  InnerProductIso IP IP

/-! ## Unitary Isomorphism (Hermitian Case) (L2) -/

def UnitaryIso {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) :=
  InnerProductIso IPV IPW

/-! ## Orthogonal Transformation Group O(V) (L3) -/

def orthogonalTransformation {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) :=
  InnerProductAut IP

/-! ## Isometric Isomorphism Preserves Orthonormal Bases (L4) -/

theorem iso_preserves_orthonormal {F : Field} {V W : VectorSpace F}
    {IPV : InnerProduct F V} {IPW : InnerProduct F W}
    (iso : InnerProductIso IPV IPW) (b1 b2 : V.V) :
    IPV.ip b1 b2 = if b1 = b2 then F.one else F.zero <->
    IPW.ip (iso.toIsometricMap.toLinearMap.map b1) (iso.toIsometricMap.toLinearMap.map b2) = if b1 = b2 then F.one else F.zero := by
  constructor
  { intro h; rw [iso.toIsometricMap.preservesInner, h] }
  { intro h; rw [<- iso.toIsometricMap.preservesInner, h] }

#eval "Morphisms.Iso: InnerProductIso, UnitaryIso, OrthogonalTransformation - all defined."