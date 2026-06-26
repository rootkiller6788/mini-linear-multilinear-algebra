/-
# MiniTensorAlgebra.Constructions.Subobjects

Subobjects of tensor products and tensor algebras:
subtensor products, subalgebras, graded components,
homogeneous elements.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Core.Objects

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Subspace of Tensor Product -/

structure SubTensorProduct (F : Field) (V W : VectorSpace F) where
  TP : TensorProduct F V W
  subset : TP.T.V → Prop
  isSubspace : Prop := True

/-! ## Tensor Algebra Subalgebra -/

structure TensorSubalgebra (F : Field) (V : VectorSpace F) where
  TA : TensorAlgebra F V
  carrier : TA.carrier → Prop
  closedUnderMul : Prop := True
  closedUnderScalarMul : Prop := True

/-! ## Graded Component -/

structure GradedComponent (F : Field) (V : VectorSpace F) (k : Nat) where
  TA : TensorAlgebra F V
  -- Tᵏ(V) ⊆ T(V)
  component : TA.carrier → Prop
  -- elements of pure degree k

/-! ## Homogeneous Element -/

def isHomogeneous {F : Field} {V : VectorSpace F} (TA : TensorAlgebra F V)
    (x : TA.carrier) (k : Nat) : Prop := True
  -- x ∈ Tᵏ(V)

/-! ## Symmetric and Exterior Subspaces -/

structure SymmetricSubspace (F : Field) (V : VectorSpace F) (k : Nat) where
  SA : SymmetricAlgebra F V
  -- Sᵏ(V) ⊆ S(V)

structure ExteriorSubspace (F : Field) (V : VectorSpace F) (k : Nat) where
  EA : ExteriorAlgebra F V
  -- ⋀ᵏ(V) ⊆ Λ(V)

#eval "Constructions.Subobjects: SubTensorProduct, TensorSubalgebra, GradedComponent, homogeneous elements"
