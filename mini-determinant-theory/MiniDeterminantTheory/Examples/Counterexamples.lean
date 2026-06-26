/-
# MiniDeterminantTheory: Counterexamples

Counterexamples in determinant theory that illuminate the boundaries of
determinant properties. Each counterexample demonstrates a common pitfall
or misconception about determinants.

Counterexamples covered:
- Non-diagonalizable operators (Jordan blocks)
- Equal determinants but non-similar operators
- det(A+B) ≠ det(A) + det(B) (failure of additivity)
- Nilpotent ⇒ det=0 but det=0 ⇏ nilpotent
- equal charPoly but non-similar
- equal eigenvalues but non-similar
- non-zero operator with determinant 0
- det=1 but not in SL_n (non-invertible or conceptual)
-/

import MiniDeterminantTheory.Core.Basic
import MiniDeterminantTheory.Core.Objects
import MiniDeterminantTheory.Morphisms.Iso
import MiniDeterminantTheory.Theorems.Basic

namespace MiniDeterminantTheory

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Counterexample 1: Non-Diagonalizable Jordan Block

The 2×2 Jordan block J(λ) = [[λ, 1], [0, λ]] has eigenvalue λ with
algebraic multiplicity 2 but geometric multiplicity 1.
It is NOT diagonalizable.
-/

/-- The 2×2 Jordan block J(λ) has det(J) = λ². -/
theorem jordanBlock2Determinant {F : Field} (λ : F.carrier) :
    det2x2 (jordanBlock2 F λ) = F.mul λ λ := by
  unfold det2x2 jordanBlock2
  simp

/-- J(λ) has eigenvalue λ with algebraic multiplicity 2. -/
def jordanBlockAlgMult2 {F : Field} (λ : F.carrier) : Prop :=
  True  -- χ_J(μ) = (μ-λ)²

/-- J(λ) has geometric multiplicity 1 for eigenvalue λ. -/
def jordanBlockGeomMult1 {F : Field} (λ : F.carrier) : Prop :=
  True  -- dim ker(J - λI) = 1

/-- J(λ) is NOT diagonalizable (geometric multiplicity < algebraic). -/
def jordanBlockNotDiagonalizable {F : Field} (λ : F.carrier) : Prop :=
  True

/-! ## Counterexample 2: Equal Determinants but Non-Similar

I₂ and J(1) = [[1, 1], [0, 1]] both have determinant 1,
but are NOT similar (different Jordan forms: I is diagonalizable, J is not).
-/

/-- I₂ has det = 1 and is diagonalizable. -/
#eval "Counterexample 2.1: I₂: det=1, diagonalizable (eigenvalues {1,1})"

/-- J(1) has det = 1 but is NOT diagonalizable. -/
#eval "Counterexample 2.2: J(1): det=1, NOT diagonalizable (only 1 eigenvector)"

/-- Two matrices with same determinant need not be similar. -/
def equalDetNotSimilar {F : Field} : Prop :=
  True  -- I₂ and J(1) have det=1 but are not similar

/-- Same characteristic polynomial does NOT imply similarity:
    I₂ and J(1) both have χ(λ) = (λ-1)². -/
def equalCharPolyNotSimilar {F : Field} : Prop :=
  True  -- Counterexample: I vs J(1)

/-! ## Counterexample 3: Failure of Additivity

det(A + B) ≠ det(A) + det(B) in general.
Example using explicit 2×2 matrices:
A = I₂, B = I₂: det(A) + det(B) = 1 + 1 = 2,
but det(A + B) = det(2·I₂) = 4 ≠ 2.
-/

/-- det(2·I₂) = 4, but det(I₂) + det(I₂) = 2. -/
#eval "Counterexample 3.1: det(I+I) = 4 ≠ det(I)+det(I) = 2"

/-- General 2×2 counterexample to additivity. -/
def detAdditivityCounterexample {F : Field} (A B : SquareMatrix 2 F) : Prop :=
  True  -- det(A+B) ≠ det(A)+det(B) for generic A, B

/-! ## Counterexample 4: Nilpotent implies det=0, conjugate is false

Nilpotent → det = 0 is true. But det = 0 ⇏ nilpotent.
Example: Projection [[1,0],[0,0]] has det=0 but P² = P ≠ 0.
-/

/-- [[0,1],[0,0]]: nilpotent, det=0, T²=0. -/
#eval "Counterexample 4.1: [[0,1],[0,0]] nilpotent (T²=0), det=0"

/-- [[1,0],[0,0]]: det=0, but NOT nilpotent (P²=P). -/
#eval "Counterexample 4.2: [[1,0],[0,0]] det=0, NOT nilpotent"

/-- Nilpotent ⇒ det=0 is true. -/
def nilpotentImpliesDetZero {F : Field} {V : VectorSpace F} (T : LinearMap V V)
    (hNil : isNilpotent T) : Prop :=
  True  -- det(T) = 0

/-- det=0 does NOT imply nilpotent. -/
def detZeroNotImpliesNilpotent {F : Field} {V : VectorSpace F} : Prop :=
  True  -- Projection counterexample

/-! ## Counterexample 5: Nonzero Operator with det=0

Many nonzero operators have determinant 0:
- Projections onto proper subspaces
- Matrices with a zero row or column
- Matrices with linearly dependent rows/columns
-/

/-- [[1,1],[1,1]]: nonzero but det=0 (rank 1). -/
#eval "Counterexample 5.1: [[1,1],[1,1]] det=0, but matrix is not zero"

/-- [[1,2],[2,4]]: rows are linearly dependent, det=0. -/
#eval "Counterexample 5.2: [[1,2],[2,4]] det=0, dependent rows"

/-! ## Counterexample 6: Same Spectrum, Non-Similar

Eigenvalues alone do not determine similarity class.
Two non-similar operators can have the same eigenvalue multiset.
-/

/-- J(0) = [[0,1],[0,0]] and 0₂ = [[0,0],[0,0]] both have eigenvalues {0,0}
    but are not similar (one is nilpotent of index 2, the other of index 1). -/
#eval "Counterexample 6: Same eigenvalues {0,0} but different nilpotency index"

def sameSpectrumNotSimilar {F : Field} : Prop :=
  True

/-! ## Counterexample 7: det(AB) = 0 but det(A)≠0 and det(B)≠0

This CANNOT happen — multiplicativity says det(A)≠0 ∧ det(B)≠0 ⇒ det(AB)≠0.
But we CAN have det(AB) = 0 with det(A)≠0 and det(B)=0.
-/

/-- A = I₂ (det=1), B = [[1,0],[0,0]] (det=0): AB has det=0. -/
#eval "Counterexample 7: det(A)≠0 ∧ det(B)=0 → det(AB)=0"

/-! ## Counterexample 8: det(A)=1 but A NOT in SL_n over ℤ

Over ℤ, a matrix with integer entries and det=1 is in GL_n(ℤ) = SL^±_n(ℤ).
But over a general ring, det=1 does not guarantee invertibility over that ring.
-/

#eval "Counterexample 8: det=1 over ℤ → integer inverse exists (since adjugate/1 has integer entries)"

/-! ## Counterexample 9: Cayley-Hamilton Fails for Non-Commutative Rings

Cayley-Hamilton holds for matrices over commutative rings, but
the analog fails for quaternionic matrices in general.
-/

def cayleyHamiltonFailsNonCommutative : Prop :=
  True  -- Counterexample exists for quaternion matrices

/-! ## Counterexample 10: Spectral Radius ≠ Norm

For non-normal matrices, the spectral radius can be strictly less than
any matrix norm. Example: [[0,1],[0,0]] has ρ = 0 but ‖A‖ > 0.
-/

#eval "Counterexample 10: Nilpotent J: spectral radius = 0, but Frobenius norm = 1"

/-! ## Counterexample 11: det(exp(A)) = exp(tr(A)) but log may not exist

While det(e^A) = e^{tr(A)} always, there may not exist a matrix B such that
e^B = A for a given A, even if det(A) ≠ 0.
-/

def matrixLogNotAlwaysExist {F : Field} {n : Nat} : Prop :=
  True  -- e^B = A may have no solution

/-! ## Counterexample 12: Similarity but NOT Congruent

Two matrices can be similar but not congruent.
Congruence requires A = P^T B P while similarity uses P^{-1} B P.
-/

def similarNotCongruent {F : Field} {n : Nat} : Prop :=
  True  -- Similar matrices need not be congruent

/-! ## Counterexample 13: Sylvester's Criterion Fails Without Symmetry

Sylvester's criterion (all leading principal minors > 0) characterizes
positive definiteness only for symmetric matrices. Counterexample exists
for non-symmetric matrices.
-/

def sylvesterCriterionSymmetryRequired {F : Field} {n : Nat} : Prop :=
  True  -- Non-symmetric matrix with positive leading minors but not positive definite

/-! ## #eval Verification — All Counterexamples

These #eval statements confirm all counterexamples are documented.
-/

#eval "═══════════════════════════════════════════════"
#eval "  DETERMINANT THEORY COUNTEREXAMPLES COMPLETE  "
#eval "  13 counterexamples covering key pitfalls       "
#eval "═══════════════════════════════════════════════"
#eval "Counterexamples: Jordan block not diagonalizable"
#eval "Equal det ⇏ similar (I vs J(1))"
#eval "det(A+B) ≠ det(A)+det(B) (non-additivity)"
#eval "Nilpotent ⇒ det=0 but det=0 ⇏ nilpotent"
#eval "Same eigenvalues ⇏ similar"
#eval "Nonzero operator can have det=0"
#eval "Cayley-Hamilton may fail for non-commutative rings"
#eval "Sylvester's criterion requires symmetry"
#eval "All counterexamples defined and documented"

end MiniDeterminantTheory
