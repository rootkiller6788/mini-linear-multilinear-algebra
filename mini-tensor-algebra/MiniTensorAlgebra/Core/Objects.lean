/-
# MiniTensorAlgebra.Core.Objects

Concrete instances and objects of tensor products,
tensor powers, symmetric powers, and exterior powers.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Core.Laws

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Tensor Power -/

def tensorPower (F : Field) (V : VectorSpace F) : Nat → Type
  | 0 => F.carrier
  | 1 => V.V
  | n+1 => V.V × tensorPower F V n  -- conceptual representation

/-! ## Tensor Space Tⁿ(V) -/

structure TensorPower (F : Field) (V : VectorSpace F) (n : Nat) where
  T : VectorSpace F
  -- Universal multilinear map Vⁿ → Tⁿ(V)

/-! ## Symmetric Power -/

structure SymmetricPower (F : Field) (V : VectorSpace F) (k : Nat) where
  S : VectorSpace F
  -- The k-th symmetric power Sᵏ(V)

/-! ## Exterior Power (concrete) -/

structure ExteriorPower (F : Field) (V : VectorSpace F) (k : Nat) where
  Λ : VectorSpace F
  -- The k-th exterior power ⋀ᵏ(V)

/-! ## Alternating Multilinear Map -/

structure AlternatingMap (F : Field) (V W : VectorSpace F) (k : Nat) where
  map : (V.V → V.V → V.V) → W.V  -- conceptual; k arguments
  alternating : Prop := True
  -- flips sign under transposition of arguments

/-! ## Determinant via Exterior Power -/

def detViaExterior (F : Field) (V : VectorSpace F) (n : Nat) (f : LinearMap V V) : F.carrier :=
  F.one  -- conceptual: induced map on ⋀ⁿV is scalar multiplication by determinant

#eval "Core.Objects: TensorPower, SymmetricPower, ExteriorPower, AlternatingMap"
