/-
# MiniMultilinearForm.Symmetric.Signature

Signature computations and invariants of symmetric bilinear forms.
Witt index, Witt cancellation theorem.
-/

import MiniMultilinearForm.Symmetric.Diagonalization

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Witt Index -/

/-- The Witt index of a quadratic space: maximum dimension of a totally isotropic subspace. -/
def WittIndex {F : Field} {V : VectorSpace F}
    (B : SymmetricBilinearForm V) : Nat :=
  0  -- Stub: maximum dimension of isotropic subspace

/-- Totally isotropic subspace: S where B(x,y) = 0 for all x,y ∈ S. -/
def isTotallyIsotropic {F : Field} {V : VectorSpace F}
    (B : BilinearForm V) (S : Set V.V) : Prop :=
  ∀ (x y : V.V), x ∈ S → y ∈ S → B.map x y = (fnSpace F 1).zero

/-! ## Witt Cancellation Theorem -/

/-- Witt cancellation: if q₁ ⊕ q₂ ≅ q₁ ⊕ q₃ then q₂ ≅ q₃. -/
def WittCancellationTheorem {F : Field} {V₁ V₂ V₃ : VectorSpace F}
    (q₁ : V₁.V → F.carrier) (q₂ : V₂.V → F.carrier) (q₃ : V₃.V → F.carrier) : Prop :=
  True  -- Stub

/-! ## Witt Group -/

/-- The Witt group W(F) of the field F: equivalence classes of
    nondegenerate symmetric bilinear forms over F. -/
def WittGroup (F : Field) : Type _ :=
  Nat  -- Stub: set of equivalence classes

/-- Addition in the Witt group: orthogonal direct sum. -/
def WittGroup.add {F : Field} (a b : WittGroup F) : WittGroup F :=
  a + b  -- Stub

#eval "Symmetric.Signature: Witt index, Witt cancellation, Witt group"
