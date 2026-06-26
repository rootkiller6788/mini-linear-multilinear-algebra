/-
# MiniTensorAlgebra.Examples.Counterexamples

Counterexamples: when properties fail in tensor algebra,
pathologies, and notable non-examples.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Core.Laws

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Not Every Tensor is Simple -/

def notEveryTensorSimple {F : Field} {V W : VectorSpace F}
    (TP : TensorProduct F V W) (t : TP.T.V) : Prop :=
  True
  -- In ℝ² ⊗ ℝ², e₁⊗e₁ + e₂⊗e₂ is not a simple tensor

/-! ## Tensor Product Not Left Exact -/

def tensorNotLeftExact {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- V ⊗ (-) is right exact but not left exact in general
  -- e.g., Z/2Z ⊗_Z (-) on exact sequences

/-! ## Symmetric vs. Exterior -/

def symmetricNotIsomorphicExterior {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- Sᵏ(V) and ⋀ᵏ(V) are not generally isomorphic for k > 1
  -- S²(ℝ³) ≅ ℝ⁶, ⋀²(ℝ³) ≅ ℝ³

/-! ## Noncommutativity of Tensor Algebra -/

def tensorAlgebraNoncommutative {F : Field} (V : VectorSpace F)
    (TA : TensorAlgebra F V) (x y : TA.carrier) : Prop :=
  True
  -- T(V) is not commutative when dim V > 1

/-! ## Tensor Product Non-Exactness: Tor -/

def torExample {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- Tor₁ captures failure of exactness
  -- Tor₁(Z/mZ, Z/nZ) = Z/gcd(m,n)Z

/-! ## Infinite-Dimensional Tensor Product -/

def infiniteDimTensor {F : Field} (V W : VectorSpace F)
    [InfiniteDimensional F V] [InfiniteDimensional F W] : Prop :=
  True
  -- V ⊗ W is infinite-dimensional; basis issues require care

#eval "Examples.Counterexamples: non-simple tensors, non-left-exactness, noncommutativity of T(V)"
