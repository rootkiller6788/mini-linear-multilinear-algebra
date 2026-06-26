import MiniSpectralCanonical

open MiniSpectralCanonical

def main : IO Unit := do
  IO.println "═══════════════════════════════════════════"
  IO.println "  MiniSpectralCanonical v0.1.0"
  IO.println "  Spectral Theorems and Canonical Forms"
  IO.println "═══════════════════════════════════════════"
  IO.println s!"  Spectral Theorem for self-adjoint operators"
  IO.println s!"  Jordan Canonical Form"
  IO.println s!"  Rational Canonical Form"
  IO.println s!"  Singular Value Decomposition (SVD)"
  IO.println s!"  Polar Decomposition"
  IO.println s!"  Spectral Radius"
  IO.println s!"  Courant-Fischer Min-Max Theorem"
  IO.println s!"  Gershgorin Circle Theorem"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
