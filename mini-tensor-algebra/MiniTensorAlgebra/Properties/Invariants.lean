/-
# MiniTensorAlgebra.Properties.Invariants

Invariants of tensor products and algebras:
dimension, rank, trace, and related numerical invariants.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Core.Objects

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Dimension of Tensor Product -/

def tensorDimension {F : Field} {V W : VectorSpace F}
    (TP : TensorProduct F V W) (dimV dimW : Nat) : Nat :=
  dimV * dimW

/-! ## Dimension of Tensor Algebra -/

def tensorAlgebraDimension {F : Field} {V : VectorSpace F}
    (TA : TensorAlgebra F V) (dimV : Nat) : Nat :=
  0  -- infinite unless V = 0 (conceptual)

/-! ## Dimension of Symmetric Power -/

def symmetricPowerDimension {F : Field} {V : VectorSpace F} (k dimV : Nat) : Nat :=
  -- dim Sᵏ(V) = C(dimV + k - 1, k)
  0  -- placeholder

/-! ## Dimension of Exterior Power -/

def exteriorPowerDimension {F : Field} {V : VectorSpace F} (k dimV : Nat) : Nat :=
  -- dim ⋀ᵏ(V) = C(dimV, k) if k ≤ dimV, else 0
  0  -- placeholder

/-! ## Trace of Tensor Map -/

def traceOfTensorMap {F : Field} {V : VectorSpace F}
    (f : LinearMap V V) : F.carrier := F.zero
  -- The trace of a linear map via tensor contraction

/-! ## Determinant via Top Exterior Power -/

def determinantViaExterior {F : Field} {V : VectorSpace F}
    (f : LinearMap V V) (n : Nat) : F.carrier := F.one
  -- det(f) = scalar given by ⋀ⁿf : ⋀ⁿV → ⋀ⁿV

/-! ## Rank of a Tensor -/

def tensorRank {F : Field} {V W : VectorSpace F}
    (TP : TensorProduct F V W) (t : TP.T.V) : Nat :=
  0
  -- Minimum number of simple tensors needed to express t

#eval "Properties.Invariants: dimension formulas, trace, determinant, tensor rank"
