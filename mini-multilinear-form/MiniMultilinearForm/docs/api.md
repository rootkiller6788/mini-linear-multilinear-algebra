# MiniMultilinearForm API Reference

## Core Types

### BilinearMap
```lean
structure BilinearMap {F : Field} (V₁ V₂ W : VectorSpace F) where
  map : V₁.V → V₂.V → W.V
  linearFirst : ∀ (x y : V₁.V) (z : V₂.V), map (V₁.add x y) z = W.add (map x z) (map y z)
  linearSecond : ∀ (x : V₁.V) (y z : V₂.V), map x (V₂.add y z) = W.add (map x y) (map x z)
  smulCompat : ∀ (a : F.carrier) (x : V₁.V) (y : V₂.V), map (V₁.smul a x) y = W.smul a (map x y) ∧ map x (V₂.smul a y) = W.smul a (map x y)
```

### BilinearForm
```lean
def BilinearForm {F : Field} (V : VectorSpace F) : Type _ := BilinearMap V V (fnSpace F 1)
```

### MultilinearMap
```lean
structure MultilinearMap {F : Field} (n : Nat) (V : VectorSpace F) (W : VectorSpace F) where
  map : (Fin n → V.V) → W.V
  multilinear : ∀ (i : Fin n) (x y : V.V) (args : Fin n → V.V), ...
```

### MultilinearForm
```lean
def MultilinearForm {F : Field} (n : Nat) (V : VectorSpace F) : Type _ := MultilinearMap n V (fnSpace F 1)
```

## Key Predicates

| Predicate | Meaning |
|-----------|---------|
| `isSymmetric B` | B(x,y) = B(y,x) |
| `isSkewSymmetric B` | B(x,y) = -B(y,x) |
| `isAlternating B` | B(x,x) = 0 |
| `isNondegenerate B` | radical is trivial |
| `isSymmetricTensor M` | invariant under permutation of arguments |
| `isAlternatingTensor M` | vanishes on repeated arguments |

## Key Structures

| Structure | Description |
|-----------|-------------|
| `QuadraticForm` | q(ax) = a²q(x) with polarization |
| `SymmetricBilinearForm` | Bundled symmetric form |
| `AlternatingBilinearForm` | Bundled alternating form |
| `RiemannianMetric` | Positive-definite symmetric form |
| `SymplecticForm` | Nondegenerate alternating form |
| `TensorProduct` | V ⊗ W with universal property |
| `ExteriorPower` | ΛᵏV, alternating multilinear |
