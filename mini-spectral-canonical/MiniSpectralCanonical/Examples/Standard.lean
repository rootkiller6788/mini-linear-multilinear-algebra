/-
# MiniSpectralCanonical.Examples.Standard

L6: Standard examples with #eval verification.
Identity, diagonal, Jordan blocks, nilpotent, SVD,
rotation, reflection, Hilbert, Vandermonde, circulant.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Core.Objects
import MiniSpectralCanonical.Properties.Invariants
import MiniSpectralCanonical.Theorems.Main

namespace MiniSpectralCanonical

/-! ## L6: Identity Matrix I_2

I has eigenvalue 1 (multiplicity 2), det = 1, tr = 2.
All vectors are eigenvectors. JCF is two 1x1 blocks.
-/

def exampleIdentity : Mat 2 2 := Mat.identity 2

#eval "=== Example: Identity Matrix ==="
#eval "Trace: " ++ toString (Mat.trace exampleIdentity)
#eval "Det: " ++ toString (Mat.det2 exampleIdentity)
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 exampleIdentity)

/-! ## L6: Diagonal Matrix diag(3, 5)

Eigenvalues 3 and 5, det = 15, tr = 8.
Eigenvectors are e1, e2. Orthogonal eigenbasis.
-/

def exampleDiagonal : Mat 2 2 := Mat.diagonal2 3 5

#eval "=== Example: Diagonal Matrix diag(3,5) ==="
#eval "Trace: " ++ toString (Mat.trace exampleDiagonal)
#eval "Det: " ++ toString (Mat.det2 exampleDiagonal)
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 exampleDiagonal)
#eval "Is symmetric: " ++ toString (Mat.isSymmetric2 exampleDiagonal)

/-! ## L6: Jordan Block J_2(4)

Eigenvalue 4 (algebraic multiplicity 2, geometric multiplicity 1).
Not diagonalizable. [[4,1],[0,4]].
-/

def exampleJordanBlock : Mat 2 2 :=
  Mat.jordanBlockMatrix 4 2

#eval "=== Example: Jordan Block J_2(4) ==="
#eval "Trace: " ++ toString (Mat.trace exampleJordanBlock)
#eval "Det: " ++ toString (Mat.det2 exampleJordanBlock)
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 exampleJordanBlock)
#eval "Matrix type: " ++ toString (Mat.classify2x2 exampleJordanBlock)

/-! ## L6: Nilpotent Jordan Block J_2(0)

Eigenvalue 0 (multiplicity 2). J^2 = 0.
[[0,1],[0,0]].
-/

def exampleNilpotent : Mat 2 2 :=
  Mat.jordanBlockMatrix 0 2

#eval "=== Example: Nilpotent Jordan Block J_2(0) ==="
#eval "Trace: " ++ toString (Mat.trace exampleNilpotent)
#eval "Det: " ++ toString (Mat.det2 exampleNilpotent)
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 exampleNilpotent)
#eval "Spectral radius: " ++ toString (Mat.spectralRadius2 exampleNilpotent)

/-! ## L6: Rotation Matrix by pi/6

Rotation matrix [[cos(t), -sin(t)], [sin(t), cos(t)]].
Eigenvalues are complex (elliptic type).
-/

def exampleRotation : Mat 2 2 :=
  Mat.rotation2 (1)  -- theta = 1 radian

#eval "=== Example: Rotation Matrix ==="
#eval "Trace: " ++ toString (Mat.trace exampleRotation)
#eval "Det: " ++ toString (Mat.det2 exampleRotation)
#eval "Matrix type: " ++ toString (Mat.classify2x2 exampleRotation)

/-! ## L6: Symmetric Matrix [[4,2],[2,3]]

Eigenvalues: (7+sqrt(17))/2 and (7-sqrt(17))/2.
Orthogonal eigenbasis exists.
-/

def exampleSymmetric : Mat 2 2 := Mat.ofList2x2 4 2 2 3

#eval "=== Example: Symmetric Matrix [[4,2],[2,3]] ==="
#eval "Trace: " ++ toString (Mat.trace exampleSymmetric)
#eval "Det: " ++ toString (Mat.det2 exampleSymmetric)
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 exampleSymmetric)
#eval "Signature: pos=" ++ toString (Mat.signature2 exampleSymmetric).positive ++
      " neg=" ++ toString (Mat.signature2 exampleSymmetric).negative ++
      " zero=" ++ toString (Mat.signature2 exampleSymmetric).zeroCount
#eval "Is symmetric: " ++ toString (Mat.isSymmetric2 exampleSymmetric)

/-! ## L6: Hilbert Matrix H_2

H_2 = [[1, 1/2], [1/2, 1/3]].
Highly ill-conditioned. Condition number large.
-/

def exampleHilbert : Mat 2 2 := Mat.hilbert2

#eval "=== Example: Hilbert Matrix ==="
#eval "Trace: " ++ toString (Mat.trace exampleHilbert)
#eval "Det: " ++ toString (Mat.det2 exampleHilbert)
#eval "Condition number: " ++ toString (Mat.conditionNumber2 exampleHilbert)

/-! ## L6: Vandermonde Matrix V(x,y)

V = [[1, x], [1, y]]. det(V) = y - x.
-/

def exampleVandermonde : Mat 2 2 := Mat.vandermonde2 2 5

#eval "=== Example: Vandermonde Matrix ==="
#eval "Trace: " ++ toString (Mat.trace exampleVandermonde)
#eval "Det (should be 5-2=3): " ++ toString (Mat.det2 exampleVandermonde)
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 exampleVandermonde)

/-! ## L6: Circulant Matrix

C = [[a, b], [b, a]]. Eigenvalues: a+b, a-b.
Eigenvectors: [1,1], [1,-1] (always independent of a,b).
-/

def exampleCirculant : Mat 2 2 := Mat.circulant2 5 3

#eval "=== Example: Circulant Matrix ==="
#eval "Trace: " ++ toString (Mat.trace exampleCirculant)
#eval "Det: " ++ toString (Mat.det2 exampleCirculant)
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 exampleCirculant)
#eval "Eigenvectors for l1=" ++ toString ((Mat.eigenvalues2 exampleCirculant).head?)

/-! ## L6: SVD Example

Compute SVD of [[3,0],[4,5]].
-/

def exampleSVDinput : Mat 2 2 := Mat.ofList2x2 3 0 4 5

#eval "=== Example: SVD ==="
#eval "Singular values: " ++ toString (Mat.svd2 exampleSVDinput).singularValues

/-! ## L6: Complete Spectral Analysis Demo

Full analysis of a 2x2 matrix.
-/

def exampleFullAnalysis : Mat 2 2 := Mat.ofList2x2 1 2 3 4

#eval "=== Complete Spectral Analysis ==="
#eval "Matrix: [[1,2],[3,4]]"
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 exampleFullAnalysis)
#eval "Char poly: coeffs=" ++ toString (Mat.charPoly2 exampleFullAnalysis).coeffs
#eval "Trace: " ++ toString (Mat.trace exampleFullAnalysis)
#eval "Det: " ++ toString (Mat.det2 exampleFullAnalysis)
#eval "Discriminant: " ++ toString ((Mat.trace exampleFullAnalysis)^2 - 4*Mat.det2 exampleFullAnalysis)
#eval "Matrix type: " ++ toString (Mat.classify2x2 exampleFullAnalysis)
#eval "Spectral radius: " ++ toString (Mat.spectralRadius2 exampleFullAnalysis)

/-! ## L6: Power Method Demo

Find dominant eigenvalue of [[2,1],[1,2]].
-/

def examplePowerMethod : Mat 2 2 := Mat.ofList2x2 2 1 1 2

#eval "=== Power Method ==="
#eval "True eigenvalues: " ++ toString (Mat.eigenvalues2 examplePowerMethod)
#eval "Power iter (10 steps) eigenvalue: " ++
  toString (Vec.powerIterEigenvalue examplePowerMethod (Vec.basis 2 0) 10)
#eval "Power iter (20 steps) eigenvalue: " ++
  toString (Vec.powerIterEigenvalue examplePowerMethod (Vec.basis 2 0) 20)

end MiniSpectralCanonical