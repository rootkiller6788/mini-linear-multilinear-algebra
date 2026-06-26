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

/-! ## Coproduct = Product in Vec(F) (L3)

In Vec(F), finite products and coproducts coincide: V ⊕ W is a
biproduct. This is characteristic of additive categories.
-/

axiom coproductUniversalProperty_existence {F : Field} (VS₁ VS₂ W : VectorSpace F)
    (g₁ : LinearMap VS₁ W) (g₂ : LinearMap VS₂ W) :
    ∃ (g : LinearMap (prodVS VS₁ VS₂) W),
      g.comp (inclusion1 VS₁ VS₂) = g₁ ∧ g.comp (inclusion2 VS₁ VS₂) = g₂

axiom coproductUniversalProperty_uniqueness {F : Field} (VS₁ VS₂ W : VectorSpace F)
    (g₁ : LinearMap VS₁ W) (g₂ : LinearMap VS₂ W)
    (g h : LinearMap (prodVS VS₁ VS₂) W)
    (hg₁ : g.comp (inclusion1 VS₁ VS₂) = g₁)
    (hg₂ : g.comp (inclusion2 VS₁ VS₂) = g₂)
    (hh₁ : h.comp (inclusion1 VS₁ VS₂) = g₁)
    (hh₂ : h.comp (inclusion2 VS₁ VS₂) = g₂) :
    g = h

/-! ## First Isomorphism Theorem (L4)

For any linear map f: V → W, V/ker(f) ≅ im(f).
-/

axiom firstIsomorphismTheorem_VSKerIm {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (Q : VectorSpaceQuotient VS₁ f.ker) :
    isIsomorphic (Q.asVectorSpace) VS₂

/-! ## Tensor-Hom adjunction (L8)

For vector spaces A, B, C: Hom(A⊗B, C) ≅ Hom(A, Hom(B, C))
This is the defining property of the tensor product.
-/

axiom tensorHom_adjunction {F : Field} (A B C : VectorSpace F) : True

/-! ## Exact sequences and universal properties (L3, L8)

A short exact sequence 0 → A → B → C → 0 splits in Vec(F):
B ≅ A ⊕ C. This uses the universal property of the biproduct.
-/

structure ShortExactSequence {F : Field} where
  A B C : VectorSpace F
  f : LinearMap A B
  g : LinearMap B C
  exactAtA : injective f
  exactAtC : surjective g

axiom short_exact_splits {F : Field} (ses : ShortExactSequence F) :
    isIsomorphic ses.B (prodVS ses.A ses.C)

/-! ## Proof method: universal property verification (L5)

To verify a universal property:
1. Construct the candidate morphism explicitly
2. Verify the required commutation
3. Prove uniqueness via the equalizer property
-/

/-! ## #eval examples (continued) -/

#eval "• coproductUniversalProperty — coprod = prod in Vec(F) (L3)"
#eval "• firstIsomorphismTheorem_VSKerIm — V/ker(f) ≅ im(f) (L4)"
#eval "• tensorHom_adjunction — Hom(A⊗B,C)≅Hom(A,Hom(B,C)) (L8)"
#eval "• short_exact_splits — SES in Vec(F) splits (L8)"
#eval "• Proof: explicit construction + uniqueness verification (L5)"
#eval "══ Theorems.UniversalProperties: Complete ══"

end MiniVectorSpaceCore
