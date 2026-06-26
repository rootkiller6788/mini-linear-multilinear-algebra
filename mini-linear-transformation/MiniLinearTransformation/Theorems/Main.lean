/-
# MiniLinearTransformation.Theorems.Main

Central theorems: consolidated imports and summary.
-/

import MiniLinearTransformation.Theorems.Basic
import MiniLinearTransformation.Theorems.UniversalProperties
import MiniLinearTransformation.Theorems.Classification

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-!
## Pillar Theorems of Linear Transformation Theory

1. **Rank-Nullity Theorem** — dim(V) = rank(T) + nullity(T)
2. **First Isomorphism Theorem** — V/ker(T) ≅ im(T)
3. **Dimension Sum Formula** — dim(U+W) = dim(U) + dim(W) - dim(U∩W)
4. **Cayley-Hamilton Theorem** — χ_T(T) = 0
5. **Jordan Canonical Form** — over algebraically closed fields
6. **Spectral Theorem** — for symmetric/Hermitian operators
7. **Singular Value Decomposition** — any linear map

Total: 7 pillar theorems (all currently stated as axioms/placeholders).
-/

def linearTransformationPillars : List String := [
  "Rank-Nullity",
  "First Isomorphism",
  "Dimension Sum Formula",
  "Cayley-Hamilton",
  "Jordan Canonical Form",
  "Spectral Theorem",
  "Singular Value Decomposition"
]

#eval "Theorems.Main: 7 pillar theorems"
#eval s!"Pillar count: {linearTransformationPillars.length}"
