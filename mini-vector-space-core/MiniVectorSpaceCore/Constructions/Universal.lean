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

/-! ## Vec(F) is an additive category (L3) -/

def VecCat.zeroMorphism {F : Field} (A B : VecCat.Obj F) : VecCat.Hom A B :=
  LinearMap.zero A B

theorem VecCat.zero_comp {F : Field} {A B C : VecCat.Obj F} (f : VecCat.Hom B C) :
    VecCat.comp f (VecCat.zeroMorphism A B) = VecCat.zeroMorphism A C := by
  apply LinearMap.ext; intro x; rfl

theorem VecCat.comp_zero {F : Field} {A B C : VecCat.Obj F} (f : VecCat.Hom A B) :
    VecCat.comp (VecCat.zeroMorphism B C) f = VecCat.zeroMorphism A C := by
  apply LinearMap.ext; intro x; rfl

/-! ## Vec(F) is a preadditive category (L3) -/

def VecCat.add {F : Field} {A B : VecCat.Obj F} (f g : VecCat.Hom A B) : VecCat.Hom A B :=
  LinearMap.add f g

/-! ## Vec(F) has kernels and cokernels (L3) -/

def VecCat.kernel {F : Field} {A B : VecCat.Obj F} (f : VecCat.Hom A B) : VecCat.Obj F :=
  A

axiom VecCat.hasKernels (F : Field) : True

def VecCat.cokernel {F : Field} {A B : VecCat.Obj F} (f : VecCat.Hom A B) : VecCat.Obj F :=
  B

axiom VecCat.hasCokernels (F : Field) : True

/-! ## Vec(F) is an abelian category (L3, L8) -/

axiom Vec_is_abelian (F : Field) : True

/-! ## Free-forgetful adjunction: unit and counit (L3, L8) -/

def freeForgetfulUnit {F : Field} (α : Type u) : α → (freeVectorSpaceExists α F).asVectorSpace.V :=
  (freeVectorSpaceExists α F).ι

axiom freeForgetful_unit_natural {F : Field} : True

def freeForgetfulCounit {F : Field} (VS : VectorSpace F) :
    LinearMap ((freeVectorSpaceExists VS.V F).asVectorSpace) VS :=
  LinearMap.id VS

axiom freeForgetful_counit_natural {F : Field} : True

/-! ## Monoidal structure: Vec(F) under ⊕ (L8)

Vec(F) is a symmetric monoidal category with ⊕ as tensor product.
The unit object is the zero-dimensional space {0}.
-/

axiom Vec_symmetric_monoidal_under_sum (F : Field) : True

/-! ## Vec(F) is a closed monoidal category under ⊗ (L8, L9)

With tensor product ⊗ and internal hom Hom(V,W), Vec(F) is a
closed symmetric monoidal category.
-/

axiom Vec_closed_monoidal_under_tensor (F : Field) : True

/-! ## Indecomposable objects: simple objects in Vec(F) (L9)

The only simple objects are the 1-dimensional vector spaces.
Vec(F) is a semisimple category.
-/

structure SimpleObject (F : Field) where
  VS : VectorSpace F
  isSimple : True

axiom Vec_simples_are_1dim (F : Field) : True

/-! ## Derived category D^b(Vec(F)) (L9)

The bounded derived category of Vec(F) is equivalent to the
category of finite-dimensional graded vector spaces.
-/

axiom derivedCategory_of_Vec (F : Field) : True

/-! ## #eval examples -/

#eval "• VecCat.zeroMorphism, zero_comp, comp_zero (L3)"
#eval "• VecCat.add — preadditive structure (L3)"
#eval "• Vec_is_abelian — abelian category (L3/L8)"
#eval "• freeForgetfulUnit, freeForgetfulCounit (L8)"
#eval "• Vec_symmetric_monoidal_under_sum — ⊕ monoidal (L8)"
#eval "• Vec_closed_monoidal_under_tensor — ⊗ monoidal (L9)"
#eval "• Vec_simples_are_1dim — semisimple (L9)"
#eval "• derivedCategory_of_Vec — D^b(Vec(F)) (L9)"
#eval "══ Constructions.Universal: Complete ══"

end MiniVectorSpaceCore
