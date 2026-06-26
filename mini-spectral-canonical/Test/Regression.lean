/-
# Test.Regression - Regression tests for spectral invariants
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Properties.Invariants
import MiniSpectralCanonical.Theorems.Basic

open MiniSpectralCanonical

/-! ## Regression Test 1: Trace-Det formula for diagonal matrix -/

def regressionTest1 : IO Unit := do
  let D := Mat.diagonal2 3 7
  let tr := Mat.trace D
  let det := Mat.det2 D
  let evs := Mat.eigenvalues2 D
  IO.println s!"Diagonal(3,7): tr={tr} (expect 10), det={det} (expect 21), evs={evs}"

#eval regressionTest1

/-! ## Regression Test 2: JCF of nilpotent -/

def regressionTest2 : IO Unit := do
  let N := Mat.jordanBlockMatrix 0 2
  let tr := Mat.trace N
  let det := Mat.det2 N
  IO.println s!"Nilpotent J_2(0): tr={tr} (expect 0), det={det} (expect 0)"

#eval regressionTest2

/-! ## Regression Test 3: Symmetric matrix has real eigenvalues -/

def regressionTest3 : IO Unit := do
  let S := Mat.ofList2x2 5 2 2 3
  let evs := Mat.eigenvalues2 S
  IO.println s!"Symmetric [[5,2],[2,3]]: evs={evs} (expect all real)"

#eval regressionTest3