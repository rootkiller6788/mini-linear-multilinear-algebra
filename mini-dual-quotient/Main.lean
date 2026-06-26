/-
# Main — MiniDualQuotient

Entry point that prints package information.
-/

import MiniDualQuotient

open MiniDualQuotient

def main : IO Unit := do
  IO.println "══ mini-dual-quotient ══"
  IO.println "Dual Spaces, Double Dual, Transpose, Quotient Spaces,"
  IO.println "and the Three Isomorphism Theorems for Vector Spaces."
  IO.println ""
  IO.println "Core Concepts:"
  IO.println "  - DualSpace: V* = Hom_F(V, F)"
  IO.println "  - doubleDual: V**"
  IO.println "  - canonicalEmbedding: V → V**"
  IO.println "  - transpose: T* : W* → V* for T : V → W"
  IO.println "  - QuotientSpace: V/U"
  IO.println "  - First Isomorphism Theorem: V/ker(T) ≅ im(T)"
  IO.println "  - Second Isomorphism Theorem: (U+W)/W ≅ U/(U∩W)"
  IO.println "  - Third Isomorphism Theorem: (V/U)/(W/U) ≅ V/W"
  IO.println ""
  IO.println "Modules:"
  IO.println "  Core:           Basic, Objects, Laws"
  IO.println "  Constructions:  DualSpace, QuotientSpace, Annihilator, Transpose"
  IO.println "  Morphisms:      CanonicalEmbedding, Projection, Equivalence"
  IO.println "  Properties:     Dimensional, Structural, Universal"
  IO.println "  Theorems:       FirstIsomorphism, SecondIsomorphism, ThirdIsomorphism"
  IO.println "  Examples:       DualBasis, QuotientExample, Reflexivity"
  IO.println "  Bridges:        ToAlgebra, ToGeometry, ToTopology, ToComputation"
  IO.println ""
  IO.println "══ End of mini-dual-quotient info ══"
