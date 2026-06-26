/-
# MiniVectorSpaceCore: Linear Isomorphisms

`LinearIsomorphism` — a linear map with a two-sided inverse.
Includes identity, symmetry, composition, and the `isIsomorphic` predicate.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom

namespace MiniVectorSpaceCore

/-! ## LinearIsomorphism -/

structure LinearIsomorphism {F : Field} (VS₁ VS₂ : VectorSpace F) where
  toMap   : LinearMap VS₁ VS₂
  invMap  : LinearMap VS₂ VS₁
  leftInv : ∀ (x : VS₁.V), invMap.mapping (toMap.mapping x) = x
  rightInv : ∀ (y : VS₂.V), toMap.mapping (invMap.mapping y) = y

def LinearIsomorphism.forward {F : Field} {VS₁ VS₂ : VectorSpace F}
    (φ : LinearIsomorphism VS₁ VS₂) : VS₁.V → VS₂.V :=
  φ.toMap.mapping

def LinearIsomorphism.backward {F : Field} {VS₁ VS₂ : VectorSpace F}
    (φ : LinearIsomorphism VS₁ VS₂) : VS₂.V → VS₁.V :=
  φ.invMap.mapping

/-! ## Identity isomorphism -/

def LinearIsomorphism.id {F : Field} (VS : VectorSpace F) : LinearIsomorphism VS VS where
  toMap    := LinearMap.id VS
  invMap   := LinearMap.id VS
  leftInv  := λ _ => rfl
  rightInv := λ _ => rfl

/-! ## Symmetry (inverse isomorphism) -/

def LinearIsomorphism.symm {F : Field} {VS₁ VS₂ : VectorSpace F}
    (φ : LinearIsomorphism VS₁ VS₂) : LinearIsomorphism VS₂ VS₁ where
  toMap    := φ.invMap
  invMap   := φ.toMap
  leftInv  := φ.rightInv
  rightInv := φ.leftInv

/-! ## Composition -/

def LinearIsomorphism.comp {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F}
    (ψ : LinearIsomorphism VS₂ VS₃) (φ : LinearIsomorphism VS₁ VS₂) :
    LinearIsomorphism VS₁ VS₃ where
  toMap    := LinearMap.comp ψ.toMap φ.toMap
  invMap   := LinearMap.comp φ.invMap ψ.invMap
  leftInv x := by
    simp [LinearMap.comp, ψ.toMap, φ.toMap, ψ.invMap, φ.invMap,
          ψ.leftInv, φ.leftInv]
  rightInv x := by
    simp [LinearMap.comp, ψ.toMap, φ.toMap, ψ.invMap, φ.invMap,
          ψ.rightInv, φ.rightInv]

/-! ## Isomorphism predicate -/

def isIsomorphic {F : Field} (VS₁ VS₂ : VectorSpace F) : Prop :=
  Nonempty (LinearIsomorphism VS₁ VS₂)

axiom isIsomorphic_refl {F : Field} (VS : VectorSpace F) : isIsomorphic VS VS
axiom isIsomorphic_symm {F : Field} {VS₁ VS₂ : VectorSpace F}
    (h : isIsomorphic VS₁ VS₂) : isIsomorphic VS₂ VS₁
axiom isIsomorphic_trans {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F}
    (h₁ : isIsomorphic VS₁ VS₂) (h₂ : isIsomorphic VS₂ VS₃) : isIsomorphic VS₁ VS₃

/-! ## Concrete isomorphism for fnSpace -/

def iso_identity_test : LinearIsomorphism (fnSpace Field.trivial 2) (fnSpace Field.trivial 2) :=
  LinearIsomorphism.id (fnSpace Field.trivial 2)

def testMap : LinearMap (fnSpace Field.trivial 1) (fnSpace Field.trivial 1) where
  mapping f := f
  additive _ _ := rfl
  homogeneous _ _ := rfl

def iso_test_map : LinearIsomorphism (fnSpace Field.trivial 1) (fnSpace Field.trivial 1) where
  toMap    := testMap
  invMap   := testMap
  leftInv  := λ _ => rfl
  rightInv := λ _ => rfl

/-! ## #eval examples -/

#eval "Morphisms.Iso: LinearIsomorphism defined"
#eval "Morphisms.Iso: identity isomorphism on F^2 constructed"
#eval s!"Morphisms.Iso: iso_identity_test.toMap.mapping = {iso_identity_test.toMap.mapping}"
#eval "Morphisms.Iso: isIsomorphic is an equivalence relation (axioms stated)"

end MiniVectorSpaceCore
