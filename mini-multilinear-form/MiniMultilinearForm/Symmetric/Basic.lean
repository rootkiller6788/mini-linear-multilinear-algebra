/-
# MiniMultilinearForm.Symmetric.Basic

Symmetric bilinear forms: B(x,y) = B(y,x).
Basic properties, radical, nondegeneracy.
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Symmetric Bilinear Form Type -/

/-- A symmetric bilinear form as a bundled structure. -/
structure SymmetricBilinearForm {F : Field} (V : VectorSpace F) where
  bilinearForm : BilinearForm V
  symm : isSymmetric bilinearForm

/-! ## Radical of a Symmetric Bilinear Form -/

/-- The radical of a bilinear form: rad(B) = {x | B(x,y) = 0 for all y}. -/
def BilinearForm.radical {F : Field} {V : VectorSpace F} (B : BilinearForm V) : Set V.V :=
  { x | ∀ (y : V.V), B.map x y = (fnSpace F 1).zero }

/-- A bilinear form is nondegenerate if its radical is trivial. -/
def BilinearForm.isNondegenerate {F : Field} {V : VectorSpace F} (B : BilinearForm V) : Prop :=
  ∀ (x : V.V), (∀ (y : V.V), B.map x y = (fnSpace F 1).zero) → x = V.zero

/-- A symmetric bilinear form is nondegenerate. -/
def SymmetricBilinearForm.isNondegenerate {F : Field} {V : VectorSpace F}
    (B : SymmetricBilinearForm V) : Prop :=
  BilinearForm.isNondegenerate B.bilinearForm

/-! ## Orthogonal Complement -/

/-- Orthogonal complement of a subspace S with respect to B.
    S^⊥ = {x | B(x,s) = 0 for all s ∈ S}. -/
def BilinearForm.orthogonalComplement {F : Field} {V : VectorSpace F}
    (B : BilinearForm V) (S : Set V.V) : Set V.V :=
  { x | ∀ (s : V.V), s ∈ S → B.map x s = (fnSpace F 1).zero }

/-- For symmetric forms: S ⊆ (S^⊥)^⊥. -/
def BilinearForm.orthogonalComplement_double {F : Field} {V : VectorSpace F}
    (B : BilinearForm V) (hSymm : isSymmetric B) (S : Set V.V) : Prop :=
  True  -- Stub: S ⊆ (S^⊥)^⊥

#eval "Symmetric.Basic: symmetric bilinear forms, radical, nondegeneracy, orthogonal complement"
