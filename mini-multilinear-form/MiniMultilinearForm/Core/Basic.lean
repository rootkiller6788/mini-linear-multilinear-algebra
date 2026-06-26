/-
# MiniMultilinearForm.Core.Basic

Multilinear forms: bilinear maps, multilinear maps,
symmetric/skew-symmetric/alternating forms.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Bilinear Map -/

structure BilinearMap {F : Field} (V₁ V₂ W : VectorSpace F) where
  map : V₁.V → V₂.V → W.V
  linearFirst : ∀ (x y : V₁.V) (z : V₂.V),
    map (V₁.add x y) z = W.add (map x z) (map y z)
  linearSecond : ∀ (x : V₁.V) (y z : V₂.V),
    map x (V₂.add y z) = W.add (map x y) (map x z)
  smulCompat : ∀ (a : F.carrier) (x : V₁.V) (y : V₂.V),
    map (V₁.smul a x) y = W.smul a (map x y) ∧ map x (V₂.smul a y) = W.smul a (map x y)

/-! ## Bilinear Form (scalar-valued) -/

def BilinearForm {F : Field} (V : VectorSpace F) : Type _ :=
  BilinearMap V V (fnSpace F 1)

/-! ## Symmetric Bilinear Form -/

def isSymmetric {F : Field} {V : VectorSpace F} (B : BilinearForm V) : Prop :=
  ∀ (x y : V.V), B.map x y = B.map y x

/-! ## Skew-Symmetric Bilinear Form -/

def isSkewSymmetric {F : Field} {V : VectorSpace F} (B : BilinearForm V) : Prop :=
  ∀ (x y : V.V), B.map x y = (fnSpace F 1).neg (B.map y x)
  -- B(x,y) = -B(y,x)

/-! ## Alternating Bilinear Form -/

def isAlternating {F : Field} {V : VectorSpace F} (B : BilinearForm V) : Prop :=
  ∀ (x : V.V), B.map x x = (fnSpace F 1).zero

/-! ## Multilinear Map (of n arguments) -/

structure MultilinearMap {F : Field} (n : Nat) (V : VectorSpace F) (W : VectorSpace F) where
  map : (Fin n → V.V) → W.V
  multilinear : ∀ (i : Fin n) (x y : V.V) (args : Fin n → V.V),
    map (fun j => if j = i then V.add x y else args j) =
    W.add (map (fun j => if j = i then x else args j))
          (map (fun j => if j = i then y else args j))

/-! ## Multilinear Form (scalar-valued, n-ary) -/

def MultilinearForm {F : Field} (n : Nat) (V : VectorSpace F) : Type _ :=
  MultilinearMap n V (fnSpace F 1)

/-! ## Determinant as an Alternating Multilinear Form (conceptual) -/

def DeterminantForm {F : Field} (n : Nat) : Prop :=
  ∃ (V : VectorSpace F), True  -- det : V^n → F is alternating multilinear

#eval "Core.Basic: BilinearMap, BilinearForm, Symmetric, SkewSym, Alternating, MultilinearMap"
