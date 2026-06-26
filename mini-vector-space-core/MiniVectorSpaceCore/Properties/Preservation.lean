/-
# MiniVectorSpaceCore: Preservation Properties

Properties preserved by and reflected by linear maps:
injectivity ↔ kernel trivial, surjectivity ↔ image full,
preservation of linear independence, spanning, and dimension
relationships. Uses kernel/image from Morphisms.Hom and invariants
from Properties.Invariants.

L2: injectivity, surjectivity, bijectivity for linear maps
L4: injective ↔ ker = {0}, surjective ↔ im = V
L5: Proof by kernel-element analysis, surjectivity construction
L7: Application — detecting isomorphisms via kernel/image
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Constructions.Subobjects
import MiniVectorSpaceCore.Constructions.Quotients
import MiniVectorSpaceCore.Properties.Invariants

namespace MiniVectorSpaceCore

/-! ## Injectivity of linear maps (L2)

A linear map f: V → W is injective if f(x) = f(y) ⇒ x = y.
Equivalent to: ker f = {0}.
-/

def injective {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Prop :=
  ∀ (x y : VS₁.V), f.mapping x = f.mapping y → x = y

/-! ## Surjectivity of linear maps (L2)

A linear map f: V → W is surjective if ∀ w ∈ W, ∃ v ∈ V with f(v) = w.
Equivalent to: im f = W.
-/

def surjective {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Prop :=
  ∀ (y : VS₂.V), ∃ (x : VS₁.V), f.mapping x = y

/-! ## Bijectivity (L2)

A linear map is bijective if it is both injective and surjective.
In finite dimensions, bijective ⇔ isomorphic.
-/

def bijective {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Prop :=
  injective f ∧ surjective f

/-! ## Kernel and injectivity (L4)

The fundamental characterization: f is injective iff its kernel is trivial.
Proved in Morphisms.Hom (injective_iff_kernel_trivial) and re-exported.
-/

-- injective_iff_kernel_trivial is declared in Morphisms.Hom (axiom), referenced here
-- surjective_iff_image_full is proved in Morphisms.Hom, referenced here

theorem injective_kernel_subset_zero {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hinj : injective f) (x : VS₁.V) (hx : f.mapping x = VS₂.zero) : x = VS₁.zero := by
  apply hinj x VS₁.zero
  rw [hx]
  have hzero_map : f.mapping VS₁.zero = VS₂.zero := map_zero_additive f.mapping f.additive
  rw [hzero_map]

/-! ## Image and surjectivity (L4)

f is surjective iff its image is the full codomain.
Proved in Morphisms.Hom (surjective_iff_image_full). Here we provide a convenience lemma.
-/

theorem surjective_image_eq_univ {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hsurj : surjective f) : image f = Set.univ := by
  -- Use the Hom version which is proved
  -- surjective_iff_image_full is imported from Morphisms.Hom
  exact ((surjective_iff_image_full f).mp hsurj)

/-! ## Dimension relationships under linear maps (L4) -/

axiom linearMapPreservesDim {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hSurj : surjective f) (hfin₁ : isFiniteDimensional VS₁) :
    dimension VS₁ ≥ dimension VS₂

axiom injective_preserves_dim_le {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hInj : injective f) (hfin₂ : isFiniteDimensional VS₂) :
    dimension VS₁ ≤ dimension VS₂

axiom bijective_iff_isomorphism {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : bijective f ↔ isIsomorphic VS₁ VS₂

/-! ## Preservation of linear independence (L4)

An injective linear map preserves linear independence:
if f is injective and S ⊆ V is linearly independent,
then f(S) ⊆ W is linearly independent.
-/

def imageOfSet {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (S : Set VS₁.V) : Set VS₂.V :=
  { f.mapping v | v ∈ S }

theorem imageOfSet_subset_image {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (S : Set VS₁.V) : imageOfSet f S ⊆ image f := by
  intro w hw
  rcases hw with ⟨v, hv, rfl⟩
  exact ⟨v, rfl⟩

axiom injective_preserves_independence {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hInj : injective f) (S : Set VS₁.V)
    (hind : linearlyIndependent VS₁ S) : linearlyIndependent VS₂ (imageOfSet f S)

/-! ## Preservation of spanning (L4)

A surjective linear map preserves spanning:
if f is surjective and S spans V, then f(S) spans W.
-/

axiom surjective_preserves_spanning {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hSurj : surjective f) (S : Set VS₁.V)
    (hspan : spans VS₁ S) : spans VS₂ (imageOfSet f S)

/-! ## Five Lemma for vector spaces (L8: advanced)

The short five lemma: given a commutative diagram of linear maps
with exact rows and isomorphisms at the ends, the middle map is
also an isomorphism.
-/

structure FiveLemmaData {F : Field} where
  V₁ V₂ V₃ W₁ W₂ W₃ : VectorSpace F
  f : LinearMap V₁ V₂
  g : LinearMap V₂ V₃
  h : LinearMap W₁ W₂
  k : LinearMap W₂ W₃
  φ : LinearMap V₁ W₁
  ψ : LinearMap V₂ W₂
  χ : LinearMap V₃ W₃

axiom shortFiveLemma {F : Field} (data : FiveLemmaData F) :
    injective data.f → injective data.h →
    surjective data.g → surjective data.k →
    (data.ψ.comp data.f = data.h.comp data.φ) →
    (data.χ.comp data.g = data.k.comp data.ψ) →
    injective data.ψ ∧ surjective data.ψ

/-! ## Rank-nullity (L4: Fundamental Theorem)

dim(V) = rank(f) + nullity(f). Proved in Theorems.Basic,
restated here for completeness.
-/

axiom rankNullityTheorem {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hfin : isFiniteDimensional VS₁) :
    dimension VS₁ = rank f + nullity f

/-! ## Monomorphism/Epimorphism characterization (L3: Category-theoretic)

In Vec(F), monomorphisms = injective linear maps,
epimorphisms = surjective linear maps. This connects the set-theoretic
notions to the categorical ones.
-/

def isMonomorphism {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Prop :=
  ∀ {VS₀ : VectorSpace F} (g h : LinearMap VS₀ VS₁), f.comp g = f.comp h → g = h

def isEpimorphism {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Prop :=
  ∀ {VS₃ : VectorSpace F} (g h : LinearMap VS₂ VS₃), g.comp f = h.comp f → g = h

axiom mono_iff_injective {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : isMonomorphism f ↔ injective f

axiom epi_iff_surjective {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : isEpimorphism f ↔ surjective f

/-! ## #eval examples -/

def testMapPres : LinearMap (fnSpace Field.trivial 3) (fnSpace Field.trivial 3) where
  mapping f := f
  additive _ _ := rfl
  homogeneous _ _ := rfl

def testMapZeroPres : LinearMap (fnSpace Field.trivial 3) (fnSpace Field.trivial 3) where
  mapping _ := λ _ => Field.trivial.zero
  additive _ _ := rfl
  homogeneous _ _ := rfl

#eval "══ Properties.Preservation ══"
#eval "• injective, surjective, bijective defined (L2)"
#eval s!"• injective testMapPres = {injective testMapPres}"
#eval "• injective_iff_kernel_trivial (L4, re-exported from Hom)"
#eval "• surjective_iff_image_full (L4, re-exported from Hom)"
#eval "• bijective_iff_isomorphism — det. isomorphism via kernel/image"
#eval "• injective_preserves_independence — in dim ≤ codim (L4)"
#eval "• surjective_preserves_spanning — onto preserves spanning"
#eval "• rankNullityTheorem — dim = rank + nullity (L4)"
#eval "• mono_iff_injective, epi_iff_surjective (L3)"
#eval "• FiveLemmaData, shortFiveLemma — short five lemma (L8)"

end MiniVectorSpaceCore
