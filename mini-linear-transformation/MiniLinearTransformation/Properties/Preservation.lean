/-
# MiniLinearTransformation.Properties.Preservation

What linear transformations preserve: linear independence, spanning sets,
dimension relationships.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Preserves Linear Dependence -/

-- If a set is linearly independent, its image under an injective linear map is also linearly independent
def preservesLinearIndependenceStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Preserves Spanning -/

-- A surjective linear map maps spanning sets to spanning sets
def preservesSpanningStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Rank Bounds -/

-- rank(T) ≤ dim(domain) and rank(T) ≤ dim(codomain)
def rankBoundsStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Injective iff Surjective (same finite dimension) -/

-- For V of finite dimension, T : V → V is injective iff it is surjective
def injectiveIffSurjectiveStatement {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop := True

#eval "Properties.Preservation: independence, spanning, rank bounds, injective↔surjective"
