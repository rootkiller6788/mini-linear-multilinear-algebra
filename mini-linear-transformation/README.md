# mini-linear-transformation

Linear transformations between vector spaces: linear maps, kernel, image, rank, nullity, isomorphisms.

Part of the mini-everything-math ecosystem.

## Structure

- **Core/** — LinearMap, identity, composition, zero map, kernel, image, rank, nullity
- **Morphisms/** — Linear isomorphism, equivalence
- **Constructions/** — Subspaces, quotients, products, universal constructions
- **Properties/** — Invariants, preservation, classification data
- **Theorems/** — Rank-nullity, universal properties, classification
- **Examples/** — Standard examples, counterexamples
- **Bridges/** — Connections to algebra, topology, geometry, computation

## Quick Start

```bash
lake build
lake env lean --run Test/Smoke.lean
```

## Dependencies

- `mini-vector-space-core` — Field and VectorSpace definitions
- `mini-object-kernel` — Mathematical object typeclass
