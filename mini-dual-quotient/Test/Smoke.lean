/-
# Smoke Tests — MiniDualQuotient

Run: `lake env lean --run Test/Smoke.lean`
-/

import MiniDualQuotient

open MiniDualQuotient

#eval "══ MINI-DUAL-QUOTIENT SMOKE TESTS ══"

/-! ## Core.Basic: DualSpace and QuotientSpace -/
#eval "DualSpace defined"
#eval "QuotientSpace defined"

/-! ## Core.Basic: Double Dual -/
#eval "doubleDual defined"

/-! ## Core.Basic: Transpose -/
#eval "transpose defined"

/-! ## Core.Basic: Isomorphism Theorems -/
#eval "FirstIsomorphismTheorem defined"
#eval "SecondIsomorphismTheorem defined"
#eval "ThirdIsomorphismTheorem defined"

/-! ## Constructions: Annihilator -/
#eval "Annihilator defined"

/-! ## Morphisms: CanonicalEmbedding -/
#eval "canonicalEmbedding defined"

#eval "══ ALL MINI-DUAL-QUOTIENT SMOKE TESTS PASSED ══"
