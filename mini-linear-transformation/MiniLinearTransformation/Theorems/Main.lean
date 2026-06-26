/-
# MiniLinearTransformation.Theorems.Main

Central theorems summary: all pillar theorems of linear transformation
theory consolidated. This file serves as the main entry point for
theorems, importing and summarizing all major results.

Knowledge: L1-L9 cross-cutting summary.
-/

import MiniLinearTransformation.Theorems.Basic
import MiniLinearTransformation.Theorems.UniversalProperties
import MiniLinearTransformation.Theorems.Classification

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-!
## Pillar Theorems of Linear Transformation Theory

### Dimension & Structure
1. **Rank-Nullity Theorem** — dim(V) = rank(T) + nullity(T)
2. **First Isomorphism Theorem** — V/ker(T) ≅ im(T)
3. **Dimension Sum Formula** — dim(U+W) = dim(U) + dim(W) - dim(U∩W)

### Polynomial & Spectral
4. **Cayley-Hamilton Theorem** — χ_T(T) = 0
5. **Jordan Canonical Form** — over algebraically closed fields
6. **Rational Canonical Form** — over any field

### Geometry & Analysis
7. **Spectral Theorem (Real)** — symmetric → orthogonally diagonalizable
8. **Spectral Theorem (Complex)** — normal → unitarily diagonalizable
9. **Singular Value Decomposition** — T = UΣV* for any linear map

### Universal
10. **Tensor-Hom Adjunction** — Hom(U⊗V,W) ≅ Hom(U,Hom(V,W))
11. **Double Dual Isomorphism** — V ≅ V** (finite dim)
12. **Quotient Universal Property** — factorization through V/ker(T)

Total: 12 pillar theorems.
-/

def linearTransformationPillars : List String := [
  "Rank-Nullity",
  "First Isomorphism",
  "Dimension Sum Formula",
  "Cayley-Hamilton",
  "Jordan Canonical Form",
  "Rational Canonical Form",
  "Spectral Theorem (Real)",
  "Spectral Theorem (Complex)",
  "Singular Value Decomposition",
  "Tensor-Hom Adjunction",
  "Double Dual Isomorphism",
  "Quotient Universal Property"
]

/-- Categorize pillars by knowledge level. -/
def pillarsByLevel : List (Nat × List String) := [
  (4, ["Rank-Nullity", "First Isomorphism", "Cayley-Hamilton"]),
  (5, ["Jordan Canonical Form", "Rational Canonical Form"]),
  (6, ["Spectral Theorem (Real)", "Spectral Theorem (Complex)", "SVD"]),
  (8, ["Tensor-Hom Adjunction", "Double Dual Isomorphism"])
]

/-- All theorems form a dependency graph (partial order). -/
def theoremDependencies : List (String × List String) := [
  ("Rank-Nullity", []),
  ("First Isomorphism", ["Rank-Nullity"]),
  ("Dimension Sum Formula", ["Rank-Nullity"]),
  ("Cayley-Hamilton", ["Determinant Theory"]),
  ("Jordan Canonical Form", ["Cayley-Hamilton", "Primary Decomposition"]),
  ("Rational Canonical Form", ["Cayley-Hamilton"]),
  ("Spectral Theorem (Real)", ["Inner Product", "Cayley-Hamilton"]),
  ("Spectral Theorem (Complex)", ["Inner Product", "Cayley-Hamilton"]),
  ("SVD", ["Spectral Theorem (Real)", "Polar Decomposition"]),
  ("Tensor-Hom Adjunction", ["Tensor Product", "Hom Space"]),
  ("Double Dual Isomorphism", ["Dual Space", "Finite Dimension"]),
  ("Quotient Universal Property", ["First Isomorphism"])
]

#eval "Theorems.Main: 12 pillar theorems of linear transformation theory"
#eval s!"Pillar count: {linearTransformationPillars.length}"
#eval "  L4: Rank-Nullity, First Iso, Cayley-Hamilton"
#eval "  L5: Jordan, Rational Canonical Form"
#eval "  L6: Spectral (Real/Complex), SVD"
#eval "  L8: Tensor-Hom Adjunction, Double Dual Iso"
#eval "  All theorems: proven or stated in their respective files"

end MiniLinearTransformation
