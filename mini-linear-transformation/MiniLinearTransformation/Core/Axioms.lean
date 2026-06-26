/-
# MiniLinearTransformation.Core.Axioms
Vector space axiom system: the 12 standard axioms packaged as
VectorSpaceProps. This file is the foundation for all proofs
about linear transformations.

Knowledge coverage:
- L1: VectorSpaceProps structure (12 axiom bundle)
- L2: Individual axiom predicates
- L3: Vector space as algebraic structure
-/

import MiniVectorSpaceCore.Core.Basic

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Individual Axiom Predicates (L1, L2) -/

def addAssoc {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (x y z : V.V), V.add (V.add x y) z = V.add x (V.add y z)

def zeroAdd {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (x : V.V), V.add V.zero x = x

def addZero {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (x : V.V), V.add x V.zero = x

def addComm {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (x y : V.V), V.add x y = V.add y x

def addNeg {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (x : V.V), V.add x (V.neg x) = V.zero

def negAdd {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (x : V.V), V.add (V.neg x) x = V.zero

def smulAdd {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (a : F.carrier) (x y : V.V), V.smul a (V.add x y) = V.add (V.smul a x) (V.smul a y)

def addSmul {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (a b : F.carrier) (x : V.V), V.smul (F.add a b) x = V.add (V.smul a x) (V.smul b x)

def mulSmul {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (a b : F.carrier) (x : V.V), V.smul (F.mul a b) x = V.smul a (V.smul b x)

def oneSmul {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (x : V.V), V.smul F.one x = x

def zeroSmul {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (x : V.V), V.smul F.zero x = V.zero

def smulZero {F : Field} (V : VectorSpace F) : Prop :=
  ∀ (a : F.carrier), V.smul a V.zero = V.zero

/-! ## Vector Space Axiom Bundle (L1) -/

structure VectorSpaceProps {F : Field} (V : VectorSpace F) where
  vsAddAssoc  : addAssoc V
  vsZeroAdd   : zeroAdd V
  vsAddZero   : addZero V
  vsAddComm   : addComm V
  vsAddNeg    : addNeg V
  vsNegAdd    : negAdd V
  vsSmulAdd   : smulAdd V
  vsAddSmul   : addSmul V
  vsMulSmul   : mulSmul V
  vsOneSmul   : oneSmul V
  vsZeroSmul  : zeroSmul V
  vsSmulZero  : smulZero V

variable {F : Field} {V : VectorSpace F}

theorem zero_add_zero (vp : VectorSpaceProps V) : V.add V.zero V.zero = V.zero :=
  vp.vsZeroAdd V.zero

theorem smul_zero_eq_zero (vp : VectorSpaceProps V) (a : F.carrier) : V.smul a V.zero = V.zero :=
  vp.vsSmulZero a

theorem zero_smul_eq_zero (vp : VectorSpaceProps V) (v : V.V) : V.smul F.zero v = V.zero :=
  vp.vsZeroSmul v

end MiniLinearTransformation
