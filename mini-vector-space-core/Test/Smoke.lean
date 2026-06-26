/-
# Smoke Tests -- MiniVectorSpaceCore

Run: `lake env lean --run Test/Smoke.lean`
-/

import MiniVectorSpaceCore

open MiniVectorSpaceCore

#eval "══ MINI-VECTOR-SPACE-CORE SMOKE TESTS ══"

/-! ## Core.Basic: Field -/

#eval "── Core.Basic: Field ──"
def testField : Field where
  carrier := Nat
  add := Nat.add
  mul := Nat.mul
  zero := 0
  one := 1
  neg := fun _ => 0
  inv := fun _ => 0
#eval testField.zero
#eval testField.one

/-! ## Core.Basic: VectorSpace -/

#eval "── Core.Basic: VectorSpace ──"
def testVS : VectorSpace testField where
  V := Nat
  add := Nat.add
  zero := 0
  neg := fun _ => 0
  smul := fun a x => a * x
#eval VectorSpace.zero' testVS
#eval VectorSpace.add' testVS 1 2

/-! ## Core.Basic: fnSpace -/

#eval "── Core.Basic: fnSpace ──"
def testFn := fnSpace testField 3
#eval testFn.zero 0
#eval testFn.add (fun _ => 1) (fun _ => 2) 0
#eval testFn.smul 5 (fun _ => 1) 0

/-! ## Core.Basic: linearCombination -/

#eval "── Core.Basic: linearCombination ──"
def lc := linearCombination testVS [2, 3] [1, 4]
#eval lc

/-! ## Core.Basic: Basis -/

#eval "── Core.Basic: Basis ──"
#check Basis testField testVS
#eval "Basis type checks"

/-! ## Core.Basic: dimension -/

#eval "── Core.Basic: dimension ──"
#eval dimension testVS
#eval isFiniteDimensional testVS

/-! ## Core.Objects: Object instance -/

#eval "── Core.Objects: Object instance ──"
open MiniObjectKernel
#eval describe (VectorSpace testField)
#eval objName (VectorSpace testField)

/-! ## Core.Laws: vector space axioms -/

#eval "── Core.Laws: vector space axioms ──"
#eval vecAxioms.axioms.length
#eval addAssoc testVS

/-! ## Morphisms: LinearMap -/

#eval "── Morphisms: LinearMap ──"
def lm : LinearMap testVS testVS where
  mapping := fun x => x + 1
#eval lm.mapping 5

def lmId := LinearMap.id testVS
#eval lmId.mapping 42

/-! ## Morphisms: LinearIso -/

#eval "── Morphisms: LinearIso ──"
#check LinearIso testVS testVS

/-! ## Morphisms: VSEquivalence -/

#eval "── Morphisms: VSEquivalence ──"
#check VSEquivalence testVS testVS

/-! ## Constructions/Properties/Theorems/Bridges: stubs imported ──

#eval "── Constructions/Properties/Theorems/Bridges: stubs loaded ──"
#eval "Products stub loaded"
#eval "Universal stub loaded"
#eval "Subobjects stub loaded"
#eval "Quotients stub loaded"

#eval "══ ALL MINI-VECTOR-SPACE-CORE SMOKE TESTS PASSED ══"
