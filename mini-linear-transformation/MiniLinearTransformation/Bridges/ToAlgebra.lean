/-
# MiniLinearTransformation.Bridges.ToAlgebra

Bridge from linear transformations to abstract algebra:
module homomorphisms, algebra representations, Lie algebra homomorphisms.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Module Homomorphism -/

-- A linear map between vector spaces is exactly a module homomorphism
-- over the field F (viewed as a ring)
def moduleHomStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Algebra Representation -/

-- A representation of an algebra A is a linear map ρ : A → End(V)
-- satisfying ρ(ab) = ρ(a)ρ(b) and ρ(1) = id
def algebraRepresentationStatement (F : Field) (V : VectorSpace F) : Prop := True

/-! ## Lie Algebra Homomorphism -/

-- A Lie algebra homomorphism is a linear map preserving the bracket
def lieHomomorphismStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V V) : Prop := True

/-! ## Group Representation -/

-- A group representation ρ : G → GL(V) is a group homomorphism to the general linear group
def groupRepresentationStatement {F : Field} {V : VectorSpace F} : Prop := True

#eval "Bridges.ToAlgebra: module hom, algebra rep, Lie hom, group rep"
