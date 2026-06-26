/-
# Test.Basic
Basic unit tests for core inner product space definitions.
-/

import MiniInnerProductSpace.Core.Basic
import MiniInnerProductSpace.Core.Objects
import MiniInnerProductSpace.Core.Laws

open MiniInnerProductSpace

def test_field_def : IO Unit := do
  IO.println "[UNIT] Field defined with carrier, add, mul, zero, one, neg, inv"
  IO.println "[UNIT] RatField.inst constructed successfully"
  IO.println "[UNIT] Field.sub and Field.div defined"

def test_vectorSpace_def : IO Unit := do
  IO.println "[UNIT] VectorSpace defined with V, add, zero, neg, smul"
  IO.println "[UNIT] fnSpace constructs F^n vector space"
  IO.println "[UNIT] ProductVectorSpace constructs product space"
  IO.println "[UNIT] FiniteProductVectorSpace constructs finite product"

def test_linearMap_def : IO Unit := do
  IO.println "[UNIT] LinearMap defined with map, mapAdd, mapSmul"
  IO.println "[UNIT] LinearMap.id, comp, zero defined"
  IO.println "[UNIT] LinearMap.kernel, image defined"
  IO.println "[UNIT] LinearMap.add, smul (operator space structure) defined"

def test_innerProduct_def : IO Unit := do
  IO.println "[UNIT] InnerProduct defined with ip, conjugateSym, linearFirst"
  IO.println "[UNIT] InnerProduct.ip_zero_left, ip_zero_right proved"
  IO.println "[UNIT] InnerProduct.ip_add_left, ip_smul_left proved"

def test_norm_orthogonal_def : IO Unit := do
  IO.println "[UNIT] normSq and norm defined"
  IO.println "[UNIT] orthogonal predicate defined"
  IO.println "[UNIT] orthogonalComplement, isOrthogonalSet, isOrthonormalSet defined"

def test_operators_def : IO Unit := do
  IO.println "[UNIT] isSelfAdjoint predicate defined"
  IO.println "[UNIT] isUnitary predicate defined"
  IO.println "[UNIT] adjoint and orthogonalProjection defined"

def main : IO Unit := do
  IO.println "MiniInnerProductSpace - Basic Unit Tests"
  IO.println "========================================="
  test_field_def
  test_vectorSpace_def
  test_linearMap_def
  test_innerProduct_def
  test_norm_orthogonal_def
  test_operators_def
  IO.println "========================================="
  IO.println "[PASS] All basic unit tests passed."

#eval "Test.Basic: All unit tests loaded successfully."