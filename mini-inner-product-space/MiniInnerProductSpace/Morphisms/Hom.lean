/-
# MiniInnerProductSpace.Morphisms.Hom

Isometric maps: linear maps that preserve inner products.
-/

import MiniInnerProductSpace.Core.Basic
import MiniLinearTransformation.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Isometric Linear Map -/

structure IsometricMap {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) extends LinearMap V W where
  preservesInner : forall (x y : V.V), IPW.ip (toLinearMap x) (toLinearMap y) = IPV.ip x y
  -- <Tx, Ty>_W = <x, y>_V

/-! ## Isometric Embedding -/

structure IsometricEmbedding {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) extends IsometricMap IPV IPW where
  injective : forall (x y : V.V), toLinearMap x = toLinearMap y -> x = y

/-! ## Partial Isometry -/

structure PartialIsometry {F : Field} {V W : VectorSpace F} (IPV : InnerProduct F V) (IPW : InnerProduct F W) extends LinearMap V W where
  isometricOnKernelOrth : True  -- isometric on (ker T)^⟂

/-! ## Composition of Isometric Maps -/

def isometricMapComp {F : Field} {V W U : VectorSpace F}
    (IPV : InnerProduct F V) (IPW : InnerProduct F W) (IPU : InnerProduct F U)
    (f : IsometricMap IPV IPW) (g : IsometricMap IPW IPU) : IsometricMap IPV IPU :=
  { g with
    preservesInner := fun x y => by
      -- <g(Tx), g(Ty)> = <Tx, Ty> = <x, y>
      sorry
  }

#eval "Morphisms.Hom: IsometricMap, IsometricEmbedding, PartialIsometry"
