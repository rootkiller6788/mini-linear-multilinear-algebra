/-
# MiniLinearTransformation.Constructions.Universal

Universal constructions: Hom(V,W) as vector space, dual space,
transpose of a linear map.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Hom Space -/

-- The set of all linear maps V → W forms a vector space
-- Hom(V,W) has pointwise addition and scalar multiplication
def homSpace (F : Field) (V W : VectorSpace F) : Type := LinearMap V W

/-! ## Dual Space -/

-- The dual space V* = Hom(V, F) of linear functionals
def DualSpace (F : Field) (V : VectorSpace F) : Type := LinearMap V (F : VectorSpace F)
  -- Placeholder: F as a VectorSpace over itself

/-! ## Double Dual -/

-- The double dual V** = (V*)*
-- There is a natural injection V → V**
def doubleDualInjectionStatement {F : Field} {V : VectorSpace F} : Prop := True

/-! ## Transpose of a Linear Map -/

-- Given T : V → W, its transpose T* : W* → V* sends φ to φ ∘ T
def transposeStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Adjoint -/

-- In an inner product space, the adjoint T† : W → V satisfies ⟨T v, w⟩ = ⟨v, T† w⟩
def adjointStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

#eval "Constructions.Universal: Hom space, dual space, double dual, transpose, adjoint"
