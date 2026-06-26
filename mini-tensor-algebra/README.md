# mini-tensor-algebra

Comprehensive tensor algebra library in Lean 4.

## Dependencies

- `mini-vector-space-core`
- `mini-linear-transformation`
- `mini-multilinear-form`

## Structure

```
MiniTensorAlgebra/
  Core/         -- Basic definitions: TensorProduct, TensorAlgebra, etc.
  Constructions/ -- Products, quotients, subobjects, universal constructions
  Morphisms/    -- Hom, Iso, Equivalence
  Properties/   -- Invariants, preservation, classification data
  Theorems/     -- Main theorems, classification, universal properties
  Examples/     -- Standard examples and counterexamples
  Bridges/      -- Connections to algebra, geometry, topology, computation
Test/
Benchmark/
Computation/
docs/
scripts/
```

## Building

```bash
lake build
```

## Status

Under active development. Core definitions in place; theorems and verification in progress.
