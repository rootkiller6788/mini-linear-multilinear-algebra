/-
# Main
Entry point for MiniInnerProductSpace.
Demonstrates the inner product space theory with concrete examples.
-/

import MiniInnerProductSpace

open MiniInnerProductSpace

def demonstrate_euclidean : IO Unit := do
  IO.println "=== Euclidean Inner Product on Q^3 ==="
  let x := vec3d 1 2 3
  let y := vec3d 4 5 6
  IO.println s!"x = (1, 2, 3)"
  IO.println s!"y = (4, 5, 6)"
  IO.println s!"<x,y> = {euclideanDot3 x y}"
  IO.println s!"||x||^2 = {euclideanNormSq3 x}"
  IO.println s!"||y||^2 = {euclideanNormSq3 y}"

def demonstrate_orthogonality : IO Unit := do
  IO.println "=== Orthogonality ==="
  let e1 := vec3d 1 0 0
  let e2 := vec3d 0 1 0
  let e3 := vec3d 0 0 1
  IO.println s!"e1 ⟂ e2 = {isOrthogonal3 e1 e2}"
  IO.println s!"e1 ⟂ e3 = {isOrthogonal3 e1 e3}"
  IO.println s!"e2 ⟂ e3 = {isOrthogonal3 e2 e3}"
  IO.println s!"<e1,e1> = {euclideanNormSq3 e1}"
  IO.println s!"<e2,e2> = {euclideanNormSq3 e2}"

def demonstrate_cauchySchwarz : IO Unit := do
  IO.println "=== Cauchy-Schwarz Inequality ==="
  IO.println s!"Verification for (1,2) . (3,4): {verifyCauchySchwarz2 1 2 3 4}"
  IO.println s!"Verification for (-1,2) . (-3,4): {verifyCauchySchwarz2 (-1) 2 (-3) 4}"

def demonstrate_pythagorean : IO Unit := do
  IO.println "=== Pythagorean Theorem ==="
  IO.println s!"Orthogonal vectors (3,0) . (0,4): {verifyPythagorean2 3 0 0 4}"
  IO.println s!"Orthogonal vectors (1,1) . (1,-1): {verifyPythagorean2 1 1 1 (-1)}"

def main : IO Unit := do
  IO.println "Mini Inner Product Space v1.0.0"
  IO.println "================================"
  IO.println ""
  IO.println "L1: Field, VectorSpace, InnerProduct, LinearMap, Basis"
  IO.println "L2: Norm, Orthogonality, Adjoint, Unitary, Projection"
  IO.println "L3: OrthonormalBasis, Signature, Product/Quotient Structures"
  IO.println "L4: Cauchy-Schwarz, Triangle, Riesz, Gram-Schmidt, Spectral"
  IO.println "L5: Polarization, Parseval, Minimization, Isometric transfer"
  IO.println "L6: Euclidean Q^n, Hermitian, L^2, Minkowski, Frobenius"
  IO.println "L7: Quantum, ML, PDE, Signal Processing, Algebra, Geometry"
  IO.println "L8: Hilbert, Krein, C*-algebras, Tensor Products"
  IO.println "L9: Condensed Math, Univalent Foundations, Synthetic Spectra"
  IO.println ""
  demonstrate_euclidean
  IO.println ""
  demonstrate_orthogonality
  IO.println ""
  demonstrate_cauchySchwarz
  IO.println ""
  demonstrate_pythagorean
  IO.println ""
  IO.println "================================"
  IO.println "MiniInnerProductSpace - All systems operational."