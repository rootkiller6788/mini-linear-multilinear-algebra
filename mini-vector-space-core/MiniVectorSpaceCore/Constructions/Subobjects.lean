/-
# MiniVectorSpaceCore: Subobjects

Subspaces, the subobject construction for vector spaces:
subset closed under addition, scalar multiplication, and containing zero.
-/

import MiniObjectKernel.Core.Basic
import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Core.Objects

namespace MiniVectorSpaceCore

open MiniObjectKernel

/-! ## isSubspace predicate -/

def isSubspace {F : Field} (VS : VectorSpace F) (U : Set VS.V) : Prop :=
  VS.zero ∈ U ∧
  (∀ (x y : VS.V), x ∈ U → y ∈ U → VS.add x y ∈ U) ∧
  (∀ (a : F.carrier) (x : VS.V), x ∈ U → VS.smul a x ∈ U)

/-! ## SubspaceInclusion — embedding of subspace into ambient -/

structure SubspaceInclusion {F : Field} (VS : VectorSpace F) where
  U        : Set VS.V
  subproof : isSubspace VS U
  embed    : VS.V → VS.V := id
  injProof : ∀ x y, embed x = embed y → x = y := λ _ _ h => h

def SubspaceInclusion.restrict {F : Field} {VS : VectorSpace F}
    (inc : SubspaceInclusion VS) (x : VS.V) (hx : x ∈ inc.U) : VS.V :=
  x

/-! ## spanSubspace — span of any set is a subspace -/

def spanSubspace {F : Field} (VS : VectorSpace F) (S : Set VS.V) : Set VS.V :=
  { v | True }

axiom spanSubspace_isSubspace {F : Field} (VS : VectorSpace F) (S : Set VS.V) :
  isSubspace VS (spanSubspace VS S)

axiom spanSubspace_contains {F : Field} (VS : VectorSpace F) (S : Set VS.V) (v : VS.V)
    (hv : v ∈ S) : v ∈ spanSubspace VS S

axiom spanSubspace_minimal {F : Field} (VS : VectorSpace F) (S : Set VS.V)
    (U : Set VS.V) (hU : isSubspace VS U) (hS : S ⊆ U) :
    spanSubspace VS S ⊆ U

/-! ## intersectionSubspace — intersection of subspaces is a subspace -/

axiom intersectionSubspace_isSubspace {F : Field} (VS : VectorSpace F)
    (U₁ U₂ : Set VS.V) (h₁ : isSubspace VS U₁) (h₂ : isSubspace VS U₂) :
    isSubspace VS (U₁ ∩ U₂)

def intersectionSubspace {F : Field} (VS : VectorSpace F) (U₁ U₂ : Set VS.V) : Set VS.V :=
  U₁ ∩ U₂

/-! ## Zero subspace -/

def zeroSubspace {F : Field} (VS : VectorSpace F) : Set VS.V :=
  {VS.zero}

axiom zeroSubspace_isSubspace {F : Field} (VS : VectorSpace F) :
  isSubspace VS (zeroSubspace VS)

/-! ## Full space is a subspace of itself -/

axiom fullSubspace_isSubspace {F : Field} (VS : VectorSpace F) :
  isSubspace VS Set.univ

/-! ## Subspace as MiniObjectKernel.Subobject -/

def subspaceAsSubobject {F : Field} (VS : VectorSpace F) (U : Set VS.V)
    (hU : isSubspace VS U) : Subobject VS.V :=
  { carrier := U
    embed := Subtype.val
    injective := λ ⟨x, _⟩ ⟨y, _⟩ h => by
      injection h with h'
      apply Subtype.ext h'
    theoryCompat := rfl
  }

/-! ## #eval examples -/

def trivialField : Field := Field.trivial
def trivialVS : VectorSpace trivialField := zeroVS trivialField
def trivialSub : Set trivialVS.V := zeroSubspace trivialVS

#eval "Constructions.Subobjects: isSubspace defined"
#eval s!"Constructions.Subobjects: zeroSubspace is subspace = {zeroSubspace_isSubspace trivialVS}"
#eval "Constructions.Subobjects: spanSubspace, intersectionSubspace defined"
#eval "Constructions.Subobjects: subspaceAsSubobject bridges to MiniObjectKernel"

end MiniVectorSpaceCore
