/-
# MiniLinearTransformation.Morphisms.Hom

Linear isomorphisms and automorphisms between vector spaces.
Knowledge: L1-structure, L2-isomorphism concept, L3-category, L4-theorems, L5-constructions.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Laws

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Linear Isomorphism (L1) -/

structure LinearIsomorphism {F : Field} (V W : VectorSpace F) where
  toMap : LinearMap V W
  invMap : LinearMap W V
  leftInv : ∀ (x : V.V), invMap.map (toMap.map x) = x
  rightInv : ∀ (y : W.V), toMap.map (invMap.map y) = y

def LinearIsomorphism.id {F : Field} (V : VectorSpace F) : LinearIsomorphism V V where
  toMap := LinearMap.id V
  invMap := LinearMap.id V
  leftInv _ := rfl
  rightInv _ := rfl

def LinearIsomorphism.symm {F : Field} {V W : VectorSpace F}
    (iso : LinearIsomorphism V W) : LinearIsomorphism W V where
  toMap := iso.invMap
  invMap := iso.toMap
  leftInv := iso.rightInv
  rightInv := iso.leftInv

def LinearIsomorphism.comp {F : Field} {U V W : VectorSpace F}
    (iso2 : LinearIsomorphism V W) (iso1 : LinearIsomorphism U V) : LinearIsomorphism U W where
  toMap := LinearMap.comp iso2.toMap iso1.toMap
  invMap := LinearMap.comp iso1.invMap iso2.invMap
  leftInv x := by
    dsimp [LinearMap.comp]
    calc
      iso1.invMap.map (iso2.invMap.map (iso2.toMap.map (iso1.toMap.map x))) =
        iso1.invMap.map (iso1.toMap.map x) := by rw [iso2.leftInv]
      _ = x := iso1.leftInv x
  rightInv y := by
    dsimp [LinearMap.comp]
    calc
      iso2.toMap.map (iso1.toMap.map (iso1.invMap.map (iso2.invMap.map y))) =
        iso2.toMap.map (iso2.invMap.map y) := by rw [iso1.rightInv]
      _ = y := iso2.rightInv y

/-! ## Automorphism (L2) -/

def Automorphism {F : Field} (V : VectorSpace F) := LinearIsomorphism V V

def Automorphism.id {F : Field} (V : VectorSpace F) : Automorphism V := LinearIsomorphism.id V

def Automorphism.comp {F : Field} {V : VectorSpace F}
    (g f : Automorphism V) : Automorphism V :=
  LinearIsomorphism.comp g f

/-- Automorphisms form a group under composition. -/
def Automorphism.groupLaws {F : Field} {V : VectorSpace F} : Prop :=
  (∀ (f g h : Automorphism V), Automorphism.comp (Automorphism.comp f g) h =
    Automorphism.comp f (Automorphism.comp g h)) ∧
  (∀ (f : Automorphism V), Automorphism.comp (Automorphism.id V) f = f ∧
    Automorphism.comp f (Automorphism.id V) = f) ∧
  (∀ (f : Automorphism V), ∃ (g : Automorphism V),
    Automorphism.comp g f = Automorphism.id V ∧
    Automorphism.comp f g = Automorphism.id V)

theorem Automorphism.assoc {F : Field} {V : VectorSpace F}
    (f g h : Automorphism V) :
    Automorphism.comp (Automorphism.comp f g) h =
    Automorphism.comp f (Automorphism.comp g h) := rfl

theorem Automorphism.id_comp {F : Field} {V : VectorSpace F} (f : Automorphism V) :
    Automorphism.comp (Automorphism.id V) f = f := rfl

theorem Automorphism.comp_id {F : Field} {V : VectorSpace F} (f : Automorphism V) :
    Automorphism.comp f (Automorphism.id V) = f := rfl

/-- Inverse of an automorphism. -/
def Automorphism.inv {F : Field} {V : VectorSpace F} (f : Automorphism V) : Automorphism V :=
  LinearIsomorphism.symm f

theorem Automorphism.inv_comp {F : Field} {V : VectorSpace F} (f : Automorphism V) :
    Automorphism.comp (Automorphism.inv f) f = Automorphism.id V := rfl

theorem Automorphism.comp_inv {F : Field} {V : VectorSpace F} (f : Automorphism V) :
    Automorphism.comp f (Automorphism.inv f) = Automorphism.id V := rfl

/-! ## Isomorphism Preserves Structure (L4) -/

/-- If V ≅ W and W ≅ U, then V ≅ U. -/
theorem iso_trans {F : Field} {V W U : VectorSpace F}
    (iso1 : LinearIsomorphism V W) (iso2 : LinearIsomorphism W U) :
    LinearIsomorphism V U :=
  LinearIsomorphism.comp iso2 iso1

/-- Isomorphism is reflexive: V ≅ V. -/
theorem iso_refl {F : Field} (V : VectorSpace F) : LinearIsomorphism V V :=
  LinearIsomorphism.id V

/-- Isomorphism is symmetric: V ≅ W → W ≅ V. -/
theorem iso_symm {F : Field} {V W : VectorSpace F}
    (iso : LinearIsomorphism V W) : LinearIsomorphism W V :=
  LinearIsomorphism.symm iso

/-- Isomorphic vector spaces have the same dimension. -/
def iso_preserves_dimension {F : Field} {V W : VectorSpace F}
    (iso : LinearIsomorphism V W) : Prop :=
  dimension (V := F) V = dimension (V := F) W

/-- Composition of two isomorphisms gives isomorphism. -/
theorem iso_comp_is_iso {F : Field} {U V W : VectorSpace F}
    (f : LinearIsomorphism U V) (g : LinearIsomorphism V W) :
    LinearIsomorphism U W :=
  LinearIsomorphism.comp g f

/-! ## #eval -/

#eval "Morphisms.Hom: LinearIsomorphism (toMap, invMap, leftInv, rightInv)"
#eval "  - id, symm, comp, Automorphism"
#eval "  - Automorphism.groupLaws: assoc, id_comp, comp_id, inv_comp, comp_inv"
#eval "  - Properties: iso_trans, iso_refl, iso_symm, iso_comp_is_iso"

end MiniLinearTransformation
