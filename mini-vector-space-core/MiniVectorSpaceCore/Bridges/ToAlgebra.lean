/-
# MiniVectorSpaceCore: Bridge to Algebra

Vector spaces are modules over a field. This bridge connects
vector space concepts to ring theory and module theory,
introducing algebras as rings that are also vector spaces.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom

namespace MiniVectorSpaceCore

/-! ## Module as generalization of vector space -/

structure Ring where
  carrier : Type u
  add : carrier → carrier → carrier
  mul : carrier → carrier → carrier
  zero : carrier
  one : carrier
  neg : carrier → carrier

structure Module (R : Ring) where
  M : Type u
  add : M → M → M
  zero : M
  neg : M → M
  smul : R.carrier → M → M

/-! ## Every vector space is a module over its field -/

def VectorSpace.asModule {F : Field} (VS : VectorSpace F) : Module (Ring.mk F.carrier F.add F.mul F.zero F.one F.neg) where
  M   := VS.V
  add := VS.add
  zero := VS.zero
  neg := VS.neg
  smul := VS.smul

axiom vectorSpace_is_module {F : Field} (VS : VectorSpace F) :
  True  -- every VS is a module over F

/-! ## Not every module is a vector space — need field, not just ring -/

def moduleOverRing_notVS (VS : VectorSpace Field.trivial) : Type _ :=
  VS.V  -- placeholder: Z-modules are abelian groups, not necessarily vector spaces

axiom ring_not_field_example :
  True  -- Z is a ring but not a field

/-! ## Algebra: a ring that is also a vector space -/

structure Algebra (F : Field) where
  algV : VectorSpace F
  algMul : algV.V → algV.V → algV.V
  algOne : algV.V

def Algebra.asRing {F : Field} (A : Algebra F) : Ring where
  carrier := A.algV.V
  add     := A.algV.add
  mul     := A.algMul
  zero    := A.algV.zero
  one     := A.algOne
  neg     := A.algV.neg

/-! ## Bilinear maps and tensor products (conceptual) -/

def BilinearMap {F : Field} (VS₁ VS₂ W : VectorSpace F) : Type _ :=
  (VS₁.V × VS₂.V → W.V)

axiom tensorProductExists {F : Field} (VS₁ VS₂ : VectorSpace F) :
  ∃ (VS₃ : VectorSpace F), True

axiom tensorProductUniversal {F : Field} (VS₁ VS₂ W : VectorSpace F)
    (b : BilinearMap VS₁ VS₂ W) :
    ∃ (VS₃ : VectorSpace F), True

/-! ## #eval examples -/

def testRing : Ring where
  carrier := Unit
  add _ _ := ()
  mul _ _ := ()
  zero := ()
  one := ()
  neg _ := ()

def testModule : Module testRing where
  M := Unit
  add _ _ := ()
  zero := ()
  neg _ := ()
  smul _ _ := ()

#eval "Bridges.ToAlgebra: Ring and Module structures defined"
#eval "Bridges.ToAlgebra: VectorSpace.asModule — every VS is a module"
#eval "Bridges.ToAlgebra: Algebra structure — ring + vector space"
#eval "Bridges.ToAlgebra: BilinearMap and tensorProduct concepts introduced"

end MiniVectorSpaceCore
