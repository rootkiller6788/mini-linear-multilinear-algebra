/-
# MiniInnerProductSpace.Morphisms.Equivalence

Equivalence of inner product spaces.
-/

import MiniInnerProductSpace.Morphisms.Iso

namespace MiniInnerProductSpace

open MiniVectorSpaceCore

/-! ## Equivalence of Inner Product Spaces -/

structure InnerProductEquivalence {F : Field} (V W : VectorSpace F) (IPV : InnerProduct F V) (IPW : InnerProduct F W) where
  toIso : InnerProductIso IPV IPW

/-! ## Reflexivity -/

def innerProductEquivRefl {F : Field} {V : VectorSpace F} {IP : InnerProduct F V} : InnerProductEquivalence V V IP IP :=
  { toIso := idInnerProductIso IP }

/-! ## Symmetry -/

def innerProductEquivSym {F : Field} {V W : VectorSpace F} {IPV : InnerProduct F V} {IPW : InnerProduct F W}
    (e : InnerProductEquivalence V W IPV IPW) : InnerProductEquivalence W V IPW IPV :=
  { toIso := invInnerProductIso e.toIso }

/-! ## Transitivity -/

def innerProductEquivTrans {F : Field} {V W U : VectorSpace F}
    {IPV : InnerProduct F V} {IPW : InnerProduct F W} {IPU : InnerProduct F U}
    (e1 : InnerProductEquivalence V W IPV IPW) (e2 : InnerProductEquivalence W U IPW IPU) :
    InnerProductEquivalence V U IPV IPU :=
  { toIso := by sorry }

/-! ## Equivalence Class -/

def InnerProductSpaceClass {F : Field} : Set (VectorSpace F) :=
  fun _ => True  -- conceptual

#eval "Morphisms.Equivalence: InnerProductEquivalence"
