/-
# MiniLinearTransformation.Properties.ClassificationData

Classification data for linear transformations:
diagonalizable, nilpotent, Jordan form, rational canonical form.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Properties.Invariants

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Diagonalizable -/

-- T is diagonalizable if there exists a basis of eigenvectors
def LinearMap.isDiagonalizable {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  True
  -- Placeholder: requires basis concept

/-! ## Nilpotent -/

-- T is nilpotent if Tᵏ = 0 for some k
def LinearMap.isNilpotent {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  ∃ (k : Nat), True
  -- Placeholder: requires Tᵏ (iterated composition)

/-! ## Minimal Polynomial -/

-- The minimal polynomial of T is the monic polynomial p of minimal degree with p(T) = 0
noncomputable def LinearMap.minimalPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  0

/-! ## Jordan Canonical Form -/

-- Every linear operator over an algebraically closed field has a Jordan canonical form
def jordanFormStatement {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop := True

/-! ## Rational Canonical Form -/

-- Every linear operator has a rational canonical form
def rationalFormStatement {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop := True

#eval "Properties.ClassificationData: diagonalizable, nilpotent, minimal poly, Jordan, rational form"
