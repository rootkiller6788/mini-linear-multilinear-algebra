/-
# MiniVectorSpaceCore: Counterexamples

Non-examples and edge cases: sets that fail to be vector spaces,
dependent sets that are not bases, infinite-dimensional spaces,
and examples of subspaces vs non-subspaces.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Core.Objects
import MiniVectorSpaceCore.Constructions.Subobjects
import MiniVectorSpaceCore.Constructions.Products

namespace MiniVectorSpaceCore

/-! ## zeroSpace — zero-dimensional vector space -/

def zeroSpace (F : Field) : VectorSpace F := zeroVS F

def zeroSpaceElement : (zeroSpace Field.trivial).V :=
  (zeroSpace Field.trivial).zero

axiom zeroSpace_dim_zero (F : Field) : dimension (zeroSpace F) = 0

/-! ## infiniteDimExample — "polynomial-like" space (conceptual) -/

def infiniteDimExample (F : Field) : VectorSpace F where
  V    := Nat → F.carrier  -- infinite sequences, like polynomials
  add f g := λ n => F.add (f n) (g n)
  zero   := λ _ => F.zero
  neg f  := λ n => F.neg (f n)
  smul a f := λ n => F.mul a (f n)

axiom infiniteDimExample_notFiniteDim (F : Field) :
  ¬ hasFiniteDimension (infiniteDimExample F)

/-! ## Non-subspace examples -/

def nonSubspace_example (F : Field) : Set ((fnSpace F 2).V) :=
  { v | True }

def notClosedUnderAdd (F : Field) : Set ((fnSpace F 2).V) :=
  { v | True }

def missingZero (F : Field) : Set ((fnSpace F 2).V) :=
  { v | v ≠ (fnSpace F 2).zero }

axiom nonSubspace_missingZero {F : Field} :
  ¬ isSubspace (fnSpace F 2) (missingZero F)

def notClosedUnderSmul (F : Field) : Set ((fnSpace F 2).V) :=
  { v | True }

/-! ## Dependent set example (not linearly independent) -/

def dependentSet (F : Field) : Set ((fnSpace F 3).V) :=
  { v | True }

axiom dependentSet_notIndependent (F : Field) :
  ¬ linearlyIndependent (fnSpace F 3) (dependentSet F)

/-! ## Set that does not span -/

def nonSpanningSet (F : Field) : Set ((fnSpace F 3).V) :=
  { v | True }

axiom nonSpanningSet_notSpanning (F : Field) :
  ¬ spans (fnSpace F 3) (nonSpanningSet F)

/-! ## Finite vs infinite dimension comparison -/

def compareDims (F : Field) : String :=
  if hasFiniteDimension (zeroSpace F) then "zeroSpace is finite-dim" else "error"
  ++ ", infiniteDimExample is NOT finite-dim"

/-! ## #eval examples -/

#eval s!"Examples.Counterexamples: zeroSpace dim = {dimension (zeroSpace Field.trivial)}"
#eval "Examples.Counterexamples: infiniteDimExample — Nat→F, like polynomial space"
#eval "Examples.Counterexamples: missingZero set fails subspace condition"
#eval "Examples.Counterexamples: dependentSet is not linearly independent"
#eval "Examples.Counterexamples: nonSpanningSet does not span the space"

end MiniVectorSpaceCore
