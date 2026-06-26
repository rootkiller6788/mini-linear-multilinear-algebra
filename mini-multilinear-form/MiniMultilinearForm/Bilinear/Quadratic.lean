/-
# MiniMultilinearForm.Bilinear.Quadratic

Quadratic forms: q(x) = B(x,x) for a bilinear form B.
Relation between bilinear forms and quadratic forms over fields of characteristic ≠ 2.
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Quadratic Form -/

/-- A quadratic form is a function q: V → F satisfying:
    q(ax) = a² q(x) and the polarization identity yields a bilinear form. -/
structure QuadraticForm {F : Field} (V : VectorSpace F) where
  q : V.V → F.carrier
  homogeneous : ∀ (a : F.carrier) (x : V.V),
    q (V.smul a x) = F.mul (F.mul a a) (q x)  -- q(ax) = a² q(x)
  polarBilinear : ∀ (x y : V.V),
    q (V.add x y) = F.add (F.add (q x) (q y))
      (F.mul (F.add F.one F.one) (polarForm q x y))
  -- This is a stub; proper definition requires characteristic ≠ 2

/-- The polarization of a quadratic form: B(x,y) = (q(x+y) - q(x) - q(y)) / 2 -/
def QuadraticForm.polarForm {F : Field} {V : VectorSpace F}
    (q : V.V → F.carrier) (x y : V.V) : F.carrier :=
  F.zero  -- Stub

/-- Every bilinear form gives a quadratic form via q(x) = B(x,x). -/
def BilinearForm.toQuadraticForm {F : Field} {V : VectorSpace F}
    (B : BilinearForm V) : QuadraticForm V where
  q := fun x => B.map x x
  homogeneous := by
    intro a x
    rcases B.smulCompat a x x with ⟨hl, hr⟩
    simp [hl]
  polarBilinear := by
    intro x y
    sorry  -- Stub

/-- Isotropic vector: x ≠ 0 such that q(x) = 0 -/
def QuadraticForm.isIsotropic {F : Field} {V : VectorSpace F}
    (q : QuadraticForm V) (x : V.V) : Prop :=
  x ≠ V.zero ∧ q.q x = F.zero

/-- Positive definite quadratic form (over ℝ). -/
def QuadraticForm.isPositiveDefinite {F : Field} {V : VectorSpace F}
    (q : QuadraticForm V) : Prop :=
  ∀ (x : V.V), x ≠ V.zero → F.lt F.zero (q.q x)  -- Stub: requires ordered field

#eval "Bilinear.Quadratic: quadratic forms and polarization"
