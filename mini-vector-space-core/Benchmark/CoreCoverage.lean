/-
# Benchmark: MiniVectorSpaceCore Core Coverage

Tracks every definition/theorem with implementation status.
Format: `-- [x] target | file:line`

Status: [x] done  [~] partial  [ ] planned
-/

/-!
## Core — 17 targets

-- [x] Field structure                              | Core/Basic.lean
-- [x] VectorSpace structure                        | Core/Basic.lean
-- [x] VectorSpace helper defs                      | Core/Basic.lean
-- [x] linearCombination def                       | Core/Basic.lean
-- [x] Subspace type def                            | Core/Basic.lean
-- [x] spans / linearlyIndependent                  | Core/Basic.lean
-- [x] Basis structure                              | Core/Basic.lean
-- [x] isFiniteDimensional / dimension             | Core/Basic.lean
-- [x] fnSpace (F^n)                                | Core/Basic.lean
-- [x] Object instance for VectorSpace              | Core/Objects.lean
-- [x] Theory registration                           | Core/Objects.lean
-- [x] 8 vector space axioms as Props               | Core/Laws.lean
-- [x] vecAxioms AxiomSet                           | Core/Laws.lean
-- [~] addAssoc/addComm proofs                      | Core/Laws.lean
-- [~] smulOne/smulAssoc proofs                     | Core/Laws.lean
-- [~] smulAdd/addSmul proofs                       | Core/Laws.lean
-- [~] Field axioms (stubs)                         | Core/Laws.lean

## Morphisms — 5 targets

-- [x] LinearMap structure                          | Morphisms/Hom.lean
-- [x] LinearMap.id                                 | Morphisms/Hom.lean
-- [x] LinearMap.comp                                | Morphisms/Hom.lean
-- [x] LinearIso structure                           | Morphisms/Iso.lean
-- [x] VSEquivalence structure                       | Morphisms/Equivalence.lean

## Constructions — 4 stubs

-- [~] Products stub                                 | Constructions/Products.lean
-- [~] Universal stub                                | Constructions/Universal.lean
-- [~] Subobjects stub                               | Constructions/Subobjects.lean
-- [~] Quotients stub                                | Constructions/Quotients.lean

## Properties — 3 stubs

-- [~] Invariants stub                               | Properties/Invariants.lean
-- [~] Preservation stub                             | Properties/Preservation.lean
-- [~] ClassificationData stub                       | Properties/ClassificationData.lean

## Theorems — 4 stubs

-- [~] Basic stub                                    | Theorems/Basic.lean
-- [~] UniversalProperties stub                      | Theorems/UniversalProperties.lean
-- [~] Classification stub                           | Theorems/Classification.lean
-- [~] Main stub                                     | Theorems/Main.lean

## Examples — 2 stubs

-- [~] Standard stub                                 | Examples/Standard.lean
-- [~] Counterexamples stub                          | Examples/Counterexamples.lean

## Bridges — 4 stubs

-- [~] ToAlgebra stub                                | Bridges/ToAlgebra.lean
-- [~] ToTopology stub                               | Bridges/ToTopology.lean
-- [~] ToGeometry stub                               | Bridges/ToGeometry.lean
-- [~] ToComputation stub                            | Bridges/ToComputation.lean

## Summary

Total: 39 targets
Done: 22
Stub: 17
Coverage: 56% (core done, expansions stubbed)
-/

#eval "CoreCoverage: 39 targets, 22 done, 17 stubs"
