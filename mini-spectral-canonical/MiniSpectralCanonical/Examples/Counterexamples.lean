/-
# MiniSpectralCanonical.Examples.Counterexamples

L6: Counterexamples in spectral theory.
Non-diagonalizable, defective, non-normal, rotation,
nilpotent Jordan peeling, and spectral instability examples.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Examples.Standard

namespace MiniSpectralCanonical

/-! ## L6: Counterexample 1 - Defective (Non-Diagonalizable)

[[0,1],[0,0]] has eigenvalue 0 with algebraic multiplicity 2
but geometric multiplicity 1. Not diagonalizable.
-/

def ce_defective : Mat 2 2 := Mat.jordanBlockMatrix 0 2

#eval "=== Counterexample: Defective Matrix ==="
#eval "Eigenvalues: " ++ toString (Mat.eigenvalues2 ce_defective)
#eval "Matrix type: " ++ toString (Mat.classify2x2 ce_defective)

/-! ## L6: Counterexample 2 - Non-Normal

[[0,2],[0,0]] is not normal: A A^T != A^T A.
Normal => diagonalizable by unitary, but not conversely.
-/

def ce_nonNormal : Mat 2 2 := Mat.ofList2x2 0 2 0 0

#eval "=== Counterexample: Non-Normal ==="
#eval "Is normal: " ++ toString (Mat.isNormal2 ce_nonNormal)
#eval "Is symmetric: " ++ toString (Mat.isSymmetric2 ce_nonNormal)

/-! ## L6: Counterexample 3 - Real matrix with complex eigenvalues

[[0,-1],[1,0]] has eigenvalues +/- i (purely imaginary).
Not diagonalizable over R (elliptic type).
-/

def ce_complexEigs : Mat 2 2 := Mat.ofList2x2 0 (-1) 1 0

#eval "=== Counterexample: Complex Eigenvalues ==="
#eval "Trace: " ++ toString (Mat.trace ce_complexEigs)
#eval "Det: " ++ toString (Mat.det2 ce_complexEigs)
#eval "Matrix type: " ++ toString (Mat.classify2x2 ce_complexEigs)

/-! ## L6: Counterexample 4 - Non-invertible but non-nilpotent

[[1,0],[0,0]] has det = 0, rank 1. Not nilpotent (rho=1).
-/

def ce_rank1 : Mat 2 2 := Mat.ofList2x2 1 0 0 0

#eval "=== Counterexample: Rank 1 ==="
#eval "Rank: " ++ toString (Mat.rank2 ce_rank1)
#eval "Det: " ++ toString (Mat.det2 ce_rank1)
#eval "Spectral radius: " ++ toString (Mat.spectralRadius2 ce_rank1)

/-! ## L6: Counterexample 5 - Symmetric but indefinite

[[1,0],[0,-1]] has signature (1,1,0). Positive AND negative eigenvalues.
-/

def ce_indefinite : Mat 2 2 := Mat.ofList2x2 1 0 0 (-1)

#eval "=== Counterexample: Indefinite Symmetric ==="
#eval "Signature: pos=" ++ toString (Mat.signature2 ce_indefinite).positive ++
      " neg=" ++ toString (Mat.signature2 ce_indefinite).negative ++
      " zero=" ++ toString (Mat.signature2 ce_indefinite).zeroCount

/-! ## L6: Counterexample 6 - Eigenvalue sensitivity

Wilkinson-type: small perturbation causes large eigenvalue change.
A = [[0,1],[eps,0]] has eigenvalues +/- sqrt(eps).
As eps -> 0, eigenvalues coalesce at 0.
-/

def ce_sensitive (eps : Rat) : Mat 2 2 := Mat.ofList2x2 0 1 eps 0

#eval "=== Counterexample: Eigenvalue Sensitivity ==="
#eval "eps=0.01: evs=" ++ toString (Mat.eigenvalues2 (ce_sensitive (1/100)))
#eval "eps=0.0001: evs=" ++ toString (Mat.eigenvalues2 (ce_sensitive (1/10000)))

/-! ## L6: Counterexample 7 - Commuting but not simultaneously diagonalizable

[[1,1],[0,1]] and [[1,0],[0,1]] commute but the first isn't diagonalizable.
-/

def ce_commute_nondiag : Mat 2 2 := Mat.ofList2x2 1 1 0 1
def ce_identity : Mat 2 2 := Mat.identity 2

#eval "=== Counterexample: Commuting, Not Both Diag ==="
#eval "Do they commute: " ++ toString ((Mat.mul ce_commute_nondiag ce_identity) = (Mat.mul ce_identity ce_commute_nondiag))
#eval "First diag: " ++ toString (Mat.classify2x2 ce_commute_nondiag)

/-! ## L6: Counterexample 8 - Gershgorin failure to localize

A matrix where some Gershgorin disc contains no eigenvalue
(inconclusive case).
-/

def ce_gershgorinGap : Mat 2 2 := Mat.ofList2x2 1 10 0 2

#eval "=== Counterexample: Gershgorin Gap ==="
#eval "Discs: " ++ toString (Mat.gershgorinRowDiscs ce_gershgorinGap)
#eval "Actual eigenvalues: " ++ toString (Mat.eigenvalues2 ce_gershgorinGap)

end MiniSpectralCanonical