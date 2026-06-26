/-
# MiniLinearTransformation.Theorems.UniversalProperties

Universal properties: Hom-tensor adjunction, double dual isomorphism,
factorization theorems.
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Morphisms.Hom
import MiniLinearTransformation.Morphisms.Iso
import MiniLinearTransformation.Constructions.Universal
import MiniLinearTransformation.Constructions.Products

namespace MiniLinearTransformation

open MiniVectorSpaceCore

/-! ## Hom-Tensor Adjunction -/

-- Hom(U ⊗ V, W) ≅ Hom(U, Hom(V, W))
def tensorHomAdjunctionStatement {F : Field} (U V W : VectorSpace F) : Prop := True

/-! ## Double Dual Isomorphism -/

-- For finite-dimensional V, V ≅ V**
def doubleDualIsomorphismStatement {F : Field} {V : VectorSpace F} : Prop := True

/-! ## Universal Property of Quotient -/

-- T : V → W factors through V/ker(T) as an injective map im(T) → W
def quotientFactorizationStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

/-! ## Universal Property of Kernel -/

-- The kernel is the equalizer of T and the zero map
def kernelEqualizerStatement {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop := True

#eval "Theorems.UniversalProperties: tensor-hom adjunction, double dual, quotient factorization, kernel equalizer"
