/-
# MiniLinearTransformation.Constructions.Subobjects

Kernel and image as subspaces. Invariant subspaces.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Kernel as Subspace -/

-- The kernel of a linear map is a subspace of the domain
def LinearMap.kernelSubspace {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Set V.V :=
  T.kernel

/-! ## Image as Subspace -/

-- The image of a linear map is a subspace of the codomain
def LinearMap.imageSubspace {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Set W.V :=
  T.image

/-! ## Invariant Subspace -/

-- A subspace U of V is T-invariant if T(U) ⊆ U
def LinearMap.isInvariantSubspace {F : Field} {V : VectorSpace F} (T : LinearMap V V) (U : Set V.V) : Prop :=
  ∀ (x : V.V), U x → U (T.map x)

/-! ## Eigenspace -/

-- The eigenspace for eigenvalue λ is ker(T - λ·I)
def LinearMap.eigenspace {F : Field} {V : VectorSpace F} (T : LinearMap V V) (lambda : F.carrier) : Set V.V :=
  (LinearMap.comp T (LinearMap.id V)).kernel
  -- Placeholder: full implementation would define T - λ·I

#eval "Constructions.Subobjects: kernel, image, invariant subspace, eigenspace"
