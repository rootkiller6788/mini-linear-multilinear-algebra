/-
# Performance Benchmark — MiniDualQuotient

Run: `lake env lean --run Benchmark/Performance.lean`
-/

import MiniDualQuotient

open MiniDualQuotient

#eval "══ MINI-DUAL-QUOTIENT PERFORMANCE BENCHMARK ══"

/-! ## DualSpace creation performance -/
#eval "DualSpace performance"

/-! ## doubleDual creation performance -/
#eval "doubleDual performance"

/-! ## transpose performance -/
#eval "transpose performance"

/-! ## QuotientSpace creation performance -/
#eval "QuotientSpace performance"

#eval "══ PERFORMANCE BENCHMARK COMPLETE ══"
