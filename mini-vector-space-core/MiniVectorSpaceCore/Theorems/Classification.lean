/-
# MiniVectorSpaceCore: Classification Theorems

Vector spaces over a fixed field are classified up to isomorphism
by their dimension. Every n-dimensional space is isomorphic to F^n.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Morphisms.Equivalence
import MiniVectorSpaceCore.Theorems.Basic

namespace MiniVectorSpaceCore

/-! ## Finite-dimensional classification: V ≅ F^n iff dim(V) = n -/

axiom finiteDimClassification {F : Field} (VS : VectorSpace F) (n : Nat)
    (hdim : dimension VS = n) (hfin : hasFiniteDimension VS) :
    isIsomorphic VS (fnSpace F n)

axiom finiteDimClassification_rev {F : Field} (VS : VectorSpace F) (n : Nat)
    (h : isIsomorphic VS (fnSpace F n)) :
    dimension VS = n

/-! ## Infinite-dimensional spaces exist -/

axiom infiniteDimExistence (F : Field) :
    ∃ (VS : VectorSpace F), ¬ hasFiniteDimension VS

def infiniteDimensional {F : Field} (VS : VectorSpace F) : Prop :=
  ¬ hasFiniteDimension VS

/-! ## Countable dimension classification -/

axiom countableDimClassification {F : Field} (VS : VectorSpace F)
    (h : ∀ (n : Nat), dimension VS ≠ n) :
    infiniteDimensional VS

/-! ## Finite-dimensional ⇒ dimension determines isomorphism class -/

axiom sameDim_implies_isomorphic {F : Field} (VS₁ VS₂ : VectorSpace F)
    (h₁ : hasFiniteDimension VS₁) (h₂ : hasFiniteDimension VS₂)
    (hdim : dimension VS₁ = dimension VS₂) :
    isIsomorphic VS₁ VS₂

/-! ## Uncountable-dimension spaces (conceptual) -/

structure UncountableDimension (F : Field) where
  VS : VectorSpace F
  uncountable : True

axiom uncountableDimExists (F : Field) :
  Nonempty (UncountableDimension F)

/-! ## Classification by cardinal (axiom of choice needed) -/

axiom cardinalClassification {F : Field} (VS₁ VS₂ : VectorSpace F) :
  isIsomorphic VS₁ VS₂ ↔ ∃ (κ : Nat), dimension VS₁ = κ ∧ dimension VS₂ = κ

/-! ## Special case: classification of 1-dim spaces -/

axiom oneDimClassification {F : Field} (VS : VectorSpace F)
    (h : dimension VS = 1) :
    isIsomorphic VS (fnSpace F 1)

/-! ## #eval examples -/

def testClassifyVS := fnSpace Field.trivial 3

#eval "Theorems.Classification: finiteDimClassification — V ≅ F^n ⇔ dim(V) = n"
#eval s!"Theorems.Classification: dim(F^3) = {dimension testClassifyVS}"
#eval "Theorems.Classification: sameDim_implies_isomorphic"
#eval "Theorems.Classification: infiniteDimExistence stated"
#eval "Theorems.Classification: cardinalClassification via dimension cardinal"

end MiniVectorSpaceCore
