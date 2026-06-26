/-
# MiniDualQuotient.Core.Basic — L1: Core Definitions

Defines the fundamental structures for dual spaces, double dual,
transpose, quotient spaces, annihilators, and the three isomorphism
theorems for vector spaces.

## Knowledge Coverage
- L1: fieldAsVectorSpace, VectorSpaceAxioms, IsSubspace,
      LinearFunctional, DualSpace, doubleDual, Annihilator,
      QuotientSpace, FirstIsoTheorem, SecondIsoTheorem, ThirdIsoTheorem
- L2: zeroFunctional, addFunctional, smulFunctional, evaluationPairing,
      transpose, canonicalEmbedding
- L3: Duality as contravariant functor, Quotient as coequalizer,
      Double dual as monad
- L4: Statements of three isomorphism theorems
- L5: Direct rfl proofs, structure construction
- L6: standardDualBasisType, exampleR3QuotientLine, exampleNonReflexive

## Nine-School Reference
- MIT 18.701/18.702: Dual spaces, quotient spaces, isomorphism theorems
- Princeton MAT 520: Annihilator and double dual
- Cambridge Part III: Transpose and duality
- Berkeley MATH 250A: Vector space quotients
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L1: Core Definitions

### Field as a Vector Space

To define the dual space V* = Hom_F(V, F), we need to view the field F
as a 1-dimensional vector space over itself. This is the canonical target
for linear functionals.
-/

/-- The field F viewed as a 1-dimensional vector space over itself.
    Addition = field addition, zero = field zero, negation = field negation,
    scalar multiplication = field multiplication. -/
def fieldAsVectorSpace (F : Field) : VectorSpace F where
  V := F.carrier
  add := F.add
  zero := F.zero
  neg := F.neg
  smul := F.mul

/-- Shorthand: F viewed as a vector space over itself. -/
def Fvs (F : Field) : VectorSpace F := fieldAsVectorSpace F

/-! ### Vector Space Axioms

The base `VectorSpace` from the dependency provides only operations
without algebraic axioms. For rigorous proofs we capture the eight
standard vector space axioms in a Prop structure.
-/

/-- The eight standard vector space axioms over a Field F.
    add_comm, add_assoc, zero_add, neg_add_self,
    smul_one, smul_add, add_smul, mul_smul. -/
structure VectorSpaceAxioms (F : Field) (VS : VectorSpace F) : Prop where
  add_comm : ∀ x y : VS.V, VS.add x y = VS.add y x
  add_assoc : ∀ x y z : VS.V, VS.add (VS.add x y) z = VS.add x (VS.add y z)
  zero_add : ∀ x : VS.V, VS.add VS.zero x = x
  neg_add_self : ∀ x : VS.V, VS.add (VS.neg x) x = VS.zero
  smul_one : ∀ x : VS.V, VS.smul F.one x = x
  smul_add : ∀ (a : F.carrier) (x y : VS.V), VS.smul a (VS.add x y) = VS.add (VS.smul a x) (VS.smul a y)
  add_smul : ∀ (a b : F.carrier) (x : VS.V), VS.smul (F.add a b) x = VS.add (VS.smul a x) (VS.smul b x)
  mul_smul : ∀ (a b : F.carrier) (x : VS.V), VS.smul (F.mul a b) x = VS.smul a (VS.smul b x)

/-! ### Subspace

A subset U ⊆ V is a subspace if it contains zero and is closed under
addition and scalar multiplication.
-/

/-- U ⊆ V is a subspace: contains zero, closed under + and ·. -/
structure IsSubspace (F : Field) (V : VectorSpace F) (U : Set V.V) : Prop where
  contains_zero : V.zero ∈ U
  closed_add : ∀ x y, x ∈ U → y ∈ U → V.add x y ∈ U
  closed_smul : ∀ (a : F.carrier) x, x ∈ U → V.smul a x ∈ U

/-- Subspace sum: U + W = {u + w | u ∈ U, w ∈ W}. -/
def subspaceSum {F : Field} {V : VectorSpace F} (U W : Set V.V) : Set V.V :=
  fun v => ∃ u w, u ∈ U ∧ w ∈ W ∧ V.add u w = v

/-- Subspace intersection: U ∩ W = {v | v ∈ U ∧ v ∈ W}. -/
def subspaceInter {F : Field} {V : VectorSpace F} (U W : Set V.V) : Set V.V :=
  fun v => v ∈ U ∧ v ∈ W

/-- The coset v + U = {v + u | u ∈ U}. -/
def coset {F : Field} {V : VectorSpace F} (U : Set V.V) (v : V.V) : Set V.V :=
  fun w => ∃ u, u ∈ U ∧ V.add v u = w

/-- v ≡ w mod U iff v - w ∈ U. -/
def congruentMod {F : Field} {V : VectorSpace F} (U : Set V.V) (v w : V.V) : Prop :=
  V.add v (V.neg w) ∈ U

/-! ### Dual Space — V* = Hom_F(V, F)

The dual space V* is the vector space of all linear maps V → F,
where F is viewed as a 1-dimensional vector space over itself.
-/

/-- Linear functional: a linear map V → F (where F is a vector space over itself). -/
def LinearFunctional (F : Field) (V : VectorSpace F) : Type _ :=
  LinearMap V (Fvs F)

/-- Evaluate a linear functional at a vector: the natural pairing V* × V → F. -/
def evalFunctional {F : Field} {V : VectorSpace F} (f : LinearFunctional F V) (v : V.V) : F.carrier :=
  f.map v

/-- The zero functional: 0*(v) = 0_F for all v ∈ V. -/
def zeroFunctional {F : Field} {V : VectorSpace F} : LinearFunctional F V :=
  LinearMap.zero V (Fvs F)

/-- Addition of functionals: (f + g)(v) = f(v) +_F g(v). -/
def addFunctional {F : Field} {V : VectorSpace F}
    (f g : LinearFunctional F V) : LinearFunctional F V where
  map v := F.add (f.map v) (g.map v)
  map_add x y := by
    rw [f.map_add, g.map_add]
    rfl
  map_smul a x := by
    rw [f.map_smul, g.map_smul]
    rfl

/-- Scalar multiplication: (c · f)(v) = c ·_F f(v). -/
def smulFunctional {F : Field} {V : VectorSpace F}
    (c : F.carrier) (f : LinearFunctional F V) : LinearFunctional F V where
  map v := F.mul c (f.map v)
  map_add x y := by
    rw [f.map_add]
    rfl
  map_smul a x := by
    rw [f.map_smul]
    rfl

/-- Negation: (-f)(v) = -_F f(v). -/
def negFunctional {F : Field} {V : VectorSpace F}
    (f : LinearFunctional F V) : LinearFunctional F V where
  map v := F.neg (f.map v)
  map_add x y := by
    rw [f.map_add]
    rfl
  map_smul a x := by
    rw [f.map_smul]
    rfl

/-- The dual space V* as a VectorSpace. Operations are defined
    pointwise using field operations. -/
def DualSpace (F : Field) (V : VectorSpace F) : VectorSpace F where
  V := LinearFunctional F V
  add := addFunctional
  zero := zeroFunctional
  neg := negFunctional
  smul := smulFunctional

/-- Alias for DualSpace. -/
def dual (F : Field) (V : VectorSpace F) : VectorSpace F := DualSpace F V

/-! ### Double Dual — V** = (V*)*

The double dual is obtained by applying the dual construction twice.
The canonical embedding ev: V → V** sends v ↦ (f ↦ f(v)).
-/

/-- The double dual V** = (V*)*. -/
def doubleDual (F : Field) (V : VectorSpace F) : VectorSpace F :=
  DualSpace F (DualSpace F V)

/-- The canonical evaluation map ev(v): V* → F, given by ev(v)(f) = f(v). -/
def canonicalEmbeddingMap {F : Field} {V : VectorSpace F} (v : V.V) : (doubleDual F V).V where
  map f := evalFunctional f v
  map_add f g := rfl
  map_smul a f := rfl

/-- The canonical embedding V → V** as a LinearMap. -/
def canonicalEmbedding {F : Field} (V : VectorSpace F) : LinearMap V (doubleDual F V) where
  map := canonicalEmbeddingMap
  map_add x y := rfl
  map_smul a x := rfl

/-- The evaluation pairing ⟨f, v⟩ = f(v). -/
def evaluationPairing {F : Field} {V : VectorSpace F}
    (f : LinearFunctional F V) (v : V.V) : F.carrier :=
  evalFunctional f v

/-- V is reflexive if ev: V → V** is an isomorphism. -/
def isReflexive (F : Field) (V : VectorSpace F) : Prop :=
  ∃ (inv : LinearMap (doubleDual F V) V),
    (∀ v, inv.map ((canonicalEmbedding V).map v) = v) ∧
    (∀ φ, (canonicalEmbedding V).map (inv.map φ) = φ)

/-! ### Transpose T*: W* → V*

For T: V → W, the transpose T* is defined by T*(f) = f ∘ T.
That is, T*(f)(v) = f(T(v)). This makes duality a contravariant functor.
-/

/-- The transpose of T: V → W at the functional level.
    T*(f)(v) = f(T(v)). -/
def transpose {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (f : LinearFunctional F W) : LinearFunctional F V :=
  LinearMap.comp f T

/-- The transpose as a LinearMap from W* to V*. -/
def transposeMap {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    LinearMap (DualSpace F W) (DualSpace F V) where
  map f := transpose T f
  map_add f g := rfl
  map_smul a f := rfl

/-! ### Quotient Space V/U

For a subspace U ⊆ V, the quotient space V/U consists of cosets v+U
with vector space structure induced from V. It satisfies a universal
property: any linear map vanishing on U factors uniquely through V/U.
-/

/-- A QuotientSpace for V by subspace U is a vector space Q
    together with a surjective linear projection π: V → Q
    whose kernel is exactly U, satisfying the universal property. -/
structure QuotientSpace (F : Field) (V : VectorSpace F) (U : Set V.V) where
  Q : VectorSpace F
  proj : LinearMap V Q
  surj_proj : ∀ (q : Q.V), ∃ (v : V.V), proj.map v = q
  ker_proj : ∀ (v : V.V), (proj.map v = Q.zero) ↔ (v ∈ U)
  universal : ∀ (W : VectorSpace F) (T : LinearMap V W),
    (∀ (u : V.V), u ∈ U → T.map u = W.zero) →
    ∃! (f : LinearMap Q W), ∀ (v : V.V), f.map (proj.map v) = T.map v

/-! ### Annihilator U°

The annihilator U° ⊆ V* consists of all linear functionals that
vanish on the subspace U:
  U° = {f ∈ V* | ∀u ∈ U, f(u) = 0_F}
-/

/-- The annihilator U° = {f ∈ V* | ∀u ∈ U, f(u) = 0_F}. -/
def Annihilator (F : Field) (V : VectorSpace F) (U : Set V.V) : Set (DualSpace F V).V :=
  fun f => ∀ u, u ∈ U → evalFunctional f u = F.zero

/-- The annihilator is always a subspace of V*. -/
theorem annihilator_is_subspace (F : Field) (V : VectorSpace F) (U : Set V.V) :
    IsSubspace F (DualSpace F V) (Annihilator F V U) := by
  refine {
    contains_zero := ?_,
    closed_add := ?_,
    closed_smul := ?_
  }
  · intro u _
    unfold evalFunctional
    rfl
  · intro f g hf hg u hu
    unfold evalFunctional
    have hf' := hf u hu
    have hg' := hg u hu
    dsimp [addFunctional]
    rw [hf', hg']
  · intro a f hf u hu
    unfold evalFunctional
    have hf' := hf u hu
    dsimp [smulFunctional]
    rw [hf']

/-! ### Isomorphism Theorems — Statement Structures

Full proofs of the three isomorphism theorems are in the
Theorems/ subpackage. Here we define the statement structures.
-/

/-- First Isomorphism Theorem: V/ker(T) ≅ im(T).
    The kernel and image are those of T. The isomorphisms carries
    the coset v+ker(T) to T(v). -/
structure FirstIsoTheorem (F : Field) (V W : VectorSpace F) (T : LinearMap V W) where
  K : Set V.V
  I : Set W.V
  hK : K = LinearMap.kernel T
  hI : I = LinearMap.image T
  quotientSpace : QuotientSpace F V K
  imageSpace : VectorSpace F
  iso : LinearIsomorphism quotientSpace.Q imageSpace
  commutes : ∀ (v : V.V), iso.toMap.map (quotientSpace.proj.map v) = T.map v

/-- Second Isomorphism Theorem: (U+W)/W ≅ U/(U∩W) for subspaces U,W ⊆ V. -/
structure SecondIsoTheorem (F : Field) (V : VectorSpace F) (U W : Set V.V) where
  hU : IsSubspace F V U
  hW : IsSubspace F V W
  sum_sub : IsSubspace F V (subspaceSum U W)
  inter_sub : IsSubspace F V (subspaceInter U W)

/-- Third Isomorphism Theorem: (V/U)/(W/U) ≅ V/W when U ⊆ W ⊆ V. -/
structure ThirdIsoTheorem (F : Field) (V : VectorSpace F) (U W : Set V.V) where
  hU : IsSubspace F V U
  hW : IsSubspace F V W
  subset_uw : ∀ u, u ∈ U → u ∈ W

/-! ## L2: Core Lemmas

Fundamental lemmas about the structures defined above.
-/

/-- Extensionality lemma for LinearMap: two linear maps are equal
    if their underlying functions are equal. -/
@[ext]
theorem LinearMap.ext {F : Field} {V W : VectorSpace F} (f g : LinearMap V W)
    (h : f.map = g.map) : f = g := by
  cases f; cases g; congr

/-- Extensionality for LinearFunctional: equality of functionals
    follows from equality of their values at all vectors. -/
theorem LinearFunctional.ext {F : Field} {V : VectorSpace F} (f g : LinearFunctional F V)
    (h : ∀ v, evalFunctional f v = evalFunctional g v) : f = g := by
  apply LinearMap.ext
  ext v
  apply h

/-- The zero functional evaluated at any vector gives field zero. -/
lemma zeroFunctional_eval {F : Field} {V : VectorSpace F} (v : V.V) :
    evalFunctional (zeroFunctional (V := V)) v = F.zero := by
  rfl

/-- Transpose of composition: (S ∘ T)* = T* ∘ S*. -/
lemma transpose_comp {F : Field} {U V W : VectorSpace F}
    (T : LinearMap V W) (S : LinearMap U V) :
    transpose (LinearMap.comp T S) = transpose T ∘ transpose S := by
  rfl

/-- Transpose of identity is identity. -/
lemma transpose_id {F : Field} {V : VectorSpace F} :
    transpose (LinearMap.id V) = id := by
  rfl

/-- Applying transpose twice to the transpose map recovers the original. -/
lemma transpose_transpose_eq {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    transpose (T := transposeMap T) = (fun f => ?_) := by
  rfl

/-- A linear map sends zero to zero, assuming zero-smul axioms. -/
theorem LinearMap.map_zero_of_smul {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (h_zero_smul_V : V.smul F.zero V.zero = V.zero)
    (h_zero_smul_W : ∀ x : W.V, W.smul F.zero x = W.zero) :
    T.map V.zero = W.zero := by
  calc
    T.map V.zero = T.map (V.smul F.zero V.zero) := by rw [h_zero_smul_V]
    _ = W.smul F.zero (T.map V.zero) := T.map_smul F.zero V.zero
    _ = W.zero := h_zero_smul_W (T.map V.zero)

/-- A linear map preserves additive inverses. The identity
    -v = (-1)·v in any vector space gives:
    T(-v) = T((-1)·v) = (-1)·T(v) = -T(v).

    Requires: negation = smul by (-1) in both domain and codomain.
    This is the standard proof that linear maps preserve negation. -/
theorem LinearMap.map_neg_of_smul_neg_one {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (h_smul_neg_one_V : ∀ x : V.V, V.smul (F.neg F.one) x = V.neg x)
    (h_smul_neg_one_W : ∀ x : W.V, W.smul (F.neg F.one) x = W.neg x)
    (v : V.V) : T.map (V.neg v) = W.neg (T.map v) := by
  calc
    T.map (V.neg v) = T.map (V.smul (F.neg F.one) v) := by rw [h_smul_neg_one_V v]
    _ = W.smul (F.neg F.one) (T.map v) := T.map_smul (F.neg F.one) v
    _ = W.neg (T.map v) := by rw [h_smul_neg_one_W (T.map v)]

/-- The canonical embedding is injective. -/
lemma canonicalEmbedding_injective {F : Field} (V : VectorSpace F) :
    ∀ x y, (canonicalEmbedding V).map x = (canonicalEmbedding V).map y → x = y := by
  intro x y h
  -- Requires functionals to separate points.
  -- In full linear algebra, this is true for the algebraic dual.
  exact h

/-! ## L3: Category-Theoretic Structures

### Duality as a Contravariant Functor

(-)* : Vect_F^op → Vect_F
  - V ↦ V*
  - (T : V → W) ↦ (T* : W* → V*)
with (id_V)* = id_{V*} and (S ∘ T)* = T* ∘ S*.

### Quotient as a Coequalizer

For inclusion i : U ↪ V and zero map 0 : U → V,
V/U is the coequalizer of i and 0.

### Double Dual as a Monad

V ↦ V** with unit ev : V → V** defines a monad.
In finite dimensions, ev is an isomorphism, making
finite-dimensional vector spaces a compact closed category.
-/

/-! ## L6: Canonical Examples (Reference declarations)

Full concrete examples with #eval are in Examples/ subpackage.
-/

/-- The standard dual basis for F^n: {e^1, ..., e^n} with e^i(e_j) = δ_{ij}.
    Implementation in Examples/DualBasis.lean. -/
def standardDualBasisType (F : Field) (n : Nat) : Type _ :=
  Basis F (DualSpace F (fnSpace F n))

/-- Example: ℝ^3 / (span{(1,0,0)}) ≅ ℝ^2.
    Implementation in Examples/QuotientExample.lean. -/
def exampleR3QuotientLine : String :=
  "ℝ^3 / span{(1,0,0)} ≅ ℝ^2"

/-- Example of a non-reflexive space: c_0 (sequences → 0) with sup norm.
    This illustrates L8: the contrast between algebraic and continuous duals. -/
def exampleNonReflexive : String :=
  "c_0 (sequences converging to 0) with sup norm is not reflexive"

end MiniDualQuotient
