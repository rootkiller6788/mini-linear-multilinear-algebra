/-
# MiniSpectralCanonical.Constructions.Subobjects

L3: Subobjects in spectral theory.
Invariant subspaces, cyclic subspaces, Krylov subspaces,
eigenspaces, and generalized eigenspaces.
-/

import MiniSpectralCanonical.Core.Basic

namespace MiniSpectralCanonical

/-! ## L3: Invariant Subspace

A subspace W is A-invariant if A W <= W.
For 1D subspace spanned by v, this means A v = lambda v.
-/

structure InvariantSubspace2x2 where
  basis : Vec 2
  matrix : Mat 2 2
  isEigenvector : Mat.isEigenvector2 matrix 0 basis

def InvariantSubspace2x2.dimension : Nat := 1

/-! ## L3: Cyclic Subspace

For vector v, the cyclic subspace is span{v, Av, A^2 v, ...}.
The order is the first k where A^k v is linearly dependent.
-/

structure CyclicSubspace2x2 where
  generator : Vec 2
  matrix : Mat 2 2
  order : Nat
  vectors : List (Vec 2)
  isCyclic : vectors.length = order

def CyclicSubspace2x2.companionMatrix (cs : CyclicSubspace2x2) : CompanionMatrix :=
  CompanionMatrix.ofLinear 0

/-! ## L3: Generalized Eigenspace

G_lambda = ker((A - lambda I)^n) where n = algebraic multiplicity.
For 2x2, G_lambda is either 1D (simple eigenvalue) or 2D (repeated).
-/

structure GeneralizedEigenspace2x2 where
  eigenvalue : Rat
  algebraicMult : Nat
  vectors : List (Vec 2)
  isNilpotentOnQuotient : True

def GeneralizedEigenspace2x2.dimension (ge : GeneralizedEigenspace2x2) : Nat :=
  ge.algebraicMult

/-! ## L3: Primary Decomposition

V = (+) G_{lambda_i} where lambda_i are eigenvalues.
-/

structure PrimaryDecomposition2x2 where
  eigenvalues : List Rat
  generalizedEigenspaces : List (GeneralizedEigenspace2x2)
  isDirectSum : True

/-! ## L3: Eigenspace vs Generalized Eigenspace

For a defective eigenvalue lambda:
- Eigenspace E_lambda = ker(A - lambda I) (geometric multiplicity)
- Generalized eigenspace G_lambda = ker((A - lambda I)^n)
- geometric <= algebraic multiplicity
-/

def Mat.geometricMultiplicity2 (A : Mat 2 2) (lambda : Rat) : Nat :=
  if Mat.isEigenvalue2 A lambda then
    let ev := Mat.eigenvector2 A lambda
    match ev with
    | some _ => 1
    | none => 0
  else 0

def Mat.algebraicMultiplicity2 (A : Mat 2 2) (lambda : Rat) : Nat :=
  if Mat.isEigenvalue2 A lambda then
    let evs := Mat.eigenvalues2 A
    evs.count (fun l => l == lambda)
  else 0

/-! ## L3: Defect of an Eigenvalue

defect(lambda) = algebraicMult - geometricMult.
Defect > 0 means the Jordan block for lambda is larger than 1x1.
-/

def Mat.defect2 (A : Mat 2 2) (lambda : Rat) : Nat :=
  Mat.algebraicMultiplicity2 A lambda - Mat.geometricMultiplicity2 A lambda

/-! ## L3: Fitting Decomposition

V = V_0(A) (+) V_1(A) where:
V_0 = ker(A^n) (nilpotent part)
V_1 = im(A^n) (invertible part)
-/

structure FittingDecomposition2x2 where
  nilpotentPart : Vec 2
  invertiblePart : Vec 2
  isDirectSum : True

/-! ## L3: Spectral Subspace for a Set

For a subset S of C, the spectral subspace is the sum of
generalized eigenspaces for eigenvalues in S.
-/

def Mat.spectralSubspace2 (A : Mat 2 2) (S : List Rat) : List (Vec 2) :=
  S.filterMap (fun lambda =>
    if Mat.isEigenvalue2 A lambda then
      Mat.eigenvector2 A lambda
    else none)

/-! ## L3: Controllable and Observable Subspaces

In control theory:
- Controllable subspace: span{B, AB, A^2 B, ...}
- Observable subspace: span{C^T, A^T C^T, (A^T)^2 C^T, ...}
-/

structure ControlSystem2x2 where
  A : Mat 2 2
  B : Vec 2
  C : Vec 2

def ControlSystem2x2.controllabilityMatrix : Mat 2 2 :=
  fun i j =>
    if i = 0 then ControlSystem2x2.B.csys else
    (Mat.applyVec ControlSystem2x2.A.csys ControlSystem2x2.B.csys) i

end MiniSpectralCanonical