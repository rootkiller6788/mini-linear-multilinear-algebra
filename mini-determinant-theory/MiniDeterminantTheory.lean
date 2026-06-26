/-
# MiniDeterminantTheory

The determinant theory sub-package -- defines determinants,
characteristic polynomials, eigenvalues, eigenvectors,
diagonalizability, trace, and the Cayley-Hamilton theorem.

## Sub-packages
- `Core`         -- Determinant, eigenvalues, charPoly, trace
- `Morphisms`    -- Determinant-preserving maps, similarity
- `Constructions` -- Exterior powers, wedge products, Laplace expansion
- `Properties`   -- Invariants, Preservation, ClassificationData
- `Theorems`     -- Basic, UniversalProperties, Classification, Main
- `Examples`     -- Standard, Counterexamples
- `Bridges`      -- ToAlgebra, ToTopology, ToGeometry, ToComputation
-/

import MiniDeterminantTheory.Core.Basic
import MiniDeterminantTheory.Core.Objects
import MiniDeterminantTheory.Core.Laws
import MiniDeterminantTheory.Morphisms.Hom
import MiniDeterminantTheory.Morphisms.Iso
import MiniDeterminantTheory.Morphisms.Equivalence
import MiniDeterminantTheory.Constructions.Products
import MiniDeterminantTheory.Constructions.Universal
import MiniDeterminantTheory.Constructions.Subobjects
import MiniDeterminantTheory.Constructions.Quotients
import MiniDeterminantTheory.Properties.Invariants
import MiniDeterminantTheory.Properties.Preservation
import MiniDeterminantTheory.Properties.ClassificationData
import MiniDeterminantTheory.Theorems.Basic
import MiniDeterminantTheory.Theorems.UniversalProperties
import MiniDeterminantTheory.Theorems.Classification
import MiniDeterminantTheory.Theorems.Main
import MiniDeterminantTheory.Examples.Standard
import MiniDeterminantTheory.Examples.Counterexamples
import MiniDeterminantTheory.Bridges.ToAlgebra
import MiniDeterminantTheory.Bridges.ToTopology
import MiniDeterminantTheory.Bridges.ToGeometry
import MiniDeterminantTheory.Bridges.ToComputation
