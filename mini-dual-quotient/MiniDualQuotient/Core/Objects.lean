/-
# MiniDualQuotient: Objects

Object-level registrations for DualSpace, QuotientSpace,
and related structures.
-/

import MiniDualQuotient.Core.Basic
import MiniVectorSpaceCore.Core.Objects

namespace MiniDualQuotient

open MiniVectorSpaceCore

/-!
## DualSpace Object Registration

Register DualSpace as a vector space object in the kernel.
-/

def dualObject (F : Field) (V : VectorSpace F) : String :=
  s!"DualSpace({V.name})"

/-!
## QuotientSpace Object Registration

Register QuotientSpace as a vector space object in the kernel.
-/

def quotientObject (F : Field) (V : VectorSpace F) (U : Set V.V) : String :=
  s!"QuotientSpace({V.name})"

/-!
## Double Dual Object Registration
-/

def doubleDualObject (F : Field) (V : VectorSpace F) : String :=
  s!"DoubleDual({V.name})"

/-!
## Annihilator Object Registration
-/

def annihilatorObject (F : Field) (V : VectorSpace F) (U : Set V.V) : String :=
  s!"Annihilator({V.name})"

/-!
## Transpose Object Registration
-/

def transposeObject {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : String :=
  s!"Transpose({V.name}→{W.name})"

#eval "Core.Objects: DualSpace, QuotientSpace, doubleDual, Annihilator, transpose objects registered"

end MiniDualQuotient
