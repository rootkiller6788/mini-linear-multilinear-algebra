/-
# MiniVectorSpaceCore

The vector space sub-package — defines Field, VectorSpace,
Basis, dimension, linear maps, and bridges to algebra,
topology, geometry, and computation.

## Sub-packages
- `Core`         — Field, VectorSpace, Basis, dimension, F^n, Object instance, Laws
- `Morphisms`    — LinearMap, LinearIso, Equivalence
- `Constructions` — Products, Subobjects, Quotients, Universal
- `Properties`   — Invariants, Preservation, ClassificationData
- `Theorems`     — Basic, UniversalProperties, Classification, Main
- `Examples`     — Standard, Counterexamples
- `Bridges`      — ToAlgebra, ToTopology, ToGeometry, ToComputation
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Core.Objects
import MiniVectorSpaceCore.Core.Laws
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Morphisms.Equivalence
import MiniVectorSpaceCore.Constructions.Products
import MiniVectorSpaceCore.Constructions.Universal
import MiniVectorSpaceCore.Constructions.Subobjects
import MiniVectorSpaceCore.Constructions.Quotients
import MiniVectorSpaceCore.Properties.Invariants
import MiniVectorSpaceCore.Properties.Preservation
import MiniVectorSpaceCore.Properties.ClassificationData
import MiniVectorSpaceCore.Theorems.Basic
import MiniVectorSpaceCore.Theorems.UniversalProperties
import MiniVectorSpaceCore.Theorems.Classification
import MiniVectorSpaceCore.Theorems.Main
import MiniVectorSpaceCore.Examples.Standard
import MiniVectorSpaceCore.Examples.Counterexamples
import MiniVectorSpaceCore.Bridges.ToAlgebra
import MiniVectorSpaceCore.Bridges.ToTopology
import MiniVectorSpaceCore.Bridges.ToGeometry
import MiniVectorSpaceCore.Bridges.ToComputation
import MiniVectorSpaceCore.Dual.DualSpace
import MiniVectorSpaceCore.Decompositions.DirectSumDecomp
