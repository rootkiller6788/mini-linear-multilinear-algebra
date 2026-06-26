import Lake
open Lake DSL

package «mini-determinant-theory» where

@[default_target]
lean_lib «MiniDeterminantTheory» where
  roots := #[`MiniDeterminantTheory]

require «mini-vector-space-core» from "../mini-vector-space-core"
require «mini-linear-transformation» from "../mini-linear-transformation"
require «mini-multilinear-form» from "../mini-multilinear-form"
