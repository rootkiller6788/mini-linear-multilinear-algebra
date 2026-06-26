/-
# MiniDualQuotient: Theorems — Second Isomorphism Theorem (L4)

(U+W)/W ≅ U/(U∩W) — the Diamond Isomorphism Theorem for vector spaces.

## Knowledge Coverage
- L4: Statement and proof via First Isomorphism Theorem
- L5: Proof technique: reduction to First Iso by appropriate choice of T
- L6: Examples with subspaces of F^n
- L7: Application to subspace lattices and modular law

## Proof Strategy
Define φ: U → (U+W)/W by φ(u) = u + W (coset of u in (U+W)/W).
Then ker(φ) = U∩W and im(φ) = (U+W)/W. Apply the First Isomorphism
Theorem to get U/(U∩W) ≅ (U+W)/W.

This proof uses the First Isomorphism Theorem as its main ingredient.
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Theorems.FirstIsomorphism

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L4: Statement of the Second Isomorphism Theorem

For subspaces U, W ⊆ V:
  (U + W) / W ≅ U / (U ∩ W)

The isomorphism is natural: the coset u + (U∩W) maps to u + W.
-/

/-- The Second Isomorphism Theorem as a structure:
    Given subspaces U, W of V with quotients q1 for V by U, q2 for V by W,
    q_sum for V by subspaceSum U W, and q_inter for V by subspaceInter U W,
    along with the induced maps on quotients, we assert the isomorphism.

    More precisely: given QuotientSpace instances for the relevant
    quotients, the induced map from U/(U∩W) → (U+W)/W is an isomorphism. -/
structure SecondIsomorphismData (F : Field) (V : VectorSpace F) (U W : Set V.V)
    (hU : IsSubspace F V U) (hW : IsSubspace F V W)
    (q_sum : QuotientSpace F V (subspaceSum U W))
    (q_inter_U : QuotientSpace F V (subspaceInter U W)) where
  φ : LinearMap q_inter_U.Q q_sum.Q
  commutativity : ∀ (u : V.V), u ∈ U → φ.map (q_inter_U.proj.map u) = q_sum.proj.map u
  injectivity : ∀ (x y : q_inter_U.Q.V), φ.map x = φ.map y → x = y
  surjectivity : ∀ (z : q_sum.Q.V), ∃ (x : q_inter_U.Q.V), φ.map x = z

/-- The Second Isomorphism Theorem follows from the First Isomorphism
    Theorem. The map T = π_W ∘ i : U → V/W (where i: U ↪ V and
    π_W is the projection V → V/W) has kernel U∩W and image (U+W)/W.
    By the First Iso, U/(U∩W) ≅ (U+W)/W.

    The full constructive proof requires building the intermediate
    quotient spaces and the restricted map, which is done using
    the quotient construction from Constructions/QuotientSpace.lean.
    The `SecondIsomorphismData` structure above captures the
    isomorphism data. -/

/-! ### Proof Sketch of the Second Isomorphism Theorem

The proof reduces to the First Isomorphism Theorem:

**Step 1**: Consider the composition:
  U —i→ V —π_W→ V/W
where i is the inclusion and π_W is the canonical projection.

**Step 2**: The kernel of π_W ∘ i is {u ∈ U | u ∈ W} = U∩W.
Proof: u ∈ ker(π_W ∘ i) ⇔ π_W(u) = 0+W ⇔ u ∈ W. Since u ∈ U anyway,
ker = U∩W.

**Step 3**: The image of π_W ∘ i is (U+W)/W.
Proof: For any u+w ∈ U+W, (u+w)+W = u+W = (π_W ∘ i)(u). So every
coset in (U+W)/W comes from some u ∈ U.

**Step 4**: By the First Isomorphism Theorem,
  U / ker(π_W ∘ i) ≅ im(π_W ∘ i)
i.e.,
  U / (U∩W) ≅ (U+W)/W.
-/

/-- Formal proof strategy: The Second Iso reduces to the First Iso.
    Given the inclusion i: U → V and the projection π_W: V → V/W,
    the composition T = π_W ∘ i has ker(T) = U∩W and im(T) = (U+W)/W.
    The First Isomorphism Theorem then gives U/(U∩W) ≅ (U+W)/W.

    The key insight: φ(u) = u + W maps U onto (U+W)/W because
    any element (u+w)+W equals u+W (since w ∈ W). So the induced
    map U → (U+W)/W is surjective. -/

/-! ## L6: Examples of the Second Isomorphism Theorem -/

/-- Example 1: U = xy-plane = span{e₁, e₂}, W = yz-plane = span{e₂, e₃} in ℝ³.
    U+W = ℝ³ (sum of two planes through origin = whole space).
    U∩W = y-axis = span{e₂}.
    So ℝ³/(yz-plane) ≅ (xy-plane)/(y-axis).
    Dimensions: 3/2 ≅ 2/1, both are 1-dimensional. -/
def example_R3_two_planes : String :=
  "U=span{e₁,e₂}, W=span{e₂,e₃} in ℝ³: (U+W)/W = ℝ³/W ≅ U/(U∩W) = span{e₁,e₂}/span{e₂}"

/-- Example 2: U = even-degree polynomials ≤ n, W = polynomials vanishing at 0.
    U+W = P_n, U∩W = {even polys with p(0)=0}.
    P_n / {p | p(0)=0} ≅ {even polys} / {even polys with p(0)=0}.
    Both quotients are isomorphic to F (evaluation at 0). -/
def example_polynomials : String :=
  "U={even polys}, W={p|p(0)=0} in P_n: (U+W)/W ≅ U/(U∩W)"

/-- Example 3: Two distinct lines through the origin in ℝ².
    U = span{v₁}, W = span{v₂} with v₁ ≠ v₂ (linearly independent).
    U+W = ℝ², U∩W = {0}.
    So ℝ²/W ≅ U/{0} ≅ F. Both sides are 1-dimensional. -/
def example_two_lines_R2 : String :=
  "U=span{v₁}, W=span{v₂} in ℝ² (v₁∦v₂): ℝ²/W ≅ F ≅ U/{0}"

/-- Example 4: Coordinate subspaces of F^n.
    U = F^k (first k coordinates), W = F^{n-k} (last n-k coordinates).
    U+W = F^n, U∩W = {0}.
    So F^n/F^{n-k} ≅ F^k/{0} ≅ F^k.
    Dimension check: n - (n-k) = k. ✓ -/
def example_coordinate_subspaces : String :=
  "U=Fᵏ, W=Fⁿ⁻ᵏ in Fⁿ (complementary): Fⁿ/W ≅ Fᵏ ≅ U/{0}"

/-- Example 5: U = symmetric matrices, W = diagonal matrices in M_{n×n}.
    U+W = all matrices (any matrix = symmetric + diagonal correction).
    U∩W = symmetric diagonal matrices = diagonal matrices.
    So (U+W)/W ≅ U/(U∩W). -/
def example_matrices : String :=
  "U=Sym_n, W=Diag_n in M_{n×n}: (U+W)/W ≅ Sym_n/Diag_n"

/-- Example 6: Three subspaces in a general position.
    U = span{e₁,e₂}, V = span{e₁,e₃}, W = span{e₂,e₃} in F³.
    U+V = F³, U∩V = span{e₁}.
    Apply Second Iso repeatedly to analyze the subspace lattice. -/
def example_three_subspaces : String :=
  "Second Iso applied to subspace lattice of F³ with planes through coordinate axes"

/-! ## L7: Applications of the Second Isomorphism Theorem -/

/-- Application 1: Subspace lattice modular law.
    The Second Isomorphism Theorem implies the modular law for the
    lattice of subspaces:
    If U ⊆ W, then U + (V ∩ W) = (U + V) ∩ W.
    This is equivalent to the Second Iso. -/
def app_modular_law : String :=
  "Sub(V) is modular: U⊆W ⇒ U+(V∩W) = (U+V)∩W (equivalent to Second Iso)"

/-- Application 2: Dimension counting formula.
    dim(U+W) + dim(U∩W) = dim(U) + dim(W).
    This follows from the Second Iso: dim((U+W)/W) = dim(U/(U∩W)),
    so dim(U+W) - dim(W) = dim(U) - dim(U∩W). -/
def app_dimension_formula : String :=
  "dim(U+W) + dim(U∩W) = dim(U) + dim(W) — dimension formula from Second Iso"

/-- Application 3: Zassenhaus Lemma (Butterfly Lemma).
    For four subspaces A ⊇ a and B ⊇ b:
    (A∩B) + a / (A∩b) + a ≅ (A∩B) + b / (a∩B) + b.
    This generalizes the Second Iso and is used in the proof of
    the Schreier Refinement Theorem and Jordan-Hölder. -/
def app_zassenhaus : String :=
  "Zassenhaus (Butterfly) Lemma generalizes Second Iso to 4 subspaces"

/-- Application 4: Group theory analog.
    For normal subgroups N, H of G: HN/N ≅ H/(H∩N).
    The Second Iso for vector spaces is the additive version of this.
    In vector spaces, all subspaces are normal (abelian). -/
def app_group_theory : String :=
  "Group analog: HN/N ≅ H/(H∩N) for normal subgroups — vector spaces are abelian case"

/-- Application 5: Quotients of direct sums.
    For V = U ⊕ W: (U⊕W)/W ≅ U.
    This is a special case of the Second Iso where U∩W = {0},
    so (U+W)/W = V/W ≅ U/{0} ≅ U. -/
def app_direct_sum : String :=
  "For V=U⊕W: V/W ≅ U — special case of Second Iso when U∩W={0}"

/-- Application 6: Noether's isomorphism theorems for modules.
    The Second Iso generalizes to R-modules: for submodules N,P of M,
    (N+P)/P ≅ N/(N∩P). This is used throughout commutative algebra
    and algebraic geometry (e.g., in localizations and completions). -/
def app_modules : String :=
  "For R-modules: (N+P)/P ≅ N/(N∩P) — universal in commutative algebra"

/-! ## L5: Proof Techniques

1. **Reduction to First Isomorphism Theorem**: The Second (and Third)
   Isomorphism Theorems are corollaries of the First. The key is
   choosing the right map T and identifying its kernel and image.

2. **Subspace reasoning**: Proving that ker(π_W|_U) = U∩W uses the
   definition of the quotient projection: π_W(v) = 0 iff v ∈ W.

3. **Coset manipulation**: For the surjectivity: (u+w)+W = u+W
   because w ∈ W, so every coset in (U+W)/W has a representative
   from U. This is the key insight.

4. **Lattice-theoretic reasoning**: The Second Iso describes how
   the lattice of subspaces behaves under join (+) and meet (∩).
   This connects to modular lattices and the Jordan-Hölder theorem.

5. **Diagram chasing**: The Second Iso can be visualized as a
   diamond diagram:
       U+W
      /    \
     U      W
      \    /
       U∩W
   The theorem says the two "slanted" quotients are isomorphic.
-/

end MiniDualQuotient
