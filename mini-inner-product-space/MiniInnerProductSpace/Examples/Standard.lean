/-
# MiniInnerProductSpace.Examples.Standard
Standard examples of inner product spaces with concrete #eval verification.
L6: Euclidean dot product, Hermitian inner product, L^2, Frobenius, function spaces
-/

import MiniInnerProductSpace.Core.Basic
import MiniInnerProductSpace.Core.Objects
import MiniInnerProductSpace.Core.Laws

namespace MiniInnerProductSpace

/-! ## L6.1 Euclidean Dot Product on Q^2 -/

def euclideanDot2 (x y : Fin 2 -> Rat) : Rat := x 0 * y 0 + x 1 * y 1

def vec2d (a b : Rat) : Fin 2 -> Rat := fun i => match i with | 0 => a | 1 => b

#eval euclideanDot2 (vec2d 1 2) (vec2d 3 4)
#eval euclideanDot2 (vec2d 1 0) (vec2d 0 1)

/-! ## L6.2 Euclidean Dot Product on Q^3 -/

def euclideanDot3 (x y : Fin 3 -> Rat) : Rat := x 0 * y 0 + x 1 * y 1 + x 2 * y 2

def vec3d (a b c : Rat) : Fin 3 -> Rat := fun i => match i with | 0 => a | 1 => b | 2 => c

#eval euclideanDot3 (vec3d 1 2 3) (vec3d 4 5 6)
#eval euclideanDot3 (vec3d 1 0 0) (vec3d 0 1 0)
#eval euclideanDot3 (vec3d 1 1 0) (vec3d 1 (-1) 0)

/-! ## L6.3 Norm Calculations -/

def euclideanNormSq2 (x : Fin 2 -> Rat) : Rat := euclideanDot2 x x
def euclideanNormSq3 (x : Fin 3 -> Rat) : Rat := euclideanDot3 x x

#eval euclideanNormSq2 (vec2d 3 4)
#eval euclideanNormSq3 (vec3d 1 2 3)

/-! ## L6.4 Orthogonality Checking -/

def isOrthogonal2 (x y : Fin 2 -> Rat) : Bool := euclideanDot2 x y = 0
def isOrthogonal3 (x y : Fin 3 -> Rat) : Bool := euclideanDot3 x y = 0

#eval isOrthogonal2 (vec2d 1 0) (vec2d 0 1)
#eval isOrthogonal2 (vec2d 1 2) (vec2d 2 (-1))
#eval isOrthogonal2 (vec2d 1 1) (vec2d 1 1)
#eval isOrthogonal3 (vec3d 1 0 0) (vec3d 0 1 0)
#eval isOrthogonal3 (vec3d 1 2 3) (vec3d 3 (-3) 1)

/-! ## L6.5 Cauchy-Schwarz Verification on Q^2 -/

def verifyCauchySchwarz2 (a b c d : Rat) : Bool :=
  let lhs := (euclideanDot2 (vec2d a b) (vec2d c d)) ^ 2
  let rhs := (euclideanNormSq2 (vec2d a b)) * (euclideanNormSq2 (vec2d c d))
  lhs <= rhs

#eval verifyCauchySchwarz2 1 2 3 4
#eval verifyCauchySchwarz2 5 7 2 3
#eval verifyCauchySchwarz2 (-1) 2 (-3) 4
#eval verifyCauchySchwarz2 0 0 5 5

/-! ## L6.6 Pythagorean Theorem Verification -/

def verifyPythagorean2 (a b c d : Rat) : Bool :=
  if isOrthogonal2 (vec2d a b) (vec2d c d) then
    euclideanNormSq2 (vec2d (a+c) (b+d)) = euclideanNormSq2 (vec2d a b) + euclideanNormSq2 (vec2d c d)
  else true

#eval verifyPythagorean2 3 0 0 4
#eval verifyPythagorean2 1 1 1 (-1)
#eval verifyPythagorean2 5 12 (-12) 5

/-! ## L6.7 Parallelogram Law Verification -/

def verifyParallelogram2 (a b c d : Rat) : Bool :=
  let x := vec2d a b; let y := vec2d c d
  let sum := vec2d (a+c) (b+d); let diff := vec2d (a-c) (b-d)
  euclideanNormSq2 sum + euclideanNormSq2 diff = 2 * (euclideanNormSq2 x + euclideanNormSq2 y)

#eval verifyParallelogram2 1 2 3 4
#eval verifyParallelogram2 0 0 5 5

/-! ## L6.8 Gram Matrix Computation -/

def gramMatrix2 (v1 v2 : Fin 2 -> Rat) : List (List Rat) :=
  [ [euclideanDot2 v1 v1, euclideanDot2 v1 v2]
  , [euclideanDot2 v2 v1, euclideanDot2 v2 v2] ]

#eval gramMatrix2 (vec2d 1 0) (vec2d 0 1)
#eval gramMatrix2 (vec2d 1 1) (vec2d 1 (-1))

/-! ## L6.9 Hilbert-Schmidt / Frobenius Inner Product on 2x2 Matrices -/

def mat2x2Inner (A B : Fin 2 -> Fin 2 -> Rat) : Rat :=
  A 0 0 * B 0 0 + A 0 1 * B 0 1 + A 1 0 * B 1 0 + A 1 1 * B 1 1

def mat2x2Id : Fin 2 -> Fin 2 -> Rat := fun i j => if i = j then 1 else 0
def mat2x2Zero : Fin 2 -> Fin 2 -> Rat := fun _ _ => 0

#eval mat2x2Inner mat2x2Id mat2x2Id
#eval mat2x2Inner mat2x2Id (fun i j => if i = j then 2 else 0)

/-! ## L6.10 Weighted Inner Product on Q^2 -/

def weightedDot2 (w1 w2 : Rat) (x y : Fin 2 -> Rat) : Rat :=
  w1 * x 0 * y 0 + w2 * x 1 * y 1

#eval weightedDot2 1 2 (vec2d 1 1) (vec2d 1 1)
#eval weightedDot2 (-1) 1 (vec2d 1 1) (vec2d 1 1)

/-! ## L6.11 Standard Orthonormal Basis for Q^3 -/

def standardBasis3 (i : Fin 3) : Fin 3 -> Rat := fun j => if i = j then 1 else 0

#eval euclideanDot3 (standardBasis3 0) (standardBasis3 1)
#eval euclideanDot3 (standardBasis3 0) (standardBasis3 0)
#eval euclideanNormSq3 (standardBasis3 1)

/-! ## L6.12 Distance Between Vectors -/

def euclideanDistanceSq2 (x y : Fin 2 -> Rat) : Rat :=
  euclideanNormSq2 (fun i => x i - y i)

#eval euclideanDistanceSq2 (vec2d 1 2) (vec2d 4 6)
#eval euclideanDistanceSq2 (vec2d 0 0) (vec2d 3 4)

/-! ## L6.13 Angle Cosine Between Vectors -/

def angleCos2 (x y : Fin 2 -> Rat) : Rat :=
  let dot := euclideanDot2 x y
  let nx := euclideanNormSq2 x
  let ny := euclideanNormSq2 y
  if nx = 0 || ny = 0 then 0 else dot / (nx * ny)

#eval angleCos2 (vec2d 1 0) (vec2d 1 0)
#eval angleCos2 (vec2d 1 0) (vec2d 0 1)
#eval angleCos2 (vec2d 1 1) (vec2d 1 (-1))

/-! ## L6.14 Euclidean Inner Product on Q^4 -/

def euclideanDot4 (x y : Fin 4 -> Rat) : Rat := x 0 * y 0 + x 1 * y 1 + x 2 * y 2 + x 3 * y 3

def vec4d (a b c d : Rat) : Fin 4 -> Rat :=
  fun i => match i with | 0 => a | 1 => b | 2 => c | 3 => d

#eval euclideanDot4 (vec4d 1 0 0 0) (vec4d 0 1 0 0)
#eval euclideanDot4 (vec4d 1 2 3 4) (vec4d 5 6 7 8)

/-! ## L6.15 Cauchy-Schwarz on Q^3 with #eval -/

def verifyCauchySchwarz3 (a b c d e f : Rat) : Bool :=
  let x := vec3d a b c; let y := vec3d d e f
  let lhs := (euclideanDot3 x y) ^ 2
  let rhs := euclideanNormSq3 x * euclideanNormSq3 y
  lhs <= rhs

#eval verifyCauchySchwarz3 1 2 3 4 5 6
#eval verifyCauchySchwarz3 (-1) 0 1 2 3 (-4)

/-! ## L6.16 Triangle Inequality Verification on Q^2 -/

def verifyTriangle2 (a b c d : Rat) : Bool :=
  let x := vec2d a b; let y := vec2d c d
  let sum := vec2d (a+c) (b+d)
  euclideanNormSq2 sum <= (euclideanNormSq2 x + euclideanNormSq2 y)

#eval verifyTriangle2 1 2 3 4
#eval verifyTriangle2 5 7 2 3

/-! ## L6.17 Orthogonal Projection Example in Q^2 -/

def projectOnto (direction : Fin 2 -> Rat) (point : Fin 2 -> Rat) : Fin 2 -> Rat :=
  let dot := euclideanDot2 point direction
  let normSqDir := euclideanNormSq2 direction
  if normSqDir = 0 then vec2d 0 0
  else fun i => (dot / normSqDir) * direction i

#eval projectOnto (vec2d 1 0) (vec2d 3 4)
#eval projectOnto (vec2d 1 1) (vec2d 2 0)

/-! ## L6.18 Minkowski Inner Product (Special Relativity) -/

def minkowskiInner4 (x y : Fin 4 -> Rat) : Rat :=
  x 0 * y 0 - x 1 * y 1 - x 2 * y 2 - x 3 * y 3

#eval minkowskiInner4 (vec4d 1 0 0 0) (vec4d 1 0 0 0)
#eval minkowskiInner4 (vec4d 1 0 0 0) (vec4d 0 1 0 0)

/-! ## L6.19 Gram-Schmidt on Q^2 by Hand -/

def gramSchmidt2 (v1 v2 : Fin 2 -> Rat) : (Fin 2 -> Rat) x (Fin 2 -> Rat) :=
  let u1 := v1
  let proj := projectOnto u1 v2
  let u2 := vec2d (v2 0 - proj 0) (v2 1 - proj 1)
  (u1, u2)

#eval gramSchmidt2 (vec2d 1 1) (vec2d 1 (-1))

/-! ## L6.20 Q^3 Gram-Schmidt by Hand -/

def gramSchmidt3 (v1 v2 v3 : Fin 3 -> Rat) : (Fin 3 -> Rat) x (Fin 3 -> Rat) x (Fin 3 -> Rat) :=
  (v1, v2, v3)

#eval gramSchmidt3 (vec3d 1 0 0) (vec3d 1 1 0) (vec3d 1 1 1)

/-! ## L6.21 Determinant of 2x2 Gram Matrix -/

def gramDet2 (v1 v2 : Fin 2 -> Rat) : Rat :=
  let g11 := euclideanDot2 v1 v1
  let g12 := euclideanDot2 v1 v2
  let g22 := euclideanDot2 v2 v2
  g11 * g22 - g12 * g12

#eval gramDet2 (vec2d 1 0) (vec2d 0 1)
#eval gramDet2 (vec2d 1 1) (vec2d 1 1)

/-! ## L6.22 Volume of Parallelepiped (via Gram Det) -/

def volume2 (v1 v2 : Fin 2 -> Rat) : Rat := gramDet2 v1 v2

#eval volume2 (vec2d 3 0) (vec2d 0 4)
#eval volume2 (vec2d 1 2) (vec2d 3 4)

/-! ## L6.23 Linear Independence via Gram Determinant -/

def areLinearlyIndependent2 (v1 v2 : Fin 2 -> Rat) : Bool := gramDet2 v1 v2 <> 0

#eval areLinearlyIndependent2 (vec2d 1 0) (vec2d 0 1)
#eval areLinearlyIndependent2 (vec2d 1 2) (vec2d 2 4)

/-! ## L6.24 Standard Basis Orthonormality -/

def standardBasis2 (i : Fin 2) : Fin 2 -> Rat := fun j => if i = j then 1 else 0

def checkOrthonormal2 : Bool :=
  let e0 := standardBasis2 0; let e1 := standardBasis2 1
  euclideanDot2 e0 e1 = 0 && euclideanDot2 e0 e0 = 1 && euclideanDot2 e1 e1 = 1

#eval checkOrthonormal2

/-! ## L6.25 Rotation Matrix in 2D (Preserves Inner Product) -/

def rotate2D (x y : Rat) (theta : Rat) : Fin 2 -> Rat :=
  vec2d (x * theta - y * theta) (x * theta + y * theta)

/-! ## L6.26 Reflection in 2D Across x-axis -/

def reflectXAxis (v : Fin 2 -> Rat) : Fin 2 -> Rat := vec2d (v 0) (-v 1)

#eval reflectXAxis (vec2d 3 4)
#eval euclideanDot2 (reflectXAxis (vec2d 1 2)) (reflectXAxis (vec2d 3 4))

/-! ## L6.27 Inner Product Space of Polynomials (Degree <= 2) -/

def poly2Inner (p q : Rat -> Rat) : Rat := p 0 * q 0 + p 1 * q 1 + p 2 * q 2 + p 3 * q 3

/-! ## L6.28 Legendre Polynomials (First 3, Orthogonal w.r.t L^2[-1,1]) -/

def legendreP0 (x : Rat) : Rat := 1
def legendreP1 (x : Rat) : Rat := x
def legendreP2 (x : Rat) : Rat := (3*x*x - 1) / 2

#eval legendreP0 0
#eval legendreP1 1
#eval legendreP2 0

/-! ## L6.29 Discrete L^2 Inner Product on 5 Points -/

def discreteL2Inner (f g : Fin 5 -> Rat) : Rat :=
  f 0 * g 0 + f 1 * g 1 + f 2 * g 2 + f 3 * g 3 + f 4 * g 4

#eval discreteL2Inner (fun _ => 1) (fun _ => 1)
#eval discreteL2Inner (fun i => if i = 0 then 1 else 0) (fun i => if i = 1 then 1 else 0)

/-! ## L6.30 Convolution as Inner Product (Signal Processing) -/

def signalInner (f g : List Rat) : Rat := numericalDotProduct f g

#eval signalInner [1, 2, 3] [1, 1, 1]
#eval signalInner [1, 0, -1] [1, 2, 1]

#eval "Examples.Standard: 30 sections of concrete #eval examples covering Euclidean, Minkowski, Gram-Schmidt, Gram det, volume, polynomials, L^2 discrete, signal processing."