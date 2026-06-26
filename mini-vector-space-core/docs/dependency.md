# mini-vector-space-core -- Dependencies

## Immediate Dependencies

| Package | Path | Used For |
|---------|------|----------|
| `mini-object-kernel` | `../../0. mini-math-kernel/mini-object-kernel` | `Object` typeclass, `Axioms`, `Formula` |

## Dependency Graph (partial ecosystem)

```
mini-vector-space-core
└── mini-object-kernel
    └── (self-contained, Object typeclass + Axioms + Formula)
```

## Internal Dependencies

```
Core.Basic
├── Core.Objects             (imports Core.Basic + MiniObjectKernel)
├── Core.Laws                (imports Core.Basic + MiniObjectKernel)
├── Morphisms.Hom            (imports Core.Basic)
├── Morphisms.Iso            (imports Core.Basic)
├── Morphisms.Equivalence    (imports Core.Basic, uses dimension)
├── Constructions.Products   (imports Core.Basic)
├── Constructions.Universal  (imports Core.Basic)
├── Constructions.Subobjects (imports Core.Basic + Core.Objects + MiniObjectKernel)
├── Constructions.Quotients  (imports Core.Basic + Core.Objects + MiniObjectKernel)
├── Properties.*             (imports Core.Basic)
├── Theorems.*               (imports Core.Basic)
├── Examples.*               (imports Core.Basic)
└── Bridges.*                (imports Core.Basic)
```

## Cross-Package Bridges

- `Bridges/ToAlgebra` — connects to module theory (future mini-module-theory)
- `Bridges/ToTopology` — connects to topological vector spaces
- `Bridges/ToGeometry` — connects to affine/projective geometry
- `Bridges/ToComputation` — connects to numerical linear algebra
