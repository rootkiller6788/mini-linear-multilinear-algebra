/-
# MiniLinearTransformation.Examples.Counterexamples

Counterexamples in linear transformation theory demonstrating
the boundaries of various theorems and properties.

Knowledge: L6-canonical counterexamples, L5-falsification methods.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Laws
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso
import MiniLinearTransformation.Constructions.Subobjects
import MiniLinearTransformation.Properties.Preservation

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Counterexample 1: Non-injective, Non-zero Map (L6) -/

/-- The projection π₁: ℝ² → ℝ sending (x, y) ↦ x is surjective but not injective. -/
def counterexample1_exists : Prop :=
  ∃ (V W : VectorSpace ℝ) (T : LinearMap V W),
    ¬ T.isInjective ∧ ¬ (∀ x, T.map x = W.zero) ∧ T.isSurjective

/-- Construction: π₁ ≠ 0 and π₁(e₂) = 0, so π₁ is not injective. -/
def counterexample1_construction : String :=
  "π₁(x,y) = x: π₁(0,1)=0=π₁(0,0) but (0,1)≠(0,0), so not injective."

#eval "Counterexample 1: Projection π₁ — surjective, not injective, not zero"

/-! ## Counterexample 2: Non-surjective Map (L6) -/

/-- The inclusion ι: ℝ → ℝ² sending x ↦ (x, 0) is injective but not surjective. -/
def counterexample2_exists : Prop :=
  ∃ (V W : VectorSpace ℝ) (T : LinearMap V W),
    T.isInjective ∧ ¬ T.isSurjective

/-- Construction: ι(x) = (x, 0). Image is a proper subspace. -/
def counterexample2_construction : String :=
  "ι(x) = (x,0): injective, image is x-axis (≠ ℝ²), so not surjective."

#eval "Counterexample 2: Inclusion ι — injective, not surjective"

/-! ## Counterexample 3: Infinite Dimension (L6) -/

/-- In infinite-dimensional spaces, injective ≠ surjective. -/
def counterexample3_infinite_dim : Prop :=
  ∃ (F : Field) (V : VectorSpace F) (T : LinearMap V V),
    ¬ isFiniteDimensional V ∧ T.isInjective ∧ ¬ T.isSurjective

/-- Right-shift operator on sequence space: (x₁, x₂, ...) ↦ (0, x₁, x₂, ...). -/
def rightShift : String :=
  "R(x₁,x₂,x₃,...) = (0,x₁,x₂,...): injective, image = {x₁=0}, not surjective"

/-- Left-shift operator: (x₁, x₂, x₃, ...) ↦ (x₂, x₃, ...). -/
def leftShift : String :=
  "L(x₁,x₂,x₃,...) = (x₂,x₃,...): surjective, kernel = {(c,0,0,...)}, not injective"

#eval "Counterexample 3: Right/left shift — injective≠surjective in ∞ dim"

/-! ## Counterexample 4: Non-diagonalizable (L6) -/

/-- A nilpotent Jordan block [[0,1],[0,0]] is not diagonalizable. -/
def counterexample4_nondiag : Prop :=
  ∃ (F : Field) (V : VectorSpace F) (T : LinearMap V V),
    T.isNilpotent ∧ ¬ T.isDiagonalizable

/-- J = [[0,1],[0,0]] has J² = 0 (nilpotent) but only eigenvector is (1,0)ᵀ. -/
def jordanBlock2x2 : String :=
  "J = [[0,1],[0,0]]: J²=0, eigenvalue 0 (only), eigenspace = span{(1,0)}, dim 1 < 2 → not diagonalizable"

#eval "Counterexample 4: Nilpotent Jordan block — not diagonalizable"

/-! ## Counterexample 5: Similar but Not Equal (L6) -/

/-- Similar matrices need not be equal. -/
def counterexample5_similar_not_equal : Prop :=
  ∃ (F : Field) (V : VectorSpace F) (T S : LinearMap V V),
    T.Similar S ∧ ¬ (∀ x, T.map x = S.map x)

#eval "Counterexample 5: Similar ≠ equal — conjugacy preserves spectrum"

/-! ## Counterexample 6: Non-commuting Operators (L6) -/

/-- Linear operators need not commute. -/
def counterexample6_noncommuting : Prop :=
  ∃ (F : Field) (V : VectorSpace F) (T S : LinearMap V V),
    ¬ (∀ x, (LinearMap.comp T S).map x = (LinearMap.comp S T).map x)

/-- Projection and rotation on ℝ² do not commute. -/
def noncommutingExample : String :=
  "π₁(R_θ(e₁)) ≠ R_θ(π₁(e₁)) for rotation R_θ by θ≠0,π"

#eval "Counterexample 6: Non-commuting operators"

/-! ## Counterexample 7: Rank not additive (L6) -/

/-- rank(T + S) ≠ rank(T) + rank(S) in general. -/
def counterexample7_rank_not_additive {F : Field} {V W : VectorSpace F}
    (vpW : VectorSpaceProps W) (T S : LinearMap V W) : Prop :=
    (LinearMap.add vpW T S).rank ≠ T.rank + S.rank

/-- T = id, S = -id gives T + S = 0, rank(id) + rank(-id) = 2dim, rank(0) = 0. -/
def rankNotAdditiveExample : String :=
  "rank(id) + rank(-id) = 2n, but rank(id-id) = rank(0) = 0"

#eval "Counterexample 7: rank(T+S) ≠ rank(T) + rank(S)"

/-! ## Counterexample 8: Non-isomorphic Spaces of Same Dimension (L6) -/

/-- Vector spaces of the same dimension need not be canonically isomorphic.
All n-dim spaces over the same field ARE isomorphic, but the isomorphism
is not unique (depends on choice of basis). -/
def counterexample8_noncanonical : Prop :=
  ∃ (V W : VectorSpace ℝ),
    dimension V = dimension W ∧ ¬ (∃! (iso : LinearIsomorphism V W), True)

#eval "Counterexample 8: Same-dim spaces isomorphic, but non-canonically"

#eval "Examples.Counterexamples: 8 counterexamples demonstrating boundaries"
#eval "  1. Non-injective, non-zero, surjective (projection)"
#eval "  2. Injective, not surjective (inclusion)"
#eval "  3. ∞-dim: injective ≠ surjective (shift operators)"
#eval "  4. Non-diagonalizable (nilpotent Jordan block)"
#eval "  5. Similar ≠ equal (conjugacy)"
#eval "  6. Non-commuting operators"
#eval "  7. rank(T+S) ≠ rank(T) + rank(S)"
#eval "  8. Isomorphism non-canonical (basis-dependent)"

end MiniLinearTransformation
