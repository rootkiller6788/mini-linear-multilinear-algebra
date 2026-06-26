/-
# MiniSpectralCanonical.Bridges.ToGeometry

L7: Geometric interpretations of spectral theory.
Principal axes theorem, SVD geometry (ellipsoid),
Laplacian spectrum and shape, quadratic forms.
-/

import MiniSpectralCanonical.Core.Basic
import MiniSpectralCanonical.Core.Objects

namespace MiniSpectralCanonical

/-! ## L7: Principal Axes Theorem

The eigenvectors of a symmetric matrix A give the principal axes
of the ellipsoid defined by x^T A x = 1.
Semi-axis lengths = 1/sqrt(lambda_i).
-/

structure PrincipalAxes2x2 where
  matrix : Mat 2 2
  semiAxis1 : Rat
  semiAxis2 : Rat
  axisDirection1 : Vec 2
  axisDirection2 : Vec 2

def Mat.principalAxes2 (A : Mat 2 2) (h_sym : Mat.isSymmetric2 A) : PrincipalAxes2x2 :=
  let evs := Mat.eigenvalues2 A
  let eigens := Mat.orthogonalEigenbasis2 A h_sym
  { matrix := A
    semiAxis1 := 0
    semiAxis2 := 0
    axisDirection1 := Vec.zero 2
    axisDirection2 := Vec.zero 2
  }

/-! ## L7: SVD Geometry: Linear Map as Sequence of Rotations/Scales

A = U Sigma V^T geometrically: rotate by V^T, scale by sigma_i, rotate by U.
The unit sphere maps to an ellipsoid with semi-axes sigma_i u_i.
-/

def Mat.svdGeometry2 (A : Mat 2 2) : String :=
  let svd := Mat.svd2 A
  s!"A maps unit circle to ellipse with semi-axes {svd.sigma1}, {svd.sigma2}"

/-! ## L7: Laplacian Spectrum and Graph Shape

Eigenvalues of the graph Laplacian encode:
- lambda_1 = 0 (connectedness)
- lambda_2 > 0 iff graph is connected (algebraic connectivity)
- Sum of eigenvalues = trace = total degree
-/

def graphShapeFromSpectrum2 (L : Mat 2 2) : String :=
  let evs := Mat.eigenvalues2 L
  match evs with
  | [l1, l2] =>
    if l2 > 0 then "Connected" else "Disconnected"
  | _ => "Unknown"

/-! ## L7: Quadratic Form Classification (Conic Sections)

ax^2 + 2bxy + dy^2 = 1 with symmetric [[a,b],[b,d]]:
- lambda_1, lambda_2 > 0: ellipse
- lambda_1 > 0, lambda_2 < 0: hyperbola
- one lambda = 0: parabola
-/

inductive ConicType where
  | ellipse | hyperbola | parabola | degenerate
  deriving Repr

def Mat.conicType2 (A : Mat 2 2) (h_sym : Mat.isSymmetric2 A) : ConicType :=
  let evs := Mat.eigenvalues2 A
  match evs with
  | [l1, l2] =>
    if l1 > 0 && l2 > 0 then ConicType.ellipse
    else if l1 * l2 < 0 then ConicType.hyperbola
    else if l1 = 0 \/ l2 = 0 then ConicType.parabola
    else ConicType.degenerate
  | _ => ConicType.degenerate

/-! ## L7: Surface Normals and Curvature

The Hessian matrix (matrix of second derivatives)
determines local surface shape: eigenvalues give principal curvatures.
Gaussian curvature = l1*l2, Mean curvature = (l1+l2)/2.
-/

def principalCurvatures2 (Hessian : Mat 2 2) (h_sym : Mat.isSymmetric2 Hessian) : Rat x Rat :=
  let evs := Mat.eigenvalues2 Hessian
  match evs with
  | [l1, l2] => (l1, l2)
  | [l] => (l, l)
  | _ => (0, 0)

/-! ## L7: Moment of Inertia Tensor

The inertia tensor I is a 2x2 symmetric positive definite matrix.
Principal moments = eigenvalues of I.
Principal axes = eigenvectors of I.
-/

structure InertiaTensor2x2 where
  Ixx : Rat
  Iyy : Rat
  Ixy : Rat
  principalMoments : Rat x Rat
  principalAxes : Mat 2 2

/-! ## L7: Covariance Ellipse

For a 2D dataset with covariance matrix C:
- Eigenvectors give directions of maximum/minimum variance
- Eigenvalues = variance along these directions
- sqrt(lambda_i) = standard deviation along axis i
-/

def covarianceEllipse2 (cov : Mat 2 2) (h_sym : Mat.isSymmetric2 cov) : String :=
  let evs := Mat.eigenvalues2 cov
  match evs with
  | [l1, l2] =>
    s!"Ellipse: major axis std={l1.sqrt.toRat}, minor axis std={l2.sqrt.toRat}"
  | _ => "Degenerate"

end MiniSpectralCanonical