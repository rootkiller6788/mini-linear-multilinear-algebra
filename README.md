# Mini Linear & Multilinear Algebra

A collection of **from-scratch, zero-dependency Lean 4 implementations** of university-level linear algebra, multilinear algebra, and tensor theory. Each sub-package maps to MIT (and other top-tier university) courses, building the foundations of linear algebra from first principles using the Lean 4 proof assistant.

## Sub-Packages

| Sub-Package | Topics | Key Courses |
|-------------|--------|-------------|
| [mini-vector-space-core](mini-vector-space-core/) | Fields, vector spaces, bases, dimension, linear combinations | MIT 18.06, MIT 18.700 |
| [mini-linear-transformation](mini-linear-transformation/) | Linear maps, kernel, image, rank-nullity theorem | MIT 18.06, Princeton MAT 345 |
| [mini-dual-quotient](mini-dual-quotient/) | Dual spaces, double dual, quotient spaces, isomorphism theorems | MIT 18.700, Cambridge Part II |
| [mini-inner-product-space](mini-inner-product-space/) | Inner products, orthogonality, Gram-Schmidt, adjoints | MIT 18.06, Stanford Math 113 |
| [mini-multilinear-form](mini-multilinear-form/) | Bilinear forms, symmetric/skew-symmetric, alternating, multilinear maps | MIT 18.700, Harvard Math 122 |
| [mini-determinant-theory](mini-determinant-theory/) | Determinants, eigenvalues, characteristic polynomial, diagonalization | MIT 18.06, Princeton MAT 345 |
| [mini-tensor-algebra](mini-tensor-algebra/) | Tensor products, exterior algebra, symmetric algebra, Clifford algebra | MIT 18.700, Berkeley Math 110 |
| [mini-spectral-canonical](mini-spectral-canonical/) | Spectral theorem, canonical forms, Jordan/Smith decomposition | MIT 18.06, MIT 18.065 |

## Design Philosophy

- **Zero external dependencies** -- pure Lean 4, only kernel imports
- **Self-contained sub-packages** -- each has its own `lakefile.lean`, Core/, Morphisms/, Constructions/, Properties/, Theorems/
- **Theory-to-code mapping** -- every module includes inline `#eval` examples and theorem statements
- **Multilinear focus** -- tensor, symmetric, and exterior algebras build the full multilinear hierarchy

## Building

Each sub-package is standalone. Build with Lake:

```bash
cd mini-vector-space-core
lake build
lake env lean --run Test/Smoke.lean
```

Requires **Lean 4** and **Lake**.

## Project Structure

```
3. mini-linear-multilinear-algebra/
├── mini-vector-space-core/          # Fields, vector spaces, bases, dimension
├── mini-linear-transformation/      # Linear maps, kernel, image, rank-nullity
├── mini-dual-quotient/              # Dual spaces, double dual, quotient spaces
├── mini-inner-product-space/        # Inner products, orthogonality, Gram-Schmidt
├── mini-multilinear-form/           # Bilinear forms, symmetric, alternating
├── mini-determinant-theory/         # Determinants, eigenvalues, diagonalization
├── mini-tensor-algebra/             # Tensor products, exterior/symmetric/Clifford algebra
├── mini-spectral-canonical/         # Spectral theorem, Jordan/Smith decomposition
└── lakefile.lean
```

## License

MIT
