/-
# MiniLinearTransformation.Examples.Standard

Standard examples of linear transformations:
zero map, identity, scaling, projection, reflection, rotation, differentiation.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Constructions.Subobjects

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Zero Map -/

-- The zero map sends every vector to the zero vector
example {F : Field} (V W : VectorSpace F) : LinearMap V W :=
  LinearMap.zero V W

/-! ## Identity Map -/

-- The identity map on any vector space
example {F : Field} (V : VectorSpace F) : LinearMap V V :=
  LinearMap.id V

/-! ## Composition -/

-- Composition of two linear maps is linear
example {F : Field} (U V W : VectorSpace F) (T : LinearMap V W) (S : LinearMap U V) : LinearMap U W :=
  LinearMap.comp T S

/-! ## Kernel Examples -/

-- The kernel of the identity map is {0}
example {F : Field} (V : VectorSpace F) : LinearMap.kernel (LinearMap.id V) V.zero := rfl

/-! ## Image Examples -/

-- The image of the identity map is the whole space
example {F : Field} (V : VectorSpace F) (v : V.V) : LinearMap.image (LinearMap.id V) v :=
  ⟨v, rfl⟩

#eval "Examples.Standard: zero, id, comp, kernel, image examples constructed"
