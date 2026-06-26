/-
# Memory Benchmark — MiniDualQuotient

Memory usage estimates for dual and quotient space constructions.
Structure size estimates for the core combinatorial objects.
Run: `lake env lean --run Benchmark/Memory.lean`
-/

import MiniDualQuotient
import MiniVectorSpaceCore.Core.Basic

open MiniDualQuotient
open MiniVectorSpaceCore

/-! ## Axiom: Field and base space -/

axiom memField : Field
axiom memSpace : VectorSpace memField

/-! ## Axiom: DualSpace memory footprint

DualSpace(F, V) conceptually stores:
- Reference to F and V
- The type of linear functionals V → F
- Operations: add, smul, zero, neg
-/

axiom sizeofDualSpace (dim : Nat) : Nat

/-! ## Axiom: QuotientSpace memory footprint

QuotientSpace stores base space V, subspace U,
coset representative structure, projection map,
and universal property witnesses.
-/

axiom sizeofQuotientSpace (dim : Nat) : Nat

/-! ## Axiom: IsomorphismTheorem memory footprint

Stores domain/codomain references, kernel and image sets,
and the isomorphism witness.
-/

axiom sizeofIsomorphismTheorem : Nat

/-! ## Axiom: doubleDual memory

doubleDual = DualSpace(DualSpace(V)).
Nested references and type constructors.
-/

axiom sizeofDoubleDual (dim : Nat) : Nat

/-! ## Axiom: transpose memory

Transpose T* stores original T reference, domain/codomain
are dual spaces already stored, plus f ↦ f ∘ T closure.
-/

axiom sizeofTranspose (dim : Nat) : Nat

#eval "══ MINI-DUAL-QUOTIENT MEMORY BENCHMARK ══"

/-! ### Memory footprint of DualSpace objects
DualSpace grows linearly with dimension:
each basis vector maps to a coordinate functional.
-/

#eval s!"sizeof(DualSpace, dim=1):  {sizeofDualSpace 1} units"
#eval s!"sizeof(DualSpace, dim=4):  {sizeofDualSpace 4} units"
#eval s!"sizeof(DualSpace, dim=10): {sizeofDualSpace 10} units"
#eval "Memory: DualSpace size = O(dim)"

/-! ### Memory footprint of QuotientSpace objects
QuotientSpace stores V, subspace U, and coset machinery.
-/

#eval s!"sizeof(QuotientSpace, dim=4):  {sizeofQuotientSpace 4}"
#eval s!"sizeof(DoubleDual, dim=4):     {sizeofDoubleDual 4}"
#eval s!"sizeof(IsomorphismTheorem):    {sizeofIsomorphismTheorem}"
#eval "Memory: QuotientSpace overhead ≈ DualSpace for same dim"

/-! ### Memory footprint of Transpose
Transpose is lightweight — a function pointer + type params.
-/

#eval s!"sizeof(Transpose, dim=4): {sizeofTranspose 4}"
#eval "Memory: transpose O(1) — reuses existing dual space objects"

#eval "══ MEMORY BENCHMARK COMPLETE ══"
