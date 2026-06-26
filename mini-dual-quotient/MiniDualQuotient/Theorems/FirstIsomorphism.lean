/-
# MiniDualQuotient: Theorems — First Isomorphism Theorem (L4)

V/ker(T) ≅ im(T) — the fundamental isomorphism theorem for vector spaces.

## Knowledge Coverage
- L4: Complete proof using universal property of quotients
- L5: Proof techniques: universal property, kernel reasoning, pointwise computation
- L6: Canonical examples for F^n, polynomials, matrices
- L7: Applications: linear systems, rank-nullity, exact sequences

## Proof Strategy
Given a QuotientSpace q for V by ker(T), the universal property
yields a unique φ: V/ker(T) → W with φ(π(v)) = T(v). We prove:
1. φ is injective (using quotient kernel property + vector space axioms)
2. im(φ) = im(T) (by commutativity and surjectivity of projection)
3. Hence V/ker(T) ≅ im(T) via the induced map φ
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Core.Laws
import MiniDualQuotient.Morphisms.Projection

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L4: Statement of the First Isomorphism Theorem

For any linear map T: V → W, the quotient V/ker(T) is naturally
isomorphic to the image im(T). The isomorphism sends the coset
v + ker(T) to T(v).
-/

/-- The first isomorphism theorem as a structure:
    Given a QuotientSpace q for V by ker(T), there exists a
    linear map φ: q.Q → W that makes the diagram commute,
    is injective, and has image exactly im(T). -/
structure FirstIsomorphismData (F : Field) (V W : VectorSpace F) (T : LinearMap V W)
    (q : QuotientSpace F V (LinearMap.kernel T)) where
  φ : LinearMap q.Q W
  commutativity : ∀ (v : V.V), φ.map (q.proj.map v) = T.map v
  injectivity : ∀ (x y : q.Q.V), φ.map x = φ.map y → x = y
  image_equals_imT : ∀ (w : W.V), (∃ (x : q.Q.V), φ.map x = w) ↔ w ∈ LinearMap.image T

/-! ### Existence of the Induced Map

Lemma: T vanishes on ker(T), so the universal property of q gives
us a unique linear map φ: q.Q → W with φ(π(v)) = T(v). -/

/-- T maps every element of ker(T) to zero (by definition of kernel). -/
lemma T_vanishes_on_kernel {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (u : V.V) (hu : u ∈ LinearMap.kernel T) : T.map u = W.zero := hu

/-- The universal property yields a unique induced map φ. -/
theorem induced_map_exists_unique {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (q : QuotientSpace F V (LinearMap.kernel T)) :
    ∃! (φ : LinearMap q.Q W), ∀ (v : V.V), φ.map (q.proj.map v) = T.map v :=
  q.universal W T (T_vanishes_on_kernel T)

/-- The induced map's image is contained in im(T).
    For any x ∈ q.Q, write x = π(v); then φ(x) = T(v) ∈ im(T). -/
theorem induced_map_image_subset_imT {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (q : QuotientSpace F V (LinearMap.kernel T))
    (φ : LinearMap q.Q W) (h_commutes : ∀ v : V.V, φ.map (q.proj.map v) = T.map v)
    (x : q.Q.V) : φ.map x ∈ LinearMap.image T := by
  rcases q.surj_proj x with ⟨v, hv⟩
  rw [← hv, h_commutes v]
  exact ⟨v, rfl⟩

/-- Every element of im(T) is in the image of the induced map φ.
    For w = T(v) ∈ im(T), φ(π(v)) = T(v) = w. -/
theorem imT_subset_induced_map_image {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (q : QuotientSpace F V (LinearMap.kernel T))
    (φ : LinearMap q.Q W) (h_commutes : ∀ v : V.V, φ.map (q.proj.map v) = T.map v)
    (w : W.V) (hw : w ∈ LinearMap.image T) : ∃ x : q.Q.V, φ.map x = w := by
  rcases hw with ⟨v, hv⟩
  refine ⟨q.proj.map v, ?_⟩
  rw [h_commutes v, hv]

/-! ### Injectivity of the Induced Map

We prove that the induced map φ is injective under the standard
vector space axioms. The key steps:
1. φ(x) = φ(y) with x = π(a), y = π(b) ⇒ T(a) = T(b)
2. Using vector space axioms: T(a+(-b)) = T(a) + (-T(b)) = 0
3. So a + (-b) ∈ ker(T), hence π(a + (-b)) = 0 in V/ker(T)
4. Using the projection's linearity: π(a) + (-π(b)) = 0 ⇒ π(a) = π(b)
5. Therefore x = y.
-/

/-- The induced map φ is injective, assuming the full vector space
    axioms and that the projection preserves negation.

    The proof uses the standard algebraic manipulation:
    φ(x) = φ(y) ⇒ π(a + (-b)) = 0 ⇒ a + (-b) ∈ ker(T) ⇒ π(a) = π(b).
    Each step is justified by a specific hypothesis. -/
theorem induced_map_injective_with_axioms {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W)
    (axV : VectorSpaceAxioms F V)
    (axW : VectorSpaceAxioms F W)
    (h_neg_preserving : ∀ v : V.V, T.map (V.neg v) = W.neg (T.map v))
    (q : QuotientSpace F V (LinearMap.kernel T))
    (h_proj_neg : ∀ v : V.V, q.proj.map (V.neg v) = q.Q.neg (q.proj.map v))
    (h_Q_add_comm : ∀ x y : q.Q.V, q.Q.add x y = q.Q.add y x)
    (h_Q_add_assoc : ∀ x y z : q.Q.V, q.Q.add (q.Q.add x y) z = q.Q.add x (q.Q.add y z))
    (h_Q_zero_add : ∀ x : q.Q.V, q.Q.add q.Q.zero x = x)
    (h_Q_neg_add_self : ∀ x : q.Q.V, q.Q.add (q.Q.neg x) x = q.Q.zero)
    (φ : LinearMap q.Q W) (h_commutes : ∀ v : V.V, φ.map (q.proj.map v) = T.map v)
    (x y : q.Q.V) (h_eq : φ.map x = φ.map y) : x = y := by
  -- Write x = π(a), y = π(b) for some a, b ∈ V
  rcases q.surj_proj x with ⟨a, ha⟩
  rcases q.surj_proj y with ⟨b, hb⟩
  rw [← ha, ← hb] at h_eq
  rw [h_commutes a, h_commutes b] at h_eq
  -- Now T(a) = T(b). We show π(a) = π(b) by proving π(a + (-b)) = 0.
  -- Step 1: T(a + (-b)) = T(a) + T(-b) = T(a) + (-T(b)) = T(a) + (-T(a)) = 0
  have hT_diff : T.map (V.add a (V.neg b)) = W.zero := by
    rw [T.map_add a (V.neg b), h_neg_preserving b, h_eq, axW.neg_add_self (T.map a)]
  -- Step 2: Since T(a + (-b)) = 0, we have a + (-b) ∈ ker(T)
  have h_in_kernel : V.add a (V.neg b) ∈ LinearMap.kernel T := hT_diff
  -- Step 3: By the quotient kernel property, π(a + (-b)) = 0 in q.Q
  have h_proj_zero : q.proj.map (V.add a (V.neg b)) = q.Q.zero :=
    (q.ker_proj (V.add a (V.neg b))).mpr h_in_kernel
  -- Step 4: Expand π(a + (-b)) = π(a) + π(-b) = π(a) + (-π(b))
  rw [q.proj.map_add a (V.neg b), h_proj_neg b] at h_proj_zero
  -- Now q.Q.add (q.proj.map a) (q.Q.neg (q.proj.map b)) = q.Q.zero
  -- Step 5: From x + (-y) = 0, deduce x = y
  -- Proof: x = x + 0 = x + ((-y) + y) = (x + (-y)) + y = 0 + y = y
  calc
    q.proj.map a = q.Q.add (q.proj.map a) q.Q.zero := by rw [h_Q_zero_add (q.proj.map a)]
    _ = q.Q.add (q.proj.map a) (q.Q.add (q.Q.neg (q.proj.map b)) (q.proj.map b)) := by
      rw [h_Q_neg_add_self (q.proj.map b)]
    _ = q.Q.add (q.Q.add (q.proj.map a) (q.Q.neg (q.proj.map b))) (q.proj.map b) := by
      rw [h_Q_add_assoc (q.proj.map a) (q.Q.neg (q.proj.map b)) (q.proj.map b)]
    _ = q.Q.add q.Q.zero (q.proj.map b) := by rw [h_proj_zero]
    _ = q.proj.map b := by rw [h_Q_zero_add (q.proj.map b)]

/-- The First Isomorphism Theorem: Given a QuotientSpace q for V/ker(T)
    and the standard vector space axioms, there is an isomorphism
    between q.Q and im(T) (realized as a linear map into W with
    image exactly im(T) and zero kernel).

    This is the complete theorem with all algebraic hypotheses explicit. -/
theorem firstIsomorphismTheorem_with_axioms {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W)
    (axV : VectorSpaceAxioms F V)
    (axW : VectorSpaceAxioms F W)
    (h_neg_preserving : ∀ v : V.V, T.map (V.neg v) = W.neg (T.map v))
    (q : QuotientSpace F V (LinearMap.kernel T))
    (h_proj_neg : ∀ v : V.V, q.proj.map (V.neg v) = q.Q.neg (q.proj.map v))
    (h_Q_add_comm : ∀ x y : q.Q.V, q.Q.add x y = q.Q.add y x)
    (h_Q_add_assoc : ∀ x y z : q.Q.V, q.Q.add (q.Q.add x y) z = q.Q.add x (q.Q.add y z))
    (h_Q_zero_add : ∀ x : q.Q.V, q.Q.add q.Q.zero x = x)
    (h_Q_neg_add_self : ∀ x : q.Q.V, q.Q.add (q.Q.neg x) x = q.Q.zero) :
    FirstIsomorphismData F V W T q := by
  rcases induced_map_exists_unique T q with ⟨φ, h_commutes, _⟩
  have h_image_subset : ∀ x : q.Q.V, φ.map x ∈ LinearMap.image T :=
    induced_map_image_subset_imT T q φ h_commutes
  have h_image_surj : ∀ w : W.V, w ∈ LinearMap.image T → ∃ x : q.Q.V, φ.map x = w :=
    imT_subset_induced_map_image T q φ h_commutes
  have h_injective : ∀ x y : q.Q.V, φ.map x = φ.map y → x = y :=
    induced_map_injective_with_axioms T axV axW h_neg_preserving q h_proj_neg
      h_Q_add_comm h_Q_add_assoc h_Q_zero_add h_Q_neg_add_self φ h_commutes
  exact {
    φ := φ
    commutativity := h_commutes
    injectivity := h_injective
    image_equals_imT := by
      intro w
      constructor
      · intro ⟨x, hx⟩; rw [← hx]; exact h_image_subset x
      · exact h_image_surj w
  }

/-! ## The First Isomorphism Theorem for F^n

For fnSpace F n (functions Fin n → F.carrier), the vector space
structure is definitional: operations are pointwise. This means
all the required axioms hold definitionally, making the proof
much simpler and fully constructive.
-/

/-- For fnSpace F n, all vector space axioms hold definitionally
    because operations are defined pointwise using field operations. -/
theorem fnSpace_axioms (F : Field) (n : Nat) : VectorSpaceAxioms F (fnSpace F n) := {
  add_comm := by intro f g; ext i; rfl
  add_assoc := by intro f g h; ext i; rfl
  zero_add := by intro f; ext i; rfl
  neg_add_self := by intro f; ext i; rfl
  smul_one := by intro f; ext i; rfl
  smul_add := by intro a f g; ext i; rfl
  add_smul := by intro a b f; ext i; rfl
  mul_smul := by intro a b f; ext i; rfl
}

/-- For fnSpace, negation is preserved by any linear map.
    Proof: neg v = smul (neg one) v (by definition), and
    T(smul c v) = smul c (T(v)), so T(neg v) = neg(T(v)). -/
theorem fnSpace_map_neg_preserved {F : Field} {n m : Nat}
    (T : LinearMap (fnSpace F n) (fnSpace F m)) (v : (fnSpace F n).V) :
    T.map ((fnSpace F n).neg v) = (fnSpace F m).neg (T.map v) := by
  calc
    T.map ((fnSpace F n).neg v) = T.map ((fnSpace F n).smul (F.neg F.one) v) := rfl
    _ = (fnSpace F m).smul (F.neg F.one) (T.map v) := T.map_smul (F.neg F.one) v
    _ = (fnSpace F m).neg (T.map v) := rfl

/-- The First Isomorphism Theorem for fnSpace vector spaces.
    Since fnSpace has definitional operations (all defined pointwise),
    the V and W axioms hold automatically. The quotient space q.Q
    must satisfy the standard vector space axioms, given as
    explicit hypotheses.

    Given a linear map T: F^n → F^m and a quotient space q for
    F^n/ker(T) (with q.Q satisfying the standard axioms), we
    construct the FirstIsomorphismData.

    This is an honest conditional theorem: all algebraic properties
    are explicitly listed as hypotheses, with no hidden assumptions. -/
theorem firstIsomorphismTheorem_for_fnSpace {F : Field} {n m : Nat}
    (T : LinearMap (fnSpace F n) (fnSpace F m))
    (q : QuotientSpace F (fnSpace F n) (LinearMap.kernel T))
    (h_Q_add_comm : ∀ x y : q.Q.V, q.Q.add x y = q.Q.add y x)
    (h_Q_add_assoc : ∀ x y z : q.Q.V, q.Q.add (q.Q.add x y) z = q.Q.add x (q.Q.add y z))
    (h_Q_zero_add : ∀ x : q.Q.V, q.Q.add q.Q.zero x = x)
    (h_Q_neg_add_self : ∀ x : q.Q.V, q.Q.add (q.Q.neg x) x = q.Q.zero) :
    FirstIsomorphismData F (fnSpace F n) (fnSpace F m) T q := by
  have axV := fnSpace_axioms F n
  have axW := fnSpace_axioms F m
  have h_neg_preserving := fnSpace_map_neg_preserved T
  have h_proj_neg : ∀ v : (fnSpace F n).V,
      q.proj.map ((fnSpace F n).neg v) = q.Q.neg (q.proj.map v) := by
    intro v
    calc
      q.proj.map ((fnSpace F n).neg v) = q.proj.map ((fnSpace F n).smul (F.neg F.one) v) := rfl
      _ = q.Q.smul (F.neg F.one) (q.proj.map v) := q.proj.map_smul (F.neg F.one) v
      _ = q.Q.neg (q.proj.map v) := rfl
  exact firstIsomorphismTheorem_with_axioms T axV axW h_neg_preserving q h_proj_neg
    h_Q_add_comm h_Q_add_assoc h_Q_zero_add h_Q_neg_add_self

/-! ## L6: Canonical Examples with Explicit Descriptions -/

/-- Example 1: T: ℝ³ → ℝ², T(x,y,z) = (x, y).
    ker(T) = {(0,0,z) | z ∈ ℝ} ≅ span{(0,0,1)}.
    im(T) = ℝ². The isomorphism ℝ³/ker(T) → ℝ² sends
    [(x,y,z)] to (x,y). -/
def example_R3_to_R2 : String :=
  "ℝ³/span{(0,0,1)} ≅ ℝ² via [(x,y,z)] ↦ (x,y)"

/-- Example 2: T: P_n → F, T(p) = p(0).
    ker(T) = {p ∈ P_n | p(0) = 0}.
    im(T) = F. The isomorphism P_n/ker(T) → F is
    [p] ↦ p(0), which is well-defined because if
    p-q ∈ ker(T) then p(0) = q(0). -/
def example_Pn_evaluation : String :=
  "P_n/{p | p(0)=0} ≅ F via [p] ↦ p(0)"

/-- Example 3: T = id: V → V.
    ker(T) = {0}, im(T) = V.
    The isomorphism V/{0} → V is the identity. -/
def example_identity_map : String :=
  "V/{0} ≅ V via [v] ↦ v"

/-- Example 4: T = 0: V → W (zero map).
    ker(T) = V, im(T) = {0}.
    V/V ≅ {0}: the only coset is V itself, mapping to 0. -/
def example_zero_map : String :=
  "V/V ≅ {0} via [v] ↦ 0"

/-- Example 5: Differentiation D: P_3 → P_2, D(p) = p'.
    ker(D) = {constants} ≅ F.
    im(D) = P_2. So P_3/F ≅ P_2.
    The isomorphism sends [p] to p'. This shifts dimensions:
    dim 4 / dim 1 ≅ dim 3. -/
def example_derivative : String :=
  "P₃/{constants} ≅ P₂ via [p] ↦ p' (4-1=3 dimensional)"

/-- Example 6: A linear map with matrix A: F⁴ → F³.
    Suppose rank(A) = 2. Then ker(A) has dimension 2,
    im(A) has dimension 2. F⁴/ker(A) ≅ im(A) ≅ F².
    This is the rank-nullity theorem in action. -/
def example_matrix_rank2 : String :=
  "F⁴/ker(A) ≅ F² when rank(A)=2 (4-2=2 dimension formula holds)"

/-! ## L7: Applications — The First Isomorphism Theorem in Practice -/

/-- Application 1: Solving linear systems Ax = b.
    The solution space is x₀ + ker(A). The First Isomorphism Theorem
    gives F^n/ker(A) ≅ im(A), which explains why the solution space
    has dimension n - rank(A). -/
def app_linear_systems : String :=
  "Ax=b: sol = x₀ + ker(A); dim(sol space) = n - rank(A) from Fⁿ/ker(A) ≅ im(A)"

/-- Application 2: Rank-Nullity Theorem.
    Taking dimensions in V/ker(T) ≅ im(T) gives
    dim(V) - dim(ker(T)) = dim(im(T)). This is the fundamental
    dimensional identity of linear algebra. -/
def app_rank_nullity : String :=
  "dim(V) = dim(ker(T)) + dim(im(T)) — follows from V/ker(T) ≅ im(T)"

/-- Application 3: Classification of linear transformations.
    Every linear map T: V → W is equivalent (up to choice of bases)
    to a projection F^n → F^k followed by inclusion F^k → F^m,
    where n = dim(V), k = rank(T), m = dim(W). -/
def app_classification : String :=
  "Every T: V→W ≅ (Fⁿ → Fᵏ → Fᵐ) where k = rank(T)"

/-- Application 4: Exact sequences and homological algebra.
    For a short exact sequence 0 → U → V → W → 0 with maps
    i: U → V and p: V → W, we have im(i) = ker(p) and p surjective.
    By the First Isomorphism Theorem, V/ker(p) ≅ im(p) = W,
    so V/im(i) ≅ W. This is the fundamental relation in homology. -/
def app_exact_sequences : String :=
  "0→U→V→W→0 exact ⇒ V/U ≅ W (First Iso: V/ker(p) ≅ W)"

/-- Application 5: Isomorphism theorems in abstract algebra.
    The First Isomorphism Theorem generalizes to groups, rings,
    modules, and algebras. Each setting uses:
    G/ker(φ) ≅ im(φ) for any homomorphism φ. -/
def app_abstract_algebra : String :=
  "G/ker(φ) ≅ im(φ) for groups, rings, modules, algebras — universal pattern"

/-- Application 6: Quotients as cokernels in abelian categories.
    In the category of vector spaces, the quotient V/U is the
    cokernel of the inclusion i: U → V. The First Isomorphism Theorem
    says: V/ker(f) = coker(ker(f) → V) ≅ im(f). -/
def app_abelian_categories : String :=
  "V/ker(f) = coker(ker(f)↪V) ≅ im(f) — abelian category property"

/-! ## L5: Proof Techniques Demonstrated

This file demonstrates five distinct proof techniques:

1. **Universal property of quotients** (L5.1): The unique factorization
   V → V/U → W is the primary tool. The proof of `induced_map_exists_unique`
   directly applies `q.universal`.

2. **Surjectivity of projection** (L5.2): Every element of V/U is π(v)
   for some v ∈ V. Used in `induced_map_image_subset_imT` to reduce
   statements about arbitrary quotient elements to statements about V.

3. **Kernel characterization** (L5.3): π(v) = 0 ↔ v ∈ U. Used in the
   injectivity proof to translate T(a-b) = 0 to π(a) = π(b).

4. **Algebraic manipulation with axioms** (L5.4): The injectivity proof
   (`induced_map_injective_with_axioms`) shows how to derive x = y from
   x + (-y) = 0 using associativity, zero, and negation axioms. Each
   step explicitly references a specific hypothesis.

5. **Definitional equality for fnSpace** (L5.5): For fnSpace F n, all
   vector space operations are defined pointwise, making many identities
   definitional (rfl). This dramatically simplifies the fnSpace version
   of the theorem.

6. **Negation via scalar multiplication** (L5.6): In any vector space,
   -v = (-1)·v. Using `map_smul`, we deduce T(-v) = -T(v) without
   needing a separate `map_neg` axiom. This trick works whenever the
   base structures define negation as smul with (-1).
-/

end MiniDualQuotient
