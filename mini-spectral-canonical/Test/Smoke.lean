/-
# Smoke Tests -- MiniSpectralCanonical

Run: `lake env lean --run Test/Smoke.lean`
-/

import MiniSpectralCanonical

open MiniSpectralCanonical

#eval "══ MINI-SPECTRAL-CANONICAL SMOKE TESTS ══"

/-! ## Core.Basic: Jordan Block -/

#eval "── Core.Basic: JordanBlock ──"
def testJordanBlock : JordanBlock { carrier := Float, add := fun x y => x + y, mul := fun x y => x * y, zero := 0, one := 1, neg := fun x => -x, inv := fun x => 1.0 / x } :=
  { eigenvalue := 2.0, size := 3 }
#eval testJordanBlock.eigenvalue
#eval testJordanBlock.size

/-! ## Core.Basic: Spectral Theorem Statement -/

#eval "── Core.Basic: Spectral theorem statement ──"
#check spectralTheoremSelfAdjoint
#check polarDecomposition
#check courrantFischer
#check gershgorinTheorem

/-! ## Core.Basic: SVD -/

#eval "── Core.Basic: SVD structure ──"
#check SVD

/-! ## Core.Basic: Canonical Forms -/

#eval "── Core.Basic: JordanCanonicalForm and RationalCanonicalForm ──"
#check JordanCanonicalForm
#check RationalCanonicalForm
#check CompanionMatrix

/-! ## Core.Objects: Object instances -/

#eval "── Core.Objects: Object registrations ──"
#check spectralTheory
#check jordanBlockObj
#check companionMatrixObj

/-! ## Morphisms: Similarity -/

#eval "── Morphisms: Similarity ──"
#check Similarity
#check UnitaryEquivalence

/-! ## Constructions: BlockDiagonal -/

#eval "── Constructions: BlockDiagonal ──"
#check BlockDiagonal

/-! ## Constructions: InvariantSubspace -/

#eval "── Constructions: InvariantSubspace and Eigenspace ──"
#check InvariantSubspace
#check Eigenspace
#check GeneralizedEigenspace

/-! ## Properties: Invariants -/

#eval "── Properties: Invariants ──"
#check trace
#check detOperator
#check characteristicPoly
#check minimalPoly

/-! ## Theorems: Basic -/

#eval "── Theorems: Basic spectral theorems ──"
#check realSpectralTheorem
#check complexSpectralTheorem
#check jordanDecomposition

/-! ## Theorems: Classification -/

#eval "── Theorems: Classification ──"
#check classificationComplex
#check classificationReal
#check sylvesterLawOfInertia

/-! ## Examples: Standard -/

#eval "── Examples: Standard ──"
#check identityOperatorExample
#check jordanBlockExample
#check nilpotentExample

#eval "══ ALL MINI-SPECTRAL-CANONICAL SMOKE TESTS PASSED ══"
