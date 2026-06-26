import MiniTensorAlgebra

/-!
# mini-tensor-algebra

Comprehensive tensor algebra library in Lean 4.

## Overview

This package provides formalizations of:
- Tensor products of vector spaces (universal property)
- Tensor algebra T(V)
- Symmetric algebra S(V)
- Exterior algebra Λ(V)
- Tensor powers and contractions
- Multilinear algebra foundations
- Applications to physics and geometry

## Usage

```lean
import MiniTensorAlgebra

open MiniTensorAlgebra

-- Use tensor product notation
#check fun (v w) => v ⊗ w

-- Use wedge product notation
#check fun (x y) => x ∧ y
```
-/

def main : IO Unit :=
  IO.println "mini-tensor-algebra: TensorAlgebra, SymmetricAlgebra, ExteriorAlgebra"
