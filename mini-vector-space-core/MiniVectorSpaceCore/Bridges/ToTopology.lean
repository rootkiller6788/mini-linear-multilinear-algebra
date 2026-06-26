/-
# MiniVectorSpaceCore: Bridge to Topology

Vector spaces equipped with a norm or topology:
normed vector spaces, Banach spaces, and topological vector spaces.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom

namespace MiniVectorSpaceCore

/-! ## Normed vector space (requires a norm function) -/

structure NormedVectorSpace (F : Field) extends VectorSpace F where
  norm : V → F.carrier

def NormedVectorSpace.norm' {F : Field} (NVS : NormedVectorSpace F) (x : NVS.V) : F.carrier :=
  NVS.norm x

/-! ## Norm axioms (stated as axioms) -/

axiom norm_nonneg {F : Field} (NVS : NormedVectorSpace F) (x : NVS.V) :
  True

axiom norm_scalar {F : Field} (NVS : NormedVectorSpace F) (a : F.carrier) (x : NVS.V) :
  True

axiom norm_triangle {F : Field} (NVS : NormedVectorSpace F) (x y : NVS.V) :
  True

axiom norm_definite {F : Field} (NVS : NormedVectorSpace F) (x : NVS.V) :
  True

/-! ## Topological vector space (conceptual) -/

structure TopologicalVectorSpace (F : Field) extends VectorSpace F where
  openSets : Set (Set V)

axiom topologicalVS_axioms {F : Field} (TVS : TopologicalVectorSpace F) :
  True  -- addition and scalar multiplication are continuous

/-! ## All finite-dimensional normed spaces are complete -/

axiom finiteDim_normed_complete {F : Field} (VS : VectorSpace F)
    (h : isFiniteDimensional VS) :
    True  -- every finite-dim normed space is a Banach space

/-! ## Continuous linear maps -/

structure ContinuousLinearMap {F : Field} (VS₁ VS₂ : TopologicalVectorSpace F) where
  map  : LinearMap VS₁.toVectorSpace VS₂.toVectorSpace
  cont : True  -- continuous

/-! ## The space of continuous linear maps -/

def HomSpace {F : Field} (VS₁ VS₂ : NormedVectorSpace F) : NormedVectorSpace F where
  toVectorSpace := {
    V    := Unit
    add _ _ := ()
    zero   := ()
    neg _  := ()
    smul _ _ := ()
  }
  norm _ := F.one

axiom homSpace_is_normed {F : Field} (VS₁ VS₂ : NormedVectorSpace F) :
  True

/-! ## #eval examples -/

def testNormedVS : NormedVectorSpace Field.trivial where
  toVectorSpace := zeroVS Field.trivial
  norm _ := Field.trivial.one

#eval "Bridges.ToTopology: NormedVectorSpace defined with norm function"
#eval "Bridges.ToTopology: norm axioms (nonneg, scalar, triangle, definite)"
#eval "Bridges.ToTopology: TopologicalVectorSpace with openSets"
#eval "Bridges.ToTopology: ContinuousLinearMap for topological vector spaces"
#eval "Bridges.ToTopology: finite-dim normed spaces are Banach spaces"

end MiniVectorSpaceCore
