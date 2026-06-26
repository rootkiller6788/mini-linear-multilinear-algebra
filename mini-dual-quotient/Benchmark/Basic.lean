/-
# Basic Benchmark — MiniDualQuotient

Run: `lake env lean --run Benchmark/Basic.lean`
-/

import MiniDualQuotient

open MiniDualQuotient

#eval "══ MINI-DUAL-QUOTIENT BASIC BENCHMARK ══"

/-! ## Measure DualSpace structure -/
#eval "DualSpace benchmark"

/-! ## Measure doubleDual -/
#eval "doubleDual benchmark"

/-! ## Measure transpose -/
#eval "transpose benchmark"

/-! ## Measure QuotientSpace -/
#eval "QuotientSpace benchmark"

#eval "══ BENCHMARK COMPLETE ══"
