/-
# MiniVectorSpaceCore: Preservation

Properties preserved by linear maps:
injectivity, surjectivity, and their relationships to kernel and image.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Constructions.Subobjects
import MiniVectorSpaceCore.Constructions.Quotients
import MiniVectorSpaceCore.Properties.Invariants

namespace MiniVectorSpaceCore

/-! ## Injectivity of linear maps -/

def injective {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Prop :=
  ∀ (x y : VS₁.V), f.mapping x = f.mapping y → x = y

/-! ## Surjectivity of linear maps -/

def surjective {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Prop :=
  ∀ (y : VS₂.V), ∃ (x : VS₁.V), f.mapping x = y

/-! ## Bijectivity -/

def bijective {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Prop :=
  injective f ∧ surjective f

/-! ## injective iff kernel trivial -/

axiom injective_iff_kernel_trivial {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) :
    injective f ↔ kernel f = {VS₁.zero}

/-! ## surjective iff image full -/

axiom surjective_iff_image_full {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) :
    surjective f ↔ image f = Set.univ

/-! ## Dimension non-increasing under linear maps -/

axiom linearMapPreservesDim {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hSurj : surjective f) :
    dimension VS₁ ≥ dimension VS₂

axiom injective_preserves_dim_le {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hInj : injective f) :
    dimension VS₁ ≤ dimension VS₂

/-! ## Bijective linear map is an isomorphism -/

axiom bijective_iff_isomorphism {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) :
    bijective f ↔ isIsomorphic VS₁ VS₂

/-! ## Preservation of linear independence -/

def mapsIndependent {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (S : Set VS₁.V) : Prop :=
  True

axiom injective_preserves_independence {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hInj : injective f) (S : Set VS₁.V)
    (hind : linearlyIndependent VS₁ S) :
    linearlyIndependent VS₂ (image f)

/-! ## #eval examples -/

def testMapPres : LinearMap (fnSpace Field.trivial 3) (fnSpace Field.trivial 3) where
  mapping f := f

#eval "Properties.Preservation: injective, surjective, bijective defined"
#eval s!"Properties.Preservation: injective testMap = {injective testMapPres}"
#eval "Properties.Preservation: injective_iff_kernel_trivial stated as axiom"
#eval "Properties.Preservation: surjective_iff_image_full stated as axiom"
#eval "Properties.Preservation: bijective_iff_isomorphism stated as axiom"

end MiniVectorSpaceCore
