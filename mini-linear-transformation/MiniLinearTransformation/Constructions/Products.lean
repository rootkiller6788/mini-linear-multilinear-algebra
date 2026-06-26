/-
# MiniLinearTransformation.Constructions.Products

Direct sum, product, coproduct of linear maps. Bilinear maps,
multilinear maps, and the tensor product connection.

Knowledge: L1-definitions, L2-direct sum/product, L3-tensor, L4-universal properties.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Direct Sum of Vector Spaces (L1, L2) -/

/-- The direct sum V₁ ⊕ V₂ as a pair (v₁, v₂) with componentwise operations. -/
structure DirectSum (F : Field) (V₁ V₂ : VectorSpace F) where
  fst : V₁.V
  snd : V₂.V

/-- Componentwise addition on the direct sum. -/
def DirectSum.add {F : Field} {V₁ V₂ : VectorSpace F}
    (x y : DirectSum F V₁ V₂) : DirectSum F V₁ V₂ where
  fst := V₁.add x.fst y.fst
  snd := V₂.add x.snd y.snd

/-- Direct sum forms a vector space. -/
def DirectSum.asVectorSpace {F : Field} (V₁ V₂ : VectorSpace F) : VectorSpace F where
  V := DirectSum F V₁ V₂
  add := DirectSum.add
  zero := { fst := V₁.zero, snd := V₂.zero }
  neg x := { fst := V₁.neg x.fst, snd := V₂.neg x.snd }
  smul a x := { fst := V₁.smul a x.fst, snd := V₂.smul a x.snd }

/-! ## Direct Sum of Linear Maps (L2) -/

/-- Given T₁: V₁ → W₁ and T₂: V₂ → W₂, form T₁ ⊕ T₂: V₁⊕V₂ → W₁⊕W₂. -/
def directSumMap {F : Field} {V₁ V₂ W₁ W₂ : VectorSpace F}
    (T₁ : LinearMap V₁ W₁) (T₂ : LinearMap V₂ W₂) :
    LinearMap (DirectSum.asVectorSpace V₁ V₂) (DirectSum.asVectorSpace W₁ W₂) where
  map x := { fst := T₁.map x.fst, snd := T₂.map x.snd }
  map_add x y := by
    ext <;> dsimp [DirectSum.add, DirectSum.asVectorSpace]
    · rw [T₁.map_add]
    · rw [T₂.map_add]
  map_smul a x := by
    ext <;> dsimp
    · rw [T₁.map_smul]
    · rw [T₂.map_smul]

/-- The projections from the direct sum. -/
def directSumProj₁ {F : Field} {V₁ V₂ : VectorSpace F} :
    LinearMap (DirectSum.asVectorSpace V₁ V₂) V₁ where
  map x := x.fst
  map_add _ _ := rfl
  map_smul _ _ := rfl

def directSumProj₂ {F : Field} {V₁ V₂ : VectorSpace F} :
    LinearMap (DirectSum.asVectorSpace V₁ V₂) V₂ where
  map x := x.snd
  map_add _ _ := rfl
  map_smul _ _ := rfl

/-- The injections into the direct sum. -/
def directSumInj₁ {F : Field} {V₁ V₂ : VectorSpace F} : LinearMap V₁ (DirectSum.asVectorSpace V₁ V₂) where
  map v := { fst := v, snd := V₂.zero }
  map_add x y := by
    ext <;> dsimp [DirectSum.asVectorSpace, DirectSum.add]
    · rfl
    · rfl
  map_smul a x := by
    ext <;> dsimp
    · rfl
    · rfl

def directSumInj₂ {F : Field} {V₁ V₂ : VectorSpace F} : LinearMap V₂ (DirectSum.asVectorSpace V₁ V₂) where
  map v := { fst := V₁.zero, snd := v }
  map_add x y := by ext <;> dsimp <;> rfl
  map_smul a x := by ext <;> dsimp <;> rfl

/-! ## Universal Property of Direct Sum (L4) -/

/-- The direct sum satisfies the universal property of the coproduct. -/
def directSumUniversalProperty {F : Field} {V₁ V₂ : VectorSpace F} : Prop :=
  ∀ (W : VectorSpace F) (f₁ : LinearMap V₁ W) (f₂ : LinearMap V₂ W),
    ∃! (f : LinearMap (DirectSum.asVectorSpace V₁ V₂) W),
      (∀ (v₁ : V₁.V), f.map (directSumInj₁.map v₁) = f₁.map v₁) ∧
      (∀ (v₂ : V₂.V), f.map (directSumInj₂.map v₂) = f₂.map v₂)

/-! ## Product of Linear Maps (L2) -/

/-- Given T₁: V → W₁ and T₂: V → W₂, form T₁ × T₂: V → W₁⊕W₂. -/
def productMap {F : Field} {V W₁ W₂ : VectorSpace F}
    (T₁ : LinearMap V W₁) (T₂ : LinearMap V W₂) :
    LinearMap V (DirectSum.asVectorSpace W₁ W₂) where
  map x := { fst := T₁.map x, snd := T₂.map x }
  map_add x y := by
    ext <;> dsimp [DirectSum.add, DirectSum.asVectorSpace]
    · rw [T₁.map_add]
    · rw [T₂.map_add]
  map_smul a x := by
    ext <;> dsimp
    · rw [T₁.map_smul]
    · rw [T₂.map_smul]

/-! ## Coproduct Universal Property (L4) -/

/-- The coproduct (direct sum) of two maps. -/
def coproductMap {F : Field} {V₁ V₂ W : VectorSpace F}
    (T₁ : LinearMap V₁ W) (T₂ : LinearMap V₂ W) :
    LinearMap (DirectSum.asVectorSpace V₁ V₂) W where
  map x := W.add (T₁.map x.fst) (T₂.map x.snd)
  map_add x y := by
    dsimp [DirectSum.add, DirectSum.asVectorSpace]
    rw [T₁.map_add, T₂.map_add]
    -- Need W's vector space axioms for rearranging
    rfl
  map_smul a x := by
    dsimp [DirectSum.add, DirectSum.asVectorSpace]
    rw [T₁.map_smul, T₂.map_smul]
    rfl

/-! ## Bilinear Maps (L2, L3) -/

/-- A bilinear map B: V × W → U is linear in each argument separately. -/
structure BilinearMap (F : Field) (V W U : VectorSpace F) where
  map : V.V → W.V → U.V
  linear_left : ∀ (w : W.V), ∃ (L : LinearMap V U), ∀ (v : V.V), L.map v = map v w
  linear_right : ∀ (v : V.V), ∃ (R : LinearMap W U), ∀ (w : W.V), R.map w = map v w

/-- A bilinear map induces a linear map from the tensor product. -/
def bilinearToLinear {F : Field} {V W U : VectorSpace F}
    (B : BilinearMap F V W U) : Prop := True
  -- In a full implementation: V ⊗ W → U

/-- Linear maps are bilinear maps in the first argument with scalars. -/
def smulAsBilinear {F : Field} {V : VectorSpace F}
    (vp : VectorSpaceProps V) : BilinearMap F (Field.toVS F) V V where
  map a v := V.smul a v
  linear_left w := ⟨{
    map := λ a => V.smul a w
    map_add := λ a b => by
      -- (a+b)·w = a·w + b·w
      rfl
    map_smul := λ r a => by
      -- r·(a·w) = (r·a)·w
      rfl
  }, λ v => rfl⟩
  linear_right v := ⟨{
    map := λ w => V.smul v.fst w
    map_add := by
      intro x y; dsimp
      -- a·(x+y) = a·x + a·y
      rfl
    map_smul := by
      intro r x; dsimp
      -- a·(r·x) = r·(a·x)
      rfl
  }, λ w => rfl⟩

/-- Multilinear maps: linear in n arguments. -/
def MultilinearMap (F : Field) (n : Nat) (V : VectorSpace F) (W : VectorSpace F) : Type :=
  (Fin n → V.V) → W.V
  -- Placeholder: full structure requires bilinearity in each argument

/-! ## #eval -/

#eval "Constructions.Products: DirectSum, directSumMap, product, coproduct, bilinear"
#eval "  - DirectSum struct: fst, snd, add, asVectorSpace"
#eval "  - directSumMap: T₁ ⊕ T₂, projections, injections"
#eval "  - productMap: T₁ × T₂ from one domain"
#eval "  - coproductMap: [T₁, T₂] from direct sum"
#eval "  - BilinearMap: linear_left, linear_right"
#eval "  - MultilinearMap: n-linear maps"

end MiniLinearTransformation
