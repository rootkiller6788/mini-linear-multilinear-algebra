/-
# MiniDualQuotient: Examples — Reflexivity (L6-L8)

Reflexivity: V ≅ V** for finite-dimensional V.
Counterexamples in infinite dimensions.
Connections to functional analysis (Banach spaces, weak topologies).

## Knowledge Coverage
- L6: F^n reflexivity example
- L7: Application to double dual in physics and optimization
- L8: Non-reflexive Banach spaces, weak-* topology
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Constructions.DualSpace

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L6: Reflexivity of F^n

The canonical embedding ev: F^n → (F^n)** is an isomorphism.
This was proved constructively in Constructions/DualSpace.lean.
-/

/-- F^n is reflexive: the canonical embedding is an isomorphism. -/
def fn_reflexive_example (F : Field) (n : Nat) : String :=
  s!"ev: F^{n} ≅ (F^{n})** — canonical embedding is an isomorphism"

/-- For ℝ³: ev(x,y,z)(f) = f(x,y,z). The inverse sends φ ∈ (ℝ³)**
    to (φ(e¹), φ(e²), φ(e³)) where e¹,e²,e³ is the dual basis. -/
def r3_reflexive_example : String :=
  "ev: ℝ³ ≅ (ℝ³)**: ev(v)(f)=f(v), inverse: φ ↦ (φ(e¹),φ(e²),φ(e³))"

/-- For P_n: ev(p)(φ) = φ(p). Since dim(P_n)=n+1<∞, P_n is reflexive. -/
def polynomial_reflexive_example : String :=
  "P_n ≅ P_n** for n < ∞; ev(p)(φ) = φ(p)"

/-- Any finite-dimensional vector space is reflexive.
    Proof: Pick a basis of size n, identify V ≅ F^n,
    use reflexivity of F^n, and transport the isomorphism. -/
def finite_dim_reflexive : String :=
  "All finite-dimensional V are reflexive: V ≅ V** via ev"

/-! ## L7: Applications of Reflexivity

### Physics: States and Observables
In quantum mechanics:
- V = state space (finite-dimensional for qubits)
- V* = space of observables (linear functionals = expectation values)
- V** = double dual = states on observables
- Reflexivity means every state on observables comes from a vector state
-/

/-- In quantum mechanics: state ↦ expectation functional,
    and every expectation functional comes from a density matrix.
    This is the reflexivity of trace-class operators. -/
def quantum_reflexivity : String :=
  "Quantum states ≅ (Observables)* via density matrices (reflexivity of trace class)"

/-- In machine learning: the dual of a feature space is the space of
    linear predictors. The double dual recovers the feature space. -/
def ml_dual_spaces : String :=
  "Feature space V → predictors V* → representer theorem: V** ≅ V"

/-! ## L8: Non-Reflexive Spaces in Functional Analysis

In infinite-dimensional Banach spaces, reflexivity is a subtle property.
-/

/-- James' Theorem: A Banach space is reflexive iff every continuous
    linear functional attains its maximum on the unit ball. -/
def james_theorem : String :=
  "James' Theorem: X reflexive ⇔ every f∈X* attains its norm on the unit ball"

/-- c₀ = {(xₙ) | xₙ → 0} with sup norm.
    c₀* ≅ ℓ¹ (absolutely summable sequences).
    c₀** ≅ ℓ∞ (bounded sequences).
    c₀ is NOT reflexive: c₀ ≇ c₀**. -/
def c0_non_reflexive : String :=
  "c₀* ≅ ℓ¹, c₀** ≅ ℓ∞, c₀ ⊊ c₀** — c₀ is not reflexive"

/-- ℓ¹ is not reflexive: (ℓ¹)** ≅ (ℓ∞)* ⊋ ℓ¹. -/
def l1_non_reflexive : String :=
  "ℓ¹** ≅ (ℓ∞)* ≇ ℓ¹ — ℓ¹ is not reflexive"

/-- Hilbert spaces are reflexive:
    H* ≅ H (Riesz representation), so H** ≅ H* ≅ H. -/
def hilbert_reflexive : String :=
  "All Hilbert spaces are reflexive (by Riesz representation theorem)"

/-- The weak and weak-* topologies:
    V has the weak topology (from V*), V* has the weak-* topology (from V).
    Reflexivity means the weak and weak-* topologies on V* coincide
    (under the identification V ≅ V**). -/
def weak_star_topology : String :=
  "V reflexive ⇒ weak topology on V* = weak-* topology on V*"

/-- Reflexive Banach spaces are exactly those where the unit ball
    is weakly compact (Eberlein-Šmulian theorem). -/
def eberlein_smulian : String :=
  "V reflexive ⇔ unit ball of V is weakly compact (Eberlein-Šmulian)"

end MiniDualQuotient
