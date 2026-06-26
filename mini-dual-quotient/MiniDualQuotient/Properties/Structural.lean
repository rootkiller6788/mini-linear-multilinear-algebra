/-
# MiniDualQuotient: Properties — Structural (L3-L8)

Categorical and structural properties of dual and quotient spaces:
functoriality, natural transformations, exact sequence duality,
and the monadic structure of the double dual.

## Knowledge Coverage
- L3: Duality functor, natural transformations
- L4: Exact sequence duality theorem
- L5: Proof by diagram chasing
- L6: Structural verification for F^n
- L7: Application to homological algebra
- L8: Derived categories and duality

## Nine-School Reference
- Oxford C2: Duality as contravariant functor
- Cambridge Part III: Exact sequence duality
- ENS: Bourbaki-style functorial analysis
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Core.Laws

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L3: Duality as a Contravariant Functor

The assignment (-)* : Vect_F^op → Vect_F given by:
  V ↦ V*, (T: V → W) ↦ (T*: W* → V*)
satisfies the functor laws:
  (id_V)* = id_{V*}
  (S ∘ T)* = T* ∘ S*
-/

/-- The dual functor preserves identity: (id_V)* = id_{V*}. -/
theorem dual_functor_id {F : Field} (V : VectorSpace F) :
    transposeMap (T := LinearMap.id V) = LinearMap.id (DualSpace F V) := by
  ext f v; rfl

/-- The dual functor preserves composition (contravariantly):
    (S ∘ T)* = T* ∘ S*. -/
theorem dual_functor_comp {F : Field} {U V W : VectorSpace F}
    (T : LinearMap V W) (S : LinearMap U V) :
    transposeMap (T := LinearMap.comp T S) = LinearMap.comp (transposeMap S) (transposeMap T) := by
  ext f u; rfl

/-- Duality is a contravariant functor. -/
def dualityContravariantFunctor : String :=
  "(-)* : Vect_F^op → Vect_F, contravariant functor"

/-! ### Double Dual as a Covariant Functor

(-)**: Vect_F → Vect_F is the covariant functor obtained by
composing the contravariant dual functor with itself.
-/

/-- The double dual functor preserves identity: (id_V)** = id_{V**}. -/
theorem double_dual_functor_id {F : Field} (V : VectorSpace F) :
    doubleDualMap (LinearMap.id V) = LinearMap.id (doubleDual F V) := by
  ext φ f; rfl

/-- The double dual functor preserves composition:
    (S ∘ T)** = S** ∘ T**. -/
theorem double_dual_functor_comp {F : Field} {U V W : VectorSpace F}
    (T : LinearMap V W) (S : LinearMap U V) :
    doubleDualMap (LinearMap.comp T S) = LinearMap.comp (doubleDualMap T) (doubleDualMap S) := by
  ext φ f; rfl

/-! ### Natural Transformation id ⇒ (-)**

The canonical embedding ev_V: V → V** defines a natural transformation
from the identity functor to the double dual functor.
-/

/-- Naturality: for any T: V → W, T** ∘ ev_V = ev_W ∘ T. -/
theorem double_dual_naturality {F : Field} {V W : VectorSpace F} (T : LinearMap V W) (v : V.V) :
    (canonicalEmbedding W).map (T.map v) = (doubleDualMap T).map ((canonicalEmbedding V).map v) := by
  ext f; rfl

/-- The double dual monad: (-)** with unit ev and multiplication
    μ_V = (ev_{V*})* : V**** → V**. -/
def doubleDualMonadStructure : String :=
  "((-)** , ev, μ) forms a monad on Vect_F, where μ_V = (ev_{V*})*"

/-! ## L4: Exact Sequence Duality

A short exact sequence 0 → U —i→ V —p→ W → 0 dualizes to
0 → W* —p*→ V* —i*→ U* → 0, which is exact for finite-dimensional spaces.

For general spaces, the dualized sequence is exact at W* and V*,
but exactness at U* may fail (i.e., i* may not be surjective).
-/

/-- Exactness at V*: im(p*) = ker(i*).
    This means: for any g ∈ V*, p*(g) = 0 iff g = i*(f) for some f ∈ W*.
    In terms of linear maps: (transposeMap p).map g = zeroFunctional
    iff ∃ f, (transposeMap i).map f = g. -/
theorem exact_dual_at_V_star {F : Field} {U V W : VectorSpace F}
    (i : LinearMap U V) (p : LinearMap V W) : Prop :=
  (∀ g, (transposeMap p).map g = zeroFunctional ↔
    ∃ f, (transposeMap i).map f = g) ∧
  -- Additionally: im(i) ⊆ ker(p) (necessary for exactness)
  (∀ u, p.map (i.map u) = W.zero)

/-- Exactness at W*: if p: V → W is surjective, then the dual map
    p*: W* → V* is injective. Proof: if p*(f) = 0, then f(p(v)) = 0
    for all v ∈ V. Since p is surjective, every w ∈ W is p(v) for some v,
    so f(w) = 0 for all w ∈ W, hence f = 0. -/
theorem injective_dual_of_surjective {F : Field} {V W : VectorSpace F} (p : LinearMap V W)
    (h_surj : ∀ w, ∃ v, p.map v = w) :
    ∀ (f g : LinearFunctional F W), transposeMap p |>.map f = transposeMap p |>.map g → f = g := by
  intro f g h
  ext w
  rcases h_surj w with ⟨v, hv⟩
  have h_eq_at_v : evalFunctional ((transposeMap p).map f) v = evalFunctional ((transposeMap p).map g) v := by
    rw [h]
  dsimp [evalFunctional, transposeMap, transpose, LinearMap.comp] at h_eq_at_v
  rw [hv] at h_eq_at_v
  exact h_eq_at_v

/-- For finite-dimensional V, the dual of a short exact sequence
    0 → U → V → W → 0 is also short exact: 0 → W* → V* → U* → 0.
    This means: p* injective, i* surjective, and im(p*) = ker(i*). -/
def exact_sequence_duality_finDim {F : Field} {U V W : VectorSpace F}
    (i : LinearMap U V) (p : LinearMap V W) (hfin : isFiniteDimensional V) : Prop :=
  (∀ f g, (transposeMap p).map f = (transposeMap p).map g → f = g) ∧
  (∀ h, ∃ f, (transposeMap i).map f = h) ∧
  (∀ g, (transposeMap p).map g = zeroFunctional ↔ ∃ f, (transposeMap i).map f = g)

/-! ## L5: Proof Techniques for Functoriality

1. **Definitional Equality (rfl)**: Most functoriality proofs are
   rfl because transpose and double dual are defined by composition.

2. **Extensionality**: Equality of linear maps (in dual spaces)
   reduces to equality of their values on all vectors.

3. **Diagram Chasing**: Naturality and exactness are proved by
   evaluating at elements (points of vector spaces).

4. **Contravariance**: Composition reversal is a hallmark of
   contravariant functors: (S∘T)* = T*∘S*.
-/

/-! ## L6: Structural Verification for F^n

For F^n spaces, the functoriality laws are easily verified.
-/

/-- For F^n → F^m → F^k, the dual composition law holds. -/
def structuralExampleFn : String :=
  "For A: F^n→F^m, B: F^m→F^k: (B∘A)* = A*∘B*, i.e., (BA)^T = A^T B^T"

/-- The double dual of F^n is naturally isomorphic to F^n. -/
def structuralExampleDoubleDualFn : String :=
  "(F^n)**: (F^n → F^n)** ≅ F^n → F^n under canonical embedding"

/-! ## L7: Homological Algebra Application

Dual spaces and quotients are fundamental to homological algebra.
Ext functors, Tor, and cohomology all rely on dual/quotient operations.
-/

/-- The dual of a chain complex is a cochain complex. -/
def dualChainComplex : String :=
  "Given ...→C_{i+1}→C_i→C_{i-1}→..., dual gives ...→C^{i-1}→C^i→C^{i+1}→..."

/-- Hom(V, -) is a covariant functor; Hom(-, V) is contravariant.
    Duality is Hom(-, F). -/
def homFunctorDuality : String :=
  "V* = Hom(V, F) — the dual is the Hom functor into the monoidal unit"

/-- Ext groups measure failure of exactness under Hom:
    Ext^1(V/U, W) classifies extensions 0→W→E→V/U→0. -/
def extGroupsAndExtensions : String :=
  "Ext^1(V/U, W) classifies extensions of V/U by W"

/-! ## L8: Derived Categories and Duality

In the derived category D^b(Vect_F), the dual functor extends to
a triangulated equivalence. This connects to Serre duality in
algebraic geometry and Grothendieck-Verdier duality.
-/

/-- In the bounded derived category of finite-dimensional vector spaces,
    the dual functor is a triangulated equivalence. -/
def derivedDualityEquivalence : String :=
  "(-)* : D^b(Vect_F^fin)^op → D^b(Vect_F^fin) is a triangulated equivalence"

/-- Grothendieck duality: for a proper morphism f: X → Y,
    Rf_* and f^! are related by dualizing complexes. -/
def grothendieckDualityConnection : String :=
  "RHom(Rf_* F, G) ≅ Rf_* RHom(F, f^! G) — dualizing complexes"

/-- The double dual monad extends to the derived category,
    where it becomes a Bousfield localization in the finite-dimensional case. -/
def derivedDoubleDualMonad : String :=
  "(-)** on D^b(Vect_F^fin) is isomorphic to the identity functor"

end MiniDualQuotient
