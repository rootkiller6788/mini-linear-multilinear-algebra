# User Guide — MiniDualQuotient

## Getting Started

Import the package:

```lean
import MiniDualQuotient
open MiniDualQuotient
```

## Working with Dual Spaces

```lean
-- The dual space V* (conceptual):
-- DualSpace F V : VectorSpace F
```

## Working with the Double Dual

```lean
-- The double dual V**:
-- doubleDual F V : VectorSpace F

-- The canonical embedding:
-- canonicalEmbedding V : LinearMap V (doubleDual F V)
```

## Working with Transpose

```lean
-- For T : LinearMap V W:
-- transpose T : LinearMap (DualSpace F W) (DualSpace F V)
```

## Working with Quotient Spaces

```lean
-- For a subspace U ⊆ V:
-- QuotientSpace F V U : structure with Q, proj, universal property

-- The canonical projection:
-- proj : LinearMap V Q
```

## Working with Isomorphism Theorems

```lean
-- First Isomorphism Theorem: V/ker(T) ≅ im(T)
-- IsomorphismTheorem F V W T

-- Second Isomorphism Theorem: (U+W)/W ≅ U/(U∩W)
-- secondIsomorphismTheorem U W

-- Third Isomorphism Theorem: (V/U)/(W/U) ≅ V/W
-- thirdIsomorphismTheorem U W
```

## Running Tests

```bash
lake env lean --run Test/Smoke.lean
lake env lean --run Test/Examples.lean
lake env lean --run Test/Regression.lean
```
