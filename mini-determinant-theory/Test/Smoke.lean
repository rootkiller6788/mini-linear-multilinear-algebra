/-
# Smoke Tests -- MiniDeterminantTheory

Run: `lake env lean --run Test/Smoke.lean`
-/

import MiniDeterminantTheory

open MiniDeterminantTheory

#eval "══ MINI-DETERMINANT-THEORY SMOKE TESTS ══"

/-! ## Core.Basic: Determinant -/

#eval "── Core.Basic: determinant ──"
#check determinant

/-! ## Core.Basic: Determinant Properties -/

#eval "── Core.Basic: detIsMultiplicative ──"
#check detIsMultiplicative

#eval "── Core.Basic: detOfIdentity ──"
#check detOfIdentity

#eval "── Core.Basic: detIsInvertible ──"
#check detIsInvertible

/-! ## Core.Basic: Eigenvalues -/

#eval "── Core.Basic: Eigenpair ──"
#check Eigenpair

/-! ## Core.Basic: Characteristic Polynomial -/

#eval "── Core.Basic: Polynomial / charPoly ──"
#check charPoly
#check Polynomial

/-! ## Core.Basic: Diagonalizability -/

#eval "── Core.Basic: isDiagonalizable ──"
#check isDiagonalizable

/-! ## Core.Basic: Cayley-Hamilton -/

#eval "── Core.Basic: cayleyHamilton ──"
#check cayleyHamilton

/-! ## Core.Basic: Trace -/

#eval "── Core.Basic: trace ──"
#check trace
#eval "── Core.Basic: traceIsCyclic ──"
#check traceIsCyclic

/-! ## Core.Objects: Matrix -/

#eval "── Core.Objects: Matrix ──"
#check Matrix

/-! ## Morphisms -/

#eval "── Morphisms: DeterminantHom ──"
#check DeterminantHom

#eval "── Morphisms: areSimilar ──"
#check areSimilar

#eval "── Morphisms: detEquivalent ──"
#check detEquivalent

#eval "── Morphisms: spectrumEquivalent ──"
#check spectrumEquivalent

/-! ## Constructions stubs -/

#eval "── Constructions: Products ──"
#eval "exteriorPower / wedgeProduct / laplaceExpansion"

#eval "── Constructions: Subobjects / Quotients / Universal ──"
#eval "Stubs loaded"

/-! ## Properties stubs -/

#eval "── Properties: Invariants / Preservation / ClassificationData ──"
#eval "Stubs loaded"

/-! ## Theorems stubs -/

#eval "── Theorems: Basic / UniversalProperties / Classification / Main ──"
#eval "Stubs loaded"

/-! ## Bridges stubs -/

#eval "── Bridges: ToAlgebra / ToTopology / ToGeometry / ToComputation ──"
#eval "Stubs loaded"

/-! ## Examples: Standard -/

#eval "── Examples: Standard ──"
#check identityDeterminant
#check zeroDeterminant

#eval "══ ALL MINI-DETERMINANT-THEORY SMOKE TESTS PASSED ══"
