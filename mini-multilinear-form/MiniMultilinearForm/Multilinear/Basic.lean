/
# MiniMultilinearForm.Multilinear.Basic

Multilinear maps of n arguments: conversion between bilinear and multilinear,
2-linear maps as bilinear maps, 1-linear as linear maps.

L2: Multilinear map operations
L3: Relation between bilinear and 2-multilinear
L5: Proof by fin_cases for small arity
L6: Concrete examples for n=1,2,3
-/

import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm

open MiniMultilinearForm

/-! ## Conversion utilities -/

variable {F : Field} {V W : VectorSpace F}

/-- A bilinear map V x V -> W gives a 2-multilinear map. -/
def MultilinearMap.ofBilinear (B : BilinearMap V V W) : MultilinearMap 2 V W where
  map args := B.map (args 0) (args 1)
  multilinear := by
    intro i x y args
    fin_cases i
    · -- i = 0: first argument varies
      unfold updateArg
      simp
      rw [B.linearFirst (args 0) x y]
      -- B(args0+x, args1) = B(args0, args1) + B(x, args1)
      -- But we need: map(updateArg 0 (x+y) args) = map(updateArg 0 x args) + map(updateArg 0 y args)
      -- updateArg 0 (x+y) args has first slot x+y, rest = args
      -- map of that is B(x+y, args1)
      -- = B(x, args1) + B(y, args1)
      -- = map(updateArg 0 x args) + map(updateArg 0 y args)
      unfold updateArg
      simp
      rw [B.linearFirst x y (args 1)]
      rfl
    · -- i = 1: second argument varies
      unfold updateArg
      simp
      rw [B.linearSecond (args 0) x y]
      rfl
  smulCompat := by
    intro i a x args
    fin_cases i
    · unfold updateArg; simp; rw [B.smulFirst a x (args 1)]; rfl
    · unfold updateArg; simp; rw [B.smulSecond a (args 0) x]; rfl

/-- A 2-multilinear form corresponds to a bilinear form. -/
def MultilinearMap.toBilinearTwo (M : MultilinearMap 2 V V W) : BilinearMap V V W where
  map x y := M.map (fun i => match i with | 0 => x | 1 => y)
  linearFirst := by
    intro x y z
    calc
      M.map (fun i => match i with | 0 => V.add x y | 1 => z)
          = M.map (updateArg 0 (V.add x y) (fun i => match i with | 0 => x | 1 => z)) := by
        ext i; fin_cases i <;> rfl
      _ = W.add (M.map (updateArg 0 x (fun i => match i with | 0 => x | 1 => z)))
                (M.map (updateArg 0 y (fun i => match i with | 0 => x | 1 => z))) :=
        M.multilinear 0 x y (fun i => match i with | 0 => x | 1 => z)
      _ = W.add (M.map (fun i => match i with | 0 => x | 1 => z))
                (M.map (fun i => match i with | 0 => y | 1 => z)) := by
        congr 1 <;> ext i <;> fin_cases i <;> rfl
  linearSecond := by
    intro x y z
    calc
      M.map (fun i => match i with | 0 => x | 1 => V.add y z)
          = M.map (updateArg 1 (V.add y z) (fun i => match i with | 0 => x | 1 => y)) := by
        ext i; fin_cases i <;> rfl
      _ = W.add (M.map (updateArg 1 y (fun i => match i with | 0 => x | 1 => y)))
                (M.map (updateArg 1 z (fun i => match i with | 0 => x | 1 => y))) :=
        M.multilinear 1 y z (fun i => match i with | 0 => x | 1 => y)
      _ = W.add (M.map (fun i => match i with | 0 => x | 1 => y))
                (M.map (fun i => match i with | 0 => x | 1 => z)) := by
        congr 1 <;> ext i <;> fin_cases i <;> rfl
  smulFirst := by
    intro a x y
    calc
      M.map (fun i => match i with | 0 => V.smul a x | 1 => y)
          = M.map (updateArg 0 (V.smul a x) (fun i => match i with | 0 => x | 1 => y)) := by
        ext i; fin_cases i <;> rfl
      _ = W.smul a (M.map (updateArg 0 x (fun i => match i with | 0 => x | 1 => y))) :=
        M.smulCompat 0 a x (fun i => match i with | 0 => x | 1 => y)
      _ = W.smul a (M.map (fun i => match i with | 0 => x | 1 => y)) := by
        congr; ext i; fin_cases i <;> rfl
  smulSecond := by
    intro a x y
    calc
      M.map (fun i => match i with | 0 => x | 1 => V.smul a y)
          = M.map (updateArg 1 (V.smul a y) (fun i => match i with | 0 => x | 1 => y)) := by
        ext i; fin_cases i <;> rfl
      _ = W.smul a (M.map (updateArg 1 y (fun i => match i with | 0 => x | 1 => y))) :=
        M.smulCompat 1 a y (fun i => match i with | 0 => x | 1 => y)
      _ = W.smul a (M.map (fun i => match i with | 0 => x | 1 => y)) := by
        congr; ext i; fin_cases i <;> rfl

/-- Roundtrip: ofBilinear then toBilinearTwo is the identity. -/
theorem roundtrip_bilinear (B : BilinearMap V V W) :
    MultilinearMap.toBilinearTwo (MultilinearMap.ofBilinear B) = B := by
  ext x y
  rfl

/-- A 1-multilinear map is the same as a linear map f: V -> W. -/
def MultilinearMap.fromLinear (f : V.V -> W.V)
    (hAdd : forall x y, f (V.add x y) = W.add (f x) (f y))
    (hSmul : forall a x, f (V.smul a x) = W.smul a (f x)) :
    MultilinearMap 1 V W where
  map args := f (args 0)
  multilinear := by
    intro i x y args
    fin_cases i
    simp
    rw [hAdd x y]
    rfl
  smulCompat := by
    intro i a x args
    fin_cases i
    simp
    rw [hSmul a x]
    rfl

/-- A 0-multilinear map is an element of W. -/
def MultilinearMap.ofVector (w : W.V) : MultilinearMap 0 V W where
  map _ := w
  multilinear := by intro i; exact Fin.elim0 i
  smulCompat := by intro i; exact Fin.elim0 i

/-- A 3-multilinear map from a function + linearity proofs in each slot. -/
def MultilinearMap.ofTrilinear (f : V.V -> V.V -> V.V -> W.V)
    (hAdd1 : forall x1 x2 y z, f (V.add x1 x2) y z = W.add (f x1 y z) (f x2 y z))
    (hAdd2 : forall x y1 y2 z, f x (V.add y1 y2) z = W.add (f x y1 z) (f x y2 z))
    (hAdd3 : forall x y z1 z2, f x y (V.add z1 z2) = W.add (f x y z1) (f x y z2))
    (hSmul1 : forall a x y z, f (V.smul a x) y z = W.smul a (f x y z))
    (hSmul2 : forall a x y z, f x (V.smul a y) z = W.smul a (f x y z))
    (hSmul3 : forall a x y z, f x y (V.smul a z) = W.smul a (f x y z)) :
    MultilinearMap 3 V W where
  map args := f (args 0) (args 1) (args 2)
  multilinear := by
    intro i x y args
    fin_cases i
    · simp; rw [hAdd1 x y (args 1) (args 2)]; rfl
    · simp; rw [hAdd2 (args 0) x y (args 2)]; rfl
    · simp; rw [hAdd3 (args 0) (args 1) x y]; rfl
  smulCompat := by
    intro i a x args
    fin_cases i
    · simp; rw [hSmul1 a x (args 1) (args 2)]; rfl
    · simp; rw [hSmul2 a (args 0) x (args 2)]; rfl
    · simp; rw [hSmul3 a (args 0) (args 1) x]; rfl

/-- Compose a multilinear map with a linear map on the target. -/
def MultilinearMap.postcompose (M : MultilinearMap n V W) (f : W.V -> (fnSpace F 1).V)
    (hAdd : forall x y, f (W.add x y) = (fnSpace F 1).add (f x) (f y))
    (hSmul : forall a x, f (W.smul a x) = (fnSpace F 1).smul a (f x)) :
    MultilinearForm n V :=
  let map' (args : Fin n -> V.V) : (fnSpace F 1).V := f (M.map args)
  MultilinearMap.mk map'
    (by
      intro i x y args
      rw [M.multilinear i x y args, hAdd, MultilinearMap.eval])
    (by
      intro i a x args
      rw [M.smulCompat i a x args, hSmul])

end MiniMultilinearForm
