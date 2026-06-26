# Dependency Graph: mini-tensor-algebra

## External Dependencies

```
mini-vector-space-core
  └── Core/Basic.lean (Field, VectorSpace)

mini-linear-transformation
  └── Core/Basic.lean (LinearMap)

mini-multilinear-form
  └── Core/Basic.lean (BilinearMap)
```

## Internal Dependencies

```
MiniTensorAlgebra.lean
├── Core/Basic.lean
├── Core/Laws.lean
│   └── Core/Basic.lean
├── Core/Objects.lean
│   └── Core/Basic.lean, Core/Laws.lean
├── Constructions/Products.lean
│   └── Core/Basic.lean
├── Constructions/Quotients.lean
│   └── Core/Basic.lean, Core/Laws.lean
├── Constructions/Subobjects.lean
│   └── Core/Basic.lean, Core/Objects.lean
├── Constructions/Universal.lean
│   └── Core/Basic.lean, Constructions/Quotients.lean
├── Morphisms/Hom.lean
│   └── Core/Basic.lean, Constructions/Universal.lean
├── Morphisms/Iso.lean
│   └── Core/Basic.lean, Morphisms/Hom.lean
├── Morphisms/Equivalence.lean
│   └── Core/Basic.lean, Morphisms/Hom.lean, Morphisms/Iso.lean
├── Properties/Invariants.lean
│   └── Core/Basic.lean, Core/Objects.lean
├── Properties/Preservation.lean
│   └── Core/Basic.lean, Morphisms/Hom.lean
├── Properties/ClassificationData.lean
│   └── Core/Basic.lean, Core/Objects.lean, Constructions/Subobjects.lean
├── Theorems/Basic.lean
│   └── Core/Basic.lean, Core/Laws.lean, Morphisms/Iso.lean
├── Theorems/Main.lean
│   └── Core/Basic.lean, Morphisms/Equivalence.lean, Properties/Invariants.lean
├── Theorems/Classification.lean
│   └── Core/Basic.lean, Properties/ClassificationData.lean, Morphisms/Iso.lean
├── Theorems/UniversalProperties.lean
│   └── Core/Basic.lean, Constructions/Universal.lean, Theorems/Basic.lean
├── Examples/Standard.lean
│   └── Core/Basic.lean, Core/Objects.lean
├── Examples/Counterexamples.lean
│   └── Core/Basic.lean, Core/Laws.lean
├── Bridges/ToAlgebra.lean
│   └── Core/Basic.lean, Theorems/Main.lean
├── Bridges/ToGeometry.lean
│   └── Core/Basic.lean, Morphisms/Hom.lean
├── Bridges/ToTopology.lean
│   └── Core/Basic.lean, Morphisms/Equivalence.lean
└── Bridges/ToComputation.lean
    └── Core/Basic.lean, Properties/Invariants.lean
```
