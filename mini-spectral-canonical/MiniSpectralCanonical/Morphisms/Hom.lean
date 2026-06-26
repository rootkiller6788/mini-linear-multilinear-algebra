/-
# MiniSpectralCanonical: Morphisms (Similarity and Equivalence)

Similarity transformations and spectral morphisms for canonical forms.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Similarity Transformation -/

structure Similarity {F : Field} {V : VectorSpace F} (S T : LinearMap V V) where
  P : LinearMap V V
  invertible : ∃ (Q : LinearMap V V), LinearMap.comp P Q = LinearMap.id V ∧ LinearMap.comp Q P = LinearMap.id V
  similar : T = LinearMap.comp (LinearMap.comp P S) (LinearMap.inv P)

/-! ## Unitary Equivalence -/

structure UnitaryEquivalence {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (S T : LinearMap V V) where
  U : LinearMap V V
  unitary : isUnitary IP U
  equivalent : T = LinearMap.comp (LinearMap.comp U S) (LinearMap.adjoint IP U)

/-! ## Congruence -/

structure Congruence {F : Field} {V : VectorSpace F} (S T : LinearMap V V) where
  P : LinearMap V V
  invertible : ∃ (Q : LinearMap V V), LinearMap.comp P Q = LinearMap.id V ∧ LinearMap.comp Q P = LinearMap.id V
  congruent : T = LinearMap.comp (LinearMap.comp (LinearMap.adjoint IP P) S) P

/-! ## Direct Sum of Operators -/

def directSumOperator {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : LinearMap V V :=
  LinearMap.id V  -- placeholder for actual block diagonal construction

#eval "Morphisms.Hom: Similarity, UnitaryEquivalence, Congruence"
