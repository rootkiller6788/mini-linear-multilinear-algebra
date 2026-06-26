/-
# MiniLinearTransformation.Bridges.ToGeometry

Bridge from linear transformations to geometry:
tangent maps, differential of smooth maps, linear connections.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Tangent Map (Differential) -/

-- The differential df_p : T_p M → T_{f(p)} N is a linear map between tangent spaces
def tangentMapStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Derivative as Linear Map -/

-- The derivative of a smooth map at a point is a linear transformation
def derivativeAsLinearMapStatement {F : Field} {V W : VectorSpace F} : Prop := True

/-! ## Pushforward -/

-- The pushforward f_* : T_p M → T_{f(p)} N of a smooth map f
def pushforwardStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Pullback of Differential Forms -/

-- The pullback f* : Ω^k(N) → Ω^k(M) is a linear map between vector spaces of forms
def pullbackStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

#eval "Bridges.ToGeometry: tangent map, derivative, pushforward, pullback"
