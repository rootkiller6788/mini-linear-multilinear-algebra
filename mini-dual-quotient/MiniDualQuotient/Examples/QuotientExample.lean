/-
# MiniDualQuotient: Examples — Quotient Spaces (L6)

Concrete quotient space examples: F^n by coordinate subspaces,
polynomial quotients, matrix quotients, and function space quotients.

## Knowledge Coverage
- L6: Explicit quotient constructions with geometric interpretation
- Quotient by a line, plane, hyperplane
- Polynomial quotient = evaluation at points
- Matrix quotient by symmetric / skew-symmetric subspaces
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Constructions.QuotientSpace

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L6: Quotient of F^n by Coordinate Subspaces

The simplest quotients: F^n / F^k where F^k is embedded as the
first k coordinates (remaining coordinates set to 0).
-/

/-- Quotient F^n / F^k ≅ F^{n-k}.
    The projection drops the first k coordinates. -/
def fn_quotient_by_coordinate_subspace (F : Field) (n k : Nat) : String :=
  s!"F^{n} / F^{k} ≅ F^{n - k} (projection onto last {n - k} coordinates)"

/-- Example: ℝ³ / (span{e₁}) ≅ ℝ².
    Coset (x,y,z) + span{(1,0,0)} is identified with (y,z). -/
def r3_quotient_by_line : String :=
  "ℝ³ / span{(1,0,0)} ≅ ℝ²: [(x,y,z)] ↦ (y,z)"

/-- Example: ℝ³ / (span{e₁,e₂}) ≅ ℝ.
    Coset (x,y,z) + xy-plane is identified with z. -/
def r3_quotient_by_plane : String :=
  "ℝ³ / span{e₁,e₂} ≅ ℝ: [(x,y,z)] ↦ z"

/-- Example: F^n / (hyperplane) ≅ F.
    For a non-zero linear functional φ, ker(φ) is a hyperplane,
    and F^n/ker(φ) ≅ F via φ. -/
def fn_quotient_by_hyperplane : String :=
  "Fⁿ / ker(φ) ≅ F for any non-zero φ ∈ (Fⁿ)*"

/-! ### Polynomial Quotient Spaces

Quotients of polynomial spaces by subspaces defined by vanishing
conditions at points.
-/

/-- P_n / {p | p(0) = 0} ≅ F.
    The isomorphism evaluates at 0: [p] ↦ p(0). -/
def polynomial_quotient_evaluation : String :=
  "P_n / {p | p(0)=0} ≅ F via [p] ↦ p(0)"

/-- P_n / {p | p(a₁)=...=p(a_k)=0} ≅ F^k for distinct points a_i.
    The isomorphism evaluates at the k points. -/
def polynomial_quotient_multipoint : String :=
  "P_n / {p | p(a₁)=...=p(a_k)=0} ≅ F^k via [p] ↦ (p(a₁),...,p(a_k))"

/-- Taylor quotient: P_n / {p | p(0)=p'(0)=...=p^{(k-1)}(0)=0} ≅ P_{k-1}.
    The isomorphism takes the degree-(k-1) Taylor polynomial. -/
def polynomial_taylor_quotient : String :=
  "P_n / {p | p^{(i)}(0)=0 for i<k} ≅ P_{k-1} (Taylor jet)"

/-! ### Matrix Quotient Spaces

Quotients of matrix spaces by subspaces with symmetry conditions.
-/

/-- M_{n×n} / Sym_n ≅ Skew_n (symmetric quotient).
    Every matrix decomposes as symmetric + skew-symmetric.
    The quotient by symmetric matrices is isomorphic to skew-symmetric. -/
def matrix_quotient_symmetric : String :=
  "M_{n×n}(F) / Sym_n ≅ Skew_n (char F ≠ 2)"

/-- M_{n×n} / {A | tr(A) = 0} ≅ F.
    The isomorphism is the trace: [A] ↦ tr(A). -/
def matrix_quotient_traceless : String :=
  "M_{n×n} / sl_n ≅ F via [A] ↦ tr(A)"

/-- M_{m×n} / {A | Ax = 0} ≅ column space of A (for fixed x).
    By First Isomorphism Theorem applied to A ↦ Ax. -/
def matrix_quotient_kernel_column : String :=
  "M_{m×n} / {A | Ax=0} ≅ col(Ax) ≅ F^m"

/-! ### Function Space Quotients

Quotients of function spaces illustrate infinite-dimensional phenomena.
-/

/-- C[0,1] / {f | f(0) = 0} ≅ ℝ.
    The isomorphism is evaluation at 0: [f] ↦ f(0). -/
def continuous_function_quotient : String :=
  "C[0,1] / {f | f(0)=0} ≅ ℝ via [f] ↦ f(0)"

/-- C[0,1] / {f | ∫₀¹ f = 0} ≅ ℝ.
    The isomorphism is the integral: [f] ↦ ∫ f. -/
def integral_quotient : String :=
  "C[0,1] / {f | ∫₀¹ f = 0} ≅ ℝ via [f] ↦ ∫₀¹ f(x) dx"

/-- ℓ∞ / c₀ ≇ ℓ∞ (quotient is not isomorphic to the whole space).
    This illustrates that quotients of infinite-dimensional spaces
    can be subtle. -/
def bounded_sequence_quotient : String :=
  "ℓ∞ / c₀ — the quotient of bounded sequences by sequences → 0"

/-! ### Quotient by Kernel = Image

The First Isomorphism Theorem in action.
-/

/-- For any T: V → W, V/ker(T) ≅ im(T).
    This unifies all quotient examples: every quotient is V/U
    for U = ker(π) where π is the projection. -/
def quotient_as_image : String :=
  "Every quotient V/U is V/ker(π) ≅ im(π) = V/U for π: V → V/U"

/-- Example: derivative operator D: P_n → P_{n-1}.
    ker(D) = {constants} ≅ F, im(D) = P_{n-1}.
    So P_n/constants ≅ P_{n-1}. -/
def derivative_quotient_example : String :=
  "D: P_n → P_{n-1}, ker=constants, P_n/constants ≅ P_{n-1}"

/-- Example: Laplacian Δ: C∞ → C∞.
    ker(Δ) = harmonic functions, im(Δ) has codim = dim(harmonic).
    C∞/ker(Δ) ≅ im(Δ). -/
def laplacian_quotient_example : String :=
  "Δ: C∞ → C∞, C∞/ker(Δ) ≅ im(Δ) (by First Iso Theorem)"

end MiniDualQuotient
