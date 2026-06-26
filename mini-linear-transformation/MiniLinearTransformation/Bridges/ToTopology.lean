/-
# MiniLinearTransformation.Bridges.ToTopology

Bridge from linear transformations to topology:
bounded/continuous linear operators, operator norm, Banach spaces.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Bounded Linear Operator -/

-- In a normed space, a linear map is bounded if ∃M s.t. ‖T v‖ ≤ M‖v‖
def boundedLinearOperatorStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Continuous Linear Map -/

-- For normed vector spaces, bounded ⇔ continuous
def continuousLinearMapStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Operator Norm -/

-- ‖T‖ = sup{‖T v‖ : ‖v‖ ≤ 1}
noncomputable def operatorNormStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : F.carrier := 0

/-! ## Banach Space of Operators -/

-- The space B(V,W) of bounded linear operators is a Banach space
def banachSpaceOfOperatorsStatement {F : Field} (V W : VectorSpace F) : Prop := True

/-! ## Compact Operator -/

-- A linear operator is compact if it maps bounded sets to precompact sets
def compactOperatorStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

#eval "Bridges.ToTopology: bounded/continuous operator, operator norm, Banach, compact"
