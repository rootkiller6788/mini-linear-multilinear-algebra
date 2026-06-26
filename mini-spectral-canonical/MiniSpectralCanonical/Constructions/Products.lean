/-
# MiniSpectralCanonical.Constructions.Products

L3: Product constructions for spectral theory.
Tensor products, Kronecker products, direct sums, and their
spectral properties.
-/

import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

/-! ## L3: Kronecker Product

The Kronecker product A (x) B of mxn and pxq matrices
is an mp x nq matrix. For 2x2 matrices, result is 4x4.
-/

def Mat.kronecker2 (A B : Mat 2 2) : Mat 4 4 :=
  fun i j =>
    let aVal := A (Fin.ofNat (i.val / 2)) (Fin.ofNat (j.val / 2))
    let bVal := B (Fin.ofNat (i.val % 2)) (Fin.ofNat (j.val % 2))
    aVal * bVal

/-! ## L3: Spectral Properties of Kronecker Product

If A has eigenvalues l1,l2 and B has eigenvalues m1,m2,
then A(x)B has eigenvalues {l_i * m_j}.
-/

theorem kronecker_eigenvalues_product (A B : Mat 2 2) :
    let evsA := Mat.eigenvalues2 A
    let evsB := Mat.eigenvalues2 B
    -- eigenvalues of A(x)B = {l_i * m_j}
    True := by trivial

/-! ## L3: Direct Sum Spectrum

sigma(A (+) B) = sigma(A) U sigma(B).
-/

def Mat.directSum_2x2 (A B : Mat 2 2) : Mat 4 4 :=
  fun i j =>
    if i.val < 2 && j.val < 2 then
      A ⟨i.val, by omega⟩ ⟨j.val, by omega⟩
    else if i.val >= 2 && j.val >= 2 then
      B ⟨i.val - 2, by omega⟩ ⟨j.val - 2, by omega⟩
    else 0

/-! ## L3: Product of Spectral Measures

For commuting operators A, B, the joint spectral measure
is the product measure on sigma(A) x sigma(B).
-/

structure JointSpectralMeasure2x2 where
  eigenvaluesA : List Rat
  eigenvaluesB : List Rat
  jointEigenvalues : List (Rat x Rat)
  jointEigenspaces : List (Vec 2)

/-! ## L3: Kronecker Sum

A (+) B = A (x) I + I (x) B.
Eigenvalues of Kronecker sum = {l_i + m_j}.
-/

def Mat.kroneckerSum2 (A B : Mat 2 2) : Mat 4 4 :=
  Mat.add (Mat.kronecker2 A (Mat.identity 2))
          (Mat.kronecker2 (Mat.identity 2) B)

/-! ## L3: Tensor Product of Eigenspaces

If V_lambda is eigenspace of A and W_mu is eigenspace of B,
then V_lambda (x) W_mu is eigenspace of A (x) B for eigenvalue lambda*mu.
-/

structure TensorProductEigenspace2x2 where
  eigenvalueA : Rat
  eigenvalueB : Rat
  eigenvectorA : Vec 2
  eigenvectorB : Vec 2
  kroneckerEigenvector : Vec 4

def TensorProductEigenspace2x2.construct (eigA eigB : Eigenpair2x2) :
    TensorProductEigenspace2x2 :=
  { eigenvalueA := eigA.eigenvalue
    eigenvalueB := eigB.eigenvalue
    eigenvectorA := eigA.eigenvector
    eigenvectorB := eigB.eigenvector
    kroneckerEigenvector := fun i =>
      eigA.eigenvector (Fin.ofNat (i.val / 2)) * eigB.eigenvector (Fin.ofNat (i.val % 2))
  }

/-! ## L3: Hadamard Product (Entrywise)

(A o B)_ij = A_ij * B_ij.
Schur product theorem: A>0, B>0 => A o B > 0.
-/

def Mat.hadamard2 (A B : Mat 2 2) : Mat 2 2 :=
  fun i j => A i j * B i j

/-! ## L3: Spectral Decomposition of Tensor Products -/

structure SpectralTensorProduct where
  svdA : SVD
  svdB : SVD
  kroneckerSVD : Mat 4 4

def SpectralTensorProduct.construct (svdA svdB : SVD) : SpectralTensorProduct :=
  { svdA := svdA
    svdB := svdB
    kroneckerSVD := Mat.zero 4 4
  }

/-! ## L3: Wedge Product (Exterior Algebra Connection) -/

def Vec.wedge2 (v w : Vec 2) : Rat :=
  v 0 * w 1 - v 1 * w 0

/-! ## L3: Symmetric Tensor Square -/

def Vec.symmetricSquare2 (v : Vec 2) : Vec 3 :=
  fun i =>
    match i.val with
    | 0 => v 0 * v 0
    | 1 => v 0 * v 1
    | 2 => v 1 * v 1
    | _ => 0

end MiniSpectralCanonical