import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Core.Laws
import MiniTensorAlgebra.Core.Objects
import MiniTensorAlgebra.Constructions.Products
import MiniTensorAlgebra.Constructions.Quotients
import MiniTensorAlgebra.Constructions.Subobjects
import MiniTensorAlgebra.Constructions.Universal
import MiniTensorAlgebra.Morphisms.Hom
import MiniTensorAlgebra.Morphisms.Iso
import MiniTensorAlgebra.Morphisms.Equivalence
import MiniTensorAlgebra.Properties.Invariants
import MiniTensorAlgebra.Properties.Preservation
import MiniTensorAlgebra.Properties.ClassificationData
import MiniTensorAlgebra.Theorems.Basic
import MiniTensorAlgebra.Theorems.Main
import MiniTensorAlgebra.Theorems.Classification
import MiniTensorAlgebra.Theorems.UniversalProperties
import MiniTensorAlgebra.Examples.Standard
import MiniTensorAlgebra.Examples.Counterexamples
import MiniTensorAlgebra.Bridges.ToAlgebra
import MiniTensorAlgebra.Bridges.ToGeometry
import MiniTensorAlgebra.Bridges.ToTopology
import MiniTensorAlgebra.Bridges.ToComputation

/-! ## Module Verification -/

open MiniTensorAlgebra

/-- Quick module integrity check. -/
def moduleVerification : List Bool :=
  [ tensProdDim 2 3 == 6
  , symPowDim 3 2 == 6
  , extPowDim 4 2 == 6
  , totalExtDim 3 == 8
  , sumPascalRow 4 == 16
  , det2x2 1 2 3 4 == -2
  , trace2x2 1 2 3 4 == 5
  , tor1ZmZn 4 6 == 2
  , pascalRow 3 == [1, 3, 3, 1]
  , mixTensDim 4 1 3 == 256
  ]

#eval "Module verification: " ; moduleVerification.all id
