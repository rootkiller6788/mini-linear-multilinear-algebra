# MiniInnerProductSpace Documentation

## Overview

MiniInnerProductSpace is the inner product space sub-package of
mini-everything-math. It provides formal definitions and theorems for:

- **Inner Products**: bilinear/Hermitian positive-definite forms
- **Norms**: norms induced by inner products
- **Orthogonality**: orthogonal vectors, orthogonal complements
- **Orthonormal Bases**: existence via Gram-Schmidt
- **Adjoint Operators**: Hermitian conjugate
- **Self-Adjoint / Unitary Operators**: key operator classes
- **Orthogonal Projections**: closest-point projections

## Package Structure

```
mini-inner-product-space/
|-- lakefile.lean
|-- lean-toolchain
|-- Main.lean
|-- MiniInnerProductSpace.lean
|-- README.md
|-- MiniInnerProductSpace/
|   |-- Core/
|   |   |-- Basic.lean        # InnerProduct, Norm, Orthogonality, Gram-Schmidt, Adjoint
|   |   |-- Objects.lean      # InnerProductSpaceTheory, Euclidean space, Hilbert space
|   |   |-- Laws.lean         # Cauchy-Schwarz, Triangle, Parallelogram, Bessel
|   |-- Morphisms/
|   |   |-- Hom.lean          # Isometric maps
|   |   |-- Iso.lean          # Inner product space isomorphisms
|   |   |-- Equivalence.lean  # Equivalence of inner product spaces
|   |-- Constructions/
|   |   |-- Products.lean     # Product inner product, orthogonal direct sum
|   |   |-- Universal.lean    # Universal properties
|   |   |-- Subobjects.lean   # Subspaces with induced inner product
|   |   |-- Quotients.lean    # Quotient inner product spaces
|   |-- Properties/
|   |   |-- Invariants.lean         # Dimension, signature, Gram determinant
|   |   |-- Preservation.lean       # Norm/or orthogonality/distance preservation
|   |   |-- ClassificationData.lean # Definiteness, Sylvester classification
|   |-- Theorems/
|   |   |-- Basic.lean              # Cauchy-Schwarz, Riesz, Spectral, Projection
|   |   |-- UniversalProperties.lean # Completion, dual, orthogonal group
|   |   |-- Classification.lean     # Sylvester's law, classification theorems
|   |   |-- Main.lean              # Structure theorem
|   |-- Examples/
|   |   |-- Standard.lean      # Euclidean, Hermitian, L^2, Frobenius
|   |   |-- Counterexamples.lean # Non-finite dim, incomplete, no-adjoint
|   |-- Bridges/
|       |-- ToAlgebra.lean      # Quadratic forms, C*-algebras, Clifford algebras
|       |-- ToTopology.lean     # Hilbert spaces, norm topologies
|       |-- ToGeometry.lean     # Angles, Gram matrix, reflections
|       |-- ToComputation.lean  # Gram-Schmidt algorithm, QR, least squares
|-- Test/
|   |-- Smoke.lean
|   |-- Basic.lean
|   |-- Properties.lean
|   |-- Examples.lean
|-- Benchmark/
|   |-- Basic.lean
|   |-- Core.lean
|   |-- Comparison.lean
|-- Computation/
|   |-- notebooks/
|   |   |-- exploration.ipynb
|   |   |-- verification.ipynb
|   |-- python/
|   |   |-- helper.py
|   |-- sage/
|       |-- verify.sage
|-- scripts/
|   |-- build.sh
|   |-- run.sh
|   |-- verify.sh
|-- docs/
    |-- index.md
    |-- api.md
    |-- guide.md
```

## Key Definitions

### InnerProduct

```lean
structure InnerProduct (F : Field) (V : VectorSpace F) where
  ip : V.V -> V.V -> F.carrier
  conjugateSym : forall (x y : V.V), ip x y = ip y x
  linearFirst : forall (x y z : V.V) (a : F.carrier),
    ip (V.add (V.smul a x) y) z = F.add (F.mul a (ip x z)) (ip y z)
  positiveDefinite : forall (x : V.V), x != V.zero -> ip x x != F.zero
```

### OrthonormalBasis

```lean
structure OrthonormalBasis (F : Field) (V : VectorSpace F) (IP : InnerProduct F V) where
  basis : Basis F V
  orthonormal : forall (b1 b2 : V.V), b1 in basis.basisSet -> b2 in basis.basisSet ->
    IP.ip b1 b2 = if b1 = b2 then F.one else F.zero
```

## Dependencies

- `mini-object-kernel` -- Object typeclass interface
- `mini-vector-space-core` -- Vector spaces and fields
- `mini-linear-transformation` -- Linear maps

## Quick Start

```bash
cd mini-inner-product-space
lake build
lake env lean --run Main.lean
```

## Theorems

1. **Cauchy-Schwarz**: |<x,y>| <= ||x|| * ||y||
2. **Triangle Inequality**: ||x + y|| <= ||x|| + ||y||
3. **Parallelogram Law**: ||x+y||^2 + ||x-y||^2 = 2(||x||^2 + ||y||^2)
4. **Gram-Schmidt**: Every finite-dim inner product space has an orthonormal basis
5. **Riesz Representation**: V is isomorphic to V* via the inner product
6. **Spectral Theorem**: Self-adjoint operators have orthonormal eigenbasis
7. **Orthogonal Projection**: Closest-point projection exists and is unique
8. **Sylvester's Law**: Signature of a real inner product is invariant
