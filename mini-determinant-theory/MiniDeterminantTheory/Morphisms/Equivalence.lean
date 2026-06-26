/-
# MiniDeterminantTheory: Equivalence

Equivalence relations for determinant-related objects.
-/

import MiniDeterminantTheory.Core.Basic

namespace MiniDeterminantTheory

/-! ## Determinant-Equivalence

Two linear operators are determinant-equivalent if they have the same determinant.
-/

def detEquivalent {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop :=
  determinant S = determinant T

/-! ## Spectrum Equivalence -/

def spectrumEquivalent {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop :=
  ∀ (λ : F.carrier), (∃ (v : V.V), v ≠ V.zero ∧ S.map v = V.smul λ v) ↔
    (∃ (v : V.V), v ≠ V.zero ∧ T.map v = V.smul λ v)

end MiniDeterminantTheory
