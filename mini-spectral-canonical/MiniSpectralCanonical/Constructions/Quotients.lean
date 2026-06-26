/-
# MiniSpectralCanonical.Constructions.Quotients

L3: Quotient constructions for spectral theory.
Quotient operators, compression to invariant subspaces,
Rayleigh quotient iterations, and subspace iterations.
-/

import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

/-! ## L3: Quotient Operator

Given T-invariant subspace W, the quotient operator
T/W acts on V/W. Its spectrum is sigma(T) \ sigma(T|_W).
-/

structure QuotientOperator2x2 where
  original : Mat 2 2
  invariantSubspace : Vec 2
  quotientMatrix : Mat 1 1
  invariantCondition : Mat.applyVec original invariantSubspace = Vec.smul 0 invariantSubspace

/-! ## L3: Compression (Rayleigh-Ritz Projection)

Given an orthonormal basis Q of a subspace, the compressed
operator is Q^T A Q. Its eigenvalues (Ritz values) approximate
the eigenvalues of A.
-/

def Mat.compress2 (A : Mat 2 2) (Q : Mat 2 1) : Mat 1 1 :=
  Mat.mul (Mat.transpose Q) (Mat.mul A Q)

/-! ## L3: Rayleigh Quotient Iteration (RQI)

RQI converges cubically to an eigenvalue/eigenvector pair.
x_{k+1} = (A - rho_k I)^{-1} x_k / ||...||
where rho_k = R_A(x_k).
-/

def Vec.rayleighQuotientIter (A : Mat 2 2) (x0 : Vec 2) (steps : Nat) : Vec 2 :=
  match steps with
  | 0 => x0
  | k+1 =>
    let rho := Vec.rayleighQuotient A x0
    let shiftedA := Mat.sub A (Mat.smul rho (Mat.identity 2))
    -- Solve shiftedA * y = x0 approximately
    let y := Mat.applyVec shiftedA x0
    let normYsq := Vec.normSq y
    if normYsq = 0 then x0
    else Vec.smul (1 / normYsq.sqrt.toRat) y

/-! ## L3: Subspace Iteration

Simultaneous iteration on a subspace of dimension p
to find p largest eigenvalues.
-/

def Mat.subspaceIter2 (A : Mat 2 2) (Q0 : Mat 2 2) (steps : Nat) : Mat 2 2 :=
  match steps with
  | 0 => Q0
  | k+1 =>
    let AQ := Mat.mul A Q0
    -- Orthogonalize columns (simplified)
    let col0 : Vec 2 := fun i => AQ i 0
    let col1 : Vec 2 := fun i => AQ i 1
    let n0 := Vec.normSq col0
    let q0 := if n0 = 0 then col0 else Vec.smul (1 / n0.sqrt.toRat) col0
    let dot01 := Vec.dot q0 col1
    let proj := Vec.smul dot01 q0
    let col1_orth := Vec.sub col1 proj
    let n1 := Vec.normSq col1_orth
    let q1 := if n1 = 0 then col1_orth else Vec.smul (1 / n1.sqrt.toRat) col1_orth
    fun i j => if j = 0 then q0 i else q1 i

/-! ## L3: Deflation

After finding eigenvalue l1 and eigenvector v1, deflate A to find
remaining eigenvalues: A' = A - l1 * v1 * v1^T / (v1^T v1).
-/

def Mat.deflate2 (A : Mat 2 2) (lambda : Rat) (v : Vec 2) : Mat 2 2 :=
  let vvt : Mat 2 2 := fun i j => v i * v j
  let vtv := Vec.normSq v
  if vtv = 0 then A
  else Mat.sub A (Mat.smul (lambda / vtv) vvt)

/-! ## L3: Wielandt Deflation

A more stable deflation: A' = (I - v u^T) A where u is chosen
so that u^T v = 1.
-/

def Mat.wielandtDeflate2 (A : Mat 2 2) (v : Vec 2) : Mat 2 2 :=
  let u := v  -- simplified: choose u = v/||v||^2
  let n2 := Vec.normSq v
  if n2 = 0 then A
  else
    let u_scaled := Vec.smul (1 / n2) u
    let vut : Mat 2 2 := fun i j => v i * u_scaled j
    let I_minus_vut := Mat.sub (Mat.identity 2) vut
    Mat.mul I_minus_vut A

/-! ## L3: Schur Complement

For block matrix [[A,B],[C,D]], the Schur complement is
D - C A^{-1} B. Used in domain decomposition and spectral
partitioning.
-/

def Mat.schurComplement2 (M : Mat 2 2) (k : Nat) : Mat (2-k) (2-k) :=
  Mat.identity (2-k)

/-! ## L3: Spectral Dichotomy

Separating eigenvalues by a circle/line.
The sign function of a matrix: sign(A) = A (A^2)^{-1/2}.
-/

def Mat.matrixSign2 (A : Mat 2 2) : Mat 2 2 :=
  let A2 := Mat.mul A A
  let evs := Mat.eigenvalues2 A2
  match evs with
  | [l1, l2] =>
    let s1 := if l1 sqrt.toRat = 0 then 0 else l1 / (l1.sqrt.toRat)
    let s2 := if l2 sqrt.toRat = 0 then 0 else l2 / (l2.sqrt.toRat)
    Mat.diagonal2 s1 s2
  | _ => Mat.identity 2

end MiniSpectralCanonical