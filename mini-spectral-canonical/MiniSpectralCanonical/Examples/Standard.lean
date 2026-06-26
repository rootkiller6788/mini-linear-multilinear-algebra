/-
# MiniSpectralCanonical: Standard Examples

Standard examples of spectral decompositions and canonical forms.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Identity Operator -/

-- The identity operator: all eigenvalues are 1, already diagonal
def identityOperatorExample {F : Field} (V : VectorSpace F) : LinearMap V V :=
  LinearMap.id V

-- /-! ## Diagonal Matrix -/

-- A diagonal matrix with distinct eigenvalues
def diagonalExample {F : Field} (a b : F.carrier) : JordanCanonicalForm (T := identityOperatorExample (fnSpace F 2)) :=
  { blocks := [{ eigenvalue := a, size := 1 }, { eigenvalue := b, size := 1 }] }

-- /-! ## 2x2 Jordan Block -/

-- The basic 2x2 Jordan block J_2(λ)
def jordanBlockExample {F : Field} (lambda : F.carrier) : JordanBlock F :=
  { eigenvalue := lambda, size := 2 }

-- /-! ## Nilpotent Jordan Block -/

-- A nilpotent Jordan block (eigenvalue 0)
def nilpotentExample {F : Field} : JordanBlock F :=
  { eigenvalue := F.zero, size := 3 }

-- /-! ## Real Symmetric Matrix -/

-- A real symmetric 2x2 matrix: [[1,0],[0,2]]
def realSymmetricExample {F : Field} : Prop :=
  True  -- placeholder: eigenvalues 1, 2, orthonormal eigenvectors

-- /-! ## Projection Operator -/

-- A projection P with P^2 = P: eigenvalues are 0 and 1
def projectionExample {F : Field} {V : VectorSpace F} (P : LinearMap V V) : Prop :=
  LinearMap.comp P P = P

-- /-! ## Unitary Operator -/

-- A rotation in the plane (eigenvalues on unit circle)
def unitaryExample {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (U : LinearMap V V) : Prop :=
  isUnitary IP U

#eval "Examples.Standard: Identity, Diagonal, Jordan, Nilpotent, Symmetric, Projection, Unitary"
