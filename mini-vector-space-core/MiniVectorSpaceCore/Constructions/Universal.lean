/-
# MiniVectorSpaceCore: Universal Constructions

Category of vector spaces over a fixed field F and the
free vector space functor (left adjoint to the forgetful functor).
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso

namespace MiniVectorSpaceCore

/-! ## Category Vec(F) — objects are VectorSpace F, morphisms are LinearMap -/

structure VecCat (F : Field) where
  dummy : Unit

def VecCat.Obj (F : Field) : Type _ := VectorSpace F

def VecCat.Hom {F : Field} (A B : VecCat.Obj F) : Type _ :=
  LinearMap A B

def VecCat.id {F : Field} (A : VecCat.Obj F) : VecCat.Hom A A :=
  LinearMap.id A

def VecCat.comp {F : Field} {A B C : VecCat.Obj F}
    (g : VecCat.Hom B C) (f : VecCat.Hom A B) : VecCat.Hom A C :=
  LinearMap.comp g f

/-! ## Forgetful functor Vec(F) → Set -/

def forgetfulFunctor {F : Field} (VS : VectorSpace F) : Type _ :=
  VS.V

axiom forgetfulOnMaps {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : forgetfulFunctor VS₁ → forgetfulFunctor VS₂

/-! ## Free vector space on a set -/

structure FreeVectorSpace (α : Type u) (F : Field) where
  carrier  : Type u
  [objFree : MiniObjectKernel.Object carrier]
  addFree  : carrier → carrier → carrier
  zeroFree : carrier
  negFree  : carrier → carrier
  smulFree : F.carrier → carrier → carrier
  ι        : α → carrier  -- embedding of the generating set

/-! ## Free vector space as vector space -/

def FreeVectorSpace.asVectorSpace {α : Type u} {F : Field}
    (free : FreeVectorSpace α F) : VectorSpace F where
  V    := free.carrier
  add  := free.addFree
  zero := free.zeroFree
  neg  := free.negFree
  smul := free.smulFree

/-! ## Existence of free vector space (axiom) -/

axiom freeVectorSpaceExists {α : Type u} (F : Field) : FreeVectorSpace α F

/-! ## Universal property: free ⊣ forgetful -/

axiom freeUniversalProperty {F : Field} {α : Type u} (VS : VectorSpace F)
    (f : α → VS.V) (free : FreeVectorSpace α F) :
    ∃! (g : LinearMap (free.asVectorSpace) VS),
      ∀ (a : α), g.mapping (free.ι a) = f a

/-! ## #eval examples -/

def testVecCat : VecCat Field.trivial := { dummy := () }

#eval "Constructions.Universal: VecCat — category of vector spaces over F"
#eval "Constructions.Universal: VecCat.id and VecCat.comp define category structure"
#eval "Constructions.Universal: FreeVectorSpace — left adjoint to forgetful functor"
#eval "Constructions.Universal: freeUniversalProperty stated as axiom"

end MiniVectorSpaceCore
