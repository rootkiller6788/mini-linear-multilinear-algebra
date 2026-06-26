/-
# MiniVectorSpaceCore: Classification Data

Data structures for classifying vector spaces by dimension and base field.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Morphisms.Equivalence
import MiniVectorSpaceCore.Properties.Invariants

namespace MiniVectorSpaceCore

/-! ## VectorSpaceClass — classification by dimension -/

structure VectorSpaceClass (F : Field) where
  dim  : Nat

instance : BEq (VectorSpaceClass F) where
  beq a b := a.dim == b.dim

/-! ## classifyFinite: every finite-dim space classified by its dimension -/

def classifyFinite {F : Field} (VS : VectorSpace F)
    (h : hasFiniteDimension VS) : VectorSpaceClass F where
  dim := dimension VS

axiom classifyFinite_complete {F : Field} (VS₁ VS₂ : VectorSpace F)
    (h₁ : hasFiniteDimension VS₁) (h₂ : hasFiniteDimension VS₂)
    (h : classifyFinite VS₁ h₁ = classifyFinite VS₂ h₂) :
    isIsomorphic VS₁ VS₂

axiom classifyFinite_sound {F : Field} (VS₁ VS₂ : VectorSpace F)
    (h₁ : hasFiniteDimension VS₁) (h₂ : hasFiniteDimension VS₂)
    (h : isIsomorphic VS₁ VS₂) :
    classifyFinite VS₁ h₁ = classifyFinite VS₂ h₂

/-! ## classifyByField — classifying spaces by their base field -/

def classifyByField {F : Field} (VS : VectorSpace F) : Field := F

axiom classifyByField_sound {F : Field} {VS : VectorSpace F} :
  classifyByField VS = F

/-! ## Classification data for dimension 0, 1, 2, 3, n -/

def classDim0 (F : Field) : VectorSpaceClass F := { dim := 0 }
def classDim1 (F : Field) : VectorSpaceClass F := { dim := 1 }
def classDim2 (F : Field) : VectorSpaceClass F := { dim := 2 }
def classDim3 (F : Field) : VectorSpaceClass F := { dim := 3 }
def classDimN (F : Field) (n : Nat) : VectorSpaceClass F := { dim := n }

/-! ## Comparison of classification data -/

def classes_equal {F : Field} (c₁ c₂ : VectorSpaceClass F) : Prop :=
  c₁.dim = c₂.dim

/-! ## #eval examples -/

def cls1 : VectorSpaceClass Field.trivial := classifyFinite (fnSpace Field.trivial 3) (by
  refine ⟨3, ?_⟩
  rfl)

#eval "Properties.ClassificationData: VectorSpaceClass defined"
#eval s!"Properties.ClassificationData: classDim0 F = {{dim := 0}}"
#eval s!"Properties.ClassificationData: cls1.dim = {cls1.dim}"
#eval s!"Properties.ClassificationData: classifyFinite_complete and classifyFinite_sound stated"

end MiniVectorSpaceCore
