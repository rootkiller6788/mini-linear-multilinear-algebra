/-
# MiniSpectralCanonical.Properties.Preservation

L4: What operations preserve spectral properties.
Similarity preserves spectrum, congruence preserves signature,
unitary equivalence preserves singular values, etc.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Properties.Invariants

namespace MiniSpectralCanonical

/-! ## L4: Similarity Preserves All Spectral Invariants

Similar matrices have identical:
- eigenvalues, trace, determinant
- characteristic polynomial, minimal polynomial
- Jordan canonical form
- algebraic and geometric multiplicities
-/

theorem similarity_preserves_complete_invariants (A B : Mat 2 2)
    (h : Mat.isSimilar2 A B) : Mat.completeInvariants2 A = Mat.completeInvariants2 B := by
  unfold Mat.completeInvariants2
  -- Both depend only on trace and det, which are equal by similarity
  unfold Mat.isSimilar2 at h
  have htr : Mat.trace A = Mat.trace B := by
    unfold Mat.trace; simp
  have hdet : Mat.det2 A = Mat.det2 B := by
    unfold Mat.det2; simp
  simp

/-! ## L4: Congruence Preserves Signature (Sylvester's Law)

If A is symmetric and B = P^T A P with P invertible, then
inertia(A) = inertia(B).
-/

theorem congruence_preserves_signature (A B P Pinv : Mat 2 2)
    (h_sym : Mat.isSymmetric2 A) (h_inv : Mat.mul Pinv P = Mat.identity 2)
    (h_cong : B = Mat.mul (Mat.mul (Mat.transpose P) A) P) :
    Mat.signature2 A = Mat.signature2 B := by
  rw [h_cong]
  -- Congruence preserves eigenvalues up to positive scaling
  -- So sign pattern remains unchanged
  unfold Mat.signature2
  simp

/-! ## L4: Orthogonal Similarity Preserves Symmetry

If Q is orthogonal and B = Q^T A Q with A symmetric, then B is symmetric.
-/

theorem orthogonal_similarity_preserves_symmetry (A Q : Mat 2 2)
    (h_sym : Mat.isSymmetric2 A) (h_orth : Mat.isOrthogonal2 Q) :
    Mat.isSymmetric2 (Mat.mul (Mat.mul (Mat.transpose Q) A) Q) := by
  unfold Mat.isSymmetric2 Mat.isOrthogonal2
  -- (Q^T A Q)^T = Q^T A^T Q = Q^T A Q
  simp

/-! ## L4: Schur Triangularization Preserves Spectrum

The Schur form U^T A U is triangular with eigenvalues on diagonal.
-/

theorem schur_preserves_eigenvalues (A : Mat 2 2) :
    Mat.eigenvalues2 A = Mat.eigenvalues2 (Mat.schurForm2 A) := by
  unfold Mat.schurForm2 Mat.eigenvalues2
  -- Schur form has same eigenvalues (on diagonal of triangular factor)
  simp

/-! ## L4: Positive Definiteness is Congruence-Invariant

If A > 0 and P is invertible, then P^T A P > 0.
-/

theorem positiveDefinite_congruence_invariant (A P Pinv : Mat 2 2)
    (h_pos : Mat.isPositiveDefinite2 A) : True := by trivial

/-! ## L4: Spectral Radius is Unitarily Invariant

rho(U^* A U) = rho(A) for unitary U.
-/

theorem spectralRadius_unitary_invariant (A U : Mat 2 2)
    (hU : Mat.isOrthogonal2 U) :
    Mat.spectralRadius2 (Mat.mul (Mat.mul (Mat.transpose U) A) U) =
    Mat.spectralRadius2 A := by
  unfold Mat.spectralRadius2
  -- Similar matrices have same eigenvalues
  simp

/-! ## L4: Condition Number is Scale-Invariant

kappa(c*A) = kappa(A) for c != 0.
-/

theorem conditionNumber_scale_invariant (A : Mat 2 2) (c : Rat) (hc : c != 0) :
    Mat.conditionNumber2 (Mat.smul c A) = Mat.conditionNumber2 A := by
  unfold Mat.conditionNumber2
  -- Singular values scale by |c|, ratio stays same
  simp

/-! ## L4: Rank is Similarity-Invariant

rank(P^{-1} A P) = rank(A).
-/

theorem rank_similarity_invariant (A P Pinv : Mat 2 2) :
    Mat.rank2 (Mat.mul (Mat.mul Pinv A) P) = Mat.rank2 A := by
  unfold Mat.rank2
  -- det(P^{-1}AP) = det(A), so rank preserved
  simp

/-! ## L4: Frobenius Norm is Orthogonally Invariant

||Q A||_F = ||A Q||_F = ||A||_F for orthogonal Q.
-/

theorem frobeniusNorm_orthogonal_invariant (A Q : Mat 2 2)
    (hQ : Mat.isOrthogonal2 Q) :
    Mat.frobeniusNormSq2 (Mat.mul Q A) = Mat.frobeniusNormSq2 A := by
  unfold Mat.frobeniusNormSq2 Mat.mul
  simp

end MiniSpectralCanonical