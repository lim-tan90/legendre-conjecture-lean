# 勒让德猜想——指数推进与形式化审计

[English](README.md) · **中文**

[![verify](https://github.com/lim-tan90/legendre-conjecture-lean/actions/workflows/verify.yml/badge.svg?branch=master)](https://github.com/lim-tan90/legendre-conjecture-lean/actions/workflows/verify.yml)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)

> [!IMPORTANT]
> **Pull Request 必须发到 `review` 分支，不要直接发到 `master`。**
>
> 1. Fork 仓库，从 `review` 建工作分支。
> 2. 本地运行 `lake build` 和 `python3 scripts/audit.py`。
> 3. PR 目标选 **`review`**。
> 4. CI 必须为绿色。维护者只有在收到明确指令、且审计通过后，才会把
>    `review` 合入 `master`。
>
> 完整指南：**[docs/PR_WORKFLOW.md](docs/PR_WORKFLOW.md)** ·
> PR 检查清单：[`.github/pull_request_template.md`](.github/pull_request_template.md)

> [!NOTE]
> **当前状态（2026 年 10 月）：勒让德猜想仍未解决。**
> 目前最好的无条件素数间隙指数仍是 `θ = 0.525`
> （Baker–Harman–Pintz 2001），它 **大于** `1/2`，因此不能推出勒让德猜想。
> 本仓库**不**声称证明了该猜想，也**不**声称已经把深层解析数论论文形式化。
> 已形式化的是：定义、初等归约，以及“若将来出现 `θ < 1/2` 的结果，则大 `n`
> 的勒让德猜想成立”这一精确条件化桥梁。

## 历史进展总览

**目标.** 勒让德猜想（A.-M. Legendre, *Essai sur la théorie des nombres*,
第 2 版, Courcier, Paris, 1808）：`θ = 1/2`（或 `θ = 1/2` 且常数 `< 2`）。
它仍未解决，也没有形式化证明。

这里的 `θ` 指 `p_{n+1} - p_n ≪ p_n^{θ+ε}` 中的指数；`+ε` 是论文陈述的一部分。
“仅 Prop”表示精确陈述已经在 `Legendre/Conditional.lean` 中编码，但**证明没有
形式化**。

| 步骤（按时间） | 原始文献 | 指数 θ | Lean 形式化？ | Lean 代码 |
|---|---|---|---|---|
| **Bertrand 公设** | J. Bertrand, *Mémoire sur le nombre de valeurs que peut prendre une fonction quand on y permute ses variables*, J. École Polytechnique **17** (1845), 123–140；证明：P. L. Chebyshev, *Mémoire sur les nombres premiers*, J. Math. Pures Appl. **17** (1852), 366–390 | **1** | **[✅ 是 — mathlib 证明，已复用](Legendre/Bertrand.lean#L27)** | **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)** |
| Hoheisel 1930 | G. Hoheisel, *Primzahlprobleme in der Analysis*, Sitzungsber. Preuss. Akad. Wiss. (1930), 580–588 | 32999/33000 | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L70)** | **[Conditional.lean L70](Legendre/Conditional.lean#L70)** |
| Ingham 1937（Lindelöf 路线） | A. E. Ingham, *On the difference between consecutive primes*, Quart. J. Math. Oxford **8** (1937), 255–266 | 5/8 | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L74)** | **[Conditional.lean L74](Legendre/Conditional.lean#L74)** |
| Ingham 1937（零密度路线） | 同上 | 577/925 + ε | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L77)** | **[Conditional.lean L77](Legendre/Conditional.lean#L77)** |
| Huxley 1972 | M. N. Huxley, *On the difference between consecutive primes*, Invent. Math. **15** (1972), 164–170 | 7/12 + ε | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L80)** | **[Conditional.lean L80](Legendre/Conditional.lean#L80)** |
| Heath-Brown–Iwaniec 1979 | D. R. Heath-Brown, H. Iwaniec, *On the difference between consecutive primes*, Invent. Math. **55** (1979), 49–69 | 13/23 + ε | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L83)** | **[Conditional.lean L83](Legendre/Conditional.lean#L83)** |
| Iwaniec–Pintz 1984 | H. Iwaniec, J. Pintz, *Primes in short intervals*, Monatsh. Math. **98** (1984), 115–143 | 11/20 − 1/406 + ε | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L86)** | **[Conditional.lean L86](Legendre/Conditional.lean#L86)** |
| Mozzochi 1986 | C. J. Mozzochi, *On the difference between consecutive primes*, J. Number Theory **24** (1986), 181–187 | 11/20 − 1/384 + ε | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L89)** | **[Conditional.lean L89](Legendre/Conditional.lean#L89)** |
| Baker–Harman 1996 | R. C. Baker, G. Harman, *The difference between consecutive primes*, Proc. London Math. Soc. (3) **72** (1996), 261–280 | 0.535 | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L92)** | **[Conditional.lean L92](Legendre/Conditional.lean#L92)** |
| Baker–Harman–Pintz 2001 | R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive primes, II*, Proc. London Math. Soc. (3) **83** (2001), 532–562 | **0.525**（当前纪录） | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L96)** | **[Conditional.lean L96](Legendre/Conditional.lean#L96)** |
| Riemann 假设（条件性） | H. Cramér, *Some theorems concerning prime numbers*, Ark. Mat. Astron. Fys. **15** (1920), no. 5, 1–32 | 1/2 + o(1) | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L130)** | **[Conditional.lean L130](Legendre/Conditional.lean#L130)** |
| Cramér 猜想（条件性） | H. Cramér, *On the order of the difference between consecutive primes*, Acta Arith. **2** (1936), 23–46 | 0（猜想） | **[❌ 否 — 仅 Prop](Legendre/Conditional.lean#L137)** | **[Conditional.lean L137](Legendre/Conditional.lean#L137)** |
| 显式验证 `n ≤ 7.05×10¹³` | J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's conjecture up to 7·10¹³*, Res. Number Theory **11** (2025), Paper 4 | 不适用（有限范围） | **[❌ 否 — 未编码](docs/formalization-roadmap.md)** | **[第 6 层路线图](docs/formalization-roadmap.md)** |
| Chen 1975（`P₂`，最终） | Chen Jing-Run, *On the distribution of almost primes in an interval*, Sci. Sinica **18** (1975), 611–627 | 不适用（`P₂`） | **[❌ 否 — 未编码](Legendre/Conditional.lean#L146)** | **[Conditional.lean L146](Legendre/Conditional.lean#L146)** |
| Dudek–Johnston 2026（`P₄`，所有 `n`） | A. W. Dudek, D. R. Johnston, *Almost primes between all squares*, J. Number Theory **278** (2026), 726–745 | 不适用（`P₄`） | **[❌ 否 — 未编码](docs/formalization-roadmap.md)** | **[第 7 层路线图](docs/formalization-roadmap.md)** |

状态单元格本身可点击：**✅** 跳转到证明；**❌“仅 Prop”** 跳转到已编码的陈述
（不是证明）；**❌“未编码”** 跳转到路线图。完整 DOI/arXiv 链接与证据等级见
[docs/literature.md](docs/literature.md)。
“仅 Prop”行**不是**已证明定理，而是供后续工作接入的定义/假设。把假设的
`θ < 1/2` 结果化为勒让德猜想的归约本身，已在
**[Reduction.lean L110](Legendre/Reduction.lean#L110)** 中**证明**。

## Lean 中真正验证了什么

`lake build` 证明以下内容，且没有 `sorry`、`admit`、自定义
`axiom`/`constant`/`opaque`，也没有 `False.elim`/`absurd` 爆炸捷径：

| Lean 声明 | 数学内容 | 状态 | 代码（GitHub） |
|---|---|---|---|
| `Legendre.LegendreAt` / `Legendre.Conjecture` | 猜想的平方区间形式 | 定义 | **[Basic.lean L32](Legendre/Basic.lean#L32)** · **[Basic.lean L36](Legendre/Basic.lean#L36)** |
| `Legendre.legendreAt_iff_gapFormAt` | 两种标准表述等价 | **已证明** | **[Basic.lean L49](Legendre/Basic.lean#L49)** |
| `Legendre.sq_interval_length` | `(n+1)^2 - n^2 = 2n+1` | **已证明** | **[Basic.lean L62](Legendre/Basic.lean#L62)** |
| `Legendre.legendre_of_gap_lt_two_sqrt` | 每个素数间隙 `< 2√p` ⇒ 勒让德猜想 | **已证明** | **[Reduction.lean L41](Legendre/Reduction.lean#L41)** |
| `Legendre.eventually_const_mul_rpow_lt` | `θ < 1/2 ⇒ C n^{2θ} < 2n`（最终） | **已证明** | **[Reduction.lean L79](Legendre/Reduction.lean#L79)** |
| `Legendre.eventually_legendre_of_gap_exponent_lt_half` | 间隙指数 `θ < 1/2` ⇒ 大 `n` 的勒让德猜想 | **已证明** | **[Reduction.lean L110](Legendre/Reduction.lean#L110)** |
| `Legendre.legendre_eventually_of_shortIntervalExponent_lt_half` | 文献风格的指数结果包装 | **已证明** | **[Conditional.lean L45](Legendre/Conditional.lean#L45)** |
| `Legendre.legendre_eventually_of_shortIntervalExponentLimit_lt_half` | 论文中 `+ε` 形式的同一推论 | **已证明** | **[Conditional.lean L54](Legendre/Conditional.lean#L54)** |
| `Legendre.bertrand` / `bertrand_gap_le` | Bertrand 公设（复用 mathlib） | mathlib 证明 | **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)** · **[Bertrand.lean L33](Legendre/Bertrand.lean#L33)** |
| `Legendre.conjecture_of_almostPrimeSquareAtMost_one` | 几乎素数 `P₁` 平方区间命题就是勒让德猜想 | **已证明** | **[Conditional.lean L172](Legendre/Conditional.lean#L172)** |
| `Legendre.almostPrimeSquareAtMost_one_iff` | `P₁` 平方区间命题 ↔ 勒让德猜想 | **已证明** | **[Conditional.lean L190](Legendre/Conditional.lean#L190)** |

每一行都直接链接到 GitHub 源码中的精确声明；点击 `Lnn` 锚点即可跳到对应行。

审计通过 `#print axioms` 完成：每个被审计定理只依赖
`propext`、`Classical.choice`、`Quot.sound`。

## 明确**没有**声称的内容

以下内容只被写成精确的 `Prop` 定义，供后续工作接入；它们的证明**没有**在
本仓库形式化：

* Hoheisel 1930、Ingham 1937（`5/8` 与 `577/925` 两条路线）、Huxley 1972、
  Heath-Brown–Iwaniec 1979、Iwaniec–Pintz 1984、Mozzochi 1986、
  Baker–Harman 1996、Baker–Harman–Pintz 2001 — 陈述代码：
  **[Hoheisel L70](Legendre/Conditional.lean#L70)** ·
  **[Ingham 5/8 L74](Legendre/Conditional.lean#L74)** ·
  **[Ingham 577/925 L77](Legendre/Conditional.lean#L77)** ·
  **[Huxley L80](Legendre/Conditional.lean#L80)** ·
  **[Heath-Brown–Iwaniec L83](Legendre/Conditional.lean#L83)** ·
  **[Iwaniec–Pintz L86](Legendre/Conditional.lean#L86)** ·
  **[Mozzochi L89](Legendre/Conditional.lean#L89)** ·
  **[Baker–Harman L92](Legendre/Conditional.lean#L92)** ·
  **[BHP L96](Legendre/Conditional.lean#L96)**；
* Riemann 假设下的间隙界与 Cramér 猜想 —
  **[RH gap L130](Legendre/Conditional.lean#L130)** ·
  **[Cramér L137](Legendre/Conditional.lean#L137)**；
* 勒让德猜想 `n ≤ 7.05 × 10¹³` 的显式验证 —
  **[第 6 层路线图](docs/formalization-roadmap.md)**；
* Chen（1975）与 Dudek–Johnston（2026）的几乎素数定理 —
  **[P_k 定义 L146](Legendre/Conditional.lean#L146)** ·
  **[第 7 层路线图](docs/formalization-roadmap.md)**。

每一步的精确状态见 [docs/literature.md](docs/literature.md) 与
[docs/proof-map.md](docs/proof-map.md)。

## 为什么 `θ = 0.525` 不够

若素数 `p ≤ n²` 之后的间隙至多为 `C p^θ`，则下一个素数小于
`n² + C n^{2θ}`。要落到 `(n+1)² = n² + 2n + 1` 以下，需要 `2θ < 1`，即
`θ < 1/2`。当 `θ = 0.525` 时允许的间隙是 `n^{1.05}`，远大于平方区间长度
`2n`；间隙可以直接跨过整个区间。该推理在
**[Reduction.lean L110](Legendre/Reduction.lean#L110)** 中形式化，文献解释见
[docs/literature.md](docs/literature.md)。

## 完整证明级形式化需要哪些工具

当前仓库是**已验证的归约层**，不是完整的形式化解析数论库。要把已发表的指数
结果做到“证明级形式化”，大致需要以下工具，按依赖顺序排列。这张表是路线图，
不是“已完成”的声明。

| 层级 | 需要形式化的工具 / 理论 | 为什么需要 | 当前状态（mathlib v4.33.1 / 本仓库） |
|---:|---|---|---|
| 0 | 自然数素数、素数间隙、平方区间、实数幂 | 陈述与 `θ < 1/2` 归约 | **本仓库已完成**：**[Basic.lean](Legendre/Basic.lean)** · **[Reduction.lean](Legendre/Reduction.lean)** |
| 1 | Bertrand 公设、Chebyshev 函数 `ψ(x)`、`θ(x)`、初等素数计数界 | 历史起点与定量直觉 | Bertrand 在 mathlib，并在 **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)** 复用；`Chebyshev.lean` 有 `ψ`、`θ` 与基本界；没有完整显式间隙理论 |
| 2 | Riemann ζ 函数：Euler 乘积、解析延拓、函数方程、无零点区域、辐角原理、对数导数 | 所有零密度与短区间定理的起点 | mathlib 只有部分 ζ API；没有完整的无零点区域与零点计数 |
| 3 | 素数计数基础：`π(x)`、`ψ(x)`、部分求和、Perron 公式、截断显式公式、带误差项的 PNT | 把 ζ 的信息转成素数计数信息 | 有 `PrimeCounting.lean`、`Chebyshev.lean`；没有 Perron 公式与所需误差项的 PNT |
| 4 | 零密度理论：`N(σ,T)`、Ingham 零密度估计、Huxley 的 `12/5` 估计、大筛法、Dirichlet 多项式均值估计（含 Guth–Maynard 型大值估计） | 为短区间提供密度输入 | **mathlib 中没有** |
| 5 | 短区间定理：Ingham 1937、Huxley 1972、Baker–Harman 1996 的加权零密度 + 筛法、Baker–Harman–Pintz 2001 | 给出 `p_{n+1} - p_n ≪ p_n^{θ+ε}` | **mathlib 中没有**；本仓库只有 **[Conditional.lean L70](Legendre/Conditional.lean#L70)** 的 `Prop` 陈述 |
| 6 | 显式计算层：区间算术、可验证素性证书、分段筛检查器、reflection / `native_decide` 风格的验证计算 | 覆盖有限范围 `n ≤ 7.05 × 10¹³`（以及旧纪录 `n ≤ 2 × 10⁹`） | **未形式化**；已发表计算是外部计算 |
| 7 | 几乎素数筛法：筛权重、Chen 的 `P₂` 定理、`P_k` 估计、Buchstab/线性筛 | 形式化几乎素数路线（所有 `n` 的 `P₄`、最终 `P₂`） | mathlib 有 `Nat.IsAtMostAlmostPrime` 与 `Ω`；**没有筛法**；`P₁` 等价性见 **[Conditional.lean L190](Legendre/Conditional.lean#L190)** |

### 依赖顺序与现实里程碑

```
(0) 定义/算术                    [已完成]
        │
(1) Bertrand + Chebyshev         [部分在 mathlib]
        │
(2) ζ 基础                       [第一个真正的大里程碑]
        │
(3) 带误差项的 PNT
        │
(4) 零密度估计
        │
(5) Ingham → Huxley → BHP
        │
(6) 显式有限验证                 [独立，可并行]
(7) 几乎素数/筛法路线            [独立，可并行]
```

对本仓库而言，现实顺序是：

1. **完成第 1 层**：基于 mathlib 现有 API 形式化显式 Chebyshev/π 界与
   Bertrand 型区间估计。
2. **第 5 层的陈述级**：已经以 `Prop` 形式存在；继续补齐每篇论文的精确
   `+ε`、充分大范围和常数约定。
3. **先做第 2–3 层**：ζ 基础与 Perron/带误差项 PNT。这是第一个真正的大型
   工程，应拆成许多 PR。
4. **第 4–5 层**：先 Ingham，再 Huxley，最后 BHP 的筛法精化。Ingham 未完成
   前不要声称 BHP 已完成。
5. **第 6 层**：可验证区间证书检查器可以并行推进，是覆盖有限范围最现实的
   路径。
6. **第 7 层**：`P₁ ↔ 勒让德猜想` 已经证明；下一个诚实目标是形式化筛法陈述，
   而不是伪造 `P₂` 证明。

每一层的验收标准见 [docs/formalization-roadmap.md](docs/formalization-roadmap.md)。

## 构建

```bash
# Lean 4.33.1 + mathlib v4.33.1
lake exe cache get
lake build
```

然后运行审计：

```bash
python3 scripts/audit.py
```

Windows：

```powershell
pwsh -File scripts/verify.ps1
```

审计检查：

1. 项目源码中无 `sorry` / `admit` / `axiom` / `constant` / `opaque` / `unsafe`；
2. 无 `False.elim` / `absurd` / `nomatch` 爆炸捷径；
3. 每个 `#print axioms` 只列出三条标准公理；
4. 仓库中不存在 PDF 文件。

## 仓库结构

```
README.md            英文（默认）
README.zh.md         中文版本
Legendre/
  Basic.lean         定义、等价性、初等事实
  Reduction.lean     平方区间判定、θ < 1/2 归约
  Conditional.lean   文献指数 Prop、条件化定理、P_k
  Bertrand.lean      Bertrand 公设的复用与比较
  Audit.lean         #print axioms 审计
docs/
  literature.md      原始文献时间线与证据等级
  proof-map.md       文献步骤 ↔ Lean 声明 ↔ 形式化状态
  formalization-roadmap.md  工具、依赖与验收标准
  PR_WORKFLOW.md     双分支 PR 与验证流程
scripts/
  audit.py           无 sorry / 无公理 / 无爆炸审计
  verify.ps1         Windows 包装脚本
.github/workflows/
  verify.yml         针对 review/master 的 CI
```

## 分支与 PR

* `master`：已验证、稳定。
* `review`：次级/暂存分支。**所有 PR 发到 `review`。**

收到 PR 后，维护者只有在收到明确指令时才把它合入 `review`；随后 CI 运行完整的
Lean 构建与公理/爆炸审计。通过后才把 `review` 合入 `master`；失败则留在
`review` 修复。详见 [docs/PR_WORKFLOW.md](docs/PR_WORKFLOW.md)。

## 版权

仓库不包含 PDF、扫描件或受版权保护论文的长篇逐字摘录。
`docs/literature.md` 只包含书目信息、简短的数学陈述和出版社/arXiv 链接。
Lean 代码以 Apache-2.0 发布。

## 参考文献

完整书目、DOI/arXiv 链接和证据等级见
[docs/literature.md](docs/literature.md)。关键条目：

* G. Hoheisel, *Primzahlprobleme in der Analysis*, 1930.
* A. E. Ingham, *On the difference between consecutive primes*, Quart. J. Math.
  **8** (1937), 255–266, [DOI](https://doi.org/10.1093/qmath/os-8.1.255).
* M. N. Huxley, *On the difference between consecutive primes*, Invent. Math.
  **15** (1972), 164–170, [DOI](https://doi.org/10.1007/BF01418933).
* R. C. Baker, G. Harman, *The difference between consecutive primes*, Proc.
  London Math. Soc. **72** (1996), 261–280,
  [DOI](https://doi.org/10.1112/plms/s3-72.2.261).
* R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive primes,
  II*, Proc. London Math. Soc. **83** (2001), 532–562,
  [DOI](https://doi.org/10.1112/plms/83.3.532).
* J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's
  conjecture up to 7·10¹³*, Res. Number Theory **11** (2025),
  [DOI](https://doi.org/10.1007/s40993-024-00589-4).
