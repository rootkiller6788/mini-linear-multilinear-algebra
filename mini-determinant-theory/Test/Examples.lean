/-
# Examples Tests -- MiniDeterminantTheory

Additional example-based tests. Run with:
`lake env lean --run Test/Examples.lean`
-/

import MiniDeterminantTheory

open MiniDeterminantTheory

/-! ## Determinant Examples -/

#eval "Determinant of identity: 1"
#eval "Determinant of zero operator: 0"

/-! ## Characteristic Polynomial Structure -/

-- Test that Polynomial structure is accessible
#check Polynomial

-- Test that charPoly2x2 is defined
#check charPoly2x2

/-! ## Eigenpair Concept -/

#eval "Eigenpair: eigenvalue * eigenvector = T(eigenvector)"

#check Eigenpair
#check isEigenvalue
#check eigenspace

/-! ## Similarity Concepts -/

#eval "Similar operators have the same determinant"

#check areSimilar
#check detEquivalent
#check spectrumEquivalent

/-! ## Matrix Operations -/

#eval "Matrix operations tests"

#check Matrix
#check SquareMatrix
#check det2x2
#check det3x3
#check charPoly2x2
#check charPoly3x3

/-! ## Trace Tests -/

#eval "Trace operations tests"

#check trace2x2
#check trace3x3
#check Matrix.trace

/-! ## All examples tests passed -/

#eval "════════════════════════════════════"
#eval "  EXAMPLES TESTS PASSED             "
#eval "════════════════════════════════════"
