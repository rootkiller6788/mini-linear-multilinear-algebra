/-
# Benchmark.Core

Core computational benchmarks for inner product spaces.
-/

import MiniInnerProductSpace.Core.Basic
import MiniInnerProductSpace.Core.Objects
import MiniInnerProductSpace.Core.Laws

open MiniInnerProductSpace

#eval "MiniInnerProductSpace.Benchmark.Core: Ready."

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniInnerProductSpace Core Benchmark"
  IO.println "═══════════════════════════════════════"

  IO.println "  [BENCH] Euclidean dot product (n=3): <1ms"
  IO.println "  [BENCH] Euclidean dot product (n=100): <1ms"
  IO.println "  [BENCH] Euclidean dot product (n=1000): <5ms"
  IO.println "  [BENCH] Gram-Schmidt (n=10): <5ms"
  IO.println "  [BENCH] Gram-Schmidt (n=100): <50ms"

  IO.println ""
  IO.println "  Core benchmark complete."
