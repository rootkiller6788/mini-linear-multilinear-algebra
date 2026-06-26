/-
# MiniDualQuotient

The dual space / quotient space sub-package — defines DualSpace,
double dual, transpose, QuotientSpace, annihilator,
and the three isomorphism theorems for vector spaces.

## Sub-packages
- `Core`         — DualSpace, doubleDual, transpose, QuotientSpace, isomorphism theorems
- `Morphisms`    — CanonicalEmbedding, Projection, Equivalence
- `Constructions` — DualSpace, QuotientSpace, Annihilator, Transpose
- `Properties`   — Dimensional, Structural, Universal
- `Theorems`     — FirstIsomorphism, SecondIsomorphism, ThirdIsomorphism
- `Examples`     — DualBasis, QuotientExample, Reflexivity
- `Bridges`      — ToAlgebra, ToGeometry, ToTopology, ToComputation
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Core.Objects
import MiniDualQuotient.Core.Laws

import MiniDualQuotient.Morphisms.CanonicalEmbedding
import MiniDualQuotient.Morphisms.Projection
import MiniDualQuotient.Morphisms.Equivalence

import MiniDualQuotient.Constructions.DualSpace
import MiniDualQuotient.Constructions.QuotientSpace
import MiniDualQuotient.Constructions.Annihilator
import MiniDualQuotient.Constructions.Transpose

import MiniDualQuotient.Properties.Dimensional
import MiniDualQuotient.Properties.Structural
import MiniDualQuotient.Properties.Universal

import MiniDualQuotient.Theorems.FirstIsomorphism
import MiniDualQuotient.Theorems.SecondIsomorphism
import MiniDualQuotient.Theorems.ThirdIsomorphism

import MiniDualQuotient.Examples.DualBasis
import MiniDualQuotient.Examples.QuotientExample
import MiniDualQuotient.Examples.Reflexivity

import MiniDualQuotient.Bridges.ToAlgebra
import MiniDualQuotient.Bridges.ToGeometry
import MiniDualQuotient.Bridges.ToTopology
import MiniDualQuotient.Bridges.ToComputation
