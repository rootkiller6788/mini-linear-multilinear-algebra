# mini-dual-quotient

Dual Spaces, Double Dual, Transpose, Quotient Spaces, and the
Three Isomorphism Theorems for Vector Spaces — Lite Edition.

A standalone mini-package providing the algebraic structures and
theorems for dual spaces and quotient spaces in linear algebra.

## Core Concepts

| Concept | Description |
|---------|-------------|
| DualSpace | V* = Hom_F(V, F) |
| doubleDual | V** |
| canonicalEmbedding | V → V** |
| transpose | T* : W* → V* for T : V → W |
| QuotientSpace | V/U for a subspace U ⊆ V |
| Annihilator | U° = {f ∈ V* | f(U) = {0}} |
| First Isomorphism Theorem | V/ker(T) ≅ im(T) |
| Second Isomorphism Theorem | (U+W)/W ≅ U/(U∩W) |
| Third Isomorphism Theorem | (V/U)/(W/U) ≅ V/W |

## Usage

```lean
import MiniDualQuotient

open MiniDualQuotient

-- Conceptual usage (placeholder stubs):
-- DualSpace F V
-- doubleDual F V
-- canonicalEmbedding V
-- transpose T
-- QuotientSpace.mk F V U
```

## Dependencies

- `mini-vector-space-core` — Field, VectorSpace, Basis, LinearMap
- `mini-linear-transformation` — LinearMap, LinearIsomorphism
