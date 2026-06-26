# Mini Linear & Multilinear Algebra（迷你线性与多重线性代数）

一套**从零开始、零依赖的 Lean 4 实现**，涵盖大学层次的线性代数、多重线性代数与张量理论。每个子包对应 MIT（及其他顶尖大学）课程，使用 Lean 4 证明助手从第一性原理构建线性代数基础。

## 子包

| 子包 | 主题 | 核心课程 |
|------|------|----------|
| [mini-vector-space-core](mini-vector-space-core/) | 域、向量空间、基、维数、线性组合 | MIT 18.06, MIT 18.700 |
| [mini-linear-transformation](mini-linear-transformation/) | 线性映射、核、像、秩-零化度定理 | MIT 18.06, Princeton MAT 345 |
| [mini-dual-quotient](mini-dual-quotient/) | 对偶空间、双重对偶、商空间、同构定理 | MIT 18.700, Cambridge Part II |
| [mini-inner-product-space](mini-inner-product-space/) | 内积、正交性、Gram-Schmidt、伴随算子 | MIT 18.06, Stanford Math 113 |
| [mini-multilinear-form](mini-multilinear-form/) | 双线性型、对称/反对称、交错、多重线性映射 | MIT 18.700, Harvard Math 122 |
| [mini-determinant-theory](mini-determinant-theory/) | 行列式、特征值、特征多项式、对角化 | MIT 18.06, Princeton MAT 345 |
| [mini-tensor-algebra](mini-tensor-algebra/) | 张量积、外代数、对称代数、Clifford 代数 | MIT 18.700, Berkeley Math 110 |
| [mini-spectral-canonical](mini-spectral-canonical/) | 谱定理、标准型、Jordan/Smith 分解 | MIT 18.06, MIT 18.065 |

## 设计理念

- **零外部依赖** -- 纯 Lean 4，仅导入内核模块
- **自包含子包** -- 每个子包拥有独立的 `lakefile.lean`、Core/、Morphisms/、Constructions/、Properties/、Theorems/
- **理论到代码的映射** -- 每个模块包含内联 `#eval` 示例和定理陈述
- **多重线性聚焦** -- 张量代数、对称代数与外代数构建完整的多重线性层次

## 构建

每个子包独立构建。使用 Lake 构建：

```bash
cd mini-vector-space-core
lake build
lake env lean --run Test/Smoke.lean
```

需要 **Lean 4** 和 **Lake**。

## 项目结构

```
3. mini-linear-multilinear-algebra/
├── mini-vector-space-core/          # 域、向量空间、基、维数
├── mini-linear-transformation/      # 线性映射、核、像、秩-零化度
├── mini-dual-quotient/              # 对偶空间、双重对偶、商空间
├── mini-inner-product-space/        # 内积、正交性、Gram-Schmidt
├── mini-multilinear-form/           # 双线性型、对称、交错
├── mini-determinant-theory/         # 行列式、特征值、对角化
├── mini-tensor-algebra/             # 张量积、外代数/对称代数/Clifford 代数
├── mini-spectral-canonical/         # 谱定理、Jordan/Smith 分解
└── lakefile.lean
```

## 许可证

MIT
