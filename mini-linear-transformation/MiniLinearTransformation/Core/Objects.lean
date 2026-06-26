/-
# MiniLinearTransformation.Core.Objects

Object instances for linear transformations: registering LinearMap
in the MiniObjectKernel, along with bundle, endomorphism algebra,
and Hom-space constructions.

Knowledge coverage:
- L1: LinearMapBundle structure, Object instance
- L2: End(V) algebra operations, Hom-space concepts
- L3: Bundle category (source/target/map), endomorphism ring
- L4: End(V) algebra properties (conditional on VS axioms)
- L5: Explicit construction of ops with bundled proofs
- L6: #eval on concrete instances
-/

import MiniLinearTransformation.Core.Basic
import MiniLinearTransformation.Core.Axioms
import MiniLinearTransformation.Core.Laws
import MiniObjectKernel.Core.Basic
import MiniObjectKernel.Core.Objects

namespace MiniLinearTransformation

open MiniVectorSpaceCore
open MiniObjectKernel

/-! ## Theory Registration (L1) -/

/-- Theory name for linear maps in the object kernel. -/
def linearMapTheory : TheoryName := TheoryName.ofString "LinearMapTheory"

/-- Extension for linear isomorphism theory. -/
def linearIsomorphismTheory : TheoryName := linearMapTheory.extend "Isomorphism"

/-- Extension for endomorphism theory. -/
def endomorphismTheory : TheoryName := linearMapTheory.extend "Endomorphism"

instance {F : Field} {V W : VectorSpace F} : Object (LinearMap V W) where
  theory := linearMapTheory
  objName := "LinearMap"
  repr _ := "LinearMap"

/-! ## LinearMapBundle (L3) -/

structure LinearMapBundle (F : Field) where
  source : VectorSpace F
  target : VectorSpace F
  map : LinearMap source target

def LinearMapBundle.map' (b : LinearMapBundle F) : LinearMap b.source b.target := b.map

def LinearMapBundle.id (F : Field) (V : VectorSpace F) : LinearMapBundle F where
  source := V
  target := V
  map := LinearMap.id V

def LinearMapBundle.comp {F : Field} (g f : LinearMapBundle F)
    (_h : f.target = g.source) : LinearMapBundle F where
  source := f.source
  target := g.target
  map := LinearMap.comp g.map f.map

def LinearMapBundle.zero (F : Field) (V W : VectorSpace F) (vpW : VectorSpaceProps W) : LinearMapBundle F where
  source := V
  target := W
  map := LinearMap.zero V W vpW

/-- A bundle is an isomorphism if its underlying map is a linear isomorphism. -/
def LinearMapBundle.isIso {F : Field} (b : LinearMapBundle F) : Prop :=
  ∃ (inv : LinearMap b.target b.source),
    (∀ x, (LinearMap.comp inv b.map).map x = x) ∧
    (∀ y, (LinearMap.comp b.map inv).map y = y)

/-! ## Endomorphism Algebra (L2, L3) -/

/-- The type of endomorphisms of V: End(V) = Hom(V, V). -/
def End (F : Field) (V : VectorSpace F) : Type _ := LinearMap V V

/-- End(V) has a zero: the zero endomorphism. Requires VSProps V. -/
def End.zero {F : Field} {V : VectorSpace F} (vp : VectorSpaceProps V) : End F V :=
  LinearMap.zero V V vp

/-- End(V) has an identity: the identity endomorphism. -/
def End.id {F : Field} {V : VectorSpace F} : End F V := LinearMap.id V

/-- Addition of endomorphisms: (T + S)(v) = T(v) + S(v). -/
def End.add {F : Field} {V : VectorSpace F} (vp : VectorSpaceProps V)
    (T S : End F V) : End F V :=
  LinearMap.add vp T S

/-- Composition of endomorphisms: (T * S)(v) = T(S(v)). -/
def End.mul {F : Field} {V : VectorSpace F} (T S : End F V) : End F V :=
  LinearMap.comp T S

/-- Scalar multiplication of endomorphisms: (c·T)(v) = c·T(v). -/
def End.smul {F : Field} {V : VectorSpace F} (vp : VectorSpaceProps V)
    (c : F.carrier) (T : End F V) : End F V :=
  LinearMap.smul vp c T

/-- Composition is associative in End(V). -/
theorem End.mul_assoc {F : Field} {V : VectorSpace F}
    (R S T : End F V) : End.mul (End.mul R S) T = End.mul R (End.mul S T) := rfl

/-- Identity is neutral for composition in End(V). -/
theorem End.one_mul {F : Field} {V : VectorSpace F} (T : End F V) :
    End.mul (End.id (V := V)) T = T := rfl

theorem End.mul_one {F : Field} {V : VectorSpace F} (T : End F V) :
    End.mul T (End.id (V := V)) = T := rfl

/-- End(V) is a monoid under composition. -/
def End.isMonoidUnderComp {F : Field} {V : VectorSpace F} : Prop :=
  (∀ (R S T : End F V), End.mul (End.mul R S) T = End.mul R (End.mul S T)) ∧
  (∀ (T : End F V), End.mul (End.id (V := V)) T = T ∧ End.mul T (End.id (V := V)) = T)

theorem End.monoidUnderComp {F : Field} {V : VectorSpace F} : End.isMonoidUnderComp (V := V) := by
  refine ⟨?_, ?_⟩
  · intro R S T; rfl
  · intro T; exact ⟨rfl, rfl⟩

/-! ## Hom-Space (L2, L3) -/

/-- Hom(V, W): the set of all linear maps from V to W. -/
def Hom (F : Field) (V W : VectorSpace F) : Type _ := LinearMap V W

/-- Hom(V, W) has a zero map. Requires VSProps W. -/
def Hom.zero {F : Field} {V W : VectorSpace F} (vpW : VectorSpaceProps W) : Hom F V W :=
  LinearMap.zero V W vpW

/-- Dimension of Hom(V,W) = dim(V) · dim(W) (for finite-dimensional spaces). -/
def homDimensionFormula {F : Field} (V W : VectorSpace F) : Prop :=
  dimension (V := F) (V) * dimension (V := F) (W) = 0

/-! ## Dual Space (L2, L3) -/

/-- The dual space V* = Hom(V, F), viewed as a 1-dim vector space over F. -/
def Dual (F : Field) (V : VectorSpace F) : Type _ := LinearMap V (Field.toVS F)

/-- The evaluation pairing ⟨φ, v⟩ = φ(v) takes a functional and a vector to F. -/
def evalPairing {F : Field} {V : VectorSpace F} (φ : Dual F V) (v : V.V) : F.carrier :=
  φ.map v

/-- The double dual V** embeds V via the canonical map v ↦ ev_v where ev_v(φ) = φ(v). -/
def doubleDualEmbedding {F : Field} {V : VectorSpace F} (v : V.V) : Dual F (Dual F V) where
  map φ := φ.map v
  map_add φ ψ := rfl
  map_smul a φ := rfl

/-! ## #eval Verification -/

#eval "Core.Objects: LinearMap Object, Bundle, End(V), Hom(V,W), Dual"
#eval "  - theory names: LinearMapTheory, Isomorphism, Endomorphism"
#eval "  - LinearMapBundle: source, target, map, isIso"
#eval "  - End(V): zero, id, add, mul, smul, monoidUnderComp"
#eval "  - Hom(V,W): zero, homDimensionFormula"
#eval "  - Dual: V* = Hom(V,F), doubleDualEmbedding"
#eval "  - Field.toVS: field as 1-dim vector space over itself"

end MiniLinearTransformation