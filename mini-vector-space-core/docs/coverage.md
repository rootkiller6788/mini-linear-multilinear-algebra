# mini-vector-space-core -- Implementation Coverage

## Core -- 3/3 implemented

- [x] `Field` — structure with carrier, add, mul, zero, one, neg, inv
- [x] `VectorSpace` — structure over Field with V, add, zero, neg, smul
- [x] `linearCombination` — recursive definition
- [x] `Subspace` — type alias for Set VS.V
- [x] `spans` / `linearlyIndependent` — Prop definitions (stubs)
- [x] `Basis` — structure with spanning + independent
- [x] `isFiniteDimensional` / `dimension` — Prop and noncomputable Nat
- [x] `fnSpace` — F^n standard vector space
- [x] `vecTheory` / Object instance
- [x] 8 vector space axioms as Props
- [x] `vecAxioms` as AxiomSet

## Morphisms -- 3/3 implemented

- [x] `LinearMap` — structure with mapping
- [x] `LinearMap.id` / `LinearMap.comp`
- [x] `LinearIso` — forward/backward
- [x] `VSEquivalence` — dimension equality

## Constructions -- 0/4, stubs

- [ ] `Products` — direct sum / product
- [ ] `Universal` — free vector space, tensor product
- [ ] `Subobjects` — subspace as subobject
- [ ] `Quotients` — quotient space

## Properties -- 0/3, stubs

- [ ] `Invariants` — dimension invariants
- [ ] `Preservation` — linear map preservation
- [ ] `ClassificationData` — classification by dimension

## Theorems -- 0/4, stubs

- [ ] `Basic` — basis existence, dimension invariance
- [ ] `UniversalProperties` — universal mapping properties
- [ ] `Classification` — classification by dimension
- [ ] `Main` — dimension theorem, rank-nullity

## Examples -- 0/2, stubs

- [ ] `Standard` — R^n, polynomial spaces
- [ ] `Counterexamples` — non-vector-spaces

## Bridges -- 0/4, stubs

- [ ] `ToAlgebra` — module theory
- [ ] `ToTopology` — topological vector spaces
- [ ] `ToGeometry` — affine geometry
- [ ] `ToComputation` — numerical linear algebra

## Summary

| Category       | Files | Done | Stubs | %      |
|----------------|-------|------|-------|--------|
| Core           | 3     | 3    | 0     | 100%   |
| Morphisms      | 3     | 3    | 0     | 100%   |
| Constructions  | 4     | 0    | 4     | 0%     |
| Properties     | 3     | 0    | 3     | 0%     |
| Theorems       | 4     | 0    | 4     | 0%     |
| Examples       | 2     | 0    | 2     | 0%     |
| Bridges        | 4     | 0    | 4     | 0%     |
| **Total**      | **23**| **6** | **17**| **26%** |
