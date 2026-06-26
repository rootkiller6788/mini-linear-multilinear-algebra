/-
# Benchmark: Core coverage of spectral theory
Tests that all core spectral analysis functions work correctly
across the spectrum of matrix types.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Theorems.Main

open MiniSpectralCanonical

def runBenchmark : IO Unit := do
  let matrices : List (String x Mat 2 2) := [
    ("Identity", Mat.identity 2),
    ("Diagonal(3,5)", Mat.diagonal2 3 5),
    ("J_2(4)", Mat.jordanBlockMatrix 4 2),
    ("Nilpotent J_2(0)", Mat.jordanBlockMatrix 0 2),
    ("Symmetric [[4,2],[2,3]]", Mat.ofList2x2 4 2 2 3),
    ("Rotation(1)", Mat.rotation2 1),
    ("Hilbert", Mat.hilbert2),
    ("PauliX", Mat.pauliX)
  ]
  for (name, A) in matrices do
    IO.println s!"--- {name} ---"
    IO.println s!"  trace={Mat.trace A}, det={Mat.det2 A}"
    IO.println s!"  eigenvalues={Mat.eigenvalues2 A}"
    IO.println s!"  type={Mat.classify2x2 A}"
    IO.println s!"  spectralRadius={Mat.spectralRadius2 A}"
    IO.println s!"  conditionNumber={Mat.conditionNumber2 A}"
    IO.println ""

#eval runBenchmark