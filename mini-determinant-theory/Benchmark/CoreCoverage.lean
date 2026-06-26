/-
# Benchmark: MiniDeterminantTheory Core Coverage

Tracks every definition/theorem with implementation status.
Format: `-- [x] target | file:line`

Status: [x] done  [~] partial  [ ] planned
-/

/-!
## Core -- 15 targets

-- [x] determinant definition                         | Core/Basic.lean
-- [x] detIsMultiplicative (statement)                | Core/Basic.lean
-- [x] detOfIdentity (statement)                      | Core/Basic.lean
-- [x] detIsInvertible (statement)                    | Core/Basic.lean
-- [x] Eigenpair structure                            | Core/Basic.lean
-- [x] Polynomial structure                           | Core/Basic.lean
-- [x] charPoly definition                            | Core/Basic.lean
-- [x] isDiagonalizable                               | Core/Basic.lean
-- [x] cayleyHamilton (statement)                     | Core/Basic.lean
-- [x] trace definition                               | Core/Basic.lean
-- [x] traceIsCyclic (statement)                      | Core/Basic.lean
-- [~] Core.Laws stub                                 | Core/Laws.lean
-- [x] Matrix structure                               | Core/Objects.lean
-- [x] registerDeterminantTheory                      | Core/Objects.lean
-- [~] Object instances stub                          | Core/Objects.lean

## Morphisms -- 6 targets

-- [x] DeterminantHom structure                       | Morphisms/Hom.lean
-- [x] DeterminantHom.id                              | Morphisms/Hom.lean
-- [x] DeterminantHom.comp                            | Morphisms/Hom.lean
-- [x] areSimilar definition                          | Morphisms/Iso.lean
-- [x] detEquivalent                                  | Morphisms/Equivalence.lean
-- [x] spectrumEquivalent                             | Morphisms/Equivalence.lean

## Constructions -- 4 targets

-- [x] exteriorPower (conceptual)                     | Constructions/Products.lean
-- [x] wedgeProduct (conceptual)                      | Constructions/Products.lean
-- [x] laplaceExpansion (conceptual)                  | Constructions/Products.lean
-- [~] Universal stub                                 | Constructions/Universal.lean

## Properties -- 3 stubs

-- [~] Invariants stub                                | Properties/Invariants.lean
-- [~] Preservation stub                              | Properties/Preservation.lean
-- [~] ClassificationData stub                        | Properties/ClassificationData.lean

## Theorems -- 4 stubs

-- [~] Basic stub                                     | Theorems/Basic.lean
-- [~] UniversalProperties stub                       | Theorems/UniversalProperties.lean
-- [~] Classification stub                            | Theorems/Classification.lean
-- [~] Main stub                                      | Theorems/Main.lean

## Examples -- 2 targets

-- [x] identityDeterminant / zeroDeterminant          | Examples/Standard.lean
-- [~] Counterexamples stub                           | Examples/Counterexamples.lean

## Bridges -- 4 stubs

-- [~] ToAlgebra stub                                 | Bridges/ToAlgebra.lean
-- [~] ToTopology stub                                | Bridges/ToTopology.lean
-- [~] ToGeometry stub                                | Bridges/ToGeometry.lean
-- [~] ToComputation stub                             | Bridges/ToComputation.lean

## Summary

Total: 38 targets
Done: 21
Stub: 17
Coverage: 55% (core done, expansions stubbed)
-/

#eval "CoreCoverage: 38 targets, 21 done, 17 stubs"
