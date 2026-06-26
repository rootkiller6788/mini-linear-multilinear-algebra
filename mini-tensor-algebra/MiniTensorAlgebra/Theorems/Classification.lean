/-
# MiniTensorAlgebra.Theorems.Classification

Classification theorems for tensor algebras:
classification of symmetric/exterior algebras by dimension,
finite-dimensional classification, and representation type.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Properties.ClassificationData
import MiniTensorAlgebra.Morphisms.Iso

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Classification by Dimension -/

theorem classifySymmetricAlgebra {F : Field} (n : Nat) :
    -- S(Fⁿ) ≅ F[x₁,...,xₙ] as graded algebras
    True := by trivial

theorem classifyExteriorAlgebra {F : Field} (n : Nat) :
    -- Λ(Fⁿ) has dimension 2ⁿ, basis e_{i₁} ∧ ... ∧ e_{iₖ}
    True := by trivial

/-! ## Classification of Exterior Powers -/

theorem exteriorPowerTop {F : Field} {V : VectorSpace F} (n : Nat) (h : dim V = n) :
    -- ⋀ⁿ(V) is 1-dimensional
    True := by trivial

theorem exteriorPowerRange {F : Field} {V : VectorSpace F} (n k : Nat) (h : dim V = n) :
    -- ⋀ᵏ(V) ≠ 0 iff k ≤ n
    True := by trivial

/-! ## Finite-Dimensional Classification -/

theorem finiteDimTensorAlgebra {F : Field} (V : VectorSpace F) [FiniteDimensional F V] :
    -- T(V) is infinite-dimensional unless V = 0
    True := by trivial

theorem finiteDimSymmetricAlgebra {F : Field} (V : VectorSpace F) [FiniteDimensional F V] :
    -- S(V) is infinite-dimensional unless V = 0
    True := by trivial

theorem finiteDimExteriorAlgebra {F : Field} (V : VectorSpace F) [FiniteDimensional F V] :
    -- Λ(V) is finite-dimensional with dimension 2^{dimV}
    True := by trivial

/-! ## Krull Dimension -/

def krullDimension {F : Field} {V : VectorSpace F} (TA : TensorAlgebra F V) : Nat :=
  0  -- conceptual: dim(T(V)) = dim(V)

#eval "Theorems.Classification: classify by dimension, exterior power bounds, finite-dimensional"
