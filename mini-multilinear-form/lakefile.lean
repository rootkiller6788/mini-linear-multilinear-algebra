import Lake
open Lake DSL

package «mini-multilinear-form» where

@[default_target]
lean_lib «MiniMultilinearForm» where
  roots := #[`MiniMultilinearForm]

require «mini-vector-space-core» from "../mini-vector-space-core"
require «mini-linear-transformation» from "../mini-linear-transformation"
