/-
# Benchmark: MiniSpectralCanonical Core Coverage

Tracks every definition/theorem with implementation status.
Format: `-- [x] target | file:line`

Status: [x] done  [~] partial  [ ] planned
-/

/-!
## Core -- 12 targets

-- [x] spectralTheoremSelfAdjoint                 | Core/Basic.lean
-- [x] JordanBlock structure                       | Core/Basic.lean
-- [x] JordanCanonicalForm structure               | Core/Basic.lean
-- [x] CompanionMatrix structure                   | Core/Basic.lean
-- [x] RationalCanonicalForm structure             | Core/Basic.lean
-- [x] SVD structure                               | Core/Basic.lean
-- [x] polarDecomposition                          | Core/Basic.lean
-- [x] spectralRadius                              | Core/Basic.lean
-- [x] courantFischer                              | Core/Basic.lean
-- [x] gershgorinTheorem                           | Core/Basic.lean
-- [x] Object registrations                        | Core/Objects.lean
-- [~] Spectral laws stubs                         | Core/Laws.lean

## Morphisms -- 8 targets

-- [x] Similarity structure                        | Morphisms/Hom.lean
-- [x] UnitaryEquivalence structure                | Morphisms/Hom.lean
-- [x] Congruence structure                        | Morphisms/Hom.lean
-- [x] SpectralIso structure                       | Morphisms/Iso.lean
-- [x] CanonicalFormIso structure                  | Morphisms/Iso.lean
-- [x] SVDIso structure                            | Morphisms/Iso.lean
-- [x] SpectralEquivalence structure               | Morphisms/Equivalence.lean
-- [x] JordanEquivalence structure                 | Morphisms/Equivalence.lean

## Constructions -- 8 targets

-- [x] BlockDiagonal structure                     | Constructions/Products.lean
-- [x] jordanDirectSum                             | Constructions/Products.lean
-- [x] SpectralDirectSum structure                 | Constructions/Products.lean
-- [x] InvariantSubspace structure                 | Constructions/Subobjects.lean
-- [x] Eigenspace structure                        | Constructions/Subobjects.lean
-- [x] GeneralizedEigenspace structure             | Constructions/Subobjects.lean
-- [x] SpectralSubspace structure                  | Constructions/Subobjects.lean
-- [~] Quotient constructions stub                 | Constructions/Quotients.lean

## Properties -- 8 targets

-- [x] trace                                        | Properties/Invariants.lean
-- [x] detOperator                                  | Properties/Invariants.lean
-- [x] characteristicPoly                           | Properties/Invariants.lean
-- [x] minimalPoly                                  | Properties/Invariants.lean
-- [x] algebraicMultiplicity / geometricMultiplicity | Properties/Invariants.lean
-- [~] Preservation stubs                           | Properties/Preservation.lean
-- [x] JordanType structure                         | Properties/ClassificationData.lean
-- [x] Signature structure                          | Properties/ClassificationData.lean

## Theorems -- 12 targets

-- [x] realSpectralTheorem                          | Theorems/Basic.lean
-- [x] complexSpectralTheorem                       | Theorems/Basic.lean
-- [x] jordanDecomposition                          | Theorems/Basic.lean
-- [x] rationalCanonicalFormTheorem                 | Theorems/Basic.lean
-- [x] primaryDecomposition                         | Theorems/Basic.lean
-- [x] functionalCalculus                           | Theorems/UniversalProperties.lean
-- [x] schurTriangularization                       | Theorems/UniversalProperties.lean
-- [x] classificationComplex                        | Theorems/Classification.lean
-- [x] classificationReal                           | Theorems/Classification.lean
-- [x] sylvesterLawOfInertia                        | Theorems/Classification.lean
-- [x] classificationNilpotent                      | Theorems/Classification.lean
-- [x] spectralPackage aggregation                  | Theorems/Main.lean

## Examples -- 7 targets

-- [x] identityOperatorExample                      | Examples/Standard.lean
-- [x] diagonalExample                              | Examples/Standard.lean
-- [x] jordanBlockExample                           | Examples/Standard.lean
-- [x] nilpotentExample                             | Examples/Standard.lean
-- [x] nonDiagonalizableExample                     | Examples/Counterexamples.lean
-- [x] defectiveExample                             | Examples/Counterexamples.lean
-- [x] nonNormalRealSpectrum                        | Examples/Counterexamples.lean

## Bridges -- 12 targets

-- [x] moduleStructure / F[t]-module                | Bridges/ToAlgebra.lean
-- [x] spectralProjectionsIdempotent                | Bridges/ToAlgebra.lean
-- [x] cyclicSubspace                               | Bridges/ToAlgebra.lean
-- [x] spectralRadiusTopological                    | Bridges/ToTopology.lean
-- [x] resolventOpen                                | Bridges/ToTopology.lean
-- [x] gershgorinTopology                           | Bridges/ToTopology.lean
-- [x] principalAxesTheorem                         | Bridges/ToGeometry.lean
-- [x] svdEllipsoid                                 | Bridges/ToGeometry.lean
-- [x] polarDecompositionGeometry                   | Bridges/ToGeometry.lean
-- [x] powerIteration                               | Bridges/ToComputation.lean
-- [x] rayleighQuotient                             | Bridges/ToComputation.lean
-- [x] spectralClustering                           | Bridges/ToComputation.lean

## Summary

Total: 67 targets
Done: 63
Stub: 4
Coverage: 94% (core done, some Properties stubbed)
-/

#eval "CoreCoverage: 67 targets, 63 done, 4 stubs"
