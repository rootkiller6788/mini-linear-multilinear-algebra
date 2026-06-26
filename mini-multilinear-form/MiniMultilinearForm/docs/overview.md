# MiniMultilinearForm Overview

A Lean 4 package for bilinear and multilinear forms, tensor products, and their applications.

## Package Structure

- **Core/Basic** -- BilinearMap, BilinearForm, MultilinearMap, MultilinearForm definitions
- **Bilinear/** -- Bilinear map operations, matrix representation, quadratic forms
- **Symmetric/** -- Symmetric bilinear forms, diagonalization, signature, Witt theory
- **Alternating/** -- Alternating forms, determinant, exterior powers
- **Multilinear/** -- Multilinear form operations, tensors, symmetrization/alternation
- **TensorProduct/** -- Tensor product of vector spaces, universal property
- **Applications/** -- Geometry (Riemannian metrics, symplectic forms), Physics (Lorentzian, EM)
- **Functorial/** -- Pullback, change of basis, duality
- **Examples/** -- Dot product, cross product, determinant, Killing form, Pfaffian

## Dependencies

- mini-vector-space-core
- mini-linear-transformation

## Usage

```lean
import MiniMultilinearForm
```
