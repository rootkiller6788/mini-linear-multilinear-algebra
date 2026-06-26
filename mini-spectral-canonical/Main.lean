/-
# Main entry point for MiniSpectralCanonical

Demonstrates the spectral analysis pipeline with #eval examples.
-/

import MiniSpectralCanonical

open MiniSpectralCanonical

def main : IO Unit := do
  IO.println "=== MiniSpectralCanonical: Spectral Theory & Canonical Forms ==="
  IO.println ""

  let A := Mat.ofList2x2 1 2 3 4
  IO.println s!"Matrix A = [[1,2],[3,4]]"
  IO.println s!"  Trace: {Mat.trace A}"
  IO.println s!"  Determinant: {Mat.det2 A}"
  IO.println s!"  Eigenvalues: {Mat.eigenvalues2 A}"
  IO.println s!"  Characteristic Polynomial: {Mat.charPoly2 A |>.coeffs}"
  IO.println s!"  Spectral Radius: {Mat.spectralRadius2 A}"
  IO.println s!"  Matrix Type: {Mat.classify2x2 A}"
  IO.println ""

  let S := Mat.ofList2x2 4 2 2 3
  IO.println s!"Symmetric S = [[4,2],[2,3]]"
  IO.println s!"  Is symmetric: {Mat.isSymmetric2 S}"
  IO.println s!"  Eigenvalues: {Mat.eigenvalues2 S}"
  IO.println s!"  Signature: pos={Mat.signature2 S |>.positive} neg={Mat.signature2 S |>.negative}"
  IO.println ""

  let J := Mat.jordanBlockMatrix 4 2
  IO.println s!"Jordan block J_2(4)"
  IO.println s!"  Trace: {Mat.trace J}"
  IO.println s!"  Det: {Mat.det2 J}"
  IO.println s!"  Type: {Mat.classify2x2 J}"
  IO.println ""

  IO.println "Cayley-Hamilton verification for [[1,2],[3,4]]:"
  IO.println "  A^2 - tr(A)*A + det(A)*I = 0 (proved as cayleyHamilton2x2)"
  IO.println ""

  IO.println "=== All spectral analysis complete ==="

#eval main