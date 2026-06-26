/-
# MiniSpectralCanonical.Properties.ClassificationData

L3-L4: Classification data structures for spectral theory.
Segre characteristic, Weyr characteristic, Jordan type,
partition data for nilpotent operators, and spectral graphs.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Properties.Invariants

namespace MiniSpectralCanonical

/-! ## L3: Segre Characteristic

For eigenvalue lambda, the Segre characteristic is the list of
Jordan block sizes for lambda, sorted decreasing.
The partition of algebraic multiplicity into Jordan blocks.
-/

structure SegreCharacteristic where
  eigenvalue : Rat
  blockSizes : List Nat
  isPartition : blockSizes.foldl (fun acc s => acc + s) 0 = blockSizes.length
  deriving Repr

def SegreCharacteristic.totalSize (sc : SegreCharacteristic) : Nat :=
  sc.blockSizes.foldl (fun acc s => acc + s) 0

/-! ## L3: Weyr Characteristic

The Weyr characteristic is the conjugate partition to the Segre
characteristic. It gives the nullities of powers of (A - lambda I).
-/

structure WeyrCharacteristic where
  eigenvalue : Rat
  nullities : List Nat
  deriving Repr

/-! ## L3: Jordan Type (Complete Data)

The Jordan type of A is the collection of Segre characteristics
for all eigenvalues. This completely classifies similarity classes
over algebraically closed fields.
-/

structure JordanType where
  characteristics : List SegreCharacteristic
  totalDimension : Nat
  deriving Repr

def Mat.jordanType2 (A : Mat 2 2) : JordanType :=
  let evs := Mat.eigenvalues2 A
  match evs with
  | [l1, l2] =>
    if l1 = l2 then
      -- Check if diagonalizable or defective
      let a := A 0 0; let b := A 0 1; let c := A 1 0; let d := A 1 1
      if a = l1 && d = l1 && b = 0 && c = 0 then
        -- Scalar matrix, two 1x1 blocks
        { characteristics := [{ eigenvalue := l1, blockSizes := [1, 1], isPartition := rfl }]
          totalDimension := 2 }
      else
        -- One 2x2 Jordan block
        { characteristics := [{ eigenvalue := l1, blockSizes := [2], isPartition := rfl }]
          totalDimension := 2 }
    else
      -- Two distinct eigenvalues, each 1x1
      { characteristics := [
          { eigenvalue := l1, blockSizes := [1], isPartition := rfl },
          { eigenvalue := l2, blockSizes := [1], isPartition := rfl }
        ]
        totalDimension := 2 }
  | [l] =>
    -- Single eigenvalue
    { characteristics := [{ eigenvalue := l, blockSizes := [1, 1], isPartition := rfl }]
      totalDimension := 2 }
  | _ =>
    { characteristics := []
      totalDimension := 2 }

/-! ## L3: Partition Data for Nilpotent Operators

Nilpotent similarity classes of size n correspond to integer
partitions of n. For n=2: partitions are [2] and [1,1].
-/

def numberOfPartitions : Nat -> Nat
  | 0 => 1
  | 1 => 1
  | 2 => 2
  | 3 => 3
  | 4 => 5
  | 5 => 7
  | 6 => 11
  | 7 => 15
  | n => numberOfPartitions (n-1) + numberOfPartitions (n-2)

def listPartitions (n : Nat) : List (List Nat) :=
  match n with
  | 0 => [[]]
  | 1 => [[1]]
  | 2 => [[2], [1,1]]
  | _ => [[n]]

/-! ## L3: Spectral Partition

For an eigenvalue with algebraic multiplicity m and
geometric multiplicity g, the spectral partition splits
m into g parts (sizes of Jordan blocks).
-/

structure SpectralPartition where
  totalDim : Nat
  parts : List (Nat x Nat)
  deriving Repr

/-! ## L3: Elementary Divisors

The elementary divisors are the invariant factors of A.
For F[t]-module structure, they are the polynomials (t-lambda)^k
for each Jordan block.
-/

structure ElementaryDivisor where
  eigenvalue : Rat
  exponent : Nat
  deriving Repr

def Mat.elementaryDivisors2 (A : Mat 2 2) : List ElementaryDivisor :=
  let evs := Mat.eigenvalues2 A
  match evs with
  | [l1, l2] =>
    if l1 = l2 then
      let a := A 0 0; let b := A 0 1; let c := A 1 0; let d := A 1 1
      if a = l1 && d = l1 && b = 0 && c = 0 then
        [{ eigenvalue := l1, exponent := 1 }, { eigenvalue := l1, exponent := 1 }]
      else
        [{ eigenvalue := l1, exponent := 2 }]
    else
      [{ eigenvalue := l1, exponent := 1 }, { eigenvalue := l2, exponent := 1 }]
  | [l] => [{ eigenvalue := l, exponent := 1 }, { eigenvalue := l, exponent := 1 }]
  | _ => []

/-! ## L3: Invariant Factors

The invariant factors f_1 | f_2 | ... | f_k are the monic polynomials
whose companion matrices form the rational canonical form.
For 2x2: either one degree-2 polynomial or two degree-1 polynomials.
-/

def Mat.invariantFactors2 (A : Mat 2 2) : List CharPoly :=
  let evs := Mat.eigenvalues2 A
  match evs with
  | [l1, l2] =>
    if l1 = l2 then
      let a := A 0 0; let b := A 0 1; let c := A 1 0; let d := A 1 1
      if a = l1 && d = l1 && b = 0 && c = 0 then
        [⟨[-l1, 1]⟩, ⟨[-l1, 1]⟩]
      else
        [⟨[l1*l1, -2*l1, 1]⟩]
    else
      [⟨[-l1, 1]⟩, ⟨[-l2, 1]⟩]
  | [l] => [⟨[-l, 1]⟩, ⟨[-l, 1]⟩]
  | _ => [Mat.charPoly2 A]

end MiniSpectralCanonical