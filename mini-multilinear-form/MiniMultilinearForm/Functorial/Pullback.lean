/-
# MiniMultilinearForm.Functorial.Pullback

Pullback of multilinear forms by linear maps:
given T: V→W and a multilinear form on W, get one on V.
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Pullback of Bilinear Form -/

/-- Pullback of a bilinear form B on W along T: V→W:
    (T*B)(x,y) = B(Tx, Ty). -/
def BilinearForm.pullback {F : Field} {V W : VectorSpace F}
    (B : BilinearForm W) (T : V.V → W.V) : BilinearForm V where
  map := fun x y => B.map (T x) (T y)
  linearFirst := by
    intro x y z
    sorry  -- Stub
  linearSecond := by
    intro x y z
    sorry  -- Stub
  smulCompat := by
    intro a x y
    rcases B.smulCompat a (T x) (T y) with ⟨hl, hr⟩
    constructor
    · simp [hl]
    · simp [hr]

/-! ## Pullback Preserves Properties -/

/-- Pullback of a symmetric bilinear form is symmetric. -/
def BilinearForm.pullbackSymmetric {F : Field} {V W : VectorSpace F}
    (B : BilinearForm W) (hSymm : isSymmetric B) (T : V.V → W.V) :
    isSymmetric (BilinearForm.pullback B T) := by
  intro x y
  simp [BilinearForm.pullback, hSymm x y]

/-- Pullback of an alternating bilinear form is alternating. -/
def BilinearForm.pullbackAlternating {F : Field} {V W : VectorSpace F}
    (B : BilinearForm W) (hAlt : isAlternating B) (T : V.V → W.V) :
    isAlternating (BilinearForm.pullback B T) := by
  intro x
  simp [BilinearForm.pullback, hAlt (T x)]

/-! ## Pullback of Multilinear Form -/

/-- Pullback of an n-linear form along a linear map. -/
def MultilinearForm.pullback {F : Field} {n : Nat} {V W : VectorSpace F}
    (φ : MultilinearForm n W) (T : V.V → W.V) : MultilinearForm n V :=
  φ  -- Stub

#eval "Functorial.Pullback: pullback of bilinear/multilinear forms along linear maps"
