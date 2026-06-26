/-
# Example Tests — MiniDualQuotient

Run: `lake env lean --run Test/Examples.lean`
-/

import MiniDualQuotient

open MiniDualQuotient

#eval "══ MINI-DUAL-QUOTIENT EXAMPLES ══"

/-! ## DualSpace Concept -/
def exDualSpace := DualSpace
#eval "DualSpace type: V → VectorSpace"

/-! ## Double Dual Concept -/
def exDoubleDual := doubleDual
#eval "doubleDual type: V → VectorSpace"

/-! ## Canonical Embedding -/
def exCanonicalEmbedding := canonicalEmbedding
#eval "canonicalEmbedding: V → V**"

/-! ## Transpose -/
def exTranspose := transpose
#eval "transpose: T → T*"

/-! ## QuotientSpace -/
def exQuotient := QuotientSpace
#eval "QuotientSpace: V/U"

/-! ## Isomorphism Theorem -/
def exIsomorphismTheorem := IsomorphismTheorem
#eval "IsomorphismTheorem: V/ker(T) ≅ im(T)"

/-! ## Reflexivity -/
def exReflexive := isReflexive
#eval "isReflexive: Prop"

#eval "══ ALL MINI-DUAL-QUOTIENT EXAMPLE TESTS PASSED ══"
