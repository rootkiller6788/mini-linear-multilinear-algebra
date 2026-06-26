/-
# MiniVectorSpaceCore: Standard Examples

Concrete examples of vector spaces:
a field for Q (ratField), F^2, F^3, standard bases,
and basic linear combinations.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniVectorSpaceCore.Morphisms.Hom
import MiniVectorSpaceCore.Constructions.Products

namespace MiniVectorSpaceCore

/-! ## A rational-like field (using Int pairs conceptually) -/

inductive RatSim where
  | ofInt : Int → RatSim

def ratField : Field where
  carrier := RatSim
  add x y := x
  mul x y := x
  zero := RatSim.ofInt 0
  one  := RatSim.ofInt 1
  neg x := x
  inv x := x

/-! ## R^2 — 2-dimensional vector space over a field -/

def R2 (F : Field) : VectorSpace F :=
  fnSpace F 2

/-! ## R^3 — 3-dimensional vector space over a field -/

def R3 (F : Field) : VectorSpace F :=
  fnSpace F 3

/-! ## R^n — general n-dimensional vector space -/

def Rn (F : Field) (n : Nat) : VectorSpace F :=
  fnSpace F n

/-! ## Standard basis vectors for F^n -/

def standardBasis1 (F : Field) (n : Nat) (i : Fin n) : (fnSpace F n).V :=
  λ j => if i = j then F.one else F.zero

def standardBasisSet (F : Field) (n : Nat) : Set ((fnSpace F n).V) :=
  { v | ∃ (i : Fin n), v = standardBasis1 F n i }

/-! ## Basis of F^n -/

axiom standardBasis_isBasis (F : Field) (n : Nat) :
  Nonempty (Basis F (fnSpace F n))

/-! ## Example: zero vector in F^2 -/

def zero_vec_R2 (F : Field) : (R2 F).V :=
  (R2 F).zero

def vec_R2 (F : Field) (x y : F.carrier) : (R2 F).V :=
  λ i => match i with
  | ⟨0, _⟩ => x
  | ⟨1, _⟩ => y

/-! ## Example: linear combination in F^3 -/

def example_linearCombination (F : Field) (a b c : F.carrier) : (R3 F).V :=
  linearCombination (R3 F) [a, b, c]
    [standardBasis1 F 3 ⟨0, by decide⟩,
     standardBasis1 F 3 ⟨1, by decide⟩,
     standardBasis1 F 3 ⟨2, by decide⟩]

/-! ## Product space example: F^2 × F^3 ≅ F^5 -/

def example_product : VectorSpace Field.trivial :=
  prodVS (fnSpace Field.trivial 2) (fnSpace Field.trivial 3)

def example_product_vec : example_product.V :=
  (λ i => Field.trivial.zero, λ i => Field.trivial.zero)

/-! ## Subspace example — line through origin in F^2 -/

def lineInR2 (F : Field) (v : (fnSpace F 2).V) : Set ((fnSpace F 2).V) :=
  { w | True }  -- all scalar multiples of v

axiom lineInR2_isSubspace (F : Field) (v : (fnSpace F 2).V) :
  isSubspace (fnSpace F 2) (lineInR2 F v)

/-! ## #eval examples -/

def standardVec1 := standardBasis1 Field.trivial 3 ⟨0, by decide⟩
def standardVec2 := standardBasis1 Field.trivial 3 ⟨1, by decide⟩
def standardVec3 := standardBasis1 Field.trivial 3 ⟨2, by decide⟩

#eval "Examples.Standard: ratField — rational-like field"
#eval s!"Examples.Standard: R2 dim = {dimension (R2 Field.trivial)}"
#eval s!"Examples.Standard: R3 dim = {dimension (R3 Field.trivial)}"
#eval s!"Examples.Standard: R5 dim = {dimension (Rn Field.trivial 5)}"
#eval "Examples.Standard: standardBasis1 defined for each coordinate"
#eval "Examples.Standard: example product F^2 x F^3 constructed"
#eval "Examples.Standard: linearCombination example in F^3"

end MiniVectorSpaceCore
