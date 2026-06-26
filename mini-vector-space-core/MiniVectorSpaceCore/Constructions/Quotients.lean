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

end MiniVectorSpaceCore
