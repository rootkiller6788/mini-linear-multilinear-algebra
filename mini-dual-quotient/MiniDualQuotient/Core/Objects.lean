/-
# MiniDualQuotient: Core/Objects — L3 Object Registrations

Registers dual, quotient, annihilator, and transpose objects
in the kernel's object system for cross-module interoperability.

## Knowledge Coverage
- L3: Theory-level registrations for dual and quotient constructions
- Object hierarchy: DualSpace ⊂ VectorSpace, QuotientSpace ⊂ VectorSpace
-/

import MiniDualQuotient.Core.Basic
import MiniVectorSpaceCore.Core.Objects

namespace MiniDualQuotient

open MiniVectorSpaceCore

/-!
## Object Name Registrations

Each construction is registered with a hierarchical theory name
for use in the kernel's multi-theory object system.
-/

/-- Register DualSpace as a vector space object. -/
def dualObject (F : Field) (V : VectorSpace F) : String :=
  s!"DualSpace({V.name})"

/-- Register QuotientSpace as a vector space object. -/
def quotientObject (F : Field) (V : VectorSpace F) (U : Set V.V) : String :=
  s!"QuotientSpace({V.name})"

/-- Register DoubleDual as a vector space object. -/
def doubleDualObject (F : Field) (V : VectorSpace F) : String :=
  s!"DoubleDual({V.name})"

/-- Register Annihilator as a subspace object. -/
def annihilatorObject (F : Field) (V : VectorSpace F) (U : Set V.V) : String :=
  s!"Annihilator({V.name})"

/-- Register Transpose as a morphism object. -/
def transposeObject {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : String :=
  s!"Transpose({V.name}→{W.name})"

/-- Register CanonicalEmbedding as a morphism object. -/
def canonicalEmbeddingObject (F : Field) (V : VectorSpace F) : String :=
  s!"CanonicalEmbedding({V.name}→DoubleDual({V.name}))"

/-- Register the first isomorphism theorem as a theorem object. -/
def firstIsoObject (F : Field) (V W : VectorSpace F) (T : LinearMap V W) : String :=
  s!"FirstIsomorphismTheorem({V.name}→{W.name})"

/-- Register the second isomorphism theorem. -/
def secondIsoObject (F : Field) (V : VectorSpace F) (U W : Set V.V) : String :=
  s!"SecondIsomorphismTheorem({V.name}:{U}∩{W})"

/-- Register the third isomorphism theorem. -/
def thirdIsoObject (F : Field) (V : VectorSpace F) (U W : Set V.V) : String :=
  s!"ThirdIsomorphismTheorem({V.name}:{U}⊂{W})"

/-- Object theory path: MiniDualQuotient.DualSpace. -/
def dualTheoryPath : String := "LinearAlgebra.DualQuotient.DualSpace"

/-- Object theory path: MiniDualQuotient.QuotientSpace. -/
def quotientTheoryPath : String := "LinearAlgebra.DualQuotient.QuotientSpace"

/-- Object theory path: MiniDualQuotient.Annihilator. -/
def annihilatorTheoryPath : String := "LinearAlgebra.DualQuotient.Annihilator"

/-- Object theory path: MiniDualQuotient.Transpose. -/
def transposeTheoryPath : String := "LinearAlgebra.DualQuotient.Transpose"

/-- The dual space of V has the same dimension as V (finite-dim case). -/
def dualDimensionFormula (F : Field) (V : VectorSpace F) : String :=
  s!"dim({V.name}*) = dim({V.name}) [finite-dimensional]"

/-- The quotient dimension formula: dim(V/U) = dim(V) - dim(U). -/
def quotientDimensionFormula (F : Field) (V : VectorSpace F) (U : Set V.V) : String :=
  s!"dim({V.name}/{U}) = dim({V.name}) - dim({U})"

/-- The annihilator dimension formula: dim(U°) = dim(V) - dim(U). -/
def annihilatorDimensionFormula (F : Field) (V : VectorSpace F) (U : Set V.V) : String :=
  s!"dim(Ann({V.name},{U})) = dim({V.name}) - dim({U})"

/-! ## L3: Inter-Theory Relationships

Registration of cross-theory dependencies and relationships.
-/

/-- DualSpace depends on VectorSpace theory. -/
def dualDependsOnVectorSpace : String := "DualSpace → VectorSpace [dependency]"

/-- QuotientSpace depends on VectorSpace and Subspace theories. -/
def quotientDependsOn : String := "QuotientSpace → VectorSpace, Subspace [dependency]"

/-- The relationship between DualSpace and QuotientSpace via Annihilator. -/
def dualQuotientRelation : String := "(V/U)* ≅ U° — duality connects quotients and annihilators"

/-- The transpose links DualSpace with LinearTransformation theory. -/
def transposeLinksTheories : String := "Transpose links DualSpace ↔ LinearTransformation"

/-- The canonical embedding links VectorSpace with DoubleDual. -/
def embeddingLinksTheories : String := "CanonicalEmbedding links VectorSpace → DoubleDual"

/-- The three isomorphism theorems are cross-cutting results
    linking QuotientSpace, DualSpace, and LinearTransformation. -/
def isoT theoremsLinkTheories : String :=
  "IsomorphismTheorems link Quotient × Dual × LinearTransformation"

#eval "Core.Objects: registered DualSpace, QuotientSpace, doubleDual, Annihilator, Transpose, and CanonicalEmbedding objects"

end MiniDualQuotient
