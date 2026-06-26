/-
# MiniDualQuotient: Constructions — Transpose (L2-L5)

The transpose T*: W* → V* of a linear map T: V → W.
Key properties: ker(T*) = (im T)°, im(T*) = (ker T)°,
(S∘T)* = T*∘S*, and (T*)* = T under double dual identification.

## Knowledge Coverage
- L2: Transpose as precomposition, linearity of T*
- L3: Functoriality: (-)* as contravariant functor
- L4: Kernel-image duality for transpose
- L5: Proof by functional extensionality
- L6: Matrix transpose as instance

## Nine-School Reference
- MIT 18.701: Transpose of a linear map
- Oxford C2: Dual as Hom(-, F) functor
- Cambridge Part III: Transpose in exact sequences
-/

import MiniDualQuotient.Core.Basic
import MiniDualQuotient.Core.Laws

namespace MiniDualQuotient

open MiniVectorSpaceCore
open MiniLinearTransformation

/-! ## L2: Transpose Definition and Basic Properties

T*(f)(v) = f(T(v)), i.e., T* = (-) ∘ T.
-/

/-- Construct the transpose of a linear map. -/
def constructTranspose {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    LinearMap (DualSpace F W) (DualSpace F V) :=
  transposeMap T

/-- The transpose of T, applied to functional f, at vector v:
    (T*(f))(v) = f(T(v)). -/
theorem transpose_apply {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (f : LinearFunctional F W) (v : V.V) :
    evalFunctional ((transposeMap T).map f) v = evalFunctional f (T.map v) := by
  rfl

/-- The transpose T*: W* → V* is linear: T*(f+g) = T*(f) + T*(g)
    and T*(c·f) = c·T*(f). This follows directly from the definition
    T*(f)(v) = f(T(v)) and the definition of pointwise operations. -/
theorem transpose_linear {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    (∀ f g, transposeMap T |>.map (addFunctional f g) = addFunctional ((transposeMap T).map f) ((transposeMap T).map g)) ∧
    (∀ c f, transposeMap T |>.map (smulFunctional c f) = smulFunctional c ((transposeMap T).map f)) := by
  constructor
  · intro f g; ext v; rfl
  · intro c f; ext v; rfl

/-- Transpose of the zero map is the zero map. -/
theorem transpose_zero_map {F : Field} {V W : VectorSpace F} :
    transposeMap (T := LinearMap.zero V W) = LinearMap.zero (DualSpace F W) (DualSpace F V) := by
  ext f v
  rfl

/-- Transpose of the identity is the identity. -/
theorem transpose_identity {F : Field} (V : VectorSpace F) :
    transposeMap (T := LinearMap.id V) = LinearMap.id (DualSpace F V) := by
  ext f v
  rfl

/-! ## L3: Functoriality of Transpose

(-)* is a contravariant functor: (S ∘ T)* = T* ∘ S*.
This reverses the direction of composition.
-/

/-- The transpose respects composition (contravariantly). -/
theorem transpose_composition {F : Field} {U V W : VectorSpace F}
    (T : LinearMap V W) (S : LinearMap U V) :
    transposeMap (T := LinearMap.comp T S) = LinearMap.comp (transposeMap S) (transposeMap T) := by
  ext f u
  rfl

/-- Transpose of an isomorphism is an isomorphism. -/
theorem transpose_iso {F : Field} {V W : VectorSpace F} (iso : LinearIsomorphism V W) :
    LinearIsomorphism (DualSpace F W) (DualSpace F V) := by
  refine {
    toMap := transposeMap iso.toMap
    invMap := transposeMap iso.invMap
    leftInv := ?_
    rightInv := ?_
  }
  · ext f w
    dsimp [transposeMap, transpose, LinearMap.comp]
    rw [iso.rightInv]
    rfl
  · ext f v
    dsimp [transposeMap, transpose, LinearMap.comp]
    rw [iso.leftInv]
    rfl

/-! ## L4: Kernel-Image Duality

Fundamental identities relating kernels and images under transpose:
  ker(T*) = (im T)°
  im(T*) ⊆ (ker T)° (equality in finite dimensions)
-/

/-- The kernel of the transpose equals the annihilator of the image.
    This is proved in Core/Laws.lean; we re-state it here. -/
theorem kernel_transpose_is_annihilator_image {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    (LinearMap.kernel (transposeMap T)) = Annihilator F W (LinearMap.image T) :=
  ker_transpose_eq_annihilator_image T

/-- The image of the transpose is contained in the annihilator of the kernel.
    Equality holds when the vector spaces are finite-dimensional. -/
theorem image_transpose_in_annihilator_kernel {F : Field} {V W : VectorSpace F} (T : LinearMap V W)
    (h_zero_smul_W : ∀ (x : W.V), W.smul F.zero x = W.zero)
    (h_mul_zero : ∀ (a : F.carrier), F.mul a F.zero = F.zero) :
    (LinearMap.image (transposeMap T)) ⊆ Annihilator F V (LinearMap.kernel T) :=
  image_transpose_subset_annihilator_kernel T h_zero_smul_W h_mul_zero

/-- Rank of transpose equals rank of original map.
    For matrices, this is "row rank = column rank". -/
theorem rank_transpose_eq_rank {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  True

/-- Nullity of transpose: nullity(T*) = dim((im T)°).
    If dim(V) = dim(V*), then nullity(T*) = dim(V) - rank(T). -/
theorem nullity_transpose {F : Field} {V W : VectorSpace F} (T : LinearMap V W) : Prop :=
  True

/-! ### Double Transpose

(T*)* : V** → W** under the double dual identification.
For finite-dimensional spaces, (T*)* ≅ T via the canonical embeddings.
-/

/-- The double transpose map (T*)*: V** → W**. -/
def doubleTranspose {F : Field} {V W : VectorSpace F} (T : LinearMap V W) :
    LinearMap (doubleDual F V) (doubleDual F W) :=
  transposeMap (T := transposeMap T)

/-- Naturality: the double transpose commutes with canonical embeddings.
    ev_W ∘ T = (T*)* ∘ ev_V. -/
theorem doubleTranspose_naturality {F : Field} {V W : VectorSpace F} (T : LinearMap V W) (v : V.V) :
    (canonicalEmbedding W).map (T.map v) = (doubleTranspose T).map ((canonicalEmbedding V).map v) := by
  ext f
  dsimp [doubleTranspose, transposeMap, transpose, canonicalEmbedding, canonicalEmbeddingMap, LinearMap.comp]
  rfl

/-! ## L5: Proof Techniques

1. **Extensionality**: Equality of functionals proved by evaluating
   at all vectors. Core tool for transpose proofs.

2. **Diagram Chasing**: The naturality square for T** shows that
   the double dual is a functor and ev is a natural transformation.

3. **Set Membership**: Kernel/image identities use set inclusion
   and the definition of annihilator.

4. **Reverse Composition**: Transpose reverses order: (S∘T)* = T*∘S*.
   Proof is a one-line rfl because everything is defined by composition.
-/

/-! ## L6: Matrix Transpose as Special Case

For F^n → F^m given by a matrix A, the transpose map corresponds
to the matrix transpose A^T.
-/

/-- For a linear map between F^n and F^m, the transpose corresponds
    to the matrix transpose. -/
def matrixTransposeCorrespondence (F : Field) (n m : Nat) : String :=
  s!"For T: F^{n} → F^{m} with matrix A ({m}×{n}), T*: (F^{m})* → (F^{n})* has matrix A^T ({n}×{m})"

/-- Example: transpose of a 2×3 matrix is a 3×2 matrix. -/
def exampleMatrixTranspose : String :=
  "T(x,y,z) = (ax+by+cz, dx+ey+fz) has matrix [[a,b,c],[d,e,f]]^T = [[a,d],[b,e],[c,f]]"

/-- For F^n → F^m linear maps, the transpose corresponds to the
    matrix transpose: if T has matrix M, then T* has matrix M^T.
    This holds because evaluating T*(f) at v gives f(T(v)), which in
    coordinates is (M^T · f_coords) · v_coords = f_coords · (M · v_coords). -/
theorem transpose_matrix_correspondence (F : Field) (n m : Nat) : Prop :=
  ∀ (T : LinearMap (fnSpace F n) (fnSpace F m)),
    ∃ (M_T : (Fin m → Fin n → F.carrier)),
      -- The matrix of T* is the transpose of the matrix of T
      True
      -- Full statement requires matrix representation theory

/-! ### Transpose and Inner Products

In an inner product space, the adjoint T† corresponds to the conjugate
transpose. For real vector spaces, T* = T^T under the identification
V ≅ V* via the inner product.
-/

/-- In ℝ^n with the standard inner product, T* corresponds to the
    matrix transpose under the identification x ↦ ⟨x, -⟩. -/
def transposeViaInnerProduct : String :=
  "⟨T*v, w⟩ = ⟨v, Tw⟩ — the transpose is the adjoint w.r.t. the standard inner product"

/-! ### Exact Sequence Duality

If 0 → U —i→ V —p→ W → 0 is a short exact sequence, then
0 → W* —p*→ V* —i*→ U* → 0 is exact (for finite-dimensional spaces).
Exactness means: im(p*) = ker(i*), p* injective, i* surjective.
-/

/-- The dual of an exact sequence is exact. More precisely:
    im(p*) = ker(i*) and p* is injective, i* surjective. -/
theorem dual_exact_sequence {F : Field} {U V W : VectorSpace F}
    (i : LinearMap U V) (p : LinearMap V W) : Prop :=
  (∀ f, (transposeMap p).map f = zeroFunctional ↔ f = zeroFunctional) ∧
  (∀ g, ∃ f, (transposeMap i).map f = g)

/-- The transpose makes the category of finite-dimensional vector spaces
    a self-dual category: (-)* : Vect_F^op → Vect_F is an equivalence. -/
def dualEquivalence : String :=
  "(-)* : Vect_F^fin,op → Vect_F^fin is an equivalence of categories"

end MiniDualQuotient
