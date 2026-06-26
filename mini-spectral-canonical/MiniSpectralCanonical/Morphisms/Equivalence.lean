/-
# MiniSpectralCanonical: Equivalence Relations

Equivalence relations for spectral data and canonical forms.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Spectral Equivalence -/

-- Two operators are spectrally equivalent if they have the same eigenvalues
structure SpectralEquivalence {F : Field} {V : VectorSpace F} (S T : LinearMap V V) where
  sameEigenvalues : True  -- placeholder
  sameMultiplicities : True  -- placeholder

/-! ## Jordan Equivalence -/

-- Two Jordan forms are equivalent if they have the same blocks (up to ordering)
structure JordanEquivalence {F : Field} (JCF1 JCF2 : JordanCanonicalForm T) where
  sameBlocks : True  -- placeholder: blocks identical up to permutation

/-! ## Unitary Equivalence Relation -/

-- Unitary equivalence is finer than similarity for inner product spaces
structure UnitaryEquivalenceRel {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (S T : LinearMap V V) where
  existsUnitary : ∃ (U : LinearMap V V), isUnitary IP U ∧ T = LinearMap.comp (LinearMap.comp U S) (LinearMap.adjoint IP U)

#eval "Morphisms.Equivalence: SpectralEquivalence, JordanEquivalence, UnitaryEquivalenceRel"
