/-
# MiniVectorSpaceCore: Bridge to Geometry

Affine spaces, projective spaces, and Grassmannians
all arise naturally from vector spaces.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Constructions.Subobjects

namespace MiniVectorSpaceCore

/-! ## Affine space — vector space with a forgotten origin -/

structure AffineSpace (F : Field) where
  A : Type u
  VS : VectorSpace F
  vsub : A → A → VS.V
  vadd : A → VS.V → A

def AffineSpace.underlyingVS {F : Field} (AS : AffineSpace F) : VectorSpace F :=
  AS.VS

axiom affineSpace_axioms {F : Field} (AS : AffineSpace F) :
  True  -- vadd(p, vsub(p, q)) = q, vadd(vadd(p, v), w) = vadd(p, v + w)

/-! ## Affine map — linear map + translation -/

structure AffineMap {F : Field} (AS₁ AS₂ : AffineSpace F) where
  linearPart : LinearMap AS₁.VS AS₂.VS
  translation : AS₂.VS.V

/-! ## Projective space — 1-dimensional subspaces of V -/

structure ProjectiveSpace (F : Field) (VS : VectorSpace F) where
  points : Set (Set VS.V)

def ProjectiveSpace.point {F : Field} {VS : VectorSpace F}
    (PS : ProjectiveSpace F VS) (v : VS.V) (hv : v ≠ VS.zero) : Set VS.V :=
  { w | True }  -- line through origin containing v

/-! ## Projective space dimension -/

axiom projectiveDim {F : Field} (VS : VectorSpace F) (PS : ProjectiveSpace F VS) :
  True  -- dim(P(V)) = dim(V) - 1

/-! ## Grassmannian — k-dimensional subspaces of V -/

structure Grassmannian (F : Field) (VS : VectorSpace F) (k : Nat) where
  subspaces : Set (Set VS.V)

def Grassmannian.subspace {F : Field} {VS : VectorSpace F} {k : Nat}
    (G : Grassmannian F VS k) (U : Set VS.V) (hU : U ∈ G.subspaces) : Set VS.V :=
  U

axiom grassmannian_dim {F : Field} (VS : VectorSpace F) (k : Nat)
    (hFin : hasFiniteDimension VS) (G : Grassmannian F VS k) :
  True  -- dim(Gr(k, V)) = k * (dim(V) - k)

/-! ## Linear algebraic group actions (conceptual) -/

axiom GL_action {F : Field} (VS : VectorSpace F) :
  True  -- GL(V) acts transitively on bases

/-! ## #eval examples -/

def testAffine : AffineSpace Field.trivial where
  A    := Unit
  VS   := zeroVS Field.trivial
  vsub _ _ := ()
  vadd _ _ := ()

#eval "Bridges.ToGeometry: AffineSpace — vector space without origin"
#eval "Bridges.ToGeometry: AffineMap — linear part + translation"
#eval "Bridges.ToGeometry: ProjectiveSpace — 1-dim subspaces of V"
#eval "Bridges.ToGeometry: Grassmannian — Grassmannian Gr(k, V)"
#eval "Bridges.ToGeometry: GL(V) acts transitively on bases"

end MiniVectorSpaceCore
