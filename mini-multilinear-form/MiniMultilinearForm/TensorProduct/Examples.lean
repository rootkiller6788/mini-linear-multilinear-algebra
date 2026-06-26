/-
# MiniMultilinearForm.TensorProduct.Examples

Examples of tensor products:
matrix spaces as tensor products, polynomial tensor products,
tensor product of linear maps.
-/

import MiniMultilinearForm.TensorProduct.Universal

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Matrices as Tensor Products -/

/-- The space of m×n matrices is isomorphic to F^m ⊗ F^n. -/
def matrixAsTensorProduct {F : Field} (m n : Nat) : Prop :=
  True  -- Stub: M_{m×n}(F) ≅ F^m ⊗ F^n

/-- A rank-1 matrix corresponds to v ⊗ w. -/
def rankOneMatrix {F : Field} (m n : Nat)
    (v : Fin m → F.carrier) (w : Fin n → F.carrier) : Fin m → Fin n → F.carrier :=
  fun i j => F.mul (v i) (w j)  -- (v⊗w)_{ij} = v_i w_j

/-! ## Polynomial Tensor Products -/

/-- The tensor product of polynomial rings: F[x] ⊗ F[y] ≅ F[x,y]. -/
def polynomialTensorProduct {F : Field} : Prop :=
  True  -- Stub

/-! ## Tensor Product of Linear Maps -/

/-- f ⊗ g acts on elementary tensors as (f⊗g)(v⊗w) = f(v) ⊗ g(w). -/
def tensorProductOfLinearMaps {F : Field} {V₁ V₂ W₁ W₂ : VectorSpace F}
    (f : V₁.V → V₂.V) (g : W₁.V → W₂.V) : Prop :=
  True  -- Stub

/-! ## Kronecker Product -/

/-- The Kronecker product of matrices is the matrix of tensor product of linear maps. -/
def kroneckerProduct {F : Field} (m n p q : Nat)
    (A : Fin m → Fin n → F.carrier) (B : Fin p → Fin q → F.carrier) :
    Fin (m*p) → Fin (n*q) → F.carrier :=
  fun i j => F.zero  -- Stub: (A⊗B)_{(i₁,i₂),(j₁,j₂)} = A_{i₁,j₁} B_{i₂,j₂}

#eval "TensorProduct.Examples: matrices, polynomials, Kronecker product"
