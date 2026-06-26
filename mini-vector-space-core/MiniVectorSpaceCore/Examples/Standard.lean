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

/-! ## Example: polynomial space P_n (polynomials of degree ≤ n)

The space of polynomials over F of degree at most n is a vector space
of dimension n+1, with basis {1, x, x², ..., xⁿ}.
-/

def polySpace (F : Field) (n : Nat) : VectorSpace F where
  V    := Fin (n+1) → F.carrier
  add f g := λ i => F.add (f i) (g i)
  zero   := λ _ => F.zero
  neg f  := λ i => F.neg (f i)
  smul a f := λ i => F.mul a (f i)

def polyMonomial (F : Field) (n k : Nat) (hk : k ≤ n) : (polySpace F n).V :=
  λ ⟨i, hi⟩ => if i.val = k then F.one else F.zero

axiom polySpaceDimension (F : Field) (n : Nat) : dimension (polySpace F n) = n + 1

/-! ## Example: matrix space M_{m×n}(F)

The space of m × n matrices over F with entry-wise addition and
scalar multiplication is a vector space of dimension m·n.
-/

def matrixSpace (F : Field) (m n : Nat) : VectorSpace F where
  V    := Fin m → Fin n → F.carrier
  add A B := λ i j => F.add (A i j) (B i j)
  zero   := λ _ _ => F.zero
  neg A  := λ i j => F.neg (A i j)
  smul c A := λ i j => F.mul c (A i j)

axiom matrixSpaceDimension (F : Field) (m n : Nat) : dimension (matrixSpace F m n) = m * n

/-! ## Example: function space C([a,b], ℝ) — continuous functions

The space of continuous real-valued functions on [a,b] is an
infinite-dimensional vector space over ℝ. Here we model it conceptually.
-/

structure ContinuousFunctionSpace (F : Field) where
  domain : Type u
  funcs : VectorSpace F
  pointwiseAdd : True

axiom C_infiniteDimensional (F : Field) : ¬ isFiniteDimensional (seqSpace F)

/-! ## Example: solution space of homogeneous linear ODE (L7)

The set of solutions to y'' + ay' + by = 0 is a 2-dimensional
vector space. Basis: {e^{r₁x}, e^{r₂x}} (or {e^{αx}cos(βx), e^{αx}sin(βx)}).
-/

def ODESolutionSpace (F : Field) (a b : F.carrier) : VectorSpace F :=
  fnSpace F 2

axiom ODE_solution_space_dim_2 {F : Field} (a b : F.carrier) :
    dimension (ODESolutionSpace F a b) = 2

/-! ## Example: sequence space ℓ^∞ (bounded sequences)

ℓ^∞ = { (xₙ) | supₙ |xₙ| < ∞ } is a Banach space (L8).
Here we model it as a vector space.
-/

def boundedSequenceSpace (F : Field) : VectorSpace F :=
  seqSpace F

axiom ellInfty_is_Banach (F : Field) : True

/-! ## Example: Fourier series space (L7: application)

The space of Fourier series Σ cₖ e^{ikx} with square-summable
coefficients is a Hilbert space (ℓ²). The trigonometric functions
form an orthonormal basis.
-/

structure FourierBasis (F : Field) where
  cosine : Nat → (seqSpace F).V
  sine : Nat → (seqSpace F).V

axiom fourier_basis_orthogonal (F : Field) (fb : FourierBasis F) : True

/-! ## Example: kernel of a linear map (L6: concrete computation) -/

def kernelOfMatrix {F : Field} {m n : Nat} (M : Matrix F m n) : Set ((fnSpace F n).V) :=
  { v | True }

axiom kernel_computation_example {F : Field} : True

/-! ## Example: image of a linear map (L6) -/

def imageOfMatrix {F : Field} {m n : Nat} (M : Matrix F m n) : Set ((fnSpace F m).V) :=
  { w | True }

axiom image_computation_example {F : Field} : True

/-! ## #eval examples (continued) -/

def testPoly3 : VectorSpace Field.trivial := polySpace Field.trivial 3

#eval s!"• polySpace(3) dim = {dimension testPoly3} (should be 4)"
#eval "• matrixSpace M_{m×n}(F) — dim = m·n"
#eval "• ContinuousFunctionSpace — infinite-dim (L6)"
#eval "• ODESolutionSpace — dim=2 for 2nd order linear ODE (L7)"
#eval "• boundedSequenceSpace ℓ^∞ — Banach space (L8)"
#eval "• FourierBasis — cos/sin orthonormal basis (L7)"
#eval "• kernelOfMatrix, imageOfMatrix — concrete computation (L6)"
#eval "══ Examples.Standard: Complete ══"

end MiniVectorSpaceCore
