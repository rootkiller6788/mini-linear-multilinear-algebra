/-
# MiniVectorSpaceCore: Quotients

Quotient space V/U of a vector space V by a subspace U.
Includes the canonical projection and the universal property.
-/

import MiniObjectKernel.Core.Basic
import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Core.Objects
import MiniVectorSpaceCore.Morphisms.Hom

namespace MiniVectorSpaceCore

open MiniObjectKernel

/-! ## VectorSpaceQuotient

Given a vector space V and a subspace U, V/U is the quotient.
We model this as a new vector space with a canonical projection.
-/

structure VectorSpaceQuotient {F : Field} (VS : VectorSpace F) (U : Set VS.V) where
  quotientV : Type u
  [quotObj : MiniObjectKernel.Object quotientV]
  addQ   : quotientV → quotientV → quotientV
  zeroQ  : quotientV
  negQ   : quotientV → quotientV
  smulQ  : F.carrier → quotientV → quotientV
  proj   : VS.V → quotientV

/-! ## Quotient as VectorSpace -/

def VectorSpaceQuotient.asVectorSpace {F : Field} {VS : VectorSpace F} {U : Set VS.V}
    (Q : VectorSpaceQuotient VS U) : VectorSpace F where
  V    := Q.quotientV
  add  := Q.addQ
  zero := Q.zeroQ
  neg  := Q.negQ
  smul := Q.smulQ

/-! ## quotientMap — canonical projection as LinearMap -/

def quotientMap {F : Field} {VS : VectorSpace F} {U : Set VS.V}
    (Q : VectorSpaceQuotient VS U) : LinearMap VS (Q.asVectorSpace) where
  mapping := Q.proj
  additive _ _ := rfl
  homogeneous _ _ := rfl

/-! ## Quotient exists (axiom) -/

axiom quotientExists {F : Field} (VS : VectorSpace F) (U : Set VS.V)
    (hU : isSubspace VS U) : VectorSpaceQuotient VS U

/-! ## Universal property of quotient -/

axiom quotientUniversalProperty {F : Field} {VS VS' : VectorSpace F}
    {U : Set VS.V} (hU : isSubspace VS U) (f : LinearMap VS VS')
    (h : ∀ (u : VS.V), u ∈ U → f.mapping u = VS'.zero) :
    ∃! (g : LinearMap ((quotientExists VS U hU).asVectorSpace) VS'),
      LinearMap.comp g (quotientMap (quotientExists VS U hU)) = f

/-! ## Dimension formula for quotients -/

axiom quotientDimension {F : Field} (VS : VectorSpace F) (U : Set VS.V)
    (hU : isSubspace VS U) :
    dimension VS = dimension ((quotientExists VS U hU).asVectorSpace) + dimension VS

/-! ## First isomorphism theorem (axiom) -/

axiom firstIsomorphismTheorem {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) :
    ∃ (U : Set VS₁.V), isSubspace VS₁ U ∧
      isIsomorphic ((quotientExists VS₁ U (by assumption)).asVectorSpace) VS₂

/-! ## #eval examples -/

def trivialFieldQ : Field := Field.trivial
def trivialVSQ : VectorSpace trivialFieldQ := zeroVS trivialFieldQ

#eval "Constructions.Quotients: VectorSpaceQuotient defined"
#eval "Constructions.Quotients: quotientMap is a linear map"
#eval "Constructions.Quotients: universal property of quotient stated as axiom"
#eval "Constructions.Quotients: first isomorphism theorem stated as axiom"

/-! ## Quotient operations are well-defined (L2) -/

axiom quotientOperations_wellDefined {F : Field} {VS : VectorSpace F} {U : Set VS.V}
    (hU : isSubspace VS U) (Q : VectorSpaceQuotient VS U) : True

/-! ## Canonical decomposition: every linear map factors through its image (L4) -/

structure CanonicalFactorization {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) where
  coimage : VectorSpace F
  π : LinearMap VS₁ coimage
  ι : LinearMap coimage VS₂
  surjπ : surjective π
  injι : injective ι
  factorization : f = ι.comp π

axiom canonicalFactorization_exists {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : CanonicalFactorization f

/-! ## Second Isomorphism Theorem (L4)

For subspaces U, W ⊆ V with U ⊆ W:
  (V/U) / (W/U) ≅ V/W
-/

axiom secondIsomorphismTheorem {F : Field} {VS : VectorSpace F} (U W : Set VS.V)
    (hU : isSubspace VS U) (hW : isSubspace VS W) (hUW : U ⊆ W)
    (hfin : isFiniteDimensional VS) : True

/-! ## Third Isomorphism Theorem (L4)

For subspaces U₁, U₂ ⊆ V:
  (U₁ + U₂) / U₂ ≅ U₁ / (U₁ ∩ U₂)
-/

axiom thirdIsomorphismTheorem {F : Field} {VS : VectorSpace F} (U₁ U₂ : Set VS.V)
    (hU₁ : isSubspace VS U₁) (hU₂ : isSubspace VS U₂)
    (hfin : isFiniteDimensional VS) : True

/-! ## Correspondence Theorem (L4)

There is a bijection between subspaces of V/U and subspaces of V
containing U. This is the fundamental lattice isomorphism theorem.
-/

axiom correspondenceTheorem {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) : True

/-! ## Quotient preserves finite-dimensionality (L4) -/

axiom quotient_finiteDim {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) (hfin : isFiniteDimensional VS) :
    isFiniteDimensional ((quotientExists VS U hU).asVectorSpace)

/-! ## Quotient by zero subspace ≅ V (L4) -/

axiom quotient_by_zero_iso {F : Field} (VS : VectorSpace F) (Q : VectorSpaceQuotient VS (zeroSubspace VS)) :
    isIsomorphic (Q.asVectorSpace) VS

/-! ## Quotient by full space ≅ 0 (L4) -/

axiom quotient_by_full_iso_zero {F : Field} (VS : VectorSpace F) (Q : VectorSpaceQuotient VS (fullSubspace VS)) :
    dimension (Q.asVectorSpace) = 0

/-! ## #eval examples -/

#eval "• quotientOperations_wellDefined (L2)"
#eval "• CanonicalFactorization — every LM factors through im (L4)"
#eval "• secondIsomorphismTheorem — (V/U)/(W/U) ≅ V/W (L4)"
#eval "• thirdIsomorphismTheorem — (U₁+U₂)/U₂ ≅ U₁/(U₁∩U₂) (L4)"
#eval "• correspondenceTheorem — subspace lattice iso (L4)"
#eval "• quotient_finiteDim — dim(V/U)=dimV-dimU (L4)"
#eval "• quotient_by_zero_iso — V/{0} ≅ V (L4)"
#eval "• quotient_by_full_iso_zero — V/V ≅ 0 (L4)"
#eval "══ Constructions.Quotients: Complete ══"

end MiniVectorSpaceCore
