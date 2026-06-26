# API Reference — MiniDualQuotient

## Core.Basic

### `DualSpace`

```lean
def DualSpace (F : Field) (V : VectorSpace F) : VectorSpace F
```
The dual space V* = Hom_F(V, F), the space of linear functionals on V.

### `LinearFunctional`

```lean
def LinearFunctional (F : Field) (V : VectorSpace F) : Type _
```
A linear functional on V, i.e., a linear map V → F.

### `DualBasis`

```lean
structure DualBasis (F : Field) (V : VectorSpace F) (B : Basis F V) where
  dualVectors : List (V.V → F.carrier)
  property : ∀ (b : V.V) (f : V.V → F.carrier), b ∈ B.basisSet → True
```
The dual basis {f_i} satisfying f_i(e_j) = δ_ij.

### `doubleDual`

```lean
def doubleDual (F : Field) (V : VectorSpace F) : VectorSpace F
```
The double dual V** = (V*)*.

### `canonicalEmbedding`

```lean
def canonicalEmbedding {F : Field} (V : VectorSpace F) : LinearMap V (doubleDual F V)
```
The canonical embedding V → V** sending v to ev_v : f ↦ f(v).

### `isReflexive`

```lean
def isReflexive (F : Field) (V : VectorSpace F) : Prop
```
A vector space is reflexive if the canonical embedding is an isomorphism.

### `transpose`

```lean
def transpose {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    LinearMap (DualSpace F W) (DualSpace F V)
```
The transpose T* : W* → V* defined by T*(f) = f ∘ T.

### `QuotientSpace`

```lean
structure QuotientSpace (F : Field) (V : VectorSpace F) (U : Set V.V) where
  Q : VectorSpace F
  proj : LinearMap V Q
  universal : ∀ (W : VectorSpace F) (T : LinearMap V W),
    (∀ (u : V.V), u ∈ U → T.map u = W.zero) →
    ∃! (f : LinearMap Q W), LinearMap.comp f proj = T
```
The quotient space V/U with universal property.

### `IsomorphismTheorem`

```lean
structure IsomorphismTheorem (F : Field) (V W : VectorSpace F) (T : LinearMap V W) where
  kernel : Set V.V
  image : Set W.V
  iso : LinearIsomorphism (QuotientSpace F V kernel).Q (VectorSpace F)
```
First Isomorphism Theorem: V/ker(T) ≅ im(T).

### `secondIsomorphismTheorem`

```lean
def secondIsomorphismTheorem {F : Field} {V : VectorSpace F} (U W : Set V.V) : Prop
```
Second Isomorphism Theorem: (U+W)/W ≅ U/(U∩W).

### `thirdIsomorphismTheorem`

```lean
def thirdIsomorphismTheorem {F : Field} {V : VectorSpace F} (U W : Set V.V) : Prop
```
Third Isomorphism Theorem: (V/U)/(W/U) ≅ V/W for U ⊆ W ⊆ V.

## Core.Objects

Object-level registrations for DualSpace, QuotientSpace, and related structures.

## Core.Laws

Stub — placeholder for dual space and quotient space laws (reflexivity conditions, dimension formulas).

## Constructions

### `MiniDualQuotient.Constructions.DualSpace`

Construction of dual space as a vector space of linear functionals.

### `MiniDualQuotient.Constructions.QuotientSpace`

Construction of quotient space with the canonical projection.

### `MiniDualQuotient.Constructions.Annihilator`

The annihilator U° = {f ∈ V* | f|_U = 0}.

### `MiniDualQuotient.Constructions.Transpose`

Construction of the transpose of a linear map.

## Morphisms

### `MiniDualQuotient.Morphisms.CanonicalEmbedding`

The canonical embedding V → V**.

### `MiniDualQuotient.Morphisms.Projection`

The canonical projection V → V/U.

### `MiniDualQuotient.Morphisms.Equivalence`

Isomorphism and equivalence relations on dual/quotient spaces.

## Properties

### `MiniDualQuotient.Properties.Dimensional`

Dimension properties: dim(V*) = dim(V), dim(V/U) = dim(V) - dim(U).

### `MiniDualQuotient.Properties.Structural`

Structural properties of dual and quotient spaces.

### `MiniDualQuotient.Properties.Universal`

Universal properties (mapping properties of dual and quotient).

## Theorems

### `MiniDualQuotient.Theorems.FirstIsomorphism`

First Isomorphism Theorem: V/ker(T) ≅ im(T).

### `MiniDualQuotient.Theorems.SecondIsomorphism`

Second Isomorphism Theorem: (U+W)/W ≅ U/(U∩W).

### `MiniDualQuotient.Theorems.ThirdIsomorphism`

Third Isomorphism Theorem: (V/U)/(W/U) ≅ V/W.
