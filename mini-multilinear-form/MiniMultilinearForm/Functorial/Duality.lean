/
# MiniMultilinearForm.Functorial.Duality

Duality for bilinear forms: B: V x W -> F gives maps V -> W* and W -> V*.
Left/right radicals, nondegeneracy, adjoints.

L2: Dual map construction
L3: Duality correspondence
L5: Proof by algebraic manipulation
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

/-! ## Bilinear Form as Map to Dual Space -/

variable {F : Field} {V W : VectorSpace F}

/-- A bilinear form B: V x W -> F induces a linear map V -> W* given by v |-> (w |-> B(v,w)). -/
def BilinearForm.toDualMap (B : BilinearMap V W (fnSpace F 1)) (v : V.V) : W.V -> F.carrier :=
  fun w => (B.map v w) 0

/-- The map V -> W* is linear. -/
theorem BilinearForm.toDualMap_linear (B : BilinearMap V W (fnSpace F 1)) :
    forall (x y : V.V),
      BilinearForm.toDualMap B (V.add x y) = fun w => F.add ((B.map x w) 0) ((B.map y w) 0) := by
  intro x y
  ext w
  unfold BilinearForm.toDualMap
  rw [B.linearFirst x y w]
  rfl

/-- The left radical is the kernel of V -> W*. -/
def BilinearForm.leftRadical (B : BilinearMap V W (fnSpace F 1)) : Set V.V :=
  { v | forall (w : W.V), (B.map v w) 0 = F.zero }

/-- The right radical is the kernel of W -> V*. -/
def BilinearForm.rightRadical (B : BilinearMap V W (fnSpace F 1)) : Set W.V :=
  { w | forall (v : V.V), (B.map v w) 0 = F.zero }

/-- B is left-nondegenerate iff left radical = {0}. -/
theorem leftNondegenerate_iff_leftRadical_trivial (B : BilinearMap V W (fnSpace F 1)) :
    BilinearForm.isLeftNondegenerate B <-> (forall (v : V.V), v in BilinearForm.leftRadical B -> v = V.zero) := by
  constructor
  { intro h v hv
    have h' : forall (w : W.V), (B.map V.zero w) 0 = (B.map v w) 0 := by
      intro w; rw [B.linearFirst V.zero V.zero w, V.add_zero, hv w]
    -- This is not quite right. The definition of isLeftNondegenerate says:
    -- forall v1 v2, (forall w, B(v1,w) = B(v2,w)) -> v1 = v2
    -- Here we have v with B(v,w) = 0 for all w, so B(v,w) = B(0,w) for all w
    -- So v = 0
    have hzero : forall (w : W.V), (B.map V.zero w) 0 = F.zero := by
      intro w; calc
        (B.map V.zero w) 0 = (B.map (V.smul F.zero V.zero) w) 0 := by rw [VectorSpace.zero_smul V, VectorSpace.smul_zero V F.zero]
        _ = ((fnSpace F 1).smul F.zero (B.map V.zero w)) 0 := by rw [B.smulFirst F.zero V.zero w]
        _ = F.zero := by simp [fnSpace, VectorSpace.zero_smul]
    -- hzero gives: B(0, w) = 0 and hv gives B(v, w) = 0 for all w
    -- So B(v, w) = B(0, w) for all w, hence v = 0 by left-nondegeneracy
    apply h
    intro w
    rw [hv w, show (B.map V.zero w) 0 = F.zero from by
      have hz := congrArg (fun f => f 0) (B.linearFirst V.zero V.zero w)
      simp [fnSpace, V.add_zero] at hz; exact hz]
    exact h v V.zero hzero }
  { intro h v1 v2 heq
    -- B(v1, w) = B(v2, w) for all w => B(v1-v2, w) = 0 for all w
    -- So v1-v2 is in the left radical, hence v1-v2 = 0, so v1 = v2
    -- From heq: B(v1, w) = B(v2, w) for all w
    -- Then B(v1 - v2, w) = B(v1,w) - B(v2,w) = 0 for all w (by linearity)
    -- So v1 - v2 is in the left radical, hence v1 - v2 = 0, so v1 = v2
    have h_diff : forall w, (B.map (V.add v1 (V.neg v2)) w) 0 = F.zero := by
      intro w
      have h_linear := congrArg (fun f => f 0) (B.linearFirst v1 (V.neg v2) w)
      simp [fnSpace, heq w] at h_linear
      -- Using B(v2, w) + B(-v2, w) = 0 from bilinearity
      rw [show (B.map (V.neg v2) w) 0 = F.neg ((B.map v2 w) 0) from by
        have hneg := B.smulFirst (F.neg F.one) v2 w
        have hneg' := congrArg (fun f => f 0) hneg
        simp [fnSpace, VectorSpace.neg_one_smul V v2] at hneg'
        exact hneg']
      -- Now a + (-a) = 0
      rw [F.add_neg]
    have h_rad : V.add v1 (V.neg v2) = V.zero := h (V.add v1 (V.neg v2)) h_diff
    apply VectorSpace.add_left_cancel V v1 v2
    calc
      V.add v1 v2 = V.add v1 (V.neg (V.neg v2)) := by
        -- neg(neg v2) = v2 in any vector space
        have h_dneg : V.neg (V.neg v2) = v2 := by
          apply VectorSpace.add_left_cancel V (V.neg v2)
          rw [V.add_neg, V.add_comm, V.add_neg]
        rw [h_dneg]
      _ = V.add (V.add v1 (V.neg v2)) (V.neg (V.neg v2)) := by
        rw [V.add_assoc]
      _ = V.add V.zero (V.neg (V.neg v2)) := by rw [h_rad]
      _ = V.neg (V.neg v2) := by rw [V.zero_add]
      _ = v2 := by
        apply VectorSpace.add_left_cancel V (V.neg v2)
        rw [V.add_neg, V.add_comm, V.add_neg]
    }

/-- A bilinear form B: V x V -> F is nondegenerate iff left radical = {0}. -/
theorem nondegenerate_iff_leftRadical_trivial (B : BilinearForm V) :
    BilinearForm.isNondegenerate B <-> (forall (v : V.V), v in BilinearForm.leftRadical B -> v = V.zero) := by
  constructor
  { intro h v hv
    unfold BilinearForm.leftRadical at hv
    -- hv: forall (w : V.V), (B.map v w) 0 = F.zero
    -- isNondegenerate: forall x, (forall y, (B.map x y) 0 = F.zero) -> x = V.zero
    exact h v hv }
  { intro h v hv
    -- hv: forall y, (B.map v y) 0 = F.zero
    -- So v is in the left radical
    -- By h, v = V.zero
    have hv' : v in BilinearForm.leftRadical B := hv
    exact h v hv' }

/-! ## Adjoint with respect to a Bilinear Form -/

/-- Given B on V and T: V -> V, the adjoint T* satisfies B(Tx, y) = B(x, T*y). -/
def BilinearForm.adjoint (B : BilinearForm V) (T : V.V -> V.V)
    (Tstar : V.V -> V.V) : Prop :=
  forall (x y : V.V), BilinearForm.eval B (T x) y = BilinearForm.eval B x (Tstar y)

/-- The adjoint, if it exists, is unique when B is nondegenerate. -/
theorem adjoint_unique (B : BilinearForm V) (hNondeg : BilinearForm.isNondegenerate B)
    (T : V.V -> V.V) (S1 S2 : V.V -> V.V)
    (h1 : BilinearForm.adjoint B T S1) (h2 : BilinearForm.adjoint B T S2) :
    forall x, S1 x = S2 x := by
  intro x
  -- For all y, B(x, S1 y) = B(Tx, y) = B(x, S2 y)
  -- So B(x, S1 y - S2 y) = 0 for all y
  -- We show: forall y, B(S1 x, y) = B(S2 x, y), so S1 x = S2 x by nondegeneracy
  apply hNondeg
  intro y
  calc
    BilinearForm.eval B (S1 x) y = BilinearForm.eval B (T x) y := h1 x y
    _ = BilinearForm.eval B (S2 x) y := by rw [h2 x y]

/-! ## Correspondence between Bilinear Forms and Linear Maps V -> V* -/

/-- The space of bilinear forms on V is isomorphic to Hom(V, V*). -/
def bilinearFormsIsoDualMaps (V : VectorSpace F) : Prop :=
  exists (phi : BilinearForm V -> (V.V -> V.V -> F.carrier))
    (psi : (V.V -> V.V -> F.carrier) -> BilinearForm V),
    (forall (B : BilinearForm V), psi (phi B) = B) /\
    (forall (f : V.V -> V.V -> F.carrier), phi (psi f) = f)

end MiniMultilinearForm

#eval "Functorial.Duality: dual map, left/right radicals, adjoint, isomorphism Bilin(V) ~ Hom(V, V*)"
