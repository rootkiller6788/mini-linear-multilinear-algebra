/-
# MiniMultilinearForm.Alternating.ExteriorPower

Exterior powers: the k-th exterior power of a vector space,
constructed as a quotient of the tensor algebra by alternating relations.
-/

import MiniMultilinearForm.Alternating.Basic

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Exterior Power Type -/

/-- The k-th exterior power V^∧k of a vector space V.
    Constructed as the quotient of V^⊗k by the subspace generated
    by elements with repeated entries. -/
structure ExteriorPower {F : Field} (V : VectorSpace F) (k : Nat) where
  underlying : VectorSpace F  -- The vector space V^∧k
  wedge : (Fin k → V.V) → underlying.V  -- Alternating multilinear map
  alternating : ∀ (i j : Fin k) (v : Fin k → V.V),
    i ≠ j → v i = v j → wedge v = underlying.zero

/-! ## Wedge Product -/

/-- The wedge product ∧ : ΛᵖV × ΛᑫV → Λᵖ⁺ᑫV. -/
def ExteriorPower.wedgeProduct {F : Field} {V : VectorSpace F} {p q : Nat}
    (α : ExteriorPower V p) (β : ExteriorPower V q) : ExteriorPower V (p + q) :=
  ⟨α.underlying, fun v => α.underlying.zero, by
    intro i j v hineq heq; rfl
  ⟩  -- Stub

/-! ## Basis of Exterior Power -/

/-- If {e₁,...,eₙ} is a basis of V, then {eᵢ₁∧...∧eᵢₖ | 1 ≤ i₁ < ... < iₖ ≤ n}
    is a basis of ΛᵏV. -/
def ExteriorPower.basisSize {F : Field} {V : VectorSpace F} {k n : Nat}
    (pow : ExteriorPower V k) : Nat :=
  Nat.choose n k  -- Stub: binomial coefficient

/-! ## Determinant via Exterior Power -/

/-- The determinant of a linear map T: V→V is the scalar λ such that
    the induced map ΛⁿT: ΛⁿV → ΛⁿV is multiplication by λ. -/
def determinantViaExteriorPower {F : Field} {V : VectorSpace F} {n : Nat}
    (T : V.V → V.V) (topPower : ExteriorPower V n) : F.carrier :=
  F.zero  -- Stub

#eval "Alternating.ExteriorPower: exterior powers, wedge product, determinant via top exterior power"
