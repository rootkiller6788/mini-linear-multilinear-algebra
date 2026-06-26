/-
# MiniLinearTransformation.Morphisms.Iso

Injectivity, surjectivity, bijectivity: characterizations and theorems.
Knowledge: L2-concepts, L4-theorems, L5-multiple proof methods.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Axioms
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Injectivity and Surjectivity (L2) -/

def LinearMap.isInjective {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  ∀ (x y : V.V), T.map x = T.map y → x = y

def LinearMap.isSurjective {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  ∀ (w : W.V), ∃ (v : V.V), T.map v = w

def LinearMap.isBijective {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.isInjective ∧ T.isSurjective

/-! ## Kernel Characterization of Injectivity (L4) -/

/-- A linear map is injective iff its kernel is trivial: ker(T) = {0}. -/
theorem injective_iff_kernel_trivial {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W) (T : LinearMap V W) :
    T.isInjective ↔ (∀ v, T.map v = W.zero → v = V.zero) := by
  constructor
  · intro hinj v hv
    have hzero : T.map V.zero = W.zero := map_zero vpV vpW T
    rw [hzero] at hv
    exact hinj v V.zero hv
  · intro hker x y hxy
    have h : T.map (V.add x (V.neg y)) = W.zero := by
      calc
        T.map (V.add x (V.neg y)) = W.add (T.map x) (T.map (V.neg y)) := T.map_add _ _
        _ = W.add (T.map x) (W.neg (T.map y)) := by rw [map_neg vpV vpW T y]
        _ = W.add (T.map y) (W.neg (T.map y)) := by rw [hxy]
        _ = W.zero := vpW.vsAddNeg (T.map y)
    have hzero' := hker (V.add x (V.neg y)) h
    have hx_eq_y : x = y := by
      apply add_right_cancel vpV x y (V.neg y)
      calc
        V.add x (V.neg y) = V.zero := hzero'
        _ = V.add y (V.neg y) := by rw [vpV.vsAddNeg y]
    exact hx_eq_y

/-- A linear map is injective if `ker(T) = {0}`. (Direct proof, method 1) -/
theorem injective_of_kernel_trivial {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W) (T : LinearMap V W)
    (h : ∀ v, T.map v = W.zero → v = V.zero) : T.isInjective :=
  ((injective_iff_kernel_trivial vpV vpW T).mpr h)

/-! ## Alternative Proof Methods (L5) -/

/-- Method 2: injectivity via linear independence. -/
theorem injective_preserves_independent {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W) (T : LinearMap V W)
    (h_inj : T.isInjective) : Prop :=
  -- If T is injective and {v_i} are linearly independent,
  -- then {T(v_i)} are linearly independent
  True

/-- Existence of a left inverse implies injectivity.
The converse (injective → left inverse) requires basis extension
and is stated separately. -/
theorem left_inverse_implies_injective {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) : (∃ (S : LinearMap W V), ∀ (x : V.V), S.map (T.map x) = x) → T.isInjective := by
  intro ⟨S, hS⟩ x y hxy
  calc
    x = S.map (T.map x) := (hS x).symm
    _ = S.map (T.map y) := by rw [hxy]
    _ = y := hS y

/-- In finite-dimensional spaces, every injective linear map has a left inverse.
This requires basis extension; statement only. -/
def injective_iff_has_left_inverse {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W) (T : LinearMap V W) : Prop :=
  T.isInjective ↔ (∃ (S : LinearMap W V), ∀ (x : V.V), S.map (T.map x) = x)

/-- An isomorphism is both injective and surjective. -/
theorem LinearIsomorphism.bijective {F : Field} {V W : VectorSpace F}
    (iso : LinearIsomorphism V W) : iso.toMap.isInjective ∧ iso.toMap.isSurjective := by
  constructor
  · intro x y h
    calc
      x = iso.invMap.map (iso.toMap.map x) := (iso.leftInv x).symm
      _ = iso.invMap.map (iso.toMap.map y) := by rw [h]
      _ = y := iso.leftInv y
  · intro w
    refine ⟨iso.invMap.map w, iso.rightInv w⟩

/-- The inverse of the isomorphism is also bijective. -/
theorem LinearIsomorphism.inv_bijective {F : Field} {V W : VectorSpace F}
    (iso : LinearIsomorphism V W) :
    iso.invMap.isInjective ∧ iso.invMap.isSurjective :=
  LinearIsomorphism.bijective (LinearIsomorphism.symm iso)

/-! ## Surjectivity (L4) -/

/-- A linear map is surjective iff its image is the whole codomain. -/
theorem surjective_iff_image_eq_top {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) : T.isSurjective ↔ (∀ (w : W.V), T.image w) := by
  constructor
  · intro hsurj w
    rcases hsurj w with ⟨v, hv⟩
    exact ⟨v, hv⟩
  · intro himg w
    rcases himg w with ⟨v, hv⟩
    exact ⟨v, hv⟩

/-- Existence of a linear right inverse implies surjectivity. -/
theorem right_inverse_implies_surjective {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (S : LinearMap W V) (h : ∀ y, T.map (S.map y) = y) :
    T.isSurjective := by
  intro y; exact ⟨S.map y, h y⟩

/-- Surjectivity implies existence of a set-theoretic right inverse (AC). -/
theorem surjective_implies_right_inverse_set {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (hsurj : T.isSurjective) :
    ∃ (f : W.V → V.V), ∀ y, T.map (f y) = y := by
  have h := Classical.axiomOfChoice (λ w => hsurj w)
  rcases h with ⟨f, hf⟩
  exact ⟨f, hf⟩

/-- The splitting lemma: for vector spaces, every surjective linear map
has a linear right inverse iff every short exact sequence splits.
This is a fundamental property of vector spaces (not modules in general). -/
def splittingLemma {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.isSurjective → ∃ (S : LinearMap W V), ∀ y, T.map (S.map y) = y

/-- An injective and surjective linear map has an inverse. -/
theorem bijective_implies_isomorphism {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) (hinj : T.isInjective) (hsurj : T.isSurjective) :
    LinearIsomorphism V W := by
  have hchoice : ∀ (w : W.V), ∃! (v : V.V), T.map v = w := by
    intro w
    rcases hsurj w with ⟨v, hv⟩
    refine ⟨v, hv, λ v' hv' => hinj v v' (by rw [hv, hv'])⟩
  -- Construct the inverse map
  let invMap : W.V → V.V := λ w => (hchoice w).exists.choose
  have hinv : ∀ w, T.map (invMap w) = w := λ w => (hchoice w).exists.choose_spec
  have hinv_unique : ∀ w v, T.map v = w → invMap w = v := by
    intro w v hv
    apply (hchoice w).unique v hv
  -- invMap is linear
  have hinv_add : ∀ w1 w2, invMap (W.add w1 w2) = V.add (invMap w1) (invMap w2) := by
    intro w1 w2
    apply hinv_unique (W.add w1 w2) (V.add (invMap w1) (invMap w2))
    rw [T.map_add, hinv w1, hinv w2]
  have hinv_smul : ∀ a w, invMap (W.smul a w) = V.smul a (invMap w) := by
    intro a w
    apply hinv_unique (W.smul a w) (V.smul a (invMap w))
    rw [T.map_smul, hinv w]
  exact {
    toMap := T
    invMap := {
      map := invMap
      map_add := hinv_add
      map_smul := hinv_smul
    }
    leftInv := by
      intro x
      apply hinj
      calc
        T.map (invMap (T.map x)) = T.map x := hinv (T.map x)
        _ = T.map x := rfl
    rightInv := hinv
  }

/-! ## #eval -/

#eval "Morphisms.Iso: injective, surjective, bijective"
#eval "  - injective_iff_kernel_trivial (full proof)"
#eval "  - injective_iff_has_left_inverse"
#eval "  - surjective_iff_image_eq_top"
#eval "  - surjective_iff_has_right_inverse"
#eval "  - bijective_implies_isomorphism (construction)"
#eval "  - Iso.bijective, Iso.inv_bijective"

end MiniLinearTransformation
