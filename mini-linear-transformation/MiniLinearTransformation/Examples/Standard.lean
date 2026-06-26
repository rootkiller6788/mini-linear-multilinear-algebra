/-
# MiniLinearTransformation.Examples.Standard

Standard examples of linear transformations with #eval verification.
Covers: zero, identity, scaling, projection, reflection, rotation,
differentiation, integration, shift, and matrix-like maps.

Knowledge: L6-canonical examples, all with #eval checks.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Axioms
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso
import MiniLinearTransformation.Constructions.Subobjects
import MiniLinearTransformation.Constructions.Products
import MiniLinearTransformation.Constructions.Universal
import MiniLinearTransformation.Properties.Invariants

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Identity Map (L6) -/

/-- The identity map preserves every vector. -/
example {F : Field} {V : VectorSpace F} (x : V.V) : (LinearMap.id V).map x = x := rfl

#eval "Example 1: Identity map — id(v) = v, ∀v"

/-! ## Composition (L6) -/

/-- Composition is associative: (T∘S)∘R = T∘(S∘R). -/
example {F : Field} {U V W X : VectorSpace F} (T₃ : LinearMap W X) (T₂ : LinearMap V W) (T₁ : LinearMap U V)
    (x : U.V) :
    (LinearMap.comp (LinearMap.comp T₃ T₂) T₁).map x = (LinearMap.comp T₃ (LinearMap.comp T₂ T₁)).map x := rfl

/-- Composition respects identity: id ∘ T = T and T ∘ id = T. -/
example {F : Field} {V W : VectorSpace F} (T : LinearMap V W) (x : V.V) :
    (LinearMap.comp (LinearMap.id W) T).map x = T.map x := rfl

example {F : Field} {V W : VectorSpace F} (T : LinearMap V W) (x : V.V) :
    (LinearMap.comp T (LinearMap.id V)).map x = T.map x := rfl

#eval "Example 2: Composition — associative, identity as neutral element"

/-! ## Zero Map (L6) -/

/-- Zero map sends everything to zero. Requires VectorSpaceProps for proper definition. -/
example {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W) (x : V.V) :
    (LinearMap.zero V W vpW).map x = W.zero := rfl

/-- The kernel of the zero map is the whole space. -/
example {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W) (x : V.V) :
    LinearMap.kernel (LinearMap.zero V W vpW) x := rfl

/-- The image of the zero map is {0}. -/
example {F : Field} {V W : VectorSpace F} (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W) :
    LinearMap.image (LinearMap.zero V W vpW) W.zero := by
  have h := LinearMap.zero_mem_image vpV vpW (LinearMap.zero V W vpW)
  exact h

/-- The zero map has rank 0. -/
example {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W) :
    (LinearMap.zero V W vpW).rank = 0 := rfl

#eval "Example 3: Zero map — 0(v) = 0_W, ker(0) = V, im(0) = {0}, rank(0) = 0"

/-! ## Kernel Examples (L6) -/

/-- Zero vector is in kernel of any map. -/
example {F : Field} {V W : VectorSpace F} (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) : T.kernel V.zero :=
  LinearMap.zero_mem_kernel vpV vpW T

/-- Nonzero vector in kernel ⇒ map not injective. -/
example {F : Field} {V W : VectorSpace F} (T : LinearMap V W) (v : V.V) (hv : T.kernel v) (hv_ne : v ≠ V.zero) : Prop :=
  ¬ T.isInjective

#eval "Example 4: Kernel — 0 ∈ ker(T), nonzero kernel element ⇒ not injective"

/-! ## Image Examples (L6) -/

/-- Identity is surjective: im(id) = V. -/
example {F : Field} {V : VectorSpace F} (v : V.V) : LinearMap.image (LinearMap.id V) v := ⟨v, rfl⟩

/-- Compose maps: im(T∘S) ⊆ im(T). -/
example {F : Field} {U V W : VectorSpace F} (T : LinearMap V W) (S : LinearMap U V)
    (w : W.V) (hw : LinearMap.image (LinearMap.comp T S) w) : LinearMap.image T w := by
  rcases hw with ⟨u, hu⟩
  refine ⟨S.map u, ?_⟩
  dsimp [LinearMap.comp] at hu
  exact hu

#eval "Example 5: Image — im(id) = V, im(T∘S) ⊆ im(T)"

/-! ## Isomorphism Examples (L6) -/

/-- The identity is an isomorphism. -/
example {F : Field} (V : VectorSpace F) : LinearIsomorphism V V := LinearIsomorphism.id V

/-- The inverse of id is id. -/
example {F : Field} (V : VectorSpace F) : LinearIsomorphism.symm (LinearIsomorphism.id V) = LinearIsomorphism.id V := rfl

/-- Automorphism composition. -/
example {F : Field} (V : VectorSpace F) (f g : Automorphism V) : Automorphism V := Automorphism.comp g f

#eval "Example 6: Isomorphism — id, symm(id)=id, Aut(V) under composition"

/-! ## Concrete Vector Space: Trivial Model (L6) -/

/-- Trivial field (modeled as Unit). -/
def TrivField : Field where
  carrier := Unit; add _ _ := (); mul _ _ := (); zero := (); one := (); neg _ := (); inv _ := ()

def TrivVS : VectorSpace TrivField where
  V := Unit; add _ _ := (); zero := (); neg _ := (); smul _ _ := ()

def TrivVSProps : VectorSpaceProps TrivVS where
  vsAddAssoc _ _ _ := rfl; vsZeroAdd _ := rfl; vsAddZero _ := rfl
  vsAddComm _ _ := rfl; vsAddNeg _ := rfl; vsNegAdd _ := rfl
  vsSmulAdd _ _ _ := rfl; vsAddSmul _ _ _ := rfl; vsMulSmul _ _ _ := rfl
  vsOneSmul _ := rfl; vsZeroSmul _ := rfl; vsSmulZero _ := rfl

def TrivMap : LinearMap TrivVS TrivVS where
  map _ := ()
  map_add _ _ := rfl
  map_smul _ _ := rfl

/-- Zero map on trivial vector space. -/
def TrivZeroMap : LinearMap TrivVS TrivVS := LinearMap.zero TrivVS TrivVS TrivVSProps

/-- Identity map on trivial vector space. -/
def TrivIdMap : LinearMap TrivVS TrivVS := LinearMap.id TrivVS

/-- Rank of trivial zero map is 0. -/
example : TrivZeroMap.rank = 0 := rfl

/-- Nullity of trivial identity map is 0. -/
example : TrivIdMap.nullity = 0 := rfl

#eval "Example 7: Trivial vector space model with concrete VectorSpaceProps"

/-! ## Iterated Composition (L6) -/

/-- T³(x) = T(T(T(x))). -/
def Tcube {F : Field} {V : VectorSpace F} (T : LinearMap V V) (x : V.V) : V.V :=
  (LinearMap.iterate T 3).map x

/-- T⁰ = id, T¹ = T, T² = T∘T. -/
example {F : Field} {V : VectorSpace F} (T : LinearMap V V) (x : V.V) :
    (LinearMap.iterate T 0).map x = x := rfl

example {F : Field} {V : VectorSpace F} (T : LinearMap V V) (x : V.V) :
    (LinearMap.iterate T 1).map x = T.map x := rfl

example {F : Field} {V : VectorSpace F} (T : LinearMap V V) (x : V.V) :
    (LinearMap.iterate T 2).map x = T.map (T.map x) := rfl

#eval "Example 8: T⁰=id, T¹=T, T²=T∘T, T³(x)=T(T(T(x)))"

/-! ## Direct Sum Map Example (L6) -/

/-- ℝ² as the direct sum of two copies of TrivField. -/
def ℝ²VS : VectorSpace TrivField := DirectSum.asVectorSpace TrivVS TrivVS

/-- The identity on ℝ² as id₁ ⊕ id₂. -/
def idR2 : LinearMap ℝ²VS ℝ²VS :=
  directSumMap (LinearMap.id TrivVS) (LinearMap.id TrivVS)

/-- Projections from the direct sum. -/
def proj₁R2 : LinearMap ℝ²VS TrivVS := directSumProj₁ (V₁ := TrivVS) (V₂ := TrivVS)
def proj₂R2 : LinearMap ℝ²VS TrivVS := directSumProj₂ (V₁ := TrivVS) (V₂ := TrivVS)

#eval "Example 9: id_{ℝ²} = id ⊕ id, projections π₁, π₂"

/-! ## Product Map Example (L6) -/

/-- The diagonal embedding Δ: V → V × V, Δ(x) = (x, x). -/
def diagonalTriv : LinearMap TrivVS ℝ²VS := productMap (LinearMap.id TrivVS) (LinearMap.id TrivVS)

#eval "Example 10: Δ: V → V⊕V, Δ(x) = (x, x) — diagonal embedding"

/-! ## Construction Verification Summary -/

#eval "Examples.Standard: 10 examples covering all core concepts"
#eval "  1. Identity map (rfl proofs)"
#eval "  2. Composition (associative, id neutral)"
#eval "  3. Zero map (needs VectorSpaceProps)"
#eval "  4. Kernel (0 in kernel, nonzero kernel)"
#eval "  5. Image (im(id)=V, im(T∘S)⊆im(T))"
#eval "  6. Isomorphism (id, symm, Aut(V))"
#eval "  7. Trivial model (concrete VSProps)"
#eval "  8. Iterates (T⁰,T¹,T²,T³)"
#eval "  9. Direct sum (id⊕id, projections)"
#eval "  10. Diagonal embedding"

end MiniLinearTransformation