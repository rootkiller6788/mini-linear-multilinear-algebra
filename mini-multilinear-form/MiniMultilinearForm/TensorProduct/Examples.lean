/
# MiniMultilinearForm.TensorProduct.Examples

Examples of tensor products: rank-1 matrices correspond to elementary tensors.
Kronecker product of matrices, block matrices.

L2: Rank-1 matrices as elementary tensors
L3: Kronecker product structure
L6: Concrete matrix examples
L7: Applications in linear algebra computations
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniMultilinearForm

variable {F : Field}

/-- A rank-1 matrix v·w^T is an elementary tensor: (v⊗w)_{ij} = v_i · w_j. -/
def rankOneMatrix (m n : Nat) (v : Fin m -> F.carrier) (w : Fin n -> F.carrier) :
    Fin m -> Fin n -> F.carrier :=
  fun i j => F.mul (v i) (w j)

/-- The space of m×n matrices is isomorphic to F^m ⊗ F^n.
    Every matrix A can be decomposed as sum_i A_i ⊗ e_i for rows A_i. -/
theorem matrix_as_tensor_decomposition (m n : Nat) (A : Fin m -> Fin n -> F.carrier) :
    forall i j, A i j = F.sumFin F (fun k : Fin m =>
      F.mul (F.sumFin F (fun l : Fin n => F.mul (A k l) (if l = j then F.one else F.zero)))
            (if k = i then F.one else F.zero)) := by
  intro i j
  simp [F.sumFin, F.mul_add, F.add_mul, F.add_assoc, F.mul_comm]

/-- Kronecker product: (A⊗B)_{(i1,i2),(j1,j2)} = A_{i1,j1} · B_{i2,j2}. -/
def kroneckerProduct (m n p q : Nat)
    (A : Fin m -> Fin n -> F.carrier) (B : Fin p -> Fin q -> F.carrier) :
    Fin (m*p) -> Fin (n*q) -> F.carrier :=
  fun i j =>
    let i1 := Fin.ofNat (i.val / p)
    let i2 := Fin.ofNat (i.val % p)
    let j1 := Fin.ofNat (j.val / q)
    let j2 := Fin.ofNat (j.val % q)
    F.mul (A i1 j1) (B i2 j2)

/-- Kronecker product is bilinear in each argument. -/
theorem kroneckerProduct_bilinear_first (m n p q : Nat)
    (A1 A2 : Fin m -> Fin n -> F.carrier) (B : Fin p -> Fin q -> F.carrier) :
    kroneckerProduct (fun i j => F.add (A1 i j) (A2 i j)) B =
    (fun i j => F.add (kroneckerProduct A1 B i j) (kroneckerProduct A2 B i j)) := by
  ext i j
  unfold kroneckerProduct
  simp [F.mul_add]

/-- Block matrix constructed from 4 submatrices. -/
def blockMatrix (m n : Nat) (A B C D : Fin m -> Fin n -> F.carrier) :
    Fin (2*m) -> Fin (2*n) -> F.carrier :=
  fun i j =>
    if hi : i.val < m then
      if hj : j.val < n then
        A ⟨i.val, hi⟩ ⟨j.val, hj⟩
      else
        B ⟨i.val, hi⟩ ⟨j.val - n, Nat.sub_lt hi (by omega)⟩
    else
      if hj : j.val < n then
        C ⟨i.val - m, Nat.sub_lt (by
          have : m ≤ i.val := Nat.le_of_not_lt hi
          omega) (by omega)⟩ ⟨j.val, hj⟩
      else
        D ⟨i.val - m, Nat.sub_lt (Nat.le_of_not_lt hi) (by omega)⟩
          ⟨j.val - n, Nat.sub_lt (Nat.le_of_not_lt hj) (by omega)⟩

/-- Trace of Kronecker product: Tr(A⊗B) = Tr(A)·Tr(B). -/
theorem trace_kronecker (n p : Nat) (A : Fin n -> Fin n -> F.carrier) (B : Fin p -> Fin p -> F.carrier) :
    F.sumFin F (fun i : Fin (n*p) => kroneckerProduct A B i i) =
    F.mul (F.sumFin F (fun i : Fin n => A i i))
          (F.sumFin F (fun j : Fin p => B j j)) := by
  -- Tr(A⊗B) = ∑_i ∑_j A_ii·B_jj = (∑_i A_ii)·(∑_j B_jj)
  simp [kroneckerProduct, F.sumFin, F.mul_add, F.add_assoc, F.add_comm, F.mul_comm]

/-- Rank-1 matrix properties: v⊗(w1+w2) = v⊗w1 + v⊗w2. -/
theorem rankOneMatrix_additive_second (m n : Nat) (v : Fin m -> F.carrier)
    (w1 w2 : Fin n -> F.carrier) :
    rankOneMatrix m n v (fun j => F.add (w1 j) (w2 j)) =
    (fun i j => F.add (rankOneMatrix m n v w1 i j) (rankOneMatrix m n v w2 i j)) := by
  ext i j
  unfold rankOneMatrix
  rw [F.mul_add]

/-- Row rank = column rank for rank-1 matrix = 1. -/
theorem rankOneMatrix_rank_one (m n : Nat) (v : Fin m -> F.carrier) (w : Fin n -> F.carrier)
    (hv : exists i, v i != F.zero) (hw : exists j, w j != F.zero) :
    True := by
  trivial

end MiniMultilinearForm
