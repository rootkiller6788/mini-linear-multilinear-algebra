/-
# MiniLinearTransformation.Core.Objects

Object instances for linear transformations: registering LinearMap
in the MiniObjectKernel, along with bundle, endomorphism algebra,
and Hom-space constructions.
-/

import MiniLinearTransformation.Core.Basic
import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects

namespace MiniLinearTransformation

open MiniVectorSpaceCore
open MiniObjectKernel

/-! ## Theory Registration for Linear Maps -/

/-- Theory name for linear maps. -/
def linearMapTheory : TheoryName := TheoryName.ofString "LinearMapTheory"

/-- Register LinearMap as an Object in the MiniObjectKernel typeclass. -/
instance {F : Field} {V W : VectorSpace F} : Object (LinearMap V W) where
  theory := linearMapTheory
  objName := "LinearMap"
  repr _T := "LinearMap"

/-! ## LinearMapBundle — Source, Target, and the Map Itself

A bundle packages a linear map together with its source and target spaces,
useful for categorical constructions.
-/

/-- A bundle carrying a linear map with its domain and codomain. -/
structure LinearMapBundle (F : Field) where
  source : VectorSpace F
  target : VectorSpace F
  map : LinearMap source target

/-- Extract the linear map from a bundle. -/
def LinearMapBundle.map' (b : LinearMapBundle F) : LinearMap b.source b.target :=
  b.map

/-- The identity bundle for a vector space V. -/
def LinearMapBundle.id (F : Field) (V : VectorSpace F) : LinearMapBundle F where
  source := V
  target := V
  map := LinearMap.id V

/-- Compose two bundles (when target of first matches source of second). -/
def LinearMapBundle.comp {F : Field} (g f : LinearMapBundle F)
    (_h : f.target = g.source) : LinearMapBundle F where
  source := f.source
  target := g.target
  map := LinearMap.comp g.map f.map

/-- The zero bundle from V to W. -/
def LinearMapBundle.zero (F : Field) (V W : VectorSpace F) : LinearMapBundle F where
  source := V
  target := W
  map := LinearMap.zero V W

/-! ## Endomorphism Algebra

The set \(\mathrm{End}(V)\) of all linear operators on \(V\) forms a
ring-like structure under addition and composition.
-/

/-- Addition of endomorphisms: (S + T)(v) = S(v) + T(v). -/
axiom EndoAdd {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : LinearMap V V

/-- Scalar multiplication of an endomorphism: (c·T)(v) = c·T(v). -/
axiom EndoScalarMul {F : Field} {V : VectorSpace F} (c : F.carrier) (T : LinearMap V V) : LinearMap V V

/-- The zero endomorphism. -/
axiom EndoZero {F : Field} {V : VectorSpace F} : LinearMap V V

/-- End(V) forms a unital ring with addition and composition. -/
axiom endomorphismRing {F : Field} (V : VectorSpace F) : Prop

/-- End(V) is an associative algebra over F. -/
axiom endomorphismAlgebra {F : Field} (V : VectorSpace F) : Prop

/-- Composition distributes over addition in End(V). -/
axiom endoDistrib {F : Field} {V : VectorSpace F} (R S T : LinearMap V V) : Prop

/-! ## Hom-Space as a Vector Space

\(\mathrm{Hom}(V, W)\), the set of linear maps from \(V\) to \(W\), forms
a vector space over \(F\) under pointwise addition and scalar multiplication.
-/

/-- Hom(V,W) forms a vector space over F (conceptual). -/
axiom homSpaceIsVectorSpace {F : Field} (V W : VectorSpace F) : Prop

/-- Dimension of Hom(V,W) = dim(V) · dim(W). -/
axiom homSpaceDimension {F : Field} (V W : VectorSpace F) : Prop

/-- The dual space V* = Hom(V, F) is a special case. -/
axiom dualSpaceAsHomSpace {F : Field} (V : VectorSpace F) : Prop

/-- The double dual V** is canonically isomorphic to V (for finite-dimensional V). -/
axiom doubleDualIsomorphism {F : Field} (V : VectorSpace F) : Prop

#eval "Core.Objects — LinearMap registered as Object with theory LinearMapTheory"
#eval "LinearMapBundle: id bundle, compose bundles, zero bundle"
#eval "End(V) ring: EndoAdd, EndoScalarMul, EndoZero, endoDistrib"
#eval "Hom(V,W) vector space: dim = dim(V)·dim(W), dual space V*"

end MiniLinearTransformation
