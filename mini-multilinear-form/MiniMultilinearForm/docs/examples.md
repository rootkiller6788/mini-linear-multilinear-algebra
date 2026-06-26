# MiniMultilinearForm Examples

## Dot Product on R^n

```lean
def dotProduct {F : Field} (n : Nat) : Fin n → Fin n → F.carrier :=
  fun i j => if i = j then F.one else F.zero
```

## 2D Determinant

```lean
def det2D {F : Field} (v w : Fin 2 → F.carrier) : F.carrier :=
  F.sub (F.mul (v 0) (w 1)) (F.mul (v 1) (w 0))
```

## Cross Product in 3D

```lean
def crossProduct3D {F : Field} (v w : Fin 3 → F.carrier) : Fin 3 → F.carrier :=
  fun i => match i with
  | 0 => F.sub (F.mul (v 1) (w 2)) (F.mul (v 2) (w 1))
  | 1 => F.sub (F.mul (v 2) (w 0)) (F.mul (v 0) (w 2))
  | 2 => F.sub (F.mul (v 0) (w 1)) (F.mul (v 1) (w 0))
```

## Minkowski Metric

```lean
def MinkowskiMetric {F : Field} (x y : Fin 4 → F.carrier) : F.carrier :=
  F.add (F.add (F.add
    (F.neg (F.mul (x 0) (y 0)))
    (F.mul (x 1) (y 1)))
    (F.mul (x 2) (y 2)))
    (F.mul (x 3) (y 3))
```

## Rank-One Matrix from Tensor Product

```lean
def rankOneMatrix {F : Field} (m n : Nat)
    (v : Fin m → F.carrier) (w : Fin n → F.carrier) :
    Fin m → Fin n → F.carrier :=
  fun i j => F.mul (v i) (w j)
```
