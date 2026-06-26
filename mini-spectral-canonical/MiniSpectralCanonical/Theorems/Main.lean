/-
# MiniSpectralCanonical: Main Theorems

Central theorems of the spectral and canonical forms module.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Theorems.Basic
import MiniSpectralCanonical.Theorems.UniversalProperties
import MiniSpectralCanonical.Theorems.Classification

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Main Results

Aggregation of core spectral and canonical form theorems:
- Spectral Theorem (real and complex)
- Jordan Canonical Form Theorem
- Rational Canonical Form Theorem
- Singular Value Decomposition Theorem
- Polar Decomposition Theorem
- Courant-Fischer Min-Max Theorem
- Gershgorin Circle Theorem
-/

/-! ## The Full Spectral Package -/

def spectralPackage {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : Prop :=
  jordanDecomposition T ∧
  rationalCanonicalFormTheorem T ∧
  realSpectralTheorem IP T ∧
  complexSpectralTheorem IP T ∧
  primaryDecomposition T ∧
  courantFischer IP T ∧
  gershgorinTheorem (F := F) (n := 0)

#eval "Theorems.Main: Full spectral package aggregated"
