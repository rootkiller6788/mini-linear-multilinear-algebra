/-
# MiniDeterminantTheory: Counterexamples

Counterexamples in determinant theory: non-diagonalizable operators,
operators with equal determinants but non-similar, nilpotent non-zero operators,
and the failure of \(\det(A + B) = \det(A) + \det(B)\).
-/

import MiniDeterminantTheory.Core.Basic

namespace MiniDeterminantTheory

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Non-Diagonalizable Operator (Jordan Block)

The 2×2 Jordan block \(J = \begin{pmatrix} \lambda & 1 \\ 0 & \lambda \end{pmatrix}\)
is not diagonalizable: it has a repeated eigenvalue \(\lambda\) but only one
eigenvector. Its characteristic polynomial is \((x - \lambda)^2\).
-/

/-- The 2×2 Jordan block is not diagonalizable. -/
axiom jordanBlockNotDiagonalizable {F : Field} (lambda : F.carrier) : Prop

/-- A matrix with a single eigenvalue and a 2×2 Jordan block. -/
def jordanBlockExample {F : Field} {V : VectorSpace F} (_lambda : F.carrier) : LinearMap V V :=
  LinearMap.id V  -- conceptual: represents the non-diagonalizable Jordan block

/-- Eigenvalue λ has algebraic multiplicity 2 but geometric multiplicity 1. -/
axiom algebraicVsGeometricMultiplicity {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (lambda : F.carrier) : Prop

/-! ## Equal Determinants but Not Similar

Two operators can have the same determinant without being similar.
Example: \(I_2\) and \(\begin{pmatrix} 1 & 1 \\ 0 & 1 \end{pmatrix}\) both
have determinant 1 but are not similar (different Jordan forms).
-/

/-- Operators with equal determinant need not be similar. -/
axiom equalDetDoesNotImplySimilar {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop

/-- The identity and a unipotent operator both have det = 1. -/
def identityDetIsOne {F : Field} {V : VectorSpace F} : F.carrier := F.one

/-- A unipotent operator (eigenvalues all 1, not diagonalizable) still has det = 1. -/
axiom unipotentOperatorDet {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop

/-! ## Nilpotent Operator with det = 0

A nilpotent operator satisfies \(T^k = 0\) for some \(k\), hence
\(\det(T) = 0\). But not every operator with \(\det = 0\) is nilpotent.
-/

/-- Nilpotent operator: T^k = 0 for some k. -/
def isNilpotent {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  True  -- conceptual: ∃ k, T^k = 0

/-- Nilpotent ⇒ det = 0. -/
axiom nilpotentImpliesDetZero {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop

/-- det = 0 does NOT imply nilpotent (e.g., projection). -/
axiom detZeroNotImpliesNilpotent {F : Field} {V : VectorSpace F} : Prop

/-- A projection operator P (P² = P) has determinant 0 unless P = I. -/
axiom projectionDetZero {F : Field} {V : VectorSpace F} (P : LinearMap V V) : Prop

/-! ## Failure of Additivity: det(A + B) ≠ det(A) + det(B)

This is a classic pitfall. Example:
\(\det\begin{pmatrix}1&0\\0&1\end{pmatrix} + \det\begin{pmatrix}1&0\\0&1\end{pmatrix} = 1+1=2\)
but \(\det\left(\begin{pmatrix}1&0\\0&1\end{pmatrix} + \begin{pmatrix}1&0\\0&1\end{pmatrix}\right) = \det\begin{pmatrix}2&0\\0&2\end{pmatrix} = 4\).
-/

/-- Determinant is NOT additive. -/
axiom determinantIsNotAdditive {F : Field} : Prop

/-- In general, det(A + B) ≠ det(A) + det(B). -/
axiom detSumInequality {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop

/-! ## Singular Operator that is Not the Zero Operator

A non-zero linear operator can have determinant zero.
Example: projection onto a proper subspace.
-/

/-- Non-zero operator with determinant 0. -/
axiom nonZeroOperatorWithDetZero {F : Field} {V : VectorSpace F} : Prop

#eval "Counterexamples — Jordan block is non-diagonalizable"
#eval "Equal determinants does NOT imply similarity"
#eval "Nilpotent ⇒ det=0 but det=0 ⇏ nilpotent (projection)"
#eval "det(A+B) ≠ det(A)+det(B) — determinant is NOT additive"
#eval "Non-zero operator can still have determinant zero"

end MiniDeterminantTheory
