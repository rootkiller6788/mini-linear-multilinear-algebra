/-
# MiniSpectralCanonical

The spectral theorems and canonical forms sub-package --
defines spectral theorem, Jordan canonical form,
rational canonical form, SVD, polar decomposition,
and bridges to algebra, topology, geometry, and computation.

## Sub-packages
- `Core`         -- Spectral Theorem, Jordan/Rational canonical forms, SVD, Polar, spectral radius
- `Morphisms`    -- Similarity, unitary equivalence, congruence
- `Constructions` -- Jordan blocks, companion matrices, block diagonalization
- `Properties`   -- Spectral invariants, trace, determinant, characteristic polynomial
- `Theorems`     -- Main spectral theorems, canonical form theorems, classification
- `Examples`     -- Standard examples, counterexamples
- `Bridges`      -- ToAlgebra, ToTopology, ToGeometry, ToComputation
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Core.Objects
import MiniSpectralCanonical.Core.Laws
import MiniSpectralCanonical.Morphisms.Hom
import MiniSpectralCanonical.Morphisms.Iso
import MiniSpectralCanonical.Morphisms.Equivalence
import MiniSpectralCanonical.Constructions.Products
import MiniSpectralCanonical.Constructions.Universal
import MiniSpectralCanonical.Constructions.Subobjects
import MiniSpectralCanonical.Constructions.Quotients
import MiniSpectralCanonical.Properties.Invariants
import MiniSpectralCanonical.Properties.Preservation
import MiniSpectralCanonical.Properties.ClassificationData
import MiniSpectralCanonical.Theorems.Basic
import MiniSpectralCanonical.Theorems.UniversalProperties
import MiniSpectralCanonical.Theorems.Classification
import MiniSpectralCanonical.Theorems.Main
import MiniSpectralCanonical.Examples.Standard
import MiniSpectralCanonical.Examples.Counterexamples
import MiniSpectralCanonical.Bridges.ToAlgebra
import MiniSpectralCanonical.Bridges.ToTopology
import MiniSpectralCanonical.Bridges.ToGeometry
import MiniSpectralCanonical.Bridges.ToComputation
