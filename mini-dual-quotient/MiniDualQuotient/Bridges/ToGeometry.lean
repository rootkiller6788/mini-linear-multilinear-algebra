/-
# MiniDualQuotient: Bridges — ToGeometry (L7-L8)

Connects dual and quotient spaces to geometry:
tangent/cotangent spaces, projective spaces, Grassmannians,
differential forms, and symplectic duality.

## Knowledge Coverage
- L7: Application to differential geometry
- L8: Grassmannians, flag varieties, symplectic duality
-/

import MiniDualQuotient.Core.Basic

namespace MiniDualQuotient

/-! ## Tangent and Cotangent Spaces

At a point p of a smooth manifold M, the tangent space T_pM
and cotangent space T*_pM = (T_pM)* are dual vector spaces.
-/

/-- The cotangent space is the dual of the tangent space: T*_pM = (T_pM)*.
    Differential forms are sections of the cotangent bundle. -/
def cotangent_as_dual : String :=
  "T*_pM = Hom(T_pM, ℝ) — cotangent space = dual of tangent space"

/-- A vector field is a section of TM; a 1-form is a section of T*M.
    The pairing ⟨ω, X⟩ = ω(X) gives a function on M. -/
def differential_forms : String :=
  "Ω¹(M) = Γ(T*M) — 1-forms are dual to vector fields pointwise"

/-- The differential df of a function f: M → ℝ is a 1-form:
    df_p(v) = v(f) (directional derivative). This is the dual of
    the tangent vector v. -/
def differential_of_function : String :=
  "df_p ∈ T*_pM, df_p(v) = v(f) — gradient is dual to direction"

/-! ## Projective Space as Quotient

The projective space P(V) = (V \ {0}) / ~, where v ~ w iff v = λw
for some λ ∈ F*.
-/

/-- P(V) = (V\{0}) / F* — projective space as quotient of
    the punctured vector space by scalar multiplication. -/
def projective_space_quotient : String :=
  "P(V) = (V\\{0}) / F* — quotient by the action of the multiplicative group"

/-- Homogeneous coordinates: [x₀:...:xₙ] ∈ P^n represents the
    equivalence class of (x₀,...,xₙ) under scaling. -/
def homogeneous_coordinates : String :=
  "[x₀:...:xₙ] ∈ Pⁿ = (Fⁿ⁺¹\\{0}) / F*"

/-- The tautological line bundle O(-1) over P(V) has fiber
    over [v] equal to the line spanned by v. Its dual O(1)
    is the hyperplane bundle. -/
def tautological_bundle : String :=
  "O(-1) → P(V): fiber over [v] = span{v}; O(1) = O(-1)*"

/-! ## Grassmannians and Flag Varieties

The Grassmannian Gr(k, V) = {k-dimensional subspaces of V}
can be described as a quotient of the Stiefel manifold.
-/

/-- Gr(k, V) ≅ {full-rank n×k matrices} / GL(k) —
    Grassmannian as quotient of the Stiefel manifold. -/
def grassmannian_quotient : String :=
  "Gr(k, Fⁿ) ≅ St(k, n) / GL(k) — Grassmannian as homogeneous space"

/-- The Plücker embedding: Gr(k, V) → P(∧^k V) sends a subspace
    W to the line spanned by w₁∧...∧w_k (any basis of W).
    This uses the exterior power (a quotient of the tensor power). -/
def plucker_embedding : String :=
  "Plücker: Gr(k,V) ↪ P(∧^k V), W ↦ [w₁∧...∧w_k]"

/-- Flag varieties: F(d₁,...,d_k; V) = chains of subspaces
    V₁ ⊂ ... ⊂ V_k ⊂ V with dim V_i = d_i.
    These are iterated Grassmannian bundles. -/
def flag_varieties : String :=
  "Flag varieties: iterated Grassmannians; quotient of GL(n) by parabolic subgroup"

/-! ## Symplectic Duality

A symplectic form ω: V × V → F is non-degenerate and skew-symmetric.
It induces an isomorphism V ≅ V* via v ↦ ω(v, -).
-/

/-- A symplectic vector space (V, ω) has a natural isomorphism
    V ≅ V* given by v ↦ ω(v, -). This is a self-duality. -/
def symplectic_duality : String :=
  "Symplectic ω: V ≅ V* via v ↦ ω(v, -) (non-degenerate pairing)"

/-- For a symplectic manifold (M, ω), the musical isomorphism
    ♭: TM → T*M sends X ↦ ω(X, -). Its inverse ♯: T*M → TM
    maps 1-forms to vector fields. -/
def musical_isomorphism : String :=
  "♭: TM → T*M, ♯: T*M → TM — symplectic musical isomorphisms"

/-- Lagrangian subspaces L ⊂ V satisfy L = L^ω (orthogonal complement
    w.r.t. ω). For a Lagrangian L, V/L ≅ L* (canonically). -/
def lagrangian_subspaces : String :=
  "Lagrangian L ⊂ V: L = L^ω, and V/L ≅ L*"

/-! ## Quotients in Riemannian Geometry

The Riemannian metric g gives an isomorphism TM ≅ T*M.
The Levi-Civita connection and curvature use duality.
-/

/-- g: TM ≅ T*M via X ↦ g(X, -) (Riemannian musical isomorphism). -/
def riemannian_duality : String :=
  "Metric g induces TM ≅ T*M — Riemannian duality"

/-- The Hodge star *: ∧^k T*M → ∧^{n-k} T*M uses the metric
    and orientation. It satisfies ** = ±id. -/
def hodge_star : String :=
  "Hodge star *: Ω^k(M) → Ω^{n-k}(M), ** = (-1)^{k(n-k)} (duality of forms)"

end MiniDualQuotient
