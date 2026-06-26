import MiniMultilinearForm.Core.Basic
import MiniMultilinearForm.Bilinear.Basic

namespace MiniMultilinearForm.Test

open MiniMultilinearForm

variable {F : Field}

/-- Test B(x,0) = 0 for the symplectic form. -/
theorem test_eval_zero_right : BilinearForm.eval (symplecticForm2D (F := F))
    (fun i => if i = 0 then F.one else F.zero) (fun _ => F.zero) = F.zero := by
  simp [symplecticForm2D, BilinearForm.eval, fnSpace]

/-- Test alternating property: ω(v,v) = 0. -/
theorem test_symplectic_alternating (v : Fin 2 -> F.carrier) :
    BilinearForm.eval (symplecticForm2D (F := F)) v v = F.zero := by
  have h := symplecticForm2D_alternating v
  have h' := congrArg (fun f => f 0) h
  simpa [BilinearForm.eval, fnSpace] using h'

/-- Test dot product symmetry. -/
theorem test_dotProduct_symmetric (x y : Fin 3 -> F.carrier) :
    dotProduct x y = dotProduct y x :=
  dotProduct_symmetric x y

/-- Test det2D skew-symmetry: det(x,y) = -det(y,x). -/
theorem test_det2D_skewSymmetric (x y : Fin 2 -> F.carrier) :
    det2D x y = F.neg (det2D y x) := by
  unfold det2D
  rw [F.mul_comm (y 0) (x 1), F.mul_comm (y 1) (x 0)]
  rw [F.add_comm, show F.neg (F.add (F.mul (x 0) (y 1)) (F.neg (F.mul (x 1) (y 0)))) =
    F.add (F.mul (x 1) (y 0)) (F.neg (F.mul (x 0) (y 1))) by
    simp [F.add_comm, F.add_assoc, F.neg_add]]

/-- Test trace form Tr(AB) = Tr(BA) for a concrete pair. -/
theorem test_traceForm_symmetric (A B : Fin 2 -> Fin 2 -> F.carrier) :
    traceForm2D A B = traceForm2D B A :=
  traceForm2D_symmetric A B

/-- Test Euclidean inner product symmetry. -/
theorem test_euclidean_symmetric (x y : Fin 3 -> F.carrier) :
    BilinearForm.eval (euclideanInnerProduct 3) x y =
    BilinearForm.eval (euclideanInnerProduct 3) y x := by
  have h := euclideanInnerProduct_symmetric 3 x y
  have h' := congrArg (fun f => f 0) h
  simpa [BilinearForm.eval, fnSpace] using h'

end MiniMultilinearForm.Test
