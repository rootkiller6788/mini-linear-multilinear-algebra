/-
# MiniDualQuotient: Bridges — ToComputation (L7)

Computational aspects of dual and quotient spaces:
matrix transpose, solving linear systems via quotients,
SVD, least squares, and numerical linear algebra.

## Knowledge Coverage
- L7: Application to numerical linear algebra and data science
- Matrix transpose as dual map, least squares, SVD
-/

import MiniDualQuotient.Core.Basic

namespace MiniDualQuotient

/-! ## Matrix Transpose as Dual Map

The transpose of a matrix A ∈ F^{m×n} represents the dual map
A*: (F^m)* → (F^n)* between dual spaces.
-/

/-- For A: F^n → F^m, the matrix of A*: (F^m)* → (F^n)* is A^T.
    This is because (A^T)(A^T) = A^T (wait, A*(f)(v) = f(Av),
    which in coordinates is multiplication by A^T). -/
def matrix_transpose_as_dual : String :=
  "[A*] = [A]^T — the transpose represents the dual map"

/-- The four fundamental subspaces of a matrix A:
    - ker(A) ⊆ F^n (nullspace)
    - im(A) ⊆ F^m (column space)
    - ker(A^T) ⊆ F^m (left nullspace) = (im A)°
    - im(A^T) ⊆ F^n (row space) = (ker A)° -/
def four_fundamental_subspaces : String :=
  "ker(A), im(A), ker(A^T), im(A^T) — four fundamental subspaces"

/-- The Fundamental Theorem of Linear Algebra:
    ker(A) ⊕ im(A^T) = F^n (orthogonal direct sum)
    ker(A^T) ⊕ im(A) = F^m
    This is the decomposition of domain and codomain. -/
def fundamental_theorem_linear_algebra : String :=
  "Fⁿ = ker(A) ⊕ im(A^T), Fᵐ = ker(A^T) ⊕ im(A) (orthogonal decomposition)"

/-! ## Solving Linear Systems via Quotients

The solution of Ax = b can be interpreted in terms of quotient spaces.
-/

/-- The solution set of Ax = b is a coset of ker(A):
    x₀ + ker(A) where Ax₀ = b is any particular solution.
    This is the quotient space interpretation. -/
def solution_as_coset : String :=
  "Sol(Ax=b) = x₀ + ker(A) — coset of the nullspace"

/-- The quotient F^n / ker(A) ≅ im(A) (First Iso Theorem) means
    the space of solutions modulo the homogeneous solutions is
    isomorphic to the reachable outputs. -/
def quotient_solution_interpretation : String :=
  "Fⁿ/ker(A) ≅ im(A): solutions modulo homogeneous part ≅ reachable RHS"

/-- Least squares: For Ax ≈ b, the normal equations A^T A x = A^T b
    project b onto im(A). The residual b - Ax ∈ ker(A^T) = (im A)°. -/
def least_squares_duality : String :=
  "Least squares: b - Ax ∈ (im A)° = ker(A^T); residual ⊥ column space"

/-! ## Singular Value Decomposition (SVD)

SVD diagonalizes the action of A using orthonormal bases of the
four fundamental subspaces.
-/

/-- SVD: A = U Σ V^T where:
    - U = [u₁...u_m] is an ON basis of F^m (left singular vectors)
    - V = [v₁...v_n] is an ON basis of F^n (right singular vectors)
    - Σ = diag(σ₁,...,σ_r) are singular values
    The v_i span im(A^T) and u_i span im(A). -/
def svd_decomposition : String :=
  "A = UΣV^T: V's cols = ON basis of im(A^T) ⊕ ker(A); U's cols = ON basis of im(A) ⊕ ker(A^T)"

/-- The pseudo-inverse A^+ = V Σ^+ U^T solves the least-squares
    problem and maps via the subspace decomposition.
    A^+ restricted to im(A) is the inverse of A: im(A^T) → im(A). -/
def pseudoinverse : String :=
  "A^+ = V Σ^+ U^T: A^+|_{im(A)} = (A|_{im(A^T)})^{-1} (pseudo-inverse)"

/-! ## Numerical Rank and Nullity

Computing rank and nullity via numerical linear algebra.
-/

/-- The numerical rank of A is the number of singular values above
    a tolerance ε. This is more stable than exact rank. -/
def numerical_rank : String :=
  "rank_ε(A) = #{σ_i > ε} — numerical rank via SVD threshold"

/-- Condition number κ(A) = σ_max / σ_min measures sensitivity.
    κ(A) = ‖A‖ · ‖A^+‖. Large κ → ill-conditioned. -/
def condition_number : String :=
  "κ(A) = σ_max/σ_min = ‖A‖·‖A^+‖ — condition number"

/-! ## Dual Basis Computation

Computing the dual basis numerically.
-/

/-- Given a basis {v_1,...,v_n} stored as columns of matrix B,
    the dual basis is given by the rows of B^{-1}.
    e^i(v) = (B^{-1})_{i,*} · v (i-th row of inverse times v). -/
def dual_basis_computation : String :=
  "Dual basis = rows of B^{-1} where B = [v₁|...|vₙ]; e^i(v_j) = δ_{ij}"

/-- Gram-Schmidt for dual basis: given a basis, the dual basis can
    be computed by solving n linear systems (each for one dual vector). -/
def gram_schmidt_dual : String :=
  "Gram-Schmidt: orthogonalize basis → dual basis via reciprocal basis vectors"

/-- The dual of an orthonormal basis is itself:
    If {e_i} is ON (e_i·e_j = δ_{ij}), then e^i = e_i (self-dual). -/
def orthonormal_self_dual : String :=
  "ON basis: e^i = e_i (self-dual); dual = original under inner product"

/-! ## Principal Component Analysis (PCA)

PCA uses SVD to find directions of maximum variance in data.
-/

/-- PCA: For data matrix X (n×p), the principal components are the
    eigenvectors of X^T X (which is p×p). These are the right singular
    vectors of X, spanning im(X^T). -/
def pca_svd : String :=
  "PCA: X = UΣV^T → principal directions = columns of V (right singular vectors)"

/-- Dimensionality reduction: project onto top k principal components
    to reduce dimension from p to k while preserving maximum variance. -/
def dimensionality_reduction : String :=
  "PCA reduces dim from p to k: X_k = U_k Σ_k V_k^T (rank k approximation)"

end MiniDualQuotient
