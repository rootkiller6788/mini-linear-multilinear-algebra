/-
# MiniMultilinearForm.Functorial.Duality

Duality for bilinear and multilinear forms:
correspondence between bilinear forms and linear maps V → V*,
adjoints, duality for multilinear forms.
-/

import MiniMultilinearForm.Functorial.ChangeOfBasis

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Bilinear Form as Linear Map to Dual -/

/-- A bilinear form B: V×W → F induces a linear map V → W* given by
    v ↦ (w ↦ B(v,w)). -/
def BilinearForm.toDualMap {F : Field} {V W : VectorSpace F}
    (B : BilinearMap V W (fnSpace F 1)) : V.V → (W.V → F.carrier) :=
  fun v w => B.map v w

/-- The left radical is the kernel of the map V → W*. -/
def BilinearForm.leftRadical {F : Field} {V W : VectorSpace F}
    (B : BilinearMap V W (fnSpace F 1)) : Set V.V :=
  { v | ∀ (w : W.V), B.map v w = F.zero }

/-- The right radical is the kernel of the map W → V*. -/
def BilinearForm.rightRadical {F : Field} {V W : VectorSpace F}
    (B : BilinearMap V W (fnSpace F 1)) : Set W.V :=
  { w | ∀ (v : V.V), B.map v w = F.zero }

/-! ## Nondegeneracy via Duality -/

/-- A bilinear form is left-nondegenerate if V → W* is injective. -/
def BilinearForm.isLeftNondegenerate {F : Field} {V W : VectorSpace F}
    (B : BilinearMap V W (fnSpace F 1)) : Prop :=
  ∀ (v₁ v₂ : V.V), (∀ (w : W.V), B.map v₁ w = B.map v₂ w) → v₁ = v₂

/-- A bilinear form is right-nondegenerate if W → V* is injective. -/
def BilinearForm.isRightNondegenerate {F : Field} {V W : VectorSpace F}
    (B : BilinearMap V W (fnSpace F 1)) : Prop :=
  ∀ (w₁ w₂ : W.V), (∀ (v : V.V), B.map v w₁ = B.map v w₂) → w₁ = w₂

/-! ## Adjoint with respect to a Bilinear Form -/

/-- Given a bilinear form B on V×W and a linear map T: V→V,
    the left adjoint of T with respect to B is T* satisfying
    B(Tx, y) = B(x, T*y). -/
def BilinearForm.leftAdjoint {F : Field} {V W : VectorSpace F}
    (B : BilinearMap V W (fnSpace F 1)) (T : V.V → V.V) : V.V → V.V :=
  fun v => v  -- Stub

#eval "Functorial.Duality: dual map, left/right radical, nondegeneracy, adjoint"
