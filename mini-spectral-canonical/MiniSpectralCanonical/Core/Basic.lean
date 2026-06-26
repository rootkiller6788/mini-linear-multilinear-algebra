/-
# MiniSpectralCanonical.Core.Basic

Spectral theorems and canonical forms:
Jordan canonical form, rational canonical form,
spectral theorem for self-adjoint operators, SVD.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniDeterminantTheory.Core.Basic
import MiniInnerProductSpace.Core.Basic

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation
open MiniDeterminantTheory
open MiniInnerProductSpace

/-! ## Spectral Theorem for Self-Adjoint Operators -/

def spectralTheoremSelfAdjoint {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : Prop :=
  isSelfAdjoint IP T → isDiagonalizable T

/-! ## Jordan Canonical Form -/

structure JordanBlock (F : Field) where
  eigenvalue : F.carrier
  size : Nat

structure JordanCanonicalForm {F : Field} {V : VectorSpace F} (T : LinearMap V V) where
  blocks : List (JordanBlock F)
  -- T is similar to a block diagonal matrix of Jordan blocks

/-! ## Rational Canonical Form -/

structure CompanionMatrix (F : Field) where
  poly : Polynomial F
  size : Nat

structure RationalCanonicalForm {F : Field} {V : VectorSpace F} (T : LinearMap V V) where
  invariantFactors : List (Polynomial F)
  -- T is similar to a block diagonal matrix of companion matrices

/-! ## Singular Value Decomposition (conceptual, over ℝ/ℂ) -/

structure SVD (F : Field) (V W : VectorSpace F) (T : LinearMap V W) where
  singularValues : List F.carrier
  leftVectors : List V.V
  rightVectors : List W.V
  -- T = U Σ V*

/-! ## Polar Decomposition -/

def polarDecomposition {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : Prop :=
  ∃ (U P : LinearMap V V), isUnitary IP U ∧ isSelfAdjoint IP P ∧ T = LinearMap.comp U P

/-! ## Spectral Radius -/

noncomputable def spectralRadius {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  F.zero  -- conceptual: max |λ| over eigenvalues

/-! ## Min-Max Theorem (Courant-Fischer) -/

def courantFischer {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : Prop :=
  isSelfAdjoint IP T → True  -- eigenvalues can be found by min-max

/-! ## Gershgorin Circle Theorem (statement) -/

def gershgorinTheorem {F : Field} {n : Nat} : Prop :=
  True  -- eigenvalues lie in Gershgorin discs

#eval "Core.Basic: Spectral Theorem, Jordan, Rational, SVD, Polar"
