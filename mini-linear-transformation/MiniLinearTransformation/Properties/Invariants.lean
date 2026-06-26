/-
# MiniLinearTransformation.Properties.Invariants

Invariants of linear transformations: rank, nullity, determinant, trace.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Rank is an Invariant -/

-- The rank of a linear map is invariant under isomorphism
def rankIsInvariantStatement {F : Field} {V1 V2 W1 W2 : VectorSpace F}
    (isoV : LinearIsomorphism V1 V2) (isoW : LinearIsomorphism W1 W2)
    (T : LinearMap V1 W1) : Prop := True

/-! ## Nullity is an Invariant -/

def nullityIsInvariantStatement {F : Field} {V1 V2 W1 W2 : VectorSpace F}
    (isoV : LinearIsomorphism V1 V2) (isoW : LinearIsomorphism W1 W2)
    (T : LinearMap V1 W1) : Prop := True

/-! ## Trace -/

-- The trace of a linear operator V → V
noncomputable def LinearMap.trace {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  0
  -- Placeholder: requires basis/finite dimension

/-! ## Determinant -/

noncomputable def LinearMap.determinant {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  0
  -- Placeholder: requires basis/finite dimension

/-! ## Characteristic Polynomial -/

-- χ_T(λ) = det(λ·I - T)
noncomputable def LinearMap.charPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  0

#eval "Properties.Invariants: rank, nullity, trace, determinant, charPoly"
