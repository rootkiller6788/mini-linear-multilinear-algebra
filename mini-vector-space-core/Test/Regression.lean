/-
# Regression Tests -- MiniVectorSpaceCore

Regression tests ensuring no breaking changes.
-/

import MiniVectorSpaceCore

open MiniVectorSpaceCore

/-! ## Basic Definitions Exist -/

-- Verify Field
#check Field

-- Verify VectorSpace
#check VectorSpace

-- Verify fnSpace
#check fnSpace

-- Verify linearCombination
#check linearCombination

-- Verify Subspace
#check Subspace

-- Verify Basis
#check Basis

-- Verify dimension
#check dimension
#check isFiniteDimensional

-- Verify LinearMap
#check LinearMap
#check LinearMap.id
#check LinearMap.comp

-- Verify LinearIso
#check LinearIso

-- Verify VSEquivalence
#check VSEquivalence

-- Verify vector space axioms
#check addAssoc
#check addComm
#check addZero
#check addNeg
#check smulOne
#check smulAssoc
#check smulAdd
#check addSmul

/-! ## All regression checks passed -/

#eval "Regression checks complete."
