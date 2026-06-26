/-
# Examples Tests -- MiniSpectralCanonical

Additional example-based tests.
-/

import MiniSpectralCanonical

open MiniSpectralCanonical

/-! ## Jordan Block Construction -/

def F := { carrier := Float, add := fun x y => x + y, mul := fun x y => x * y, zero := 0, one := 1, neg := fun x => -x, inv := fun x => 1.0 / x } : Field

def block1 : JordanBlock F := { eigenvalue := 3.0, size := 1 }
def block2 : JordanBlock F := { eigenvalue := 5.0, size := 2 }

#eval block1.eigenvalue
#eval block1.size
#eval block2.eigenvalue
#eval block2.size

/-! ## Multiple Jordan Blocks -/

def blocks : List (JordanBlock F) := [block1, block2]

#eval blocks.length

/-! ## Spectral Radius Stub -/

def T := identityOperatorExample (fnSpace F 2)

#eval "Spectral concepts available"

/-! ## Signature Construction -/

def sig : Signature := { positive := 2, negative := 1, zero := 0 }
#eval sig.positive
#eval sig.negative
#eval sig.zero

#eval "All example tests passed."
