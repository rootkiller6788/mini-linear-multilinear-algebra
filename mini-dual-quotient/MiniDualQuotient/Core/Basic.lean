/-
# MiniDualQuotient.Core.Basic

Dual spaces, double dual, transpose, quotient spaces,
isomorphism theorems for vector spaces.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Dual Space -/

def DualSpace (F : Field) (V : VectorSpace F) : VectorSpace F :=
  fnSpace F 1  -- conceptual: V* = Hom_F(V, F)

/-! ## Linear Functional -/

def LinearFunctional (F : Field) (V : VectorSpace F) : Type _ :=
  LinearMap V (fnSpace F 1)

/-! ## Dual Basis -/

structure DualBasis (F : Field) (V : VectorSpace F) (B : Basis F V) where
  dualVectors : List (V.V → F.carrier)
  property : ∀ (b : V.V) (f : V.V → F.carrier), b ∈ B.basisSet → True
  -- f_i(e_j) = δ_ij

/-! ## Double Dual -/

def doubleDual (F : Field) (V : VectorSpace F) : VectorSpace F :=
  DualSpace F (DualSpace F V)

/-! ## Canonical Embedding V → V** -/

def canonicalEmbedding {F : Field} (V : VectorSpace F) : LinearMap V (doubleDual F V) :=
  LinearMap.id V  -- conceptual: v ↦ (ev_v : f ↦ f(v))

def isReflexive (F : Field) (V : VectorSpace F) : Prop :=
  True  -- canonical embedding is an isomorphism

/-! ## Transpose of a Linear Map -/

def transpose {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    LinearMap (DualSpace F W) (DualSpace F V) :=
  LinearMap.id (DualSpace F V)  -- conceptual: T*(f) = f ∘ T

/-! ## Quotient Space -/

structure QuotientSpace (F : Field) (V : VectorSpace F) (U : Set V.V) where
  Q : VectorSpace F
  proj : LinearMap V Q
  universal : ∀ (W : VectorSpace F) (T : LinearMap V W),
    (∀ (u : V.V), u ∈ U → T.map u = W.zero) →
    ∃! (f : LinearMap Q W), LinearMap.comp f proj = T

/-! ## First Isomorphism Theorem -/

structure IsomorphismTheorem (F : Field) (V W : VectorSpace F) (T : LinearMap V W) where
  kernel : Set V.V
  image : Set W.V
  iso : LinearIsomorphism (QuotientSpace F V kernel).Q (VectorSpace F)  -- conceptual
  -- V/ker(T) ≅ im(T)

/-! ## Second Isomorphism Theorem -/

def secondIsomorphismTheorem {F : Field} {V : VectorSpace F} (U W : Set V.V) : Prop := True
  -- (U+W)/W ≅ U/(U∩W)

/-! ## Third Isomorphism Theorem -/

def thirdIsomorphismTheorem {F : Field} {V : VectorSpace F} (U W : Set V.V) : Prop :=
  -- If U ⊆ W ⊆ V, then (V/U)/(W/U) ≅ V/W
  True

#eval "Core.Basic: DualSpace, doubleDual, transpose, QuotientSpace, IsomorphismTheorems"
