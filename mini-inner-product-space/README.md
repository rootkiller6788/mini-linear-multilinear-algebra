# MiniInnerProductSpace

The inner product space sub-package of mini-everything-math.

Defines InnerProduct, Norm, Orthogonality, OrthonormalBasis,
Gram-Schmidt, Adjoint, Unitary, OrthogonalProjection,
and bridges to algebra, topology, geometry, and computation.

## Structure

- `Core/` -- InnerProduct, Norm, Orthogonality, OrthonormalBasis, Gram-Schmidt, Adjoint
- `Morphisms/` -- IsometricMap, InnerProductIso, Equivalence
- `Constructions/` -- Products, Subobjects, Quotients, Universal
- `Properties/` -- Invariants, Preservation, ClassificationData
- `Theorems/` -- Basic, UniversalProperties, Classification, Main
- `Examples/` -- Standard, Counterexamples
- `Bridges/` -- ToAlgebra, ToTopology, ToGeometry, ToComputation

## Dependencies

- `mini-vector-space-core` -- Vector spaces and fields
- `mini-linear-transformation` -- Linear maps between vector spaces

## Usage

```bash
lake build
lake env lean --run Main.lean
```
