/-
# MiniInnerProductSpace.Core.Objects
Object instances for inner product space theory.
L3: InnerProductSpaceTheory, HilbertSpaceTheory
L6: EuclideanSpaceTheory (concrete instance)
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

open MiniInnerProductSpace

/-! ## Inner Product Space Theory Object (L3) -/

structure InnerProductSpaceTheory where
  field : Field
  space : VectorSpace field
  inner : InnerProduct field space
  dim : Nat
  basis : Basis field space

/-! ## Object Instance (conceptual) -/

def InnerProductSpaceTheory.name (t : InnerProductSpaceTheory) : String := "InnerProductSpace"

/-! ## Finite-dimensional Inner Product Space -/

structure FiniteDimInnProdSpace where
  theory : InnerProductSpaceTheory
  finiteDim : theory.dim < 42

/-! ## Euclidean Space Theory Q^n (L6 Concrete) -/

def EuclideanSpaceTheory (n : Nat) : InnerProductSpaceTheory :=
  {
    field := RatField.inst
    space := fnSpace RatField.inst n
    inner := EuclideanInnerProduct n
    dim := n
    basis := {
      basisSet := fun _ => True
      spanning := True.intro
      independent := True.intro
    }
  }

/-! ## Hilbert Space Theory (conceptual) (L8) -/

structure HilbertSpaceTheory where
  ipt : InnerProductSpaceTheory
  complete : True

/-! ## Complex Inner Product Space (conceptual) -/

structure ComplexInnerProductSpaceTheory where
  ipt : InnerProductSpaceTheory
  isHermitian : True

/-! ## Pre-Hilbert Space (L8 Advanced) -/

structure PreHilbertSpace where
  ipt : InnerProductSpaceTheory
  separable : True

/-! ## Minkowski Spacetime (L6 Indefinite inner product) -/

structure MinkowskiSpaceTheory where
  dim : Nat
  signature : Nat × Nat

def MinkowskiSpaceTheory.example : MinkowskiSpaceTheory :=
  { dim := 4; signature := (3, 1) }

/-! ## Sobolev Space Theory (L8 Advanced Topic) -/

structure SobolevSpaceTheory where
  baseSpace : InnerProductSpaceTheory
  order : Nat
  integrabilityExponent : Nat

/-! ## Reproducing Kernel Hilbert Space (RKHS) (L8) -/

structure RKHSTtheory where
  baseHilbert : HilbertSpaceTheory
  kernel : True

/-! ## Weighted Inner Product Space -/

structure WeightedInnerProductSpace where
  baseSpace : InnerProductSpaceTheory
  weight : True

/-! ## L^2 Space on a Measure Space (L8) -/

structure L2SpaceTheory where
  measureSpace : True
  innerProd : True

/-! ## Direct Sum of Inner Product Spaces -/

structure DirectSumInnProdSpaceTheory where
  components : List InnerProductSpaceTheory
  orthogonalSum : True

/-! ## Tensor Product of Inner Product Spaces (L8) -/

structure TensorProductInnProdSpaceTheory where
  left : InnerProductSpaceTheory
  right : InnerProductSpaceTheory
  inducedInner : True

/-! ## Indefinite Inner Product Space (Krein Space) (L8) -/

structure KreinSpaceTheory where
  baseSpace : InnerProductSpaceTheory
  fundamentalDecomposition : True

/-! ## Fock Space (Quantum Field Theory) (L8/L9) -/

structure FockSpaceTheory where
  oneParticleSpace : InnerProductSpaceTheory
  vacuum : True

#eval "Core.Objects: InnerProductSpaceTheory, EuclideanSpaceTheory, HilbertSpaceTheory, Sobolev, RKHS, L2, TensorProduct, Fock"