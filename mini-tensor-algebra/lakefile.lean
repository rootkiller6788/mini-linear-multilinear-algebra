import Lake
open Lake DSL

package «mini-tensor-algebra» where

@[default_target]
lean_lib «MiniTensorAlgebra» where
  roots := #[`MiniTensorAlgebra]

require «mini-vector-space-core» from "../mini-vector-space-core"
require «mini-linear-transformation» from "../mini-linear-transformation"
require «mini-multilinear-form» from "../mini-multilinear-form"
