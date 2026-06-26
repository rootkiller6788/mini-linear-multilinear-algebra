/-
# Regression Tests -- MiniDeterminantTheory

Regression tests ensuring no breaking changes.
-/

import MiniDeterminantTheory

open MiniDeterminantTheory

/-! ## Basic Definitions Exist -/

-- Core definitions
#check determinant
#check detIsMultiplicative
#check detOfIdentity
#check detIsInvertible
#check Eigenpair
#check Polynomial
#check charPoly
#check isDiagonalizable
#check cayleyHamilton
#check trace
#check traceIsCyclic

-- Objects
#check Matrix

-- Morphisms
#check DeterminantHom
#check DeterminantHom.id
#check DeterminantHom.comp
#check areSimilar
#check detEquivalent
#check spectrumEquivalent

-- Constructions
#check exteriorPower
#check wedgeProduct
#check laplaceExpansion

-- Examples
#check identityDeterminant
#check zeroDeterminant

/-! ## All regression checks passed -/

#eval "Regression checks complete."
