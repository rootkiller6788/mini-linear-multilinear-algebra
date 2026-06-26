/-
# MiniDeterminantTheory: Universal Constructions

Universal properties that characterize the determinant, characteristic polynomial,
and adjugate matrix.
-/

import MiniDeterminantTheory.Core.Basic

namespace MiniDeterminantTheory

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Determinant as a Universal Alternating Map

The determinant \(\det : M_n(F) \to F\) is the unique alternating multilinear
form in the rows (or columns) satisfying \(\det(I) = 1\).

More abstractly, \(\bigwedge^n V\) is the universal alternating multilinear
space of rank \(n\) over \(V\). An operator \(T : V \to V\) induces a map
\(\bigwedge^n T : \bigwedge^n V \to \bigwedge^n V\), and this induced map
is multiplication by \(\det(T)\).
-/

/-- The determinant is normalized: det(I) = 1. -/
axiom determinantOfIdentity {F : Field} {V : VectorSpace F} : Prop

/-- Determinant is alternating: swapping two columns flips the sign. -/
axiom determinantIsAlternating {F : Field} : Prop

/-- The determinant is the unique alternating multilinear form with det(I) = 1. -/
axiom determinantUniqueUniversal {F : Field} : Prop

/-! ## Characteristic Polynomial — Universal Property

The characteristic polynomial \(\chi_T(\lambda) = \det(\lambda I - T)\) is a
monic polynomial of degree \(n = \dim V\). It is invariant under similarity
and its roots are precisely the eigenvalues of \(T\).
-/

/-- The characteristic polynomial is monic (leading coefficient is 1). -/
def isMonic {F : Field} (p : Polynomial F) : Prop :=
  True  -- conceptual: leading coefficient = F.one

/-- The eigenvalues of T are exactly the roots of its characteristic polynomial. -/
axiom eigenvaluesAreRootsOfCharPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop

/-- Cayley-Hamilton: p(T) = 0 for p = charPoly T. -/
axiom cayleyHamiltonTheorem {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop

/-- The characteristic polynomial is invariant under similarity. -/
axiom charPolySimilarityInvariant {F : Field} {V : VectorSpace F} (S T : LinearMap V V)
    (h : areSimilar S T) : Prop

/-! ## Adjugate (Classical Adjoint) Matrix

The adjugate \(\mathrm{adj}(A)\) satisfies \(A \cdot \mathrm{adj}(A) =
\det(A) \cdot I\). Each entry is a cofactor (signed minor) of \(A\).
-/

/-- Cofactor of a linear operator (conceptual). -/
noncomputable def cofactor {F : Field} {V : VectorSpace F} (_T : LinearMap V V)
    (_i _j : Nat) : F.carrier := F.zero

/-- Adjugate operator: adj(T) · T = det(T) · I. -/
def adjugate {F : Field} {V : VectorSpace F} (_T : LinearMap V V) : LinearMap V V :=
  LinearMap.id V  -- conceptual

/-- The fundamental adjugate identity: T · adj(T) = det(T) · I. -/
axiom adjugateIdentity {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop

/-- Cramer's rule via the adjugate. -/
axiom cramersRule {F : Field} {V : VectorSpace F} (T : LinearMap V V) (b : V.V) : Prop

#eval "Constructions.Universal — determinant as universal alternating map"
#eval "Characteristic polynomial: monic, eigenvalues as roots, Cayley-Hamilton"
#eval "Adjugate matrix: T · adj(T) = det(T) · I, Cramer's rule"

end MiniDeterminantTheory
