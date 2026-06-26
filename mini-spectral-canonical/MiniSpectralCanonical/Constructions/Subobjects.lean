/-
# MiniSpectralCanonical: Subobjects

Invariant subspaces and spectral subobjects.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Invariant Subspace -/

-- A subspace W ⊆ V is invariant under T if T(W) ⊆ W
structure InvariantSubspace {F : Field} {V : VectorSpace F} (T : LinearMap V V) where
  W : Subspace V
  invariant : True  -- placeholder: ∀ w ∈ W, T w ∈ W

/-! ## Eigenvalue Subspace (Eigenspace) -/

-- The eigenspace for eigenvalue λ
structure Eigenspace {F : Field} {V : VectorSpace F} (T : LinearMap V V) (lambda : F.carrier) where
  vectors : Subspace V  -- {v | T v = λ v}
  dimension : Nat  -- geometric multiplicity

/-! ## Generalized Eigenspace -/

-- Generalized eigenspace for eigenvalue λ (Jordan chains)
structure GeneralizedEigenspace {F : Field} {V : VectorSpace F} (T : LinearMap V V) (lambda : F.carrier) where
  vectors : Subspace V  -- {v | (T - λI)^k v = 0 for some k}
  nilpotenceIndex : Nat  -- smallest k such that (T-λI)^k = 0 on this subspace

/-! ## Spectral Subspace -/

-- Spectral subspace for a subset of the spectrum
structure SpectralSubspace {F : Field} {V : VectorSpace F} (T : LinearMap V V) (sigma : Set F.carrier) where
  subspace : Subspace V
  corresponds : True  -- placeholder

#eval "Constructions.Subobjects: InvariantSubspace, Eigenspace, GeneralizedEigenspace"
