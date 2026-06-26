/-
# Examples Tests -- MiniVectorSpaceCore

Additional example-based tests.
-/

import MiniVectorSpaceCore

open MiniVectorSpaceCore

/-! ## Finite-dimensional example: F^3 -/

def exField : Field where
  carrier := Nat
  add := Nat.add
  mul := Nat.mul
  zero := 0
  one := 1
  neg := fun _ => 0
  inv := fun _ => 0

def exVS := fnSpace exField 3

#eval exVS.zero 0
#eval exVS.zero 1
#eval exVS.zero 2

/-! ## Linear combination in F^3 -/

def v1 : Fin 3 → Nat := fun i => match i with | 0 => 1 | _ => 0
def v2 : Fin 3 → Nat := fun i => match i with | 1 => 1 | _ => 0

def lcResult := linearCombination exVS [2, 3] [v1, v2]
#eval lcResult 0
#eval lcResult 1
#eval lcResult 2

/-! ## LinearMap composition -/

def squareMap : LinearMap exVS exVS := LinearMap.id exVS

#eval squareMap.mapping v1 0
#eval squareMap.mapping v2 1
