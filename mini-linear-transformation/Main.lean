/-
# MiniLinearTransformation

Linear transformations package: LinearMap, kernel, image,
rank, nullity, composition, and isomorphism theorems.

Part of the mini-everything-math project.
-/

import MiniLinearTransformation

def main : IO Unit := do
  IO.println "═══════════════════════════════════════"
  IO.println "  MiniLinearTransformation v0.1.0"
  IO.println "  Linear Transformations Sub-Package"
  IO.println "═══════════════════════════════════════"
  IO.println "  LinearMap: structure-preserving maps between vector spaces"
  IO.println "  Kernel: subspace of domain mapped to zero"
  IO.println "  Image: subspace of codomain reached by the map"
  IO.println "  Rank: dimension of the image"
  IO.println "  Nullity: dimension of the kernel"
  IO.println "  Composition: T ∘ S maps through intermediate space"
  IO.println "  Rank-Nullity Theorem: dim(ker T) + dim(im T) = dim(dom T)"
  IO.println "  LinearIsomorphism: invertible linear map with two-sided inverse"
  IO.println ""
  IO.println "  Run `lake env lean --run Test/Smoke.lean` for tests."
