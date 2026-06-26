/-
# MiniDualQuotient: Bridges — ToTopology (L7-L8)

Connects dual and quotient spaces to topology:
continuous dual, weak/weak-* topologies, Banach-Alaoglu,
Hahn-Banach, and quotient topologies.

## Knowledge Coverage
- L7: Application to functional analysis and topological vector spaces
- L8: Weak-* compactness, Krein-Milman, Choquet theory
-/

import MiniDualQuotient.Core.Basic

namespace MiniDualQuotient

/-! ## Continuous Dual Space

For a topological vector space V, the continuous dual V'
consists of continuous linear functionals V → F.
V' ⊆ V* (algebraic dual) with equality for finite-dimensional V.
-/

/-- The continuous dual V' = {f ∈ V* | f is continuous}.
    For finite-dimensional V (with its unique Hausdorff TVS topology),
    V' = V* (every linear functional is continuous). -/
def continuous_dual : String :=
  "V' = {f∈V* | f continuous}; for finite-dim V, V' = V*"

/-- For a normed space (V, ‖·‖), the dual norm on V' is
    ‖f‖ = sup_{‖v‖≤1} |f(v)|. This makes V' a Banach space. -/
def dual_norm : String :=
  "‖f‖ = sup_{‖v‖≤1} |f(v)| — dual norm makes V' a Banach space"

/-- The canonical embedding V → V'' (continuous double dual) is
    an isometry. V is reflexive in the functional-analytic sense
    if this embedding is surjective. -/
def continuous_double_dual : String :=
  "J: V → V'', J(v)(f) = f(v) — canonical isometric embedding"

/-! ## Weak and Weak-* Topologies

The weak topology σ(V, V') on V is the coarsest topology making
all f ∈ V' continuous.
The weak-* topology σ(V', V) on V' is the topology of pointwise
convergence on V.
-/

/-- Weak topology on V: v_α → v iff f(v_α) → f(v) ∀ f∈V'. -/
def weak_topology : String :=
  "σ(V,V'): v_α ⇀ v iff f(v_α) → f(v) for all f∈V'"

/-- Weak-* topology on V': f_α → f iff f_α(v) → f(v) ∀ v∈V.
    This makes V' a locally convex space. -/
def weak_star_topology : String :=
  "σ(V',V): f_α ⇀* f iff f_α(v) → f(v) for all v∈V"

/-- Banach-Alaoglu Theorem: The closed unit ball of V' is
    weak-* compact. This is the fundamental compactness result
    in functional analysis. -/
def banach_alaoglu : String :=
  "Banach-Alaoglu: unit ball of V' is σ(V',V)-compact"

/-- The weak-* topology on V' coincides with the weak topology
    when V is reflexive (since V ≅ V''). -/
def weak_star_equals_weak : String :=
  "V reflexive ⇒ σ(V',V) = σ(V',V'') — weak-* = weak on V'"

/-! ## Hahn-Banach Theorem

The Hahn-Banach theorem allows extending continuous linear
functionals from subspaces to the whole space.
-/

/-- Hahn-Banach (analytic form): For a subspace U ⊆ V and
    f ∈ U', there exists an extension f̃ ∈ V' with ‖f̃‖ = ‖f‖. -/
def hahn_banach_extension : String :=
  "Hahn-Banach: ∀ f∈U', ∃ f̃∈V' extending f with same norm"

/-- Hahn-Banach (geometric form): Separating hyperplane theorem.
    Disjoint convex sets can be separated by a closed hyperplane. -/
def hahn_banach_geometric : String :=
  "Geometric Hahn-Banach: disjoint convex sets separated by hyperplane"

/-- Corollary: The continuous dual separates points in a locally
    convex space. For any v ≠ 0, ∃ f∈V' with f(v) ≠ 0. -/
def dual_separates_points : String :=
  "V' separates points of V (for locally convex Hausdorff TVS)"

/-! ## Quotient Topology

For a topological vector space V and subspace U, the quotient
topology on V/U is the finest topology making π: V → V/U continuous.
-/

/-- The quotient topology on V/U: a set is open iff its preimage
    under π is open in V. -/
def quotient_topology : String :=
  "Quotient topology on V/U: π continuous; V/U is Hausdorff iff U is closed"

/-- For a normed space V and closed subspace U, the quotient norm is
    ‖[v]‖ = inf_{u∈U} ‖v + u‖. This makes V/U a normed space. -/
def quotient_norm : String :=
  "‖[v]‖ = inf_{u∈U} ‖v+u‖ — quotient norm on V/U"

/-- The dual of a quotient: (V/U)' ≅ U° (annihilator in V').
    This is the topological version of (V/U)* ≅ U°. -/
def quotient_dual_annihilator : String :=
  "(V/U)' ≅ U° = {f∈V' | f|_U = 0} — annihilator as continuous dual of quotient"

/-! ## Krein-Milman and Choquet Theory

Extreme points and integral representations in locally convex spaces.
-/

/-- Krein-Milman Theorem: A compact convex set K in a locally convex
    space is the closed convex hull of its extreme points. -/
def krein_milman : String :=
  "Krein-Milman: compact convex K = co(ext(K)) (closed convex hull of extreme points)"

/-- Choquet's Theorem: Every point in a compact convex set can be
    represented as an integral over extreme points (Choquet measure). -/
def choquet_theorem : String :=
  "Choquet: x = ∫_{ext(K)} y dμ_x(y) — integral representation over extreme points"

/-- Bishop-Phelps Theorem: The set of norm-attaining functionals
    is dense in V'. This connects functional analysis to optimization. -/
def bishop_phelps : String :=
  "Bishop-Phelps: norm-attaining functionals are dense in V'"

end MiniDualQuotient
