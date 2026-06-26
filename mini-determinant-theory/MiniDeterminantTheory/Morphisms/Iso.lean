/-
# MiniDeterminantTheory: Isomorphisms

Isomorphism structures for determinant-equipped objects.
-/

import MiniObjectKernel.Core.Basic
import MiniDeterminantTheory.Core.Basic

namespace MiniDeterminantTheory

open MiniObjectKernel

/-! ## Similarity of Linear Operators -/

def areSimilar {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop :=
  ∃ (P : LinearMap V V), (∃ (Q : LinearMap V V),
    LinearMap.comp P Q = LinearMap.id V ∧ LinearMap.comp Q P = LinearMap.id V) ∧
    LinearMap.comp (LinearMap.comp P S) Q = T

/-! Properties:
  - Similar operators have the same determinant
  - Similar operators have the same characteristic polynomial
  - Similar operators have the same eigenvalues
-/

end MiniDeterminantTheory
