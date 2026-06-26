import Lake
open Lake DSL

package «mini-dual-quotient» where

@[default_target]
lean_lib «MiniDualQuotient» where
  roots := #[`MiniDualQuotient]

require «mini-vector-space-core» from "../mini-vector-space-core"
require «mini-linear-transformation» from "../mini-linear-transformation"
