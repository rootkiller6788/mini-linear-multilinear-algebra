/-
# MiniSpectralCanonical.Core.Objects

Object instances for spectral and canonical form structures.
Registers Jordan blocks, companion matrices, SVD as object types.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Object Registration for Spectral Structures -/

def spectralTheory : String := "SpectralCanonicalTheory"

/-! ## Jordan Block as Object -/

def jordanBlockObj {F : Field} (b : JordanBlock F) : String :=
  s!"JordanBlock(λ={b.eigenvalue}, size={b.size})"

/-! ## Companion Matrix as Object -/

def companionMatrixObj {F : Field} (cm : CompanionMatrix F) : String :=
  s!"CompanionMatrix(poly, size={cm.size})"

/-! ## Rational Canonical Form as Object -/

def rationalCFObj {F : Field} {V : VectorSpace F} (rcf : RationalCanonicalForm T) : String :=
  s!"RationalCanonicalForm"

/-! ## SVD as Object -/

def svdObj {F : Field} {V W : VectorSpace F} (svd : SVD F V W T) : String :=
  s!"SVD(singularValues={svd.singularValues.length})"

#eval "Core.Objects: Spectral structures registered as objects"
