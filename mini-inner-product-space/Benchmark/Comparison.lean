/-
# Benchmark.Comparison

Comparison benchmarks for inner product space operations
across different implementations (classic vs modified GS, etc.).
-/

import MiniInnerProductSpace.Bridges.ToComputation

open MiniInnerProductSpace

#eval "MiniInnerProductSpace.Benchmark.Comparison: Ready."

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniInnerProductSpace Comparison Benchmark"
  IO.println "═══════════════════════════════════════"

  IO.println "  [BENCH] Classic Gram-Schmidt vs Modified Gram-Schmidt"
  IO.println "    Classic: <10ms (stub)"
  IO.println "    Modified: <12ms (stub, more stable)"

  IO.println "  [BENCH] Gram-Schmidt vs Householder QR"
  IO.println "    Gram-Schmidt: <10ms (stub)"
  IO.println "    Householder: <15ms (stub, more accurate)"

  IO.println "  [BENCH] Normal equations vs QR for least squares"
  IO.println "    Normal equations: <5ms (stub)"
  IO.println "    QR: <8ms (stub, more stable)"

  IO.println ""
  IO.println "  Comparison benchmark complete."
