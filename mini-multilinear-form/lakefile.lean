import Lake
open Lake DSL

package «mini-multilinear-form» where

@[default_target]
lean_lib «MiniMultilinearForm» where
  roots := #[`MiniMultilinearForm]

-- Self-contained module: Field and VectorSpace types defined internally.
-- Cross-module references to mini-vector-space-core and mini-linear-transformation
-- are NOT needed because all foundational types are defined in Core/Basic.lean.
