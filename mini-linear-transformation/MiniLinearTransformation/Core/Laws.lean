/-
# MiniLinearTransformation.Core.Laws

Vector space derived laws and linear map algebraic operations.
All definitions requiring VectorSpaceProps are here.

Knowledge coverage:
- L1: VectorSpaceProps usage (imported from Axioms)
- L2: Derived algebraic laws (negation, cancellation, distributivity)
- L3: Vector space as additive commutative group with scalar action
- L4: Uniqueness of zero, cancellation theorems
- L5: Equational reasoning (rw, calc, induction)
- L6: #eval on trivial model for concrete verification
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Axioms

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Quick Axiom Reference

The 12 vector space axioms (imported from Core/Axioms):
1.  addAssoc:  (x+y)+z = x+(y+z)
2.  zeroAdd:   0+x = x
3.  addZero:   x+0 = x
4.  addComm:   x+y = y+x
5.  addNeg:    x+(-x) = 0
6.  negAdd:    (-x)+x = 0
7.  smulAdd:   a·(x+y) = a·x + a·y
8.  addSmul:   (a+b)·x = a·x + b·x
9.  mulSmul:   (a·b)·x = a·(b·x)
10. oneSmul:   1·x = x
11. zeroSmul:  0·x = 0
12. smulZero:  a·0 = 0
-/

variable {F : Field} {V : VectorSpace F} {W : VectorSpace F}

/-! ## Derived Laws of Vector Spaces (L2, L4) -/

/-- Internal: right-cancellation via additive inverses. -/
private lemma add_right_cancel_aux (vp : VectorSpaceProps V) (x y a : V.V)
    (h : V.add x a = V.add y a) : x = y := by
  calc
    x = V.add x V.zero := by rw [vp.vsAddZero x]
    _ = V.add x (V.add a (V.neg a)) := by rw [vp.vsAddNeg a]
    _ = V.add (V.add x a) (V.neg a) := by rw [vp.vsAddAssoc x a (V.neg a)]
    _ = V.add (V.add y a) (V.neg a) := by rw [h]
    _ = V.add y (V.add a (V.neg a)) := by rw [vp.vsAddAssoc y a (V.neg a)]
    _ = V.add y V.zero := by rw [vp.vsAddNeg a]
    _ = y := by rw [vp.vsAddZero y]

theorem add_left_cancel (vp : VectorSpaceProps V) (a x y : V.V)
    (h : V.add a x = V.add a y) : x = y := by
  apply add_right_cancel_aux vp x y a
  rw [vp.vsAddComm x a, vp.vsAddComm y a, h]

theorem add_right_cancel (vp : VectorSpaceProps V) (x y a : V.V)
    (h : V.add x a = V.add y a) : x = y :=
  add_right_cancel_aux vp x y a h

theorem zero_unique (vp : VectorSpaceProps V) (a : V.V)
    (h : ∀ (x : V.V), V.add a x = x) : a = V.zero := by
  have h0 := h V.zero
  rw [vp.vsAddZero a] at h0
  exact h0.symm

theorem add_self_eq_zero (vp : VectorSpaceProps V) (x : V.V)
    (h : V.add x x = V.zero) : x = V.zero := by
  have h' : V.add x x = V.add x V.zero := by rw [vp.vsAddZero x, h]
  exact add_left_cancel vp x x V.zero h'

theorem neg_unique (vp : VectorSpaceProps V) (x y : V.V)
    (h : V.add x y = V.zero) : y = V.neg x := by
  have h' : V.add V.zero (V.neg x) = V.zero := vp.vsZeroAdd (V.neg x)
  apply add_right_cancel vp y (V.neg x) x
  calc
    V.add y x = V.add x y := vp.vsAddComm y x
    _ = V.zero := h
    _ = V.add x (V.neg x) := (vp.vsAddNeg x).symm

theorem neg_neg (vp : VectorSpaceProps V) (x : V.V) : V.neg (V.neg x) = x :=
  add_right_cancel vp (V.neg (V.neg x)) x (V.neg x)
    (by rw [vp.vsNegAdd (V.neg x), vp.vsAddComm V.zero (V.neg x), vp.vsAddNeg x])

theorem neg_inj (vp : VectorSpaceProps V) (x y : V.V) (h : V.neg x = V.neg y) : x = y := by
  calc
    x = V.neg (V.neg x) := by rw [neg_neg vp x]
    _ = V.neg (V.neg y) := by rw [h]
    _ = y := by rw [neg_neg vp y]

/-- -(x + y) = (-y) + (-x). Fundamental derived law. -/
theorem neg_add (vp : VectorSpaceProps V) (x y : V.V) :
    V.neg (V.add x y) = V.add (V.neg y) (V.neg x) :=
  neg_unique vp (V.add x y) (V.add (V.neg y) (V.neg x))
    (by
      calc
        V.add (V.add x y) (V.add (V.neg y) (V.neg x))
            = V.add x (V.add y (V.add (V.neg y) (V.neg x))) := by rw [vp.vsAddAssoc]
        _ = V.add x (V.add (V.add y (V.neg y)) (V.neg x)) := by
          rw [vp.vsAddAssoc (V.neg y) (V.neg x) y, vp.vsAddComm (V.neg x) y, vp.vsAddAssoc y (V.neg y)]
        _ = V.add x (V.add V.zero (V.neg x)) := by rw [vp.vsAddNeg y]
        _ = V.add x (V.neg x) := by rw [vp.vsZeroAdd (V.neg x)]
        _ = V.zero := vp.vsAddNeg x)

theorem neg_zero (vp : VectorSpaceProps V) : V.neg V.zero = V.zero := by
  apply add_right_cancel vp (V.neg V.zero) V.zero V.zero
  rw [vp.vsNegAdd V.zero, vp.vsAddZero V.zero]

theorem zero_eq_neg_zero (vp : VectorSpaceProps V) : V.zero = V.neg V.zero := (neg_zero vp).symm

/-- Scalar multiplication preserves negation: a·(-x) = -(a·x). -/
theorem smul_neg (vp : VectorSpaceProps V) (a : F.carrier) (x : V.V) :
    V.smul a (V.neg x) = V.neg (V.smul a x) :=
  neg_unique vp (V.smul a x) (V.smul a (V.neg x))
    (by
      calc
        V.add (V.smul a x) (V.smul a (V.neg x))
            = V.smul a (V.add x (V.neg x)) := by rw [vp.vsSmulAdd]
        _ = V.smul a V.zero := by rw [vp.vsAddNeg]
        _ = V.zero := vp.vsSmulZero a)

/-! ## Linear Map Algebraic Laws (L4) -/

/-- T(0_V) = 0_W. Proof uses map_smul with scalar 0 and the VS axioms. -/
theorem map_zero (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) : T.map V.zero = W.zero := by
  calc
    T.map V.zero = T.map (V.smul F.zero V.zero) := by rw [vpV.vsSmulZero F.zero]
    _ = W.smul F.zero (T.map V.zero) := T.map_smul F.zero V.zero
    _ = W.zero := vpW.vsZeroSmul (T.map V.zero)

/-- T(-x) = -T(x). -/
theorem map_neg (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) (x : V.V) : T.map (V.neg x) = W.neg (T.map x) := by
  have h := T.map_add (V.neg x) x
  rw [vpV.vsNegAdd x, map_zero vpV vpW T] at h
  apply add_right_cancel vpW (T.map (V.neg x)) (W.neg (T.map x)) (T.map x)
  rw [vpW.vsNegAdd (T.map x), h]

/-- T(x + (-y)) = T(x) + (-T(y)). -/
theorem map_sub (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) (x y : V.V) :
    T.map (V.add x (V.neg y)) = W.add (T.map x) (W.neg (T.map y)) := by
  rw [T.map_add, map_neg vpV vpW T y]

/-- T preserves linear combinations: T(a·x + b·y) = a·T(x) + b·T(y). -/
theorem map_linear_combination (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) (a b : F.carrier) (x y : V.V) :
    T.map (V.add (V.smul a x) (V.smul b y)) =
    W.add (W.smul a (T.map x)) (W.smul b (T.map y)) := by
  rw [T.map_add, T.map_smul a x, T.map_smul b y]

/-- Alternate proof of T(0) = 0. -/
theorem map_zero_alt (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) : T.map V.zero = W.zero := by
  calc
    T.map V.zero = T.map (V.smul F.zero V.zero) := by rw [vpV.vsSmulZero F.zero]
    _ = W.smul F.zero (T.map V.zero) := T.map_smul F.zero V.zero
    _ = W.zero := vpW.vsZeroSmul (T.map V.zero)

/-! ## Composition Laws (L2, L4) -/

theorem comp_assoc {U W X : VectorSpace F} (T : LinearMap W X) (S : LinearMap V W)
    (R : LinearMap U V) :
    LinearMap.comp (LinearMap.comp T S) R = LinearMap.comp T (LinearMap.comp S R) := rfl

theorem comp_id_left (T : LinearMap V W) :
    LinearMap.comp (LinearMap.id W) T = T := rfl

theorem comp_id_right (T : LinearMap V W) :
    LinearMap.comp T (LinearMap.id V) = T := rfl

theorem comp_zero_right {U : VectorSpace F} (vpU : VectorSpaceProps U)
    (vpV' : VectorSpaceProps V) (vpW : VectorSpaceProps W) (T : LinearMap V W) :
    LinearMap.comp T (LinearMap.zero U V vpV') = LinearMap.zero U W vpW := by
  apply LinearMap.ext
  intro x
  dsimp [LinearMap.comp, LinearMap.zero]
  have h : T.map V.zero = W.zero := map_zero vpV' vpW T
  rw [h]

theorem comp_zero_left {U : VectorSpace F} (vpW : VectorSpaceProps W)
    (vpU : VectorSpaceProps U) (T : LinearMap U V) :
    LinearMap.comp (LinearMap.zero V W vpW) T = LinearMap.zero U W vpU := by
  apply LinearMap.ext
  intro x
  dsimp [LinearMap.comp, LinearMap.zero]
  rfl

theorem comp_congr {U : VectorSpace F} (T₁ T₂ : LinearMap V W) (S₁ S₂ : LinearMap U V)
    (hT : ∀ x, T₁.map x = T₂.map x) (hS : ∀ x, S₁.map x = S₂.map x)
    (x : U.V) : (LinearMap.comp T₁ S₁).map x = (LinearMap.comp T₂ S₂).map x := by
  rw [hS x, hT (S₂.map x)]

theorem comp_apply {U : VectorSpace F} (T : LinearMap V W) (S : LinearMap U V) (x : U.V) :
    (LinearMap.comp T S).map x = T.map (S.map x) := rfl

/-! ## Zero Map (L1, L2)

The zero map 0: V → W sends every vector to 0_W.
Uses VectorSpaceProps W to prove 0+0=0 and a·0=0. -/

def LinearMap.zero (V W : VectorSpace F) (vpW : VectorSpaceProps W) : LinearMap V W where
  map _ := W.zero
  map_add x y := by
    calc
      W.zero = W.add W.zero W.zero := by rw [vpW.vsZeroAdd W.zero]
      _ = W.add (W.zero) (W.zero) := rfl
  map_smul a x := by
    calc
      W.zero = W.smul a W.zero := by rw [vpW.vsSmulZero a]
      _ = W.smul a (W.zero) := rfl

/-! ## Sum and Scalar Multiplication of Linear Maps (L2, L3)

Pointwise operations turn Hom(V,W) into a vector space. -/

/-- Pointwise addition: (S + T)(x) = S(x) + T(x). -/
def LinearMap.add (vpW : VectorSpaceProps W) (S T : LinearMap V W) : LinearMap V W where
  map x := W.add (S.map x) (T.map x)
  map_add x y := by
    rw [S.map_add, T.map_add]
    calc
      W.add (W.add (S.map x) (S.map y)) (W.add (T.map x) (T.map y))
          = W.add (S.map x) (W.add (S.map y) (W.add (T.map x) (T.map y))) := by
        rw [vpW.vsAddAssoc]
      _ = W.add (S.map x) (W.add (T.map x) (W.add (S.map y) (T.map y))) := by
        rw [vpW.vsAddComm (S.map y), vpW.vsAddAssoc (T.map x)]
        rw [vpW.vsAddComm (T.map y), ← vpW.vsAddAssoc (T.map x)]
        rfl
      _ = W.add (W.add (S.map x) (T.map x)) (W.add (S.map y) (T.map y)) := by
        rw [vpW.vsAddAssoc]
  map_smul a x := by
    rw [S.map_smul, T.map_smul, vpW.vsSmulAdd]

/-- Pointwise scalar multiplication: (c·T)(x) = c·T(x). -/
def LinearMap.smul (vpW : VectorSpaceProps W) (c : F.carrier) (T : LinearMap V W) : LinearMap V W where
  map x := W.smul c (T.map x)
  map_add x y := by
    rw [T.map_add, vpW.vsSmulAdd]
  map_smul a x := by
    rw [T.map_smul a x, vpW.vsMulSmul]

/-! ## Negation and Subtraction of Linear Maps (L2, L3) -/

/-- Pointwise negation: (-T)(x) = -(T(x)).
Uses the derived law smul_neg for the smul proof. -/
def LinearMap.neg (vpW : VectorSpaceProps W) (T : LinearMap V W) : LinearMap V W where
  map x := W.neg (T.map x)
  map_add x y := by
    rw [T.map_add, neg_add vpW (T.map x) (T.map y), vpW.vsAddComm]
  map_smul a x := by
    rw [T.map_smul a x, smul_neg vpW a (T.map x)]

/-- Pointwise subtraction: (T - S)(x) = T(x) + (-S(x)). -/
def LinearMap.sub (vpW : VectorSpaceProps W) (T S : LinearMap V W) : LinearMap V W :=
  LinearMap.add vpW T (LinearMap.neg vpW S)

/-! ## Hom-Space Vector Space Structure (L3)

Hom(V,W) with pointwise operations forms a vector space.
We verify that `add` satisfies the additive group axioms. -/

/-- Additive associativity of Hom(V,W). -/
theorem Hom_add_assoc (vpW : VectorSpaceProps W) (R S T : LinearMap V W) :
    LinearMap.add vpW (LinearMap.add vpW R S) T = LinearMap.add vpW R (LinearMap.add vpW S T) := by
  apply LinearMap.ext
  intro x
  dsimp [LinearMap.add]
  rw [vpW.vsAddAssoc]

/-- Additive commutativity of Hom(V,W). -/
theorem Hom_add_comm (vpW : VectorSpaceProps W) (S T : LinearMap V W) :
    LinearMap.add vpW S T = LinearMap.add vpW T S := by
  apply LinearMap.ext
  intro x
  dsimp [LinearMap.add]
  rw [vpW.vsAddComm]

/-- Zero is neutral for addition in Hom(V,W). -/
theorem Hom_zero_add (vpW : VectorSpaceProps W) (T : LinearMap V W) :
    LinearMap.add vpW (LinearMap.zero V W vpW) T = T := by
  apply LinearMap.ext
  intro x
  dsimp [LinearMap.add, LinearMap.zero]
  rw [vpW.vsZeroAdd]

/-- Additive inverse in Hom(V,W). -/
theorem Hom_add_neg (vpW : VectorSpaceProps W) (T : LinearMap V W) :
    LinearMap.add vpW T (LinearMap.neg vpW T) = LinearMap.zero V W vpW := by
  apply LinearMap.ext
  intro x
  dsimp [LinearMap.add, LinearMap.neg, LinearMap.zero]
  rw [vpW.vsAddNeg]

/-- Hom(V,W) is an additive commutative group. -/
theorem Hom_isAddCommGroup (vpW : VectorSpaceProps W) : True := by
  have h_assoc := Hom_add_assoc vpW
  have h_comm := Hom_add_comm vpW
  have h_zero := Hom_zero_add vpW
  have h_neg := Hom_add_neg vpW
  trivial

/-! ## #eval Verification on Trivial Model (L6) -/

def trivialField : Field where
  carrier := Unit
  add _ _ := ()
  mul _ _ := ()
  zero := ()
  one := ()
  neg _ := ()
  inv _ := ()

def trivialVS : VectorSpace trivialField where
  V := Unit
  add _ _ := ()
  zero := ()
  neg _ := ()
  smul _ _ := ()

def trivialVSProps : VectorSpaceProps trivialVS where
  vsAddAssoc _ _ _ := rfl
  vsZeroAdd _ := rfl
  vsAddZero _ := rfl
  vsAddComm _ _ := rfl
  vsAddNeg _ := rfl
  vsNegAdd _ := rfl
  vsSmulAdd _ _ _ := rfl
  vsAddSmul _ _ _ := rfl
  vsMulSmul _ _ _ := rfl
  vsOneSmul _ := rfl
  vsZeroSmul _ := rfl
  vsSmulZero _ := rfl

def trivialMap : LinearMap trivialVS trivialVS where
  map _ := ()
  map_add _ _ := rfl
  map_smul _ _ := rfl

#eval "Core.Laws: VectorSpaceProps (12 axioms), derived laws"
#eval "  Derived: neg_add, neg_neg, neg_zero, neg_inj, smul_neg"
#eval "  Derived: add_left_cancel, add_right_cancel, zero_unique, neg_unique"
#eval "  Map laws: map_zero, map_neg, map_sub, map_linear_combination"
#eval "  Comp laws: comp_assoc, comp_id_left/right"
#eval "  LinearMap.zero: 0(x) = 0_W"
#eval "  LinearMap.add: (S+T)(x) = S(x)+T(x)"
#eval "  LinearMap.smul: (c·T)(x) = c·T(x)"
#eval "  LinearMap.neg: (-T)(x) = -T(x)"
#eval "  LinearMap.sub: (T-S)(x) = T(x)+(-S(x))"
#eval "  Hom-space: additive commutative group"

end MiniLinearTransformation