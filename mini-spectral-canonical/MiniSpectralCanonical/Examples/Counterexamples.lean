/-
# MiniSpectralCanonical: Counterexamples

Counterexamples illustrating edge cases in spectral theory.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Counterexamples

Placeholder for spectral counterexamples:
- Non-diagonalizable matrix (nontrivial Jordan block)
- Defective matrix (geometric multiplicity < algebraic multiplicity)
- Non-normal operator with real eigenvalues
- Non-orthogonal eigenvectors for symmetric matrix over non-closed field
- Non-diagonalizable operator over R (rotation by 90 degrees)
-/

/-! ## Non-Diagonalizable Operator -/

-- The canonical 2x2 Jordan block is not diagonalizable
def nonDiagonalizableExample {F : Field} : JordanBlock F :=
  { eigenvalue := F.one, size := 2 }  -- J_2(1) has geometric multiplicity 1

/-! ## Defective Matrix -/

-- A defective matrix: algebraic multiplicity 2 but geometric multiplicity 1
def defectiveExample {F : Field} : Prop :=
  True  -- placeholder

/-! ## Non-Normal with Real Spectrum -/

-- A matrix that is not normal but has all real eigenvalues
def nonNormalRealSpectrum {F : Field} (IP : InnerProduct F V) (T : LinearMap V V) : Prop :=
  ¬ isNormal IP T ∧ True  -- placeholder

/-! ## Non-Existence of Jordan Form over R -/

-- The rotation matrix [[0,-1],[1,0]] has no real eigenvalues
def rotationNoRealEigenvalues {F : Field} : Prop :=
  True  -- placeholder: over R, this 2x2 matrix has no real Jordan form

/-! ## Non-Symmetric but Diagonalizable -/

-- A diagonalizable but non-symmetric matrix
def nonSymmetricDiagonalizable {F : Field} : Prop :=
  True  -- placeholder

#eval "Examples.Counterexamples: Non-diagonalizable, Defective, Non-normal, Rotation"
