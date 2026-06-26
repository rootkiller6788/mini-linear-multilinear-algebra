import Lake
open Lake DSL

package «mini-spectral-canonical» where

@[default_target]
lean_lib «MiniSpectralCanonical» where
  roots := #[`MiniSpectralCanonical]

require «mini-vector-space-core» from "../mini-vector-space-core"
require «mini-linear-transformation» from "../mini-linear-transformation"
require «mini-determinant-theory» from "../mini-determinant-theory"
require «mini-inner-product-space» from "../mini-inner-product-space"
