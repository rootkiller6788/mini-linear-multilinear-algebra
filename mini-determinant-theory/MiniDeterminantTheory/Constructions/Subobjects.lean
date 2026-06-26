/-
# MiniDeterminantTheory: Subobjects

Subobject constructions for determinant theory.
-/

import MiniObjectKernel.Core.Basic
import MiniDeterminantTheory.Core.Basic
import MiniDeterminantTheory.Core.Objects

namespace MiniDeterminantTheory

open MiniObjectKernel

/-! ## Subspace and Restricted Operator

For a linear operator T on V and a subspace U ⊆ V,
the restriction T|_U has a determinant relative to U.
-/

/-! ## Invariant Subspaces

An invariant subspace U satisfies T(U) ⊆ U.
The determinant of T restricted to an invariant subspace
relates to the characteristic polynomial factors.
-/

end MiniDeterminantTheory
