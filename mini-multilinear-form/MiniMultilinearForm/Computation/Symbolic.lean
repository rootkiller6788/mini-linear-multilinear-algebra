/
# MiniMultilinearForm.Computation.Symbolic

Symbolic computation with bilinear and multilinear forms:
expression trees, simplification, normalization.

L7: Computational applications
L8: Symbolic algebra
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

/-! ## Symbolic Expressions for Bilinear Forms -/

/-- A symbolic expression for entries of a bilinear form matrix. -/
inductive SymbolicExpr (F : Field) : Type where
  | var : Nat -> SymbolicExpr F
  | const : F.carrier -> SymbolicExpr F
  | add : SymbolicExpr F -> SymbolicExpr F -> SymbolicExpr F
  | mul : SymbolicExpr F -> SymbolicExpr F -> SymbolicExpr F
  | neg : SymbolicExpr F -> SymbolicExpr F

namespace SymbolicExpr

variable {F : Field}

/-- Evaluate a symbolic expression given a variable assignment. -/
def eval (e : SymbolicExpr F) (assign : Nat -> F.carrier) : F.carrier :=
  match e with
  | var n => assign n
  | const c => c
  | add e1 e2 => F.add (eval e1 assign) (eval e2 assign)
  | mul e1 e2 => F.mul (eval e1 assign) (eval e2 assign)
  | neg e => F.neg (eval e assign)

/-- Count the number of operations in an expression. -/
def size (e : SymbolicExpr F) : Nat :=
  match e with
  | var _ => 1
  | const _ => 1
  | add e1 e2 => 1 + size e1 + size e2
  | mul e1 e2 => 1 + size e1 + size e2
  | neg e => 1 + size e

/-- Collect all variable indices appearing in an expression. -/
def variables (e : SymbolicExpr F) : List Nat :=
  match e with
  | var n => [n]
  | const _ => []
  | add e1 e2 => variables e1 ++ variables e2
  | mul e1 e2 => variables e1 ++ variables e2
  | neg e => variables e

/-- Simplification: constant folding for add, mul, neg. -/
def simplify (e : SymbolicExpr F) : SymbolicExpr F :=
  match e with
  | add (const a) (const b) => const (F.add a b)
  | mul (const a) (const b) => const (F.mul a b)
  | neg (const a) => const (F.neg a)
  | add (const a) e2 =>
    if a = F.zero then simplify e2 else add (const a) (simplify e2)
  | mul (const a) e2 =>
    if a = F.one then simplify e2
    else if a = F.zero then const F.zero
    else mul (const a) (simplify e2)
  | add e1 e2 => add (simplify e1) (simplify e2)
  | mul e1 e2 => mul (simplify e1) (simplify e2)
  | neg e => neg (simplify e)
  | e => e

/-- Substitute a variable with a value. -/
def subst (e : SymbolicExpr F) (varIdx : Nat) (val : F.carrier) : SymbolicExpr F :=
  match e with
  | var n => if n = varIdx then const val else var n
  | const _ => e
  | add e1 e2 => add (subst e1 varIdx val) (subst e2 varIdx val)
  | mul e1 e2 => mul (subst e1 varIdx val) (subst e2 varIdx val)
  | neg e => neg (subst e varIdx val)

/-- Partial derivative with respect to a variable. -/
def partialDerivative (e : SymbolicExpr F) (varIdx : Nat) : SymbolicExpr F :=
  match e with
  | var n => if n = varIdx then const F.one else const F.zero
  | const _ => const F.zero
  | add e1 e2 => add (partialDerivative e1 varIdx) (partialDerivative e2 varIdx)
  | mul e1 e2 => add (mul (partialDerivative e1 varIdx) e2) (mul e1 (partialDerivative e2 varIdx))
  | neg e => neg (partialDerivative e varIdx)

end SymbolicExpr

/-! ## Symbolic Bilinear Forms -/

/-- A symbolic bilinear form is an n x n matrix of symbolic expressions. -/
def SymbolicBilinearForm (F : Field) (n : Nat) : Type :=
  Fin n -> Fin n -> SymbolicExpr F

/-- Evaluate a symbolic bilinear form on vectors x, y. -/
def SymbolicBilinearForm.eval {F : Field} {n : Nat}
    (B : SymbolicBilinearForm F n) (x y : Fin n -> F.carrier) (assign : Nat -> F.carrier) : F.carrier :=
  F.sum n (fun i => F.sum n (fun j =>
    F.mul (F.mul (SymbolicExpr.eval (B i j) assign) (x i)) (y j)))

/-- The Gram matrix of a bilinear form as a symbolic bilinear form. -/
def symbolicGramMatrix {F : Field} (n : Nat) (B : BilinearForm (fnSpace F n))
    (basis : Fin n -> (Fin n -> F.carrier)) : SymbolicBilinearForm F n :=
  fun i j => SymbolicExpr.const (BilinearForm.eval B (basis i) (basis j))

/-! ## Symbolic Tensor Contraction -/

/-- Contract a symbolic tensor T_{ij} with U_{jk} -> sum_j T_{ij} * U_{jk}. -/
def contractTensors {F : Field} (n m p : Nat)
    (T : Fin n -> Fin m -> SymbolicExpr F)
    (U : Fin m -> Fin p -> SymbolicExpr F) :
    Fin n -> Fin p -> SymbolicExpr F :=
  fun i k =>
    List.foldl (fun acc j =>
      SymbolicExpr.add acc (SymbolicExpr.mul (T i j) (U j k)))
      (SymbolicExpr.const F.zero)
      (List.ofFn id)

end MiniMultilinearForm

#eval "Computation.Symbolic: symbolic expressions, simplification, tensor contraction"
