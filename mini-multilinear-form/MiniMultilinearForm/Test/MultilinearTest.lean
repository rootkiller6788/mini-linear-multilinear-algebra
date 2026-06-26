import MiniMultilinearForm.Core.Basic
import MiniMultilinearForm.Multilinear.Basic
import MiniMultilinearForm.Multilinear.Operations

namespace MiniMultilinearForm.Test

open MiniMultilinearForm

variable {F : Field}

/-- Test zero multilinear form evaluates to zero. -/
theorem test_zero_multilinear_form (vs : Fin 3 -> (fnSpace F 2).V) :
    MultilinearForm.eval (MultilinearForm.zero 3) vs = F.zero := by
  rfl

/-- Test the 2D determinant form is alternating. -/
theorem test_determinantForm2D_alternating (v : Fin 2 -> F.carrier) :
    MultilinearForm.eval (determinantForm2D (F := F)) (fun _ : Fin 2 => v) = F.zero := by
  have h := determinantForm2D_alternating
  -- The alternating property ensures det(v,v) = 0
  have h0 := h 0 1 (fun _ : Fin 2 => v) (by decide) (by rfl)
  have h0' := congrArg (fun f => f 0) h0
  simpa [MultilinearForm.eval, fnSpace] using h0'

/-- Test wedge product of 1-forms is alternating. -/
theorem test_wedgeProduct_alternating (phi psi : MultilinearForm 1 (fnSpace F 2)) (v : Fin 2 -> F.carrier) :
    isAlternatingTensor (wedgeProduct2D phi psi) :=
  wedgeProduct2D_alternating phi psi

/-- Test ofBilinear <-> toBilinearTwo roundtrip. -/
theorem test_bilinear_multilinear_roundtrip (B : BilinearMap (fnSpace F 2) (fnSpace F 2) (fnSpace F 1)) :
    MultilinearMap.toBilinearTwo (MultilinearMap.ofBilinear B) = B :=
  roundtrip_bilinear B

/-- Test: determinant form evaluates to det2D. -/
theorem test_determinantForm_eval (v w : Fin 2 -> F.carrier) :
    evalForm (determinantForm2D (F := F)) (fun i => if i = 0 then v else w) = det2D v w := by
  unfold evalForm determinantForm2D
  simp

end MiniMultilinearForm.Test
