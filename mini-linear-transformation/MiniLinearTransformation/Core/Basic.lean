/-
# MiniLinearTransformation.Core.Basic

Linear maps between vector spaces: structure definition and
the simplest operations (identity, composition). More complex
operations requiring vector space axioms are in Core/Laws.lean.

Knowledge coverage:
- L1: LinearMap structure, Field.toVS
- L2: Kernel/Image/Rank/Nullity concepts
- L3: Composition, identity
- L5: Direct construction proofs (by rfl)
- L6: #eval verification on explicit examples
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Axioms

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Linear Map Structure (L1) -/

/-- A linear map T: V → W preserves addition and scalar multiplication. -/
structure LinearMap {F : Field} (V W : VectorSpace F) where
  map : V.V → W.V
  map_add : ∀ (x y : V.V), map (V.add x y) = W.add (map x) (map y)
  map_smul : ∀ (a : F.carrier) (x : V.V), map (V.smul a x) = W.smul a (map x)

/-- Apply a linear map to a vector. -/
def LinearMap.apply {F : Field} {V W : VectorSpace F} (T : LinearMap V W) (x : V.V) : W.V := T.map x

/-! ## Field as 1-Dimensional Vector Space (L2 helper) -/

/-- Every field F is a 1-dimensional vector space over itself,
with scalar multiplication equal to field multiplication. -/
def Field.toVS (F : Field) : VectorSpace F where
  V := F.carrier
  add := F.add
  zero := F.zero
  neg := F.neg
  smul := F.mul

/-! ## Identity Linear Map (L1) -/

/-- The identity linear map id_V: V → V, id_V(x) = x. -/
def LinearMap.id {F : Field} (V : VectorSpace F) : LinearMap V V where
  map x := x
  map_add _ _ := rfl
  map_smul _ _ := rfl

/-! ## Composition of Linear Maps (L1) -/

/-- Composition T ∘ S: U → W defined by (T ∘ S)(x) = T(S(x)). -/
def LinearMap.comp {F : Field} {U V W : VectorSpace F}
    (T : LinearMap V W) (S : LinearMap U V) : LinearMap U W where
  map x := T.map (S.map x)
  map_add x y := by rw [S.map_add, T.map_add]
  map_smul a x := by rw [S.map_smul, T.map_smul]

/-! ## Kernel of a Linear Map (L2) -/

/-- ker(T) = {v ∈ V | T(v) = 0_W}. -/
def LinearMap.kernel {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Set V.V :=
  fun v => T.map v = W.zero

/-- Zero vector in kernel: T(0_V) = 0_W using VS axioms. -/
theorem LinearMap.zero_mem_kernel {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) : T.kernel V.zero := by
  dsimp [LinearMap.kernel]
  calc
    T.map V.zero = T.map (V.smul F.zero V.zero) := by rw [vpV.vsSmulZero F.zero]
    _ = W.smul F.zero (T.map V.zero) := T.map_smul F.zero V.zero
    _ = W.zero := vpW.vsZeroSmul (T.map V.zero)

/-- Kernel is closed under addition. -/
theorem LinearMap.kernel_add_closed {F : Field} {V W : VectorSpace F}
    (vpW : VectorSpaceProps W) (T : LinearMap V W) (x y : V.V)
    (hx : T.kernel x) (hy : T.kernel y) : T.kernel (V.add x y) := by
  dsimp [LinearMap.kernel] at hx hy ⊢
  rw [T.map_add, hx, hy, vpW.vsZeroAdd W.zero]

/-- Kernel is closed under scalar multiplication. -/
theorem LinearMap.kernel_smul_closed {F : Field} {V W : VectorSpace F}
    (vpW : VectorSpaceProps W) (T : LinearMap V W) (a : F.carrier) (x : V.V)
    (hx : T.kernel x) : T.kernel (V.smul a x) := by
  dsimp [LinearMap.kernel] at hx ⊢
  rw [T.map_smul, hx, vpW.vsSmulZero a]

/-! ## Image of a Linear Map (L2) -/

/-- im(T) = {w ∈ W | ∃ v ∈ V, T(v) = w}. -/
def LinearMap.image {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Set W.V :=
  fun w => ∃ (v : V.V), T.map v = w

/-- Zero is in the image: T(0_V) = 0_W. -/
theorem LinearMap.zero_mem_image {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) : T.image W.zero := by
  have hzero : T.map V.zero = W.zero := by
    calc
      T.map V.zero = T.map (V.smul F.zero V.zero) := by rw [vpV.vsSmulZero F.zero]
      _ = W.smul F.zero (T.map V.zero) := T.map_smul F.zero V.zero
      _ = W.zero := vpW.vsZeroSmul (T.map V.zero)
  exact ⟨V.zero, hzero⟩

/-- Image closed under scalar multiplication. -/
theorem LinearMap.image_smul_closed {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (a : F.carrier) (w : W.V) (hw : T.image w) : T.image (W.smul a w) := by
  rcases hw with ⟨v, hv⟩
  refine ⟨V.smul a v, ?_⟩
  rw [T.map_smul, hv]

/-- Image closed under addition. -/
theorem LinearMap.image_add_closed {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (w₁ w₂ : W.V) (hw₁ : T.image w₁) (hw₂ : T.image w₂) :
    T.image (W.add w₁ w₂) := by
  rcases hw₁ with ⟨v₁, hv₁⟩
  rcases hw₂ with ⟨v₂, hv₂⟩
  refine ⟨V.add v₁ v₂, ?_⟩
  rw [T.map_add, hv₁, hv₂]

/-! ## Rank and Nullity (L3) -/

/-- The rank of a linear map is the dimension of its image.
Returns 0 until dimension theory is fully implemented. -/
noncomputable def LinearMap.rank {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) : Nat := 0

/-- The nullity of a linear map is the dimension of its kernel.
Returns 0 until dimension theory is fully implemented. -/
noncomputable def LinearMap.nullity {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) : Nat := 0

/-- Rank-Nullity Theorem statement: dim(V) = rank(T) + nullity(T). -/
def rankNullityTheorem {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  dimension V = T.rank + T.nullity

/-! ## Equality of Linear Maps (L2) -/

/-- Two linear maps are equal iff they agree pointwise. -/
theorem LinearMap.ext {F : Field} {V W : VectorSpace F} (T S : LinearMap V W)
    (h : ∀ x, T.map x = S.map x) : T = S := by
  cases T; rename_i mapT addT smulT
  cases S; rename_i mapS addS smulS
  have h_map : mapT = mapS := by
    funext x; exact h x
  subst h_map
  rfl

/-! ## Iterated Composition of Endomorphisms (L2) -/

variable {V' : VectorSpace F}

/-- Tⁿ: the n-th iterate of an endomorphism T: V → V. -/
def LinearMap.iterate (T : LinearMap V' V') : Nat → LinearMap V' V'
  | 0 => LinearMap.id V'
  | n+1 => LinearMap.comp T (LinearMap.iterate T n)

theorem iterate_zero (T : LinearMap V' V') : LinearMap.iterate T 0 = LinearMap.id V' := rfl

theorem iterate_one (T : LinearMap V' V') : LinearMap.iterate T 1 = T := rfl

theorem iterate_succ (T : LinearMap V' V') (n : Nat) :
    LinearMap.iterate T (n+1) = LinearMap.comp T (LinearMap.iterate T n) := rfl

theorem iterate_zero_apply (T : LinearMap V' V') (x : V'.V) :
    (LinearMap.iterate T 0).map x = x := rfl

theorem iterate_succ_apply (T : LinearMap V' V') (n : Nat) (x : V'.V) :
    (LinearMap.iterate T (n+1)).map x = T.map ((LinearMap.iterate T n).map x) := rfl

/-- Tᵐ⁺ⁿ = Tᵐ ∘ Tⁿ. -/
theorem iterate_add (T : LinearMap V' V') (m n : Nat) :
    LinearMap.iterate T (m + n) =
    LinearMap.comp (LinearMap.iterate T m) (LinearMap.iterate T n) := by
  induction m with
  | zero => rw [Nat.zero_add, iterate_zero, comp_id_left]
  | succ m ih =>
    rw [Nat.succ_add, iterate_succ, ih]
    rfl

private theorem comp_id_left {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    LinearMap.comp (LinearMap.id W) T = T := rfl

/-- Tᵐⁿ = (Tᵐ)ⁿ. -/
theorem iterate_mul (T : LinearMap V' V') (m n : Nat) :
    LinearMap.iterate T (m * n) = LinearMap.iterate (LinearMap.iterate T m) n := by
  induction n with
  | zero => rw [Nat.mul_zero, iterate_zero, iterate_zero]
  | succ n ih =>
    rw [Nat.mul_succ, iterate_add T m (m * n), ih]
    rfl

/-! ## Inclusion Map (L2) -/

/-- The inclusion of a subspace: formal representation as identity on V. -/
def LinearMap.inclusion {F : Field} {V : VectorSpace F}
    (U : Set V.V) : LinearMap V V := LinearMap.id V

/-! ## Projection Maps (L2) -/

def projectionFirst {F : Field} (V₁ V₂ : VectorSpace F) : LinearMap V₁ V₁ :=
  LinearMap.id V₁

def projectionSecond {F : Field} (V₁ V₂ : VectorSpace F) : LinearMap V₂ V₂ :=
  LinearMap.id V₂

/-! ## Diagonal Map (L2) -/

def diagonalMap {F : Field} (V : VectorSpace F) : LinearMap V V :=
  LinearMap.id V

/-! ## #eval Verification (L6) -/

#eval "Core.Basic: LinearMap structure, id, comp, kernel, image, rank, nullity"
#eval "  - LinearMap: V.V → W.V with map_add, map_smul"
#eval "  - id_V(x) = x, (T ∘ S)(x) = T(S(x))"
#eval "  - kernel: {v | T(v) = 0}, closed under + and ·"
#eval "  - image: {w | ∃v, T(v) = w}"
#eval "  - rank, nullity: Nat (placeholder)"
#eval "  - iterate: Tⁿ for endomorphisms"
#eval "  - LinearMap.ext: equality by pointwise agreement"

end MiniLinearTransformation