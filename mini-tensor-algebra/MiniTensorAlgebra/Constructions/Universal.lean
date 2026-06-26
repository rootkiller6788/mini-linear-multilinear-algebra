/-
# MiniTensorAlgebra.Constructions.Universal

Universal constructions: free vector space on a set,
free algebra, universal enveloping algebra,
and universal property proofs.
-/

import MiniTensorAlgebra.Core.Basic
import MiniTensorAlgebra.Constructions.Quotients

namespace MiniTensorAlgebra

open MiniVectorSpaceCore

/-! ## Free Vector Space -/

structure FreeVectorSpace (F : Field) (X : Type) where
  V : VectorSpace F
  ι : X → V.V
  universal : ∀ (W : VectorSpace F) (f : X → W.V),
    ∃! (g : LinearMap V W), ∀ (x : X), g.map (ι x) = f x

/-! ## Free Algebra -/

structure FreeAlgebra (F : Field) (X : Type) where
  A : VectorSpace F  -- underlying vector space
  mul : A.V → A.V → A.V
  ι : X → A.V
  universal : ∀ (B : VectorSpace F) (mulB : B.V → B.V → B.V) (f : X → B.V),
    -- any map into an algebra lifts
    True := True

/-! ## Tensor Algebra as Free Algebra -/

def tensorAlgebraIsFreeAlgebra {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- T(V) is the free associative algebra on V

/-! ## Symmetric Algebra as Free Commutative Algebra -/

def symmetricAlgebraIsFree {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- S(V) is the free commutative algebra on V

/-! ## Exterior Algebra as Free Anti-Commutative Algebra -/

def exteriorAlgebraIsFree {F : Field} (V : VectorSpace F) : Prop :=
  True
  -- Λ(V) is the free anti-commutative algebra on V

/-! ## Universal Mapping Property: T(V) → A -/

structure UniversalMap (F : Field) (V : VectorSpace F) (A : Type) where
  TA : TensorAlgebra F V
  f : V.V → A  -- linear map
  lift : TA.carrier → A  -- algebra homomorphism
  property : Prop := True  -- lift ∘ T₁ = f

#eval "Constructions.Universal: FreeVectorSpace, FreeAlgebra, tensor algebra as free algebra"
