/-
# MiniDeterminantTheory: Standard Examples

Standard examples of determinant computations.
-/

import MiniDeterminantTheory.Core.Basic

namespace MiniDeterminantTheory

/-! ## Standard Determinant Examples

Conceptual examples:
- Determinant of identity operator = 1
- Determinant of zero operator = 0
- Determinant of scalar operator c·I = c^n (where n = dim V)
- Determinant of orthogonal operator = ±1
- Determinant of nilpotent operator = 0
-/

def identityDeterminant {F : Field} {V : VectorSpace F} : F.carrier :=
  F.one

def zeroDeterminant {F : Field} {V : VectorSpace F} : F.carrier :=
  F.zero

end MiniDeterminantTheory
