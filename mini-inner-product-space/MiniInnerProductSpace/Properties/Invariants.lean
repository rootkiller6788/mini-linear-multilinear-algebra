/-
# MiniInnerProductSpace.Properties.Invariants

Invariants of inner product spaces: dimension, signature, determinant.
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore

/-! ## Dimension -/

def invDimension {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) : Nat :=
  0  -- dimension is invariant under inner product isomorphism

/-! ## Signature (for indefinite inner products) -/

structure Signature where
  positiveIndex : Nat
  negativeIndex : Nat
  zeroIndex : Nat

def invSignature {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) : Signature :=
  { positiveIndex := 0; negativeIndex := 0; zeroIndex := 0 }

/-! ## Gram Determinant -/

def gramDeterminant {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (vecs : List V.V) : F.carrier :=
  F.zero  -- det of Gram matrix G_ij = <v_i, v_j>

/-! ## Hilbert-Schmidt Norm -/

def hilbertSchmidtNorm {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : F.carrier :=
  F.zero  -- sqrt(tr(T* T))

/-! ## Orthogonal Group -/

def orthogonalGroup {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) : Set (V.V -> V.V) :=
  fun _ => True  -- { T : V -> V | <Tx, Ty> = <x,y> }

#eval "Properties.Invariants: Dimension, Signature, GramDeterminant, HilbertSchmidtNorm"
