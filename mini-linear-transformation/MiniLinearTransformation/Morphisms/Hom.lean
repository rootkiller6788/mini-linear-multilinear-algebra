/-
# MiniLinearTransformation.Morphisms.Hom

Linear transformations as morphisms between vector spaces.
Isomorphism and automorphism of vector spaces.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Isomorphism of Vector Spaces -/

structure LinearIsomorphism {F : Field} (V W : VectorSpace F) where
  toMap : LinearMap V W
  invMap : LinearMap W V
  leftInv : ∀ (x : V.V), invMap.map (toMap.map x) = x
  rightInv : ∀ (y : W.V), toMap.map (invMap.map y) = y

def LinearIsomorphism.id {F : Field} (V : VectorSpace F) : LinearIsomorphism V V where
  toMap := LinearMap.id V
  invMap := LinearMap.id V
  leftInv x := rfl
  rightInv y := rfl

/-! ## Automorphism -/

def Automorphism {F : Field} (V : VectorSpace F) := LinearIsomorphism V V

/-! ## Symmetric isomorphism -/

def LinearIsomorphism.symm {F : Field} {V W : VectorSpace F} (iso : LinearIsomorphism V W) : LinearIsomorphism W V where
  toMap := iso.invMap
  invMap := iso.toMap
  leftInv := iso.rightInv
  rightInv := iso.leftInv

/-! ## Composition of isomorphisms -/

def LinearIsomorphism.comp {F : Field} {U V W : VectorSpace F}
    (iso2 : LinearIsomorphism V W) (iso1 : LinearIsomorphism U V) : LinearIsomorphism U W where
  toMap := LinearMap.comp iso2.toMap iso1.toMap
  invMap := LinearMap.comp iso1.invMap iso2.invMap
  leftInv x := by
    simp [LinearMap.comp, iso1.leftInv, iso2.leftInv]
  rightInv y := by
    simp [LinearMap.comp, iso2.rightInv, iso1.rightInv]

#eval "Morphisms.Hom: LinearIsomorphism, id, symm, comp, Automorphism"
