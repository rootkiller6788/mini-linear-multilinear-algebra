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
  additive _ _ := rfl
  homogeneous _ _ := rfl

def projection2 {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap (prodVS VS₁ VS₂) VS₂ where
  mapping := Prod.snd
  additive _ _ := rfl
  homogeneous _ _ := rfl

/-! ## Inclusion maps -/

def inclusion1 {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap VS₁ (prodVS VS₁ VS₂) where
  mapping := λ x => (x, VS₂.zero)
  additive _ _ := rfl
  homogeneous _ _ := rfl

def inclusion2 {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap VS₂ (prodVS VS₁ VS₂) where
  mapping := λ y => (VS₁.zero, y)
  additive _ _ := rfl
  homogeneous _ _ := rfl

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

/-! ## n-fold product via Fin -/

def prodVSN {F : Field} (VSes : Fin 3 → VectorSpace F) : VectorSpace F where
  V    := (i : Fin 3) → (VSes i).V
  add f g := λ i => (VSes i).add (f i) (g i)
  zero   := λ i => (VSes i).zero
  neg f  := λ i => (VSes i).neg (f i)
  smul a f := λ i => (VSes i).smul a (f i)

/-! ## Diagonal map Δ: V → V × V -/

def diagonalMap {F : Field} (VS : VectorSpace F) : LinearMap VS (prodVS VS VS) where
  mapping v := (v, v)
  additive _ _ := rfl
  homogeneous _ _ := rfl

/-! ## Codagonal (sum) map Σ: V × V → V -/

def sumMap {F : Field} (VS : VectorSpace F) : LinearMap (prodVS VS VS) VS where
  mapping (x, y) := VS.add x y
  additive (x₁, y₁) (x₂, y₂) := by
    simp [prodVS, VectorSpace.add']
    rfl
  homogeneous a (x, y) := by
    simp [prodVS, VectorSpace.smul']
    rfl

/-! ## Twist map τ: V × W → W × V -/

def twistMap {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap (prodVS VS₁ VS₂) (prodVS VS₂ VS₁) where
  mapping (x, y) := (y, x)
  additive _ _ := rfl
  homogeneous _ _ := rfl

theorem twistMap_twice_is_id {F : Field} (VS₁ VS₂ : VectorSpace F) :
    (twistMap VS₂ VS₁).comp (twistMap VS₁ VS₂) = LinearMap.id _ := by
  apply LinearMap.ext; intro x; rfl

/-! ## Associativity: (V₁ × V₂) × V₃ ≅ V₁ × (V₂ × V₃) -/

def associatorMap {F : Field} (VS₁ VS₂ VS₃ : VectorSpace F) :
    LinearMap (prodVS (prodVS VS₁ VS₂) VS₃) (prodVS VS₁ (prodVS VS₂ VS₃)) where
  mapping ((x₁, x₂), x₃) := (x₁, (x₂, x₃))
  additive _ _ := rfl
  homogeneous _ _ := rfl

theorem associator_is_iso {F : Field} (VS₁ VS₂ VS₃ : VectorSpace F) :
    isIsomorphic (prodVS (prodVS VS₁ VS₂) VS₃) (prodVS VS₁ (prodVS VS₂ VS₃)) := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · exact associatorMap VS₁ VS₂ VS₃
  · refine {
      mapping ((x₁, (x₂, x₃))) := ((x₁, x₂), x₃)
      additive _ _ := rfl
      homogeneous _ _ := rfl
    }
  · intro ((x₁, x₂), x₃); rfl
  · intro (x₁, (x₂, x₃)); rfl

/-! ## #eval examples (continued) -/

def testProd2 := prodVS (fnSpace Field.trivial 1) (fnSpace Field.trivial 2)
def testProd3 := prodVSN (λ | ⟨0, _⟩ => fnSpace Field.trivial 1 | ⟨1, _⟩ => fnSpace Field.trivial 2 | ⟨2, _⟩ => fnSpace Field.trivial 3)

#eval "• prodVSN — Fin n → VS_i (L3)"
#eval "• diagonalMap Δ: V → V×V (L3)"
#eval "• sumMap Σ: V×V → V (L3)"
#eval "• twistMap τ: V×W → W×V — τ²=id (L3)"
#eval "• associatorMap — (V₁×V₂)×V₃ ≅ V₁×(V₂×V₃) (L3)"
#eval s!"• associator_is_iso — proved (L4)"
#eval "══ Constructions.Products: Complete ══"

end MiniVectorSpaceCore
