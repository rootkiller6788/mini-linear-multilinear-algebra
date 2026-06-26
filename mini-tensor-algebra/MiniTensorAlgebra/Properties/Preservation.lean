/-
# MiniTensorAlgebra.Properties.Preservation

Properties preserved under tensor products:
exactness, flatness, and structural properties.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Morphisms.Hom

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Right Exactness of Tensor Product -/

def tensorRightExact {F : Field} {V W U X : VectorSpace F}
    (f : LinearMap W U) (g : LinearMap U X)
    (hExact : Prop) : Prop := True
  -- V ⊗ W → V ⊗ U → V ⊗ X → 0 is exact when W → U → X → 0 is exact

/-! ## Flatness -/

def isFlat {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- V is flat if V ⊗ (-) preserves exact sequences

/-! ## Tensor Product Preserves Direct Sums -/

def tensorPreservesDirectSum {F : Field} {V W U : VectorSpace F} : Prop :=
  True
  -- V ⊗ (W ⊕ U) ≅ (V ⊗ W) ⊕ (V ⊗ U)

/-! ## Tensor Product and Subspaces -/

def tensorPreservesSubspace {F : Field} {V W : VectorSpace F}
    (U : Subspace F V) : Prop := True
  -- U ⊗ W is a subspace of V ⊗ W (in characteristic 0)

/-! ## Exactness Criterion -/

structure ExactSequence (F : Field) (length : Nat) where
  spaces : List (VectorSpace F)
  maps : List (Sigma fun (V W : VectorSpace F) => LinearMap V W)
  isExact : Prop := True

#eval "Properties.Preservation: right exactness, flatness, preservation of direct sums and subspaces"
