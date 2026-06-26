/-
# MiniSpectralCanonical.Core.Objects

L3: Concrete instances and operations on spectral objects.
Built on Core.Basic types: Vec, Mat, JordanBlock, CompanionMatrix,
SVD, etc. Provides concrete matrix constructions, utility functions,
and small-matrix operations for 2x2 and 3x3 matrices.
-/

import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

/-! ## L3: Concrete Matrix Constructions -/

def Mat.ofList2x2 (a b c d : Rat) : Mat 2 2 :=
  fun i j =>
    match i, j with
    | (0, _), (0, _) => a
    | (0, _), (1, _) => b
    | (1, _), (0, _) => c
    | (1, _), (1, _) => d

def Mat.diagonal2 (a b : Rat) : Mat 2 2 :=
  fun i j => if i = j then (if i = (0 : Fin 2) then a else b) else 0

def Mat.upperTriangular2 (a b d : Rat) : Mat 2 2 :=
  fun i j =>
    match i, j with
    | (0, _), (0, _) => a | (0, _), (1, _) => b
    | (1, _), (0, _) => 0 | (1, _), (1, _) => d

def Mat.jordanBlockMatrix (eigenvalue : Rat) (size : Nat) : Mat size size :=
  fun i j =>
    if i = j then eigenvalue
    else if j.val = i.val + 1 then 1
    else 0

/-! ## L3: Named Matrices -/

def Mat.pauliX : Mat 2 2 := Mat.ofList2x2 0 1 1 0

def Mat.pauliZ : Mat 2 2 := Mat.ofList2x2 1 0 0 (-1)

def Mat.hilbert2 : Mat 2 2 := Mat.ofList2x2 1 (1/2) (1/2) (1/3)

def Mat.vandermonde2 (x y : Rat) : Mat 2 2 :=
  Mat.ofList2x2 1 x 1 y

def Mat.circulant2 (a b : Rat) : Mat 2 2 :=
  Mat.ofList2x2 a b b a

/-! ## L3: Matrix Norms -/

def Mat.frobeniusNormSq2 (A : Mat 2 2) : Rat :=
  let a := A 0 0
  let b := A 0 1
  let c := A 1 0
  let d := A 1 1
  a*a + b*b + c*c + d*d

def Mat.operatorNorm2 (A : Mat 2 2) : Rat :=
  let evs := Mat.eigenvalues2 (Mat.mul (Mat.transpose A) A)
  match evs with
  | [] => 0
  | l :: ls => List.foldl max l ls |>.sqrt.toRat

/-! ## L3: Jordan Block Constructors -/

def JordanBlock.nilpotent (n : Nat) : JordanBlock :=
  { eigenvalue := 0, size := n }

def JordanBlock.identity (lambda : Rat) : JordanBlock :=
  { eigenvalue := lambda, size := 1 }

def JordanBlock.standard2x2 (lambda : Rat) : JordanBlock :=
  { eigenvalue := lambda, size := 2 }

def JordanCanonicalForm.diagonal (eigenvalues : List Rat) : JordanCanonicalForm :=
  let blocks := eigenvalues.map (fun l => { eigenvalue := l, size := 1 : JordanBlock })
  let total := eigenvalues.length
  { blocks := blocks, totalSize := total, sizeCorrect := by simp }

def JordanCanonicalForm.fromBlocks (blks : List JordanBlock) : JordanCanonicalForm :=
  let total := blks.foldl (fun acc b => acc + b.size) 0
  { blocks := blks, totalSize := total, sizeCorrect := rfl }

/-! ## L3: Companion Matrix Constructors -/

def CompanionMatrix.ofDegree1 (a0 : Rat) : CompanionMatrix :=
  { coeffs := [-a0], size := 1, sizeCorrect := rfl }

def CompanionMatrix.ofDegree2 (a0 a1 : Rat) : CompanionMatrix :=
  { coeffs := [-a0, -a1], size := 2, sizeCorrect := rfl }

/-! ## L3: SVD Constructors -/

def SVD.fromSingularValues (s1 s2 : Rat) : SVD :=
  { U := Mat.identity 2, sigma1 := s1, sigma2 := s2,
    Vt := Mat.identity 2, singularValues := [s1, s2] }

def SVD.rank (svd : SVD) : Nat :=
  svd.singularValues.count (fun s => s != 0)

/-! ## L3: Signature Utilities -/

def Signature.fromEigenvalues (evs : List Rat) : Signature :=
  { positive := evs.count (fun l => l > 0)
    negative := evs.count (fun l => l < 0)
    zeroCount := evs.count (fun l => l == 0)
  }

/-! ## L3: Spectral Decomposition Data -/

structure Eigenpair2x2 where
  eigenvalue : Rat
  eigenvector : Vec 2
  deriving Repr

structure SpectralDecomposition2x2 where
  eigenvalues : List Rat
  eigenvectors : List (Vec 2)
  isComplete : eigenvectors.length = eigenvalues.length

structure Diagonalization2x2 where
  A : Mat 2 2
  P : Mat 2 2
  Pinv : Mat 2 2
  D : Mat 2 2
  decomposition : Mat.mul (Mat.mul P D) Pinv = A

/-! ## L3: Gershgorin Region -/

structure GershgorinRegion where
  discs : List GershgorinDisc
  deriving Repr

def GershgorinRegion.contains (r : GershgorinRegion) (z : Rat) : Bool :=
  r.discs.any (fun d => abs (z - d.center) <= d.radius)

def Mat.gershgorinEigenvalueBound2 (A : Mat 2 2) : Rat :=
  let d1 := abs (A 0 1)
  let d2 := abs (A 1 0)
  let c1 := abs (A 0 0)
  let c2 := abs (A 1 1)
  max (c1 + d1) (c2 + d2)

/-! ## L3: Ritz Approximation -/

structure RitzApproximation where
  matrix : Mat 2 2
  subspaceDim : Nat
  ritzValues : List Rat
  ritzVectors : List (Vec 2)

def RitzApproximation.residual (ra : RitzApproximation) (k : Nat) : Rat :=
  match ra.ritzValues.get? k, ra.ritzVectors.get? k with
  | some l, some v =>
    let Av := Mat.applyVec ra.matrix v
    Vec.normSq (Vec.sub Av (Vec.smul l v))
  | _, _ => 0

/-! ## L3: Krylov Utilities -/

def KrylovSubspace.arnoldi (A : Mat 2 2) (v : Vec 2) (m : Nat) : List (Vec 2) :=
  let ks : KrylovSubspace := { matrix := A, startVector := v, order := m }
  KrylovSubspace.basis ks

/-! ## L3: Schur Form Data -/

structure SchurData2x2 where
  schurMatrix : Mat 2 2
  isUpperTriangular : schurMatrix 1 0 = 0
  originalMatrix : Mat 2 2

/-! ## L3: Polar Decomposition Data -/

structure PolarDecomp2x2 where
  U : Mat 2 2
  P : Mat 2 2
  isOrthogonalU : Mat.isOrthogonal2 U
  isSymmetricP : Mat.isSymmetric2 P

/-! ## L3: Quadratic Form -/

structure QuadraticForm2x2 where
  matrix : Mat 2 2
  isSymmetric : Mat.isSymmetric2 matrix

def QuadraticForm2x2.evaluateAt (qf : QuadraticForm2x2) (v : Vec 2) : Rat :=
  Vec.dot v (Mat.applyVec qf.matrix v)

def QuadraticForm2x2.classify (qf : QuadraticForm2x2) : MatrixType2x2 :=
  Mat.classify2x2 qf.matrix

/-! ## L3: Condition Number -/

def Mat.conditionNumber2 (A : Mat 2 2) : Rat :=
  let svd := Mat.svd2 A
  if svd.sigma2 = 0 then 999999 else svd.sigma1 / svd.sigma2

/-! ## L3: Principal Component Analysis -/

structure PCA2x2 where
  dataMatrix : Mat 2 2
  covariance : Mat 2 2
  principalComponents : List (Vec 2)
  explainedVariance : List Rat

def Mat.covarianceMatrix2 (A : Mat 2 2) : Mat 2 2 :=
  Mat.smul (1 / 2) (Mat.mul (Mat.transpose A) A)

end MiniSpectralCanonical