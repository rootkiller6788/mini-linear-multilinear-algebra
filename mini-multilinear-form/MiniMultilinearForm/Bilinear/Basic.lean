/-
# MiniMultilinearForm.Bilinear.Basic

Basic properties of bilinear maps and bilinear forms:
zero map, addition of bilinear maps, scalar multiplication.
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Zero Bilinear Map -/

def BilinearMap.zero {F : Field} {V₁ V₂ W : VectorSpace F} : BilinearMap V₁ V₂ W where
  map := fun _ _ => W.zero
  linearFirst := by
    intro x y z
    simp [W.add_zero]
  linearSecond := by
    intro x y z
    simp [W.add_zero]
  smulCompat := by
    intro a x y
    simp [W.smul_zero, W.zero_smul]

/-! ## Addition of Bilinear Maps -/

def BilinearMap.add {F : Field} {V₁ V₂ W : VectorSpace F} (B₁ B₂ : BilinearMap V₁ V₂ W) : BilinearMap V₁ V₂ W where
  map := fun x y => W.add (B₁.map x y) (B₂.map x y)
  linearFirst := by
    intro x y z
    simp [B₁.linearFirst, B₂.linearFirst, W.add_assoc, W.add_comm]
  linearSecond := by
    intro x y z
    simp [B₁.linearSecond, B₂.linearSecond, W.add_assoc, W.add_comm]
  smulCompat := by
    intro a x y
    rcases B₁.smulCompat a x y with ⟨h₁l, h₁r⟩
    rcases B₂.smulCompat a x y with ⟨h₂l, h₂r⟩
    constructor
    · simp [h₁l, h₂l, W.smul_add]
    · simp [h₁r, h₂r, W.smul_add]

/-! ## Scalar Multiplication of Bilinear Map -/

def BilinearMap.smul {F : Field} {V₁ V₂ W : VectorSpace F} (a : F.carrier) (B : BilinearMap V₁ V₂ W) : BilinearMap V₁ V₂ W where
  map := fun x y => W.smul a (B.map x y)
  linearFirst := by
    intro x y z
    simp [B.linearFirst, W.smul_add]
  linearSecond := by
    intro x y z
    simp [B.linearSecond, W.smul_add]
  smulCompat := by
    intro b x y
    rcases B.smulCompat b x y with ⟨hl, hr⟩
    constructor
    · simp [hl, W.smul_mul_smul]
    · simp [hr, W.smul_mul_smul]

#eval "Bilinear.Basic: zero, add, smul operations on bilinear maps"
