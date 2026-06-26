# MiniSpectralCanonical

The spectral theorems and canonical forms sub-package of mini-everything-math.

Defines spectral theorem for self-adjoint operators, Jordan canonical form,
rational canonical form, SVD, polar decomposition, spectral radius,
Courant-Fischer min-max theorem, and Gershgorin circle theorem,
plus bridges to algebra, topology, geometry, and computation.

## Structure

- `Core/` -- Spectral theorem, Jordan/Rational canonical forms, SVD, Polar, spectral radius
- `Morphisms/` -- Similarity, unitary equivalence, congruence
- `Constructions/` -- Jordan blocks, companion matrices, block diagonalization
- `Properties/` -- Spectral invariants, trace, determinant, characteristic polynomial
- `Theorems/` -- Main spectral theorems, canonical form theorems, classification
- `Examples/` -- Standard examples, counterexamples
- `Bridges/` -- ToAlgebra, ToTopology, ToGeometry, ToComputation

## Dependencies

- `mini-vector-space-core` -- VectorSpace, Basis, dimension
- `mini-linear-transformation` -- Linear maps, eigenvalues/vectors
- `mini-determinant-theory` -- Determinant, characteristic polynomial
- `mini-inner-product-space` -- Inner products, self-adjoint, unitary operators

## Usage

```bash
lake build
lake env lean --run Main.lean
```
