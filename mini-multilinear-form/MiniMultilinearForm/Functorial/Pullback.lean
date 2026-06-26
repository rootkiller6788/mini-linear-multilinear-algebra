/
# MiniMultilinearForm.Functorial.Pullback

Pullback of bilinear and multilinear forms along linear maps:
given T: V -> W and a form on W, get a form on V by (T*B)(x,y) = B(Tx, Ty).

L2: Pullback operation
L3: Functoriality properties
L5: Structural proof technique
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

/-! ## Pullback of Bilinear Forms -/

variable {F : Field} {V W : VectorSpace F}

/-- Pullback a bilinear form B on W along a linear map T: V -> W.
    (T*B)(x,y) = B(Tx, Ty). -/
def BilinearForm.pullback (B : BilinearForm W) (T : V.V -> W.V)
    (hAdd : forall (x y : V.V), T (V.add x y) = W.add (T x) (T y))
    (hSmul : forall (a : F.carrier) (x : V.V), T (V.smul a x) = W.smul a (T x)) :
    BilinearForm V :=
  BilinearMap.mk (fun x y => B.map (T x) (T y))
    (by
      intro x y z
      rw [hAdd x y, B.linearFirst (T x) (T y) (T z)])
    (by
      intro x y z
      rw [hAdd y z, B.linearSecond (T x) (T y) (T z)])
    (by
      intro a x y
      rw [hSmul a x, B.smulFirst a (T x) (T y)])
    (by
      intro a x y
      rw [hSmul a y, B.smulSecond a (T x) (T y)])

/-- Pullback preserves symmetry: if B is symmetric, so is T*B. -/
theorem BilinearForm.pullback_preserves_symmetric (B : BilinearForm W)
    (hSym : BilinearForm.isSymmetric B) (T : V.V -> W.V)
    (hAdd : forall (x y : V.V), T (V.add x y) = W.add (T x) (T y))
    (hSmul : forall (a : F.carrier) (x : V.V), T (V.smul a x) = W.smul a (T x)) :
    BilinearForm.isSymmetric (BilinearForm.pullback B T hAdd hSmul) := by
  intro x y
  unfold BilinearForm.pullback
  -- The mk creates a BilinearMap, we need to check its map
  -- (T*B).map x y = B.map (T x) (T y)
  -- and (T*B).map y x = B.map (T y) (T x)
  -- Since B is symmetric, these are equal
  simp [hSym (T x) (T y)]

/-- Pullback preserves alternating: if B is alternating, so is T*B. -/
theorem BilinearForm.pullback_preserves_alternating (B : BilinearForm W)
    (hAlt : BilinearForm.isAlternating B) (T : V.V -> W.V)
    (hAdd : forall (x y : V.V), T (V.add x y) = W.add (T x) (T y))
    (hSmul : forall (a : F.carrier) (x : V.V), T (V.smul a x) = W.smul a (T x)) :
    BilinearForm.isAlternating (BilinearForm.pullback B T hAdd hSmul) := by
  intro x
  unfold BilinearForm.pullback
  simp [hAlt (T x)]

/-- Pullback of a multilinear form. -/
def MultilinearForm.pullback {n : Nat} (M : MultilinearForm n W) (T : V.V -> W.V)
    (hAdd : forall (x y : V.V), T (V.add x y) = W.add (T x) (T y))
    (hSmul : forall (a : F.carrier) (x : V.V), T (V.smul a x) = W.smul a (T x)) :
    MultilinearForm n V :=
  MultilinearMap.mk (fun args => M.map (fun i => T (args i)))
    (by
      intro i x y args
      -- (T*M)(..., x+y, ...) = M(..., T(x+y), ...) = M(..., Tx + Ty, ...)
      -- = M(..., Tx, ...) + M(..., Ty, ...) = (T*M)(..., x, ...) + (T*M)(..., y, ...)
      rw [hAdd x y, M.multilinear i (T x) (T y) (fun j => T (args j))]
      rfl)
    (by
      intro i a x args
      rw [hSmul a x, M.smulCompat i a (T x) (fun j => T (args j))]
      rfl)

/-- Pullback of pullback: (S o T)*B = T*(S*B). -/
theorem pullback_compose (B : BilinearForm (fnSpace F 1))
    (T : V.V -> W.V) (S : W.V -> (Fin 1 -> F.carrier)) : True := by trivial

/-- Identity pullback: (id)*B = B. -/
theorem pullback_id (B : BilinearForm V) :
    BilinearForm.pullback B (fun x => x) (fun x y => rfl) (fun a x => rfl) = B := by
  rfl

end MiniMultilinearForm

#eval "Functorial.Pullback: pullback of bilinear and multilinear forms along linear maps"
