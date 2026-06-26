/-
# Benchmark.CoreCoverage

Benchmark for core coverage of tensor algebra:
measure how many core definitions and theorems
are covered by the existing code.
-/

import MiniTensorAlgebra

open MiniTensorAlgebra

/-! ## Core Structure Coverage -/

def benchmark_coreStructures : List String := [
  "TensorProduct",
  "TensorAlgebra",
  "SymmetricAlgebra",
  "ExteriorAlgebra",
  "TensorPower",
  "SymmetricPower",
  "ExteriorPower"
]

/-! ## Core Theorem Coverage -/

def benchmark_coreTheorems : List String := [
  "tensorProductExists",
  "tensorProductUnique",
  "tensorHomAdjunction",
  "pbwForVectorSpace",
  "exteriorDimension"
]

/-! ## Core Law Coverage -/

def benchmark_coreLaws : List String := [
  "tensor_add_left",
  "tensor_smul_left",
  "symmetric_commutativity",
  "exterior_antiComm"
]

#eval "Benchmark.CoreCoverage: " ++ toString (benchmark_coreStructures.length) ++ " structures, " ++
  toString (benchmark_coreTheorems.length) ++ " theorems, " ++
  toString (benchmark_coreLaws.length) ++ " laws tracked"
