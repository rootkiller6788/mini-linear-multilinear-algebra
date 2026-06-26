import MiniTensorAlgebra

open MiniTensorAlgebra

/-!
# Regression Tests

Tests for correctness of dimension formulas and algebraic identities.
-/

/-! ## Dimension Formula Correctness -/

def testTensorPowerDim : List Bool :=
  [ tensPowDim 2 0 == 1
  , tensPowDim 2 1 == 2
  , tensPowDim 2 2 == 4
  , tensPowDim 2 3 == 8
  , tensPowDim 3 2 == 9
  , tensPowDim 4 3 == 64
  , tensPowDim 1 5 == 1
  ]

#eval "T^n dim tests: all true?" ; testTensorPowerDim.all id

def testSymPowerDim : List Bool :=
  [ symPowDim 3 0 == 1
  , symPowDim 3 1 == 3
  , symPowDim 3 2 == 6
  , symPowDim 3 3 == 10
  , symPowDim 2 0 == 1
  , symPowDim 2 1 == 2
  , symPowDim 2 2 == 3
  ]

#eval "S^k dim tests: all true?" ; testSymPowerDim.all id

def testExtPowerDim : List Bool :=
  [ extPowDim 4 0 == 1
  , extPowDim 4 1 == 4
  , extPowDim 4 2 == 6
  , extPowDim 4 3 == 4
  , extPowDim 4 4 == 1
  , extPowDim 4 5 == 0
  , extPowDim 3 2 == 3
  , extPowDim 5 3 == 10
  ]

#eval "Λ^k dim tests: all true?" ; testExtPowerDim.all id

/-! ## Determinant Identities -/

def testDetMultiplicative : List Bool :=
  [ checkDetMult 1 2 3 4 5 6 7 8
  , checkDetMult 2 0 1 3 4 1 0 5
  , checkDetMult 1 1 1 1 1 1 1 1
  ]

#eval "det(AB)=det(A)det(B): all true?" ; testDetMultiplicative.all id

/-! ## Trace Identities -/

def testTraceCyclic : List Bool :=
  [ checkTraceCyclic 1 2 3 4 5 6 7 8
  , checkTraceCyclic 2 1 3 4 5 0 2 1
  , checkTraceCyclic 0 0 0 0 1 2 3 4
  ]

#eval "tr(AB)=tr(BA): all true?" ; testTraceCyclic.all id

/-! ## Tor Tests -/

#eval "Tor1(Z/4,Z/6)=2" ; tor1ZmZn 4 6 == 2
#eval "Tor1(Z/7,Z/11)=1" ; tor1ZmZn 7 11 == 1
#eval "Tor1(Z/12,Z/18)=6" ; tor1ZmZn 12 18 == 6
#eval "Tor1(Z/2,Z/2)=2" ; tor1ZmZn 2 2 == 2

/-! ## Hilbert Series Consistency -/

def testHilbertExtSum (n : Nat) : Bool := sumPascalRow n == 2 ^ n

#eval "Λ Hilbert sum equals 2^n for n=3..7:"
#eval List.range 5 |>.map (λ i => testHilbertExtSum (i+3))

#eval "=== Regression complete ===" ; 0
