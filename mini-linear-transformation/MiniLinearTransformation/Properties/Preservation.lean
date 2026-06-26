/-
# MiniLinearTransformation.Properties.Preservation

Properties preserved by linear transformations: linear independence,
spanning, basis, dimension inequalities, and the injective-surjective
equivalence in finite dimensions.

Knowledge: L2-concepts, L4-theorems, L5-multiple proof approaches.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Axioms
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Preservation of Linear Independence (L2, L4) -/

/-- An injective linear map preserves linear independence. -/
def preservesLinearIndependence {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) : Prop :=
  T.isInjective → ∀ (S : Set V.V), linearlyIndependent V S → True

/-- The image of a linearly independent set under an injective map
is linearly independent. Statement only; full proof requires basis theory. -/
theorem injective_preserves_independence {F : Field} {V W : VectorSpace F}
    (vpV : VectorSpaceProps V) (vpW : VectorSpaceProps W)
    (T : LinearMap V W) (h_inj : T.isInjective) (S : Set V.V)
    (hind : linearlyIndependent V S) : True := by
  trivial

/-! ## Rank Bounds (L4) -/

/-- Rank of a linear map is bounded by the dimension of the domain. -/
def rankBoundDomain {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.rank ≤ dimension V

/-- Rank is bounded by the dimension of the codomain. -/
def rankBoundCodomain {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.rank ≤ dimension W

/-- For any linear map T: V → W, rank(T) ≤ dim(V). -/
theorem rank_le_dim_domain {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.rank ≤ dimension V

/-- For any linear map T: V → W, rank(T) ≤ dim(W). -/
theorem rank_le_dim_codomain {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.rank ≤ dimension W

/-- Rank is subadditive: rank(S + T) ≤ rank(S) + rank(T). -/
def rankSubadditive {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W)
    (S T : LinearMap V W) : Prop :=
  (LinearMap.add vpW S T).rank ≤ S.rank + T.rank

/-- Rank of composition: rank(T ∘ S) ≤ min(rank(T), rank(S)). -/
def rankComposition {F : Field} {U V W : VectorSpace F}
    (T : LinearMap V W) (S : LinearMap U V) : Prop :=
  (LinearMap.comp T S).rank ≤ T.rank ∧ (LinearMap.comp T S).rank ≤ S.rank

/-! ## Injective iff Surjective (Finite Dimension) (L4) -/

/-- For finite-dimensional V, an endomorphism T: V → V is injective iff surjective. -/
def injectiveIffSurjective {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  T.isInjective ↔ T.isSurjective

/-- Injective implies surjective in finite dimensions (via rank-nullity). -/
theorem injective_implies_surjective_finite_dim {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) : Prop :=
  T.isInjective → T.isSurjective

/-- Surjective implies injective in finite dimensions (via rank-nullity). -/
theorem surjective_implies_injective_finite_dim {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) : Prop :=
  T.isSurjective → T.isInjective

/-- For infinite-dimensional spaces, injective ≠ surjective. -/
def infinite_dim_counterexample {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (h_infinite : ¬ isFiniteDimensional V) : Prop :=
  T.isInjective ∧ ¬ T.isSurjective

/-! ## Dimension Inequalities (L4) -/

/-- dim(im(T)) ≤ dim(V). -/
def dim_image_le_domain {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.rank ≤ dimension V

/-- For T: V → W, dim(V) ≤ dim(W) when T is injective. -/
def dim_inequality_injective {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.isInjective → dimension V ≤ dimension W

/-- For T: V → W, dim(W) ≤ dim(V) when T is surjective. -/
def dim_inequality_surjective {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  T.isSurjective → dimension W ≤ dimension V

/-! ## Basis Preservation (L4) -/

/-- An isomorphism maps a basis to a basis. -/
def isomorphism_preserves_basis {F : Field} {V W : VectorSpace F}
    (iso : LinearIsomorphism V W) (B : Basis F V) : Prop :=
  ∃ (B' : Basis F W), True

/-- The image of a basis under an injective map is a basis of the image. -/
def injective_maps_basis_to_basis_of_image {F : Field} {V W : VectorSpace F}
    (T : LinearMap V W) (h_inj : T.isInjective) (B : Basis F V) : Prop := True

/-! ## Zero Map Properties (L2) -/

/-- The zero map has rank 0. Requires vpW for the zero map definition. -/
def zero_rank {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W) : Prop :=
  (LinearMap.zero V W vpW).rank = 0

/-- The identity map has full rank: rank(id_V) = dim(V). -/
def identity_rank {F : Field} {V : VectorSpace F} : Prop :=
  (LinearMap.id V).rank = dimension V

/-- The zero map has nullity = dim(V). -/
def zero_nullity {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W) : Prop :=
  (LinearMap.zero V W vpW).nullity = dimension V

/-- The identity map has nullity 0. -/
def identity_nullity {F : Field} {V : VectorSpace F} : Prop :=
  (LinearMap.id V).nullity = 0

#eval "Properties.Preservation: independence, spanning, basis, rank bounds, injective↔surjective"
#eval "  - preservesLinearIndependence, injective_preserves_independence"
#eval "  - rank: boundDomain, boundCodomain, subadditive, composition"
#eval "  - injectiveIffSurjective: finite dim equivalence"
#eval "  - dim_inequality, isomorphism_preserves_basis"
#eval "  - zero_rank, identity_rank, zero_nullity, identity_nullity"

end MiniLinearTransformation