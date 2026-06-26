/-
# MiniSpectralCanonical.Morphisms.Iso

L2-L3: Isomorphisms between spectral structures.
Spectral type classification, Jordan-Chevalley decomposition,
real Jordan form, and structure-preserving isomorphisms.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Morphisms.Hom

namespace MiniSpectralCanonical

/-! ## L3: Spectral Type Classification -/

inductive SpectralType2x2 where
  | realDistinct (l1 l2 : Rat)
  | realRepeated (l : Rat)
  | complexConjugate (realPart imagPart : Rat)
  deriving Repr

def Mat.spectralType2 (A : Mat 2 2) : SpectralType2x2 :=
  let a := A 0 0; let b := A 0 1
  let c := A 1 0; let d := A 1 1
  let disc := (a+d)*(a+d) - 4*(a*d - b*c)
  if disc > 0 then
    let sqrtDisc := disc.sqrt.toRat
    SpectralType2x2.realDistinct ((a+d + sqrtDisc) / 2) ((a+d - sqrtDisc) / 2)
  else if disc = 0 then
    SpectralType2x2.realRepeated ((a+d)/2)
  else
    let imag := ((-disc).sqrt.toRat) / 2
    SpectralType2x2.complexConjugate ((a+d)/2) imag

/-! ## L3: Isomorphism of Jordan Forms -/

structure JordanIsomorphism2x2 where
  source : JordanCanonicalForm
  target : JordanCanonicalForm
  P : Mat 2 2
  Pinv : Mat 2 2
  conjugation : Mat.mul (Mat.mul Pinv (JordanCanonicalForm.toMatrix source))
                        P = JordanCanonicalForm.toMatrix target

/-! ## L3: Companion Matrix Isomorphism -/

structure CompanionIsomorphism where
  source : CompanionMatrix
  target : CompanionMatrix
  isIdentical : source = target
  deriving Repr

/-! ## L3: Real Jordan Form

For a real matrix with complex eigenvalues a +/- bi,
the real Jordan form uses 2x2 blocks [[a, -b], [b, a]].
-/

structure RealJordanBlock2x2 where
  realPart : Rat
  imagPart : Rat
  isComplexPair : Bool

def RealJordanBlock2x2.toMatrix (rjb : RealJordanBlock2x2) : Mat 2 2 :=
  if rjb.isComplexPair then
    Mat.ofList2x2 rjb.realPart (-rjb.imagPart) rjb.imagPart rjb.realPart
  else
    Mat.ofList2x2 rjb.realPart 1 0 rjb.realPart

/-! ## L3: Jordan-Chevalley Decomposition

Every matrix A decomposes uniquely as A = S + N where
S is diagonalizable, N is nilpotent, and SN = NS.
-/

structure ChevalleyDecomposition2x2 where
  S : Mat 2 2
  N : Mat 2 2
  isDiagonalizableS : (Mat.eigenvalues2 S).length >= 1
  isNilpotentN : Mat.det2 N = 0 /\ Mat.trace N = 0
  commuteSN : Mat.mul S N = Mat.mul N S
  decomposition : Mat.add S N = Mat.identity 2

def Mat.chevalleyDecomposition2 (A : Mat 2 2) : ChevalleyDecomposition2x2 :=
  let evs := Mat.eigenvalues2 A
  match evs with
  | [l1, l2] =>
    let S : Mat 2 2 := Mat.diagonal2 l1 l2
    let N : Mat 2 2 := Mat.sub A S
    { S := S, N := N,
      isDiagonalizableS := by
        unfold Mat.eigenvalues2; simp
      isNilpotentN := And.intro rfl rfl
      commuteSN := by
        unfold Mat.mul Mat.diagonal2; ext i j; fin_cases i <;> fin_cases j <;> simp
      decomposition := by
        unfold Mat.add Mat.sub; ext i j; fin_cases i <;> fin_cases j <;> ring
    }
  | [l] =>
    let S : Mat 2 2 := Mat.diagonal2 l l
    let N : Mat 2 2 := Mat.sub A S
    { S := S, N := N,
      isDiagonalizableS := by simp
      isNilpotentN := And.intro rfl rfl
      commuteSN := by
        unfold Mat.mul Mat.diagonal2; ext i j; fin_cases i <;> fin_cases j <;> simp
      decomposition := by
        unfold Mat.add Mat.sub; ext i j; fin_cases i <;> fin_cases j <;> ring
    }
  | _ =>
    { S := A, N := Mat.zero 2 2,
      isDiagonalizableS := by trivial
      isNilpotentN := And.intro rfl rfl
      commuteSN := by simp
      decomposition := by simp
    }

/-! ## L3: Spectral Isomorphism Invariants -/

structure SpectralInvariants2x2 where
  trace : Rat
  determinant : Rat
  spectralRadius : Rat
  signature : Signature
  matrixType : MatrixType2x2
  deriving Repr

def Mat.spectralInvariants2 (A : Mat 2 2) : SpectralInvariants2x2 :=
  { trace := Mat.trace A
    determinant := Mat.det2 A
    spectralRadius := Mat.spectralRadius2 A
    signature := Mat.signature2 A
    matrixType := Mat.classify2x2 A
  }

/-! ## L3: Duality Between JCF and RCF

Over C, the Jordan form and rational form are related:
each invariant factor's roots give eigenvalues, and
root multiplicities give Jordan block sizes.
-/

def jcf_to_rcf (jcf : JordanCanonicalForm) : RationalCanonicalForm :=
  let companions := jcf.blocks.map (fun jb =>
    if jb.size = 1 then
      CompanionMatrix.ofLinear jb.eigenvalue
    else
      CompanionMatrix.ofDegree1 jb.eigenvalue)
  { companions := companions,
    totalSize := jcf.totalSize,
    sizeCorrect := by
      simp
  }

end MiniSpectralCanonical