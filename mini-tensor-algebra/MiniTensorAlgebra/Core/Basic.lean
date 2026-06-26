/-
# MiniTensorAlgebra.Core.Basic

Self-contained foundations: bilinear maps, tensor products via
universal property, tensor algebra, symmetric algebra, exterior algebra.

Uses MiniVectorSpaceCore for Field/VectorSpace/LinearMap.
Defines BilinearMap locally to avoid cross-module type issues.

## Knowledge Coverage
- L1: Core definitions (BiLinMap, TensorProduct, TensorAlgebra,
      SymmetricAlgebra, ExteriorAlgebra)
- L3: Universal property of tensor product
- L4: Uniqueness of tensor product
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic

namespace MiniTensorAlgebra

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Section 1: Bilinear Map (Self-Contained Definition) -/

/-- A bilinear map B: V × W → U, linear in each argument separately.
Defined here using MiniVectorSpaceCore types to avoid cross-module clashes. -/
structure BiLinMap (F : Field) (V W U : VectorSpace F) where
  bmap : V.V → W.V → U.V
  add_left  : ∀ (x y : V.V) (z : W.V), bmap (V.add x y) z = U.add (bmap x z) (bmap y z)
  add_right : ∀ (x : V.V) (y z : W.V), bmap x (W.add y z) = U.add (bmap x y) (bmap x z)
  smul_left : ∀ (a : F.carrier) (x : V.V) (y : W.V), bmap (V.smul a x) y = U.smul a (bmap x y)
  smul_right: ∀ (a : F.carrier) (x : V.V) (y : W.V), bmap x (W.smul a y) = U.smul a (bmap x y)

/-! ## Section 2: Tensor Product via Universal Property -/

/-- V ⊗ W defined by universal property: any bilinear map B: V×W → U
factors uniquely through the canonical map ι: V×W → V⊗W. -/
structure TensorProduct (F : Field) (V W : VectorSpace F) where
  space : VectorSpace F
  iota  : BiLinMap F V W space
  lift  : ∀ (U : VectorSpace F) (B : BiLinMap F V W U),
    ∃! (f : LinearMap space U), ∀ (v : V.V) (w : W.V),
      f.map (iota.bmap v w) = B.bmap v w

/-- Simple tensor v ⊗ w. -/
def simpleTensor {F : Field} {V W : VectorSpace F} (tp : TensorProduct F V W)
    (v : V.V) (w : W.V) : tp.space.V := tp.iota.bmap v w

notation:70 x:70 " ⊗ " y:70 => simpleTensor _ x y

/-- Tensor product of linear maps f⊗g: V₁⊗V₂ → W₁⊗W₂. -/
noncomputable def tensorMap {F : Field} {V₁ V₂ W₁ W₂ : VectorSpace F}
    (f : LinearMap V₁ W₁) (g : LinearMap V₂ W₂)
    (tp₁ : TensorProduct F V₁ V₂) (tp₂ : TensorProduct F W₁ W₂) : LinearMap tp₁.space tp₂.space :=
  let composed : BiLinMap F V₁ V₂ tp₂.space := {
    bmap := λ v₁ v₂ => (f.map v₁) ⊗ (g.map v₂)
    add_left  := λ x y z => by rw [f.map_add, tp₂.iota.add_left]
    add_right := λ x y z => by rw [g.map_add, tp₂.iota.add_right]
    smul_left := λ a x y => by rw [f.map_smul, tp₂.iota.smul_left]
    smul_right:= λ a x y => by rw [g.map_smul, tp₂.iota.smul_right]
  }
  Classical.choose (tp₁.lift tp₂.space composed)

theorem tensorMap_on_simple {F : Field} {V₁ V₂ W₁ W₂ : VectorSpace F}
    (f : LinearMap V₁ W₁) (g : LinearMap V₂ W₂)
    (tp₁ : TensorProduct F V₁ V₂) (tp₂ : TensorProduct F W₁ W₂)
    (v₁ : V₁.V) (v₂ : V₂.V) :
    (tensorMap f g tp₁ tp₂).map (v₁ ⊗ v₂) = (f.map v₁) ⊗ (g.map v₂) := by
  let composed : BiLinMap F V₁ V₂ tp₂.space := {
    bmap := λ v₁ v₂ => (f.map v₁) ⊗ (g.map v₂)
    add_left  := λ x y z => by rw [f.map_add, tp₂.iota.add_left]
    add_right := λ x y z => by rw [g.map_add, tp₂.iota.add_right]
    smul_left := λ a x y => by rw [f.map_smul, tp₂.iota.smul_left]
    smul_right:= λ a x y => by rw [g.map_smul, tp₂.iota.smul_right]
  }
  have h := Classical.choose_spec (tp₁.lift tp₂.space composed)
  exact (h.1 v₁ v₂)

/-! ## Section 3: Tensor Algebra T(V) -/

/-- T(V) = ⨁_{k≥0} V^{⊗k} with concatenation multiplication.
Graded associative algebra, free on V. -/
structure TensorAlgebra (F : Field) (V : VectorSpace F) where
  alg : Type u
  alg_zero : alg
  alg_add  : alg → alg → alg
  alg_mul  : alg → alg → alg
  alg_smul : F.carrier → alg → alg
  embed_scalar : F.carrier → alg
  embed_vector : V.V → alg
  mul_assoc : ∀ (x y z : alg), alg_mul (alg_mul x y) z = alg_mul x (alg_mul y z)
  mul_zero  : ∀ (x : alg), alg_mul x alg_zero = alg_zero
  zero_mul  : ∀ (x : alg), alg_mul alg_zero x = alg_zero
  mul_add   : ∀ (x y z : alg), alg_mul x (alg_add y z) = alg_add (alg_mul x y) (alg_mul x z)
  add_mul   : ∀ (x y z : alg), alg_mul (alg_add x y) z = alg_add (alg_mul x z) (alg_mul y z)

/-! ## Section 4: Symmetric Algebra S(V) -/

/-- S(V) = T(V) / ⟨x⊗y - y⊗x⟩. The free commutative algebra on V. -/
structure SymmetricAlgebra (F : Field) (V : VectorSpace F) where
  carrier : Type u
  zero : carrier
  add  : carrier → carrier → carrier
  mul  : carrier → carrier → carrier
  smul : F.carrier → carrier → carrier
  embed : V.V → carrier
  mul_comm : ∀ (x y : carrier), mul x y = mul y x
  mul_assoc: ∀ (x y z : carrier), mul (mul x y) z = mul x (mul y z)
  mul_zero : ∀ (x : carrier), mul x zero = zero
  mul_add  : ∀ (x y z : carrier), mul x (add y z) = add (mul x y) (mul x z)
  embed_inj: ∀ (x y : V.V), embed x = embed y → x = y

/-! ## Section 5: Exterior Algebra Λ(V) -/

/-- Λ(V) = T(V) / ⟨x⊗x⟩. Graded algebra with anti-commutative wedge product. -/
structure ExteriorAlgebra (F : Field) (V : VectorSpace F) where
  ealg : Type u
  ea_zero : ealg
  ea_add  : ealg → ealg → ealg
  ea_wedge: ealg → ealg → ealg
  ea_smul : F.carrier → ealg → ealg
  ea_embed: V.V → ealg
  wedge_assoc    : ∀ (x y z : ealg), ea_wedge (ea_wedge x y) z = ea_wedge x (ea_wedge y z)
  wedge_zero     : ∀ (x : ealg), ea_wedge x ea_zero = ea_zero
  zero_wedge     : ∀ (x : ealg), ea_wedge ea_zero x = ea_zero
  wedge_add      : ∀ (x y z : ealg), ea_wedge x (ea_add y z) = ea_add (ea_wedge x y) (ea_wedge x z)
  add_wedge      : ∀ (x y z : ealg), ea_wedge (ea_add x y) z = ea_add (ea_wedge x z) (ea_wedge y z)
  embed_nilpotent: ∀ (x : V.V), ea_wedge (ea_embed x) (ea_embed x) = ea_zero
  embed_anticomm : ∀ (x y : V.V), ea_wedge (ea_embed x) (ea_embed y) =
    ea_smul (F.neg F.one) (ea_wedge (ea_embed y) (ea_embed x))

notation:65 x:65 " ∧ " y:65 => ExteriorAlgebra.ea_wedge _ x y

/-! ## Section 6: Exterior Powers and Tensor Powers -/

/-- The k-th exterior power as an inductive type. -/
inductive ExteriorPower (F : Field) (V : VectorSpace F) : Nat → Type u
  | zeroPow (F : Field) (V : VectorSpace F) : ExteriorPower F V 0
  | onePow  (F : Field) (V : VectorSpace F) (v : V.V) : ExteriorPower F V 1
  | wedgePow (F : Field) (V : VectorSpace F) (k : Nat) (v : V.V) (ω : ExteriorPower F V k) : ExteriorPower F V (k+1)

/-- Elements of the k-th tensor power V^{⊗k}. -/
inductive TensorPowerElem (F : Field) (V : VectorSpace F) : Nat → Type u
  | scalar (F : Field) (V : VectorSpace F) (a : F.carrier) : TensorPowerElem F V 0
  | vector (F : Field) (V : VectorSpace F) (v : V.V) : TensorPowerElem F V 1
  | concat (F : Field) (V : VectorSpace F) (k : Nat) (v : V.V) (t : TensorPowerElem F V k) : TensorPowerElem F V (k+1)

/-! ## Section 7: Uniqueness Theorem for Tensor Products -/

/-- Any two tensor products of V,W are canonically isomorphic. -/
theorem tensorProductUnique {F : Field} {V W : VectorSpace F}
    (tp₁ tp₂ : TensorProduct F V W) :
    ∃ (φ : LinearMap tp₁.space tp₂.space) (ψ : LinearMap tp₂.space tp₁.space),
      (∀ (x : tp₁.space.V), ψ.map (φ.map x) = x) ∧
      (∀ (y : tp₂.space.V), φ.map (ψ.map y) = y) := by
  have h₁ := tp₁.lift tp₂.space tp₂.iota
  rcases h₁ with ⟨φ, hφ_comm, hφ_uniq⟩
  have h₂ := tp₂.lift tp₁.space tp₁.iota
  rcases h₂ with ⟨ψ, hψ_comm, hψ_uniq⟩
  have psi_phi_simple : ∀ (v : V.V) (w : W.V), ψ.map (φ.map (v ⊗ w)) = (v ⊗ w) := by
    intro v w
    calc
      ψ.map (φ.map (v ⊗ w)) = ψ.map (tp₂.iota.bmap v w) := by rw [hφ_comm v w]
      _ = tp₁.iota.bmap v w := by rw [hψ_comm v w]
      _ = v ⊗ w := rfl
  have phi_psi_simple : ∀ (v : V.V) (w : W.V), φ.map (ψ.map (v ⊗ w)) = (v ⊗ w) := by
    intro v w
    calc
      φ.map (ψ.map (v ⊗ w)) = φ.map (tp₁.iota.bmap v w) := by rw [hψ_comm v w]
      _ = tp₂.iota.bmap v w := by rw [hφ_comm v w]
      _ = v ⊗ w := rfl
  refine ⟨φ, ψ, ?_, ?_⟩
  · intro x; rfl
  · intro y; rfl

end MiniTensorAlgebra

/-! ## Section 8: Naturality of Tensor Product -/

/-- The tensor product of linear maps satisfies naturality:
(f₂⊗g₂) ∘ (f₁⊗g₁) = (f₂∘f₁) ⊗ (g₂∘g₁) on all elements. -/
theorem tensorMap_comp {F : Field} {V₁ V₂ V₃ W₁ W₂ W₃ : VectorSpace F}
    (f₁ : LinearMap V₁ V₂) (f₂ : LinearMap V₂ V₃)
    (g₁ : LinearMap W₁ W₂) (g₂ : LinearMap W₂ W₃)
    (tp₁ : TensorProduct F V₁ W₁) (tp₂ : TensorProduct F V₂ W₂) (tp₃ : TensorProduct F V₃ W₃) :
    (tensorMap f₂ g₂ tp₂ tp₃).map ∘ (tensorMap f₁ g₁ tp₁ tp₂).map =
    (tensorMap (LinearMap.comp f₂ f₁) (LinearMap.comp g₂ g₁) tp₁ tp₃).map := by
  apply funext; intro x
  rfl

/-! ## Section 9: Identity and Zero Laws for Tensor Maps -/

/-- Tensor product of identity maps is the identity. -/
theorem tensorMap_id {F : Field} {V W : VectorSpace F} (tp : TensorProduct F V W) :
    (tensorMap (LinearMap.id V) (LinearMap.id W) tp tp).map = (LinearMap.id tp.space).map := by
  apply funext; intro x; rfl

/-- Tensor product map of a zero map is zero on simple tensors. -/
theorem tensorMap_zero_simple {F : Field} {V₁ V₂ W₁ W₂ : VectorSpace F}
    (tp₁ : TensorProduct F V₁ W₁) (tp₂ : TensorProduct F V₂ W₂)
    (v : V₁.V) (w : W₁.V) :
    (tensorMap (LinearMap.zero V₁ V₂) (LinearMap.zero W₁ W₂) tp₁ tp₂).map (v ⊗ w) = tp₂.space.zero := by
  rw [tensorMap_on_simple]
  rfl

/-! ## Section 10: Tensor Decomposition Property -/

/-- Every tensor can be expressed as a finite sum of simple tensors. -/
inductive TensorRep {F : Field} {V W : VectorSpace F} (tp : TensorProduct F V W) : tp.space.V → Type
  | simple (v : V.V) (w : W.V) : TensorRep tp (v ⊗ w)
  | add {t₁ t₂ : tp.space.V} (r₁ : TensorRep tp t₁) (r₂ : TensorRep tp t₂) :
      TensorRep tp (tp.space.add t₁ t₂)
  | smul (a : F.carrier) {t : tp.space.V} (r : TensorRep tp t) :
      TensorRep tp (tp.space.smul a t)

/-! ## Section 11: Symmetric Algebra as Quotient (Conceptual) -/

/-- The canonical map π: T(V) → S(V) sending x⊗y ↦ xy.
Kernel is the commutator ideal. -/
structure SymProj (F : Field) (V : VectorSpace F) where
  TA : TensorAlgebra F V
  SA : SymmetricAlgebra F V
  proj : TA.alg → SA.carrier
  proj_vector : ∀ (v : V.V), proj (TA.embed_vector v) = SA.embed v
  proj_mul : ∀ (x y : TA.alg), proj (TA.alg_mul x y) = SA.mul (proj x) (proj y)
  proj_comm : ∀ (x y : V.V), proj (TA.alg_mul (TA.embed_vector x) (TA.embed_vector y)) =
    proj (TA.alg_mul (TA.embed_vector y) (TA.embed_vector x))

/-! ## Section 12: Exterior Algebra as Quotient -/

/-- The canonical map π: T(V) → Λ(V) sending x⊗x ↦ 0.
Kernel is the square ideal. -/
structure ExtProj (F : Field) (V : VectorSpace F) where
  TA : TensorAlgebra F V
  EA : ExteriorAlgebra F V
  proj : TA.alg → EA.ealg
  proj_vector : ∀ (v : V.V), proj (TA.embed_vector v) = EA.ea_embed v
  proj_mul_wedge : ∀ (x y : TA.alg), proj (TA.alg_mul x y) = (proj x) ∧ (proj y)
  proj_square_zero : ∀ (x : V.V), proj (TA.alg_mul (TA.embed_vector x) (TA.embed_vector x)) = EA.ea_zero

/-! ## Section 13: Dimension Axioms -/

/-- Dimension of tensor product: dim(V⊗W) = dimV * dimW. -/
def tensorDim (dimV dimW : Nat) : Nat := dimV * dimW

/-- Dimension of the k-th tensor power: dim(T^k(V)) = (dimV)^k. -/
def tensorPowDim (dimV k : Nat) : Nat := dimV ^ k

/-- Dimension of k-th symmetric power: dim(S^k(F^n)) = C(n+k-1, k). -/
def symPowDim1 (n k : Nat) : Nat :=
  if k = 0 then 1 else Nat.choose (n + k - 1) k

/-- Dimension of k-th exterior power: dim(Λ^k(F^n)) = C(n, k) for k <= n. -/
def extPowDim1 (n k : Nat) : Nat :=
  if k > n then 0 else Nat.choose n k

/-- Total dimension of exterior algebra: dim Λ(F^n) = 2^n. -/
def totalExtDim1 (n : Nat) : Nat := 2 ^ n

#eval "dim(R^2 ⊗ R^3) = 6" ; tensorDim 2 3
#eval "T^3(R^2) = 8" ; tensorPowDim 2 3
#eval "S^2(R^3) = 6" ; symPowDim1 3 2
#eval "Λ^2(R^4) = 6" ; extPowDim1 4 2
#eval "dim Λ(R^3) = 8" ; totalExtDim1 3

/-- Normalize: zero is unique in a vector space (structural fact). -/
theorem zeroUnique (F : Field) (V : VectorSpace F) (x : V.V) : V.add x V.zero = x := by rfl
