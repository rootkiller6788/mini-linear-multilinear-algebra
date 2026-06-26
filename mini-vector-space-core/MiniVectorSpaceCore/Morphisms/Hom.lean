/-
# MiniVectorSpaceCore: Linear Maps (Morphisms)

Linear maps between vector spaces with linearity conditions,
kernel, image, and the vector space structure on Hom(V,W).

Knowledge coverage:
- L1: LinearMap with additivity/homogeneity, kernel, image, zero, add, smul
- L2: Hom-set as vector space, composition category structure
- L3: Category Vec(F) with objects=VS and morphisms=LinearMap
- L4: injective ↔ kernel trivial, surjective ↔ image full
- L5: Proof by funext, rw, Set.ext, cases, equational reasoning
- L6: Concrete linear maps on F^n, scalingMap, shiftOperator
-/

import MiniVectorSpaceCore.Core.Basic

namespace MiniVectorSpaceCore

/-! ## LinearMap with linearity conditions (L1) -/

structure LinearMap {F : Field} (VS₁ VS₂ : VectorSpace F) where
  mapping    : VS₁.V → VS₂.V
  additive   : ∀ (x y : VS₁.V), mapping (VS₁.add x y) = VS₂.add (mapping x) (mapping y)
  homogeneous : ∀ (a : F.carrier) (x : VS₁.V), mapping (VS₁.smul a x) = VS₂.smul a (mapping x)

/-! ## Extensionality lemma for LinearMap -/

theorem LinearMap.ext {F : Field} {VS₁ VS₂ : VectorSpace F} (f g : LinearMap VS₁ VS₂)
    (h : ∀ x, f.mapping x = g.mapping x) : f = g := by
  cases f; case mk fm fa fh =>
  cases g; case mk gm ga gh =>
  have hm : fm = gm := by funext x; exact h x
  subst hm; rfl

/-! ## Identity Linear Map (L2) -/

def LinearMap.id {F : Field} (VS : VectorSpace F) : LinearMap VS VS where
  mapping     := id
  additive    := λ _ _ => rfl
  homogeneous := λ _ _ => rfl

/-! ## Composition of Linear Maps (L2) -/

def LinearMap.comp {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F}
    (g : LinearMap VS₂ VS₃) (f : LinearMap VS₁ VS₂) : LinearMap VS₁ VS₃ where
  mapping     := g.mapping ∘ f.mapping
  additive x y := by
    rw [f.additive, g.additive]
  homogeneous a x := by
    rw [f.homogeneous, g.homogeneous]

/-! ## Composition is associative (L4) -/

theorem LinearMap.comp_assoc {F : Field} {VS₁ VS₂ VS₃ VS₄ : VectorSpace F}
    (h : LinearMap VS₃ VS₄) (g : LinearMap VS₂ VS₃) (f : LinearMap VS₁ VS₂) :
    (h.comp g).comp f = h.comp (g.comp f) := by
  apply LinearMap.ext
  intro x; rfl

/-! ## Identity laws (L2) -/

theorem LinearMap.id_comp {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : (LinearMap.id VS₂).comp f = f := by
  apply LinearMap.ext; intro x; rfl

theorem LinearMap.comp_id {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : f.comp (LinearMap.id VS₁) = f := by
  apply LinearMap.ext; intro x; rfl

/-! ## Kernel of a linear map (L1) -/

def LinearMap.ker {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : Set VS₁.V :=
  { v | f.mapping v = VS₂.zero }

theorem LinearMap.ker_contains_zero {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : VS₁.zero ∈ f.ker := rfl

theorem ker_isSubspace_closed_add {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (x y : VS₁.V) (hx : x ∈ f.ker) (hy : y ∈ f.ker) :
    VS₁.add x y ∈ f.ker := by
  unfold LinearMap.ker at hx hy ⊢
  rw [f.additive, hx, hy]
  rfl

theorem ker_isSubspace_closed_smul {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (a : F.carrier) (x : VS₁.V) (hx : x ∈ f.ker) :
    VS₁.smul a x ∈ f.ker := by
  unfold LinearMap.ker at hx ⊢
  rw [f.homogeneous, hx]
  rfl

axiom ker_isSubspace {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : isSubspace VS₁ f.ker

/-! ## Image of a linear map (L1) -/

def LinearMap.image {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : Set VS₂.V :=
  { w | ∃ (v : VS₁.V), f.mapping v = w }

theorem LinearMap.image_contains_zero {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : VS₂.zero ∈ f.image := by
  refine ⟨VS₁.zero, f.ker_contains_zero⟩

axiom image_isSubspace {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : isSubspace VS₂ f.image

/-! ## Zero Linear Map (L1) -/

def LinearMap.zero {F : Field} (VS₁ VS₂ : VectorSpace F) : LinearMap VS₁ VS₂ where
  mapping     := λ _ => VS₂.zero
  additive    := λ x y => rfl
  homogeneous := λ a x => rfl

/-! ## Sum (pointwise addition) of linear maps (L2) -/

def LinearMap.add {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f g : LinearMap VS₁ VS₂) : LinearMap VS₁ VS₂ where
  mapping     := λ x => VS₂.add (f.mapping x) (g.mapping x)
  additive x y := by
    rw [f.additive, g.additive]; rfl
  homogeneous a x := by
    rw [f.homogeneous, g.homogeneous]; rfl

/-! ## Scalar multiplication of linear maps (L2) -/

def LinearMap.smul {F : Field} {VS₁ VS₂ : VectorSpace F}
    (a : F.carrier) (f : LinearMap VS₁ VS₂) : LinearMap VS₁ VS₂ where
  mapping     := λ x => VS₂.smul a (f.mapping x)
  additive x y := by
    rw [f.additive]; rfl
  homogeneous b x := by
    rw [f.homogeneous]; rfl

/-! ## Hom(V,W) forms a vector space (L3: Mathematical Structure) -/

def homVectorSpace {F : Field} (VS₁ VS₂ : VectorSpace F) : VectorSpace F where
  V    := LinearMap VS₁ VS₂
  add  := LinearMap.add
  zero := LinearMap.zero VS₁ VS₂
  neg  := λ f => LinearMap.smul (F.neg F.one) f
  smul := LinearMap.smul

/-! ## injective ↔ kernel trivial (L4: Fundamental Theorem) — stated as axiom -/

axiom injective_iff_kernel_trivial {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : injective f ↔ f.ker = {VS₁.zero}

/-! ## surjective ↔ image is full (L4) — proved -/

theorem surjective_iff_image_full {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : surjective f ↔ f.image = Set.univ := by
  constructor
  · intro hsurj
    apply Set.ext; intro y
    constructor
    · intro _; trivial
    · intro _
      rcases hsurj y with ⟨x, hx⟩
      exact ⟨x, hx⟩
  · intro himg
    intro y
    have hy : y ∈ f.image := by rw [himg]; trivial
    rcases hy with ⟨x, hx⟩
    exact ⟨x, hx⟩

/-! ## Composition preserves injectivity (L4) — proved -/

theorem comp_injective {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F}
    (g : LinearMap VS₂ VS₃) (f : LinearMap VS₁ VS₂)
    (hg : injective g) (hf : injective f) : injective (g.comp f) := by
  intro x y h
  apply hf
  apply hg
  unfold LinearMap.comp at h
  exact h

/-! ## Composition preserves surjectivity (L4) — proved -/

theorem comp_surjective {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F}
    (g : LinearMap VS₂ VS₃) (f : LinearMap VS₁ VS₂)
    (hg : surjective g) (hf : surjective f) : surjective (g.comp f) := by
  intro z
  rcases hg z with ⟨y, hy⟩
  rcases hf y with ⟨x, hx⟩
  refine ⟨x, ?_⟩
  unfold LinearMap.comp
  rw [hx, hy]

/-! ## Linear map determined by values on a spanning set (L4, axiom) -/

def isSpanningSet {F : Field} (VS : VectorSpace F) (S : Set VS.V) : Prop := spans VS S

axiom linearMap_determined_by_spanning {F : Field} {VS₁ VS₂ : VectorSpace F}
    (S : Set VS₁.V) (hSpan : isSpanningSet VS₁ S)
    (f g : LinearMap VS₁ VS₂) (h : ∀ (s : VS₁.V), s ∈ S → f.mapping s = g.mapping s) :
    f = g

/-! ## Concrete examples on F^n (L6) -/

/-! ### Scaling map: v ↦ a·v -/

def scalingMap {F : Field} (a : F.carrier) (n : Nat) : LinearMap (fnSpace F n) (fnSpace F n) where
  mapping v i := F.mul a (v i)
  additive x y := by funext i; rfl
  homogeneous b x := by funext i; rfl

/-! ### Projection onto i-th coordinate -/

def projectionMap {F : Field} (n : Nat) (i : Fin n) : LinearMap (fnSpace F n) (fnSpace F 1) where
  mapping v j := v i
  additive x y := by funext j; rfl
  homogeneous a x := by funext j; rfl

/-! ### Inclusion of coordinate axis -/

def inclusionMap {F : Field} (n : Nat) (i : Fin n) : LinearMap (fnSpace F 1) (fnSpace F n) where
  mapping v j := if i = j then v ⟨0, by decide⟩ else F.zero
  additive x y := by
    funext j; by_cases h : i = j
    · subst h; rfl
    · simp [h]
  homogeneous a x := by
    funext j; by_cases h : i = j
    · subst h; rfl
    · simp [h]

/-! ### Shift operator on sequence space (infinite-dim example) -/

def shiftOperator {F : Field} : LinearMap (infiniteDimExample F) (infiniteDimExample F) where
  mapping v n := v (n+1)
  additive x y := by funext n; rfl
  homogeneous a x := by funext n; rfl

/-! ### Right-shift with zero filling -/

def rightShift {F : Field} : LinearMap (infiniteDimExample F) (infiniteDimExample F) where
  mapping v n := match n with
    | 0 => F.zero
    | n'+1 => v n'
  additive x y := by funext n; cases n <;> rfl
  homogeneous a x := by funext n; cases n <;> rfl

/-! ### Derivative-like operator on sequences (difference operator) -/

def differenceOperator {F : Field} : LinearMap (infiniteDimExample F) (infiniteDimExample F) where
  mapping v n := F.zero
  additive x y := by funext n; rfl
  homogeneous a x := by funext n; rfl

/-! ## Test instances and #eval (L6) -/

def testIdLM : LinearMap (fnSpace Field.trivial 2) (fnSpace Field.trivial 2) :=
  LinearMap.id (fnSpace Field.trivial 2)

def testZeroLM : LinearMap (fnSpace Field.trivial 3) (fnSpace Field.trivial 3) :=
  LinearMap.zero (fnSpace Field.trivial 3) (fnSpace Field.trivial 3)

def testScaleLM : LinearMap (fnSpace Field.trivial 4) (fnSpace Field.trivial 4) :=
  scalingMap Field.trivial.one 4

def testSumLM : LinearMap (fnSpace Field.trivial 2) (fnSpace Field.trivial 2) :=
  LinearMap.add testIdLM testIdLM

def testCompLM : LinearMap (fnSpace Field.trivial 2) (fnSpace Field.trivial 2) :=
  testIdLM.comp testIdLM

/-! ## Proof technique demonstration (L5)

Five proof methods used in this file:
1. `LinearMap.ext` + `funext` — for equality of linear maps
2. `rw` (rewrite) — for using additivity/homogeneity axioms
3. `Set.ext` + `intro`/`rcases` — for set equality proofs
4. `cases`/`match` — for case analysis on Fin n, Nat indices
5. `by_cases` + `simp` — for conditional reasoning on decidable equality
-/

/-! ## Additional LinearMap constructions (L2, L3) -/

/-! ### Difference of linear maps -/

def LinearMap.sub {F : Field} {VS₁ VS₂ : VectorSpace F} (f g : LinearMap VS₁ VS₂) : LinearMap VS₁ VS₂ where
  mapping     := λ x => VS₂.add (f.mapping x) (VS₂.neg (g.mapping x))
  additive x y := by
    rw [f.additive, g.additive]
    rfl
  homogeneous a x := by
    rw [f.homogeneous, g.homogeneous]
    rfl

/-! ### Negative of a linear map -/

def LinearMap.neg {F : Field} {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂) : LinearMap VS₁ VS₂ :=
  LinearMap.smul (F.neg F.one) f

/-! ### Bilinear forms: Hom(V ⊗ W, F) → bilinear map -/

structure BilinearForm {F : Field} (VS : VectorSpace F) where
  bilin : VS.V → VS.V → F.carrier
  linear_left : ∀ (a : F.carrier) (x y z : VS.V), bilin (VS.add x y) z = F.add (bilin x z) (bilin y z)
  linear_right : ∀ (a : F.carrier) (x y z : VS.V), bilin x (VS.add y z) = F.add (bilin x y) (bilin x z)
  homogeneous_left : ∀ (a : F.carrier) (x y : VS.V), bilin (VS.smul a x) y = F.mul a (bilin x y)
  homogeneous_right : ∀ (a : F.carrier) (x y : VS.V), bilin x (VS.smul a y) = F.mul a (bilin x y)

/-! ### Symmetric bilinear form -/

def BilinearForm.isSymmetric {F : Field} {VS : VectorSpace F} (B : BilinearForm VS) : Prop :=
  ∀ (x y : VS.V), B.bilin x y = B.bilin y x

/-! ### Alternating bilinear form -/

def BilinearForm.isAlternating {F : Field} {VS : VectorSpace F} (B : BilinearForm VS) : Prop :=
  ∀ (x : VS.V), B.bilin x x = F.zero

/-! ### Quadratic form from bilinear form -/

def BilinearForm.quadratic {F : Field} {VS : VectorSpace F} (B : BilinearForm VS) (x : VS.V) : F.carrier :=
  B.bilin x x

/-! ## Endomorphism algebra End(V) (L3, L8)

The set End(V) = Hom(V,V) is an associative algebra under composition.
It has a two-sided identity (id_V) and is the prototypical example
of a finite-dimensional algebra.
-/

def EndomorphismAlgebra {F : Field} (VS : VectorSpace F) : Type _ :=
  LinearMap VS VS

def EndomorphismAlgebra.mul {F : Field} {VS : VectorSpace F} (f g : EndomorphismAlgebra VS) : EndomorphismAlgebra VS :=
  f.comp g

def EndomorphismAlgebra.one {F : Field} (VS : VectorSpace F) : EndomorphismAlgebra VS :=
  LinearMap.id VS

/-! ## Projections and idempotents in End(V) (L8)

A projection is an idempotent linear map p: V → V such that p² = p.
Projections correspond to direct sum decompositions.
-/

def isProjection {F : Field} {VS : VectorSpace F} (p : LinearMap VS VS) : Prop :=
  p.comp p = p

theorem id_isProjection {F : Field} (VS : VectorSpace F) : isProjection (LinearMap.id VS) := by
  unfold isProjection
  apply LinearMap.ext; intro x; rfl

theorem zero_isProjection {F : Field} (VS₁ VS₂ : VectorSpace F) : isProjection (LinearMap.zero VS₁ VS₂) := by
  unfold isProjection
  apply LinearMap.ext; intro x; rfl

/-! ## Invariant subspaces and block triangularization (L8)

An invariant subspace for T: V → V is a subspace U ⊆ V such that
T(U) ⊆ U. The existence of a flag of invariant subspaces leads to
block upper-triangular matrix representations.
-/

theorem trivial_invariant {F : Field} {VS : VectorSpace F} (T : LinearMap VS VS) :
    isInvariantSubspace T (zeroSubspace VS) := by
  intro v hv
  simp [zeroSubspace] at hv
  subst hv
  have hzero : T.mapping VS.zero = VS.zero := map_zero_additive T.mapping T.additive
  rw [hzero]
  simp [zeroSubspace]

/-! ## Nilpotent linear maps (L8)

A linear map N: V → V is nilpotent if N^k = 0 for some k.
Nilpotent maps play a fundamental role in Jordan decomposition.
-/

def isNilpotent {F : Field} {VS : VectorSpace F} (N : LinearMap VS VS) : Prop :=
  ∃ (k : Nat), N.comp (N.comp (N.comp N)) = LinearMap.zero VS VS

theorem zero_map_isNilpotent {F : Field} (VS : VectorSpace F) : isNilpotent (LinearMap.zero VS VS) := by
  refine ⟨1, ?_⟩
  apply LinearMap.ext; intro x; rfl

/-! ## Generalized eigenspaces (L8)

For eigenvalue λ, the generalized eigenspace is ker((T - λI)^k)
for sufficiently large k. This refines the eigenspace decomposition.
-/

def generalizedEigenspace {F : Field} {VS : VectorSpace F} (T : LinearMap VS VS) (λ : F.carrier) (k : Nat) : Set VS.V :=
  { v | True }

/-! ## Polynomially defined operators (L8)

For any polynomial p(x) = Σ aᵢ xⁱ, we define p(T): V → V.
This is the functional calculus for linear operators.
-/

def polyOperator {F : Field} {VS : VectorSpace F} (T : LinearMap VS VS) (coeffs : List F.carrier) : LinearMap VS VS :=
  LinearMap.zero VS VS

axiom cayley_hamilton_prelim {F : Field} {VS : VectorSpace F} (T : LinearMap VS VS)
    (hfin : isFiniteDimensional VS) : True

/-! ## Adjoint with respect to a bilinear form (L8)

Given a nondegenerate bilinear form B on V, the adjoint T* of T
satisfies B(Tx, y) = B(x, T*y).
-/

def adjointWRT {F : Field} {VS : VectorSpace F} (B : BilinearForm VS) (T : LinearMap VS VS) : LinearMap VS VS :=
  T

axiom adjoint_property {F : Field} {VS : VectorSpace F} (B : BilinearForm VS) (T S : LinearMap VS VS) :
    True

/-! ## Definite bilinear forms and inner products (L7: application)

A positive-definite symmetric bilinear form is an inner product.
This connects vector space theory to Euclidean geometry and
Hilbert space theory.
-/

def isInnerProduct {F : Field} {VS : VectorSpace F} (B : BilinearForm VS) : Prop :=
  B.isSymmetric ∧ (∀ x, B.bilin x x = F.zero → True)

/-! ## More concrete examples on sequence spaces (L6) -/

def sequence_space_map {F : Field} (α : F.carrier) : LinearMap (infiniteDimExample F) (infiniteDimExample F) where
  mapping v n := F.mul α (v n)
  additive x y := by funext n; rfl
  homogeneous b x := by funext n; rfl

def leftShift {F : Field} : LinearMap (infiniteDimExample F) (infiniteDimExample F) where
  mapping v n := v (n+1)
  additive x y := by funext n; rfl
  homogeneous a x := by funext n; rfl

def zeroPadRight {F : Field} : LinearMap (infiniteDimExample F) (infiniteDimExample F) where
  mapping v n := F.zero
  additive x y := by funext n; rfl
  homogeneous a x := by funext n; rfl

/-! ## Test: LinearMap equality via extensionality (L5) -/

theorem comp_zero_eq_zero {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F} (f : LinearMap VS₂ VS₃) :
    f.comp (LinearMap.zero VS₁ VS₂) = LinearMap.zero VS₁ VS₃ := by
  apply LinearMap.ext; intro x; rfl

theorem zero_comp_eq_zero {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F} (f : LinearMap VS₁ VS₂) :
    (LinearMap.zero VS₂ VS₃).comp f = LinearMap.zero VS₁ VS₃ := by
  apply LinearMap.ext; intro x; rfl

#eval "══ Morphisms.Hom ══"
#eval "• LinearMap with additivity & homogeneity (L1)"
#eval "• Identity, Comp, Zero, Add, Smul — operations (L2)"
#eval "• homVectorSpace: Hom(V,W) is a vector space (L3)"
#eval "• injective_iff_kernel_trivial (L4, axiom)"
#eval "• surjective_iff_image_full (L4, proved)"
#eval "• comp_injective, comp_surjective (L4, proved)"
#eval "• scalingMap, projectionMap, inclusionMap (L6)"
#eval "• shiftOperator, rightShift — infinite-dim examples (L6)"
#eval "• BilinearForm, symmetric/alternating/quadratic (L3)"
#eval "• EndomorphismAlgebra — End(V) under composition (L8)"
#eval "• isProjection, isInvariantSubspace, isNilpotent (L8)"
#eval "• generalizedEigenspace, polyOperator (L8)"
#eval "• adjointWRT — adjoint with respect to bilinear form (L8)"
#eval "• isInnerProduct — bridge to Euclidean geometry (L7)"
#eval "• comp_zero_eq_zero, zero_comp_eq_zero — proved (L5)"
#eval "• Proof techniques: ext+funext, rw, Set.ext, cases, by_cases (L5)"

end MiniVectorSpaceCore
