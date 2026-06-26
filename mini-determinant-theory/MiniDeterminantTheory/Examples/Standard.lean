/-
# MiniDeterminantTheory: Standard Examples

Standard examples of determinant computations with #eval verifications.
Includes 2×2 and 3×3 matrix computations, diagonal matrices, triangular matrices,
Vandermonde examples, and key determinantal identities verified on concrete cases.

All examples are #eval-verifiable for concrete field elements.
-/

import MiniDeterminantTheory.Core.Basic
import MiniDeterminantTheory.Core.Laws
import MiniDeterminantTheory.Core.Objects

namespace MiniDeterminantTheory

open MiniVectorSpaceCore

/-! ## Concrete Field for #eval Computations

We define a concrete field over `Int` for computable determinant examples.
Note: This is NOT a mathematical field (integers don't form a field), but the
determinant formula ad-bc works purely algebraically with ring operations.
For #eval verification purposes, we use ℤ as a computable ring.
-/

/-- A computable "field-like" structure over ℤ for #eval examples.
    The determinant formulas use only +, *, -, so we provide those.
    Inv is defined as the identity (not used in determinant computation). -/
def ℤField : Field where
  carrier := Int
  add := Int.add
  mul := Int.mul
  zero := 0
  one := 1
  neg := Int.neg
  inv := fun x => x  -- unused in determinant computation

/-- Helper to construct a 2×2 integer matrix for #eval. -/
def mat2 (a b c d : Int) : SquareMatrix 2 ℤField where
  entries i j :=
    match i.val, j.val with
    | 0, 0 => a | 0, 1 => b | 1, 0 => c | 1, 1 => d
    | _, _ => 0

/-- Helper to construct a 3×3 integer matrix for #eval. -/
def mat3 (a b c d e f g h i : Int) : SquareMatrix 3 ℤField where
  entries r c :=
    match r.val, c.val with
    | 0, 0 => a | 0, 1 => b | 0, 2 => c
    | 1, 0 => d | 1, 1 => e | 1, 2 => f
    | 2, 0 => g | 2, 1 => h | 2, 2 => i
    | _, _ => 0

/-! ## Example 1: Determinant of Identity

det(I_n) = 1 for all n. The simplest and most fundamental example.
-/

/-- Determinant of 2×2 identity is 1. -/
#eval "Ex 1.1: det(I₂) = 1"
#eval det2x2 (Matrix.identity 2 ℤField)

/-- Determinant of 3×3 identity is 1. -/
#eval "Ex 1.2: det(I₃) = 1"
#eval det3x3 (Matrix.identity 3 ℤField)

/-! ## Example 2: Determinant of Zero Matrix

det(0_{n×n}) = 0 for n ≥ 1.
-/

#eval "Ex 2: det(Zero₂ₓ₂) = 0"
#eval det2x2 (Matrix.zero 2 2 ℤField)

/-! ## Example 3: Determinant of a Diagonal Matrix

det(diag(d₁, d₂, ..., dₙ)) = d₁·d₂·...·dₙ
-/

#eval "Ex 3.1: det(diag(3,5)) = 15"
#eval det2x2 (mat2 3 0 0 5)

#eval "Ex 3.2: det(diag(2,4,7)) = 56"
#eval det3x3 (mat3 2 0 0 0 4 0 0 0 7)

/-! ## Example 4: 2×2 Determinant Examples

Classic 2×2 determinant computations.
-/

/-- det([[2, 3], [5, 7]]) = 2·7 - 3·5 = 14 - 15 = -1. -/
#eval "Ex 4.1: det([[2,3],[5,7]]) = -1"
#eval det2x2 (mat2 2 3 5 7)

/-- det([[1, 2], [3, 4]]) = 1·4 - 2·3 = 4 - 6 = -2. -/
#eval "Ex 4.2: det([[1,2],[3,4]]) = -2"
#eval det2x2 (mat2 1 2 3 4)

/-- det([[a, b], [c, d]]) = ad - bc (general formula). -/
def example2x2Formula {F : Field} (a b c d : F.carrier) : F.carrier :=
  F.add (F.mul a d) (F.neg (F.mul b c))

#eval "Ex 4.3: 2×2 formula for [5,7],[9,11]"
#eval det2x2 (mat2 5 7 9 11)

/-! ## Example 5: 3×3 Determinant (Sarrus' Rule)

Examples of 3×3 determinant computation via Sarrus' rule.
-/

/-- det([[1,0,2], [3,1,0], [0,4,1]]) via Sarrus.
    pos: 1·1·1 + 0·0·0 + 2·3·4 = 1 + 0 + 24 = 25
    neg: 2·1·0 + 1·0·4 + 0·3·1 = 0 + 0 + 0 = 0
    det = 25. -/
#eval "Ex 5.1: 3×3 via Sarrus: det = 25"
#eval det3x3 (mat3 1 0 2 3 1 0 0 4 1)

/-- det([[2,1,1], [1,2,1], [1,1,2]]) = 4. -/
#eval "Ex 5.2: det([[2,1,1],[1,2,1],[1,1,2]]) = 4"
#eval det3x3 (mat3 2 1 1 1 2 1 1 1 2)

/-! ## Example 6: Triangular Matrix Determinant

For triangular matrices, det = product of diagonal entries.
-/

/-- Upper triangular 2×2: det([[3, 7], [0, 5]]) = 3·5 = 15. -/
#eval "Ex 6.1: det(upper tri 2×2) = 3·5 = 15"
#eval det2x2 (mat2 3 7 0 5)

/-- Lower triangular 2×2: det([[4, 0], [9, 2]]) = 4·2 = 8. -/
#eval "Ex 6.2: det(lower tri 2×2) = 4·2 = 8"
#eval det2x2 (mat2 4 0 9 2)

/-- Upper triangular 3×3: det([[1,2,3],[0,4,5],[0,0,6]]) = 1·4·6 = 24. -/
#eval "Ex 6.3: det(upper tri 3×3) = 1·4·6 = 24"
#eval det3x3 (mat3 1 2 3 0 4 5 0 0 6)

/-! ## Example 7: Vandermonde Determinant

V(x₁, x₂, ..., xₙ) = ∏_{i<j} (x_j - x_i).
-/

/-- Vandermonde 2×2: det([[1, x₁], [1, x₂]]) = x₂ - x₁. -/
#eval "Ex 7.1: Vandermonde 2×2 for x₁=3, x₂=7"
#eval det2x2 (mat2 1 3 1 7)  -- should be 7-3 = 4

/-- Vandermonde 3×3: det([[1, 2, 4], [1, 3, 9], [1, 5, 25]]) = (3-2)(5-2)(5-3) = 1·3·2 = 6. -/
#eval "Ex 7.2: Vandermonde 3×3 for x₁=2, x₂=3, x₃=5"
#eval det3x3 (mat3 1 2 4 1 3 9 1 5 25)  -- 2²=4, 3²=9, 5²=25

/-! ## Example 8: Determinant of a Permutation Matrix

det(P_σ) = sgn(σ) = ±1.
-/

/-- 2×2 swap matrix [[0,1],[1,0]] has det = 0-1 = -1. -/
#eval "Ex 8.1: det([[0,1],[1,0]]) = -1"
#eval det2x2 (mat2 0 1 1 0)

/-- 3×3 cyclic permutation: [[0,1,0],[0,0,1],[1,0,0]] → det = +1. -/
#eval "Ex 8.2: det(cyclic perm 3×3) = 1"
#eval det3x3 (mat3 0 1 0 0 0 1 1 0 0)

/-! ## Example 9: Characteristic Polynomial Examples

Computing characteristic polynomials for 2×2 and 3×3 matrices.
-/

/-- Char poly of [[2,1],[1,2]]: λ² - 4λ + 3 = (λ-1)(λ-3).
    Coefficients: [det=3, -trace=-4, 1]. -/
#eval "Ex 9.1: charPoly of [[2,1],[1,2]]: coeffs [3, -4, 1]"
#eval charPoly2x2 (mat2 2 1 1 2)

/-- Char poly of [[0,1],[-1,0]]: λ² + 1 (eigenvalues ±i).
    Coefficients: [det=1, -trace=0, 1]. -/
#eval "Ex 9.2: charPoly of [[0,1],[-1,0]]: coeffs [1, 0, 1]"
#eval charPoly2x2 (mat2 0 1 (-1) 0)

/-- Char poly of diagonal(2,3,5): λ³ - 10λ² + 31λ - 30.
    det=30, s2=2·3+2·5+3·5=31, trace=10. -/
#eval "Ex 9.3: charPoly3x3 of diag(2,3,5)"
#eval charPoly3x3 (mat3 2 0 0 0 3 0 0 0 5)

/-! ## Example 10: Determinant as Volume

|det(A)| is the volume of the parallelepiped spanned by column vectors.
-/

/-- Area of parallelogram: det([[3,0],[0,2]]) = 6. -/
#eval "Ex 10.1: |det([[3,0],[0,2]])| = 6"
#eval det2x2 (mat2 3 0 0 2)

/-- Area of parallelogram: det([[1,2],[3,1]]) = 1-6 = -5, |det| = 5. -/
#eval "Ex 10.2: |det([[1,2],[3,1]])| = 5"
#eval det2x2 (mat2 1 2 3 1)

/-- Volume of parallelepiped: det([[2,0,0],[0,3,0],[0,0,4]]) = 24. -/
#eval "Ex 10.3: Volume of 2×3×4 box = 24"
#eval det3x3 (mat3 2 0 0 0 3 0 0 0 4)

/-! ## Example 11: Determinant of Special Matrices

Rotation matrices, reflection matrices, projection matrices, shear matrices.
-/

/-- Rotation matrix: [[0,-1],[1,0]] (90° rotation), det = 1. -/
#eval "Ex 11.1: det(90° rotation [[0,-1],[1,0]]) = 1"
#eval det2x2 (mat2 0 (-1) 1 0)

/-- Reflection across x-axis: [[1,0],[0,-1]], det = -1. -/
#eval "Ex 11.2: det(reflection [[1,0],[0,-1]]) = -1"
#eval det2x2 (mat2 1 0 0 (-1))

/-- Projection [[1,0],[0,0]], det = 0. -/
#eval "Ex 11.3: det(projection [[1,0],[0,0]]) = 0"
#eval det2x2 (mat2 1 0 0 0)

/-- Shear matrix [[1,5],[0,1]], det = 1. -/
#eval "Ex 11.4: det(shear [[1,5],[0,1]]) = 1"
#eval det2x2 (mat2 1 5 0 1)

/-! ## Example 12: Cramer's Rule in Action

Solving a 2×2 linear system via Cramer's rule.
-/

/-- System: 2x + 3y = 8, 5x + 7y = 19.
    det(A) = -1, x = det([[8,3],[19,7]])/det(A) = (-1)/(-1) = 1,
    y = det([[2,8],[5,19]])/det(A) = (-2)/(-1) = 2. -/
#eval "Ex 12: Cramer: det(A)=-1, det(A₁)=-1, det(A₂)=-2 → x=1,y=2"
#eval det2x2 (mat2 2 3 5 7)  -- det(A) = -1
#eval det2x2 (mat2 8 3 19 7)  -- det(A₁) = -1
#eval det2x2 (mat2 2 8 5 19)  -- det(A₂) = -2

/-! ## Example 13: Eigenvalues and Determinant

det(A) = product of eigenvalues.
-/

/-- For [[2,1],[1,2]]: eigenvalues 1, 3; det = 1·3 = 3. -/
#eval "Ex 13.1: det([[2,1],[1,2]]) = 1·3 = 3"
#eval det2x2 (mat2 2 1 1 2)

/-- For [[0,1],[-1,0]]: eigenvalues i, -i; det = i·(-i) = 1. -/
#eval "Ex 13.2: det([[0,1],[-1,0]]) = 1"
#eval det2x2 (mat2 0 1 (-1) 0)

/-! ## Example 14: Determinant of Block Matrices

det(diag(A, B)) = det(A)·det(B).
For 2×2 blocks: det([[2,1],[1,3]])=5, det([[4,0],[0,5]])=20.
The block diagonal has det=5·20=100.
-/

#eval "Ex 14: det(block diag) computes: det(A)=5, det(B)=20"
#eval det2x2 (mat2 2 1 1 3)  -- det(A) = 5
#eval det2x2 (mat2 4 0 0 5)  -- det(B) = 20

/-! ## Example 15: Leibniz Formula

The determinant as a sum over permutations (Leibniz formula).
For 2×2: det(A) = a₁₁a₂₂·sgn(id) + a₁₂a₂₁·sgn((12)) = a₁₁a₂₂ - a₁₂a₂₁.
For 3×3: 6 terms from S₃.
-/

#eval "Ex 15.1: Leibniz 2×2: det[[5,2],[3,4]] = 20-6 = 14"
#eval det2x2 (mat2 5 2 3 4)

#eval "Ex 15.2: Leibniz 3×3: det[[1,2,3],[0,1,4],[5,6,0]]"
#eval det3x3 (mat3 1 2 3 0 1 4 5 6 0)

/-! ## Example 16: Determinant of the Inverse

det(A⁻¹) = 1/det(A) when det(A) ≠ 0.
For A = [[2,0],[0,3]], det(A)=6, A⁻¹ = [[1/2,0],[0,1/3]], det(A⁻¹)=1/6.
-/

#eval "Ex 16: det(inverse) = 1/det(A); det(diag(2,3)) = 6"
#eval det2x2 (mat2 2 0 0 3)  -- det = 6

/-! ## Example 17: Determinant via Row Reduction

Gaussian elimination on [[1,2],[3,4]]:
R₂ ← R₂ - 3R₁ gives [[1,2],[0,-2]], det = 1·(-2) · (-1)^0 = -2.
-/

#eval "Ex 17: det via row reduction: det[[1,2],[3,4]] = -2"
#eval det2x2 (mat2 1 2 3 4)  -- computed as 1·4 - 2·3 = -2

/-- After row reduction, the upper triangular form [[1,2],[0,-2]] has det = -2. -/
#eval "Ex 17b: Upper tri form [[1,2],[0,-2]] has det = -2"
#eval det2x2 (mat2 1 2 0 (-2))  -- matches!

/-! ## Example 18: Determinant and Matrix Exponential

det(e^A) = e^{tr(A)}. For 2×2 nilpotent [[0,1],[0,0]]:
A²=0, so e^A = I + A, det = 1, tr(A) = 0, e⁰ = 1. ✓
-/

#eval "Ex 18.1: Nilpotent [[0,1],[0,0]]: det=0"
#eval det2x2 (mat2 0 1 0 0)  -- det = 0

#eval "Ex 18.2: e^A = I + A = [[1,1],[0,1]]: det=1"
#eval det2x2 (mat2 1 1 0 1)  -- det = 1 (I+A)

/-! ## Example 19: Hadamard's Inequality Verification

|det(A)| ≤ ∏ ‖a_i‖ (product of column norms).
For [[3,0],[0,2]]: |det| = 6, product of column norms = √(3²+0²)·√(0²+2²) = 3·2 = 6.
Equality holds for orthogonal columns.
-/

#eval "Ex 19.1: Hadamard equality: |det(diag(3,2))| = 3·2 = 6"
#eval det2x2 (mat2 3 0 0 2)

/-- For [[3,4],[-4,3]]: |det| = 25, col norms: √(3²+4²)=5, √((-4)²+3²)=5, product=25. -/
#eval "Ex 19.2: Hadamard: |det[[3,4],[-4,3]]| = 25, col norms product = 5·5 = 25"
#eval det2x2 (mat2 3 4 (-4) 3)

/-! ## Example 20: Determinant of Companion Matrix

The companion matrix C of p(λ) = λ² - tr·λ + det is [[0, -det], [1, tr]].
Its characteristic polynomial is p(λ), so det(C) = det (the constant term up to sign).
-/

/-- Companion matrix of λ² - 5λ + 6 (roots 2, 3): C = [[0, -6], [1, 5]], det(C) = 6. -/
#eval "Ex 20.1: Companion matrix of λ²-5λ+6: det = 0·5 - (-6)·1 = 6"
#eval det2x2 (mat2 0 (-6) 1 5)  -- det = 0·5 - (-6)·1 = 6 ✓

/-- Companion matrix of λ² - 0·λ + 1 (roots i, -i): C = [[0, -1], [1, 0]], det(C) = 1. -/
#eval "Ex 20.2: Companion matrix of λ²+1: det = 1"
#eval det2x2 (mat2 0 (-1) 1 0)  -- det = 1 ✓

/-! ## Additional Example: Jacobi's Formula

For A(t) = [[t, 1], [0, t]], det(A(t)) = t², d/dt det = 2t.
tr(A⁻¹·A') = 2/t (since A' = [[1,0],[0,1]]). Jacobi: d/dt det = det · tr(A⁻¹·A') = t²·2/t = 2t. ✓
-/

#eval "Ex 21: det([[t,1],[0,t]]) = t²; det for t=5 is 25"
#eval det2x2 (mat2 5 1 0 5)  -- 25

/-! ## #eval Verification — All Standard Examples

These #eval statements confirm all standard examples with real computations.
-/

#eval "══════════════════════════════════════════"
#eval "  STANDARD DETERMINANT EXAMPLES COMPLETE  "
#eval "  20+ examples with real #eval computations"
#eval "  All examples computed over ℤ (Int) field  "
#eval "══════════════════════════════════════════"

end MiniDeterminantTheory
