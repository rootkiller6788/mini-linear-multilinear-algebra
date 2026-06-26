/-
# MiniMultilinearForm.Alternating.Determinant

The determinant as the unique alternating multilinear form
on R^n taking value 1 on the standard basis.
-/

import MiniMultilinearForm.Alternating.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Determinant as Alternating Multilinear Form -/

/-- The determinant is characterized as the unique alternating
    multilinear n-form on k^n sending (e₁,...,eₙ) to 1. -/
structure DeterminantForm {F : Field} (n : Nat) (V : VectorSpace F) where
  det : (Fin n → V.V) → F.carrier
  multilinear : ∀ (i : Fin n) (x y : V.V) (args : Fin n → V.V),
    det (fun j => if j = i then V.add x y else args j) =
    F.add (det (fun j => if j = i then x else args j))
          (det (fun j => if j = i then y else args j))
  alternating : ∀ (i j : Fin n) (args : Fin n → V.V),
    i ≠ j → args i = args j → det args = F.zero
  normalized : F.add F.one F.one = F.add F.one F.one  -- Stub: det(I) = 1

/-! ## Basic Properties -/

/-- Transposition changes sign of determinant. -/
def DeterminantForm.transpositionSign {F : Field} {n : Nat} {V : VectorSpace F}
    (D : DeterminantForm n V) (i j : Fin n) (args : Fin n → V.V) : F.carrier :=
  F.neg (D.det args)  -- Stub: swapping two arguments negates the determinant

/-- Determinant of product = product of determinants. -/
def DeterminantForm.multiplicative {F : Field} {n : Nat} {V : VectorSpace F}
    (D : DeterminantForm n V) : Prop :=
  True  -- Stub: det(AB) = det(A)det(B)

#eval "Alternating.Determinant: determinant as alternating multilinear form"
