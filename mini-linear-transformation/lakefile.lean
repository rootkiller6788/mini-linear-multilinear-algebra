import Lake
open Lake DSL

package «mini-linear-transformation» where

@[default_target]
lean_lib «MiniLinearTransformation» where
  roots := #[`MiniLinearTransformation]

require «mini-vector-space-core» from "../mini-vector-space-core"
require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
