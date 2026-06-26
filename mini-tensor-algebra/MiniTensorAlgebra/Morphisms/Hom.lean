/-
# MiniTensorAlgebra.Morphisms.Hom

Homomorphisms (morphisms) between tensor products,
tensor algebras, symmetric algebras, and exterior algebras.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Constructions.Universal

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Tensor Product Homomorphism -/

structure TensorProductHom (F : Field) (V₁ V₂ W₁ W₂ : VectorSpace F) where
  TP₁ : TensorProduct F V₁ V₂
  TP₂ : TensorProduct F W₁ W₂
  f : LinearMap V₁ W₁
  g : LinearMap V₂ W₂
  map : LinearMap TP₁.T TP₂.T
  -- f ⊗ g : V₁ ⊗ V₂ → W₁ ⊗ W₂

/-! ## Tensor Algebra Homomorphism -/

structure TensorAlgebraHom (F : Field) (V W : VectorSpace F) where
  TAV : TensorAlgebra F V
  TAW : TensorAlgebra F W
  f : LinearMap V W
  lift : TAV.carrier → TAW.carrier
  -- induced algebra homomorphism T(f) : T(V) → T(W)

/-! ## Symmetric Algebra Homomorphism -/

structure SymmetricAlgebraHom (F : Field) (V W : VectorSpace F) where
  SAV : SymmetricAlgebra F V
  SAW : SymmetricAlgebra F W
  f : LinearMap V W
  lift : SAV.carrier → SAW.carrier
  -- induced algebra homomorphism S(f) : S(V) → S(W)

/-! ## Exterior Algebra Homomorphism -/

structure ExteriorAlgebraHom (F : Field) (V W : VectorSpace F) where
  EAV : ExteriorAlgebra F V
  EAW : ExteriorAlgebra F W
  f : LinearMap V W
  lift : EAV.carrier → EAW.carrier
  -- induced algebra homomorphism Λ(f) : Λ(V) → Λ(W)

/-! ## Composition of Tensor Homomorphisms -/

def composeTensorHoms {F : Field} {V₁ V₂ W₁ W₂ X₁ X₂ : VectorSpace F}
    (h₁ : TensorProductHom F V₁ V₂ W₁ W₂) (h₂ : TensorProductHom F W₁ W₂ X₁ X₂) :
    TensorProductHom F V₁ V₂ X₁ X₂ :=
  h₁  -- placeholder

#eval "Morphisms.Hom: TensorProductHom, TensorAlgebraHom, SymmetricAlgebraHom, ExteriorAlgebraHom"
