/-
# MiniDualQuotient: Examples — Reflexivity

Stub — placeholder for future development.
Example: reflexivity of finite-dimensional vector spaces.
-/

import MiniDualQuotient.Core.Basic

namespace MiniDualQuotient

/-
TODO: Reflexivity examples
- Every finite-dimensional V is reflexive: V ≅ V**
- F^n is reflexive
- Polynomial spaces are reflexive (finite-dimensional)
- Non-reflexive example: infinite-dimensional V in functional analysis
- Naturality of canonical embedding
-/

/-!
## Reflexivity Example (conceptual)

A vector space V is reflexive if the canonical embedding
  ev : V → V**,  ev(v)(f) = f(v)
is an isomorphism.

All finite-dimensional vector spaces are reflexive:
  dim(V) = dim(V*) = dim(V**)
so the canonical embedding (injective) is also surjective.

Non-reflexive example: c_0 (sequences converging to 0) with sup norm.
-/

def exampleReflexivity : String := "Reflexivity example stub"

#eval "Reflexivity example stub"

end MiniDualQuotient
