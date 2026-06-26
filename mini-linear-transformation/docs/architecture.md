# mini-linear-transformation -- Architecture

## Dependency Graph

```
MiniVectorSpaceCore (Field, VectorSpace)
  └── MiniLinearTransformation
        ├── Core/
        │     ├── Basic.lean          LinearMap, id, comp, zero, kernel, image, rank, nullity
        │     ├── Objects.lean        Object instance registration
        │     └── Laws.lean           Laws of linear transformations
        ├── Morphisms/
        │     ├── Hom.lean            LinearIsomorphism, Automorphism, symm, comp
        │     ├── Iso.lean            isInjective, isSurjective, bijective, kernel trivial
        │     └── Equivalence.lean    LinearMap.Equiv, Similar, HomSet (category)
        ├── Constructions/
        │     ├── Subobjects.lean     Kernel subspace, image subspace, invariant subspace, eigenspace
        │     ├── Quotients.lean      First isomorphism, quotient universal property
        │     ├── Products.lean       Direct sum, product, coproduct, BilinearMap
        │     └── Universal.lean      Hom space, dual space, double dual, transpose, adjoint
        ├── Properties/
        │     ├── Invariants.lean     Rank, nullity, trace, determinant, charPoly
        │     ├── Preservation.lean   Independence, spanning, rank bounds, injective↔surjective
        │     └── ClassificationData.lean  Diagonalizable, nilpotent, minimal poly, Jordan, rational form
        ├── Theorems/
        │     ├── Basic.lean          Rank-Nullity, dim sum, basis extension, Cayley-Hamilton
        │     ├── UniversalProperties.lean  Tensor-hom, double dual, quotient factorization
        │     ├── Classification.lean Jordan, rational form, spectral, SVD
        │     └── Main.lean           7 pillar theorems summary
        ├── Examples/
        │     ├── Standard.lean       Zero, id, comp, kernel, image examples
        │     └── Counterexamples.lean Non-injective, non-surjective, non-diagonalizable
        ├── Bridges/
        │     ├── ToAlgebra.lean      Module hom, algebra/Lie/group representations
        │     ├── ToTopology.lean     Bounded/continuous operators, operator norm
        │     ├── ToGeometry.lean     Tangent map, derivative, pushforward/pullback
        │     └── ToComputation.lean  Matrix ops, LU/QR, eigenvalues, Gram-Schmidt
        ├── Test/                     Smoke, Examples, Regression
        ├── Benchmark/                CoreCoverage + 5 school benchmarks
        └── Root: MiniLinearTransformation.lean, Main.lean, README.md
```

## Layer Map

| Layer | Files | Purpose |
|-------|-------|---------|
| **Core** (3) | Basic, Objects, Laws | LinearMap, kernel, image, rank, nullity |
| **Morphisms** (3) | Hom, Iso, Equivalence | LinearIso, injective/surjective, similarity |
| **Constructions** (4) | Subobjects, Quotients, Products, Universal | Kernel/image subspaces, quotient, dual, transpose |
| **Properties** (3) | Invariants, Preservation, ClassificationData | rank/tr/det/χ, rank bounds, Jordan/diag |
| **Theorems** (4) | Basic, UniversalProperties, Classification, Main | 7 pillars (all statements/placeholders) |
| **Examples** (2) | Standard, Counterexamples | Basic examples, 4 counterexamples |
| **Bridges** (4) | Algebra, Topology, Geometry, Computation | Module→Banach→Tangent→FloatField |

## Axiom Inventory

| Group | Count | Axioms |
|-------|-------|--------|
| Linear transformation laws | 4 | linearity of add, smul, assoc of comp, id neutral |
| Theorem statements | 7 | Rank-Nullity, First Iso, dim sum, Cayley-Hamilton, Jordan, Spectral, SVD |
| **Total** | **11** | |
