import Lake
open Lake DSL

package «mini-inner-product-space» where

@[default_target]
lean_lib «MiniInnerProductSpace» where
  roots := #[`MiniInnerProductSpace]

require «mini-vector-space-core» from "../mini-vector-space-core"
require «mini-linear-transformation» from "../mini-linear-transformation"
