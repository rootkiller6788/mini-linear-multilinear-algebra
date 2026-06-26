/-
# MiniLinearTransformation.Morphisms.Equivalence

Equivalence relations on linear transformations.
Matrix representation and similarity of linear maps.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Equivalence of linear maps -/

-- Two linear maps are equivalent if they agree on all inputs
def LinearMap.Equiv {F : Field} {V W : VectorSpace F} (T S : LinearMap V W) : Prop :=
  ∀ (x : V.V), T.map x = S.map x

/-! ## Similarity of linear operators -/

-- Two linear operators on V are similar if there exists an automorphism conjugating them
def LinearMap.Similar {F : Field} {V : VectorSpace F} (T S : LinearMap V V) : Prop :=
  ∃ (iso : LinearIsomorphism V V),
    LinearMap.Equiv (LinearMap.comp iso.toMap (LinearMap.comp T iso.invMap)) S

/-! ## Composition as category structure -/

-- The category Vect_F where objects are VectorSpaces and morphisms are LinearMaps
def HomSet (F : Field) (V W : VectorSpace F) : Type := LinearMap V W

#eval "Morphisms.Equivalence: LinearMap.Equiv, Similar, HomSet"
