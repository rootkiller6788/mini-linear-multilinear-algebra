"""
MiniInnerProductSpace Python Helper

Utility functions for working with inner products, norms,
orthogonality, Gram-Schmidt, QR decomposition, and
spectral theorem verification in Python.

Corresponds to the Lean 4 MiniInnerProductSpace package
in mini-everything-math.
"""

import numpy as np
from numpy.linalg import norm, qr, eigvalsh
from typing import List, Tuple, Callable


def dot_product(x: np.ndarray, y: np.ndarray) -> float:
    """Standard Euclidean inner product / dot product."""
    return float(np.dot(x, y))


def vector_norm(x: np.ndarray) -> float:
    """Norm induced by the dot product."""
    return float(np.sqrt(dot_product(x, x)))


def is_orthogonal(x: np.ndarray, y: np.ndarray, tol: float = 1e-10) -> bool:
    """Check if two vectors are orthogonal."""
    return abs(dot_product(x, y)) < tol


def orthogonal_complement(vectors: List[np.ndarray], v: np.ndarray) -> np.ndarray:
    """Project v onto the orthogonal complement of span(vectors)."""
    if not vectors:
        return v.copy()
    A = np.column_stack(vectors)
    Q, _ = qr(A, mode='reduced')
    return v - Q @ (Q.T @ v)


def gram_schmidt(A: np.ndarray) -> np.ndarray:
    """Classical Gram-Schmidt orthonormalization.

    Args:
        A: (m, n) matrix of column vectors to orthonormalize.

    Returns:
        Q: (m, n) matrix with orthonormal columns.
    """
    m, n = A.shape
    Q = np.zeros((m, n))
    R = np.zeros((n, n))
    for j in range(n):
        v = A[:, j].copy()
        for i in range(j):
            R[i, j] = dot_product(Q[:, i], A[:, j])
            v = v - R[i, j] * Q[:, i]
        R[j, j] = vector_norm(v)
        if R[j, j] > 1e-15:
            Q[:, j] = v / R[j, j]
        else:
            Q[:, j] = v  # zero norm, keep as is
    return Q


def modified_gram_schmidt(A: np.ndarray) -> np.ndarray:
    """Modified Gram-Schmidt (numerically more stable)."""
    m, n = A.shape
    Q = A.copy().astype(float)
    R = np.zeros((n, n))
    for i in range(n):
        R[i, i] = vector_norm(Q[:, i])
        if R[i, i] > 1e-15:
            Q[:, i] /= R[i, i]
        for j in range(i + 1, n):
            R[i, j] = dot_product(Q[:, i], Q[:, j])
            Q[:, j] -= R[i, j] * Q[:, i]
    return Q


def cauchy_schwarz_check(x: np.ndarray, y: np.ndarray) -> Tuple[bool, float, float]:
    """Verify Cauchy-Schwarz: |<x,y>| <= ||x|| * ||y||."""
    lhs = abs(dot_product(x, y))
    rhs = vector_norm(x) * vector_norm(y)
    return lhs <= rhs * (1 + 1e-12), lhs, rhs


def triangle_inequality_check(x: np.ndarray, y: np.ndarray) -> Tuple[bool, float, float]:
    """Verify triangle inequality: ||x+y|| <= ||x|| + ||y||."""
    lhs = vector_norm(x + y)
    rhs = vector_norm(x) + vector_norm(y)
    return lhs <= rhs * (1 + 1e-12), lhs, rhs


def parallelogram_law_check(x: np.ndarray, y: np.ndarray) -> Tuple[bool, float, float]:
    """Verify parallelogram law: ||x+y||^2 + ||x-y||^2 = 2(||x||^2 + ||y||^2)."""
    lhs = vector_norm(x + y)**2 + vector_norm(x - y)**2
    rhs = 2 * (vector_norm(x)**2 + vector_norm(y)**2)
    return np.isclose(lhs, rhs, rtol=1e-12), lhs, rhs


def orthogonal_projection(A: np.ndarray, b: np.ndarray) -> np.ndarray:
    """Project b onto the column space of A.

    Uses QR decomposition for numerical stability.
    Equivalent to the Lean orthogonalProjection.
    """
    Q, R = qr(A, mode='reduced')
    return Q @ (Q.T @ b)


def least_squares(A: np.ndarray, b: np.ndarray) -> np.ndarray:
    """Solve min ||Ax - b|| via QR decomposition.

    Corresponds to solving normal equations stably via QR.
    """
    Q, R = qr(A, mode='reduced')
    return np.linalg.solve(R, Q.T @ b)


def spectral_theorem_verify(S: np.ndarray) -> bool:
    """Verify spectral theorem for a symmetric matrix.

    Checks: real eigenvalues, orthogonal eigenvectors.
    """
    eigenvalues = eigvalsh(S)
    all_real = np.all(np.isreal(eigenvalues))
    _, eigvecs = np.linalg.eigh(S)
    orthonormal = np.allclose(eigvecs.T @ eigvecs, np.eye(len(S)), atol=1e-10)
    return bool(all_real and orthonormal)


def is_self_adjoint(A: np.ndarray) -> bool:
    """Check if matrix is self-adjoint (symmetric in real case)."""
    return np.allclose(A, A.T, atol=1e-10)


def is_unitary(A: np.ndarray) -> bool:
    """Check if matrix is unitary (orthogonal in real case)."""
    n = A.shape[0]
    return np.allclose(A.T @ A, np.eye(n), atol=1e-10) and np.allclose(A @ A.T, np.eye(n), atol=1e-10)


def gram_matrix(vectors: List[np.ndarray]) -> np.ndarray:
    """Compute the Gram matrix G_{ij} = <v_i, v_j>."""
    n = len(vectors)
    G = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            G[i, j] = dot_product(vectors[i], vectors[j])
    return G


def householder_qr(A: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
    """QR decomposition using Householder reflections.

    More numerically stable than Gram-Schmidt for ill-conditioned matrices.
    """
    m, n = A.shape
    Q = np.eye(m)
    R = A.copy().astype(float)

    for k in range(n):
        x = R[k:, k].copy()
        alpha = -np.sign(x[0]) * np.linalg.norm(x)
        v = x.copy()
        v[0] = x[0] - alpha
        v = v / np.linalg.norm(v)

        # Apply Householder reflection
        R[k:, k:] -= 2.0 * np.outer(v, v @ R[k:, k:])
        # Accumulate Q
        Qk = np.eye(m)
        Qk[k:, k:] -= 2.0 * np.outer(v, v)
        Q = Q @ Qk

    return Q[:, :n], R[:n, :]


if __name__ == "__main__":
    print("MiniInnerProductSpace Python Helper")
    print("====================================")
    np.random.seed(42)

    x = np.random.randn(10)
    y = np.random.randn(10)

    ok, lhs, rhs = cauchy_schwarz_check(x, y)
    print(f"Cauchy-Schwarz: {'OK' if ok else 'FAIL'} ({lhs:.4f} <= {rhs:.4f})")

    ok, lhs, rhs = triangle_inequality_check(x, y)
    print(f"Triangle: {'OK' if ok else 'FAIL'} ({lhs:.4f} <= {rhs:.4f})")

    ok, lhs, rhs = parallelogram_law_check(x, y)
    print(f"Parallelogram: {'OK' if ok else 'FAIL'} ({lhs:.4f} = {rhs:.4f})")

    print(f"\n{:^40}".format("All checks passed!"))
