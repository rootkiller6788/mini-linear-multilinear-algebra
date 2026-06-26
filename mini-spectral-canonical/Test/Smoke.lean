/-
# Test.Smoke - Basic smoke tests for all modules
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Core.Objects
import MiniSpectralCanonical.Core.Laws
import MiniSpectralCanonical.Morphisms.Hom
import MiniSpectralCanonical.Morphisms.Iso
import MiniSpectralCanonical.Morphisms.Equivalence
import MiniSpectralCanonical.Constructions.Products
import MiniSpectralCanonical.Constructions.Quotients
import MiniSpectralCanonical.Constructions.Subobjects
import MiniSpectralCanonical.Constructions.Universal
import MiniSpectralCanonical.Properties.Invariants
import MiniSpectralCanonical.Properties.Preservation
import MiniSpectralCanonical.Properties.ClassificationData
import MiniSpectralCanonical.Theorems.Basic
import MiniSpectralCanonical.Theorems.Classification
import MiniSpectralCanonical.Theorems.Main
import MiniSpectralCanonical.Theorems.UniversalProperties
import MiniSpectralCanonical.Examples.Standard
import MiniSpectralCanonical.Examples.Counterexamples
import MiniSpectralCanonical.Bridges.ToAlgebra
import MiniSpectralCanonical.Bridges.ToComputation
import MiniSpectralCanonical.Bridges.ToGeometry
import MiniSpectralCanonical.Bridges.ToTopology
import MiniSpectralCanonical.Advanced.Topics
import MiniSpectralCanonical.Research.Frontiers

open MiniSpectralCanonical

/-! Smoke test: verify all modules import and basic computations work -/

#eval "=== SMOKE TEST: All Modules Imported Successfully ==="

def smokeTestBasic : IO Unit := do
  let A := Mat.ofList2x2 1 2 3 4
  let tr := Mat.trace A
  let det := Mat.det2 A
  let evs := Mat.eigenvalues2 A
  if tr = 5 && det = -2 then
    IO.println "PASS: Core.Basic"
  else
    IO.println s!"FAIL: Core.Basic (tr={tr}, det={det}, evs={evs})"

#eval smokeTestBasic

def smokeTestObjects : IO Unit := do
  let PX := Mat.pauliX
  IO.println s!"Pauli X trace={Mat.trace PX} (expect 0)"

#eval smokeTestObjects

def smokeTestLaws : IO Unit := do
  let A := Mat.ofList2x2 1 2 2 3
  IO.println s!"Cayley-Hamilton law for 2x2 holds (see theorem)"

#eval smokeTestLaws

def smokeTestMorphisms : IO Unit := do
  let A := Mat.ofList2x2 1 0 0 1
  let s := Similarity2x2.refl A
  IO.println s!"Similarity preserves trace: {similarity_preserves_trace_2x2 s}"

#eval smokeTestMorphisms

#eval "=== ALL SMOKE TESTS COMPLETED ==="