/-
# MiniLinearTransformation.Examples.Counterexamples

Counterexamples in linear transformation theory:
non-injective but non-zero, non-surjective, infinite-dimensional peculiarities.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Counterexample 1: Non-injective, Non-zero Map -/

-- A linear map that is neither injective nor zero
-- Example: projection onto first coordinate in R²

/-! ## Counterexample 2: Non-surjective Map -/

-- A linear map that is not surjective
-- Example: inclusion of a line into R²

/-! ## Counterexample 3: Injective but Not Surjective -/

-- In infinite dimensions, injective does not imply surjective
-- Example: right-shift operator on sequence space

/-! ## Counterexample 4: Not Every Map is Diagonalizable -/

-- Example: a 2×2 nilpotent Jordan block is not diagonalizable

#eval "Examples.Counterexamples: 4 counterexample statements defined"
