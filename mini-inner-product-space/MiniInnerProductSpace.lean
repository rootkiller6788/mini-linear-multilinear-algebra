/-
# MiniInnerProductSpace
Root module for the inner product space sub-package.
Re-exports all sub-packages for convenience.

Sub-packages:
- Core: InnerProduct, Norm, Orthogonality, Gram-Schmidt, Adjoint
- Morphisms: IsometricMap, InnerProductIso, Equivalence
- Constructions: Products, Subobjects, Quotients, Universal
- Properties: Invariants, Preservation, ClassificationData
- Theorems: Basic, UniversalProperties, Classification, Main
- Examples: Standard, Counterexamples
- Bridges: ToAlgebra, ToTopology, ToGeometry, ToComputation
-/

import MiniInnerProductSpace.Core.Basic
import MiniInnerProductSpace.Core.Objects
import MiniInnerProductSpace.Core.Laws
import MiniInnerProductSpace.Morphisms.Hom
import MiniInnerProductSpace.Morphisms.Iso
import MiniInnerProductSpace.Morphisms.Equivalence
import MiniInnerProductSpace.Constructions.Products
import MiniInnerProductSpace.Constructions.Universal
import MiniInnerProductSpace.Constructions.Subobjects
import MiniInnerProductSpace.Constructions.Quotients
import MiniInnerProductSpace.Properties.Invariants
import MiniInnerProductSpace.Properties.Preservation
import MiniInnerProductSpace.Properties.ClassificationData
import MiniInnerProductSpace.Theorems.Basic
import MiniInnerProductSpace.Theorems.UniversalProperties
import MiniInnerProductSpace.Theorems.Classification
import MiniInnerProductSpace.Theorems.Main
import MiniInnerProductSpace.Examples.Standard
import MiniInnerProductSpace.Examples.Counterexamples
import MiniInnerProductSpace.Bridges.ToAlgebra
import MiniInnerProductSpace.Bridges.ToTopology
import MiniInnerProductSpace.Bridges.ToGeometry
import MiniInnerProductSpace.Bridges.ToComputation