/-
# MiniMultilinearForm.Multilinear.Operations

Operations on multilinear forms: symmetrization, alternation,
contraction, evaluation on specific vectors.
-/

import MiniMultilinearForm.Multilinear.Tensor

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Symmetrization -/

/-- Symmetrization of a multilinear form:
    S(M)(v₁,...,vₙ) = (1/n!) Σ_{σ∈Sₙ} M(v_{σ(1)},...,v_{σ(n)}). -/
def MultilinearForm.symmetrization {F : Field} {n : Nat} {V : VectorSpace F}
    (M : MultilinearForm n V) : MultilinearForm n V :=
  M  -- Stub

/-- The result of symmetrization is symmetric. -/
def MultilinearForm.symmetrization_isSymmetric {F : Field} {n : Nat} {V : VectorSpace F}
    (M : MultilinearForm n V) : isSymmetricTensor (MultilinearForm.symmetrization M) := by
  intro σ args
  sorry  -- Stub

/-! ## Alternation -/

/-- Alternation of a multilinear form:
    Alt(M)(v₁,...,vₙ) = Σ_{σ∈Sₙ} sgn(σ) M(v_{σ(1)},...,v_{σ(n)}). -/
def MultilinearForm.alternation {F : Field} {n : Nat} {V : VectorSpace F}
    (M : MultilinearForm n V) : MultilinearForm n V :=
  M  -- Stub

/-- The result of alternation is alternating. -/
def MultilinearForm.alternation_isAlternating {F : Field} {n : Nat} {V : VectorSpace F}
    (M : MultilinearForm n V) : isAlternatingTensor (MultilinearForm.alternation M) := by
  intro i j args hne heq
  sorry  -- Stub

/-! ## Contraction -/

/-- Contraction of a multilinear form with a vector on the i-th slot. -/
def MultilinearForm.contract {F : Field} {n : Nat} {V : VectorSpace F}
    (M : MultilinearForm (n+1) V) (i : Fin (n+1)) (v : V.V) : MultilinearForm n V :=
  M  -- Stub

/-! ## Evaluation -/

/-- Evaluate a multilinear form on an n-tuple of vectors. -/
def MultilinearForm.eval {F : Field} {n : Nat} {V : VectorSpace F}
    (M : MultilinearForm n V) (vs : Fin n → V.V) : F.carrier :=
  M.map vs

#eval "Multilinear.Operations: symmetrization, alternation, contraction, evaluation"
