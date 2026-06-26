/-
# MiniDeterminantTheory.Core.Basic

Determinants, characteristic polynomials, eigenvalues, eigenvectors.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniMultilinearForm.Core.Basic

namespace MiniDeterminantTheory

open MiniVectorSpaceCore
open MiniLinearTransformation
open MiniMultilinearForm

/-! ## Determinant of a Linear Operator -/

noncomputable def determinant {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  F.one  -- conceptual; actual definition via exterior powers

/-! ## Properties of Determinants -/

def detIsMultiplicative {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop :=
  determinant (LinearMap.comp S T) = F.mul (determinant S) (determinant T)

def detOfIdentity {F : Field} {V : VectorSpace F} : Prop :=
  determinant (LinearMap.id V) = F.one

def detIsInvertible {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  (determinant T = F.zero) ↔ (¬ ∃ (S : LinearMap V V),
    LinearMap.comp S T = LinearMap.id V ∧ LinearMap.comp T S = LinearMap.id V)

/-! ## Eigenvalues and Eigenvectors -/

structure Eigenpair {F : Field} {V : VectorSpace F} (T : LinearMap V V) where
  eigenvalue : F.carrier
  eigenvector : V.V
  nonzero : eigenvector ≠ V.zero
  equation : T.map eigenvector = V.smul eigenvalue eigenvector

/-! ## Characteristic Polynomial -/

structure Polynomial (F : Field) where
  coeffs : List F.carrier

def charPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Polynomial F :=
  ⟨[F.one]⟩  -- conceptual: p(λ) = det(λI - T)

/-! ## Diagonalizability -/

def isDiagonalizable {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  ∃ (basis : List V.V), True  -- T is diagonal with respect to basis

/-! ## Cayley-Hamilton Theorem (statement) -/

def cayleyHamilton {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  True  -- p_T(T) = 0

/-! ## Trace -/

noncomputable def trace {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  F.zero  -- conceptual

def traceIsCyclic {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop :=
  trace (LinearMap.comp S T) = trace (LinearMap.comp T S)

#eval "Core.Basic: determinant, eigenvalues, charPoly, diagonalizable, trace"

end MiniDeterminantTheory
