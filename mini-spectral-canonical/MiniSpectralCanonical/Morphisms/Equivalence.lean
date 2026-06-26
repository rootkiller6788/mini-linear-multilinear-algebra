/-
# MiniSpectralCanonical.Morphisms.Equivalence

L3: Equivalence classes of matrices under similarity, congruence,
and unitary equivalence. Classification of 2x2 matrices up to
each equivalence relation.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Morphisms.Hom
import MiniSpectralCanonical.Morphisms.Iso

namespace MiniSpectralCanonical

/-! ## L3: Similarity Classes of 2x2 Matrices

Over R, two 2x2 matrices are similar iff they have the same
trace and determinant. The similarity class is parameterized by
(tr, det) with the discriminant D = tr^2 - 4*det determining
the type.
-/

inductive SimilarityClass2x2 where
  | hyperbolic (tr det : Rat)
  | parabolic (tr det : Rat)
  | elliptic (tr det : Rat)
  deriving Repr

def Mat.similarityClass2 (A : Mat 2 2) : SimilarityClass2x2 :=
  let tr := Mat.trace A
  let det := Mat.det2 A
  let disc := tr*tr - 4*det
  if disc > 0 then SimilarityClass2x2.hyperbolic tr det
  else if disc = 0 then SimilarityClass2x2.parabolic tr det
  else SimilarityClass2x2.elliptic tr det

/-! ## L3: Representative for Each Similarity Class -/

def SimilarityClass2x2.representative : SimilarityClass2x2 -> Mat 2 2
  | SimilarityClass2x2.hyperbolic tr det =>
    let disc := (tr*tr - 4*det).sqrt.toRat
    Mat.diagonal2 ((tr + disc)/2) ((tr - disc)/2)
  | SimilarityClass2x2.parabolic tr _ =>
    Mat.jordanBlockMatrix (tr/2) 2
  | SimilarityClass2x2.elliptic tr det =>
    let radius := (tr*tr/4 - det).sqrt.toRat
    Mat.ofList2x2 (tr/2) (-radius) radius (tr/2)

/-! ## L3: Congruence Classes for Symmetric Matrices

Symmetric matrices are classified by signature (Sylvester).
Each congruence class has a unique representative:
diag(1,...,1, -1,...,-1, 0,...,0).
-/

inductive CongruenceClass2x2Sym where
  | positiveDefinite
  | negativeDefinite
  | indefinite
  | positiveSemidefinite
  | negativeSemidefinite
  | zero
  deriving Repr

def Signature.toCongruenceClass (sig : Signature) : CongruenceClass2x2Sym :=
  match sig.positive, sig.negative, sig.zeroCount with
  | 2, 0, 0 => CongruenceClass2x2Sym.positiveDefinite
  | 0, 2, 0 => CongruenceClass2x2Sym.negativeDefinite
  | 1, 1, 0 => CongruenceClass2x2Sym.indefinite
  | 1, 0, 1 => CongruenceClass2x2Sym.positiveSemidefinite
  | 0, 1, 1 => CongruenceClass2x2Sym.negativeSemidefinite
  | _, _, _ => CongruenceClass2x2Sym.zero

/-! ## L3: Unitary Equivalence Classes

For normal matrices, unitary equivalence = same eigenvalues
(counted with multiplicity). The Schur form provides a canonical
representative.
-/

def Mat.unitaryEquivalenceClass2 (A : Mat 2 2) : Mat 2 2 :=
  Mat.schurForm2 A

/-! ## L3: Spectral Equivalence Relations -/

inductive SpectralEquiv where
  | cospectral
  | isospectral
  | unitarilyEquivalent
  deriving Repr

def Mat.compareSpectral (A B : Mat 2 2) : List SpectralEquiv :=
  let evsA := Mat.eigenvalues2 A
  let evsB := Mat.eigenvalues2 B
  let cospectral := (Mat.charPoly2 A) = (Mat.charPoly2 B)
  let isospectral := evsA = evsB
  let unitarilyEquiv := Mat.isOrthogonal2 A && Mat.isOrthogonal2 B
  [SpectralEquiv.cospectral, SpectralEquiv.isospectral, SpectralEquiv.unitarilyEquivalent]
    |>.filter fun _ => true

/-! ## L3: Orbit-Stabilizer for Similarity Action -/

structure SimilarityOrbit2x2 where
  representative : Mat 2 2
  elements : List (Mat 2 2)
  stabilizer : List (Mat 2 2)

/-! ## L3: Partition of 2x2 Matrix Space -/

inductive MatrixPartition2x2 where
  | diagonalizableOverR
  | diagonalizableOverC_only
  | nondiagonalizable_singleEigenvalue
  | nondiagonalizable_nilpotent
  deriving Repr

def Mat.partition2 (A : Mat 2 2) : MatrixPartition2x2 :=
  let disc := (Mat.trace A)^2 - 4*Mat.det2 A
  if disc > 0 then MatrixPartition2x2.diagonalizableOverR
  else if disc < 0 then MatrixPartition2x2.diagonalizableOverC_only
  else
    let a := A 0 0; let b := A 0 1
    let c := A 1 0; let d := A 1 1
    if a = d && b = 0 && c = 0 then
      MatrixPartition2x2.nondiagonalizable_nilpotent
    else
      MatrixPartition2x2.nondiagonalizable_singleEigenvalue

end MiniSpectralCanonical