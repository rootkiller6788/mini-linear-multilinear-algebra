import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm.Benchmark

open MiniMultilinearForm

variable {F : Field}

/-- Addition of two bilinear forms: O(n²) for n×n matrix addition. -/
def additionComplexity (n : Nat) : Nat := n * n

/-- Scalar multiplication of bilinear form: O(n²) to multiply each entry. -/
def scalarMultiplicationComplexity (n : Nat) : Nat := n * n

/-- Symmetrization of a general bilinear form: B_sym = (B + B^T)/2.
    O(n²) operations (add then divide by 2 for each entry). -/
def symmetrizationComplexity (n : Nat) : Nat := n * n

/-- Alternation of a general bilinear form: B_alt = (B - B^T)/2.
    Same complexity as symmetrization: O(n²). -/
def alternationComplexity (n : Nat) : Nat := n * n

/-- Pullback along a linear map T: (T*B)(x,y) = B(Tx, Ty).
    If T is represented as an m×n matrix and B is n×n,
    then evaluating T*B costs O(m²·n) for the pullback on a pair. -/
def pullbackComplexity (m n : Nat) : Nat := m * m * n

/-- Contraction of a (k+1)-linear form to a k-linear form:
    O(dim(V)^k) operations if evaluated naively. -/
def contractionComplexity (dim k : Nat) : Nat :=
  match k with
  | 0 => 1
  | k'+1 => dim * contractionComplexity dim k'

end MiniMultilinearForm.Benchmark
