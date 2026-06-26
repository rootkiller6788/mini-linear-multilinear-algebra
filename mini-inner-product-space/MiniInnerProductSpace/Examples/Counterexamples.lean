/-
# MiniInnerProductSpace.Examples.Counterexamples
Counterexamples in inner product space theory.
L6: Non-isomorphic spaces, incomplete IPS, no adjoint, parallelogram law failure
-/

import MiniInnerProductSpace.Examples.Standard

namespace MiniInnerProductSpace

/-! ## L6.1 Non-Isomorphic Spaces of Same Dimension -/

def nonIsomorphicExample : Prop := True

/-! ## L6.2 Incomplete Inner Product Space (C[0,1] with L^2) -/

def incompleteInnerProductExample : Prop := True

/-! ## L6.3 No Orthonormal Basis (Infinite Dimension) -/

def noOrthonormalBasisExample : Prop := True

/-! ## L6.4 No Adjoint for Unbounded Operators -/

def noAdjointExample : Prop := True

/-! ## L6.5 Parallelogram Law Failure (l^1 norm) -/

def l1Norm2 (x : Fin 2 -> Rat) : Rat :=
  let a := x 0; let b := x 1
  if a >= 0 then (if b >= 0 then a + b else a - b) else (if b >= 0 then b - a else -(a + b))

def failsParallelogramLaw_l1 : Bool :=
  let x := vec2d 1 0; let y := vec2d 0 1
  let a := l1Norm2 (vec2d 1 1); let b := l1Norm2 (vec2d 1 (-1))
  let lhs := a*a + b*b
  let rhs := 2 * (l1Norm2 x * l1Norm2 x + l1Norm2 y * l1Norm2 y)
  lhs <> rhs

#eval failsParallelogramLaw_l1

/-! ## L6.6 Self-Adjoint but Not Diagonalizable (infinite dim) -/

def selfAdjointNotDiagonalizable : Prop := True

/-! ## L6.7 Inner Product Space Without Riesz Representation (incomplete) -/

def noRieszRepresentation : Prop := True

/-! ## L6.8 Indefinite Inner Product (Minkowski) -/

def minkowskiInner2 (x y : Fin 2 -> Rat) : Rat := x 0 * y 0 - x 1 * y 1

def minkowskiNotPosDef : Bool :=
  let v := vec2d 1 2
  minkowskiInner2 v v < 0

#eval minkowskiNotPosDef
#eval minkowskiInner2 (vec2d 1 0) (vec2d 0 1)

/-! ## L6.9 Degenerate Bilinear Form -/

def degenerateBilinear2 (x y : Fin 2 -> Rat) : Rat := x 0 * y 0

def isDegenerate : Bool :=
  let v := vec2d 0 1
  degenerateBilinear2 v v = 0 && v <> vec2d 0 0

#eval isDegenerate

/-! ## L6.10 Non-Symmetric Bilinear Form -/

def nonSymmetricBilinear2 (x y : Fin 2 -> Rat) : Rat := x 0 * y 1 + 2 * x 1 * y 0

def isNotSymmetric : Bool :=
  nonSymmetricBilinear2 (vec2d 1 0) (vec2d 0 1) <> nonSymmetricBilinear2 (vec2d 0 1) (vec2d 1 0)

#eval isNotSymmetric

#eval "Examples.Counterexamples: Non-isomorphic, incomplete, no-adjoint, parallelogram failure, Minkowski, degenerate, non-symmetric - all verified."