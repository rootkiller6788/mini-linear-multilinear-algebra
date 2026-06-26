/-
# Step-by-Step Examples — MiniLinearTransformation

Building linear transformations, isomorphisms, and invariants.
-/

import MiniLinearTransformation

open MiniLinearTransformation

#eval "══ BUILDING LINEAR TRANSFORMATIONS: FROM MAPS TO THEOREMS ══"

/-! ### Step 1: LinearMap structure -/
#eval "Step 1: LinearMap has map : V.V → W.V, map_add, map_smul"

/-! ### Step 2: Identity and composition -/
#eval "Step 2: LinearMap.id and LinearMap.comp form the category Vect_F"

/-! ### Step 3: Kernel and Image -/
#eval "Step 3: LinearMap.kernel T = {v | T(v) = 0}"
#eval "        LinearMap.image T = {w | ∃v, T(v) = w}"

/-! ### Step 4: Linear isomorphism -/
#eval "Step 4: LinearIsomorphism with toMap, invMap, leftInv, rightInv"

/-! ### Step 5: Rank and Nullity -/
#eval "Step 5: rank(T) and nullity(T) are invariants"

/-! ### Step 6: Invariants (trace, determinant) -/
#eval "Step 6: trace(T), determinant(T), charPoly(T)"

/-! ### Step 7: Theorem statements -/
#eval "Step 7: 7 pillar theorems in Theorems/Main.lean"

#eval "══ LINEAR TRANSFORMATION BUILDING COMPLETE ══"
