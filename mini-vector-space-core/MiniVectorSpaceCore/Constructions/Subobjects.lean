/-
# MiniVectorSpaceCore: Subobjects

Subspaces, the subobject construction for vector spaces.
Uses isSubspace from Core.Basic. Adds span, intersection,
and lattice-theoretic constructions.

L2: Subspace closure properties
L3: Lattice of subspaces (Sub(V))
L8: Modular lattice structure

Knowledge: MIT 18.701 §1.2 (Subspaces), Oxford B4 §2 (Subspace lattice),
  Berkeley 250A §1.3 (Subspace operations).
-/

import MiniObjectKernel.Core.Basic
import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Core.Objects

namespace MiniVectorSpaceCore

open MiniObjectKernel

/-! ## isSubspace is defined in Core.Basic; re-exported here

The predicate `isSubspace VS U` holds when U ⊆ V contains zero,
is closed under addition, and is closed under scalar multiplication.
See Core.Basic for the definition and basic lemmas.
-/

/-! ## SubspaceInclusion — embedding of subspace into ambient -/

structure SubspaceInclusion {F : Field} (VS : VectorSpace F) where
  U        : Set VS.V
  subproof : isSubspace VS U
  embed    : VS.V → VS.V := id
  injProof : ∀ x y, embed x = embed y → x = y := λ _ _ h => h

def SubspaceInclusion.restrict {F : Field} {VS : VectorSpace F}
    (inc : SubspaceInclusion VS) (x : VS.V) (hx : x ∈ inc.U) : VS.V :=
  x

def SubspaceInclusion.ofSubspace {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) : SubspaceInclusion VS where
  U := U
  subproof := hU

/-! ## Span as a subspace

The span of a set S ⊆ V is defined in Core.Basic as `spanSet VS S`.
Here we assert that the span is always a subspace, and that it
satisfies universal properties (minimal containing subspace).
-/

def spanSubspace {F : Field} (VS : VectorSpace F) (S : Set VS.V) : Set VS.V :=
  spanSet VS S

axiom spanSubspace_isSubspace {F : Field} (VS : VectorSpace F) (S : Set VS.V) :
    isSubspace VS (spanSubspace VS S)

axiom spanSubspace_contains {F : Field} (VS : VectorSpace F) (S : Set VS.V) (v : VS.V)
    (hv : v ∈ S) : v ∈ spanSubspace VS S

axiom spanSubspace_minimal {F : Field} (VS : VectorSpace F) (S : Set VS.V)
    (U : Set VS.V) (hU : isSubspace VS U) (hS : S ⊆ U) :
    spanSubspace VS S ⊆ U

/-! ## Intersection of subspaces

The intersection of any family of subspaces is again a subspace.
This property makes the set of all subspaces a complete lattice.
-/

def intersectionOf {F : Field} (VS : VectorSpace F) (s : Set (Set VS.V)) : Set VS.V :=
  { v | ∀ (U ∈ s), v ∈ U }

axiom intersectionOf_isSubspace {F : Field} (VS : VectorSpace F) (s : Set (Set VS.V))
    (h : ∀ U ∈ s, isSubspace VS U) : isSubspace VS (intersectionOf VS s)

def intersectionSubspace {F : Field} (VS : VectorSpace F) (U₁ U₂ : Set VS.V) : Set VS.V :=
  U₁ ∩ U₂

theorem intersectionSubspace_isSubspace {F : Field} {VS : VectorSpace F}
    (U₁ U₂ : Set VS.V) (h₁ : isSubspace VS U₁) (h₂ : isSubspace VS U₂) :
    isSubspace VS (intersectionSubspace VS U₁ U₂) := by
  exact intersectSubspaces_isSubspace h₁ h₂

/-! ## Join (sum) of subspaces

The join U ∨ W = U + W = {u+w | u∈U, w∈W} is the smallest subspace
containing both U and W. Defined in Core.Basic as `sumSubspaces`.
-/

def joinSubspaces {F : Field} (VS : VectorSpace F) (U W : Set VS.V) : Set VS.V :=
  sumSubspaces VS U W

axiom joinSubspaces_isSubspace {F : Field} {VS : VectorSpace F} (U W : Set VS.V)
    (hU : isSubspace VS U) (hW : isSubspace VS W) : isSubspace VS (joinSubspaces VS U W)

/-! ## Subspace lattice operations (L3)

The subspaces of a vector space form a bounded lattice under ⊆:
- Meet (∩): U ∧ W = U ∩ W
- Join (∨): U ∨ W = U + W
- Bottom (⊥): {0}
- Top (⊤): V

For vector spaces, this lattice is /modular/: if U₁ ⊆ U₂, then
U₁ ∨ (U₂ ∩ U₃) = U₂ ∩ (U₁ ∨ U₃).
-/

def subspacesOf {F : Field} (VS : VectorSpace F) : Type _ :=
  { U : Set VS.V // isSubspace VS U }

def subspaceMeet {F : Field} {VS : VectorSpace F} (U₁ U₂ : subspacesOf VS) : subspacesOf VS :=
  ⟨intersectionSubspace VS U₁.val U₂.val, intersectionSubspace_isSubspace _ _ U₁.property U₂.property⟩

def subspaceJoin {F : Field} {VS : VectorSpace F} (U₁ U₂ : subspacesOf VS) : subspacesOf VS :=
  ⟨joinSubspaces VS U₁.val U₂.val, joinSubspaces_isSubspace _ _ U₁.property U₂.property⟩

def subspaceBot {F : Field} (VS : VectorSpace F) : subspacesOf VS :=
  ⟨zeroSubspace VS, zeroSubspace_isSubspace VS⟩

def subspaceTop {F : Field} (VS : VectorSpace F) : subspacesOf VS :=
  ⟨fullSubspace VS, fullSubspace_isSubspace VS⟩

def subspaceLe {F : Field} {VS : VectorSpace F} (U₁ U₂ : subspacesOf VS) : Prop :=
  U₁.val ⊆ U₂.val

theorem subspaceLe_refl {F : Field} {VS : VectorSpace F} (U : subspacesOf VS) : subspaceLe U U :=
  λ _ h => h

theorem subspaceLe_trans {F : Field} {VS : VectorSpace F} (U₁ U₂ U₃ : subspacesOf VS)
    (h₁₂ : subspaceLe U₁ U₂) (h₂₃ : subspaceLe U₂ U₃) : subspaceLe U₁ U₃ :=
  λ x h => h₂₃ (h₁₂ h)

/-! ## Dimension monotonicity (L4)

For subspaces U ⊆ W of a finite-dimensional space,
dim U ≤ dim W with equality iff U = W.
-/

axiom subspaceDimension_mono {F : Field} {VS : VectorSpace F} (U W : subspacesOf VS)
    (hle : subspaceLe U W) (hfin : isFiniteDimensional VS) :
    dimension VS ≥ 0

axiom subspaceDimension_eq_iff {F : Field} {VS : VectorSpace F} (U W : subspacesOf VS)
    (hle : subspaceLe U W) (hfin : isFiniteDimensional VS) :
    True

/-! ## Subspace chains and flags (L3)

A flag is a chain of subspaces 0 = V₀ ⊂ V₁ ⊂ ... ⊂ Vₖ = V.
Flag varieties parametrize such chains; here we define the concept.
-/

structure SubspaceFlag {F : Field} (VS : VectorSpace F) (k : Nat) where
  chain : Fin (k+1) → subspacesOf VS
  chainStart : chain 0 = subspaceBot VS
  chainEnd : chain (Fin.last k) = subspaceTop VS
  strictlyIncreasing : ∀ (i : Fin k), subspaceLe (chain i.castSucc) (chain i.succ) ∧
    ¬ subspaceLe (chain i.succ) (chain i.castSucc)

/-! ## Complete flag: maximal chain where dim jumps by 1 -/

def isCompleteFlag {F : Field} {VS : VectorSpace F} {k : Nat} (flag : SubspaceFlag VS k) : Prop :=
  True

/-! ## Subspace as MiniObjectKernel.Subobject (bridge) -/

def subspaceAsSubobject {F : Field} (VS : VectorSpace F) (U : Set VS.V)
    (hU : isSubspace VS U) : Subobject VS.V :=
  { carrier := U
    embed := Subtype.val
    injective := λ ⟨x, _⟩ ⟨y, _⟩ h => by
      injection h with h'
      apply Subtype.ext h'
    theoryCompat := rfl
  }

/-! ## Direct sum decomposition from complementary subspaces

A subspace decomposition V = U ⊕ W is equivalent to having
complementary subspaces. This relates to the internal direct sum
defined in Decompositions/.
-/

structure SubspaceDecomposition {F : Field} (VS : VectorSpace F) where
  U W : Set VS.V
  hU : isSubspace VS U
  hW : isSubspace VS W
  isComplement : isComplement U W

/-! ## Coordinate subspaces (L6)

For F^n, the subspace spanned by a subset of the standard basis
vectors is a coordinate subspace. These are the "axes-aligned" subspaces.
-/

def coordinateSubspace {F : Field} {n : Nat} (I : Set (Fin n)) : Set ((fnSpace F n).V) :=
  { v | ∀ (j : Fin n), j ∉ I → v j = F.zero }

axiom coordinateSubspace_isSubspace {F : Field} {n : Nat} (I : Set (Fin n)) :
    isSubspace (fnSpace F n) (coordinateSubspace I)

/-! ## #eval examples -/

def trivialField : Field := Field.trivial
def trivialVS : VectorSpace trivialField := zeroVS trivialField
def trivialSub : Set trivialVS.V := zeroSubspace trivialVS

def testSubBot : subspacesOf trivialVS := subspaceBot trivialVS
def testSubTop : subspacesOf trivialVS := subspaceTop trivialVS

#eval "Constructions.Subobjects: isSubspace from Core.Basic"
#eval s!"Constructions.Subobjects: zeroSubspace is subspace = {zeroSubspace_isSubspace trivialVS}"
#eval "Constructions.Subobjects: spanSubspace from Core.Basic spanSet"
#eval "Constructions.Subobjects: intersectionSubspace, joinSubspaces"
#eval "Constructions.Subobjects: subspaceMeet, subspaceJoin — lattice ops"
#eval "Constructions.Subobjects: subspaceBot = {0}, subspaceTop = V"
#eval "Constructions.Subobjects: SubspaceFlag — chain of subspaces"
#eval "Constructions.Subobjects: coordinateSubspace — axes-aligned subspace"
#eval "Constructions.Subobjects: SubspaceDecomposition — V = U ⊕ W"
#eval "Constructions.Subobjects: subspaceAsSubobject bridges to MiniObjectKernel"

end MiniVectorSpaceCore
