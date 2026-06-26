import MiniMultilinearForm.Core.Basic

namespace MiniMultilinearForm.Benchmark

open MiniMultilinearForm

variable {F : Field}

/-- Tensor product V⊗W: dimension = dim(V)·dim(W).
    Storage: for V=F^m, W=F^n, the tensor product space has dimension m·n. -/
def tensorProductDimension (m n : Nat) : Nat := m * n

/-- For m=n=10: dim = 100 (a 10×10 matrix space). -/
example : tensorProductDimension 10 10 = 100 := by
  unfold tensorProductDimension; rfl

/-- Tensor product of two maps: f⊗g on V1⊗W1 → V2⊗W2.
    Represented by Kronecker product of matrices: size (m1·n1)×(m2·n2). -/
def kroneckerSize (m1 n1 m2 n2 : Nat) : Nat := (m1 * m2) * (n1 * n2)

/-- Tensor contraction: C_{ij} = ∑_k T_{ik} ⊗ U_{kj}.
    Complexity: O(m·n·p) for T:m×n, U:n×p. -/
def tensorContractionComplexity (m n p : Nat) : Nat := m * n * p

/-- Symmetric power S^k(V): dimension = C(n+k-1, k) for dim(V)=n.
    Much smaller than tensor power n^k. -/
def symmetricPowerDimension (n k : Nat) : Nat :=
  -- dim(S^k(V)) when dim(V) = n
  -- = C(n+k-1, k) = (n+k-1)!/(k!(n-1)!)
  -- Simplified formula for small k
  Nat.choose (n + k - 1) k

/-- Exterior power Λ^k(V): dimension = C(n, k) for dim(V)=n.
    dim(Λ^k(F^n)) = binomial(n, k). -/
def exteriorPowerDimension (n k : Nat) : Nat := Nat.choose n k

end MiniMultilinearForm.Benchmark
