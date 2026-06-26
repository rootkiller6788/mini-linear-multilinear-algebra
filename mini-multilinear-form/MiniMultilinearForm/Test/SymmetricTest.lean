import MiniMultilinearForm.Core.Basic
import MiniMultilinearForm.Symmetric.Basic

namespace MiniMultilinearForm.Test

open MiniMultilinearForm

variable {F : Field}

/-- Test Gram matrix symmetry. -/
theorem test_gramMatrix_symmetric (B : SymmetricBilinearForm (fnSpace F 2)) (vs : Fin 3 -> (fnSpace F 2).V) :
    forall i j, gramMatrix 3 B vs i j = gramMatrix 3 B vs j i :=
  gramMatrix_symmetric 3 B vs

/-- Test hyperbolic plane isotropy. -/
theorem test_hyperbolicPlane_isotropic : isIsotropic (hyperbolicPlane (F := F))
    (fun i => if i = 0 then F.one else F.zero) :=
  hyperbolicPlane_isotropic

/-- Test orthogonal group contains identity. -/
theorem test_identity_in_orthogonalGroup (B : BilinearForm (fnSpace F 2)) :
    (fun x => x) in orthogonalGroup B :=
  identity_in_orthogonalGroup B

/-- Test Euclidean plane is not the zero form. -/
theorem test_euclideanPlane_nonzero :
    BilinearForm.eval (euclideanPlane (F := F)).form
      (basisVec F 2 0) (basisVec F 2 0) = F.one := by
  unfold BilinearForm.eval euclideanPlane basisVec
  simp [fnSpace]

/-- Test hyperbolic plane symmetry. -/
theorem test_hyperbolicPlane_symmetric (x y : Fin 2 -> F.carrier) :
    BilinearForm.eval (hyperbolicPlane (F := F)).form x y =
    BilinearForm.eval (hyperbolicPlane (F := F)).form y x := by
  have h := (hyperbolicPlane (F := F)).symm x y
  have h' := congrArg (fun f => f 0) h
  simpa [BilinearForm.eval, fnSpace] using h'

end MiniMultilinearForm.Test
