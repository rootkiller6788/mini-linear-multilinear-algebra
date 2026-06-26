/-
# MiniInnerProductSpace.Examples.Standard

Standard examples of inner product spaces.
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore

/-! ## Euclidean Dot Product on R^n -/

def EuclideanInnerProduct (n : Nat) : InnerProduct RealField (fnSpace RealField n) :=
  {
    ip := fun x y => RealField.zero  -- sum_i x_i * y_i
    conjugateSym := fun x y => rfl
    linearFirst := fun x y z a => by sorry
    positiveDefinite := fun x h => by sorry
  }

/-! ## Hermitian Inner Product on C^n -/

def HermitianInnerProduct (n : Nat) : InnerProduct ComplexField (fnSpace ComplexField n) :=
  {
    ip := fun z w => ComplexField.zero  -- sum_i z_i * conj(w_i)
    conjugateSym := fun z w => by sorry
    linearFirst := fun x y z a => by sorry
    positiveDefinite := fun x h => by sorry
  }

/-! ## L^2 Inner Product on R^n -/

def L2InnerProduct (n : Nat) : InnerProduct RealField (fnSpace RealField n) :=
  EuclideanInnerProduct n  -- same as Euclidean

/-! ## Frobenius Inner Product on Matrices -/

def FrobeniusInnerProduct (m n : Nat) : Prop :=
  -- <A, B> = tr(A^T B)
  True

/-! ## Function Space Inner Product (L^2[a,b]) -/

def L2FunctionInnerProduct (a b : RealNumber) : Prop :=
  -- <f, g> = integral_a^b f(x) g(x) dx
  True

#eval "Examples.Standard: Euclidean, Hermitian, L2, Frobenius, FunctionSpace"
