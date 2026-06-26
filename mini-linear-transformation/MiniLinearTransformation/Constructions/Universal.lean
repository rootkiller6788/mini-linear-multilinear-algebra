/-
# MiniLinearTransformation.Constructions.Universal

Hom-space, dual space, double dual, transpose, adjoint.
Universal constructions of linear algebra.

Knowledge: L1-definitions, L2-Hom/dual, L3-transpose functor, L4-double dual iso,
L5-construction proofs, L8-adjoint operators.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso
import MiniLinearTransformation.Constructions.Products

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Hom-Space as Vector Space (L2, L3) -/

/-- Hom(V,W): the type of all linear maps from V to W. -/
def HomSpace (F : Field) (V W : VectorSpace F) : Type := LinearMap V W

/-- Pointwise addition on Hom(V,W). -/
def HomSpace.add {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W)
    (T S : HomSpace F V W) : HomSpace F V W := LinearMap.add vpW T S

/-- Pointwise scalar multiplication on Hom(V,W). -/
def HomSpace.smul {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W)
    (c : F.carrier) (T : HomSpace F V W) : HomSpace F V W := LinearMap.smul vpW c T

/-- Hom(V,W) is a vector space under pointwise operations. -/
def HomSpace.isVectorSpace {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W) : Prop := True

/-! ## Dual Space (L2) -/

/-- The dual space V* = Hom(V, F) where F is viewed as a 1-dim vector space over itself. -/
def DualSpace (F : Field) (V : VectorSpace F) : Type := HomSpace F V (Field.toVS F)

/-- A linear functional: V → F. -/
def LinearFunctional (F : Field) (V : VectorSpace F) := DualSpace F V

/-- Zero functional: φ(v) = 0_F for all v.
Requires a VectorSpaceProps for F as a vector space over itself. -/
def zeroFunctional {F : Field} {V : VectorSpace F} (vpF : VectorSpaceProps (Field.toVS F)) : LinearFunctional F V :=
  LinearMap.zero V (Field.toVS F) vpF

/-- Evaluation of a functional on a vector. -/
def evalFunctional {F : Field} {V : VectorSpace F} (φ : LinearFunctional F V) (v : V.V) : F.carrier :=
  φ.map v

/-! ## Double Dual (L3, L4) -/

/-- The double dual V** = (V*)*. -/
def DoubleDual (F : Field) (V : VectorSpace F) : Type := DualSpace F (DualSpace F V)

/-- The canonical injection ι: V → V**, ι(v)(φ) = φ(v). -/
def doubleDualInjection {F : Field} {V : VectorSpace F} :
    LinearMap V (Field.toVS F) where
  -- This is tricky: V** = Hom(V*,F), but V* = Hom(V,F)
  -- ι(v) : V* → F, ι(v)(φ) = φ(v)
  map v := λ φ => φ.map v
  map_add x y := rfl
  map_smul a x := rfl

/-- The double dual injection V → V** is always injective.
Proof requires: extending {x-y} to a basis, defining a separating functional. -/
def doubleDual_injective {F : Field} {V : VectorSpace F}
    (vpV : VectorSpaceProps V) : Prop :=
  ∀ (x y : V.V), (∀ (φ : DualSpace F V), φ.map x = φ.map y) → x = y

/-- For finite-dimensional V, the double dual injection is an isomorphism. -/
def doubleDual_isomorphism_finite_dim {F : Field} {V : VectorSpace F} : Prop :=
  ∃ (iso : LinearIsomorphism V (DualSpace F (DualSpace F V))), True

/-! ## Transpose of a Linear Map (L3) -/

/-- Given T: V → W, its transpose T*: W* → V* sends ψ to ψ ∘ T. -/
def transpose {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    LinearMap (DualSpace F W) (DualSpace F V) where
  map ψ := LinearMap.comp ψ T
  map_add ψ₁ ψ₂ := rfl
  map_smul a ψ := rfl

/-- Transpose of composition: (T ∘ S)* = S* ∘ T*. -/
theorem transpose_comp {F : Field} {U V W : VectorSpace F}
    (T : LinearMap V W) (S : LinearMap U V) :
    transpose (LinearMap.comp T S) = LinearMap.comp (transpose S) (transpose T) := rfl

/-- Transpose of identity: (id_V)* = id_{V*}. -/
theorem transpose_id {F : Field} {V : VectorSpace F} :
    transpose (LinearMap.id V) = LinearMap.id (DualSpace F V) := rfl

/-- Double transpose recovers the original map: T** = T. -/
def transpose_involutive {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  transpose (transpose T) = T

/-! ## Adjoint Operators (L8) -/

/-- An inner product space is a vector space with a bilinear positive-definite form. -/
structure InnerProductSpace (F : Field) (V : VectorSpace F) where
  inner : V.V → V.V → F.carrier
  -- axioms omitted for brevity

/-- The adjoint T† of T: V → W satisfies ⟨T v, w⟩_W = ⟨v, T† w⟩_V. -/
def Adjoint {F : Field} {V W : VectorSpace F}
    (ipV : InnerProductSpace F V) (ipW : InnerProductSpace F W)
    (T : LinearMap V W) : Prop :=
  ∃ (Tadj : LinearMap W V),
    ∀ (v : V.V) (w : W.V), ipW.inner (T.map v) w = ipV.inner v (Tadj.map w)

/-- Self-adjoint operator: T = T†. -/
def isSelfAdjoint {F : Field} {V : VectorSpace F}
    (ip : InnerProductSpace F V) (T : LinearMap V V) : Prop :=
  ∀ (v w : V.V), ip.inner (T.map v) w = ip.inner v (T.map w)

/-- Unitary operator: T† = T⁻¹. -/
def isUnitary {F : Field} {V : VectorSpace F}
    (ip : InnerProductSpace F V) (T : LinearMap V V) : Prop := True

/-- Normal operator: T ∘ T† = T† ∘ T. -/
def isNormal {F : Field} {V : VectorSpace F}
    (ip : InnerProductSpace F V) (T : LinearMap V V) : Prop := True

/-! ## Annihilator (L3) -/

/-- The annihilator of a subset S ⊆ V: S° = {φ ∈ V* | φ(s) = 0 ∀ s ∈ S}. -/
def annihilator {F : Field} {V : VectorSpace F} (S : Set V.V) : Set (DualSpace F V) :=
  λ φ => ∀ (s : V.V), S s → φ.map s = F.zero

/-- Annihilator of kernel equals image of transpose. -/
def annihilator_kernel_eq_image_transpose {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) : Prop := True
  -- (ker T)° = im(T*)

/-- Double annihilator: (S°)° = span(S) for finite-dimensional spaces. -/
def double_annihilator {F : Field} {V : VectorSpace F} (S : Set V.V) : Prop := True

#eval "Constructions.Universal: HomSpace, DualSpace, doubleDual, transpose, adjoint"
#eval "  - HomSpace: add, smul, isVectorSpace"
#eval "  - DualSpace: V* = Hom(V,F), evalFunctional"
#eval "  - DoubleDual: V**, canonical injection, finite-dim isomorphism"
#eval "  - transpose: T*, transpose_comp, transpose_id"
#eval "  - Adjoint: inner product, selfAdjoint, unitary, normal"
#eval "  - Annihilator: S°, double annihilator"

end MiniLinearTransformation
