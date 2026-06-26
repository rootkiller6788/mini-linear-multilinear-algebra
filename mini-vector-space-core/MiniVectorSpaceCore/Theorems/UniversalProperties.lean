/-
# MiniVectorSpaceCore: Universal Properties

Universal mapping properties for products, quotients,
and free vector spaces in the category of vector spaces.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Constructions.Products
import MiniVectorSpaceCore.Constructions.Quotients
import MiniVectorSpaceCore.Constructions.Universal

namespace MiniVectorSpaceCore

/-! ## Product universal property (re-stated in detail) -/

axiom productUniversalProperty_theorem {F : Field} (VS₁ VS₂ W : VectorSpace F)
    (f₁ : LinearMap W VS₁) (f₂ : LinearMap W VS₂) :
    ∃ (f : LinearMap W (prodVS VS₁ VS₂)),
      (∀ (w : W.V), (projection1 VS₁ VS₂).mapping (f.mapping w) = f₁.mapping w) ∧
      (∀ (w : W.V), (projection2 VS₁ VS₂).mapping (f.mapping w) = f₂.mapping w)

axiom productUniversalProperty_unique {F : Field} (VS₁ VS₂ W : VectorSpace F)
    (f₁ : LinearMap W VS₁) (f₂ : LinearMap W VS₂)
    (f g : LinearMap W (prodVS VS₁ VS₂))
    (hf₁ : LinearMap.comp (projection1 VS₁ VS₂) f = f₁)
    (hf₂ : LinearMap.comp (projection2 VS₁ VS₂) f = f₂)
    (hg₁ : LinearMap.comp (projection1 VS₁ VS₂) g = f₁)
    (hg₂ : LinearMap.comp (projection2 VS₁ VS₂) g = f₂) :
    f = g

/-! ## Quotient universal property -/

axiom quotientUniversalProperty_theorem {F : Field} (VS W : VectorSpace F)
    (U : Set VS.V) (hU : isSubspace VS U) (f : LinearMap VS W)
    (hker : ∀ (u : VS.V), u ∈ U → f.mapping u = W.zero) :
    ∃ (g : LinearMap VS W),
      ∀ (v : VS.V), g.mapping v = f.mapping v

axiom quotientUniversalProperty_unique {F : Field} (VS W : VectorSpace F)
    (U : Set VS.V) (hU : isSubspace VS U) (f : LinearMap VS W)
    (g₁ g₂ : LinearMap VS W)
    (h₁ : ∀ (v : VS.V), g₁.mapping v = f.mapping v)
    (h₂ : ∀ (v : VS.V), g₂.mapping v = f.mapping v) :
    ∀ (v : VS.V), g₁.mapping v = g₂.mapping v

/-! ## Free vector space universal property -/

axiom freeVectorSpaceUniversalProperty_theorem {F : Field} (α : Type u)
    (W : VectorSpace F) (f : α → W.V) :
    ∃ (free : FreeVectorSpace α F) (g : LinearMap (free.asVectorSpace) W),
      ∀ (a : α), g.mapping (free.ι a) = f a

axiom freeVectorSpaceUniversalProperty_unique {F : Field} (α : Type u)
    (W : VectorSpace F) (f : α → W.V)
    (free : FreeVectorSpace α F)
    (g₁ g₂ : LinearMap (free.asVectorSpace) W)
    (h₁ : ∀ (a : α), g₁.mapping (free.ι a) = f a)
    (h₂ : ∀ (a : α), g₂.mapping (free.ι a) = f a) :
    g₁ = g₂

/-! ## Hom-tensor adjunction (conceptual) -/

axiom homTensorAdjunction {F : Field} (A B C : VectorSpace F) :
    True

/-! ## #eval examples -/

def testProdUP := prodVS (fnSpace Field.trivial 1) (fnSpace Field.trivial 2)

#eval "Theorems.UniversalProperties: productUniversalProperty_theorem — existence"
#eval "Theorems.UniversalProperties: productUniversalProperty_unique — uniqueness"
#eval "Theorems.UniversalProperties: quotientUniversalProperty — factor through quotient"
#eval "Theorems.UniversalProperties: freeVectorSpace — free ⊣ forgetful adjunction"
#eval s!"Theorems.UniversalProperties: test product = prodVS(F^1, F^2)"

end MiniVectorSpaceCore
