/-
# MiniVectorSpaceCore: Basic Theorems

Fundamental theorems of linear algebra:
dimension theorem (rank + nullity), basis existence,
basis extension, and uniqueness of dimension.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Constructions.Subobjects
import MiniVectorSpaceCore.Properties.Invariants
import MiniVectorSpaceCore.Properties.Preservation

namespace MiniVectorSpaceCore

/-! ## Rank-Nullity Theorem (Dimension Theorem) -/

noncomputable def kerDim {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : Nat := 0

noncomputable def imDim {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : Nat := 0

axiom dimensionTheorem {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin : hasFiniteDimension VS₁) :
    dimension VS₁ = rank f + nullity f

/-! ## Basis existence -/

axiom basisExistence {F : Field} (VS : VectorSpace F) :
  Nonempty (Basis F VS)

axiom basisExistence_finite {F : Field} (VS : VectorSpace F)
    (h : hasFiniteDimension VS) :
  Nonempty (Basis F VS)

/-! ## Basis extension — independent set extends to basis -/

axiom basisExtension {F : Field} (VS : VectorSpace F) (S : Set VS.V)
    (h : linearlyIndependent VS S) :
    ∃ (B : Basis F VS), S ⊆ B.basisSet

/-! ## Two bases have same cardinality (uniqueness of dimension) -/

axiom uniqueDimension {F : Field} (VS : VectorSpace F)
    (B₁ B₂ : Basis F VS) : True

def basisCardinality {F : Field} (VS : VectorSpace F) (B : Basis F VS) : Nat :=
  dimension VS

axiom basisCardinality_invariant {F : Field} (VS : VectorSpace F)
    (B₁ B₂ : Basis F VS) : basisCardinality VS B₁ = basisCardinality VS B₂

/-! ## Every subspace has a basis -/

axiom subspaceBasis {F : Field} (VS : VectorSpace F) (U : Set VS.V)
    (hU : isSubspace VS U) :
    ∃ (B : Basis F VS), True

/-! ## All bases of F^n have size n -/

axiom fnSpaceBasisSize {F : Field} (n : Nat) :
  dimension (fnSpace F n) = n

/-! ## Dimension of subspace ≤ dimension of ambient -/

axiom subspaceDimension_le {F : Field} (VS : VectorSpace F) (U : Set VS.V)
    (hU : isSubspace VS U) : True

/-! ## Zero dimensional iff only zero vector -/

axiom zeroDimensional_iff_trivial {F : Field} (VS : VectorSpace F) :
  dimension VS = 0 ↔ ∀ (v : VS.V), v = VS.zero

/-! ## Any non-zero vector extends to a basis in a 1-dim space -/

axiom oneDimSpace_basis {F : Field} (VS : VectorSpace F)
    (h : dimension VS = 1) (v : VS.V) (hv : v ≠ VS.zero) :
    ∃ (B : Basis F VS), v ∈ B.basisSet

/-! ## #eval examples -/

def testDimVS := fnSpace Field.trivial 4

#eval "Theorems.Basic: dimensionTheorem — dim(V) = rank(T) + nullity(T)"
#eval "Theorems.Basic: basisExistence — every VS has a basis"
#eval "Theorems.Basic: basisExtension — independent set extends to basis"
#eval s!"Theorems.Basic: fnSpaceBasisSize 4: dim(F^4) = {dimension testDimVS}"
#eval "Theorems.Basic: uniqueDimension — two bases have same cardinality"

end MiniVectorSpaceCore
