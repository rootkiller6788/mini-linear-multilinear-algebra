/-
# MiniMultilinearForm.Multilinear.Basic

Multilinear maps of n arguments: definitions, basic operations,
composition, and evaluation.
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Operations on Multilinear Maps -/

/-- Zero multilinear map. -/
def MultilinearMap.zero {F : Field} (n : Nat) (V W : VectorSpace F) : MultilinearMap n V W where
  map := fun _ => W.zero
  multilinear := by
    intro i x y args
    simp [W.add_zero]

/-- Add two multilinear maps pointwise. -/
def MultilinearMap.add {F : Field} {n : Nat} {V W : VectorSpace F}
    (M₁ M₂ : MultilinearMap n V W) : MultilinearMap n V W where
  map := fun args => W.add (M₁.map args) (M₂.map args)
  multilinear := by
    intro i x y args
    simp [M₁.multilinear, M₂.multilinear, W.add_assoc, W.add_comm, W.add_left_comm]
    sorry  -- Stub

/-- Scalar multiplication of a multilinear map. -/
def MultilinearMap.smul {F : Field} {n : Nat} {V W : VectorSpace F}
    (a : F.carrier) (M : MultilinearMap n V W) : MultilinearMap n V W where
  map := fun args => W.smul a (M.map args)
  multilinear := by
    intro i x y args
    simp [M.multilinear, W.smul_add]
    sorry  -- Stub

/-! ## Composition with Linear Maps -/

/-- Precomposition with a linear map on each argument. -/
def MultilinearMap.precompose {F : Field} {n : Nat} {V₁ V₂ W : VectorSpace F}
    (M : MultilinearMap n V₂ W) (T : V₁.V → V₂.V) : MultilinearMap n V₁ W where
  map := fun args => M.map (fun i => T (args i))
  multilinear := by
    intro i x y args
    sorry  -- Stub

#eval "Multilinear.Basic: zero, add, smul, precomposition of multilinear maps"
