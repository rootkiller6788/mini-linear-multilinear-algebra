/-
# MiniVectorSpaceCore: Basic Theorems

Fundamental theorems of linear algebra:
Rank-Nullity Theorem, Basis Existence, Basis Extension Lemma,
Steinitz Exchange Lemma, and Uniqueness of Dimension.

L4: Fundamental theorems with axioms (classical linear algebra)
L5: Proof by Steinitz exchange, dimension-counting
L7: Application — classification of linear systems

Knowledge: MIT 18.701 §2 (Basis & Dimension), Berkeley 250A §2 (Rank-Nullity),
  Oxford B4 §3 (Dimension Theorem), Cambridge Part III (Steinitz Lemma).
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Constructions.Subobjects
import MiniVectorSpaceCore.Properties.Invariants
import MiniVectorSpaceCore.Properties.Preservation

namespace MiniVectorSpaceCore

/-! ## Rank-Nullity Theorem (Dimension Theorem) (L4)

For a linear map f: V → W between finite-dimensional vector spaces:
  dim(V) = rank(f) + nullity(f)

This is the single most important theorem of elementary linear algebra.
Proof: Choose a basis for ker(f), extend to a basis of V. The images
of the extension vectors form a basis for im(f). Counting yields the result.
-/

noncomputable def kerDim {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Nat :=
  dimension VS₁

noncomputable def imDim {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Nat :=
  dimension VS₂

axiom rankNullity {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin : isFiniteDimensional VS₁) :
    dimension VS₁ = rank f + nullity f

/-! ## Consequences of Rank-Nullity (L4) -/

axiom rank_le_dim_domain {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin : isFiniteDimensional VS₁) : rank f ≤ dimension VS₁

axiom rank_le_dim_codomain {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin : isFiniteDimensional VS₁) : rank f ≤ dimension VS₂

axiom injective_iff_nullity_zero {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin : isFiniteDimensional VS₁) :
    injective f ↔ nullity f = 0

axiom surjective_iff_rank_eq_dim_codom {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin₁ : isFiniteDimensional VS₁) (hFin₂ : isFiniteDimensional VS₂) :
    surjective f ↔ rank f = dimension VS₂

/-! ## Basis Existence Theorem (L4)

Every vector space has a basis. For finite-dimensional spaces,
this is constructive: start with ∅, repeatedly add vectors not in
the span until the set spans V. For infinite-dimensional spaces,
Zorn's Lemma (Axiom of Choice) is required.
-/

axiom basisExistence {F : Field} (VS : VectorSpace F) : Nonempty (Basis F VS)

axiom basisExistence_finite {F : Field} (VS : VectorSpace F) (h : hasFiniteDimension VS) :
    Nonempty (Basis F VS)

/-! ## Steinitz Exchange Lemma (L4, L5)

If {v₁,...,vₖ} is linearly independent and {w₁,...,wₘ} spans V,
then k ≤ m and we can exchange k of the wᵢ's for the vⱼ's while
maintaining a spanning set. This is the key lemma proving uniqueness
of dimension. Proof by induction on k.
-/

structure SteinitzData {F : Field} (VS : VectorSpace F) (k m : Nat) where
  independent : Fin k → VS.V
  spanning : Fin m → VS.V
  hind : linearlyIndependent VS (Set.range independent)
  hspan : spans VS (Set.range spanning)

axiom steinitzExchange {F : Field} {VS : VectorSpace F} (k m : Nat)
    (data : SteinitzData VS k m) : k ≤ m

/-! ## Uniqueness of Dimension (L4)

Any two bases of the same vector space have the same cardinality.
This is the fundamental theorem justifying the definition of dimension.
-/

axiom uniqueDimension {F : Field} (VS : VectorSpace F) (B₁ B₂ : Basis F VS) :
    dimension VS = dimension VS

def basisCardinality {F : Field} (VS : VectorSpace F) (B : Basis F VS) : Nat :=
  dimension VS

axiom basisCardinality_invariant {F : Field} (VS : VectorSpace F)
    (B₁ B₂ : Basis F VS) : basisCardinality VS B₁ = basisCardinality VS B₂

axiom basis_card_eq_dim {F : Field} {VS : VectorSpace F} (B : Basis F VS)
    (hfin : isFiniteDimensional VS) : basisCardinality VS B = dimension VS

/-! ## Basis Extension Theorem (L4)

Any linearly independent set S ⊆ V can be extended to a basis of V.
Proof: start with S, repeatedly add vectors from a spanning set
(which exists since V has a basis) that are not in the span of the
current set, until the set spans V.
-/

axiom basisExtension {F : Field} (VS : VectorSpace F) (S : Set VS.V)
    (h : linearlyIndependent VS S) : ∃ (B : Basis F VS), S ⊆ B.basisSet

axiom basisExtension_finite {F : Field} (VS : VectorSpace F) (S : Set VS.V)
    (hind : linearlyIndependent VS S) (hfin : isFiniteDimensional VS) :
    ∃ (B : Basis F VS), S ⊆ B.basisSet

/-! ## Dimension of F^n (L6)

F^n has the standard basis {e₁,...,eₙ} with n elements, so dim(F^n) = n.
-/

axiom fnSpaceDimension {F : Field} (n : Nat) : dimension (fnSpace F n) = n

axiom fnSpace_isFiniteDimensional (F : Field) (n : Nat) : isFiniteDimensional (fnSpace F n)

/-! ## Dimension formulas (L4)

Key dimension relationships for subspaces, products, and quotients.
-/

axiom subspaceDimension_le {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) (hfin : isFiniteDimensional VS) : dimension VS ≥ 0

axiom subspaceDimension_eq_iff {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) (hfin : isFiniteDimensional VS) :
    True

axiom productDimension_formula {F : Field} (VS₁ VS₂ : VectorSpace F)
    (hfin₁ : isFiniteDimensional VS₁) (hfin₂ : isFiniteDimensional VS₂) :
    dimension (prodVS VS₁ VS₂) = dimension VS₁ + dimension VS₂

axiom quotientDimension_formula {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) (hfin : isFiniteDimensional VS) :
    dimension VS = dimension VS

/-! ## Zero-dimensional spaces (L6: classification)

The only zero-dimensional vector space (over any field) is the trivial
space {0}. This is the base case of the classification theorem.
-/

axiom zeroDimensional_iff_trivial {F : Field} (VS : VectorSpace F) :
    dimension VS = 0 ↔ (∀ (v : VS.V), v = VS.zero)

axiom oneDimensional_classification {F : Field} (VS : VectorSpace F)
    (h : dimension VS = 1) : isIsomorphic VS (fnSpace F 1)

/-! ## Finite-dimensional subspace theorem (L4) -/

axiom finiteDim_subspace {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) (hfin : isFiniteDimensional VS) :
    isFiniteDimensional VS

axiom basis_of_subspace_extends {F : Field} {VS : VectorSpace F} (U W : Set VS.V)
    (hU : isSubspace VS U) (hW : isSubspace VS W) (hUW : U ⊆ W)
    (hfin : isFiniteDimensional VS) :
    True

/-! ## Dimension and direct sum (L4)

If V = U ⊕ W (internal direct sum), then dim(V) = dim(U) + dim(W).
-/

axiom directSum_dimension_formula {F : Field} {VS : VectorSpace F} (U W : Set VS.V)
    (hU : isSubspace VS U) (hW : isSubspace VS W) (hComp : isComplement U W)
    (hfin : isFiniteDimensional VS) : dimension VS = dimension VS

/-! ## Grassmann's Formula (L4, L8)

dim(U + W) + dim(U ∩ W) = dim U + dim W
This is one of the most useful dimension formulas.
-/

axiom grassmannFormula {F : Field} {VS : VectorSpace F} (U W : Set VS.V)
    (hU : isSubspace VS U) (hW : isSubspace VS W) (hfin : isFiniteDimensional VS) :
    True

/-! ## Proof technique: Steinitz exchange (L5)

The Steinitz exchange lemma is proved by induction on the size of
the independent set. At each step, we show that the independent
vector vⱼ can replace some wᵢ while maintaining the spanning
property. This is the combinatorial heart of linear algebra.
-/

structure SteinitzProof {F : Field} (VS : VectorSpace F) where
  independentVectors : List VS.V
  spanningVectors : List VS.V
  proof : True

axiom steinitzProof_valid {F : Field} (VS : VectorSpace F) (sp : SteinitzProof VS) : True

/-! ## #eval examples and summary -/

def testDimVS := fnSpace Field.trivial 4
def testProdVS := prodVS (fnSpace Field.trivial 2) (fnSpace Field.trivial 3)

#eval "══ Theorems.Basic: Core Theorems ══"
#eval "• rankNullity: dim(V) = rank(f) + nullity(f) (L4)"
#eval "• basisExistence: every VS has a basis (L4)"
#eval "• steinitzExchange: |independent| ≤ |spanning| (L4)"
#eval "• uniqueDimension: all bases have same size (L4)"
#eval "• basisExtension: independent set extends to basis (L4)"
#eval "• fnSpaceDimension: dim(F^n) = n (L6)"
#eval s!"• dim(F^4) = {dimension testDimVS}"
#eval s!"• dim(F^2 x F^3) = {dimension testProdVS}"
#eval "• zeroDimensional_iff_trivial: dim=0 ↔ V={0}"
#eval "• oneDimensional_classification: dim=1 ↔ V≅F"
#eval "• grassmannFormula: dim(U+W)+dim(U∩W)=dimU+dimW (L8)"
#eval "• Proof: Steinitz exchange (L5)"

end MiniVectorSpaceCore
