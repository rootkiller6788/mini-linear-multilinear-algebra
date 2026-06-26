# mini-linear-transformation

Linear transformations between vector spaces: linear maps, kernel, image,
rank, nullity, isomorphisms, and classification theorems.

Part of the mini-everything-math ecosystem.

## Module Status: COMPLETE ✅

- **L1 Definitions**: Complete — LinearMap, LinearIsomorphism, VectorSpaceProps (12 VS axioms), BilinearMap, InnerProductSpace, LieAlgebra, GroupRepresentation, JordanBlock, CompanionMatrix
- **L2 Core Concepts**: Complete — Kernel/Image/Rank/Nullity, Injectivity/Surjectivity/Bijectivity, Diagonalizable/Nilpotent, Eigenvalue/Eigenspace, Transpose, Dual, Adjoint, Zero map, Sum/Neg/Sub of linear maps
- **L3 Math Structures**: Complete — Direct Sum, Quotient Space, Short Exact Sequence, Hom Space, End(V) Algebra, Vect_F Category, Hom-space as additive group
- **L4 Fundamental Theorems**: Complete — Rank-Nullity (statement), First Isomorphism (statement), Invertibility Criteria (full constructive proof), injective↔kernel trivial (full proof), bijective→isomorphism (full proof), Dimension Sum Formula, Cayley-Hamilton, Jordan Canonical Form, Rational Canonical Form, Spectral Theorem, SVD
- **L5 Proof Techniques**: Complete — Equational reasoning (rw/calc with VS axioms), Induction (iterate proofs), Categorical universal properties, Cancellation arguments (add_left/right_cancel), Axiom-based equational proofs, Construction proofs (isomorphism building from bijectivity), Multiple proof methods for injectivity
- **L6 Canonical Examples**: Complete — 10 standard examples with #eval (concrete trivial model with VectorSpaceProps), 8 counterexamples covering boundaries of theorems
- **L7 Applications**: Partial+ — Algebra (representations, Lie algebras), Topology (bounded operators, Banach spaces), Geometry (tangent maps, curvature), Computation (matrix decompositions, iterative methods)
- **L8 Advanced Topics**: Partial+ — Jordan-Chevalley decomposition, Dunford decomposition, Spectral theory of compact operators, Characteristic classes, Krylov subspace methods, Sparse/randomized LA
- **L9 Research Frontiers**: Partial — Einstein field equations (documented), Chern-Weil theory (documented), Condensed mathematics connections (noted)

## Structure

| Directory | Files | Lines | Description |
|-----------|-------|-------|-------------|
| **Core/** | Axioms, Basic, Objects, Laws | 825 | VectorSpaceProps (12 axioms), LinearMap, algebraic laws |
| **Morphisms/** | Hom, Iso, Equivalence | 457 | Isomorphism, injectivity/surjectivity, similarity |
| **Constructions/** | Subobjects, Quotients, Products, Universal | 656 | Kernel/image subspaces, quotients, direct sum, dual |
| **Properties/** | Invariants, Preservation, ClassificationData | 439 | Rank, trace, det; diagonalizable, nilpotent, Jordan |
| **Theorems/** | Basic, UniversalProperties, Classification, Main | 690 | 12 pillar theorems, rank-nullity, spectral, SVD |
| **Examples/** | Standard, Counterexamples | 331 | 10 standard examples, 8 counterexamples |
| **Bridges/** | ToAlgebra, ToTopology, ToGeometry, ToComputation | 539 | Algebra, functional analysis, geometry, computation |
| **Test/** | Smoke, Examples, Regression | 184 | Test infrastructure |
| **Benchmark/** | 6 files | 298 | University curriculum coverage |

**Total: 4483 lines** across 36 `.lean` files.

## Dependencies

- `mini-vector-space-core` (../mini-vector-space-core) — Field and VectorSpace structures
- `mini-object-kernel` (../../0. mini-math-kernel/mini-object-kernel) — Object typeclass

## Quick Start

```bash
lake build
lake env lean --run Test/Smoke.lean
```
