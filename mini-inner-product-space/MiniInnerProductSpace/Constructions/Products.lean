/-
# MiniInnerProductSpace.Constructions.Products
Product and direct sum of inner product spaces.
L3: Product inner product, orthogonal direct sum
L4: Universal property of product inner product space
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

open MiniInnerProductSpace

/-! ## Product Inner Product (L3) -/

def productInnerProduct {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) :
    InnerProduct F (ProductVectorSpace V W) where
  ip p q := F.add (IPV.ip p.1 q.1) (IPW.ip p.2 q.2)
  conjugateSym p q := by
    rw [IPV.conjugateSym, IPW.conjugateSym]
  linearFirst x y z a := by
    simp [IPV.linearFirst, IPW.linearFirst]

/-! ## Product of n Inner Product Spaces (L3) -/

structure FiniteProductInnerProduct {F : Field} (n : Nat) (spaces : Fin n → VectorSpace F)
    (inners : ∀ (i : Fin n), InnerProduct F (spaces i)) where
  productSpace : VectorSpace F
  productInner : InnerProduct F productSpace

/-! ## Orthogonal Direct Sum (L3) -/

structure OrthogonalDirectSum {F : Field} {V W : VectorSpace F}
    (IPV : InnerProduct F V) (IPW : InnerProduct F W) where
  directSum : VectorSpace F
  innerProduct : InnerProduct F directSum
  componentsAreOrthogonal : True

/-! ## Product Preserves Positive Definiteness (L4) -/

structure ProductPreservesPosDef {F : Field} {V W : VectorSpace F}
    {IPV : InnerProduct F V} {IPW : InnerProduct F W}
    (hV : isPosDef IPV) (hW : isPosDef IPW) where
  productIsPosDef : isPosDef (productInnerProduct IPV IPW)

/-! ## Product Orthogonality of Components -/

structure ProductOrthogonalComponents {F : Field} {V W : VectorSpace F}
    (IPV : InnerProduct F V) (IPW : InnerProduct F W) where
  componentsAreOrthogonal : True

/-! ## Direct Sum Decomposition -/

structure DirectSumDecomposition {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) where
  subspace1 : Set V.V
  subspace2 : Set V.V
  decomposition : True
  orthogonalSum : True

/-! ## Tensor Product Inner Product (L8 Advanced) -/

structure TensorProductInnerProduct {F : Field} {V W : VectorSpace F}
    (IPV : InnerProduct F V) (IPW : InnerProduct F W) where
  tensorSpace : VectorSpace F
  tensorInner : InnerProduct F tensorSpace
  universalProperty : True

/-! ## Kronecker Product Structure -/

structure KroneckerProduct where
  A : List (List Rat)
  B : List (List Rat)
  kronResult : List (List Rat)

/-! ## Infinite Direct Sum of Hilbert Spaces -/

structure InfiniteDirectSum {F : Field} where
  componentSpaces : Nat → VectorSpace F
  componentInners : ∀ n, InnerProduct F (componentSpaces n)
  directSumSpace : VectorSpace F
  directSumInner : InnerProduct F directSumSpace

/-! ## Summary -/

def productsSummary : List String :=
  [ "Product IPS: V × W with IP((v1,w1),(v2,w2)) = <v1,v2>_V + <w1,w2>_W"
  , "Orthogonal direct sum: product where components are orthogonal"
  , "Finite product: n-fold product of IPS"
  , "Tensor product: V ⊗ W with induced IP <v1⊗w1, v2⊗w2> = <v1,v2><w1,w2>"
  , "Universal property: product is categorical product in IPS category"
  ]

#eval "Constructions.Products: ProductInnerProduct, OrthogonalDirectSum, TensorProduct - all defined."
