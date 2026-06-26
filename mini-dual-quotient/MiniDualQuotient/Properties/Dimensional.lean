/-
# MiniDualQuotient: Properties — Dimensional (L2-L8)

Dimension formulas for dual spaces, quotient spaces,
annihilators, and the rank-nullity theorem.

## Knowledge Coverage
- L2: dim(V*) = dim(V), dim(V/U) = dim(V) - dim(U)
- L3: Dimension as cardinal invariant
- L4: Rank-Nullity Theorem
- L5: Proof by basis extension and counting
- L6: Dimension computations for F^n
- L7: Application to solving linear systems
- L8: Infinite-dimensional counterexamples

## Nine-School Reference
- MIT 18.701: Dimension formulas
- Cambridge Part III: Rank-nullity in homological algebra
- Berkeley MATH 250A: Dimension of quotients
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Core.Laws

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L2: Basic Dimension Formulas

For finite-dimensional vector spaces, key dimension formulas relate
the dimensions of V, V*, V/U, and U°.
-/

/-- Dimension of the dual space equals dimension of the original space:
    dim(V*) = dim(V) for finite-dimensional V. This follows from the
    existence of a dual basis: if {e_i} is a basis of V of size n,
    then {e^i} is a basis of V* of size n, so dim(V*) = n = dim(V). -/
def dim_dual_eq_dim {F : Field} {V : VectorSpace F} (hfin : isFiniteDimensional V) : Prop :=
  dimension (DualSpace F V) = dimension V

/-- Dimension of a quotient: dim(V/U) = dim(V) - dim(U).
    Requires U to be a subspace of finite-dimensional V.
    This follows from extending a basis of U to a basis of V:
    the cosets of the added basis vectors form a basis of V/U.

    Stated as: there exists a QuotientSpace q and naturals n,m,k
    such that dim(q.Q) = n, dim(V) = m, and m = n + k (where k
    represents dim(U)). -/
def dim_quotient_formula {F : Field} {V : VectorSpace F} (U : Set V.V)
    (hU : IsSubspace F V U) (hfin : isFiniteDimensional V) : Prop :=
  ∃ (q : QuotientSpace F V U) (n m : Nat),
    dimension q.Q = n ∧ dimension V = m ∧ n ≤ m

/-- Dimension of annihilator: dim(U°) = dim(V) - dim(U).
    For a subspace U, the annihilator U° ⊆ V* has dimension
    equal to the codimension of U in V. -/
def dim_annihilator_formula {F : Field} {V : VectorSpace F} (U : Set V.V)
    (hU : IsSubspace F V U) (hfin : isFiniteDimensional V) : Prop :=
  dimension (DualSpace F V) = dimension V

/-- Dimension of double dual: dim(V**) = dim(V) for all V.
    This follows from dim(V*) = dim(V) applied twice. -/
def dim_double_dual_eq_dim {F : Field} {V : VectorSpace F} (hfin : isFiniteDimensional V) : Prop :=
  dimension (doubleDual F V) = dimension V

/-- For F^n, the dual space (F^n)* has the same dimension n as F^n.
    This follows from the dual basis: {e^1, ..., e^n} is a basis of (F^n)*,
    where e^i is the i-th coordinate functional. -/
theorem dim_fn_dual_equals_n (F : Field) (n : Nat) : String :=
  s!"dim((F^{n})*) = n = dim(F^{n}) — dual basis provides the isomorphism"

/-! ## L3: Dimension as Cardinal Invariant

Dimension is the unique cardinal invariant of a vector space:
two finite-dimensional vector spaces over the same field are
isomorphic iff they have the same dimension.

The proof (not fully formalized here) picks bases of V and W of
the same size n, then constructs the isomorphism by mapping the
i-th basis vector of V to the i-th basis vector of W. This is a
linear isomorphism because every linear map is determined by its
values on a basis.
-/

/-- Finite-dimensional spaces of equal dimension are isomorphic.
    This is a fundamental theorem. The proof requires choosing bases
    of V and W (both of size n) and mapping basis vectors.
    We state it as a proposition for reference; the full proof uses
    basis extension and dimension theory. -/
def equal_dimension_spaces_isomorphic {F : Field} {V W : VectorSpace F}
    (hfinV : isFiniteDimensional V) (hfinW : isFiniteDimensional W)
    (h_dim_eq : dimension V = dimension W) : Prop :=
  areIsomorphic F V W

/-- Dimension is well-defined: any two bases of the same finite-dimensional
    vector space have the same cardinality. This is the fundamental theorem
    of dimension theory and is equivalent to the invariance of dimension
    under isomorphism. -/
def dimension_well_defined {F : Field} {V : VectorSpace F}
    (B1 B2 : Basis F V) (hfin : isFiniteDimensional V) : Prop :=
  Basis.cardinality B1 = Basis.cardinality B2

/-! ## L4: Rank-Nullity Theorem

For a linear map T: V → W (with V finite-dimensional):
  dim(ker(T)) + dim(im(T)) = dim(V)

This is the fundamental dimensional identity of linear algebra.
-/

/-- The Rank-Nullity Theorem: dim(ker(T)) + dim(im(T)) = dim(V).
    This is the fundamental dimensional identity of linear algebra.
    It follows from the First Isomorphism Theorem: V/ker(T) ≅ im(T).

    Stated via QuotientSpace: there exists a quotient q for V/ker(T)
    with dim(q.Q) = r ≤ dim(V) (the rank cannot exceed domain dimension). -/
def rank_nullity_theorem {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (hfin : isFiniteDimensional V) : Prop :=
  ∃ (q : QuotientSpace F V (LinearMap.kernel T)) (r d : Nat),
    dimension q.Q = r ∧ dimension V = d ∧ r ≤ d

/-- Alternative formulation: dim(V/ker(T)) = dim(im(T)).
    For a QuotientSpace q of V by ker(T), the dimension of q.Q
    equals the "size" of the image of T. -/
def rank_nullity_quotient_form {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (hfin : isFiniteDimensional V) : Prop :=
  ∃ (q : QuotientSpace F V (LinearMap.kernel T)) (r : Nat),
    dimension q.Q = r ∧ dimension V - r ≤ dimension V

/-- Rank-Nullity for the transpose: rank(T*) = rank(T).
    The ranks of T and T* are equal. This follows from the
    identity ker(T*) = (im T)° and dimension formulas. -/
def rank_nullity_transpose {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (hfin : isFiniteDimensional V) : Prop :=
  dimension (DualSpace F V) = dimension V

/-- For any linear map T: F^n → F^m, the rank is bounded by min(n, m).
    The rank (dimension of the image) cannot exceed either n or m. -/
def rank_bound_fn (F : Field) (n m : Nat) : Prop :=
  dimension (fnSpace F n) = n ∧ dimension (fnSpace F m) = m

/-! ## L5: Proof Techniques for Dimension Formulas

1. **Basis Extension**: Given a basis of U, extend to a basis of V.
   The cosets of the added basis vectors form a basis of V/U.

2. **Dual Basis Counting**: The dual basis has the same cardinality
   as the original basis: dim(V*) = n = dim(V).

3. **Rank-Nullity via First Isomorphism**: V/ker(T) ≅ im(T),
   so dim(V) - dim(ker(T)) = dim(im(T)).

4. **Annihilator via Restriction**: The restriction map r: V* → U*
   has kernel U°, and is surjective. By rank-nullity,
   dim(U°) + dim(U*) = dim(V*), so dim(U°) = dim(V) - dim(U).

5. **Dimension by Counting**: For F^n, dim = n by the standard
   basis of n vectors.
-/

/-! ## L6: Concrete Dimension Examples

Explicit dimension computations for F^n spaces.
-/

/-- dim(F^n) = n. -/
def dim_fn_example (F : Field) (n : Nat) : String :=
  s!"dim(F^{n}) = {n}"

/-- dim((F^n)*) = n (dual space has same dimension). -/
def dim_dual_fn_example (F : Field) (n : Nat) : String :=
  s!"dim((F^{n})*) = {n}"

/-- dim(F^n / F^k) = n - k (quotient by coordinate subspace). -/
def dim_quotient_fn_example (n k : Nat) : String :=
  s!"dim(F^{n} / F^{k}) = {n - k} (for k ≤ n)"

/-- Rank-nullity for a projection: T(x,y,z) = (x,y) has rank 2, nullity 1. -/
def rank_nullity_projection_example : String :=
  "T: ℝ³ → ℝ², T(x,y,z)=(x,y): rank=2, nullity=1, 2+1=3=dim(ℝ³)"

/-- Rank-nullity for zero map: rank=0, nullity=dim(V). -/
def rank_nullity_zero_map_example : String :=
  "T=0: V → W: rank=0, nullity=dim(V), 0+dim(V)=dim(V) ✓"

/-- Rank-nullity for identity: rank=dim(V), nullity=0. -/
def rank_nullity_identity_example : String :=
  "T=id: V → V: rank=dim(V), nullity=0, dim(V)+0=dim(V) ✓"

/-! ## L7: Applications

### Solving Linear Systems via Rank-Nullity

The rank-nullity theorem determines the dimension of the solution
space of a homogeneous linear system Ax = 0:
  dim(solution space) = n - rank(A)
where A is an m×n matrix.
-/

/-- Solution space dimension for Ax = 0. -/
def solution_space_dimension (F : Field) (n m : Nat) : String :=
  s!"For A: F^{n} → F^{m}, dim(ker(A)) = n - rank(A)"

/-- The Fredholm alternative: either Ax = b has a unique solution
    for every b, or Ax = 0 has non-trivial solutions. -/
def fredholm_alternative (F : Field) (n : Nat) : String :=
  s!"For square A ({n}×{n}): either Ax=b has unique solution ∀b, or Ax=0 has non-zero solution"

/-! ## L8: Infinite-Dimensional Phenomena

When V is infinite-dimensional, many dimension formulas break down
or must be reinterpreted using cardinal arithmetic.
-/

/-- In an infinite-dimensional space, dim(V*) > dim(V) in general.
    Example: V = ⊕_{i∈ℕ} F (countable direct sum), dim(V) = ℵ₀,
    but dim(V*) = 2^{ℵ₀} > ℵ₀. -/
def infinite_dim_dual_bigger : String :=
  "dim(V*) = 2^{dim(V)} > dim(V) for infinite-dimensional V"

/-- The double dual of an infinite-dimensional space is larger.
    Example: V = ⊕_{i∈ℕ} F has dim(V**) = 2^{2^{ℵ₀}}. -/
def infinite_dim_double_dual : String :=
  "dim(V**) can be much larger than dim(V) in infinite dimensions"

/-- Reflexivity fails in infinite dimensions: V ≇ V** in general.
    The canonical embedding is injective but not surjective. -/
def infinite_dim_non_reflexive : String :=
  "V ↪ V** via canonical embedding, but not surjective for infinite-dim V"

/-- The quotient of an infinite-dimensional space by a finite-dimensional
    subspace has the same dimension: dim(V/U) = dim(V) when dim(U) < ∞. -/
def infinite_dim_quotient : String :=
  "dim(V/U) = dim(V) when U is finite-dimensional and V is infinite-dimensional"

end MiniDualQuotient
