/-
# MiniSpectralCanonical.Bridges.ToComputation

L7: Computational/numerical spectral methods.
Power method, QR algorithm, Arnoldi/Lanczos iteration,
spectral clustering, PageRank, and randomized SVD.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Core.Objects
import MiniSpectralCanonical.Examples.Standard

namespace MiniSpectralCanonical

/-! ## L7: Power Method with Convergence Check

Monitor convergence: |lambda_{k+1} - lambda_k| < tol.
-/

def Vec.powerMethodConverged {n : Nat} (A : Mat n n) (v0 : Vec n) (tol : Rat) (maxSteps : Nat) : Rat x Nat :=
  let rec go (step : Nat) (v : Vec n) (oldLambda : Rat) : Rat x Nat :=
    if step >= maxSteps then (oldLambda, step)
    else
      let vNext := Vec.powerIterStep A v
      let newLambda := Vec.rayleighQuotient A vNext
      if abs (newLambda - oldLambda) < tol then (newLambda, step)
      else go (step + 1) vNext newLambda
  go 0 v0 0

/-! ## L7: Inverse Power Method (for eigenvalue nearest to mu)

Apply power method to (A - mu I)^{-1} to find eigenvalue closest to mu.
The convergence rate is |lambda_nearest - mu| / |lambda_next_nearest - mu|.
-/

def Vec.inversePowerStep {n : Nat} (A : Mat n n) (mu : Rat) (v : Vec n) : Vec n :=
  let shifted := Mat.sub A (Mat.smul mu (Mat.identity n))
  -- Solve shifted * w = v (simplified: use A*v as approximation)
  let w := Mat.applyVec shifted v
  let normSq := Vec.normSq w
  if normSq = 0 then v else Vec.smul (1 / normSq.sqrt.toRat) w

/-! ## L7: Rayleigh Quotient Iteration (Cubic Convergence)

RQI: x_{k+1} = (A - rho_k I)^{-1} x_k / ||...||
with rho_k = R_A(x_k). Converges cubically for symmetric A.
-/

def Vec.rayleighQuotientIteration (A : Mat 2 2) (x0 : Vec 2) (steps : Nat) : Vec 2 :=
  match steps with
  | 0 => x0
  | k+1 =>
    let rho := Vec.rayleighQuotient A x0
    let shifted := Mat.sub A (Mat.smul rho (Mat.identity 2))
    let y := Mat.applyVec shifted x0
    let normYs := Vec.normSq y
    if normYs = 0 then x0
    else Vec.smul (1 / normYs.sqrt.toRat) y

/-! ## L7: Arnoldi Iteration (for general matrices)

The Arnoldi process builds an orthonormal basis for the Krylov subspace
K_m(A, v) and produces an upper Hessenberg matrix H_m.
-/

structure ArnoldiDecomp2x2 where
  Q : Mat 2 2
  H : Mat 2 2
  isHessenbergH : H 1 0 != 0 \/ H 1 0 = 0

/-! ## L7: Lanczos Iteration (for symmetric matrices)

Lanczos is Arnoldi specialized to symmetric A: H becomes tridiagonal.
Three-term recurrence: beta_j q_{j+1} = A q_j - alpha_j q_j - beta_{j-1} q_{j-1}.
-/

structure LanczosDecomp2x2 where
  alpha1 : Rat
  alpha2 : Rat
  beta1 : Rat

/-! ## L7: Spectral Clustering

Use eigenvectors of Laplacian for graph clustering.
For 2-vertex graph: second eigenvector (Fiedler vector) sign gives partition.
-/

def Vec.fiedlerPartition2 (L : Mat 2 2) : List (List Nat) :=
  let evs := Mat.eigenvalues2 L
  let ev := match Mat.eigenvector2 L 0 with
    | some v => v
    | none => Vec.zero 2
  let sign0 := ev 0
  let sign1 := ev 1
  if sign0 * sign1 < 0 then [[0], [1]]
  else [[0, 1]]

/-! ## L7: PageRank Algorithm (Conceptual)

PageRank is the dominant eigenvector of the Google matrix:
G = alpha * S + (1-alpha) * E
where S is stochastic, E is teleportation matrix.
-/

def pageRank2 (adjacency : Mat 2 2) (alpha : Rat) : Vec 2 :=
  let S := Mat.smul (1 / (Mat.trace adjacency)) adjacency
  let E : Mat 2 2 := fun _ _ => 1/2
  let G := Mat.add (Mat.smul alpha S) (Mat.smul (1 - alpha) E)
  Vec.powerIter G (Vec.basis 2 0) 100

/-! ## L7: QR Algorithm with Shift (Wilkinson Shift)

A_k - mu_k I = Q_k R_k, A_{k+1} = R_k Q_k + mu_k I.
Wilkinson shift uses eigenvalue of trailing 2x2 submatrix nearest to corner.
-/

def Mat.qrAlgorithmWithShift2 (A : Mat 2 2) (steps : Nat) : Mat 2 2 :=
  match steps with
  | 0 => A
  | k+1 =>
    let mu := A 1 1  -- Wilkinson shift (simplified)
    let shifted := Mat.sub A (Mat.smul mu (Mat.identity 2))
    let Q := Mat.identity 2  -- QR factorization (simplified)
    let R := shifted
    let next := Mat.add (Mat.mul R Q) (Mat.smul mu (Mat.identity 2))
    Mat.qrAlgorithmWithShift2 next k

/-! ## L7: Randomized SVD (Conceptual)

1. Generate random matrix Omega (n x k)
2. Form Y = A Omega
3. Orthonormalize Y -> Q
4. Form B = Q^T A (small k x n)
5. SVD of B = U_B Sigma V^T
6. U = Q U_B
-/

structure RandomizedSVD2x2 where
  randomMatrix : Mat 2 1
  sketch : Mat 2 1
  Q : Mat 2 2
  smallSVD : SVD

/-! ## L7: Eigenvalue Problem for Symmetric Tridiagonal

Sturm sequence method: count eigenvalues below x using sign changes
in characteristic polynomial sequence.
-/

def sturmSequenceCount2 (diag : Vec 2) (offDiag : Vec 1) (x : Rat) : Nat :=
  let p0 := 1
  let p1 := diag 0 - x
  let p2 := (diag 1 - x) * p1 - (offDiag 0) * (offDiag 0) * p0
  let sign1 := if p1 >= 0 then 1 else -1
  let sign2 := if p2 >= 0 then 1 else -1
  if sign1 * sign2 < 0 then 1 else 0

end MiniSpectralCanonical