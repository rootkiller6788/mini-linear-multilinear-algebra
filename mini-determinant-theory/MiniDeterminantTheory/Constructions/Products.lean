/-
# MiniDeterminantTheory: Products

Exterior product and wedge product constructions.
-/

import MiniDeterminantTheory.Core.Basic

namespace MiniDeterminantTheory

/-! ## Exterior Power (conceptual)

The determinant as the top exterior power:
det(T) is the scalar by which T acts on ⋀^n V.
-/

def exteriorPower (V : Type u) (k : Nat) [VectorSpace V F] : Type u :=
  V  -- conceptual: actual exterior power requires quotient construction

/-! ## Wedge Product (conceptual) -/

def wedgeProduct {F : Field} {V : VectorSpace F} (v w : V.V) : V.V :=
  V.zero  -- conceptual

/-! ## Laplace Expansion (conceptual) -/

def laplaceExpansion {F : Field} {V : VectorSpace F} (T : LinearMap V V) (row col : Nat) : F.carrier :=
  F.zero  -- conceptual: determinant via cofactor expansion

end MiniDeterminantTheory
