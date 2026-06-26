/-
# MiniVectorSpaceCore: Vector Space Equivalence

Dimension-based equivalence of vector spaces.
Two vector spaces are equivalent when they have the same dimension.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom

namespace MiniVectorSpaceCore

/-! ## VectorSpaceEquivalence — by equal dimension -/

structure VectorSpaceEquivalence {F : Field} (VS₁ VS₂ : VectorSpace F) where
  dimMatch : dimension VS₁ = dimension VS₂

/-! ## isEquivalent predicate -/

def isEquivalent {F : Field} (VS₁ VS₂ : VectorSpace F) : Prop :=
  dimension VS₁ = dimension VS₂

axiom isEquivalent_refl {F : Field} (VS : VectorSpace F) : isEquivalent VS VS

axiom isEquivalent_symm {F : Field} {VS₁ VS₂ : VectorSpace F}
    (eq : isEquivalent VS₁ VS₂) : isEquivalent VS₂ VS₁

axiom isEquivalent_trans {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F}
    (eq₁ : isEquivalent VS₁ VS₂) (eq₂ : isEquivalent VS₂ VS₃) :
    isEquivalent VS₁ VS₃

/-! ## Dimension lemma: isomorphic implies equivalent -/

axiom iso_implies_equivalent {F : Field} {VS₁ VS₂ : VectorSpace F}
    (h : isIsomorphic VS₁ VS₂) : isEquivalent VS₁ VS₂

/-! ## Equivalent vector spaces -/

def equivalentByDim {F : Field} (VS₁ VS₂ : VectorSpace F) (n : Nat)
    (h₁ : dimension VS₁ = n) (h₂ : dimension VS₂ = n) :
    VectorSpaceEquivalence VS₁ VS₂ where
  dimMatch := by rw [h₁, h₂]

/-! ## Construct equivalence from isomorphism -/

def vecEquivFromIso {F : Field} {VS₁ VS₂ : VectorSpace F}
    (iso : LinearIsomorphism VS₁ VS₂) : VectorSpaceEquivalence VS₁ VS₂ where
  dimMatch := by
    -- axiom: isomorphic spaces have equal dimension
    exact iso_implies_equivalent (by exact ⟨iso⟩) |>.dimMatch

/-! ## Equivalence class helper -/

def equivalenceClass {F : Field} (n : Nat) : Type _ :=
  Σ (VS : VectorSpace F), dimension VS = n

def zeroDimClass {F : Field} : equivalenceClass (F := F) 0 :=
  ⟨zeroVS F, rfl⟩

/-! ## #eval examples -/

def testVS1 := fnSpace Field.trivial 3
def testVS2 := fnSpace Field.trivial 3

#eval "Morphisms.Equivalence: VectorSpaceEquivalence defined"
#eval s!"Morphisms.Equivalence: dim(testVS1) = {dimension testVS1}, dim(testVS2) = {dimension testVS2}"
#eval s!"Morphisms.Equivalence: isEquivalent testVS1 testVS2 = {isEquivalent testVS1 testVS2}"
#eval "Morphisms.Equivalence: equivalence relation axioms stated (refl, symm, trans)"

end MiniVectorSpaceCore
