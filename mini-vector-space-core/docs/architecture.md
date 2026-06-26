# mini-vector-space-core -- Architecture

## Overview

The vector space package defines the notions of Field, VectorSpace, Basis,
dimension, and linear maps, proving fundamental results about vector spaces.

## Dependency Graph

```
mini-vector-space-core
├── mini-object-kernel (../../0. mini-math-kernel/mini-object-kernel)
│   └── (Object typeclass, Axioms, Formulas)
```

## Module Map

```
MiniVectorSpaceCore/
├── Core/
│   ├── Basic.lean              — Field, VectorSpace, Basis, dimension, F^n, linearCombination
│   ├── Objects.lean            — Object instances, TheoryName registration
│   └── Laws.lean               — Vector space axioms (8 axioms as Props + AxiomSet)
├── Morphisms/
│   ├── Hom.lean                — LinearMap, id, comp
│   ├── Iso.lean                — LinearIso (forward/backward)
│   └── Equivalence.lean        — VSEquivalence (dimension equality)
├── Constructions/
│   ├── Products.lean           — Direct sum / product (stub)
│   ├── Subobjects.lean         — Subspaces as subobjects (stub)
│   ├── Quotients.lean          — Quotient spaces (stub)
│   └── Universal.lean          — Free vector space, tensor products (stub)
├── Properties/
│   ├── Invariants.lean         — Dimension invariants (stub)
│   ├── Preservation.lean       — What linear maps preserve (stub)
│   └── ClassificationData.lean — Classification by dimension (stub)
├── Theorems/
│   ├── Basic.lean              — Basis existence, dimension invariance (stub)
│   ├── UniversalProperties.lean — Universal mapping properties (stub)
│   ├── Classification.lean     — Classification by dimension (stub)
│   └── Main.lean               — Dimension theorem, rank-nullity (stub)
├── Examples/
│   ├── Standard.lean           — R^n, polynomial spaces (stub)
│   └── Counterexamples.lean    — Non-vector-spaces, dependent sets (stub)
└── Bridges/
    ├── ToAlgebra.lean           — Bridge to module theory (stub)
    ├── ToTopology.lean           — Bridge to topological vector spaces (stub)
    ├── ToGeometry.lean           — Bridge to affine geometry (stub)
    └── ToComputation.lean        — Bridge to numerical linear algebra (stub)
```
