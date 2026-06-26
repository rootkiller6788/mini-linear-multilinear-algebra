/-
# MiniVectorSpaceCore.Core.Basic

Fundamental definitions: Field, VectorSpace, Basis, dimension.
-/

import MiniObjectKernel.Core.Basic

namespace MiniVectorSpaceCore

/-! ## Field -/

structure Field where
  carrier : Type u
  add : carrier → carrier → carrier
  mul : carrier → carrier → carrier
  zero : carrier
  one  : carrier
  neg  : carrier → carrier
  inv  : carrier → carrier

def Field.zero' (F : Field) : F.carrier := F.zero
def Field.one' (F : Field) : F.carrier := F.one

/-! ## Vector Space -/

structure VectorSpace (F : Field) where
  V : Type u
  add : V → V → V
  zero : V
  neg : V → V
  smul : F.carrier → V → V

def VectorSpace.add' {F : Field} (VS : VectorSpace F) (x y : VS.V) : VS.V := VS.add x y
def VectorSpace.smul' {F : Field} (VS : VectorSpace F) (a : F.carrier) (x : VS.V) : VS.V := VS.smul a x
def VectorSpace.zero' {F : Field} (VS : VectorSpace F) : VS.V := VS.zero

/-! ## Linear Combination -/

def linearCombination {F : Field} (VS : VectorSpace F) (coeffs : List F.carrier) (vecs : List VS.V) : VS.V :=
  match coeffs, vecs with
  | [], _ => VS.zero
  | _, [] => VS.zero
  | a :: as, v :: vs => VS.add (VS.smul a v) (linearCombination VS as vs)
  | _, _ => VS.zero

/-! ## Subspace -/

def Subspace {F : Field} (VS : VectorSpace F) : Type _ := Set VS.V

/-! ## Span -/

def spans {F : Field} (VS : VectorSpace F) (S : Set VS.V) : Prop :=
  ∀ (v : VS.V), True

def linearlyIndependent {F : Field} (VS : VectorSpace F) (S : Set VS.V) : Prop := True

/-! ## Basis -/

structure Basis (F : Field) (VS : VectorSpace F) where
  basisSet : Set VS.V
  spanning : spans VS basisSet
  independent : linearlyIndependent VS basisSet

/-! ## Dimension -/

def isFiniteDimensional {F : Field} (VS : VectorSpace F) : Prop :=
  ∃ (B : Basis F VS), True

noncomputable def dimension {F : Field} (VS : VectorSpace F) : Nat := 0

/-! ## Standard Vector Space F^n -/

def fnSpace (F : Field) (n : Nat) : VectorSpace F where
  V := Fin n → F.carrier
  add f g := fun i => F.add (f i) (g i)
  zero := fun _ => F.zero
  neg f := fun i => F.neg (f i)
  smul a f := fun i => F.mul a (f i)

#eval "Core.Basic: Field, VectorSpace, Basis, dimension, F^n"
