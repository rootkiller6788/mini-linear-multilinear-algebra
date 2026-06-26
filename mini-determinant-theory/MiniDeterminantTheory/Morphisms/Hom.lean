/-
# MiniDeterminantTheory: Homomorphisms

Morphisms between determinant-equipped structures.
-/

import MiniDeterminantTheory.Core.Basic

namespace MiniDeterminantTheory

/-! ## Determinant-Preserving Maps -/

structure DeterminantHom (V W : Type u) [VectorSpace V F] [VectorSpace W F] where
  map : LinearMap V W
  preserveDeterminant : determinant (map : LinearMap V V) = determinant (map : LinearMap W W)

/-! ## Identity and Composition -/

def DeterminantHom.id (V : Type u) [VectorSpace V F] : DeterminantHom V V where
  map := LinearMap.id V
  preserveDeterminant := rfl

def DeterminantHom.comp {V W X : Type u} [VectorSpace V F] [VectorSpace W F] [VectorSpace X F]
    (g : DeterminantHom W X) (f : DeterminantHom V W) : DeterminantHom V X where
  map := LinearMap.comp g.map f.map
  preserveDeterminant := by
    sorry

end MiniDeterminantTheory
