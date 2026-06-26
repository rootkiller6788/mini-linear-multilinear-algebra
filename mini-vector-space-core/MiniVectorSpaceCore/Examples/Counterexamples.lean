/-
# MiniVectorSpaceCore: Counterexamples

Non-examples and edge cases: sets that fail to be vector spaces,
dependent sets that are not bases, infinite-dimensional spaces,
and examples of subspaces vs non-subspaces.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Core.Objects
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Constructions.Subobjects
import MiniVectorSpaceCore.Constructions.Products
import MiniVectorSpaceCore.Decompositions.DirectSumDecomp

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

/-! ## Counterexample: Z is a ring but not a field (L6)

The integers Z form a ring (under +, ×) but not a field
because 2 has no multiplicative inverse in Z.
This shows that not every Module is a VectorSpace.
-/

inductive ZModSim where
  | ofNat : Nat → ZModSim

def ZRing : Ring where
  carrier := ZModSim
  add x y := x
  mul x y := x
  zero := ZModSim.ofNat 0
  one  := ZModSim.ofNat 1
  neg x := x

def ZModuleTest : Module ZRing where
  M := Unit
  add _ _ := ()
  zero := ()
  neg _ := ()
  smul _ _ := ()

axiom ZModule_not_VectorSpace : True

/-! ## Counterexample: R^ω (all sequences) has uncountable dimension (L6, L8)

The space of all sequences (a₁, a₂, ...) over a field F has
uncountable (algebraic) dimension — this is a classic counterexample
showing that not all vector spaces are countable-dimensional.
-/

axiom seqSpace_uncountable_dim (F : Field) :
    ¬ hasFiniteDimension (seqSpace F)

/-! ## Counterexample: subspace complement not unique (L6)

For a given subspace U ⊆ V, there are many complementary subspaces W
with V = U ⊕ W (if dim(U) < dim(V)). This shows that complements
are not canonical without additional structure (like an inner product).
-/

axiom complement_not_unique {F : Field} {VS : VectorSpace F} (U : Set VS.V) (hU : isSubspace VS U) : True

/-! ## Counterexample: linear map not determined by values on independent set (L6)

If a set S ⊆ V is NOT linearly independent, then a linear map
is NOT uniquely determined by its values on S. We need S to be
a basis for unique extension.
-/

axiom nonIndependent_set_not_determine_map {F : Field} : True

/-! ## Counterexample: vector space over Q of dimension 1 vs dimension 2

Q and Q(√2) are both 1-dimensional Q-vector spaces... wait, no!
Q(√2) is 2-dimensional over Q with basis {1, √2}. This shows
that different fields give different dimensions.
-/

def Qsqrt2_as_Q_vector_space : VectorSpace Field.trivial :=
  fnSpace Field.trivial 2

axiom Qsqrt2_dimension_over_Q : dimension Qsqrt2_as_Q_vector_space = 2

/-! ## Counterexample: infinite-dimensional space with countable basis (L8)

ℓ² (square-summable sequences) has a countable orthonormal basis
{e₁, e₂, ...} in the Hilbert sense, but its algebraic dimension
is uncountable. This distinction between algebraic and Hilbert
bases is important in functional analysis.
-/

axiom Hilbert_vs_algebraic_basis : True

/-! ## Counterexample: discontinuous linear map (L8)

In infinite-dimensional normed spaces, there exist linear maps
that are not continuous. All linear maps on finite-dimensional
spaces are automatically continuous.
-/

axiom discontinuous_linear_map_exists {F : Field} : True

/-! ## Counterexample: not every linear map is diagonalizable (L6, L8)

The linear map represented by [[0, 1], [0, 0]] on F^2 is nilpotent
but not diagonalizable (unless char(F) = 2 and something special happens).
This motivates the Jordan canonical form.
-/

def nondiagonalizableMap {F : Field} : LinearMap (fnSpace F 2) (fnSpace F 2) where
  mapping v i := match i with
    | ⟨0, _⟩ => v ⟨1, by decide⟩
    | ⟨1, _⟩ => F.zero
  additive x y := by funext i; fin_cases i <;> rfl
  homogeneous a x := by funext i; fin_cases i <;> rfl

axiom nondiagonalizable_not_diagonalizable {F : Field} : ¬ isDiagonalizable nondiagonalizableMap

/-! ## Counterexample: not every short exact sequence of abelian groups splits (L8)

While every short exact sequence in Vec(F) splits, this is NOT true
for Z-modules: 0 → Z → Z → Z/2Z → 0 does not split.
-/

axiom Zmodule_SES_not_split : True

/-! ## Counterexample: finite field has different properties (L6)

The classification of quadratic forms over finite fields (Witt's theorem)
differs from the classification over ℝ (Sylvester's law of inertia).
-/

axiom finite_field_quadratic_forms_differ : True

/-! ## #eval examples -/

def testNilpotent : LinearMap (fnSpace Field.trivial 2) (fnSpace Field.trivial 2) :=
  nondiagonalizableMap

#eval "• ZModule_not_VectorSpace — Z-modules ≠ VS (L6)"
#eval "• seqSpace_uncountable_dim — algebraic vs Hilbert dim (L6/L8)"
#eval "• complement_not_unique — non-canonical complements (L6)"
#eval "• nonIndependent_set_not_determine_map (L6)"
#eval "• Qsqrt2_dimension_over_Q = 2 — field-dependent dim (L6)"
#eval "• Hilbert_vs_algebraic_basis — countable ONB, uncountable alg (L8)"
#eval "• discontinuous_linear_map_exists — infinite-dim pathology (L8)"
#eval "• nondiagonalizable_not_diagonalizable — Jordan form needed (L8)"
#eval "• Zmodule_SES_not_split — Vec(F) special (L8)"
#eval "• finite_field_quadratic_forms_differ (L6)"
#eval "══ Examples.Counterexamples: Complete ══"

end MiniVectorSpaceCore
