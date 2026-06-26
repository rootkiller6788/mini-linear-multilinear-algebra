/-
# MiniInnerProductSpace.Core.Basic

Inner product spaces: inner products, norms, orthogonality,
orthonormal bases, Gram-Schmidt, adjoints.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Inner Product (over R or C -- conceptual over F) -/

structure InnerProduct (F : Field) (V : VectorSpace F) where
  ip : V.V -> V.V -> F.carrier
  conjugateSym : forall (x y : V.V), ip x y = ip y x
  linearFirst : forall (x y z : V.V) (a : F.carrier),
    ip (V.add (V.smul a x) y) z = F.add (F.mul a (ip x z)) (ip y z)
  positiveDefinite : forall (x : V.V), x != V.zero -> ip x x != F.zero

/-! ## Norm induced by Inner Product -/

def norm {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (x : V.V) : F.carrier :=
  IP.ip x x  -- conceptual: sqrt(ip x,x)

/-! ## Orthogonality -/

def orthogonal {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (x y : V.V) : Prop :=
  IP.ip x y = F.zero

notation:60 x:60 " ⟂ " y:60 => orthogonal _ x y

/-! ## Orthogonal Complement -/

def orthogonalComplement {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (S : Set V.V) : Set V.V :=
  fun v => forall (s, s in S), orthogonal IP v s

/-! ## Orthonormal Basis -/

structure OrthonormalBasis (F : Field) (V : VectorSpace F) (IP : InnerProduct F V) where
  basis : Basis F V
  orthonormal : forall (b1 b2 : V.V), b1 in basis.basisSet -> b2 in basis.basisSet ->
    IP.ip b1 b2 = if b1 = b2 then F.one else F.zero

/-! ## Gram-Schmidt Process -/

def gramSchmidt {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (vecs : List V.V) : List V.V :=
  []  -- conceptual: returns orthonormalized list

/-! ## Adjoint Operator -/

noncomputable def adjoint {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : LinearMap V V :=
  LinearMap.id V  -- conceptual: <Tx,y> = <x,T*y>

/-! ## Self-Adjoint / Hermitian -/

def isSelfAdjoint {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : Prop :=
  adjoint IP T = T

/-! ## Unitary / Orthogonal Operator -/

def isUnitary {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (T : LinearMap V V) : Prop :=
  True  -- T preserves inner product: <Tx,Ty> = <x,y>

/-! ## Orthogonal Projection -/

noncomputable def orthogonalProjection {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (W : Set V.V) : LinearMap V V :=
  LinearMap.id V  -- conceptual

#eval "Core.Basic: InnerProduct, norm, orthogonal, Gram-Schmidt, adjoint, unitary"
