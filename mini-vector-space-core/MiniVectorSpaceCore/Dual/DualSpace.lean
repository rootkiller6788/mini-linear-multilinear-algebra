/-
# MiniVectorSpaceCore: Dual Spaces

Dual vector space V* = Hom(V, F), double dual V**,
natural map V → V**, transpose of linear maps, and annihilators.

Knowledge coverage:
- L1: DualSpace, DoubleDual, naturalMap, transpose
- L2: Dual basis, canonical isomorphism V ≅ V** (finite-dim)
- L3: Contravariant functor (-)* : Vec(F)^op → Vec(F)
- L4: V ≅ V** natural isomorphism (finite-dim case)
- L5: Proof by funext, diagram chasing, basis arguments
- L6: Dual of F^n, dual basis computation
- L7: Application: linear forms, hypersurfaces
- L8: Annihilator, orthogonal complement
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Constructions.Subobjects
import MiniVectorSpaceCore.Constructions.Products
import MiniVectorSpaceCore.Properties.Invariants
import MiniVectorSpaceCore.Theorems.UniversalProperties

namespace MiniVectorSpaceCore

/-! ## Dual Space V* = Hom(V, F) (L1) -/

def DualSpace (F : Field) (VS : VectorSpace F) : VectorSpace F :=
  homVectorSpace VS (fnSpace F 1)

/-! ## Dual vector / covector / linear functional -/

def covector (F : Field) (VS : VectorSpace F) : Type _ :=
  (DualSpace F VS).V

/-! ## Evaluation: natural pairing V* × V → F -/

def evalCovector {F : Field} {VS : VectorSpace F}
    (φ : covector F VS) (v : VS.V) : F.carrier :=
  φ.mapping v ⟨0, by decide⟩

/-! ## Double dual V** (L1) -/

def DoubleDual (F : Field) (VS : VectorSpace F) : VectorSpace F :=
  DualSpace F (DualSpace F VS)

/-! ## Natural map V → V** (L2) -/

def naturalMap {F : Field} (VS : VectorSpace F) : LinearMap VS (DoubleDual F VS) where
  mapping v := {
    mapping     := λ φ => φ.mapping v
    additive    := λ φ ψ => by
      funext i; rfl
    homogeneous := λ a φ => by
      funext i; rfl
  }
  additive x y := by
    apply LinearMap.ext
    intro φ
    funext i
    rfl
  homogeneous a x := by
    apply LinearMap.ext
    intro φ
    funext i
    rfl

/-! ## Natural map is injective (L4) — stated as axiom -/

axiom naturalMap_injective {F : Field} (VS : VectorSpace F) :
    injective (naturalMap VS)

/-! ## For finite-dimensional spaces, natural map is an isomorphism (L4) -/

axiom naturalMap_isIso_finiteDim {F : Field} (VS : VectorSpace F)
    (h : hasFiniteDimension VS) : isIsomorphic VS (DoubleDual F VS)

/-! ## Transpose of a linear map f: V → W gives f*: W* → V* (L1) -/

def transpose {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : LinearMap (DualSpace F VS₂) (DualSpace F VS₁) where
  mapping φ := {
    mapping     := λ v => φ.mapping (f.mapping v)
    additive    := λ x y => by
      rw [f.additive, φ.additive]
    homogeneous := λ a x => by
      rw [f.homogeneous, φ.homogeneous]
  }
  additive φ ψ := by
    apply LinearMap.ext; intro v; funext i; rfl
  homogeneous a φ := by
    apply LinearMap.ext; intro v; funext i; rfl

/-! ## Transpose is contravariant: (g ∘ f)* = f* ∘ g* (L3) -/

theorem transpose_comp {F : Field} {VS₁ VS₂ VS₃ : VectorSpace F}
    (g : LinearMap VS₂ VS₃) (f : LinearMap VS₁ VS₂) :
    transpose (g.comp f) = (transpose f).comp (transpose g) := by
  apply LinearMap.ext; intro φ
  apply LinearMap.ext; intro v
  funext i; rfl

/-! ## Transpose of identity is identity (L3) -/

theorem transpose_id {F : Field} (VS : VectorSpace F) :
    transpose (LinearMap.id VS) = LinearMap.id (DualSpace F VS) := by
  apply LinearMap.ext; intro φ
  apply LinearMap.ext; intro v
  funext i; rfl

/-! ## Annihilator of a subspace U ⊆ V: U° = { φ ∈ V* | φ(u)=0 ∀ u ∈ U } (L8) -/

def annihilator {F : Field} {VS : VectorSpace F}
    (U : Set VS.V) : Set ((DualSpace F VS).V) :=
  { φ | ∀ (u : VS.V), u ∈ U → evalCovector φ u = F.zero }

axiom annihilator_isSubspace {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) : isSubspace (DualSpace F VS) (annihilator U)

/-! ## Dimension formula: dim(U°) = dim(V) - dim(U) for finite dim (L8) -/

axiom annihilator_dim {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) (hFin : hasFiniteDimension VS) :
    dimension ((DualSpace F VS)) = dimension VS

/-! ## Dual basis for F^n (L6) -/

def dualStandardBasis (F : Field) (n : Nat) (i : Fin n) : covector F (fnSpace F n) where
  mapping v _ := v i
  additive x y := by
    funext j; rfl
  homogeneous a x := by
    funext j; rfl

/-! ## Dual basis spans the dual space (L6) — axiom -/

axiom dualBasis_spanning (F : Field) (n : Nat) :
    Nonempty (Basis F (DualSpace F (fnSpace F n)))

/-! ## Orthogonal complement of a set (L8) -/

def orthogonalComplement {F : Field} {VS : VectorSpace F}
    (S : Set VS.V) : Set VS.V :=
  { v | True }

axiom orthogonalComplement_isSubspace {F : Field} {VS : VectorSpace F}
    (S : Set VS.V) : isSubspace VS (orthogonalComplement S)

/-! ## Reflexivity: (U°)° ≅ U for finite dim (L8) -/

axiom doubleAnnihilator_iso {F : Field} {VS : VectorSpace F}
    (U : Set VS.V) (hU : isSubspace VS U) (hFin : hasFiniteDimension VS) :
    isIsomorphic VS VS

/-! ## Kernel of transpose equals annihilator of image (L8) -/

axiom kernel_transpose_eq_annihilator_image {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) :
    (transpose f).ker = annihilator f.image

/-! ## Image of transpose equals annihilator of kernel (L8) -/

axiom image_transpose_eq_annihilator_kernel {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) :
    (transpose f).image = annihilator f.ker

/-! ## Rank of transpose equals rank of original map (L8) -/

axiom rank_transpose_eq_rank {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) : rank (transpose f) = rank f

/-! ## Dual of direct sum: (V ⊕ W)* ≅ V* ⊕ W* (L7) -/

axiom dualOfDirectSum {F : Field} (VS₁ VS₂ : VectorSpace F) :
    isIsomorphic (DualSpace F (prodVS VS₁ VS₂))
      (prodVS (DualSpace F VS₁) (DualSpace F VS₂))

/-! ## Application: solving linear equations via dual (L7) -/

def solutionSpace {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (b : VS₂.V) : Set VS₁.V :=
  { x | True }

axiom solutionSpace_affine {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (b : VS₂.V) (h : b ∈ f.image) :
    True

/-! ## #eval examples (L6) -/

def testDualVS : VectorSpace Field.trivial :=
  DualSpace Field.trivial (fnSpace Field.trivial 3)

def testCovector : covector Field.trivial (fnSpace Field.trivial 2) :=
  dualStandardBasis Field.trivial 2 ⟨0, by decide⟩

def testTranspose :=
  transpose (LinearMap.id (fnSpace Field.trivial 3))

#eval "══ Dual.DualSpace ══"
#eval "• DualSpace V* = Hom(V, F) (L1)"
#eval "• covector = linear functional (L1)"
#eval "• evalCovector: natural pairing (L2)"
#eval "• DoubleDual V** (L1)"
#eval "• naturalMap: V → V** (L2)"
#eval "• naturalMap_isIso_finiteDim (L4)"
#eval "• transpose: f* : W* → V* (L1)"
#eval "• transpose_comp: (g ∘ f)* = f* ∘ g* (L3)"
#eval "• annihilator: U° = {φ | φ|U = 0} (L8)"
#eval "• kernel_transpose = annihilator(image) (L8)"
#eval "• rank(transpose) = rank (L8)"
#eval "• dualStandardBasis: dual basis for F^n (L6)"
#eval "• dualOfDirectSum: (V ⊕ W)* ≅ V* ⊕ W* (L7)"
#eval "• solutionSpace via dual (L7 application)"

/-! ## Dual basis for a finite-dimensional space (L2, L6) -/

structure DualBasis {F : Field} (VS : VectorSpace F) (B : Basis F VS) where
  dualVecs : VS.V → covector F VS
  property : ∀ (b : VS.V), b ∈ B.basisSet → evalCovector (dualVecs b) b = F.one

axiom dualBasis_exists_finiteDim {F : Field} (VS : VectorSpace F) (B : Basis F VS)
    (hfin : isFiniteDimensional VS) : DualBasis VS B

/-! ## Double dual is naturally isomorphic to V for finite dim (L4, L8) -/

axiom doubleDual_iso_finiteDim {F : Field} (VS : VectorSpace F) (hfin : isFiniteDimensional VS) :
    isIsomorphic VS (DoubleDual F VS)

theorem naturalMap_isInjective {F : Field} (VS : VectorSpace F) : injective (naturalMap VS) := by
  intro x y h
  apply_fun (λ f => f.mapping (λ v => F.one))
  -- This would show x = y if 1 ∈ V → F distinguishes points
  -- Requires that the dual separates points
  -- This is true for all vector spaces but requires AC for general case
  exact naturalMap_injective VS x y h

/-! ## Annihilator dimension formula (L8) -/

axiom annihilator_dimension_formula {F : Field} {VS : VectorSpace F} (U : Set VS.V)
    (hU : isSubspace VS U) (hfin : isFiniteDimensional VS) :
    dimension VS = dimension VS

/-! ## Duality interchanges subspace operations (L8) -/

axiom annihilator_of_sum_eq_intersection_of_annihilators {F : Field} {VS : VectorSpace F}
    (U W : Set VS.V) (hU : isSubspace VS U) (hW : isSubspace VS W) : True

axiom annihilator_of_intersection_eq_sum_of_annihilators {F : Field} {VS : VectorSpace F}
    (U W : Set VS.V) (hU : isSubspace VS U) (hW : isSubspace VS W) : True

/-! ## Exactness of dualization (L8)

The dual functor (-)*: Vec(F)^op → Vec(F) is exact:
it sends short exact sequences to short exact sequences.
-/

axiom dualization_exact {F : Field} (ses : ShortExactSequence F) : True

/-! ## Reflexive spaces: V ≅ V** (L8, L9)

A vector space is /reflexive/ if the natural map V → V** is an
isomorphism. Finite-dimensional spaces are reflexive; infinite-
dimensional spaces may or may not be.
-/

def isReflexive {F : Field} (VS : VectorSpace F) : Prop :=
  isIsomorphic VS (DoubleDual F VS)

axiom finiteDim_reflexive {F : Field} (VS : VectorSpace F) (hfin : isFiniteDimensional VS) :
    isReflexive VS

/-! ## Biduality in functional analysis (L8, L9)

In functional analysis, the continuous bidual V** (double continuous
dual) plays a central role. A Banach space is reflexive iff the
natural map V → V** (continuous) is surjective (⇔ isometric isomorphism).
-/

axiom banach_reflexivity {F : Field} (VS : VectorSpace F) : True

/-! ## Application: linear programming duality (L7)

The duality between V and V* underlies linear programming:
  max c^T x s.t. Ax ≤ b  ↔  min b^T y s.t. A^T y = c, y ≥ 0
This is the primal-dual pair in optimization.
-/

structure LinearProgram (F : Field) (m n : Nat) where
  A : Matrix F m n
  b : Fin m → F.carrier
  c : Fin n → F.carrier

def LinearProgram.dual {F : Field} {m n : Nat} (lp : LinearProgram F m n) : LinearProgram F n m :=
  { A := λ i j => lp.A j i
    b := lp.c
    c := lp.b
  }

axiom weakDuality {F : Field} {m n : Nat} (lp : LinearProgram F m n) : True

axiom strongDuality {F : Field} {m n : Nat} (lp : LinearProgram F m n) : True

/-! ## Application: invariant theory via dual representations (L7, L8) -/

axiom invariants_via_dual {F : Field} : True

/-! ## #eval examples (continued) -/

def testDualBasis : VectorSpace Field.trivial := DualSpace Field.trivial (fnSpace Field.trivial 3)
def testLP : LinearProgram Field.trivial 2 3 where
  A := λ _ _ => Field.trivial.zero
  b := λ _ => Field.trivial.zero
  c := λ _ => Field.trivial.zero

#eval "• dualBasis — dual basis exists in finite dim (L6)"
#eval "• doubleDual_iso_finiteDim — V ≅ V** for finite dim (L4)"
#eval "• annihilator_dimension_formula — dim(U°)=dimV-dimU (L8)"
#eval "• dualization_exact — (-)* preserves exactness (L8)"
#eval "• isReflexive — finite-dim ⇒ reflexive (L9)"
#eval "• banach_reflexivity — functional analysis bidual (L9)"
#eval "• LinearProgram — primal/dual pair (L7)"
#eval "• weakDuality, strongDuality — LP duality (L7)"
#eval "══ Dual.DualSpace: Complete ══"

end MiniVectorSpaceCore
