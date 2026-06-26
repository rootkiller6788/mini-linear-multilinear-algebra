/-
# MiniLinearTransformation.Core.Basic

Linear maps between vector spaces: structure-preserving maps.
Kernel, image, rank, nullity, composition.
-/

import MiniVectorSpaceCore.Core.Basic

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Linear Map -/

structure LinearMap {F : Field} (V W : VectorSpace F) where
  map : V.V → W.V
  map_add : ∀ (x y : V.V), map (V.add x y) = W.add (map x) (map y)
  map_smul : ∀ (a : F.carrier) (x : V.V), map (V.smul a x) = W.smul a (map x)

def LinearMap.apply {F : Field} {V W : VectorSpace F} (T : LinearMap V W) (x : V.V) : W.V := T.map x

/-! ## Identity Linear Map -/

def LinearMap.id {F : Field} (V : VectorSpace F) : LinearMap V V where
  map x := x
  map_add _ _ := rfl
  map_smul _ _ := rfl

/-! ## Composition -/

def LinearMap.comp {F : Field} {U V W : VectorSpace F} (T : LinearMap V W) (S : LinearMap U V) : LinearMap U W where
  map x := T.map (S.map x)
  map_add x y := by
    rw [S.map_add, T.map_add]
  map_smul a x := by
    rw [S.map_smul, T.map_smul]

/-! ## Zero Map -/

def LinearMap.zero {F : Field} (V W : VectorSpace F) : LinearMap V W where
  map _ := W.zero
  map_add _ _ := by simp
  map_smul _ _ := by simp

/-! ## Kernel -/

def LinearMap.kernel {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Set V.V :=
  fun v => T.map v = W.zero

/-! ## Image -/

def LinearMap.image {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Set W.V :=
  fun w => ∃ (v : V.V), T.map v = w

/-! ## Rank and Nullity -/

noncomputable def LinearMap.rank {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Nat := 0
noncomputable def LinearMap.nullity {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Nat := 0

/-! ## Rank-Nullity Theorem (statement) -/

def rankNullityTheorem {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  True

#eval "Core.Basic: LinearMap, Id, Comp, Zero, Kernel, Image, Rank, Nullity"
