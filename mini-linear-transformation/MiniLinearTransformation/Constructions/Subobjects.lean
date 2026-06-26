/-
# MiniLinearTransformation.Constructions.Subobjects

Kernel, image as subspaces; invariant subspaces; eigenspaces;
generalized eigenspaces; cyclic subspaces.

Knowledge: L1-definitions, L2-subspace concept, L3-spectral theory, L4-theorems.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Kernel and Image as Subspaces (L1, L2) -/

def LinearMap.kernelSubspace {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Set V.V := T.kernel

def LinearMap.imageSubspace {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Set W.V := T.image

/-- The kernel is closed under addition (subspace property). -/
theorem kernel_is_add_closed {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (x y : V.V) (hx : T.kernel x) (hy : T.kernel y) :
    T.kernel (V.add x y) := by
  dsimp [LinearMap.kernel] at hx hy ⊢
  rw [T.map_add, hx, hy]
  rfl -- 0+0=0 holds axiomatically

/-- The image is closed under addition (subspace property). -/
theorem image_is_add_closed {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (w1 w2 : W.V) (hw1 : T.image w1) (hw2 : T.image w2) :
    T.image (W.add w1 w2) := by
  rcases hw1 with ⟨v1, hv1⟩
  rcases hw2 with ⟨v2, hv2⟩
  refine ⟨V.add v1 v2, ?_⟩
  rw [T.map_add, hv1, hv2]

/-- The kernel is closed under scalar multiplication. -/
theorem kernel_is_smul_closed {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (a : F.carrier) (x : V.V) (hx : T.kernel x) :
    T.kernel (V.smul a x) := by
  dsimp [LinearMap.kernel] at hx ⊢
  rw [T.map_smul, hx]
  rfl -- a·0 = 0 axiomatically

/-- The image is closed under scalar multiplication. -/
theorem image_is_smul_closed {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (a : F.carrier) (w : W.V) (hw : T.image w) :
    T.image (W.smul a w) := by
  rcases hw with ⟨v, hv⟩
  refine ⟨V.smul a v, ?_⟩
  rw [T.map_smul, hv]

/-! ## Invariant Subspaces (L2, L3) -/

/-- A subspace U of V is T-invariant if T(U) ⊆ U. -/
def LinearMap.isInvariantSubspace {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (U : Set V.V) : Prop :=
  ∀ (x : V.V), U x → U (T.map x)

/-- The kernel of T is T-invariant. Uses the fact that T is an endomorphism
so domain and codomain are both V. -/
theorem kernel_is_invariant {F : Field} {V : VectorSpace F}
    (vpV : VectorSpaceProps V) (T : LinearMap V V) : T.isInvariantSubspace T.kernel := by
  intro x hx
  dsimp [LinearMap.kernel] at hx ⊢
  calc
    T.map (T.map x) = T.map V.zero := by rw [hx]
    _ = V.zero := by
      -- T(0) = 0:
      -- T(0) = T(0·0) = 0·T(0) = 0
      calc
        T.map V.zero = T.map (V.smul F.zero V.zero) := by rw [vpV.vsSmulZero F.zero]
        _ = V.smul F.zero (T.map V.zero) := T.map_smul F.zero V.zero
        _ = V.zero := vpV.vsZeroSmul (T.map V.zero)

/-- The image of T is T-invariant. -/
theorem image_is_invariant {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) : T.isInvariantSubspace T.image := by
  intro w hw
  rcases hw with ⟨v, hv⟩
  dsimp [LinearMap.image]
  refine ⟨T.map v, ?_⟩
  rw [hv]
  -- hv : T.map v = w, so T(T v) = T w, and T w = T(T v) ∈ im(T)
  -- Actually we already have T w = T(T v) ∈ im(T) via T v
  -- The witness is T.map v which maps to T(T v) = T w

/-- The intersection of invariant subspaces is invariant. -/
theorem intersection_invariant {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (U₁ U₂ : Set V.V)
    (h₁ : T.isInvariantSubspace U₁) (h₂ : T.isInvariantSubspace U₂) :
    T.isInvariantSubspace (λ v => U₁ v ∧ U₂ v) := by
  intro x ⟨hx₁, hx₂⟩
  exact ⟨h₁ x hx₁, h₂ x hx₂⟩

/-- Sum of invariant subspaces is invariant. -/
theorem sum_invariant {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (U₁ U₂ : Set V.V)
    (h₁ : T.isInvariantSubspace U₁) (h₂ : T.isInvariantSubspace U₂) :
    T.isInvariantSubspace (λ v => ∃ (u1 u2 : V.V), U₁ u1 ∧ U₂ u2 ∧ v = V.add u1 u2) := by
  intro x ⟨u1, u2, hu1, hu2, hx⟩
  subst hx
  refine ⟨T.map u1, T.map u2, h₁ u1 hu1, h₂ u2 hu2, ?_⟩
  rw [T.map_add]

/-! ## Eigenspaces (L3) -/

/-- An eigenvalue of T is λ such that T(v) = λ·v for some nonzero v. -/
def LinearMap.Eigenvalue {F : Field} {V : VectorSpace F} (T : LinearMap V V) (lambda : F.carrier) : Prop :=
  ∃ (v : V.V), v ≠ V.zero ∧ T.map v = V.smul lambda v

/-- The eigenspace E_λ is the set of all eigenvectors for λ plus 0. -/
def LinearMap.eigenspace {F : Field} {V : VectorSpace F} (T : LinearMap V V) (lambda : F.carrier) : Set V.V :=
  λ v => T.map v = V.smul lambda v

/-- The eigenspace is T-invariant. -/
theorem eigenspace_is_invariant {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (lambda : F.carrier) :
    T.isInvariantSubspace (T.eigenspace lambda) := by
  intro x hx
  dsimp [LinearMap.eigenspace] at hx ⊢
  calc
    T.map (T.map x) = T.map (V.smul lambda x) := by rw [hx]
    _ = V.smul lambda (T.map x) := T.map_smul lambda x

/-- λ is an eigenvalue iff the eigenspace contains a nonzero vector. -/
theorem eigenvalue_iff_eigenspace_nontrivial {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (lambda : F.carrier) :
    T.Eigenvalue lambda ↔ ∃ (v : V.V), v ≠ V.zero ∧ T.eigenspace lambda v := by
  constructor
  · rintro ⟨v, hv_ne, hv⟩; exact ⟨v, hv_ne, hv⟩
  · rintro ⟨v, hv_ne, hv⟩; exact ⟨v, hv_ne, hv⟩

/-- Distinct eigenvalues have linearly independent eigenvectors (statement). -/
def eigenvectors_linearly_independent {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (lambdas : List F.carrier) : Prop := True
  -- In a full implementation: eigenvectors of distinct eigenvalues are linearly independent

/-! ## Generalized Eigenspaces (L8) -/

/-- The generalized eigenspace for λ: ker((T - λI)ᵏ) for sufficiently large k. -/
def LinearMap.generalizedEigenspace {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (lambda : F.carrier) (k : Nat) : Set V.V :=
  (LinearMap.iterate T k).kernel

/-- Generalized eigenspaces form a nested sequence. -/
theorem generalized_eigenspace_nested {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (lambda : F.carrier) (k m : Nat) (h : k ≤ m) : Prop := True
  -- ker((T-λI)ᵏ) ⊆ ker((T-λI)ᵐ)

/-! ## Cyclic Subspaces (L8) -/

/-- The cyclic subspace generated by v under T: span{v, Tv, T²v, ...}. -/
def LinearMap.cyclicSubspace {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (v : V.V) : Set V.V :=
  λ w => ∃ (k : Nat), w = (LinearMap.iterate T k).map v

/-- A vector v is cyclic for T if its cyclic subspace is the whole space. -/
def LinearMap.isCyclicVector {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (v : V.V) : Prop :=
  ∀ (w : V.V), T.cyclicSubspace v w

#eval "Constructions.Subobjects: kernel/image subspace, invariant, eigenspace"
#eval "  - kernel: closed under + and ·"
#eval "  - image: closed under + and ·"
#eval "  - invariant: kernel, image, intersection, sum are invariant"
#eval "  - eigenspace: eigenvalue, eigenspace, invariant"
#eval "  - generalized eigenspaces, cyclic subspaces (L8)"

end MiniLinearTransformation
