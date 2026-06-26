/-
# Regression Tests -- MiniSpectralCanonical

Regression tests ensuring no breaking changes.
-/

import MiniSpectralCanonical

open MiniSpectralCanonical

/-! ## Basic Definitions Exist -/

-- Verify JordanBlock type is usable
#check JordanBlock

-- Verify canonical form structures
#check JordanCanonicalForm
#check RationalCanonicalForm
#check CompanionMatrix

-- Verify SVD
#check SVD

-- Verify spectral theorem statements
#check spectralTheoremSelfAdjoint
#check polarDecomposition
#check spectralRadius
#check courantFischer
#check gershgorinTheorem

-- Verify Morphisms
#check Similarity
#check UnitaryEquivalence
#check Congruence

-- Verify Constructions
#check BlockDiagonal
#check InvariantSubspace
#check Eigenspace
#check GeneralizedEigenspace
#check SpectralSubspace

-- Verify Properties
#check trace
#check detOperator
#check characteristicPoly
#check minimalPoly
#check algebraicMultiplicity
#check geometricMultiplicity

-- Verify Classification data
#check JordanType
#check SpectralPartition
#check Signature
#check segreCharacteristic

-- Verify Theorems
#check realSpectralTheorem
#check complexSpectralTheorem
#check jordanDecomposition
#check rationalCanonicalFormTheorem
#check primaryDecomposition
#check schurTriangularization
#check classificationComplex
#check classificationReal
#check sylvesterLawOfInertia

-- Verify Examples
#check identityOperatorExample
#check diagonalExample
#check jordanBlockExample
#check nilpotentExample

-- Verify Bridges
#check cyclicSubspace
#check spectralRadiusTopological
#check principalAxesTheorem
#check svdEllipsoid
#check powerIteration
#check rayleighQuotient

/-! ## All regression checks passed -/

#eval "Regression checks complete."
