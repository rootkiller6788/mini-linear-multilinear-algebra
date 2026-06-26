/-
# MiniSpectralCanonical: Quotients

Quotient constructions for spectral theory and canonical forms.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Quotient by Invariant Subspace -/

-- The quotient V/W where W is T-invariant inherits a linear operator
def quotientOperator {F : Field} {V : VectorSpace F} (T : LinearMap V V) (W : InvariantSubspace T) : LinearMap V V :=
  LinearMap.id V  -- placeholder

/-! ## Nilpotent Quotient -/

-- Jordan blocks correspond to nilpotent operators on quotient spaces
def nilpotentQuotient {F : Field} {V : VectorSpace F} (T : LinearMap V V) (lambda : F.carrier) : Prop :=
  True  -- placeholder: (T - λI) on generalized eigenspace quotient

/-! ## Spectral Quotient Theorem -/

-- The spectrum of T|_W and T on V/W partition the spectrum of T
def spectralQuotientTheorem {F : Field} {V : VectorSpace F} (T : LinearMap V V) (W : InvariantSubspace T) : Prop :=
  True  -- placeholder

#eval "Constructions.Quotients: Quotient by invariant subspace"
