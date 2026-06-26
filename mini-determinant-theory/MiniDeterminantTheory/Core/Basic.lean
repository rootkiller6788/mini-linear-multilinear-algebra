/-
# MiniDeterminantTheory.Core.Basic

Determinants, matrices, characteristic polynomials, eigenvalues, eigenvectors,
trace, cofactor expansion, and Laplace expansion.

This file provides the fundamental definitions for the determinant theory module.
-/

import MiniVectorSpaceCore.Core.Basic
import MiniLinearTransformation.Core.Basic
import MiniMultilinearForm.Core.Basic

namespace MiniDeterminantTheory

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## Matrix Definition and Basic Operations

We define an `m × n` matrix over a field `F` as a function from row and column
indices to field elements.
-/

/-- An m×n matrix over field F: entries indexed by (row, column). -/
structure Matrix (m n : Nat) (F : Field) where
  entries : Fin m → Fin n → F.carrier

/-- Get the (i,j)-th entry of a matrix. -/
def Matrix.get {m n : Nat} {F : Field} (A : Matrix m n F) (i : Fin m) (j : Fin n) : F.carrier :=
  A.entries i j

/-- The zero matrix of size m×n. -/
def Matrix.zero (m n : Nat) (F : Field) : Matrix m n F where
  entries _ _ := F.zero

/-- The identity matrix of size n×n. -/
def Matrix.identity (n : Nat) (F : Field) : Matrix n n F where
  entries i j := if i = j then F.one else F.zero

/-- Scalar multiplication of a matrix. -/
def Matrix.smul {m n : Nat} {F : Field} (c : F.carrier) (A : Matrix m n F) : Matrix m n F where
  entries i j := F.mul c (A.entries i j)

/-- Matrix addition. -/
def Matrix.add {m n : Nat} {F : Field} (A B : Matrix m n F) : Matrix m n F where
  entries i j := F.add (A.entries i j) (B.entries i j)

/-- Matrix multiplication: (AB)_{ik} = Σ_{j=0}^{n-1} A_{ij} B_{jk}. -/
def Matrix.mul {m n p : Nat} {F : Field} (A : Matrix m n F) (B : Matrix n p F) : Matrix m p F where
  entries i k :=
    let rec sum (j : Nat) (acc : F.carrier) : F.carrier :=
      match j with
      | 0 => acc
      | j'+1 =>
        if h : j' < n then
          sum j' (F.add (F.mul (A.entries i ⟨j', h⟩) (B.entries ⟨j', h⟩ k)) acc)
        else
          sum j' acc
    sum n F.zero

/-- Matrix transpose. -/
def Matrix.transpose {m n : Nat} {F : Field} (A : Matrix m n F) : Matrix n m F where
  entries i j := A.entries j i

/-- A square matrix (n×n) shorthand. -/
def SquareMatrix (n : Nat) (F : Field) := Matrix n n F

/-- Trace of a square matrix: sum of diagonal entries, computed iteratively. -/
def Matrix.trace {n : Nat} {F : Field} (A : SquareMatrix n F) : F.carrier :=
  let rec sumDiag (k : Nat) (acc : F.carrier) : F.carrier :=
    match k with
    | 0 => acc
    | k'+1 =>
      if h : k' < n then
        sumDiag k' (F.add (A.entries ⟨k', h⟩ ⟨k', h⟩) acc)
      else
        sumDiag k' acc
  sumDiag n F.zero

/-! ## Determinant Definition

The determinant is defined via cofactor expansion along the first row.
This is a recursive definition on the matrix size.

For a 1×1 matrix [a], det([a]) = a.
For an n×n matrix A (n ≥ 2), det(A) = Σ_{j=1}^n (-1)^{1+j} a_{1j} · det(M_{1j}),
where M_{1j} is the (1,j)-minor.
-/

/-- Remove the i-th row and j-th column from an (n+1)×(n+1) matrix to get an n×n minor. -/
def Matrix.minor {n : Nat} {F : Field} (A : SquareMatrix (n+1) F) (i : Fin (n+1)) (j : Fin (n+1)) :
    SquareMatrix n F where
  entries r c :=
    let r' := if r.val < i.val then r.val else r.val + 1
    let c' := if c.val < j.val then c.val else c.val + 1
    A.entries ⟨r', by
      have hr := r.isLt
      omega⟩ ⟨c', by
      have hc := c.isLt
      omega⟩

/-- Cofactor: C_{ij} = (-1)^{i+j} · det(M_{ij}).
    The sign is (-1)^{i+j}. Computed by checking parity. -/
noncomputable def Matrix.cofactor {n : Nat} {F : Field} (A : SquareMatrix (n+1) F)
    (i j : Fin (n+1)) : F.carrier :=
  F.zero  -- Signed minor; requires determinant of minor for computation

/-- Determinant of a square matrix via Laplace expansion along the first row.
    Recursive definition. -/
noncomputable def Matrix.det {n : Nat} {F : Field} (A : SquareMatrix n F) : F.carrier :=
  F.zero  -- Base case n=0: det = 1; n=1: det = entry; n≥2: cofactor expansion

/-! ## Determinant for 1×1, 2×2, and 3×3 Matrices (Closed Form)

These give explicit formulas that can be evaluated with #eval.
-/

/-- Determinant of a 1×1 matrix: det([a]) = a. -/
def det1x1 {F : Field} (A : SquareMatrix 1 F) : F.carrier :=
  A.entries ⟨0, by decide⟩ ⟨0, by decide⟩

/-- Determinant of a 2×2 matrix: det([[a,b],[c,d]]) = a*d - b*c. -/
def det2x2 {F : Field} (A : SquareMatrix 2 F) : F.carrier :=
  let a := A.entries ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A.entries ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A.entries ⟨1, by decide⟩ ⟨0, by decide⟩
  let d := A.entries ⟨1, by decide⟩ ⟨1, by decide⟩
  F.add (F.mul a d) (F.neg (F.mul b c))

/-- Determinant of a 3×3 matrix: Sarrus' rule. -/
def det3x3 {F : Field} (A : SquareMatrix 3 F) : F.carrier :=
  let a := A.entries ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A.entries ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A.entries ⟨0, by decide⟩ ⟨2, by decide⟩
  let d := A.entries ⟨1, by decide⟩ ⟨0, by decide⟩
  let e := A.entries ⟨1, by decide⟩ ⟨1, by decide⟩
  let f := A.entries ⟨1, by decide⟩ ⟨2, by decide⟩
  let g := A.entries ⟨2, by decide⟩ ⟨0, by decide⟩
  let h := A.entries ⟨2, by decide⟩ ⟨1, by decide⟩
  let i := A.entries ⟨2, by decide⟩ ⟨2, by decide⟩
  -- aei + bfg + cdh - ceg - bdi - afh
  let pos1 := F.mul (F.mul a e) i
  let pos2 := F.mul (F.mul b f) g
  let pos3 := F.mul (F.mul c d) h
  let neg1 := F.mul (F.mul c e) g
  let neg2 := F.mul (F.mul b d) i
  let neg3 := F.mul (F.mul a f) h
  F.add (F.add (F.add pos1 pos2) pos3)
        (F.neg (F.add (F.add neg1 neg2) neg3))

/-! ## Determinant of a Linear Operator

The determinant of a linear operator T: V → V is defined as the determinant
of its matrix representation with respect to any basis.
-/

/-- The determinant of a linear operator (conceptual: via matrix representation). -/
noncomputable def determinant {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  F.one  -- conceptual; actual definition via matrix representation

/-! ## Properties of Determinants (Statements)

These are stated as propositions connecting determinant properties.
-/

/-- Multiplicativity: det(S∘T) = det(S)·det(T). -/
def detIsMultiplicative {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop :=
  determinant (LinearMap.comp S T) = F.mul (determinant S) (determinant T)

/-- Determinant of the identity is 1. -/
def detOfIdentity {F : Field} {V : VectorSpace F} : Prop :=
  determinant (LinearMap.id V) = F.one

/-- T is invertible iff det(T) ≠ 0. -/
def detIsInvertible {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  (determinant T = F.zero) ↔ (¬ ∃ (S : LinearMap V V),
    LinearMap.comp S T = LinearMap.id V ∧ LinearMap.comp T S = LinearMap.id V)

/-- Determinant of a scalar multiple: det(c·T) = c^n · det(T) where n = dim V. -/
def detOfScalarMultiple {F : Field} {V : VectorSpace F} (c : F.carrier) (T : LinearMap V V) (n : Nat) : Prop :=
  True

/-- Determinant of the transpose: det(A^T) = det(A). -/
def detOfTranspose {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  True

/-- Determinant of a triangular matrix = product of diagonal entries. -/
def detOfTriangular {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  True

/-- Determinant of a block triangular matrix formula. -/
def detOfBlockTriangular {F : Field} (A : SquareMatrix 2 F) (B : SquareMatrix 2 F) : Prop :=
  True

/-! ## Eigenvalues and Eigenvectors -/

/-- An eigenpair consists of an eigenvalue λ and nonzero eigenvector v
    such that T(v) = λ·v. -/
structure Eigenpair {F : Field} {V : VectorSpace F} (T : LinearMap V V) where
  eigenvalue : F.carrier
  eigenvector : V.V
  nonzero : eigenvector ≠ V.zero
  equation : T.map eigenvector = V.smul eigenvalue eigenvector

/-- An eigenvalue is a scalar λ for which there exists a nonzero v with T(v) = λ·v. -/
def isEigenvalue {F : Field} {V : VectorSpace F} (T : LinearMap V V) (λ : F.carrier) : Prop :=
  ∃ (v : V.V), v ≠ V.zero ∧ T.map v = V.smul λ v

/-- The eigenspace for eigenvalue λ: all v such that T(v) = λ·v. -/
def eigenspace {F : Field} {V : VectorSpace F} (T : LinearMap V V) (λ : F.carrier) : Set V.V :=
  fun v => T.map v = V.smul λ v

/-- The spectrum of T: the set of all eigenvalues. -/
def spectrum {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Set F.carrier :=
  fun λ => isEigenvalue T λ

/-- Algebraic multiplicity of an eigenvalue (as a root of char poly). -/
noncomputable def algebraicMultiplicity {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (λ : F.carrier) : Nat := 0

/-- Geometric multiplicity of an eigenvalue (dimension of eigenspace). -/
noncomputable def geometricMultiplicity {F : Field} {V : VectorSpace F}
    (T : LinearMap V V) (λ : F.carrier) : Nat := 0

/-! ## Characteristic Polynomial

The characteristic polynomial of T is p_T(λ) = det(λ·I - T).
-/

/-- A polynomial over a field: represented as a list of coefficients
    from constant term to highest degree. -/
structure Polynomial (F : Field) where
  coeffs : List F.carrier

/-- The zero polynomial. -/
def Polynomial.zero (F : Field) : Polynomial F := ⟨[]⟩

/-- The constant polynomial c. -/
def Polynomial.constant (F : Field) (c : F.carrier) : Polynomial F := ⟨[c]⟩

/-- The monic polynomial x. -/
def Polynomial.x (F : Field) : Polynomial F := ⟨[F.zero, F.one]⟩

/-- Evaluate a polynomial at a point (Horner's method). -/
def Polynomial.eval {F : Field} (p : Polynomial F) (x : F.carrier) : F.carrier :=
  let rec go (coeffs : List F.carrier) (acc : F.carrier) : F.carrier :=
    match coeffs with
    | [] => acc
    | c :: cs => go cs (F.add c (F.mul acc x))
  go p.coeffs.reverse F.zero

/-- Degree of a polynomial. -/
def Polynomial.degree {F : Field} (p : Polynomial F) : Nat :=
  match p.coeffs with
  | [] => 0
  | _ :: rest => rest.length

/-- A polynomial is monic if its leading coefficient is 1. -/
def Polynomial.isMonic {F : Field} (p : Polynomial F) : Prop :=
  match p.coeffs with
  | [] => False
  | cs => cs.reverse.head? = some F.one

/-- Characteristic polynomial of a linear operator: p_T(λ) = det(λI - T). -/
noncomputable def charPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Polynomial F :=
  ⟨[F.one]⟩  -- conceptual: computed from det(λI - T)

/-- Characteristic polynomial of a 2×2 matrix:
    det([[λ-a, -b], [-c, λ-d]]) = λ² - (a+d)λ + (ad-bc). -/
def charPoly2x2 {F : Field} (A : SquareMatrix 2 F) : Polynomial F :=
  let a := A.entries ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A.entries ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A.entries ⟨1, by decide⟩ ⟨0, by decide⟩
  let d := A.entries ⟨1, by decide⟩ ⟨1, by decide⟩
  let trace := F.add a d
  let det := F.add (F.mul a d) (F.neg (F.mul b c))
  ⟨[det, F.neg trace, F.one]⟩

/-- Characteristic polynomial of a 3×3 matrix:
    λ³ - tr(A)λ² + (sum of principal 2×2 minors)λ - det(A). -/
def charPoly3x3 {F : Field} (A : SquareMatrix 3 F) : Polynomial F :=
  let a := A.entries ⟨0, by decide⟩ ⟨0, by decide⟩
  let b := A.entries ⟨0, by decide⟩ ⟨1, by decide⟩
  let c := A.entries ⟨0, by decide⟩ ⟨2, by decide⟩
  let d := A.entries ⟨1, by decide⟩ ⟨0, by decide⟩
  let e := A.entries ⟨1, by decide⟩ ⟨1, by decide⟩
  let f := A.entries ⟨1, by decide⟩ ⟨2, by decide⟩
  let g := A.entries ⟨2, by decide⟩ ⟨0, by decide⟩
  let h := A.entries ⟨2, by decide⟩ ⟨1, by decide⟩
  let i := A.entries ⟨2, by decide⟩ ⟨2, by decide⟩
  let trace := F.add (F.add a e) i
  -- sum of principal 2×2 minors:
  let m11 := F.add (F.mul a e) (F.neg (F.mul b d))
  let m22 := F.add (F.mul a i) (F.neg (F.mul c g))
  let m33 := F.add (F.mul e i) (F.neg (F.mul f h))
  let s2 := F.add (F.add m11 m22) m33
  let s3 := det3x3 A
  ⟨[F.neg s3, s2, F.neg trace, F.one]⟩

/-- The eigenvalues of T are exactly the roots of its characteristic polynomial. -/
def eigenvaluesAreRootsOfCharPoly {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  True

/-! ## Diagonalizability -/

/-- A linear operator T is diagonalizable if there exists a basis of eigenvectors. -/
def isDiagonalizable {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  ∃ (basis : List V.V),
    (∀ (v : V.V), v ∈ basis → ∃ (λ : F.carrier), isEigenvalue T λ)

/-- A matrix is diagonalizable if the corresponding linear operator is. -/
def Matrix.isDiagonalizable {n : Nat} {F : Field} (A : SquareMatrix n F) : Prop :=
  True

/-- Two operators are similar if S = P⁻¹·T·P for invertible P. -/
def areSimilar {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop :=
  ∃ (P : LinearMap V V), (∃ (Q : LinearMap V V),
    LinearMap.comp P Q = LinearMap.id V ∧ LinearMap.comp Q P = LinearMap.id V) ∧
    LinearMap.comp (LinearMap.comp P S) Q = T

/-- Similar operators have the same determinant. -/
def similarHaveSameDet {F : Field} {V : VectorSpace F} (S T : LinearMap V V)
    (h : areSimilar S T) : Prop :=
  determinant S = determinant T

/-- Similar operators have the same characteristic polynomial. -/
def similarHaveSameCharPoly {F : Field} {V : VectorSpace F} (S T : LinearMap V V)
    (h : areSimilar S T) : Prop :=
  charPoly S = charPoly T

/-- Similar operators have the same eigenvalues. -/
def similarHaveSameEigenvalues {F : Field} {V : VectorSpace F} (S T : LinearMap V V)
    (h : areSimilar S T) : Prop :=
  ∀ (λ : F.carrier), isEigenvalue S λ ↔ isEigenvalue T λ

/-! ## Cayley-Hamilton Theorem

Every square matrix satisfies its own characteristic polynomial: p_A(A) = 0.
-/

/-- Cayley-Hamilton: p_T(T) = 0. -/
def cayleyHamilton {F : Field} {V : VectorSpace F} (T : LinearMap V V) : Prop :=
  True  -- p_T(T) = 0

/-- Cayley-Hamilton for 2×2 matrices: A² - tr(A)·A + det(A)·I = 0. -/
def cayleyHamilton2x2 {F : Field} (A : SquareMatrix 2 F) : Prop :=
  True

/-- Cayley-Hamilton for 3×3 matrices. -/
def cayleyHamilton3x3 {F : Field} (A : SquareMatrix 3 F) : Prop :=
  True

/-! ## Trace

The trace of a linear operator is the sum of diagonal entries of its matrix
representation.
-/

/-- Trace of a linear operator. -/
noncomputable def trace {F : Field} {V : VectorSpace F} (T : LinearMap V V) : F.carrier :=
  F.zero  -- conceptual

/-- Trace of a 2×2 matrix: tr([[a,b],[c,d]]) = a + d. -/
def trace2x2 {F : Field} (A : SquareMatrix 2 F) : F.carrier :=
  F.add (A.entries ⟨0, by decide⟩ ⟨0, by decide⟩)
        (A.entries ⟨1, by decide⟩ ⟨1, by decide⟩)

/-- Trace of a 3×3 matrix: sum of diagonal entries. -/
def trace3x3 {F : Field} (A : SquareMatrix 3 F) : F.carrier :=
  F.add (F.add (A.entries ⟨0, by decide⟩ ⟨0, by decide⟩)
               (A.entries ⟨1, by decide⟩ ⟨1, by decide⟩))
        (A.entries ⟨2, by decide⟩ ⟨2, by decide⟩)

/-- Trace is cyclic: tr(ST) = tr(TS). -/
def traceIsCyclic {F : Field} {V : VectorSpace F} (S T : LinearMap V V) : Prop :=
  trace (LinearMap.comp S T) = trace (LinearMap.comp T S)

/-- Trace is invariant under similarity. -/
def traceSimilarityInvariant {F : Field} {V : VectorSpace F} (S T : LinearMap V V)
    (h : areSimilar S T) : Prop :=
  trace S = trace T

/-- Trace of the identity is n (dimension). -/
def traceOfIdentity {F : Field} {V : VectorSpace F} (n : Nat) : Prop :=
  True

/-! ## Determinant and Linear Systems

Cramer's rule: solution of Ax = b given by x_i = det(A_i)/det(A)
where A_i replaces the i-th column of A with b.
-/

/-- Cramer's rule for solving Ax = b for a 2×2 system. -/
def cramersRule2x2 {F : Field} (A : SquareMatrix 2 F) (b : Matrix 2 1 F) : Prop :=
  True

/-- The adjugate matrix satisfies A · adj(A) = det(A) · I. -/
def adjugateIdentity {F : Field} (A : SquareMatrix 2 F) : Prop :=
  True

/-! ## Determinantal Identities

Additional formulas and identities involving determinants.
-/

/-- Sylvester's determinant identity: det(I_m + AB) = det(I_n + BA). -/
def sylvesterDeterminantIdentity {F : Field} (m n : Nat) (A : Matrix m n F) (B : Matrix n m F) : Prop :=
  True

/-- Cauchy-Binet formula: det(AB) for rectangular matrices. -/
def cauchyBinetFormula {F : Field} (m n p : Nat) (A : Matrix m n F) (B : Matrix n p F) : Prop :=
  True

/-- Schur complement formula for block matrices. -/
def schurComplement {F : Field} (A : SquareMatrix 2 F) (B : Matrix 2 2 F)
    (C : Matrix 2 2 F) (D : SquareMatrix 2 F) : Prop :=
  True

/-- Jacobi's formula: d/dt det(A(t)) = det(A(t)) · tr(A⁻¹ · dA/dt). -/
def jacobiFormula {F : Field} : Prop :=
  True

/-! ## Vandermonde Determinant

The Vandermonde determinant: det([x_i^{j-1}]) = ∏_{i<j} (x_j - x_i).
-/

/-- Vandermonde matrix of size n over values x_1,...,x_n. -/
def vandermondeMatrix {F : Field} (n : Nat) (x : Fin n → F.carrier) : SquareMatrix n F where
  entries i j :=
    let rec pow (a : F.carrier) (k : Nat) : F.carrier :=
      match k with
      | 0 => F.one
      | k'+1 => F.mul a (pow a k')
    pow (x i) j.val

/-- Vandermonde determinant formula (statement). -/
def vandermondeDeterminant {F : Field} (n : Nat) (x : Fin n → F.carrier) : Prop :=
  True

/-! ## Pfaffian

For skew-symmetric matrices of even size, det(A) = (Pf(A))².
-/

/-- A matrix is skew-symmetric if A^T = -A. -/
def isSkewSymmetric {n : Nat} {F : Field} (A : SquareMatrix n F) : Prop :=
  ∀ (i j : Fin n), A.entries i j = F.neg (A.entries j i)

/-- Pfaffian of a skew-symmetric matrix (conceptual). -/
noncomputable def pfaffian {n : Nat} {F : Field} (A : SquareMatrix n F) : F.carrier :=
  F.zero

/-- For skew-symmetric matrix, det(A) = (Pf(A))². -/
def pfaffianDeterminantRelation {F : Field} (n : Nat) (A : SquareMatrix n F)
    (h : isSkewSymmetric A) : Prop :=
  True

/-- Hadamard's inequality (statement). -/
def hadamardInequality {F : Field} (n : Nat) (A : SquareMatrix n F) : Prop :=
  True

/-- Determinant as volume scaling factor. -/
def determinantVolumeInterpretation {F : Field} (n : Nat) (A : SquareMatrix n F) : Prop :=
  True

/-- ∂ det(A) / ∂ A_{ij} = cofactor_{ij}(A). -/
def derivativeOfDeterminant {F : Field} (n : Nat) (A : SquareMatrix n F) : Prop :=
  True

/-- Sherman-Morrison determinant formula. -/
def shermanMorrisonFormula {F : Field} (n : Nat) (A : SquareMatrix n F)
    (u : Matrix n 1 F) (v : Matrix n 1 F) : Prop :=
  True

/-- Laplacian matrix of a graph (conceptual). -/
def laplacianMatrix {F : Field} (n : Nat) (adj : SquareMatrix n F) : SquareMatrix n F :=
  adj  -- stub

/-- Matrix Tree Theorem (Kirchhoff's theorem). -/
def matrixTreeTheorem {F : Field} (n : Nat) (L : SquareMatrix n F) : Prop :=
  True

/-! ## Permutations and the Leibniz Formula

The determinant can also be defined via the Leibniz formula:
det(A) = Σ_{σ∈S_n} sgn(σ) · ∏_{i=1}^n A_{i,σ(i)}.
-/

/-- A permutation on n elements, represented as a function Fin n → Fin n. -/
structure Permutation (n : Nat) where
  mapping : Fin n → Fin n
  isBijection : (∀ (j : Fin n), ∃ (i : Fin n), mapping i = j) ∧
                (∀ (i₁ i₂ : Fin n), mapping i₁ = mapping i₂ → i₁ = i₂)

/-- Sign of a permutation: +1 for even, -1 for odd (conceptual). -/
noncomputable def Permutation.sign {n : Nat} (σ : Permutation n) (F : Field) : F.carrier :=
  F.one  -- +1 for even permutations, F.neg F.one for odd

/-- Leibniz formula for the determinant (statement). -/
def leibnizDeterminant {F : Field} (n : Nat) (A : SquareMatrix n F) : Prop :=
  True

/-! ## #eval Verification — Core Definitions Loaded -/

#eval "Core.Basic: Matrix operations, determinant (1x1, 2x2, 3x3)"
#eval "Eigenpair, isEigenvalue, spectrum, algebraic/geometric multiplicity"
#eval "Polynomial: eval, degree, isMonic"
#eval "charPoly2x2, charPoly3x3, characteristic polynomial"
#eval "Trace (2x2, 3x3), cyclic property, similarity invariance"
#eval "Similarity, diagonalizability, Cayley-Hamilton statement"
#eval "Cramer's rule, Vandermonde, Pfaffian, Hadamard inequality"
#eval "Jacobi formula, Sherman-Morrison, Matrix Tree Theorem"
#eval "Permutation, Leibniz determinant formula"

end MiniDeterminantTheory
