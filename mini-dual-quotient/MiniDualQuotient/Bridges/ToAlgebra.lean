/-
# MiniDualQuotient: Bridges — ToAlgebra (L7-L8)

Connects dual and quotient spaces to algebraic structures:
module theory, semisimple algebras, Frobenius algebras,
and representation theory.

## Knowledge Coverage
- L7: Application to module theory and representation theory
- L8: Frobenius algebras and self-duality
-/

import MiniDualQuotient.Core.Basic

namespace MiniDualQuotient

/-! ## Module Theory

Vector spaces are modules over a field F. Many dual/quotient
constructions generalize to modules over any ring R.
-/

/-- For an R-module M, the dual M* = Hom_R(M, R) is an R-module.
    The transpose and double dual constructions carry over. -/
def module_dual_generalization : String :=
  "M* = Hom_R(M, R) for any ring R (module dual)"

/-- For modules over a PID, the structure theorem decomposes
    finitely generated modules into cyclic summands.
    The dual of a cyclic module R/(a) is ann_{(a)}(R). -/
def pid_module_dual : String :=
  "For R a PID, (R/(a))* ≅ R/(a) (self-dual cyclic modules)"

/-- Injective modules are dual to projective modules.
    For a field F, every module is both injective and projective.
    For general rings, this fails. -/
def injective_projective_dual : String :=
  "Over a field F, every module is injective and projective (vector space property)"

/-! ## Semisimple Algebras

A finite-dimensional algebra A over F is semisimple iff
A ≅ ⊕_i M_{n_i}(D_i) (Wedderburn's theorem).
-/

/-- For a semisimple algebra A = ⊕ End(V_i), the dual A* ≅ A
    as A-bimodules via the trace pairing ⟨a, b⟩ = tr(ab). -/
def semisimple_algebra_dual : String :=
  "Semisimple A: A* ≅ A as A-bimodules (trace pairing)"

/-- The regular representation of a finite group G over F
    decomposes as F[G] ≅ ⊕_ρ (dim ρ) · V_ρ.
    The dual representation gives V_ρ* with character χ̄_ρ. -/
def group_algebra_dual : String :=
  "F[G]* ≅ F[G] for finite G when char F ∤ |G| (Maschke + trace)"

/-! ## Frobenius Algebras

A Frobenius algebra is a finite-dimensional algebra A equipped
with a nondegenerate bilinear form ⟨a,b⟩ = tr(λ_a ∘ λ_b)
satisfying ⟨ab, c⟩ = ⟨a, bc⟩.
-/

/-- A Frobenius algebra A has A ≅ A* as left A-modules.
    The isomorphism is a ↦ ⟨a, -⟩. -/
def frobenius_algebra_self_dual : String :=
  "Frobenius algebra: A ≅ A* as left A-modules (self-duality)"

/-- Examples of Frobenius algebras:
    - F[G] (group algebra of a finite group)
    - H*(M; F) (cohomology ring of a closed manifold)
    - Matrix algebras M_n(F) -/
def frobenius_examples : String :=
  "Frobenius algebras: F[G], H*(M;F), M_n(F), finite-dimensional Hopf algebras"

/-- For a Frobenius algebra, the Nakayama automorphism ν: A → A
    measures the failure of symmetry of the Frobenius form:
    ⟨a, b⟩ = ⟨b, ν(a)⟩. -/
def nakayama_automorphism : String :=
  "Nakayama automorphism ν: ⟨a,b⟩ = ⟨b,ν(a)⟩ (measuring non-symmetry)"

/-! ## Quotients in Ring Theory

Quotient spaces V/U generalize to quotient modules M/N
and quotient rings R/I.
-/

/-- The three isomorphism theorems for rings are identical
    in form to those for vector spaces.
    V/ker(φ) ≅ im(φ) → R/ker(φ) ≅ im(φ) for ring hom φ. -/
def ring_isomorphism_theorems : String :=
  "Ring iso theorems: R/I ≅ im(φ) for φ: R → S (I = ker φ)"

/-- For a Lie algebra g, the quotient g/[g,g] is the abelianization,
    analogous to V/[V,V] (which is just V since V is abelian). -/
def lie_algebra_quotient : String :=
  "g/[g,g] = abelianization of Lie algebra (quotient by derived subalgebra)"

/-! ## Pontryagin Duality

For locally compact abelian groups, there is a duality G ↔ Ĝ
(Pontryagin duality), where Ĝ = Hom(G, S¹).
For finite abelian groups, Ĝ ≅ G.
For vector spaces over F_p, the dual is the same as the algebraic dual.
-/

/-- Pontryagin duality: for a finite abelian group G, Ĝ ≅ G.
    For F_p-vector spaces, this is the algebraic dual. -/
def pontryagin_duality : String :=
  "Ĝ = Hom(G, S¹); for finite G, Ĝ ≅ G; for F_p-vector spaces, ĝ = algebraic dual"

end MiniDualQuotient
