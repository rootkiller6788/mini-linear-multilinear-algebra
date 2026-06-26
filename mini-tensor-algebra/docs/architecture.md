# Architecture: mini-tensor-algebra

## Package Structure

```
mini-tensor-algebra/
├── lakefile.lean          # Lake build configuration
├── lean-toolchain         # Lean version pinning
├── Main.lean              # Entry point
├── MiniTensorAlgebra.lean # Module root (imports all)
├── MiniTensorAlgebra/
│   ├── Core/
│   │   ├── Basic.lean     # TensorProduct, TensorAlgebra, SymmetricAlgebra, ExteriorAlgebra
│   │   ├── Laws.lean      # Bilinearity, commutativity, anti-commutativity laws
│   │   └── Objects.lean   # TensorPower, SymmetricPower, ExteriorPower
│   ├── Constructions/
│   │   ├── Products.lean  # Triple products, iterated tensor
│   │   ├── Quotients.lean # Symmetric/exterior as quotients
│   │   ├── Subobjects.lean # Graded components, subalgebras
│   │   └── Universal.lean # Universal constructions
│   ├── Morphisms/
│   │   ├── Hom.lean       # Algebra homomorphisms
│   │   ├── Iso.lean       # Isomorphisms (assoc, swap, distribute)
│   │   └── Equivalence.lean # Tensor-Hom adjunction, monoidal structure
│   ├── Properties/
│   │   ├── Invariants.lean # Dimension, rank, trace, determinant
│   │   ├── Preservation.lean # Exactness, flatness
│   │   └── ClassificationData.lean # Graded decomposition, Hilbert series
│   ├── Theorems/
│   │   ├── Basic.lean     # Existence, uniqueness, bilinearity
│   │   ├── Main.lean      # PBW, grading, dimension theorems
│   │   ├── Classification.lean # Classification by dimension
│   │   └── UniversalProperties.lean # Free algebra properties
│   ├── Examples/
│   │   ├── Standard.lean  # ℝ²⊗ℝ³, Λ(ℝ³), etc.
│   │   └── Counterexamples.lean # Non-simple tensors, non-left-exactness
│   └── Bridges/
│       ├── ToAlgebra.lean   # Module tensor, Hopf algebras, braided categories
│       ├── ToGeometry.lean  # Differential forms, de Rham, curvature tensor
│       ├── ToTopology.lean  # Kunneth, cup product, chain complexes
│       └── ToComputation.lean # Tensor decomposition, sparse tensors, BLAS
├── Test/
│   ├── Smoke.lean         # Import and basic compile check
│   ├── Regression.lean    # Core theorem regression
│   └── Examples.lean      # Example-based tests
├── Benchmark/
│   ├── CoreCoverage.lean  # Core definition/theorem coverage
│   ├── MIT.lean           # MIT 18.06/18.700 benchmark
│   ├── Harvard.lean       # Harvard Math 55/123 benchmark
│   ├── Princeton.lean     # Princeton MAT 217/345 benchmark
│   ├── CambridgePartIII.lean # Cambridge Part III benchmark
│   └── OxfordPartC.lean   # Oxford Part C benchmark
├── Computation/
│   ├── notebooks/         # Jupyter notebooks (placeholder)
│   ├── python/            # Python computation (placeholder)
│   └── sage/              # Sage computation (placeholder)
├── docs/
│   ├── architecture.md    # This file
│   ├── coverage.md        # Coverage tracking
│   └── dependency.md      # Dependency graph
└── scripts/
    ├── check.ps1          # Windows check script
    └── check.sh           # Unix check script
```

## Dependencies

- `mini-vector-space-core`: Field, VectorSpace definitions
- `mini-linear-transformation`: LinearMap
- `mini-multilinear-form`: BilinearMap, MultilinearMap

## Core Design

1. **TensorProduct**: Defined via universal property (not explicit construction)
2. **TensorAlgebra**: Free associative algebra on a vector space
3. **SymmetricAlgebra**: Quotient of T(V) by commutator ideal
4. **ExteriorAlgebra**: Quotient of T(V) by square ideal
