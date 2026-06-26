/-
# MiniSpectralCanonical: Isomorphisms

Isomorphism structures for spectral and canonical form data.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Morphisms.Hom

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Spectral Isomorphism -/

-- Two operators are spectrally isomorphic if they have the same spectral data
structure SpectralIso {F : Field} {V : VectorSpace F} (S T : LinearMap V V) where
  similar : Similarity S T
  sameSpectrum : True  -- placeholder: eigenvalues match with multiplicities

/-! ## Canonical Form Isomorphism -/

-- The canonical form is unique up to ordering of blocks
structure CanonicalFormIso {F : Field} (J1 J2 : JordanCanonicalForm T) where
  blockPermutation : True  -- placeholder: blocks are same up to permutation

/-! ## SVD Uniqueness -/

-- SVD is unique up to sign changes in singular vectors
structure SVDIso {F : Field} {V W : VectorSpace F} (svd1 svd2 : SVD F V W T) where
  sameSingularValues : svd1.singularValues = svd2.singularValues
  upToUnitary : True  -- placeholder

#eval "Morphisms.Iso: SpectralIso, CanonicalFormIso, SVDIso"
