/-
# Test.Examples - Integration tests for spectral theory examples
-/

import MiniSpectralCanonical.Examples.Standard
import MiniSpectralCanonical.Examples.Counterexamples

open MiniSpectralCanonical

#eval "=== Test: Standard Examples Loaded ==="
#eval "Identity trace = " ++ toString (Mat.trace exampleIdentity)
#eval "Diagonal det = " ++ toString (Mat.det2 exampleDiagonal)
#eval "Jordan block type = " ++ toString (Mat.classify2x2 exampleJordanBlock)
#eval "Symmetric signature = " ++ toString (Mat.signature2 exampleSymmetric)
#eval "Hilbert condition = " ++ toString (Mat.conditionNumber2 exampleHilbert)
#eval "=== Test: Counterexamples Loaded ==="
#eval "Defective type = " ++ toString (Mat.classify2x2 ce_defective)
#eval "Non-normal check = " ++ toString (Mat.isNormal2 ce_nonNormal)
#eval "Complex eig type = " ++ toString (Mat.classify2x2 ce_complexEigs)