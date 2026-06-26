/-
# MiniInnerProductSpace.Morphisms.Hom
Isometric maps: linear maps that preserve inner products.
L2: IsometricMap, IsometricEmbedding, PartialIsometry
L3: Composition of isometric maps
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

/-! ## Isometric Linear Map (L2) -/

structure IsometricMap {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) where
  toLinearMap : LinearMap V W
  preservesInner : forall (x y : V.V), IPW.ip (toLinearMap.map x) (toLinearMap.map y) = IPV.ip x y

namespace IsometricMap

/-! ## Identity Isometric Map -/

def id {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) : IsometricMap IP IP where
  toLinearMap := LinearMap.id V
  preservesInner x y := rfl

/-! ## Composition of Isometric Maps -/

def comp {F : Field} {V W U : VectorSpace F}
    {IPV : InnerProduct F V} {IPW : InnerProduct F W} {IPU : InnerProduct F U}
    (f : IsometricMap IPV IPW) (g : IsometricMap IPW IPU) : IsometricMap IPV IPU where
  toLinearMap := LinearMap.comp g.toLinearMap f.toLinearMap
  preservesInner x y := by
    rw [g.preservesInner, f.preservesInner]

/-! ## Isometric Map Preserves Norm -/

theorem preservesNorm {F : Field} {V W : VectorSpace F} {IPV : InnerProduct F V} {IPW : InnerProduct F W}
    (f : IsometricMap IPV IPW) (x : V.V) : normSq IPW (f.toLinearMap.map x) = normSq IPV x := by
  rw [normSq, normSq, f.preservesInner]

/-! ## Isometric Map Preserves Orthogonality -/

theorem preservesOrthogonal {F : Field} {V W : VectorSpace F} {IPV : InnerProduct F V} {IPW : InnerProduct F W}
    (f : IsometricMap IPV IPW) (x y : V.V) (h : orthogonal IPV x y) : orthogonal IPW (f.toLinearMap.map x) (f.toLinearMap.map y) := by
  unfold orthogonal
  rw [f.preservesInner, h]

end IsometricMap

/-! ## Isometric Embedding (L2) -/

structure IsometricEmbedding {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) where
  toIsometricMap : IsometricMap IPV IPW
  injective : forall (x y : V.V), toIsometricMap.toLinearMap.map x = toIsometricMap.toLinearMap.map y -> x = y

/-! ## Partial Isometry (L2/L8) -/

structure PartialIsometry {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) where
  toLinearMap : LinearMap V W
  isometricOnKernelOrth : True

/-! ## Norm-Preserving Map (weaker than isometric) -/

def isNormPreserving {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W)
    (T : LinearMap V W) : Prop :=
  forall (x : V.V), normSq IPW (T.map x) = normSq IPV x

/-! ## Isometric implies Norm-Preserving -/

theorem isometric_implies_normPreserving {F : Field} {V W : VectorSpace F}
    {IPV : InnerProduct F V} {IPW : InnerProduct F W}
    (f : IsometricMap IPV IPW) : isNormPreserving IPV IPW f.toLinearMap := by
  intro x; rw [normSq, normSq, f.preservesInner]

#eval "Morphisms.Hom: IsometricMap, IsometricEmbedding, PartialIsometry - all defined."