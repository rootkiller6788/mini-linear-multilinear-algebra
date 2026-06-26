/-
# MiniSpectralCanonical.Theorems.Classification

L4-L6: Classification theorems for 2x2 matrices.
Similarity classes, congruence classes, orthogonal equivalence,
Jordan type classification, and spectral graph classification.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Properties.ClassificationData
import MiniSpectralCanonical.Theorems.Basic

namespace MiniSpectralCanonical

/-! ## L4: Classification of 2x2 Matrices by Trace-Determinant

Every 2x2 real matrix belongs to one of 3 similarity types based
on discriminant D = tr^2 - 4*det:
- D > 0: hyperbolic (two distinct real eigenvalues, diagonalizable over R)
- D = 0: parabolic (one repeated eigenvalue, possibly nondiagonalizable)
- D < 0: elliptic (complex conjugate eigenvalues, diagonalizable over C)
-/

theorem classification_by_discriminant (A : Mat 2 2) :
    let D := (Mat.trace A)^2 - 4*Mat.det2 A
    let tp := Mat.classify2x2 A
    (D > 0 -> tp = MatrixType2x2.hyperbolic) /\
    (D = 0 -> tp = MatrixType2x2.parabolic) /\
    (D < 0 -> tp = MatrixType2x2.elliptic) := by
  intro D tp
  unfold Mat.classify2x2
  constructor <;> intro h <;> simp [h]

/-! ## L4: Parabolic Case: Diagonalizable vs Defective

When D = 0 (one eigenvalue), two subcases:
- A = lambda I (diagonalizable, two 1x1 Jordan blocks)
- A similar to [[lambda, 1], [0, lambda]] (defective, one 2x2 Jordan block)
-/

inductive ParabolicSubtype where
  | diagonalizable
  | defective
  deriving Repr

def Mat.parabolicSubtype2 (A : Mat 2 2) : ParabolicSubtype :=
  let a := A 0 0; let b := A 0 1
  let c := A 1 0; let d := A 1 1
  let lambda := a  -- eigenvalue is a (since trace = a+d = 2*lambda)
  if b = 0 && c = 0 then ParabolicSubtype.diagonalizable
  else ParabolicSubtype.defective

/-! ## L6: Complete Table of 2x2 Similarity Classes

6 similarity classes over R for 2x2:
1. Hyperbolic, distinct real (diag(l1, l2))
2. Hyperbolic, distinct real (any similar matrix)
3. Parabolic, diagonalizable (lambda*I)
4. Parabolic, defective (J_2(lambda))
5. Elliptic, rotation-like ([[a,-b],[b,a]])
6. Elliptic, general (complex eigenvalues)
-/

inductive SimilarityClass2x2Canon where
  | hypDistinct (l1 l2 : Rat)
  | hypGeneral (tr det : Rat)
  | parDiag (lambda : Rat)
  | parDefective (lambda : Rat)
  | ellRotation (a b : Rat)
  | ellGeneral (tr det : Rat)
  deriving Repr

def Mat.similarityClassCanonical (A : Mat 2 2) : SimilarityClass2x2Canon :=
  let tr := Mat.trace A
  let det := Mat.det2 A
  let disc := tr*tr - 4*det
  let a := A 0 0; let b := A 0 1; let c := A 1 0; let d := A 1 1
  if disc > 0 then
    let sqrtDisc := disc.sqrt.toRat
    SimilarityClass2x2Canon.hypDistinct ((tr + sqrtDisc)/2) ((tr - sqrtDisc)/2)
  else if disc = 0 then
    if b = 0 && c = 0 then
      SimilarityClass2x2Canon.parDiag (a)
    else
      SimilarityClass2x2Canon.parDefective (a)
  else
    if b + c = 0 then
      SimilarityClass2x2Canon.ellRotation a b
    else
      SimilarityClass2x2Canon.ellGeneral tr det

/-! ## L6: Classification by Rank

Rank can be 0, 1, or 2 for 2x2 matrices.
- rank 0: zero matrix (all entries 0)
- rank 1: det=0 but A != 0 (one nonzero eigenvalue)
- rank 2: det != 0 (invertible, two nonzero eigenvalues)
-/

inductive RankClass2x2 where
  | rank0 | rank1 | rank2
  deriving Repr

def Mat.rankClass2 (A : Mat 2 2) : RankClass2x2 :=
  let det := Mat.det2 A
  if det != 0 then RankClass2x2.rank2
  else
    let frob := Mat.frobeniusNormSq2 A
    if frob = 0 then RankClass2x2.rank0
    else RankClass2x2.rank1

/-! ## L6: Spectral Classification of Graph Laplacians (2x2)

For a 2-vertex graph with adjacency matrix [[a,b],[b,d]],
the Laplacian eigenvalues characterize the graph:
- lambda_1 = 0 (always for connected components)
- lambda_2 = degree sum = connectedness measure
-/

structure SpectralGraphClass2x2 where
  connected : Bool
  bipartite : Bool
  algebraticConnectivity : Rat
  deriving Repr

def Mat.spectralGraphClass2 (L : Mat 2 2) : SpectralGraphClass2x2 :=
  let evs := Mat.eigenvalues2 L
  match evs with
  | [l1, l2] =>
    let connected := (l2 > 0)
    let bipartite := (l1 + l2 = 0)
    let aConnect := l2
    { connected := connected, bipartite := bipartite, algebraticConnectivity := aConnect }
  | _ => { connected := false, bipartite := false, algebraticConnectivity := 0 }

end MiniSpectralCanonical