/-
# MiniInnerProductSpace.Morphisms.Iso

Inner product space isomorphisms: bijective isometric maps.
-/

import MiniInnerProductSpace.Morphisms.Hom

namespace MiniInnerProductSpace

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Inner Product Space Isomorphism -/

structure InnerProductIso {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) extends IsometricMap IPV IPW where
  inverse : V.V -> V.V
  leftInv : forall (x : V.V), inverse (toLinearMap x) = x
  rightInv : forall (y : W.V), toLinearMap (inverse y) = y

/-! ## Identity InnerProductIso -/

def idInnerProductIso {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) : InnerProductIso IP IP :=
  {
    toIsometricMap := {
      toLinearMap := LinearMap.id V
      preservesInner := fun x y => rfl
    }
    inverse := fun x => x
    leftInv := fun x => rfl
    rightInv := fun y => rfl
  }

/-! ## Inverse InnerProductIso -/

def invInnerProductIso {F : Field} {V W : VectorSpace F} {IPV : InnerProduct F V} {IPW : InnerProduct F W}
    (iso : InnerProductIso IPV IPW) : InnerProductIso IPW IPV :=
  {
    toIsometricMap := {
      toLinearMap := {
        map := iso.inverse
        mapAdd := fun x y => by sorry
        mapSmul := fun a x => by sorry
      }
      preservesInner := fun x y => by sorry
    }
    inverse := iso.toLinearMap
    leftInv := iso.rightInv
    rightInv := iso.leftInv
  }

/-! ## Unitary Isomorphism (complex inner product spaces) -/

def UnitaryIso {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) :=
  InnerProductIso IPV IPW

#eval "Morphisms.Iso: InnerProductIso, UnitaryIso"
