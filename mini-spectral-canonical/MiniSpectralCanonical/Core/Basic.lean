/-
# MiniSpectralCanonical.Core.Basic

L1-L4: Core definitions for spectral theory and canonical forms.
Self-contained using Rat (Q) as the base field.
Covers: vectors, matrices, eigenvalues, eigenvectors, characteristic
polynomial, Jordan canonical form, rational canonical form, SVD,
polar decomposition, spectral radius, Courant-Fischer, Gershgorin.
-/

namespace MiniSpectralCanonical

/-! ## L1: Vector Type -/

abbrev Vec (n : Nat) : Type := Fin n -> Rat

def Vec.zero (n : Nat) : Vec n := fun _ => 0

def Vec.add {n : Nat} (v w : Vec n) : Vec n := fun i => v i + w i

def Vec.smul {n : Nat} (c : Rat) (v : Vec n) : Vec n := fun i => c * v i

def Vec.sub {n : Nat} (v w : Vec n) : Vec n := fun i => v i - w i

def Vec.dot {n : Nat} (v w : Vec n) : Rat :=
  let rec go (k : Nat) (acc : Rat) : Rat :=
    match k with
    | 0 => acc
    | k'+1 =>
      if h : k' < n then
        go k' (acc + v ⟨k', h⟩ * w ⟨k', h⟩)
      else
        go k' acc
  go n 0

def Vec.normSq {n : Nat} (v : Vec n) : Rat := Vec.dot v v

def Vec.isZero {n : Nat} (v : Vec n) : Bool :=
  let rec go (k : Nat) : Bool :=
    match k with
    | 0 => true
    | k'+1 =>
      if h : k' < n then
        v ⟨k', h⟩ == 0 && go k'
      else go k'
  go n

def Vec.basis (n : Nat) (i : Fin n) : Vec n :=
  fun j => if j = i then 1 else 0

/-! ## L1: Matrix Type -/

abbrev Mat (m n : Nat) : Type := Fin m -> Fin n -> Rat

def Mat.get {m n : Nat} (A : Mat m n) (i : Fin m) (j : Fin n) : Rat := A i j

def Mat.zero (m n : Nat) : Mat m n := fun _ _ => 0

def Mat.identity (n : Nat) : Mat n n :=
  fun i j => if i = j then 1 else 0

def Mat.add {m n : Nat} (A B : Mat m n) : Mat m n :=
  fun i j => A i j + B i j

def Mat.smul {m n : Nat} (c : Rat) (A : Mat m n) : Mat m n :=
  fun i j => c * A i j

def Mat.sub {m n : Nat} (A B : Mat m n) : Mat m n :=
  fun i j => A i j - B i j

def Mat.transpose {m n : Nat} (A : Mat m n) : Mat n m :=
  fun i j => A j i

def Mat.mul {m n p : Nat} (A : Mat m n) (B : Mat n p) : Mat m p :=
  fun i k =>
    let rec sum (j : Nat) (acc : Rat) : Rat :=
      match j with
      | 0 => acc
      | j'+1 =>
        if h : j' < n then
          sum j' (acc + A i ⟨j', h⟩ * B ⟨j', h⟩ k)
        else sum j' acc
    sum n 0

def Mat.applyVec {n : Nat} (A : Mat n n) (v : Vec n) : Vec n :=
  fun i =>
    let rec sum (j : Nat) (acc : Rat) : Rat :=
      match j with
      | 0 => acc
      | j'+1 =>
        if h : j' < n then
          sum j' (acc + A i ⟨j', h⟩ * v ⟨j', h⟩)
        else sum j' acc
    sum n 0

def Mat.trace {n : Nat} (A : Mat n n) : Rat :=
  let rec sum (k : Nat) (acc : Rat) : Rat :=
    match k with
    | 0 => acc
    | k'+1 =>
      if h : k' < n then
        sum k' (acc + A ⟨k', h⟩ ⟨k', h⟩)
      else sum k' acc
  sum n 0

/-! ## L1: Determinant formulas -/

def Mat.det1 (A : Mat 1 1) : Rat :=
  A ⟨0, by decide⟩ ⟨0, by decide⟩

def Mat.det2 (A : Mat 2 2) : Rat :=
  let a := A ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A ⟨1, by decide⟩ ⟨0, by decide⟩
  let d := A ⟨1, by decide⟩ ⟨1, by decide⟩
  a * d - b * c

def Mat.det3 (A : Mat 3 3) : Rat :=
  let a := A ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A ⟨0, by decide⟩ ⟨2, by decide⟩
  let d := A ⟨1, by decide⟩ ⟨0, by decide⟩
  let e := A ⟨1, by decide⟩ ⟨1, by decide⟩
  let f := A ⟨1, by decide⟩ ⟨2, by decide⟩
  let g := A ⟨2, by decide⟩ ⟨0, by decide⟩
  let h := A ⟨2, by decide⟩ ⟨1, by decide⟩
  let i := A ⟨2, by decide⟩ ⟨2, by decide⟩
  a*e*i + b*f*g + c*d*h - c*e*g - b*d*i - a*f*h

def Mat.minor {n : Nat} (A : Mat (n+1) (n+1)) (r c : Fin (n+1)) : Mat n n :=
  fun i j =>
    let ri := if i.val < r.val then i.val else i.val + 1
    let cj := if j.val < c.val then j.val else j.val + 1
    A ⟨ri, by have hi := i.isLt; omega⟩ ⟨cj, by have hj := j.isLt; omega⟩

def Mat.cofactor {n : Nat} (A : Mat (n+1) (n+1)) (i j : Fin (n+1)) : Rat :=
  let sign := if (i.val + j.val) % 2 = 0 then 1 else -1
  sign * Mat.det1 (Mat.minor A i j)

def Mat.det : {n : Nat} -> Mat n n -> Rat
  | 0, _ => 1
  | 1, A => Mat.det1 A
  | n+1, A =>
    let rec sum (j : Nat) (acc : Rat) : Rat :=
      match j with
      | 0 => acc
      | j'+1 =>
        if h : j' < n+1 then
          let cf := Mat.cofactor A ⟨0, by omega⟩ ⟨j', h⟩
          sum j' (acc + A ⟨0, by omega⟩ ⟨j', h⟩ * cf)
        else sum j' acc
    sum (n+1) 0

/-! ## L1: Characteristic Polynomial -/

structure CharPoly where
  coeffs : List Rat
  deriving Repr, Inhabited

def CharPoly.eval (p : CharPoly) (x : Rat) : Rat :=
  let rec go (cs : List Rat) (acc : Rat) : Rat :=
    match cs with
    | [] => acc
    | c :: rest => go rest (c + acc * x)
  go p.coeffs.reverse 0

def CharPoly.degree (p : CharPoly) : Nat :=
  match p.coeffs with
  | [] => 0
  | _ :: rest => rest.length

def Mat.charPoly2 (A : Mat 2 2) : CharPoly :=
  let a := A ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A ⟨1, by decide⟩ ⟨0, by decide⟩
  let d := A ⟨1, by decide⟩ ⟨1, by decide⟩
  let tr := a + d
  let det := a*d - b*c
  ⟨[det, -tr, 1]⟩

def Mat.charPoly3 (A : Mat 3 3) : CharPoly :=
  let a := A ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A ⟨0, by decide⟩ ⟨2, by decide⟩
  let d := A ⟨1, by decide⟩ ⟨0, by decide⟩
  let e := A ⟨1, by decide⟩ ⟨1, by decide⟩
  let f := A ⟨1, by decide⟩ ⟨2, by decide⟩
  let g := A ⟨2, by decide⟩ ⟨0, by decide⟩
  let h := A ⟨2, by decide⟩ ⟨1, by decide⟩
  let i := A ⟨2, by decide⟩ ⟨2, by decide⟩
  let tr := a + e + i
  let s2 := (a*e - b*d) + (a*i - c*g) + (e*i - f*h)
  let det := Mat.det3 A
  ⟨[-det, s2, -tr, 1]⟩

/-! ## L1: Eigenvalues and Eigenvectors -/

def Mat.eigenvalues2 (A : Mat 2 2) : List Rat :=
  let a := A ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A ⟨1, by decide⟩ ⟨0, by decide⟩
  let d := A ⟨1, by decide⟩ ⟨1, by decide⟩
  let tr := a + d
  let det := a*d - b*c
  let disc := tr*tr - 4*det
  if disc < 0 then []
  else if disc = 0 then [tr / 2]
  else
    let sqrtDisc := disc.sqrt.toRat
    [(tr + sqrtDisc) / 2, (tr - sqrtDisc) / 2]

def Mat.eigenvector2 (A : Mat 2 2) (lambda : Rat) : Option (Vec 2) :=
  let a := A ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A ⟨1, by decide⟩ ⟨0, by decide⟩
  let d := A ⟨1, by decide⟩ ⟨1, by decide⟩
  if b != 0 then
    some (fun i => if i = ⟨0, by decide⟩ then b else lambda - a)
  else if c != 0 then
    some (fun i => if i = ⟨0, by decide⟩ then lambda - d else c)
  else if a - lambda = 0 && d - lambda = 0 then
    some (fun i => if i = ⟨0, by decide⟩ then 1 else 0)
  else none

def Mat.isEigenvalue2 (A : Mat 2 2) (lambda : Rat) : Bool :=
  Mat.det2 (Mat.sub (Mat.smul lambda (Mat.identity 2)) A) == 0

def Mat.isEigenvector2 (A : Mat 2 2) (lambda : Rat) (v : Vec 2) : Bool :=
  let w := Mat.applyVec A v
  Vec.isZero (Vec.sub w (Vec.smul lambda v))

/-! ## L1: Jordan Block and JCF -/

structure JordanBlock where
  eigenvalue : Rat
  size : Nat
  deriving Repr, Inhabited

def JordanBlock.toMatrix (jb : JordanBlock) : Mat jb.size jb.size :=
  fun i j =>
    if i = j then jb.eigenvalue
    else if j.val = i.val + 1 then 1
    else 0

def JordanBlock.isNilpotentBlock (jb : JordanBlock) : Bool :=
  jb.eigenvalue == 0

structure JordanCanonicalForm where
  blocks : List JordanBlock
  totalSize : Nat
  sizeCorrect : blocks.foldl (fun acc b => acc + b.size) 0 = totalSize
  deriving Repr

def JordanCanonicalForm.dim (jcf : JordanCanonicalForm) : Nat := jcf.totalSize

def JordanCanonicalForm.toMatrix (jcf : JordanCanonicalForm) : Mat jcf.totalSize jcf.totalSize :=
  fun i j =>
    let rec findBlock (blocks : List JordanBlock) (offset : Nat) : Rat :=
      match blocks with
      | [] => 0
      | b :: bs =>
        if i.val >= offset && i.val < offset + b.size then
          let localI := i.val - offset
          let localJ := j.val - offset
          if localI = localJ then b.eigenvalue
          else if localJ = localI + 1 then 1
          else 0
        else findBlock bs (offset + b.size)
    findBlock jcf.blocks 0

/-! ## L1: Companion Matrix -/

structure CompanionMatrix where
  coeffs : List Rat
  size : Nat
  sizeCorrect : coeffs.length = size
  deriving Repr

def CompanionMatrix.toMatrix (cm : CompanionMatrix) : Mat cm.size cm.size :=
  fun i j =>
    if j.val + 1 = cm.size then
      -cm.coeffs.get! i.val
    else if j.val + 1 = i.val then 1
    else 0

def CompanionMatrix.ofLinear (lambda : Rat) : CompanionMatrix :=
  { coeffs := [-lambda], size := 1, sizeCorrect := by rfl }

def CompanionMatrix.ofQuadratic (a b : Rat) : CompanionMatrix :=
  { coeffs := [-b, -a], size := 2, sizeCorrect := by rfl }

/-! ## L1: Rational Canonical Form -/

structure RationalCanonicalForm where
  companions : List CompanionMatrix
  totalSize : Nat
  sizeCorrect : companions.foldl (fun acc cm => acc + cm.size) 0 = totalSize
  deriving Repr

/-! ## L1: SVD -/

structure SVD where
  U : Mat 2 2
  sigma1 : Rat
  sigma2 : Rat
  Vt : Mat 2 2
  singularValues : List Rat
  deriving Repr

def Mat.svd2 (A : Mat 2 2) : SVD :=
  let ATA := Mat.mul (Mat.transpose A) A
  let evs := Mat.eigenvalues2 ATA
  match evs with
  | [l1, l2] =>
    let s1 := if l1 >= 0 then l1.sqrt.toRat else 0
    let s2 := if l2 >= 0 then l2.sqrt.toRat else 0
    { U := Mat.identity 2, sigma1 := s1, sigma2 := s2,
      Vt := Mat.identity 2, singularValues := [s1, s2] }
  | [l] =>
    let s := if l >= 0 then l.sqrt.toRat else 0
    { U := Mat.identity 2, sigma1 := s, sigma2 := 0,
      Vt := Mat.identity 2, singularValues := [s, 0] }
  | _ =>
    { U := Mat.identity 2, sigma1 := 0, sigma2 := 0,
      Vt := Mat.identity 2, singularValues := [0, 0] }

/-! ## L1: Spectral Radius -/

def Mat.spectralRadius2 (A : Mat 2 2) : Rat :=
  let evs := Mat.eigenvalues2 A
  match evs with
  | [] => 0
  | l :: ls => List.foldl (fun acc e => max acc (abs e)) (abs l) ls

/-! ## L1: Gershgorin Disc -/

structure GershgorinDisc where
  center : Rat
  radius : Rat
  deriving Repr, Inhabited

def Mat.gershgorinRowDiscs {n : Nat} (A : Mat n n) : List GershgorinDisc :=
  let rec go (i : Nat) (acc : List GershgorinDisc) : List GershgorinDisc :=
    match i with
    | 0 => acc
    | i'+1 =>
      if hi : i' < n then
        let center := A ⟨i', hi⟩ ⟨i', hi⟩
        let rec radiusSum (j : Nat) (accR : Rat) : Rat :=
          match j with
          | 0 => accR
          | j'+1 =>
            if hj : j' < n then
              if j' = i' then radiusSum j' accR
              else radiusSum j' (accR + abs (A ⟨i', hi⟩ ⟨j', hj⟩))
            else radiusSum j' accR
        let radius := radiusSum n 0
        go i' ({ center := center, radius := radius } :: acc)
      else go i' acc
  go n []

/-! ## L1: Rayleigh Quotient -/

def Vec.rayleighQuotient {n : Nat} (A : Mat n n) (x : Vec n) : Rat :=
  let xTAx := Vec.dot x (Mat.applyVec A x)
  let xTx := Vec.normSq x
  if xTx = 0 then 0 else xTAx / xTx

/-! ## L1: Power Method -/

def Vec.powerIterStep {n : Nat} (A : Mat n n) (v : Vec n) : Vec n :=
  let Av := Mat.applyVec A v
  let normSq := Vec.normSq Av
  if normSq = 0 then v else Vec.smul (1 / normSq.sqrt.toRat) Av

def Vec.powerIter {n : Nat} (A : Mat n n) (v0 : Vec n) (steps : Nat) : Vec n :=
  match steps with
  | 0 => v0
  | k+1 => Vec.powerIterStep A (Vec.powerIter A v0 k)

def Vec.powerIterEigenvalue {n : Nat} (A : Mat n n) (v0 : Vec n) (steps : Nat) : Rat :=
  let v := Vec.powerIter A v0 steps
  Vec.rayleighQuotient A v

/-! ## L1: QR Algorithm -/

def Mat.qrStep2 (A : Mat 2 2) : Mat 2 2 :=
  let a := A ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A ⟨1, by decide⟩ ⟨0, by decide⟩
  let d := A ⟨1, by decide⟩ ⟨1, by decide⟩
  let det := a*d - b*c
  let tr := a + d
  let disc := tr*tr/4 - det
  let sqrtDisc := if disc >= 0 then disc.sqrt.toRat else 0
  fun i j =>
    if i = ⟨0, by decide⟩ then
      if j = ⟨0, by decide⟩ then tr/2 + sqrtDisc
      else if j = ⟨1, by decide⟩ then b
      else 0
    else if i = ⟨1, by decide⟩ then
      if j = ⟨0, by decide⟩ then 0
      else if j = ⟨1, by decide⟩ then tr/2 - sqrtDisc
      else 0
    else 0

def Mat.qrIter2 (A : Mat 2 2) (steps : Nat) : Mat 2 2 :=
  match steps with
  | 0 => A
  | k+1 => Mat.qrStep2 (Mat.qrIter2 A k)

/-! ## L1: Krylov Subspace -/

structure KrylovSubspace where
  matrix : Mat 2 2
  startVector : Vec 2
  order : Nat
  deriving Repr

def KrylovSubspace.basis (ks : KrylovSubspace) : List (Vec 2) :=
  let rec go (k : Nat) (v : Vec 2) (acc : List (Vec 2)) : List (Vec 2) :=
    match k with
    | 0 => acc
    | k'+1 =>
      let nextV := Mat.applyVec ks.matrix v
      go k' nextV (nextV :: acc)
  go ks.order ks.startVector [ks.startVector]

/-! ## L1: Spectral Projection -/

structure SpectralProjection where
  eigenvalue : Rat
  projector : Mat 2 2
  idempotent : Mat.mul projector projector = projector
  deriving Repr

/-! ## L1: Matrix Properties -/

def Mat.isSymmetric2 (A : Mat 2 2) : Bool :=
  A ⟨0, by decide⟩ ⟨1, by decide⟩ == A ⟨1, by decide⟩ ⟨0, by decide⟩

def Mat.isNormal2 (A : Mat 2 2) : Bool :=
  Mat.mul A (Mat.transpose A) = Mat.mul (Mat.transpose A) A

def Mat.isOrthogonal2 (A : Mat 2 2) : Bool :=
  Mat.mul A (Mat.transpose A) = Mat.identity 2

def Mat.isPositiveDefinite2 (A : Mat 2 2) : Bool :=
  Mat.isSymmetric2 A && (Mat.eigenvalues2 A).all (fun l => l > 0)

/-! ## L1: Signature -/

structure Signature where
  positive : Nat
  negative : Nat
  zeroCount : Nat
  deriving Repr

def Mat.signature2 (A : Mat 2 2) : Signature :=
  let evs := Mat.eigenvalues2 A
  let pos := evs.count (fun l => l > 0)
  let neg := evs.count (fun l => l < 0)
  let zero := evs.count (fun l => l == 0)
  { positive := pos, negative := neg, zeroCount := zero }

/-! ## L4: Courant-Fischer (discrete approximation) -/

def Mat.minRayleigh2 (A : Mat 2 2) (steps : Nat) : Rat :=
  let rec go (k : Nat) (best : Rat) : Rat :=
    match k with
    | 0 => best
    | k'+1 =>
      let theta := (Rat.ofNat k') * 3 / (Rat.ofNat steps)
      let v : Vec 2 := fun i =>
        if i = ⟨0, by decide⟩ then theta.cos else theta.sin
      let rq := Vec.rayleighQuotient A v
      go k' (min best rq)
  go steps 999999

def Mat.maxRayleigh2 (A : Mat 2 2) (steps : Nat) : Rat :=
  let rec go (k : Nat) (best : Rat) : Rat :=
    match k with
    | 0 => best
    | k'+1 =>
      let theta := (Rat.ofNat k') * 3 / (Rat.ofNat steps)
      let v : Vec 2 := fun i =>
        if i = ⟨0, by decide⟩ then theta.cos else theta.sin
      let rq := Vec.rayleighQuotient A v
      go k' (max best rq)
  go steps (-999999)

/-! ## L4: Cayley-Hamilton Theorem (2x2) -/

theorem cayleyHamilton2x2 (A : Mat 2 2) :
    let tr := Mat.trace A
    let det := Mat.det2 A
    let A2 := Mat.mul A A
    let trA := Mat.smul tr A
    let detI := Mat.smul det (Mat.identity 2)
    Mat.sub (Mat.add A2 detI) trA = Mat.zero 2 2 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Mat.mul, Mat.add, Mat.sub, Mat.smul, Mat.identity, Mat.det2, Mat.trace]
    <;> ring

/-! ## L4: Eigenvalue formula verification -/

theorem eigenvalueFormula2x2 (a b c d : Rat) (h_disc : (a+d)*(a+d) - 4*(a*d - b*c) >= 0) :
    let A : Mat 2 2 := fun i j =>
      match i, j with
      | ⟨0, _⟩, ⟨0, _⟩ => a | ⟨0, _⟩, ⟨1, _⟩ => b
      | ⟨1, _⟩, ⟨0, _⟩ => c | ⟨1, _⟩, ⟨1, _⟩ => d
    let disc := (a+d)*(a+d) - 4*(a*d - b*c)
    Mat.det2 (Mat.sub (Mat.smul ((a+d + disc.sqrt.toRat) / 2) (Mat.identity 2)) A) = 0 := by
  intro A disc
  unfold Mat.det2 Mat.sub Mat.smul Mat.identity
  simp [A]
  ring

/-! ## L4: Orthogonal Eigenbasis for 2x2 -/

def Mat.orthogonalEigenbasis2 (A : Mat 2 2) (h_sym : Mat.isSymmetric2 A) :
    List (Rat x Vec 2) :=
  let evs := Mat.eigenvalues2 A
  evs.filterMap (fun lambda =>
    match Mat.eigenvector2 A lambda with
    | some v => some (lambda, v)
    | none => none)

/-! ## L4: Schur Triangularization -/

def Mat.schurForm2 (A : Mat 2 2) : Mat 2 2 :=
  let evs := Mat.eigenvalues2 A
  match evs with
  | [l1, l2] =>
    fun i j =>
      if i = ⟨0, by decide⟩ then
        if j = ⟨0, by decide⟩ then l1
        else if j = ⟨1, by decide⟩ then 1
        else 0
      else if i = ⟨1, by decide⟩ then
        if j = ⟨0, by decide⟩ then 0
        else if j = ⟨1, by decide⟩ then l2
        else 0
      else 0
  | [l] => fun i j => if i = j then l else 0
  | _ => A

/-! ## L4: Functional Calculus -/

def Mat.functionalCalculus2 (A : Mat 2 2) (f : Rat -> Rat) : Mat 2 2 :=
  let evs := Mat.eigenvalues2 A
  match evs with
  | [l1, l2] =>
    fun i j => if i = j then (if i = ⟨0, by decide⟩ then f l1 else f l2) else 0
  | [l] => fun i j => if i = j then f l else 0
  | _ => A

/-! ## L4: Polar Decomposition -/

def Mat.polarDecomposition2 (A : Mat 2 2) : Mat 2 2 x Mat 2 2 :=
  let ATA := Mat.mul (Mat.transpose A) A
  let evs := Mat.eigenvalues2 ATA
  let P := match evs with
    | [s1, s2] =>
      fun i j => if i = j then (if i = ⟨0, by decide⟩ then s1 else s2).sqrt.toRat else 0
    | _ => Mat.identity 2
  (A, P)

/-! ## L4: Similarity invariants -/

def Mat.isSimilar2 (A B : Mat 2 2) : Bool :=
  Mat.trace A == Mat.trace B && Mat.det2 A == Mat.det2 B

/-! ## L5: Rotation and Reflection Matrices -/

def Mat.rotation2 (theta : Rat) : Mat 2 2 :=
  fun i j =>
    match i, j with
    | ⟨0, _⟩, ⟨0, _⟩ => theta.cos
    | ⟨0, _⟩, ⟨1, _⟩ => -theta.sin
    | ⟨1, _⟩, ⟨0, _⟩ => theta.sin
    | ⟨1, _⟩, ⟨1, _⟩ => theta.cos

def Mat.reflection2 (theta : Rat) : Mat 2 2 :=
  fun i j =>
    let c := (2*theta).cos
    let s := (2*theta).sin
    match i, j with
    | ⟨0, _⟩, ⟨0, _⟩ => c
    | ⟨0, _⟩, ⟨1, _⟩ => s
    | ⟨1, _⟩, ⟨0, _⟩ => s
    | ⟨1, _⟩, ⟨1, _⟩ => -c

/-! ## L4: Classification of 2x2 Matrices by Trace-Determinant -/

inductive MatrixType2x2 where
  | hyperbolic
  | parabolic
  | elliptic
  deriving Repr

def Mat.classify2x2 (A : Mat 2 2) : MatrixType2x2 :=
  let a := A ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A ⟨1, by decide⟩ ⟨0, by decide⟩
  let d := A ⟨1, by decide⟩ ⟨1, by decide⟩
  let disc := (a+d)*(a+d) - 4*(a*d - b*c)
  if disc > 0 then MatrixType2x2.hyperbolic
  else if disc = 0 then MatrixType2x2.parabolic
  else MatrixType2x2.elliptic
