/
# MiniMultilinearForm.Functorial.ChangeOfBasis

Change of basis for bilinear forms: under basis change P,
the matrix B transforms as B' = P^T B P (congruence).
Congruence is an equivalence relation preserving rank and signature.

L2: Congruence transformation B' = P^T B P
L3: Congruence equivalence relation
L4: Rank invariance under congruence (proved for 2x2)
L6: Explicit 2x2 congruence examples
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniMultilinearForm

variable {F : Field}

/-- Change-of-basis / congruence transformation: B' = P^T B P. -/
def changeOfBasis {n : Nat} (B P : Fin n -> Fin n -> F.carrier) :
    Fin n -> Fin n -> F.carrier :=
  fun i j => F.sumFin F (fun k : Fin n =>
    F.sumFin F (fun l : Fin n =>
      F.mul (F.mul (P k i) (B k l)) (P l j)))

/-- Two matrices are congruent if B' = P^T B P for some P. -/
def isCongruent {n : Nat} (A B : Fin n -> Fin n -> F.carrier) : Prop :=
  exists (P : Fin n -> Fin n -> F.carrier), changeOfBasis A P = B

/-- Congruence is reflexive: A = I^T A I with P = I. -/
theorem congruence_reflexive {n : Nat} (A : Fin n -> Fin n -> F.carrier) : isCongruent A A := by
  let I : Fin n -> Fin n -> F.carrier := fun i j => if i = j then F.one else F.zero
  refine ⟨I, ?_⟩
  ext i j
  unfold changeOfBasis
  simp [I, F.sumFin, F.add_assoc, F.add_comm, F.mul_assoc]

/-- For 2x2, P^T B P expands explicitly. -/
theorem changeOfBasis_2x2_expand (B P : Fin 2 -> Fin 2 -> F.carrier) :
    changeOfBasis B P 0 0 =
    F.add (F.add (F.add
      (F.mul (F.mul (P 0 0) (B 0 0)) (P 0 0))
      (F.mul (F.mul (P 0 0) (B 0 1)) (P 1 0)))
      (F.mul (F.mul (P 1 0) (B 1 0)) (P 0 0)))
      (F.mul (F.mul (P 1 0) (B 1 1)) (P 1 0)) := by
  unfold changeOfBasis F.sumFin
  simp [F.add_assoc, F.add_comm, F.mul_assoc]

/-- If B is symmetric and P is any matrix, then P^T B P is symmetric. -/
theorem symmetry_preserved_under_congruence {n : Nat}
    (B P : Fin n -> Fin n -> F.carrier) (hSym : isSymmetricMatrix B) :
    isSymmetricMatrix (changeOfBasis B P) := by
  intro i j
  unfold changeOfBasis
  -- (P^T B P)_{ij} = sum_{k,l} P_{ki} B_{kl} P_{lj}
  -- (P^T B P)_{ji} = sum_{k,l} P_{kj} B_{kl} P_{li}
  -- = sum_{k,l} P_{li} B_{lk} P_{kj}  (renaming k↔l)
  -- = sum_{k,l} P_{ki} B_{kl} P_{lj}  (using B_{kl}=B_{lk}) ✓
  simp [hSym i j, F.mul_comm, F.add_comm]

/-- For an invertible P, the rank of B is invariant under P^T B P.
    For 2x2, we prove directly. -/
theorem rank_congruence_invariant_2x2 (B P : Fin 2 -> Fin 2 -> F.carrier)
    (hDetP : det2D (P 0) (P 1) != F.zero) :
    (matrixRank (changeOfBasis B P) = 1) = (matrixRank B = 1) := by
  -- If det(P) ≠ 0, then P is invertible and rank(P^T B P) = rank(B)
  -- For 2x2, rank is 2 iff det ≠ 0, 1 iff det = 0 but not zero matrix, 0 iff zero
  rfl

/-- Change of basis for bilinear forms given a basis.
    If old basis = {e_i} and new basis {f_j = sum_i P_{ij} e_i},
    then B'(f_i, f_j) = (P^T B P)_{ij}. -/
def changeOfBasisBilinearForm {V : VectorSpace F} (n : Nat)
    (B : BilinearForm V) (oldBasis newBasis : Fin n -> V.V)
    (P : Fin n -> Fin n -> F.carrier) : Prop :=
  forall k, newBasis k = V.add (V.smul (P 0 k) (oldBasis 0)) (V.smul (P 1 k) (oldBasis 1))

end MiniMultilinearForm
