/-
# MiniDualQuotient: Properties — Dimensional

Stub — placeholder for future development.
Dimension properties of dual and quotient spaces.
-/

import MiniDualQuotient.Core.Basic

namespace MiniDualQuotient

/-
TODO: Dimensional properties
- dim(V*) = dim(V) for finite-dimensional V
- dim(V/U) = dim(V) - dim(U)
- dim(U°) = dim(V) - dim(U)
- dim((V/U)*) = dim(V) - dim(U)
- Nullity-rank theorem: dim(ker(T)) + dim(im(T)) = dim(V)
- dim(V**) = dim(V)
-/

/-!
## Dimension Properties (conceptual)

For finite-dimensional vector spaces over F:

  1. dim(V*) = dim(V)
  2. dim(V/U) = dim(V) - dim(U)
  3. dim(U°) = dim(V) - dim(U)
  4. dim(V**) = dim(V)

Nullity-Rank Theorem:
  dim(ker(T)) + dim(im(T)) = dim(domain(T))
-/

def dimensionalProperty (F : Field) (V : VectorSpace F) : String :=
  s!"dim({V.name}*) = dim({V.name})"

#eval "Dimensional property stub"

end MiniDualQuotient
