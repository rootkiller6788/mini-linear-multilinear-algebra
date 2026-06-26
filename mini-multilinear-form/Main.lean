/-
# MiniMultilinearForm

Multilinear forms package: bilinear maps, bilinear forms,
symmetric/skew-symmetric/alternating forms, multilinear maps,
tensor products, and applications.

Part of the mini-everything-math project.
-/

import MiniMultilinearForm

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniMultilinearForm v0.1.0"
  IO.println "  Multilinear Forms Sub-Package"
  IO.println "═══════════════════════════════════════"
  IO.println "  BilinearMap: V₁ × V₂ → W"
  IO.println "  BilinearForm: V × V → F"
  IO.println "  MultilinearMap: V^n → W"
  IO.println "  Symmetric, SkewSymmetric, Alternating forms"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
