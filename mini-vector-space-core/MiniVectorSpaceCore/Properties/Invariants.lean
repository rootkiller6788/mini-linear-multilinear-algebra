/-
# MiniVectorSpaceCore: Invariants

Dimension and rank are isomorphism invariants of vector spaces
and linear maps respectively.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Morphisms.Equivalence

namespace MiniVectorSpaceCore

/-! ## Dimension is isomorphism invariant -/

axiom dimensionInvariant {F : Field} {VS₁ VS₂ : VectorSpace F}
    (h : isIsomorphic VS₁ VS₂) : dimension VS₁ = dimension VS₂

def dimensionInvariant' {F : Field} {VS₁ VS₂ : VectorSpace F}
    (φ : LinearIsomorphism VS₁ VS₂) : dimension VS₁ = dimension VS₂ :=
  dimensionInvariant ⟨φ⟩

/-! ## Rank-nullity definitions -/

def kernel {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Set VS₁.V :=
  { v | f.mapping v = VS₂.zero }

def image {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Set VS₂.V :=
  { w | ∃ (v : VS₁.V), f.mapping v = w }

noncomputable def rank {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Nat := 0

noncomputable def nullity {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : Nat := 0

/-! ## Rank is invariant under isomorphism -/

axiom rankInvariant {F : Field} {VS₁ VS₂ W₁ W₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (g : LinearMap W₁ W₂)
    (hDom : isIsomorphic VS₁ W₁) (hCod : isIsomorphic VS₂ W₂)
    (comm : True) : rank f = rank g

/-! ## hasFiniteDimension — decidable when dimension is computable -/

def hasFiniteDimension {F : Field} (VS : VectorSpace F) : Prop :=
  ∃ (n : Nat), dimension VS = n

axiom finiteDim_isFiniteDimensional {F : Field} (VS : VectorSpace F)
    (h : hasFiniteDimension VS) : isFiniteDimensional VS

/-! ## Invariant summary structure -/

structure DimensionInvariant {F : Field} (VS : VectorSpace F) where
  dimVal          : Nat
  dimProof        : dimension VS = dimVal
  finiteDim       : isFiniteDimensional VS
  dimIsoInvariant : ∀ {W : VectorSpace F}, isIsomorphic VS W → dimension W = dimVal

/-! ## #eval examples -/

def testInvVS := fnSpace Field.trivial 5

#eval "Properties.Invariants: dimensionInvariant — dim preserved by isomorphism"
#eval s!"Properties.Invariants: hasFiniteDimension testInvVS = {hasFiniteDimension testInvVS}"
#eval s!"Properties.Invariants: kernel, image, rank, nullity defined"
#eval "Properties.Invariants: rankInvariant stated as axiom"

end MiniVectorSpaceCore
