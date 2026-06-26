/-
# MiniLinearTransformation

Linear transformations between vector spaces: linear maps, kernel,
image, rank, nullity, isomorphisms, composition.

This sub-package extends mini-vector-space-core with the theory
of linear transformations.

## Sub-packages
- `Core`         — LinearMap, identity, composition, zero, kernel, image, rank, nullity, Laws
- `Morphisms`    — LinearIsomorphism, Equivalence
- `Constructions` — Kernel subspace, image subspace, quotient by kernel, universal property
- `Properties`   — Invariants (rank, nullity), Preservation, ClassificationData
- `Theorems`     — Rank-Nullity, UniversalProperties, Classification, Main
- `Examples`     — Standard linear transformations, counterexamples
- `Bridges`      — ToAlgebra, ToTopology, ToGeometry, ToComputation
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Objects
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso
import MiniLinearTransformation.Morphisms.Equivalence
import MiniLinearTransformation.Constructions.Subobjects
import MiniLinearTransformation.Constructions.Quotients
import MiniLinearTransformation.Constructions.Products
import MiniLinearTransformation.Constructions.Universal
import MiniLinearTransformation.Properties.Invariants
import MiniLinearTransformation.Properties.Preservation
import MiniLinearTransformation.Properties.ClassificationData
import MiniLinearTransformation.Theorems.Basic
import MiniLinearTransformation.Theorems.UniversalProperties
import MiniLinearTransformation.Theorems.Classification
import MiniLinearTransformation.Theorems.Main
import MiniLinearTransformation.Examples.Standard
import MiniLinearTransformation.Examples.Counterexamples
import MiniLinearTransformation.Bridges.ToAlgebra
import MiniLinearTransformation.Bridges.ToTopology
import MiniLinearTransformation.Bridges.ToGeometry
import MiniLinearTransformation.Bridges.ToComputation
