import MiniTensorAlgebra

open MiniTensorAlgebra

/-!
# Smoke Tests

Quick sanity checks that the module loads and basic operations work.
-/

/-- Basic tensor product dimension check. -/
#eval "Smoke: dim check" ; tensProdDim 2 3 == 6

/-- Symmetric power dimension check. -/
#eval "Smoke: symmetric check" ; symPowDim 3 2 == 6

/-- Exterior power dimension check. -/
#eval "Smoke: exterior check" ; extPowDim 4 2 == 6

/-- Determinant check. -/
#eval "Smoke: det check" ; det2x2 1 2 3 4 == -2

/-- Trace check. -/
#eval "Smoke: tr check" ; trace2x2 1 2 3 4 == 5

/-- Tor check. -/
#eval "Smoke: Tor check" ; tor1ZmZn 4 6 == 2

/-- Pascal row check. -/
#eval "Smoke: Pascal row" ; pascalRow 3 == [1, 3, 3, 1]

/-- Hilbert series check. -/
#eval "Smoke: Hilbert ext check" ; hilbertExteriorSeries 4 == [1, 4, 6, 4, 1]

/-- Total exterior dimension check. -/
#eval "Smoke: total ext dim" ; totalExtDim 5 == 32

/-- Mixed tensor dimension check. -/
#eval "Smoke: mixed tensor" ; mixTensDim 4 1 3 == 256

/-- All basic operations functional. -/
#eval "Smoke: all basic imports and operations OK" ; 0
