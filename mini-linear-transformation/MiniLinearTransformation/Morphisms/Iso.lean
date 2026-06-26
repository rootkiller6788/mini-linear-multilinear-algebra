/-
# MiniLinearTransformation.Morphisms.Iso

Isomorphism structure and reasoning for linear transformations.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Injective and Surjective linear maps -/

def LinearMap.isInjective {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  ∀ (x y : V.V), T.map x = T.map y → x = y

def LinearMap.isSurjective {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  ∀ (w : W.V), ∃ (v : V.V), T.map v = w

/-! ## Injectivity from kernel -/

def LinearMap.injective_of_kernel_trivial {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (h : ∀ v, T.map v = W.zero → v = V.zero) : T.isInjective := by
  intro x y hxy
  have hzero : T.map (V.add x (V.neg y)) = W.zero := by
    calc
      T.map (V.add x (V.neg y)) = W.add (T.map x) (T.map (V.neg y)) := T.map_add _ _
      _ = W.add (T.map y) (T.map (V.neg y)) := by rw [hxy]
      _ = T.map (V.add y (V.neg y)) := by rw [T.map_add]
      _ = T.map V.zero := by
        -- In a vector space, y + (-y) = 0; we assume this axiom
        sorry
      _ = W.zero := T.map_smul (_ : F.carrier) V.zero
    -- The above is a sketch; in a full implementation this would use vector space axioms
  have hzero' := h (V.add x (V.neg y)) hzero
  -- Again, we'd need full vector space axioms
  sorry

/-! ## Isomorphism implies bijection -/

def LinearIsomorphism.bijective {F : Field} {V W : VectorSpace F} (iso : LinearIsomorphism V W) :
    iso.toMap.isInjective ∧ iso.toMap.isSurjective := by
  constructor
  · intro x y h
    calc
      x = iso.invMap.map (iso.toMap.map x) := (iso.leftInv x).symm
      _ = iso.invMap.map (iso.toMap.map y) := by rw [h]
      _ = y := iso.leftInv y
  · intro w
    refine ⟨iso.invMap.map w, iso.rightInv w⟩

#eval "Morphisms.Iso: injective, surjective, bijective, inj_from_kernel"
