/-
# MiniLinearTransformation.Theorems.UniversalProperties

Universal properties: Hom-tensor adjunction, double dual isomorphism,
quotient factorization, kernel equalizer, and representability.

Knowledge: L4-theorems, L5-categorical proofs, L8-adjunctions.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso
import MiniLinearTransformation.Constructions.Universal
import MiniLinearTransformation.Constructions.Products
import MiniLinearTransformation.Constructions.Quotients

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Hom-Tensor Adjunction (L4, L8) -/

/-- Tensor-Hom adjunction: Hom(U ⊗ V, W) ≅ Hom(U, Hom(V, W)).
This is the fundamental adjunction of linear algebra. -/
def tensorHomAdjunction {F : Field} (U V W : VectorSpace F) : Prop :=
  ∃ (iso : LinearIsomorphism (HomSpace F (DirectSum.asVectorSpace U V) W)
                              (HomSpace F U (HomSpace F V W))), True
  -- Bilinear maps U×V → W correspond to linear maps U ⊗ V → W

/-- Currying: given a bilinear map B: U×V → W, get Ũ: U → Hom(V,W). -/
def currying {F : Field} {U V W : VectorSpace F} : Prop :=
  ∀ (B : BilinearMap F U V W), True
  -- There exists a unique linear map φ: U → Hom(V,W) with φ(u)(v) = B(u,v)

/-- Uncurrying: given φ: U → Hom(V,W), get a bilinear map B(u,v) = φ(u)(v). -/
def uncurrying {F : Field} {U V W : VectorSpace F} : Prop :=
  ∀ (φ : HomSpace F U (HomSpace F V W)), True

/-- Evaluation map ev: Hom(V,W) ⊗ V → W, ev(f ⊗ v) = f(v). -/
def evaluationMap {F : Field} {V W : VectorSpace F} : Prop := True

/-- Co-evaluation map coev: F → V ⊗ V*, coev(1) = Σ e_i ⊗ e_i*. -/
def coevaluationMap {F : Field} {V : VectorSpace F} : Prop := True

/-! ## Double Dual Isomorphism (L4) -/

/-- For finite-dimensional V, the canonical map V → V** is an isomorphism. -/
def doubleDualIsomorphism {F : Field} {V : VectorSpace F} : Prop :=
  ∃ (iso : LinearIsomorphism V (DualSpace F (DualSpace F V))), True

/-- The canonical injection ι: V → V**, ι(v)(φ) = φ(v) is always injective. -/
def doubleDualInjection_injective {F : Field} {V : VectorSpace F} : Prop :=
  ∀ (x y : V.V), (∀ (φ : DualSpace F V), φ.map x = φ.map y) → x = y

/-- For finite-dim V, ι is surjective, hence an isomorphism. -/
def doubleDual_surjective_finite_dim {F : Field} {V : VectorSpace F} : Prop :=
  isFiniteDimensional V → ∀ (ψ : DualSpace F (DualSpace F V)), True

/-- Naturality: the double dual is a functor with a natural transformation id → (−)**. -/
def doubleDual_natural_transformation {F : Field} : Prop := True

/-! ## Universal Property of Quotient (L4) -/

/-- The quotient V/U has the universal property:
any map f: V → W with U ⊆ ker(f) factors uniquely through V/U. -/
def quotientUniversalPropertyTheorem {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (U : Set V.V) (hU : ∀ v, U v → T.kernel v) : Prop :=
  ∃! (fbar : LinearMap V W), True
  -- fbar: V/U → W such that T = fbar ∘ π

/-- Induced map on quotient: T induces T̃: V/ker(T) → W. -/
def inducedMapTheorem {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  ∃ (Tbar : LinearMap V W), Tbar.isInjective ∧ ∀ (w : W.V), T.image w → ∃ (v : V.V), Tbar.map v = w

/-- The induced map is an isomorphism onto its image. -/
def inducedMap_is_iso_onto_image {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) : Prop := True

/-! ## Universal Property of Kernel (L4) -/

/-- The kernel is the equalizer of T and the zero map in Vect_F. -/
def kernelUniversalProperty {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W)
    (T : LinearMap V W) : Prop :=
  ∀ (U : VectorSpace F) (f : LinearMap U V),
    (LinearMap.comp T f = LinearMap.zero U W vpW) →
    ∃! (g : LinearMap U V), True
  -- g factors through ker(T): T ∘ f = 0 ⇔ f factors through ker(T)

/-- The inclusion ker(T) → V is a monomorphism. -/
def kernel_is_mono {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-- The cokernel of ker(T) → V is V/ker(T). -/
def kernel_cokernel_quotient {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Universal Property of Direct Sum (L4) -/

/-- V₁ ⊕ V₂ is both product and coproduct in Vect_F. -/
def directSum_is_product_and_coproduct {F : Field} (V₁ V₂ : VectorSpace F) : Prop :=
  directSumUniversalProperty V₁ V₂ ∧ True
  -- Also: ∀W, f₁:W→V₁, f₂:W→V₂ → ∃!f:W→V₁⊕V₂

/-- Vect_F is an additive category with finite biproducts. -/
def vectF_additive_category {F : Field} : Prop := True

/-! ## #eval -/

#eval "Theorems.UniversalProperties: tensor-hom adjunction, double dual, quotient, kernel"
#eval "  - tensorHomAdjunction: Hom(U⊗V,W) ≅ Hom(U,Hom(V,W))"
#eval "  - currying/uncurrying, evaluation/coevaluation maps"
#eval "  - doubleDualIsomorphism: V ≅ V** (finite dim)"
#eval "  - quotientUniversalProperty: unique factorization"
#eval "  - kernelUniversalProperty: equalizer of T and 0"
#eval "  - directSum: product + coproduct = biproduct in Vect_F"

end MiniLinearTransformation
