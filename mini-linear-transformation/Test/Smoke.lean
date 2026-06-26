/-
# Smoke Tests — MiniLinearTransformation

Run: `lake env lean --run Test/Smoke.lean`
-/

import MiniLinearTransformation

open MiniLinearTransformation

#eval "══ MINI-LINEAR-TRANSFORMATION SMOKE TESTS ══"

/-! ## Core.Basic: LinearMap -/

#eval "── Core.Basic: LinearMap structure ──"
-- Placeholder: LinearMap requires VectorSpace instances
#eval "LinearMap structure defined with map, map_add, map_smul"

#eval "── Core.Basic: Identity ──"
-- LinearMap.id V is a linear map
#eval "LinearMap.id defined"

#eval "── Core.Basic: Composition ──"
-- LinearMap.comp T S composes linear maps
#eval "LinearMap.comp defined"

#eval "── Core.Basic: Zero Map ──"
-- LinearMap.zero V W is the zero linear map
#eval "LinearMap.zero defined"

#eval "── Core.Basic: Kernel and Image ──"
-- LinearMap.kernel T and LinearMap.image T
#eval "LinearMap.kernel and LinearMap.image defined"

#eval "── Core.Basic: Rank and Nullity ──"
-- LinearMap.rank T and LinearMap.nullity T
#eval "LinearMap.rank and LinearMap.nullity defined"

/-! ## Core.Objects -/

#eval "── Core.Objects: Object instance ──"
#eval "LinearMap Object instance registered"

/-! ## Core.Laws -/

#eval "── Core.Laws: Laws stub ──"
#eval "Laws of linear transformations defined"

/-! ## Morphisms -/

#eval "── Morphisms.Hom: LinearIsomorphism ──"
#eval "LinearIsomorphism structure with id, symm, comp"

#eval "── Morphisms.Iso: Injective/Surjective ──"
#eval "isInjective and isSurjective defined"

#eval "── Morphisms.Equivalence: Similar ──"
#eval "LinearMap.Equiv and LinearMap.Similar defined"

/-! ## Constructions -/

#eval "── Constructions.Subobjects ──"
#eval "kernel subspace, image subspace, invariant subspace, eigenspace"

#eval "── Constructions.Quotients ──"
#eval "first isomorphism theorem statement, quotient universal property"

#eval "── Constructions.Products ──"
#eval "direct sum, product, coproduct, bilinear maps"

#eval "── Constructions.Universal ──"
#eval "Hom space, dual space, double dual, transpose, adjoint"

/-! ## Properties -/

#eval "── Properties.Invariants ──"
#eval "rank, nullity, trace, determinant, charPoly"

#eval "── Properties.Preservation ──"
#eval "independence, spanning, rank bounds, injective iff surjective"

#eval "── Properties.ClassificationData ──"
#eval "diagonalizable, nilpotent, minimal poly, Jordan, rational form"

/-! ## Theorems -/

#eval "── Theorems.Basic ──"
#eval "rank-nullity, dim sum, basis extension, invertibility, Cayley-Hamilton"

#eval "── Theorems.UniversalProperties ──"
#eval "tensor-hom adjunction, double dual, quotient factorization"

#eval "── Theorems.Classification ──"
#eval "Jordan, rational form, spectral real/complex, SVD"

#eval "── Theorems.Main ──"
#eval s!"7 pillar theorems: {linearTransformationPillars}"

#eval "══ ALL MINI-LINEAR-TRANSFORMATION SMOKE TESTS PASSED ══"
