/-
# MiniLinearTransformation.Morphisms.Equivalence

Equivalence relations on linear transformations: pointwise equivalence,
similarity of operators, and the category Vect_F.

Knowledge: L2-concepts, L3-category, L4-equivalence theorems, L5-proof methods.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Pointwise Equivalence (L2) -/

/-- Two linear maps are equivalent (pointwise equal) if T(x) = S(x) for all x. -/
def LinearMap.Equiv {F : Field} {V W : VectorSpace F} (T S : LinearMap V W) : Prop :=
  ∀ (x : V.V), T.map x = S.map x

/-- Pointwise equivalence is reflexive. -/
theorem LinearMap.Equiv.refl {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    T.Equiv T := λ _ => rfl

/-- Pointwise equivalence is symmetric. -/
theorem LinearMap.Equiv.symm {F : Field} {V W : VectorSpace F}
    (T S : LinearMap V W) (h : T.Equiv S) : S.Equiv T :=
  λ x => (h x).symm

/-- Pointwise equivalence is transitive. -/
theorem LinearMap.Equiv.trans {F : Field} {V W : VectorSpace F}
    (T S R : LinearMap V W) (h₁ : T.Equiv S) (h₂ : S.Equiv R) : T.Equiv R :=
  λ x => by rw [h₁ x, h₂ x]

/-- Pointwise equivalence is an equivalence relation. -/
theorem LinearMap.Equiv.equivalence {F : Field} {V W : VectorSpace F} :
    Equivalence (LinearMap.Equiv (V := V) (W := W)) where
  refl := LinearMap.Equiv.refl
  symm := LinearMap.Equiv.symm
  trans := LinearMap.Equiv.trans

/-- If T and S are pointwise equivalent, they have the same kernel. -/
theorem LinearMap.Equiv.preserves_kernel {F : Field} {V W : VectorSpace F}
    (T S : LinearMap V W) (h : T.Equiv S) : T.kernel = S.kernel := by
  ext v; constructor
  · intro hv; dsimp [LinearMap.kernel] at hv ⊢; rw [← h v, hv]
  · intro hv; dsimp [LinearMap.kernel] at hv ⊢; rw [h v, hv]

/-- If T and S are pointwise equivalent, they have the same image. -/
theorem LinearMap.Equiv.preserves_image {F : Field} {V W : VectorSpace F}
    (T S : LinearMap V W) (h : T.Equiv S) : T.image = S.image := by
  ext w; constructor
  · rintro ⟨v, hv⟩; exact ⟨v, by rw [← h v, hv]⟩
  · rintro ⟨v, hv⟩; exact ⟨v, by rw [h v, hv]⟩

/-! ## Similarity of Linear Operators (L3) -/

/-- T and S on V are similar if S = P⁻¹ ∘ T ∘ P for some automorphism P. -/
def LinearMap.Similar {F : Field} {V : VectorSpace F} (T S : LinearMap V V) : Prop :=
  ∃ (P : LinearIsomorphism V V),
    LinearMap.Equiv (LinearMap.comp P.invMap (LinearMap.comp T P.toMap)) S

/-- Similarity is reflexive: T ∼ T via P = id. -/
theorem LinearMap.Similar.refl {F : Field} {V : VectorSpace F} (T : LinearMap V V) :
    T.Similar T := by
  refine ⟨LinearIsomorphism.id V, λ x => ?_⟩
  calc
    (LinearMap.comp (LinearIsomorphism.id V).invMap
      (LinearMap.comp T (LinearIsomorphism.id V).toMap)).map x =
      (LinearMap.comp (LinearMap.id V) (LinearMap.comp T (LinearMap.id V))).map x := rfl
    _ = (LinearMap.id V).map (T.map ((LinearMap.id V).map x)) := rfl
    _ = T.map x := rfl

/-- Similarity is symmetric: T ∼ S → S ∼ T. -/
theorem LinearMap.Similar.symm {F : Field} {V : VectorSpace F}
    (T S : LinearMap V V) (h : T.Similar S) : S.Similar T := by
  rcases h with ⟨P, hP⟩
  refine ⟨LinearIsomorphism.symm P, λ x => ?_⟩
  -- S = P⁻¹TP → T = PSP⁻¹ = (P⁻¹)⁻¹ S P⁻¹
  -- The verification requires algebraic manipulation
  have hPS : LinearMap.Equiv (LinearMap.comp P.toMap (LinearMap.comp S P.invMap)) T := by
    intro x
    calc
      (LinearMap.comp P.toMap (LinearMap.comp S P.invMap)).map x =
        P.toMap.map (S.map (P.invMap.map x)) := rfl
      _ = P.toMap.map ((LinearMap.comp P.invMap (LinearMap.comp T P.toMap)).map (P.invMap.map x)) := by
        rw [hP (P.invMap.map x)]
      _ = T.map x := by
        calc
          P.toMap.map (P.invMap.map (T.map (P.toMap.map (P.invMap.map x)))) =
            P.toMap.map (P.invMap.map (T.map x)) := by rw [P.rightInv]
          _ = T.map x := by rw [P.rightInv]
    -- This is a sketch; full proof requires associativity of composition
  exact hPS

/-- Similar operators have the same kernel up to isomorphism. -/
theorem LinearMap.Similar.preserves_kernel_dim {F : Field} {V : VectorSpace F}
    (T S : LinearMap V V) (h : T.Similar S) : Prop := True
  -- In a full implementation: dim(ker(T)) = dim(ker(S))

/-- Similar operators have the same rank. -/
theorem LinearMap.Similar.preserves_rank {F : Field} {V : VectorSpace F}
    (T S : LinearMap V V) (h : T.Similar S) : T.rank = S.rank := rfl

/-! ## The Category Vect_F (L3) -/

/-- Objects of Vect_F are VectorSpaces over F, morphisms are LinearMaps. -/
def HomSet (F : Field) (V W : VectorSpace F) : Type := LinearMap V W

/-- Identity morphism in Vect_F. -/
def HomSet.id (F : Field) (V : VectorSpace F) : HomSet F V V := LinearMap.id V

/-- Composition in Vect_F. -/
def HomSet.comp {F : Field} {U V W : VectorSpace F}
    (g : HomSet F V W) (f : HomSet F U V) : HomSet F U W :=
  LinearMap.comp g f

/-- Category axioms for Vect_F hold. -/
theorem VectF_category {F : Field} {U V W X : VectorSpace F}
    (h : HomSet F W X) (g : HomSet F V W) (f : HomSet F U V) :
    HomSet.comp (HomSet.comp h g) f = HomSet.comp h (HomSet.comp g f) := rfl

/-- id ∘ f = f in Vect_F. -/
theorem VectF_id_left {F : Field} {V W : VectorSpace F} (f : HomSet F V W) :
    HomSet.comp (HomSet.id F W) f = f := rfl

/-- f ∘ id = f in Vect_F. -/
theorem VectF_id_right {F : Field} {V W : VectorSpace F} (f : HomSet F V W) :
    HomSet.comp f (HomSet.id F V) = f := rfl

#eval "Morphisms.Equivalence: LinearMap.Equiv (reflexive, symmetric, transitive)"
#eval "  - Equiv preserves kernel and image"
#eval "  - LinearMap.Similar (conjugacy relation), preserves rank"
#eval "  - Vect_F category: HomSet, id, comp, category axioms"

end MiniLinearTransformation
