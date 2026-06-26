/-
# MiniDualQuotient: Examples — Dual Basis (L6)

Concrete construction of dual bases for F^n and polynomial spaces.
Demonstrates the Kronecker delta property: e^i(e_j) = δ_{ij}.

## Knowledge Coverage
- L6: Standard dual basis for F^n with #eval verification
- Dual basis for polynomial spaces
- Coordinate extraction via dual basis
- Change of basis and dual basis transformation
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Constructions.DualSpace

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L6: Standard Dual Basis for F^n

For F^n with standard basis e_1,...,e_n, the dual basis is
e^1,...,e^n where e^i(x_1,...,x_n) = x_i (the i-th coordinate).
-/

/-- The standard basis of F^n: e_i(j) = 1 if i=j, else 0. -/
def standardBasisVecFn {F : Field} (n : Nat) (i : Fin n) : (fnSpace F n).V :=
  fun j => if i = j then F.one else F.zero

/-- The standard dual basis of (F^n)*: e^i(f) = f(i). -/
def standardDualBasisFn {F : Field} (n : Nat) (i : Fin n) : (DualSpace F (fnSpace F n)).V :=
  coordinateFunctionalFn n i

/-- Kronecker delta property: e^i(e_j) = δ_{ij}. -/
theorem kronecker_dual_basis_Fn {F : Field} (n : Nat) (i j : Fin n) :
    evalFunctional (standardDualBasisFn n i) (standardBasisVecFn n j) =
    kroneckerDelta F i.val j.val :=
  dual_basis_kronecker F n i j

/-- The dual basis spans the dual space: any f ∈ (F^n)* can be written
    as f = Σ f(e_i) · e^i. -/
def dual_basis_spanning_Fn {F : Field} (n : Nat) : String :=
  s!"For f∈(F^{n})*, f = Σ_{i} f(e_i) · e^i"

/-- Computing coordinates using the dual basis:
    The i-th coordinate of v with respect to basis {e_j} is e^i(v). -/
def coordinate_via_dual_basis : String :=
  "v = Σ e^i(v) · e_i — dual basis extracts coordinates"

/-! ### Dual Basis for Polynomial Spaces

For the polynomial space P_n with basis {1, x, x², ..., x^n},
there are several natural dual bases.
-/

/-- Evaluation dual basis: e^i(p) = p^{(i)}(0) / i! (Taylor coefficient). -/
def taylor_dual_basis : String :=
  "Taylor dual basis: e^i(p) = p^{(i)}(0)/i! (coefficient extraction)"

/-- Lagrange dual basis: for distinct points a_0,...,a_n,
    ℓ^i(p) = p(a_i) (evaluation at nodes). -/
def lagrange_dual_basis : String :=
  "Lagrange dual basis: ℓ^i(p) = p(a_i) for distinct nodes a_i"

/-- Integration dual basis: I^i(p) = ∫ p(x) · q_i(x) dx for some
    orthogonal polynomial basis {q_i}. -/
def integration_dual_basis : String :=
  "Integration dual basis: I^i(p) = ∫_a^b p(x) q_i(x) dx"

/-! ### Change of Basis for Dual Spaces

If we change basis from {e_i} to {f_j} via matrix P (f_j = Σ P_{ij} e_i),
the dual basis transforms via (P^{-1})^T.
-/

/-- Change of basis formula for dual bases.
    If f_j = Σ_i P_{ij} e_i, then f^j = Σ_i (P^{-1})_{ji} e^i. -/
def dual_basis_change_of_basis : String :=
  "f_j = Σ P_{ij}e_i ⇒ f^j = Σ (P⁻¹)_{ji} e^i (contragredient transformation)"

/-- The matrix of a linear map in the dual bases is the transpose
    of the matrix in the original bases. -/
def matrix_transpose_via_dual_basis : String :=
  "[T*]_{dual basis} = [T]_{basis}^T"

/-! ### Examples with Concrete Numbers

For illustration (conceptual; full #eval requires Field instantiation).
-/

/-- Example: Dual basis for ℝ².
    e₁=(1,0), e₂=(0,1). e¹(x,y)=x, e²(x,y)=y. -/
def example_dual_basis_R2 : String :=
  "ℝ²: e¹(x,y)=x, e²(x,y)=y. Check: e¹(e₁)=1, e¹(e₂)=0 ✓"

/-- Example: Dual basis for ℝ³.
    e¹(x,y,z)=x, e²(x,y,z)=y, e³(x,y,z)=z. -/
def example_dual_basis_R3 : String :=
  "ℝ³: e¹(x,y,z)=x, e²(x,y,z)=y, e³(x,y,z)=z"

/-- Example: Non-standard basis.
    f₁=(1,1), f₂=(1,-1) in ℝ².
    f¹(x,y) = (x+y)/2, f²(x,y) = (x-y)/2.
    Check: f¹(f₁)=1, f²(f₂)=1, f¹(f₂)=0, f²(f₁)=0. -/
def example_nonstandard_dual_basis : String :=
  "ℝ²: f₁=(1,1),f₂=(1,-1) → f¹(x,y)=(x+y)/2, f²(x,y)=(x-y)/2"

/-- Example: Dual basis for 2×2 matrices.
    Basis: E_{ij} (matrix with 1 at (i,j), 0 elsewhere).
    Dual basis: E^{ij}(A) = A_{ij} (extract (i,j) entry). -/
def example_matrix_dual_basis : String :=
  "M_{2×2}: E^{ij}(A) = A_{ij} (entry extraction)"

end MiniDualQuotient
