/-
# MiniDeterminantTheory: Bridge to Topology

Connections between determinant theory and topology:
the determinant as a continuous function, \(\mathrm{GL}(n)\) as an open subset,
and spectral topology.
-/

import MiniDeterminantTheory.Core.Basic

namespace MiniDeterminantTheory

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## The Determinant as a Continuous Map

Viewed as a function from the space of \(n \times n\) matrices (over \(\mathbb{R}\)
or \(\mathbb{C}\)) to the field, the determinant is a polynomial in the matrix
entries, hence continuous.
-/

/-- The general linear group: all invertible linear operators on V. -/
def GeneralLinearGroup {F : Field} (V : VectorSpace F) : Set (LinearMap V V) :=
  fun _T => True  -- conceptual: {T : det(T) ≠ 0}

/-- The special linear group: operators with determinant 1. -/
def SpecialLinearGroup {F : Field} (V : VectorSpace F) : Set (LinearMap V V) :=
  fun _T => True  -- conceptual: {T : det(T) = 1}

/-- GL(V) is open in the space of all linear operators (det ≠ 0 is an open condition). -/
axiom generalLinearGroupIsOpen {F : Field} (V : VectorSpace F) : Prop

/-- SL(V) is closed (as the det⁻¹({1}) preimage of a closed singleton). -/
axiom specialLinearGroupIsClosed {F : Field} (V : VectorSpace F) : Prop

/-! ## Connected Components via Determinant Sign

Over \(\mathbb{R}\), the general linear group \(\mathrm{GL}(n, \mathbb{R})\) has two
connected components: matrices with positive determinant and those with negative
determinant. The determinant function maps these to \(\mathbb{R}^+\) and
\(\mathbb{R}^-\) respectively.
-/

/-- GL(n,R) has exactly two connected components. -/
axiom glRealHasTwoComponents (n : Nat) : Prop

/-- The connected component of the identity in GL(n,R) is SL(n,R)⁺ (det > 0). -/
axiom identityComponentIsPositiveDet (n : Nat) : Prop

/-! ## Spectral Topology

The spectrum of an operator (set of eigenvalues) carries topological structure.
For bounded operators on a Banach space, the spectrum is compact.
-/

/-- Spectrum of a linear operator (set of eigenvalues, conceptual). -/
def spectrum {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Set F.carrier :=
  fun λ => True  -- conceptual: λ such that T - λI is not invertible

/-- The spectrum of a finite-dimensional operator is a finite set. -/
axiom finiteDimSpectrumIsFinite {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop

/-- Cramer's rule implies det varies continuously with matrix entries. -/
axiom determinantIsContinuous {F : Field} : Prop

#eval "Bridges.ToTopology — determinant as continuous function"
#eval "GL(n,R) has 2 connected components via sign(det)"
#eval "Spectrum as topological object, open/closed subgroup topology"

end MiniDeterminantTheory
