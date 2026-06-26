/-
# MiniMultilinearForm

Multilinear forms package: bilinear maps, bilinear forms,
symmetric/skew-symmetric/alternating forms, multilinear maps,
tensor products, and applications to geometry and physics.

Part of the mini-everything-math project.

## Sub-packages
- `Core`          — Field, VectorSpace, BilinearMap, BilinearForm, MultilinearMap
- `Bilinear`      — Bilinear form operations, matrix representation, quadratic forms
- `Multilinear`   — Multilinear map operations, tensor of multilinear maps
- `Symmetric`     — Symmetric bilinear forms, radical, nondegeneracy, signature
- `Alternating`   — Alternating forms, determinant, exterior powers
- `TensorProduct` — Tensor product of vector spaces, universal property
- `Functorial`    — Pullback, change of basis, duality
- `Examples`      — Dot product, cross product, determinant, trace form, Killing form
- `Applications`  — Riemannian geometry, symplectic geometry, physics tensors
- `Computation`   — Symbolic computation, evaluation, normal forms
-/

import MiniMultilinearForm.Core.Basic
import MiniMultilinearForm.Bilinear.Basic
import MiniMultilinearForm.Bilinear.Quadratic
import MiniMultilinearForm.Multilinear.Basic
import MiniMultilinearForm.Multilinear.Operations
import MiniMultilinearForm.Multilinear.Tensor
import MiniMultilinearForm.Symmetric.Basic
import MiniMultilinearForm.Symmetric.Diagonalization
import MiniMultilinearForm.Symmetric.Signature
import MiniMultilinearForm.Alternating.Basic
import MiniMultilinearForm.Alternating.Determinant
import MiniMultilinearForm.Alternating.ExteriorPower
import MiniMultilinearForm.TensorProduct.Basic
import MiniMultilinearForm.TensorProduct.Universal
import MiniMultilinearForm.TensorProduct.Examples
import MiniMultilinearForm.Functorial.Pullback
import MiniMultilinearForm.Functorial.Duality
import MiniMultilinearForm.Functorial.ChangeOfBasis
import MiniMultilinearForm.Examples.Basic
import MiniMultilinearForm.Examples.Advanced
import MiniMultilinearForm.Applications.Geometry
import MiniMultilinearForm.Applications.Physics
import MiniMultilinearForm.Computation.Symbolic
