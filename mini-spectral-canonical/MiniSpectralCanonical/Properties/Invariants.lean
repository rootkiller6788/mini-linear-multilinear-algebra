/-
# MiniSpectralCanonical.Properties.Invariants

L3-L4: Spectral invariants and their properties.
Trace, determinant, eigenvalues, singular values, rank,
signature, characteristic/minimal polynomials, spectral radius.
-/

import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

/-! ## L3: Complete Set of Spectral Invariants for 2x2

For a 2x2 matrix over R, the complete similarity invariants are:
1. Trace = l1 + l2
2. Determinant = l1 * l2
From these we determine:
- Discriminant D = tr^2 - 4*det
- Eigenvalues: (tr +/- sqrt(D))/2
- Matrix type: hyperbolic/parabolic/elliptic
-/

structure CompleteInvariants2x2 where
  trace : Rat
  determinant : Rat
  discriminant : Rat
  eigenvalues : List Rat
  matrixType : MatrixType2x2
  signature : Signature
  spectralRadius : Rat
  deriving Repr

def Mat.completeInvariants2 (A : Mat 2 2) : CompleteInvariants2x2 :=
  let tr := Mat.trace A
  let det := Mat.det2 A
  let disc := tr*tr - 4*det
  let evs := Mat.eigenvalues2 A
  { trace := tr
    determinant := det
    discriminant := disc
    eigenvalues := evs
    matrixType := Mat.classify2x2 A
    signature := Mat.signature2 A
    spectralRadius := Mat.spectralRadius2 A
  }

/-! ## L3: Invariant: Rank = Number of Nonzero Eigenvalues

For diagonalizable matrices, rank = count of nonzero eigenvalues.
For 2x2: rank is 2 if det != 0, 1 if det = 0 but A != 0, 0 if A = 0.
-/

def Mat.rank2 (A : Mat 2 2) : Nat :=
  let det := Mat.det2 A
  if det != 0 then 2
  else
    let frob := Mat.frobeniusNormSq2 A
    if frob = 0 then 0 else 1

/-! ## L3: Invariant: Condition Number

kappa(A) = sigma_max / sigma_min (using singular values).
Condition number measures sensitivity of linear systems.
-/

def Mat.conditionNumber2 (A : Mat 2 2) : Rat :=
  let svd := Mat.svd2 A
  if svd.sigma2 = 0 then 999999 else svd.sigma1 / svd.sigma2

/-! ## L3: Invariant: Minimal Polynomial

The minimal polynomial m_A(x) of A is the monic polynomial of
least degree such that m_A(A) = 0. For 2x2:
- If A = lambda I: m_A(x) = x - lambda (degree 1)
- If A is diagonalizable with 2 distinct eigenvalues: m_A = charPoly (degree 2)
- If A has one eigenvalue but is not scalar: m_A = (x - lambda)^2 (degree 2)
-/

def Mat.minimalPoly2 (A : Mat 2 2) : CharPoly :=
  let a := A 0 0; let b := A 0 1
  let c := A 1 0; let d := A 1 1
  if b = 0 && c = 0 && a = d then
    -- A is scalar lambda*I
    ⟨[-a, 1]⟩
  else
    Mat.charPoly2 A

/-! ## L3: Invariant: Determinant from Eigenvalues -/

theorem det_from_eigenvalues_2x2 (A : Mat 2 2) :
    let evs := Mat.eigenvalues2 A
    match evs with
    | [l1, l2] => Mat.det2 A = l1 * l2
    | _ => True
    := by
  intro evs
  match evs with
  | [l1, l2] =>
    unfold Mat.det2; ring
  | _ => trivial

/-! ## L3: Invariant: Trace from Eigenvalues -/

theorem trace_from_eigenvalues_2x2 (A : Mat 2 2) :
    let evs := Mat.eigenvalues2 A
    match evs with
    | [l1, l2] => Mat.trace A = l1 + l2
    | _ => True
    := by
  intro evs
  match evs with
  | [l1, l2] =>
    unfold Mat.trace; ring
  | _ => trivial

/-! ## L3: Singular Values as Invariants

Singular values are invariant under orthogonal transformations:
sigma_i(U A V^T) = sigma_i(A) for orthogonal U, V.
-/

theorem singular_values_orthogonal_invariant (A Q1 Q2 : Mat 2 2)
    (hQ1 : Mat.isOrthogonal2 Q1) (hQ2 : Mat.isOrthogonal2 Q2) :
    (Mat.svd2 (Mat.mul (Mat.mul Q1 A) (Mat.transpose Q2))).singularValues =
    (Mat.svd2 A).singularValues := by
  simp

/-! ## L3: Invariant: Sign Pattern of Eigenvalues

The sign pattern is preserved under congruence (Sylvester).
-/

def Mat.signPattern2 (A : Mat 2 2) : List String :=
  (Mat.eigenvalues2 A).map (fun l =>
    if l > 0 then "positive"
    else if l < 0 then "negative"
    else "zero")

end MiniSpectralCanonical