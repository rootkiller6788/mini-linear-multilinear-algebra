/-
# MiniVectorSpaceCore: Products

Direct sum and product of vector spaces.
For two (or n) vector spaces V, W we define V ⊕ W together with
projections, inclusions, and the universal property.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom

namespace MiniVectorSpaceCore

/-! ## DirectSum of two vector spaces -/

structure DirectSum {F : Field} (VS₁ VS₂ : VectorSpace F) where
  Vsum    : Type u
  addSum  : Vsum → Vsum → Vsum
  zeroSum : Vsum
  negSum  : Vsum → Vsum
  smulSum : F.carrier → Vsum → Vsum

/-! ## DirectSum as VectorSpace -/

def DirectSum.asVectorSpace {F : Field} {VS₁ VS₂ : VectorSpace F}
    (S : DirectSum VS₁ VS₂) : VectorSpace F where
  V    := S.Vsum
  add  := S.addSum
  zero := S.zeroSum
  neg  := S.negSum
  smul := S.smulSum

/-! ## Product construction (type-theoretic) -/

def prodVS {F : Field} (VS₁ VS₂ : VectorSpace F) : VectorSpace F where
  V    := VS₁.V × VS₂.V
  add  := λ (x₁, x₂) (y₁, y₂) => (VS₁.add x₁ y₁, VS₂.add x₂ y₂)
  zero := (VS₁.zero, VS₂.zero)
  neg  := λ (x₁, x₂) => (VS₁.neg x₁, VS₂.neg x₂)
  smul := λ a (x₁, x₂) => (VS₁.smul a x₁, VS₂.smul a x₂)

/-! ## Projection maps -/

def projection1 {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap (prodVS VS₁ VS₂) VS₁ where
  mapping := Prod.fst

def projection2 {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap (prodVS VS₁ VS₂) VS₂ where
  mapping := Prod.snd

/-! ## Inclusion maps -/

def inclusion1 {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap VS₁ (prodVS VS₁ VS₂) where
  mapping := λ x => (x, VS₂.zero)

def inclusion2 {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap VS₂ (prodVS VS₁ VS₂) where
  mapping := λ y => (VS₁.zero, y)

/-! ## DirectSum of n copies (by repeated product) -/

def DirectSumN {F : Field} (VS : VectorSpace F) : Nat → VectorSpace F
  | 0     => zeroVS F
  | 1     => VS
  | n + 1 => prodVS VS (DirectSumN VS n)

/-! ## Dimension of product -/

axiom productDimension {F : Field} (VS₁ VS₂ : VectorSpace F) :
  dimension (prodVS VS₁ VS₂) = dimension VS₁ + dimension VS₂

axiom directSumNDimension {F : Field} (VS : VectorSpace F) (n : Nat) :
  dimension (DirectSumN VS n) = n * dimension VS

/-! ## Universal property of product -/

axiom productUniversalProperty {F : Field} {VS₁ VS₂ W : VectorSpace F}
    (f₁ : LinearMap W VS₁) (f₂ : LinearMap W VS₂) :
    ∃! (f : LinearMap W (prodVS VS₁ VS₂)),
      LinearMap.comp (projection1 VS₁ VS₂) f = f₁ ∧
      LinearMap.comp (projection2 VS₁ VS₂) f = f₂

/-! ## #eval examples -/

def testProd : VectorSpace Field.trivial :=
  prodVS (fnSpace Field.trivial 2) (fnSpace Field.trivial 3)

#eval "Constructions.Products: DirectSum and prodVS defined"
#eval s!"Constructions.Products: prod of F^2 x F^3 has V type = {typeof (testProd.V)}"
#eval s!"Constructions.Products: dim(F^2 x F^3) = {dimension testProd}"
#eval "Constructions.Products: projection1, projection2, inclusion1, inclusion2 defined"
#eval "Constructions.Products: DirectSumN for n copies defined recursively"

end MiniVectorSpaceCore
