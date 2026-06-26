/-
# MiniVectorSpaceCore.Core.Objects

Registers `VectorSpace` as an `Object` in the MiniObjectKernel ecosystem,
along with bundled structures and utility definitions.
-/

import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects
import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom

namespace MiniVectorSpaceCore

open MiniObjectKernel

/-! ## Theory Registration -/

def vecTheory : Objects.TheoryName :=
  Objects.TheoryName.ofString "VectorSpaceTheory"

instance : Objects.Object (VectorSpace F) where
  theory := vecTheory
  objName := "VectorSpace"
  repr _ := "V"

/-! ## VectorSpaceBundle  (Field + VectorSpace packaged together) -/

structure VectorSpaceBundle where
  carrierField : Field
  carrierVS    : VectorSpace carrierField

def VectorSpaceBundle.dim (b : VectorSpaceBundle) : Nat :=
  dimension b.carrierVS

def VectorSpaceBundle.field (b : VectorSpaceBundle) : Field :=
  b.carrierField

def VectorSpaceBundle.make (F : Field) (VS : VectorSpace F) : VectorSpaceBundle where
  carrierField := F
  carrierVS    := VS

/-! ## LinearMapBundle  (two VSes + the map) -/

structure LinearMapBundle where
  srcField : Field
  srcVS    : VectorSpace srcField
  tgtVS    : VectorSpace srcField
  map      : LinearMap srcVS tgtVS

def LinearMapBundle.src (b : LinearMapBundle) : VectorSpaceBundle :=
  VectorSpaceBundle.make b.srcField b.srcVS

def LinearMapBundle.tgt (b : LinearMapBundle) : VectorSpaceBundle :=
  VectorSpaceBundle.make b.srcField b.tgtVS

def LinearMapBundle.make {F : Field} (VS₁ VS₂ : VectorSpace F) (f : LinearMap VS₁ VS₂) : LinearMapBundle where
  srcField := F
  srcVS    := VS₁
  tgtVS    := VS₂
  map      := f

/-! ## Helpers -/

def Field.trivial : Field where
  carrier := Unit
  add _ _ := ()
  mul _ _ := ()
  zero    := ()
  one     := ()
  neg _   := ()
  inv _   := ()

def zeroVS (F : Field) : VectorSpace F where
  V    := Unit
  add _ _ := ()
  zero   := ()
  neg _  := ()
  smul _ _ := ()

def isZeroVS {F : Field} (VS : VectorSpace F) : Prop :=
  dimension VS = 0

/-! ## Examples and #eval -/

def exampleBundle : VectorSpaceBundle :=
  VectorSpaceBundle.make Field.trivial (zeroVS Field.trivial)

#eval "Core.Objects: VectorSpace Object registered — theory = " ++ toString (Objects.theory (zeroVS Field.trivial))
#eval "Core.Objects: zeroVS dimension = " ++ toString (dimension (zeroVS Field.trivial))
#eval "Core.Objects: exampleBundle.field = Field.trivial"
#eval s!"Core.Objects: {describe (VectorSpace Field.trivial)}"

end MiniVectorSpaceCore
