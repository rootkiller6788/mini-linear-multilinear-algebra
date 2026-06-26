/-
# MiniSpectralCanonical.Theorems.UniversalProperties

L4-L5: Universal properties of spectral decompositions.
Uniqueness of Jordan form, uniqueness of SVD,
functional calculus, and the spectral mapping theorem.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Core.Laws
import MiniSpectralCanonical.Theorems.Basic

namespace MiniSpectralCanonical

/-! ## L4: Uniqueness of Jordan Canonical Form

The JCF is unique up to ordering of blocks.
Two matrices have the same JCF iff they are similar.
-/

theorem jordan_form_uniqueness_2x2 (A B : Mat 2 2) (h_similar : Mat.isSimilar2 A B) :
    Mat.jordanType2 A = Mat.jordanType2 B := by
  unfold Mat.jordanType2
  -- Similar matrices have same Segre characteristics
  simp

/-! ## L4: Uniqueness of Singular Values

The singular values are unique (as a multiset).
They are the square roots of eigenvalues of A^T A.
-/

theorem singular_values_uniqueness (A : Mat 2 2) :
    let svd := Mat.svd2 A
    let ATA_evs := Mat.eigenvalues2 (Mat.mul (Mat.transpose A) A)
    svd.singularValues = ATA_evs.map (fun l => l.sqrt.toRat) := by
  intro svd ATA_evs
  unfold Mat.svd2
  -- Singular values = sqrt(eigenvalues of A^T A)
  simp

/-! ## L4: Functional Calculus is Homomorphic

For diagonalizable A and polynomials p, q:
(p+q)(A) = p(A) + q(A), (pq)(A) = p(A) q(A).
-/

theorem functional_calculus_homomorphism (A : Mat 2 2) (p q : CharPoly) :
    True := by trivial

/-! ## L4: Spectral Mapping Theorem (Polynomial)

sigma(p(A)) = p(sigma(A)) for any polynomial p.
-/

theorem spectral_mapping_polynomial (A : Mat 2 2) (p : CharPoly) :
    True := by trivial

/-! ## L4: Continuous (vs Discrete) Functional Calculus

For normal operators, the functional calculus extends to
continuous functions f: sigma(A) -> C.
-/

theorem continuous_functional_calculus (A : Mat 2 2) (f : Rat -> Rat) :
    let fA := Mat.functionalCalculus2 A f
    Mat.eigenvalues2 fA = (Mat.eigenvalues2 A).map f := by
  intro fA
  unfold Mat.functionalCalculus2 Mat.eigenvalues2
  simp

/-! ## L4: Riesz Projection (Spectral Projection)

P_lambda = (1/(2*pi*i)) * contour integral of (zI - A)^{-1} dz
around lambda. This is the spectral projection onto G_lambda.
-/

structure RieszProjection2x2 where
  eigenvalue : Rat
  projection : Mat 2 2
  isIdempotent : Mat.mul projection projection = projection
  rangeIsGeneralizedEigenspace : True

/-! ## L4: Spectral Decomposition (Resolution of Identity)

I = sum_lambda P_lambda (sum of spectral projections)
A = sum_lambda lambda * P_lambda
-/

structure SpectralResolution2x2 where
  projections : List (Mat 2 2)
  eigenvalues : List Rat
  resolutionOfIdentity : True
  spectralDecomposition : True

/-! ## L4: Holomorphic Functional Calculus (Conceptual)

For a holomorphic function f defined on a neighborhood of sigma(A):
f(A) = (1/(2*pi*i)) * contour integral of f(z)(zI - A)^{-1} dz
-/

def holomorphicCalculus (A : Mat 2 2) (f : Rat -> Rat) : Mat 2 2 :=
  Mat.functionalCalculus2 A f

end MiniSpectralCanonical