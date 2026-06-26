/-
# MiniVectorSpaceCore: Linear Maps (Morphisms)

Structures and operations for linear maps between vector spaces.
-/

import MiniVectorSpaceCore.Core.Basic

namespace MiniVectorSpaceCore

/-! ## LinearMap -/

structure LinearMap {F : Field} (VS₁ VS₂ : VectorSpace F) where
  mapping : VS₁.V → VS₂.V

/-! ## Identity and Composition -/

def LinearMap.id {F : Field} (VS : VectorSpace F) : LinearMap VS VS where
  mapping := id

def LinearMap.comp {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F}
    (g : LinearMap VS₂ VS₃) (f : LinearMap VS₁ VS₂) : LinearMap VS₁ VS₃ where
  mapping := g.mapping ∘ f.mapping

#eval "Morphisms.Hom — stub"
