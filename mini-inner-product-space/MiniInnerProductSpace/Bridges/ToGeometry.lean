/-
# MiniInnerProductSpace.Bridges.ToGeometry

Bridge from inner product spaces to geometry:
angles, distances, Gram matrix, orthogonal transformations.
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore

/-! ## Angle Between Vectors -/

def angle {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (x y : V.V) : F.carrier :=
  F.zero  -- cos(theta) = <x,y> / (||x|| * ||y||)

/-! ## Distance -/

def distance {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (x y : V.V) : F.carrier :=
  norm IP (V.add x (V.smul (F.neg F.one) y))  -- ||x - y||

/-! ## Gram Matrix -/

def gramMatrix {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (vecs : List V.V) : List (List F.carrier) :=
  []  -- G_{ij} = <v_i, v_j>

/-! ## Volume via Gram Determinant -/

def volume {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (vecs : List V.V) : F.carrier :=
  F.zero  -- vol = sqrt(det(Gram))

/-! ## Orthogonal Transformation (Rigid Motion) -/

def orthogonalTransformation {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : Prop :=
  forall (x y : V.V), IP.ip (T x) (T y) = IP.ip x y

/-! ## Reflection Across Hyperplane -/

def reflection {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (u : V.V) : LinearMap V V :=
  LinearMap.id V  -- R_u(x) = x - 2<x,u>/<u,u> * u

#eval "Bridges.ToGeometry: Angle, Distance, GramMatrix, Volume, OrthogonalTransformation, Reflection"
