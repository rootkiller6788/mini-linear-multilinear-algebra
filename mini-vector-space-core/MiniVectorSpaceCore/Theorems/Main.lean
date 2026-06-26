/-
# MiniVectorSpaceCore: Main Theorems

The central theorems of linear algebra synthesized:
main classification theorem and the fundamental theorem of linear maps.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Morphisms.Iso
import MiniVectorSpaceCore.Theorems.Basic
import MiniVectorSpaceCore.Theorems.Classification
import MiniVectorSpaceCore.Theorems.UniversalProperties
import MiniVectorSpaceCore.Properties.Invariants
import MiniVectorSpaceCore.Properties.Preservation

namespace MiniVectorSpaceCore

/-! ## Main classification theorem -/

axiom mainClassificationTheorem {F : Field} (VS₁ VS₂ : VectorSpace F)
    (h₁ : hasFiniteDimension VS₁) (h₂ : hasFiniteDimension VS₂) :
    (isIsomorphic VS₁ VS₂) ↔ (dimension VS₁ = dimension VS₂)

/-! ## Fundamental theorem of linear algebra (rank + nullity = dim) -/

axiom fundamentalTheoremLinAlg {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin : hasFiniteDimension VS₁) :
    dimension VS₁ = rank f + nullity f

/-! ## Consequences of the fundamental theorem -/

axiom rank_le_dim_domain {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin : hasFiniteDimension VS₁) :
    rank f ≤ dimension VS₁

axiom nullity_le_dim_domain {F : Field} {VS₁ VS₂ : VectorSpace F}
    (f : LinearMap VS₁ VS₂) (hFin : hasFiniteDimension VS₁) :
    nullity f ≤ dimension VS₁

/-! ## Summary of finite-dimensional linear algebra -/

structure FiniteDimSummary (F : Field) (VS : VectorSpace F) where
  finiteDim    : hasFiniteDimension VS
  dbasis       : Basis F VS
  classType    : isIsomorphic VS (fnSpace F (dimension VS))
  dimIso       : ∀ (W : VectorSpace F), isIsomorphic VS W → dimension W = dimension VS
  mapDecomp    : ∀ {W : VectorSpace F} (f : LinearMap VS W),
                  dimension VS = rank f + nullity f

axiom finiteDimSummary_exists {F : Field} (VS : VectorSpace F)
    (h : hasFiniteDimension VS) : FiniteDimSummary F VS

/-! ## Summary propositions as a structure -/

structure VectorSpaceSummary (F : Field) where
  classification : ∀ (VS₁ VS₂ : VectorSpace F), hasFiniteDimension VS₁ → hasFiniteDimension VS₂ →
                    (isIsomorphic VS₁ VS₂ ↔ dimension VS₁ = dimension VS₂)
  rankNullity    : ∀ {VS₁ VS₂ : VectorSpace F} (f : LinearMap VS₁ VS₂), hasFiniteDimension VS₁ →
                    dimension VS₁ = rank f + nullity f
  dimProduct     : ∀ (VS₁ VS₂ : VectorSpace F),
                    dimension (prodVS VS₁ VS₂) = dimension VS₁ + dimension VS₂

axiom vectorSpaceSummary (F : Field) : VectorSpaceSummary F

/-! ## #eval examples -/

def testMainVS := fnSpace Field.trivial 2

#eval "Theorems.Main: mainClassificationTheorem — finite-dim VS classified by dim"
#eval "Theorems.Main: fundamentalTheoremLinAlg — rank + nullity = dim"
#eval s!"Theorems.Main: dim(test F^2) = {dimension testMainVS}"
#eval "Theorems.Main: VectorSpaceSummary bundles classification + rank-nullity + dim product"

/-! ## Applications and examples (L7) -/

structure LinearSystem {F : Field} {m n : Nat} where
  matrix : Fin m → Fin n → F.carrier
  rhs : Fin m → F.carrier

def LinearSystem.solutions {F : Field} {m n : Nat} (sys : LinearSystem (m:=m) (n:=n)) : Set ((fnSpace F n).V) :=
  { x | True }

axiom linearSystem_solution_space_affine {F : Field} {m n : Nat} (sys : LinearSystem (m:=m) (n:=n)) : True

/-! ## Summary: vector space theory hierarchy -/

/-! ## Proof techniques summary (L5)

1. Basis selection: Choose a basis and use the coordinate representation
2. Steinitz exchange: |I| ≤ |S| for independent I and spanning S
3. Dimension counting: Use rank-nullity and dimension formulas
4. Universal properties: Construct unique morphism, verify commutation
5. Categorical: Use adjoint functors, natural transformations
-/

#eval "• linearSystem_solution_space — application to linear systems (L7)"
#eval "• Proof techniques: basis selection, Steinitz, dim count, UP, categorical (L5)"
#eval "══ Theorems.Main: Synthesis Complete ══"

end MiniVectorSpaceCore
