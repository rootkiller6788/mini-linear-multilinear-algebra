# MiniDeterminantTheory

The determinant theory sub-package of mini-everything-math.

Defines determinants, characteristic polynomials, eigenvalues,
eigenvectors, diagonalizability, trace, and the Cayley-Hamilton theorem.

## Structure

- `Core/` -- Determinant, eigenvalues, characteristic polynomial, trace
- `Morphisms/` -- DeterminantHom, areSimilar, detEquivalent, spectrumEquivalent
- `Constructions/` -- Exterior powers, wedge product, Laplace expansion
- `Properties/` -- Invariants, Preservation, ClassificationData
- `Theorems/` -- Basic, UniversalProperties, Classification, Main
- `Examples/` -- Standard, Counterexamples
- `Bridges/` -- ToAlgebra, ToTopology, ToGeometry, ToComputation

## Dependencies

- `mini-vector-space-core` -- Vector space and field definitions
- `mini-linear-transformation` -- Linear maps and operators
- `mini-multilinear-form` -- Multilinear form definitions

## Usage

```bash
lake build
lake env lean --run Main.lean
```
