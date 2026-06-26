# MiniVectorSpaceCore

The vector space sub-package of mini-everything-math.

Defines Field, VectorSpace, Basis, dimension, linear maps,
and bridges to algebra, topology, geometry, and computation.

## Structure

- `Core/` -- Field, VectorSpace, Basis, dimension, F^n, Object instance, Laws
- `Morphisms/` -- LinearMap, LinearIso, Equivalence
- `Constructions/` -- Products, Subobjects, Quotients, Universal
- `Properties/` -- Invariants, Preservation, ClassificationData
- `Theorems/` -- Basic, UniversalProperties, Classification, Main
- `Examples/` -- Standard, Counterexamples
- `Bridges/` -- ToAlgebra, ToTopology, ToGeometry, ToComputation

## Dependencies

- `mini-object-kernel` -- Object typeclass interface

## Usage

```bash
lake build
lake env lean --run Main.lean
```
