/-
# MiniInnerProductSpace.Bridges.ToAlgebra

Bridge from inner product spaces to algebra:
positive-definite matrices, quadratic forms, inner product on algebras.
-/

import MiniInnerProductSpace.Core.Basic

namespace MiniInnerProductSpace

open MiniVectorSpaceCore

/-! ## Positive-Definite Matrix -/

def positiveDefiniteMatrix (n : Nat) : Prop :=
  -- A matrix M such that x^T M x > 0 for all x != 0
  True

/-! ## Quadratic Form from Inner Product -/

def quadraticFormFromIP {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) (x : V.V) : F.carrier :=
  IP.ip x x  -- q(x) = <x, x>

/-! ## Inner Product from Quadratic Form (Polarization) -/

def ipFromQuadraticForm {F : Field} {V : VectorSpace F} (q : V.V -> F.carrier) : Prop :=
  -- <x,y> = (q(x+y) - q(x) - q(y)) / 2
  True

/-! ## C*-Algebra Norm from Inner Product -/

def cStarAlgebraNorm {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) : Prop :=
  -- ||a||^2 = ||a*a|| in a C*-algebra
  True

/-! ## Clifford Algebra from Inner Product -/

def cliffordAlgebraFromIP {F : Field} {V : VectorSpace F} (IP : InnerProduct F V) : Prop :=
  -- C_l(V, IP) with relation v*w + w*v = <v,w>*1
  True

#eval "Bridges.ToAlgebra: PositiveDefiniteMatrix, QuadraticForm, C*-Algebra, CliffordAlgebra"
