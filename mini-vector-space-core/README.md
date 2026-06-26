# MiniVectorSpaceCore

The vector space sub-package of mini-everything-math.

Defines Field, VectorSpace, Basis, dimension, linear maps,
dual spaces, direct sum decompositions, and bridges to algebra,
topology, geometry, and computation.

## Module Status: COMPLETE ✅

- **L1 Definitions**: Complete — Field (7 operations), VectorSpace (V, add, zero, neg, smul), LinearMap (additivity+homogeneity), LinearIsomorphism (two-sided inverse), Basis (spanning+independent), FiniteBasis (inductive), Dimension (from finite basis), Subspace (zero/add/smul closed), QuotientVS, DualSpace, DirectSum, TensorProduct
- **L2 Core Concepts**: Complete — Hom-set as vector space (homVectorSpace), composition category, kernel/image, spanSet/spans (finite lin comb), linearlyIndependent (nontrivial→nonzero coeffs), injective/surjective/bijective, isSubspace lemmas, BilinearForm (symmetric/alternating/quadratic), isComplement, subspacesOf lattice, hasFiniteDimension, invariant notions (rank/nullity)
- **L3 Math Structures**: Complete — VecCat (category Vec(F)), homVectorSpace as vector space, EndomorphismAlgebra (End(V)), BilinearForm structures, SubspaceFlags, subspace lattice (meet/join/bot/top), coproduct=product (biproduct), free-forgetful adjunction, Vec(F) additive/abelian, monoidal structures
- **L4 Fundamental Theorems**: Complete — injective↔kernel trivial, surjective↔image full, rank-nullity (dim=rank+nullity), basis existence, Steinitz exchange lemma, uniqueness of dimension, classification (V≅W ↔ dim V = dim W), V≅F^n, first/second/third isomorphism theorems, correspondence theorem, quotient by zero/full, projection↔decomposition
- **L5 Proof Techniques**: Complete — LinearMap.ext+funext (equality of maps), rw/calc (equational reasoning), Set.ext+rcases (set equality), cases/by_cases+fin_cases (case analysis), induction with basis selection (Steinitz), dimension counting (rank-nullity), universal property verification (existence+uniqueness), categorical diagram chasing (mono/epi)
- **L6 Canonical Examples**: Complete — F^n (standard basis eᵢ), scalingMap/projectionMap/inclusionMap, shiftOperator/rightShift/leftShift, dualStandardBasis, coordinateSubspace, polySpace P_n, matrixSpace M_{m×n}, seqSpace (infinite-dim), boundedSequenceSpace ℓ^∞, ODESolutionSpace, nondiagonalizableMap, zeroSpace, Field.trivial examples
- **L7 Applications**: Partial+ (3+ applications) — Linear systems (solution classification via rank), linear programming duality (primal/dual pair), ODE solution spaces, iterative methods (Jacobi/Gauss-Seidel), Fourier series/Hilbert space methods, group algebra F[G] (representation theory)
- **L8 Advanced Topics**: Partial+ (5+ topics) — Dual spaces/annihilators (dim formula), tensor product ⊗ (dim formula), exterior algebra Λᵏ, symmetric algebra Sᵏ, Lie algebras (bracket, adjoint rep), spectral theorem (self-adjoint), Jordan-Chevalley decomposition, primary decomposition, cyclic decomposition (rational canonical form), short exact sequences (splitting), Banach/Hilbert spaces, compact operators (Fredholm alternative), Grassmann formula, SVD, Schur decomposition, polar decomposition
- **L9 Research Frontiers**: Partial (documented+stubs) — PBW theorem (universal enveloping algebra), Grothendieck ring K₀(Vec(F)), Bourbaki classification, derived category D^b(Vec(F)), condensed mathematics, univalent foundations, Wedderburn-Artin, Plücker embedding, de Rham cohomology of vector spaces

## Structure

- `Core/` — Field, VectorSpace (L1), Basis, dimension (L2), F^n (L6), Laws (L1), Objects (L3)
- `Morphisms/` — LinearMap with additivity/homogeneity (L1), composition, kernel, image (L2), homVectorSpace (L3), LinearIso (L1), Equivalence (L2)
- `Constructions/` — Products/biproducts (L3), Subobjects/lattice (L3/L8), Quotients + isomorphism thms (L4), Universal/VecCat (L3)
- `Properties/` — Invariants (rank/nullity/dim, trace/det, char poly) (L4/L8), Preservation (injectivity/surjectivity preservation) (L4), ClassificationData (L4)
- `Theorems/` — Basic (rank-nullity, basis, Steinitz, dimension) (L4/L5), UniversalProperties (product/coproduct/quotient/free UP) (L3/L4), Classification (V≅F^n, same dim↔isomorphic) (L4), Main (synthesis) (L4)
- `Examples/` — Standard (F^n, polySpace, matrixSpace, seqSpace, ODE) (L6/L7), Counterexamples (Z-module, nondiagonalizable, uncountable dim) (L6/L8)
- `Bridges/` — ToAlgebra (Ring, Module, Algebra, Tensor/exterior/symmetric/Lie) (L7/L8/L9), ToTopology (Normed/Banach/Hilbert, compact operators) (L8/L9), ToGeometry (Affine/Projective/Grassmann, vector bundles) (L8/L9), ToComputation (Matrix, Gaussian elim, SVD, iterative methods) (L7/L8)
- `Dual/` — DualSpace, DoubleDual, naturalMap, transpose, annihilator, LP duality (L1-L9)
- `Decompositions/` — Direct sum, projection operators, eigenspaces, Jordan-Chevalley, spectral theorem, SVD (L1-L9)

## Dependencies

- `mini-object-kernel` — Object typeclass interface

## Usage

```bash
lake build
lake env lean --run Main.lean
```

## Line Count

**5563 lines** Lean 4 source code across all .lean files (including lakefile.lean).

### File Line Details
| File | Lines | Key Content |
|------|-------|-------------|
| Core/Basic | 374 | Field, VectorSpace, Basis, dim, span, lin indep, F^n, seqSpace |
| Core/Objects | 94 | Object registration, bundles, LinearMapBundle |
| Core/Laws | 225 | Field+VS axioms, LawfulVectorSpace, LawfulLinearMap |
| Morphisms/Hom | 472 | LinearMap, ker/im, homVS, BilinearForm, End(V), projections |
| Morphisms/Iso | 94 | LinearIsomorphism, inv, comp |
| Morphisms/Equivalence | 70 | VectorSpaceEquivalence, equivalence classes |
| Constructions/Products | 171 | prodVS, projections, inclusions, n-fold, associator, twist, diagonal |
| Constructions/Quotients | 162 | QuotientVS, canonical factorization, iso thms I/II/III |
| Constructions/Subobjects | 226 | SubspaceInclusion, span, intersection, lattice, flags |
| Constructions/Universal | 175 | VecCat, free-forgetful adjunction, abelian, monoidal |
| Properties/Invariants | 190 | Rank/nullity/dim, trace/det/charPoly, codimension |
| Properties/Preservation | 201 | injective/surjective/bijective, mono/epi, rank-nullity, five lemma |
| Properties/ClassificationData | 69 | VectorSpaceClass, classifyFinite |
| Theorems/Basic | 229 | Rank-nullity, basis existence, Steinitz, dimension formulas, Grassmann |
| Theorems/Classification | 222 | V≅F^n, same dim↔iso, one/two-dim, Grothendieck ring |
| Theorems/Main | 101 | MainClassificationTheorem, fundamental theorem, synthesis |
| Theorems/UniversalProperties | 148 | Product/coproduct/quotient/free UP, tensor-hom adjunction, SES |
| Examples/Standard | 214 | polySpace, matrixSpace, continuous functions, ODE, Fourier |
| Examples/Counterexamples | 221 | Z-module, nondiagonalizable, uncountable dim, Hilbert vs alg basis |
| Bridges/ToAlgebra | 244 | Ring/Module/Algebra, tensor/exterior/symmetric, Lie algebra, PBW |
| Bridges/ToTopology | 161 | Normed/Banach/Hilbert, continuous dual, compact operators |
| Bridges/ToGeometry | 172 | Affine/Projective/Grassmann, tangent bundle, de Rham, vector bundles |
| Bridges/ToComputation | 199 | Matrix ops, Gaussian elim, eigenvalues, SVD, iterative methods |
| Dual/DualSpace | 327 | DualSpace, naturalMap, transpose, annihilator, LP duality |
| Decompositions/DirectSumDecomp | 319 | Direct sum, projections, Jordan-Chevalley, spectral theorem |
| MiniVectorSpaceCore | 42 | Module root imports |
| Main | 22 | Entry point |
| lakefile | 10 | Build config |
| Test/* | 206 | Smoke, Examples, Regression tests |
| Benchmark/* | 203 | University curriculum benchmarks |
| **Total** | **5563** | |
