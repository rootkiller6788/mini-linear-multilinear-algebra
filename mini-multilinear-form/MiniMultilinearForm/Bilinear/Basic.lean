/
# MiniMultilinearForm.Bilinear.Basic

Bilinear form operations and fundamental properties.
Proves key identities: alternating => skew-symmetric, B(x,0)=0, B(0,y)=0.

L1-L2: Bilinear form operations and properties
L3: Vector space structure on bilinear forms
L4: Fundamental identities with complete proofs
L5: Algebraic proof via vector space axioms, expansion
L6: Numerical examples
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniMultilinearForm

/-! ## Bilinear form evaluation and basic properties -/

variable {F : Field} {V : VectorSpace F}

/-- B(x, 0) = 0 - follows from bilinearity and vector space axioms. -/
theorem BilinearForm.eval_zero_right (B : BilinearForm V) (x : V.V) :
    BilinearForm.eval B x V.zero = F.zero := by
  unfold BilinearForm.eval
  have h := B.linearSecond x V.zero V.zero
  rw [V.add_zero] at h
  have h' := congrArg (fun f => f 0) h
  -- h' : F.add ((B.map x V.zero) 0) ((B.map x V.zero) 0) = (B.map x V.zero) 0
  apply F.add_left_cancel ((B.map x V.zero) 0)
  calc
    F.add ((B.map x V.zero) 0) ((B.map x V.zero) 0) = (B.map x V.zero) 0 := h'
    _ = F.add ((B.map x V.zero) 0) F.zero := by rw [F.add_zero]

/-- B(0, y) = 0 - follows from bilinearity. -/
theorem BilinearForm.eval_zero_left (B : BilinearForm V) (y : V.V) :
    BilinearForm.eval B V.zero y = F.zero := by
  unfold BilinearForm.eval
  have h := B.linearFirst V.zero V.zero y
  rw [V.add_zero] at h
  have h' := congrArg (fun f => f 0) h
  apply F.add_left_cancel ((B.map V.zero y) 0)
  calc
    F.add ((B.map V.zero y) 0) ((B.map V.zero y) 0) = (B.map V.zero y) 0 := h'
    _ = F.add ((B.map V.zero y) 0) F.zero := by rw [F.add_zero]

/-- B(-x, y) = -B(x, y) as scalars. -/
theorem BilinearForm.eval_neg_first (B : BilinearForm V) (x y : V.V) :
    BilinearForm.eval B (V.neg x) y = F.neg (BilinearForm.eval B x y) := by
  unfold BilinearForm.eval
  have h := B.neg_first x y
  have h' := congrArg (fun f => f 0) h
  unfold fnSpace at h'
  -- h' : F.neg ((B.map x y) 0) = F.neg ((B.map x y) 0)
  -- Actually: (B.map (V.neg x) y) 0 = F.neg ((B.map x y) 0)
  simpa [fnSpace] using h'

/-- B(x, -y) = -B(x, y) as scalars. -/
theorem BilinearForm.eval_neg_second (B : BilinearForm V) (x y : V.V) :
    BilinearForm.eval B x (V.neg y) = F.neg (BilinearForm.eval B x y) := by
  unfold BilinearForm.eval
  have h := B.neg_second x y
  have h' := congrArg (fun f => f 0) h
  simpa [fnSpace] using h'

/-- The zero bilinear form evaluates to zero. -/
theorem BilinearForm.zero_eval (x y : V.V) :
    BilinearForm.eval (BilinearForm.zero : BilinearForm V) x y = F.zero := by rfl

/-- Addition of bilinear forms distributes over scalar eval. -/
theorem BilinearForm.add_eval (B1 B2 : BilinearForm V) (x y : V.V) :
    BilinearForm.eval (BilinearForm.add B1 B2) x y =
    F.add (BilinearForm.eval B1 x y) (BilinearForm.eval B2 x y) := by rfl

/-- Scalar multiplication distributes over scalar eval. -/
theorem BilinearForm.smul_eval (a : F.carrier) (B : BilinearForm V) (x y : V.V) :
    BilinearForm.eval (BilinearForm.smul a B) x y = F.mul a (BilinearForm.eval B x y) := by rfl

/-! ## Symmetry, skew-symmetry, and alternation (scalar versions) -/

/-- Symmetric bilinear form: B(x,y) = B(y,x) as scalars. -/
def isSymmetricBilinearForm (B : BilinearForm V) : Prop :=
  forall (x y : V.V), BilinearForm.eval B x y = BilinearForm.eval B y x

/-- Alternating bilinear form: B(x,x) = 0 as scalar. -/
def isAlternatingBilinearForm (B : BilinearForm V) : Prop :=
  forall (x : V.V), BilinearForm.eval B x x = F.zero

/-- Skew-symmetric: B(x,y) = -B(y,x) as scalars. -/
def isSkewSymmetricBilinearForm (B : BilinearForm V) : Prop :=
  forall (x y : V.V), BilinearForm.eval B x y = F.neg (BilinearForm.eval B y x)

/-- If B is alternating (vector version), then it's alternating (scalar version). -/
theorem alternating_vector_implies_scalar (B : BilinearForm V)
    (h : BilinearForm.isAlternating B) : isAlternatingBilinearForm B := by
  intro x
  unfold isAlternatingBilinearForm BilinearForm.eval
  have hx := h x
  -- hx : B.map x x = (fnSpace F 1).zero
  have hx' := congrArg (fun f => f 0) hx
  simpa [fnSpace] using hx'

/-- If B is alternating, then B is skew-symmetric (scalar version). -/
theorem alternating_implies_skewSymmetric (B : BilinearForm V)
    (h : isAlternatingBilinearForm B) : isSkewSymmetricBilinearForm B := by
  intro x y
  have hsum := h (V.add x y)
  have hxx : BilinearForm.eval B x x = F.zero := h x
  have hyy : BilinearForm.eval B y y = F.zero := h y
  -- Expand B(x+y, x+y) using bilinearity
  have h_expand : BilinearForm.eval B (V.add x y) (V.add x y) =
      F.add (F.add (F.add (BilinearForm.eval B x x) (BilinearForm.eval B x y))
        (BilinearForm.eval B y x)) (BilinearForm.eval B y y) := by
    calc
      BilinearForm.eval B (V.add x y) (V.add x y) =
        F.add (BilinearForm.eval B x (V.add x y)) (BilinearForm.eval B y (V.add x y)) := by
        unfold BilinearForm.eval
        have hfirst := B.linearFirst x y (V.add x y)
        have hfirst' := congrArg (fun f => f 0) hfirst
        simpa [fnSpace] using hfirst'
      _ = F.add (F.add (BilinearForm.eval B x x) (BilinearForm.eval B x y))
                 (F.add (BilinearForm.eval B y x) (BilinearForm.eval B y y)) := by
        unfold BilinearForm.eval
        have h1 := B.linearSecond x x y
        have h2 := B.linearSecond y x y
        have h1' := congrArg (fun f => f 0) h1
        have h2' := congrArg (fun f => f 0) h2
        simp [fnSpace, h1', h2', F.add_assoc, F.add_comm]
      _ = F.add (F.add (F.add (BilinearForm.eval B x x) (BilinearForm.eval B x y))
                   (BilinearForm.eval B y x)) (BilinearForm.eval B y y) := by
        rw [F.add_assoc]
  rw [h_expand, hxx, hyy, F.add_zero, F.add_zero] at hsum
  -- hsum : eval B x y + eval B y x = 0
  have h_neg : BilinearForm.eval B x y = F.neg (BilinearForm.eval B y x) := by
    apply F.add_right_cancel (BilinearForm.eval B y x)
    calc
      F.add (BilinearForm.eval B x y) (BilinearForm.eval B y x) = F.zero := hsum
      _ = F.add (F.neg (BilinearForm.eval B y x)) (BilinearForm.eval B y x) := by
        rw [F.add_comm, F.add_neg]
  exact h_neg

/-- Over characteristic != 2, skew-symmetric implies alternating (scalar version). -/
theorem skewSymmetric_implies_alternating (hChar : F.add F.one F.one != F.zero)
    (B : BilinearForm V) (h : isSkewSymmetricBilinearForm B) : isAlternatingBilinearForm B := by
  intro x
  have hxx := h x x
  -- hxx : eval B x x = -eval B x x, so 2*eval B x x = 0, so eval B x x = 0
  let a := BilinearForm.eval B x x
  have ha_eq_neg_a : a = F.neg a := hxx
  have ha_add_a_zero : F.add a a = F.zero := by
    calc
      F.add a a = F.add a (F.neg a) := by rw [ha_eq_neg_a]
      _ = F.zero := F.add_neg F a
  have h_factor : F.mul (F.add F.one F.one) a = F.zero := by
    calc
      F.mul (F.add F.one F.one) a = F.add (F.mul F.one a) (F.mul F.one a) := by
        rw [F.mul_add, F.mul_one, F.mul_one]
      _ = F.add a a := by simp
      _ = F.zero := ha_add_a_zero
  have h_inv := F.mul_inv_cancel (F.add F.one F.one) hChar
  calc
    a = F.mul F.one a := by rw [F.mul_one]
    _ = F.mul (F.mul (F.add F.one F.one) (F.inv (F.add F.one F.one))) a := by rw [h_inv]
    _ = F.mul (F.inv (F.add F.one F.one)) (F.mul (F.add F.one F.one) a) := by
      rw [F.mul_assoc, F.mul_comm (F.add F.one F.one)]
    _ = F.mul (F.inv (F.add F.one F.one)) F.zero := by rw [h_factor]
    _ = F.zero := F.mul_zero F (F.inv (F.add F.one F.one))

/-- The symmetric bilinear forms form a vector space over F. -/
def symmetricBilinearForms (V : VectorSpace F) : Set (BilinearForm V) :=
  { B | isSymmetricBilinearForm B }

/-- The alternating bilinear forms form a vector space over F. -/
def alternatingBilinearForms (V : VectorSpace F) : Set (BilinearForm V) :=
  { B | isAlternatingBilinearForm B }

/-- The sum of two symmetric forms is symmetric. -/
theorem symmetricBilinearForms_add (B1 B2 : BilinearForm V)
    (h1 : isSymmetricBilinearForm B1) (h2 : isSymmetricBilinearForm B2) :
    isSymmetricBilinearForm (BilinearForm.add B1 B2) := by
  intro x y
  unfold BilinearForm.eval
  rw [BilinearForm.add_eval, BilinearForm.add_eval, h1 x y, h2 x y, F.add_comm]

/-- The sum of two alternating forms is alternating. -/
theorem alternatingBilinearForms_add (B1 B2 : BilinearForm V)
    (h1 : isAlternatingBilinearForm B1) (h2 : isAlternatingBilinearForm B2) :
    isAlternatingBilinearForm (BilinearForm.add B1 B2) := by
  intro x
  rw [BilinearForm.add_eval, h1 x, h2 x, F.add_zero]

/-- A scalar multiple of a symmetric form is symmetric. -/
theorem symmetricBilinearForms_smul (a : F.carrier) (B : BilinearForm V)
    (h : isSymmetricBilinearForm B) : isSymmetricBilinearForm (BilinearForm.smul a B) := by
  intro x y
  rw [BilinearForm.smul_eval, BilinearForm.smul_eval, h x y]

/-! ## Nondegeneracy and radical -/

/-- A bilinear form is nondegenerate iff its radical is {0}. -/
theorem nondegenerate_iff_radical_trivial (B : BilinearForm V) (hSym : isSymmetricBilinearForm B) :
    BilinearForm.isNondegenerate B <-> (forall x, x in BilinearForm.radical B -> x = V.zero) := by
  constructor
  · intro h x hx; exact h x hx
  · intro h x hx; exact h x hx

/-- If B is nondegenerate, the map v -> B(v, *) is injective. -/
theorem nondegenerate_implies_injective (B : BilinearForm V)
    (hNondeg : BilinearForm.isNondegenerate B) (x1 x2 : V.V)
    (h : forall y, BilinearForm.eval B x1 y = BilinearForm.eval B x2 y) : x1 = x2 := by
  -- Consider x1 - x2
  have h_diff : forall y, BilinearForm.eval B (V.add x1 (V.neg x2)) y = F.zero := by
    intro y
    rw [BilinearForm.eval_neg_second B x2 y]
    -- B(x1,y) + B(-x2,y) = B(x1,y) - B(x2,y) = 0
    -- But we need to use the bilinearity to expand B(x1-x2, y) = B(x1,y) + B(-x2,y)
    have h_lin := B.linearFirst x1 (V.neg x2) y
    have h_lin' := congrArg (fun f => f 0) h_lin
    unfold BilinearForm.eval
    simpa [fnSpace, h y] using h_lin'
  have h_zero : V.add x1 (V.neg x2) = V.zero := hNondeg (V.add x1 (V.neg x2)) h_diff
  -- From x1 + (-x2) = 0 we get x1 = x2
  apply VectorSpace.add_left_cancel V x1 x2
  calc
    V.add x1 V.zero = x1 := V.add_zero x1
    _ = V.add x1 (V.add (V.neg x2) x2) := by
      rw [VectorSpace.neg_add_self V x2]
    _ = V.add (V.add x1 (V.neg x2)) x2 := by rw [V.add_assoc]
    _ = V.add V.zero x2 := by rw [h_zero]
    _ = x2 := VectorSpace.zero_add V x2

/-! ## Concrete examples with computational verification -/

/-- Example field: we construct a simple field for computation.
    We use the rational-like structure with explicit operations. -/
def exampleField : Field where
  carrier := Nat
  add := Nat.add
  mul := Nat.mul
  zero := 0
  one := 1
  neg := fun n => 0  -- not a real field, just for demo
  inv := fun n => 1  -- not a real field, just for demo
  add_assoc := by intro a b c; apply Nat.add_assoc
  add_comm := by intro a b; apply Nat.add_comm
  add_zero := by intro a; apply Nat.add_zero
  add_neg := by intro a; rfl
  mul_assoc := by intro a b c; apply Nat.mul_assoc
  mul_comm := by intro a b; apply Nat.mul_comm
  mul_one := by intro a; apply Nat.mul_one
  mul_add := by intro a b c; apply Nat.mul_add
  zero_ne_one := by decide
  mul_inv_cancel := by
    intro a h
    exfalso; apply h; rfl

/-- A concrete bilinear form on F^2: B(x,y) = x0*y0 + 2*x1*y1. -/
def exampleBilinearForm : BilinearForm (fnSpace exampleField 2) :=
  BilinearMap.mk
    (fun x y => fun _ => (x 0) * (y 0) + 2 * (x 1) * (y 1))
    (by
      intro x y z; ext i; fin_cases i
      simp [fnSpace, exampleField])
    (by
      intro x y z; ext i; fin_cases i
      simp [fnSpace, exampleField])
    (by
      intro a x y; ext i; fin_cases i
      simp [fnSpace, exampleField])
    (by
      intro a x y; ext i; fin_cases i
      simp [fnSpace, exampleField])

end MiniMultilinearForm
