# mini-linear-transformation -- Dependency Graph

## Internal Dependencies

```
Core/Basic.lean       (depends on MiniVectorSpaceCore.Core.Basic)
Core/Objects.lean     → Core/Basic
Core/Laws.lean        → Core/Basic, Core/Objects

Morphisms/Hom.lean    → Core/Basic
Morphisms/Iso.lean    → Morphisms/Hom
Morphisms/Equivalence → Morphisms/Hom, Morphisms/Iso

Constructions/Subobjects  → Morphisms/Hom
Constructions/Quotients   → Morphisms/Hom, Constructions/Subobjects
Constructions/Products    → Morphisms/Hom
Constructions/Universal   → Morphisms/Hom

Properties/Invariants       → Morphisms/Hom, Morphisms/Iso
Properties/Preservation     → Morphisms/Hom
Properties/ClassificationData → Properties/Invariants

Theorems/Basic               → Properties/Preservation, Constructions/Subobjects
Theorems/UniversalProperties → Morphisms/Iso, Constructions/Universal, Constructions/Products
Theorems/Classification      → Properties/ClassificationData, Theorems/Basic
Theorems/Main                → Theorems/Basic, Theorems/UniversalProperties, Theorems/Classification

Examples/Standard       → Core/Basic, Morphisms/Hom, Constructions/Subobjects
Examples/Counterexamples → Core/Basic, Morphisms/Iso

Bridges/ToAlgebra       → Core/Basic, Morphisms/Hom
Bridges/ToTopology      → Core/Basic, Morphisms/Hom
Bridges/ToGeometry      → Morphisms/Hom
Bridges/ToComputation   → Morphisms/Hom, Morphisms/Equivalence
```

## External Dependencies

All modules import `MiniVectorSpaceCore` (Field, VectorSpace definitions).
Root also imports `MiniObjectKernel` for the Object typeclass.

## Import Graph (condensed)

```
MiniVectorSpaceCore ← Core/Basic ← Core/Objects ← Core/Laws
                              ↓
        ← Morphisms/Hom ← Morphisms/Iso ← Morphisms/Equivalence
                ↓                ↓                ↓
        ← Constructions/*  ←  Properties/*
                ↓                ↓
        ← Theorems/*  ←  Examples/*  ←  Bridges/*
```
