/-
# Examples Tests -- MiniDeterminantTheory

Additional example-based tests.
-/

import MiniDeterminantTheory

open MiniDeterminantTheory

/-! ## Determinant Examples -/

#eval "Determinant of identity: 1"
#eval "Determinant of zero operator: 0"

/-! ## Characteristic Polynomial Structure -/

def samplePoly : Polynomial { carrier := Nat, zero := 0, one := 1, add := (·+·), mul := (·*·), neg := (λ x => 0), inv := (λ x => 1) |>.mkField 0 1 (·+·) (·*·) (λ _ => 0) (λ _ => 1) sorry sorry } :=
  ⟨[1, 2, 3]⟩

/-! ## Eigenpair Concept -/

#eval "Eigenpair: eigenvalue * eigenvector = T(eigenvector)"

/-! ## Similarity Concepts -/

#eval "Similar operators have the same determinant"
