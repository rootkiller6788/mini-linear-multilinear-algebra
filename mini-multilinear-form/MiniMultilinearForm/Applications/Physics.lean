/-
# MiniMultilinearForm.Applications.Physics

Applications to physics:
Lorentzian metrics, stress-energy tensors,
electromagnetic field tensors, moment of inertia tensor.
-/

import MiniMultilinearForm.Applications.Geometry

namespace MiniMultilinearForm

open MiniVectorSpaceCore

/-! ## Lorentzian Metric -/

/-- A Lorentzian metric on an (n+1)-dimensional vector space:
    signature (n,1) -- one timelike direction, n spacelike. -/
structure LorentzianMetric {F : Field} (V : VectorSpace F) where
  form : BilinearForm V
  signature : Signature
  isLorentzian : signature.positive = signature.negative + 1 ∨ signature.negative = signature.positive + 1

/-! ## Minkowski Spacetime -/

/-- Minkowski spacetime: ℝ^4 with metric diag(-1,1,1,1). -/
def MinkowskiMetric {F : Field} (x y : Fin 4 → F.carrier) : F.carrier :=
  F.add (F.add (F.add
    (F.neg (F.mul (x 0) (y 0)))
    (F.mul (x 1) (y 1)))
    (F.mul (x 2) (y 2)))
    (F.mul (x 3) (y 3))

/-! ## Stress-Energy Tensor -/

/-- The stress-energy tensor in physics is a symmetric bilinear form
    on Minkowski spacetime. -/
structure StressEnergyTensor {F : Field} (V : VectorSpace F) where
  T : SymmetricBilinearForm V
  conserved : True  -- Stub: ∇_μ T^{μν} = 0

/-! ## Electromagnetic Field Tensor -/

/-- The electromagnetic field tensor F_{μν} is an alternating bilinear form
    (2-form) on Minkowski spacetime. -/
structure ElectromagneticFieldTensor {F : Field} (V : VectorSpace F) where
  Fμν : AlternatingBilinearForm V
  maxwellHomogeneous : True  -- Stub: dF = 0
  maxwellInhomogeneous : True  -- Stub: d*F = J

/-! ## Moment of Inertia Tensor -/

/-- The moment of inertia tensor in rigid body dynamics is a
    symmetric positive-definite bilinear form on ℝ³. -/
structure InertiaTensor {F : Field} (V : VectorSpace F) where
  I : SymmetricBilinearForm V
  positiveDefinite : ∀ (x : V.V), x ≠ V.zero → True  -- Stub

#eval "Applications.Physics: Lorentzian metrics, stress-energy, EM field, inertia tensor"
