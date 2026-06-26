/-
# MiniSpectralCanonical.Morphisms.Hom

L2-L3: Similarity, unitary equivalence, congruence.
Structure-preserving transformations for spectral theory.
-/

import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

/-! ## L2: Similarity Transformations

Two matrices A, B are similar if B = P^{-1} A P for invertible P.
For 2x2, similarity is characterized by equal trace and determinant.
-/

structure Similarity2x2 where
  A : Mat 2 2
  B : Mat 2 2
  P : Mat 2 2
  Pinv : Mat 2 2
  PinvP_eq_I : Mat.mul Pinv P = Mat.identity 2
  PPinv_eq_I : Mat.mul P Pinv = Mat.identity 2
  similar : Mat.mul (Mat.mul Pinv A) P = B
  deriving Repr

def Similarity2x2.refl (A : Mat 2 2) : Similarity2x2 :=
  { A := A, B := A,
    P := Mat.identity 2, Pinv := Mat.identity 2,
    PinvP_eq_I := by
      unfold Mat.mul; ext i j; fin_cases i <;> fin_cases j <;> simp [Mat.identity]
    PPinv_eq_I := by
      unfold Mat.mul; ext i j; fin_cases i <;> fin_cases j <;> simp [Mat.identity]
    similar := by
      simp [Mat.mul, Mat.identity]
  }

def Similarity2x2.symm (s : Similarity2x2) : Similarity2x2 :=
  { A := s.B, B := s.A,
    P := s.Pinv, Pinv := s.P,
    PinvP_eq_I := s.PPinv_eq_I,
    PPinv_eq_I := s.PinvP_eq_I,
    similar := by
      rw [s.similar]
      simp [Mat.mul]
  }

def Similarity2x2.trans (s1 s2 : Similarity2x2) : Similarity2x2 :=
  { A := s1.A, B := s2.B,
    P := Mat.mul s2.P s1.P,
    Pinv := Mat.mul s1.Pinv s2.Pinv,
    PinvP_eq_I := by
      -- (P1^{-1} P2^{-1}) (P2 P1) = P1^{-1} I P1 = I
      simp [Mat.mul]
    PPinv_eq_I := by
      simp [Mat.mul]
    similar := by
      rw [s1.similar, s2.similar]
      simp [Mat.mul]
  }

/-! ## L2: Unitary Equivalence

Two matrices A, B are unitarily equivalent if B = U^* A U
for unitary U. Unitary equivalence preserves singular values.
-/

structure UnitaryEquivalence2x2 where
  A : Mat 2 2
  B : Mat 2 2
  U : Mat 2 2
  isUnitaryU : Mat.isOrthogonal2 U
  equivalent : Mat.mul (Mat.mul (Mat.transpose U) A) U = B
  deriving Repr

/-! ## L2: Congruence

A and B are congruent if B = P^T A P for invertible P.
Congruence preserves symmetry and (by Sylvester) signature.
-/

structure Congruence2x2 where
  A : Mat 2 2
  B : Mat 2 2
  P : Mat 2 2
  Pinv : Mat 2 2
  PinvP_eq_I : Mat.mul Pinv P = Mat.identity 2
  congruent : Mat.mul (Mat.mul (Mat.transpose P) A) P = B
  deriving Repr

/-! ## L2: Direct Sum of Matrices

The direct sum A (+) B is block diagonal [A 0; 0 B].
-/

def Mat.directSum2 (A B : Mat 2 2) : Mat 4 4 :=
  fun i j =>
    match i.val, j.val with
    | 0, 0 => A 0 0 | 0, 1 => A 0 1 | 0, 2 => 0 | 0, 3 => 0
    | 1, 0 => A 1 0 | 1, 1 => A 1 1 | 1, 2 => 0 | 1, 3 => 0
    | 2, 0 => 0      | 2, 1 => 0      | 2, 2 => B 0 0 | 2, 3 => B 0 1
    | 3, 0 => 0      | 3, 1 => 0      | 3, 2 => B 1 0 | 3, 3 => B 1 1

/-! ## L2: Block Diagonalization

A matrix is block diagonal if it decomposes as a direct sum
of smaller blocks. The Jordan form is the finest block diagonalization.
-/

structure BlockDiagonal2x2 where
  block1 : Mat 1 1
  block2 : Mat 1 1
  P : Mat 2 2
  Pinv : Mat 2 2

/-! ## L2: Similarity Preserves Trace (Proof)

Trace is a similarity invariant: tr(P^{-1}AP) = tr(A).
-/

theorem similarity_preserves_trace_2x2 (s : Similarity2x2) :
    Mat.trace s.A = Mat.trace s.B := by
  rw [s.similar]
  unfold Mat.trace Mat.mul
  simp; ring

/-! ## L2: Similarity Preserves Determinant (Proof)

det(P^{-1}AP) = det(A).
-/

theorem similarity_preserves_det_2x2 (s : Similarity2x2) :
    Mat.det2 s.A = Mat.det2 s.B := by
  rw [s.similar]
  unfold Mat.det2 Mat.mul
  simp; ring

/-! ## L2: Similarity Preserves Characteristic Polynomial

If A and B are similar, then charPoly(A) = charPoly(B).
-/

theorem similarity_preserves_charPoly_2x2 (s : Similarity2x2) :
    Mat.charPoly2 s.A = Mat.charPoly2 s.B := by
  rw [s.similar]
  unfold Mat.charPoly2 Mat.mul
  simp; ring

/-! ## L2: Symmetry is Congruence-Invariant

If A is symmetric and B is congruent to A, then B is symmetric.
-/

theorem congruence_preserves_symmetry (c : Congruence2x2) (h_sym : Mat.isSymmetric2 c.A) :
    Mat.isSymmetric2 c.B := by
  rw [c.congruent]
  unfold Mat.isSymmetric2 Mat.transpose Mat.mul
  simp
  -- (P^T A P)^T = P^T A^T P = P^T A P (since A is symmetric)
  rw [h_sym]

/-! ## L2: Unitary Equivalence Preserves Singular Values

The singular values (eigenvalues of A^T A) are preserved.
-/

theorem unitary_equivalence_preserves_singular_values (ue : UnitaryEquivalence2x2) :
    Mat.eigenvalues2 (Mat.mul (Mat.transpose ue.A) ue.A) =
    Mat.eigenvalues2 (Mat.mul (Mat.transpose ue.B) ue.B) := by
  rw [ue.equivalent]
  unfold Mat.mul Mat.transpose
  -- (U^T A U)^T (U^T A U) = U^T A^T A U (similar)
  simp

/-! ## L2: Sum of Commuting Diagonalizable Matrices

If A and B commute and are both diagonalizable over a common basis,
then A+B is also diagonalizable.
-/

structure CommutingPair2x2 where
  A : Mat 2 2
  B : Mat 2 2
  commute : Mat.mul A B = Mat.mul B A

def CommutingPair2x2.isSimultaneouslyDiagonalizable (cp : CommutingPair2x2) : Bool :=
  Mat.isSymmetric2 cp.A && Mat.isSymmetric2 cp.B

end MiniSpectralCanonical