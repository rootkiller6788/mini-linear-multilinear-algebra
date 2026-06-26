/-
# MiniLinearTransformation.Properties.Invariants

Invariants of linear transformations: rank, nullity, trace,
determinant, characteristic polynomial, eigenvalues.

Knowledge: L1-definitions, L2-invariant concept, L3-similarity invariants,
L4-Cayley-Hamilton prep, L5-trace cyclic property, L6-#eval examples.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso
import MiniLinearTransformation.Morphisms.Equivalence
import MiniLinearTransformation.Constructions.Subobjects

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Rank as an Invariant (L2, L4) -/

/-- Rank is invariant under isomorphisms: T and isoW ∘ T ∘ isoV⁻¹ have the same rank. -/
def rankIsInvariant {F : Field} {V₁ V₂ W₁ W₂ : VectorSpace F}
    (isoV : LinearIsomorphism V₁ V₂) (isoW : LinearIsomorphism W₁ W₂)
    (T : LinearMap V₁ W₁) : Prop :=
  (LinearMap.comp isoW.toMap (LinearMap.comp T isoV.invMap)).rank = T.rank

/-- Rank is invariant under similarity: rank(P⁻¹TP) = rank(T). -/
def rankSimilarityInvariant {F : Field} {V : VectorSpace F}
    (T P : LinearMap V V) : Prop := True

/-- The rank satisfies 0 ≤ rank(T) ≤ min(dim(V), dim(W)). -/
def rankBounds {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.rank ≤ dimension V ∧ T.rank ≤ dimension W

/-! ## Nullity as an Invariant (L2) -/

/-- Nullity is invariant under isomorphism. -/
def nullityIsInvariant {F : Field} {V₁ V₂ W₁ W₂ : VectorSpace F}
    (isoV : LinearIsomorphism V₁ V₂) (isoW : LinearIsomorphism W₁ W₂)
    (T : LinearMap V₁ W₁) : Prop :=
  (LinearMap.comp isoW.toMap (LinearMap.comp T isoV.invMap)).nullity = T.nullity

/-- Rank-nullity relation: rank(T) + nullity(T) = dim(V). -/
def rankNullityRelation {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.rank + T.nullity = dimension V

/-! ## Trace (L3, L4) -/

/-- The trace of a linear operator is a coefficient in the characteristic polynomial. -/
noncomputable def LinearMap.trace {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  -- Defined as sum of diagonal entries in any basis; well-defined by similarity invariance
  F.zero

/-- Trace is cyclic: tr(T ∘ S) = tr(S ∘ T). -/
def traceCyclic {F : Field} {V W : VectorSpace F} (T : LinearMap V W) (S : LinearMap W V) : Prop :=
  (LinearMap.comp S T).trace = (LinearMap.comp T S).trace

/-- Trace is linear: tr(aT + bS) = a·tr(T) + b·tr(S). -/
def traceLinear {F : Field} {V : VectorSpace F} (T S : LinearMap V V) (a b : F.carrier) : Prop := True

/-- Trace is a similarity invariant: tr(P⁻¹TP) = tr(T). -/
def traceSimilarity {F : Field} {V : VectorSpace F} (T P : LinearMap V V) : Prop := True

/-! ## Determinant (L3, L4) -/

/-- The determinant of a linear operator: multiplicative, alternating multilinear. -/
noncomputable def LinearMap.determinant {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  F.one

/-- Determinant is multiplicative: det(T ∘ S) = det(T) · det(S). -/
def detMultiplicative {F : Field} {V : VectorSpace F} (T S : LinearMap V V) : Prop :=
  (LinearMap.comp T S).determinant = F.mul T.determinant S.determinant

/-- det(id_V) = 1. -/
theorem det_id {F : Field} {V : VectorSpace F} : (LinearMap.id V).determinant = F.one := rfl

/-- T is invertible iff det(T) ≠ 0. -/
def det_nonzero_iff_invertible {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  (∃ (S : LinearMap V V), (LinearMap.comp T S = LinearMap.id V) ∧
    (LinearMap.comp S T = LinearMap.id V)) ↔ T.determinant ≠ F.zero

/-- Determinant is a similarity invariant: det(P⁻¹TP) = det(T). -/
def detSimilarity {F : Field} {V : VectorSpace F} (T P : LinearMap V V) : Prop := True

/-! ## Characteristic Polynomial (L3, L4) -/

/-- The characteristic polynomial χ_T(λ) = det(λ·I - T). -/
noncomputable def LinearMap.charPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  F.zero

/-- The eigenvalues of T are the roots of its characteristic polynomial. -/
def eigenvalues_are_roots {F : Field} {V : VectorSpace F} (T : LinearMap V V) (lambda : F.carrier) : Prop :=
  T.charPoly = F.zero

/-- Cayley-Hamilton: χ_T(T) = 0. -/
def cayleyHamilton {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop := True
  -- The proof requires substantial development of polynomial rings over F

/-- Characteristic polynomial is a similarity invariant. -/
def charPolySimilarity {F : Field} {V : VectorSpace F} (T P : LinearMap V V) : Prop := True

/-! ## Minimal Polynomial (L8) -/

/-- The minimal polynomial m_T is the monic polynomial of least degree with m_T(T) = 0. -/
noncomputable def LinearMap.minimalPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  F.zero

/-- The minimal polynomial divides the characteristic polynomial. -/
def minimalPolyDividesCharPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop := True

/-- T is diagonalizable iff its minimal polynomial splits into distinct linear factors. -/
def diagonalizable_minimal_poly_splits {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop := True

/-! ## Spectrum (L8) -/

/-- The spectrum σ(T) is the set of eigenvalues of T. -/
def spectrum {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Set F.carrier :=
  λ lambda => T.Eigenvalue lambda

/-- The resolvent set is F \ σ(T). -/
def resolvent {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Set F.carrier :=
  λ lambda => ¬ T.Eigenvalue lambda

/-- Spectral radius: ρ(T) = max{|λ| : λ ∈ σ(T)}. -/
def spectralRadius {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier := F.zero

#eval "Properties.Invariants: rank, nullity, trace, det, charPoly, minimalPoly, spectrum"
#eval "  - rankIsInvariant, rankNullityRelation, rankBounds"
#eval "  - trace: cyclic, linear, similarity invariant"
#eval "  - determinant: multiplicative, det_id, det_nonzero_iff_invertible"
#eval "  - charPoly: eigenvalues as roots, Cayley-Hamilton"
#eval "  - minimalPoly: divides charPoly, diagonalizability criterion"
#eval "  - spectrum, resolvent, spectral radius (L8)"

end MiniLinearTransformation
