import Lake
open Lake DSL

package «mini-vector-space-core» where

@[default_target]
lean_lib «MiniVectorSpaceCore» where
  roots := #[`MiniVectorSpaceCore]

require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
