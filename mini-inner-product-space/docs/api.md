# MiniInnerProductSpace API Reference

## Core Types

### InnerProduct

The central structure representing an inner product on a vector space.

```
structure InnerProduct (F : Field) (V : VectorSpace F)
  ip : V.V -> V.V -> F.carrier
  conjugateSym : forall x y, ip x y = ip y x
  linearFirst : forall x y z a, ip (V.add (V.smul a x) y) z = F.add (F.mul a (ip x z)) (ip y z)
  positiveDefinite : forall x, x != V.zero -> ip x x != F.zero
```

### OrthonormalBasis

A basis where all vectors are mutually orthogonal and unit-normed.

```
structure OrthonormalBasis (F : Field) (V : VectorSpace F) (IP : InnerProduct F V)
  basis : Basis F V
  orthonormal : forall b1 b2 in basis, IP.ip b1 b2 = (if b1=b2 then F.one else F.zero)
```

### IsometricMap

A linear map that preserves inner products.

```
structure IsometricMap {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W)
  extends LinearMap V W
  preservesInner : forall x y, IPW.ip (T x) (T y) = IPV.ip x y
```

## Core Functions

### norm

```lean
def norm {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (x : V.V) : F.carrier
```
Returns the norm ||x|| = sqrt(<x,x>) (conceptual).

### orthogonal

```lean
def orthogonal {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (x y : V.V) : Prop
```
True if <x,y> = 0. Notation: `x ⟂ y`.

### orthogonalComplement

```lean
def orthogonalComplement {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (S : Set V.V) : Set V.V
```
The set of vectors orthogonal to all vectors in S.

### gramSchmidt

```lean
def gramSchmidt {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (vecs : List V.V) : List V.V
```
Orthonormalizes a list of vectors (conceptual).

### adjoint

```lean
noncomputable def adjoint {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : LinearMap V V
```
The adjoint (Hermitian conjugate) satisfying <Tx,y> = <x,T*y>.

### orthogonalProjection

```lean
noncomputable def orthogonalProjection {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : LinearMap V V
```
The orthogonal projection onto subspace W.

## Predicates

| Name | Signature | Description |
|------|-----------|-------------|
| `isSelfAdjoint` | `(IP, T) -> Prop` | T = T* |
| `isUnitary` | `(IP, T) -> Prop` | <Tx,Ty> = <x,y> |
| `isIsotropicSubspace` | `(IP, W) -> Prop` | <x,x> = 0 for all x in W |
| `isHilbertSpace` | `(IP) -> Prop` | Cauchy completeness |

## Operator Classes

| Class | Definition | Key Property |
|-------|-----------|--------------|
| Self-Adjoint / Hermitian | T = T* | Real eigenvalues |
| Unitary / Orthogonal | T* T = I | Preserves inner product |
| Normal | T T* = T* T | Spectral theorem |
| Positive | <Tx,x> >= 0 | Square root exists |
| Projection | T^2 = T, T = T* | Orthogonal projection |
