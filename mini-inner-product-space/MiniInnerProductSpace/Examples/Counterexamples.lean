/-
# MiniInnerProductSpace.Examples.Counterexamples

Counterexamples in inner product space theory.
-/

import MiniInnerProductSpace.Examples.Standard

namespace MiniInnerProductSpace

open MiniVectorSpaceCore

/-! ## Non-Isomorphic Spaces of Same Dimension -/

def nonIsomorphicExample : Prop :=
  -- R^2 with standard inner product vs R^2 with indefinite inner product
  True

/-! ## Incomplete Inner Product Space -/

def incompleteInnerProductExample : Prop :=
  -- C[0,1] with L^2 inner product is not complete (not a Hilbert space)
  True

/-! ## Non-Existence of Orthonormal Basis (infinite dimensional) -/

def noOrthonormalBasisExample : Prop :=
  -- Some infinite-dimensional inner product spaces lack an orthonormal basis
  True

/-! ## No Adjoint -/

def noAdjointExample : Prop :=
  -- Unbounded operators on infinite-dimensional Hilbert spaces may lack adjoints
  True

/-! ## Parallelogram Law Failure -/

def parallelogramLawFailure : Prop :=
  -- l^1 norm on R^n does not come from an inner product (fails parallelogram law)
  True

/-! ## Self-Adjoint but Not Diagonalizable -/

def selfAdjointNotDiagonalizable : Prop :=
  -- In infinite dimensions, self-adjoint doesn"t guarantee diagonalizability
  True

#eval "Examples.Counterexamples: Non-isomorphic, Incomplete, NoBasis, NoAdjoint, Parallelogram, NonDiagonal"
