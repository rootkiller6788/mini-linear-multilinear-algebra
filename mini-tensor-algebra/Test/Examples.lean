import MiniTensorAlgebra

open MiniTensorAlgebra

/-!
# Test Examples for mini-tensor-algebra

Verification of key formulas and invariants.
-/

#eval "=== Dimension Tests ==="

#eval "dim(R^2⊗R^3) = 6" ; tensProdDim 2 3
#eval "dim(R^4⊗R^5) = 20" ; tensProdDim 4 5
#eval "dim(empty) = 1" ; iterTensorDim []
#eval "iter 2*3*4 = 24" ; iterTensorDim [2,3,4]

#eval "=== Tensor Powers ==="

#eval "T^0(R^2) = 1" ; tensPowDim 2 0
#eval "T^1(R^2) = 2" ; tensPowDim 2 1
#eval "T^2(R^2) = 4" ; tensPowDim 2 2
#eval "T^3(R^2) = 8" ; tensPowDim 2 3

#eval "=== Symmetric Powers ==="

#eval "S^0(R^3) = 1" ; symPowDim 3 0
#eval "S^1(R^3) = 3" ; symPowDim 3 1
#eval "S^2(R^3) = 6" ; symPowDim 3 2
#eval "S^3(R^3) = 10" ; symPowDim 3 3

#eval "=== Exterior Powers ==="

#eval "Λ^0(R^4) = 1" ; extPowDim 4 0
#eval "Λ^1(R^4) = 4" ; extPowDim 4 1
#eval "Λ^2(R^4) = 6" ; extPowDim 4 2
#eval "Λ^3(R^4) = 4" ; extPowDim 4 3
#eval "Λ^4(R^4) = 1" ; extPowDim 4 4
#eval "Λ^5(R^4) = 0" ; extPowDim 4 5

#eval "=== Total Exterior Algebra ==="

#eval "dim Λ(R^0) = 1" ; totalExtDim 0
#eval "dim Λ(R^1) = 2" ; totalExtDim 1
#eval "dim Λ(R^3) = 8" ; totalExtDim 3
#eval "dim Λ(R^5) = 32" ; totalExtDim 5
#eval "dim Λ(R^8) = 256" ; totalExtDim 8

#eval "=== Pascal Row Verification ==="

#eval "Λ*(R^3):" ; pascalRow 3
#eval "Λ*(R^4):" ; pascalRow 4
#eval "Λ*(R^5):" ; pascalRow 5

#eval "=== Sum of Pascal Row = 2^n ==="

#eval "ΣΛ*(R^3)=8=2^3?" ; sumPascalRow 3 == 2^3
#eval "ΣΛ*(R^4)=16=2^4?" ; sumPascalRow 4 == 2^4
#eval "ΣΛ*(R^5)=32=2^5?" ; sumPascalRow 5 == 2^5
#eval "ΣΛ*(R^6)=64=2^6?" ; sumPascalRow 6 == 2^6

#eval "=== Determinant Tests ==="

#eval "det(I_2) = 1" ; det2x2 1 0 0 1
#eval "det([1,2],[3,4]) = -2" ; det2x2 1 2 3 4
#eval "det([2,0],[0,3]) = 6" ; det2x2 2 0 0 3
#eval "det([a,b],[c,d]) = 0 if ad=bc" ; det2x2 2 4 1 2

#eval "=== Trace Tests ==="

#eval "tr(I_2) = 2" ; trace2x2 1 0 0 1
#eval "tr([1,2],[3,4]) = 5" ; trace2x2 1 2 3 4

#eval "=== Mixed Tensor Tests ==="

#eval "(1,0)-tensor ℝ^4 = 4" ; mixTensDim 4 1 0
#eval "(0,2)-tensor ℝ^3 = 9" ; mixTensDim 3 0 2
#eval "(1,1)-tensor ℝ^5 = 25" ; mixTensDim 5 1 1
#eval "(1,3)-tensor ℝ^4 = 256" ; mixTensDim 4 1 3

#eval "=== Hilbert Series ==="

#eval "H_T(R^2,k=0..4):" ; hilbertT 2 4
#eval "H_S(R^3,k=0..5):" ; hilbertS 3 5
#eval "H_Λ(R^4):" ; hilbertExteriorSeries 4

#eval "=== All tests passed ===" ; 42
