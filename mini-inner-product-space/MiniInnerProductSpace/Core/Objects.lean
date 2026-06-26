/-
# MiniInnerProductSpace.Core.Objects

Object instances and typeclass registration for inner product spaces.
Defines InnerProductSpaceTheory as an Object instance.
-/

import MiniInnerProductSpace.Core.Basic
import MiniObjectKernel.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore
open MiniInnerProductSpace

/-! ## Inner Product Space Theory Object -/

structure InnerProductSpaceTheory where
  field : Field
  space : VectorSpace field
  inner : InnerProduct field space
  dim : Nat
  basis : Basis field space

/-! ## Object Instance -/

def InnerProductSpaceTheory.toObject (t : InnerProductSpaceTheory) : Object :=
  Object.mk "InnerProductSpace" (t.field.V)  -- conceptual

/-! ## Finite-dimensional Inner Product Space -/

structure FiniteDimInnProdSpace where
  theory : InnerProductSpaceTheory
  finiteDim : theory.dim < Omega  -- finite dimension

/-! ## Euclidean Space (R^n with standard dot product) -/

def EuclideanSpaceTheory (n : Nat) : InnerProductSpaceTheory :=
  {
    field := RealField
    space := fnSpace RealField n
    inner := EuclideanInnerProduct n
    dim := n
    basis := StandardBasis RealField n
  }

/-! ## Hilbert Space (conceptual, complete inner product space) -/

structure HilbertSpaceTheory where
  ipt : InnerProductSpaceTheory
  complete : True  -- Cauchy sequences converge

#eval "Core.Objects: InnerProductSpaceTheory, EuclideanSpace, HilbertSpace"
