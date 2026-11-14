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
> 4. PR 中的形式化代码应基于**当前最新的稳定 Lean 与 mathlib 版本**编写。截至
>    **2026-10-18**，最新稳定版本为 **Lean `v4.35.0`** 与 **mathlib `v4.35.0`**
>    （即 `lean-toolchain` 与 `lakefile.toml` 中固定的版本）。若提交 PR 时已有更新的
>    稳定版，请适配到该版本，并在 PR 描述中注明。
> 5. CI 必须为绿色。维护者只有在收到明确指令、且审计通过后，才会把
>    `review` 合入 `master`。
>
> 6. **Layer 5 及后续层级按层组织：**实现放在 `Legendre/LayerN/`，
>    `Legendre/LayerN.lean` 作为统一导入入口。Layer 5 陈述已移入
>    `Layer5/Statements.lean`；Layer 6、7 目录已预留给后续证明和证书。
> 7. 进展变化时同步更新文献指数 comparator、中英文 README 和证明进度表；
>    运行 `python3 scripts/check_literature.py`。陈述对应通过不等于原定理已证明。
> 8. 每次移植均须在中英文 README 标明来源、固定提交、许可证及目标路径，
>    保留许可证原文与代码中的作者归属。
>
> 完整指南：**[docs/PR_WORKFLOW.md](docs/PR_WORKFLOW.md)** ·
> PR 检查清单：[`.github/pull_request_template.md`](.github/pull_request_template.md)

> [!NOTE]
> **当前状态（2026 年 10 月）：勒让德猜想仍未解决。**
> 目前最好的无条件素数间隙指数仍是 `θ = 0.525`
> （Baker–Harman–Pintz 2001），它 **大于** `1/2`，因此不能推出勒让德猜想。
> 本仓库**不**声称证明了该猜想，也**不**声称已经形式化 Hoheisel、Ingham、
> Huxley、Baker–Harman 或 Baker–Harman–Pintz 的深层指数结果。已形式化的是：
> 定义、初等归约、**Nagura 1952 显式区间定理**（对每个 `x ≥ 25`，
> `(x, 6x/5]` 中有素数，见 [`Nagura.lean`](Legendre/Nagura.lean)）、九项已发表
> 短区间结果的精确陈述级约定（[Layer5.lean](Legendre/Layer5.lean)），以及
> “若将来出现 `θ < 1/2` 的结果，则大 `n` 的勒让德猜想成立”这一精确条件化桥梁。

> [!TIP]
> **Layer 1 已完整完成（Nagura）。** `Legendre/ExplicitBounds.lean` 证明了区间谓词
> `HasPrimeIn`、显式短区间定理“对每个 `x ≥ 1`，`(x, 2x]` 中有素数”、
> Chebyshev 桥 `θ(x) < θ(y) ⇒ (x, y] 中有素数`，以及 `θ`、`ψ`、`π` 的显式
> 上下界。**Nagura 定理现已在** [`Legendre/Nagura.lean`](Legendre/Nagura.lean)
> **中完整证明**：对每个实数 `x ≥ 25`，区间 `(x, 6x/5]` 中有素数
> （`nagura_hasPrimeIn`），并给出显式 Chebyshev 界 `0.916n < ψ(n) < 1.086n`。
> Dusart 型 `x + x/(25 log²x)` 界仍未形式化；见
> [docs/formalization-roadmap.md](docs/formalization-roadmap.md)。
> Nagura 形式化改编自 MIT 许可的
> [ShouqiaoW/erdos](https://github.com/ShouqiaoW/erdos) 项目；见
> [复用的形式化成果](#复用的形式化成果)。
>
> **第 5 层陈述级已完成形式化。** `Legendre/Layer5.lean` 按论文原文的精确 `+ε`、
> 常数与“充分大”约定编码了九项已发表短区间结果，并证明了区间形式、间隙形式与
> `Conditional.lean` 中的粗粒度 `Prop` 三者等价。解析证明本身仍然**开放**。

<details>
<summary><strong>Layer 4：全局 12/5 密度、小截断及多项式幂（2026-11-14）</strong></summary>

**入口：** `import Legendre.Layer4`。对于任意有限 Dirichlet 多项式
`P(t)=Σ_{1≤n≤N} a(n)n^(−it)`，已证明均方积分相对
`(B−A)Σ|a(n)|²` 的偏差现已收紧到 **`2πN Σ|a(n)|²`**，常数对两个端点统一，
由已证明的实直线 Hilbert 不等式推出。优化后的间隔采样在 N>1 时仅损失一个 `log N`。
此前的调和数界、精确极限均值及连续大值测度界均保留；系数允许为任意复数，
新均方估计包括 N=0 的空支撑情形。

新增零密度指数接口，常数对 σ∈[1/2,1] 统一；已证明对数损失到 `T^ε` 的条件传递。
现有有效无零区域还给出 `N(1−1/(4000000 log T),T)` 的固定低高度计数界（T≥3）。
有限加法大筛、间隔采样及 Gram/Halász–Montgomery 接口现已证明；
带权代表集保留零点重数，并给出条件零点检测到密度计数的传递。
新增有限 Euler 公式导出了实际的两分支零点检测器，显式保留极点项；
采样允许各零点实部独立变化，计数界保留两个检测分支的能量。
此前长检测器的较弱计数界现由下述紧支撑检测器的 Ingham 证明加强。
[精确检测器及剩余解析步骤](docs/layer4-zero-detector.md)。
尾部能量已有显式 X^(1−2σ) 衰减，并已从实际检测器推出保留低高度项的完整带重数计数界。
整函数 xi 的对称高斯平方核、精确 Gamma 商界及可积包络已导出精确轮廓函数方程，
并证明临界线上 `|ζ(s)|⁴ ≤ 4|xiSmoothedZetaSquare(s)|²`。
已证明归一化轮廓均方界与临界线四阶矩 `O(T log^6 T)`，并导出每个 `ε>0` 的
`O_ε(T^(1+ε))` 界；文献的尖锐 `log^4` 目标仍开放。[证明链](docs/layer4-moment-kernel.md)。
紧支撑 Möbius 检测器已有精确初始 Mellin 轮廓积分，平滑尺度可独立于此前的平方长度选择。
已证明移到临界线的路径移动公式，并保留精确主极点项；显式高处范围内该项足够小，
从而得到真正的“多项式大值或临界线积分大值”零点检测分支。现已证明整线带权矩及间隔采样核求和界，进一步给出积分分支的三次幂计数界；
多项式分支现已得到
`R ≤ C log^8(2Y+1)(Y^(2−2σ)+T X^(1−2σ))`。取 X=ceil(T)、
Y=T^(3/(2(2−σ))) 平衡两分支，覆盖全部高度并恢复解析重数后，已证明
**`N(σ,T) ≤ C T^(3(1−σ)/(2−σ)) log^10 T`**，适用于全部 σ∈[1/2,1]、T≥2。
因此 **Ingham 1940 曲线零密度估计的任意正 ε 指数版本已闭合证明**，常数对 σ 统一；
`layer4_ingham_comparator` 已为闭合证明。这不等于不同的 Ingham 1937 素数短区间结论。[精确范围](docs/layer4-compact-detector.md)。
实际对数相位相关核现已证明为 `C(sqrt(|t|)+U/|t|)`；
倒数求和的对数界与有限 Gram 对偶性进一步给出含显式 `R sqrt(T)` 项的
无条件 Halász 能量界，也允许各样本实部独立变化。区间细分和窗口优化现已证明
两项大值界 `R ≪ log^6(2U) log(2T) (UE/W²+UTE³/W⁶)`。进一步得到实际 Möbius
多项式二阶矩中的 `R^(2/3)(AT)^(1/3)` 项，对共同纵向平移一致，
并已接入紧支撑检测器的临界质量四阶矩。加强后的两分支计数现已证明
**`N(σ,T) ≤ C T^((12/5)(1−σ)) (1+log T)^38`**，对 σ∈[1/2,1]、T≥2 统一，
保留全部解析重数。因此 `hasZeroDensityEstimate_twelve_fifths` 及独立的
`layer4_huxley_global_comparator` 均已闭合证明。[完整密度证明与参数平衡](docs/layer4-huxley-density.md)。[精确陈述与常数](docs/layer4-exponential-large-values.md)。
**新增（2026-11-14）：受限范围的 Huxley 曲线零密度已证明。** 对每个 `ε>0`，同一个常数
适用于全部 σ∈[1/2,5/6]、T≥2：`N(σ,T) ≤ C_ε T^(3(1−σ)/(3σ−1)+ε)`，保留全部解析重数。
证明对实际短检测块取整数卷积幂，统一控制系数，合并两个检测分支，并覆盖全部高度；
σ≤3/4 由 Ingham 补齐。完整曲线 benchmark 仍有 σ>5/6 的部分待证。
[精确证明、来源及剩余范围](docs/layer4-small-mollifier-powers.md)。

实际无权短和还已证明 Weyl 界 `C sqrt(U) abs(t)^(1/6)`，条件为 `U≤V≤2U`、
`1≤abs(t)`、`U²≤4 abs(t)`。有限差分证明及独立 comparator 均已闭合；
将该输入接到剩余 Möbius 加权多项式分支的步骤仍待完成。[证明与精确范围](docs/layer4-weyl-short-sums.md)。

带权短和现已对所有 `β≥0` 统一得到 `U^(1/2−β)` 因子；一般长度版本显式保留三项差分代价。
在平滑长度 `Y=T` 下，实际 Type II 分支已得到 `C_ε T^(3−4σ+4δ+ε)` 界，
适用于 `X≤2T^δ`，并保留全部主极点约束。剩余 Möbius 多项式分支的组装仍待完成。
[精确陈述与验证](docs/layer4-weighted-long-detector.md)。

**Layer 4 路线图的验收要求已齐备。** 更强的 Huxley 曲线密度、Guth–Maynard
及尖锐四阶矩 `log^4` 仍明确标为开放目标，均未作为全局 `12/5` 证明的假设。

验证（2026-11-14）：**4,302 项构建**、**全部 4,530 个项目定理声明**
的公理审计通过，仅依赖三项标准公理；**304 个 Lean 文件**的实际
`sorry`/`admit`/`sorryAx` 均为零。两份独立定理清单、审计目标与实际公理输出完全一致。
**165 项独立使用检查**全部通过：Layer 4 **120 项**、Layer 3 九项、文献对照 36 项。
新增检查覆盖零截断、空实际零点集、取整、检测器高度、卷积的具体系数、
支撑边界、有界幂的统一性、σ=5/6 的幂窗口，以及 σ=4/5、5/6 的完整受限曲线计数和高度二的共同常数。把逐点系数幂误当成 Dirichlet
卷积幂的用例被 Lean 拒绝；全局定理仍不等于更强的曲线 benchmark。
其他检查覆盖有限差分端点、各自适用陈述中的零及负高度、空重叠区间及 Weyl 长度边界。
删除 Weyl 定理高度与长度条件的误用被 Lean 拒绝。
最新九项检查覆盖实部权重、一般块长、有限 Abel 权重及 Y=T 下实际 Type II 指数，
包括零截断与 σ=3/4 端点。删除 β 条件或遗漏一般长度代价的用例被 Lean 拒绝。
本地完整验证的全局 12/5 密度证明提交：`484d8dfc70c24cb715743a2fc6ca811f800f0c67`（[证明与范围](docs/layer4-huxley-density.md)）。
本地完整验证的解析大值／矩证明提交：[`3c358dd2af95`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/3c358dd2af95dcc46071df0fa860cd38d0559a34)。
本地完整验证的 Ingham 证明提交：[`6e5dd7031d2c`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/6e5dd7031d2c1af9ff40aafefcc9ccca974e81de)。
此前已验证的大筛检查点：[`897139fbb45d`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/897139fbb45d96b98270f24bf5b196c411df1c19)。
初始 Layer 4 证明提交：[`4f31d764b243`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/4f31d764b243f6a093dc9cbf34a677a5ad3bc17c)。
[初始均值估计](docs/layer4-mean-values.md) ·
[大筛、间隔采样与带权零点检测](docs/layer4-large-sieve.md) ·
[线性均方误差与优化采样](docs/layer4-linear-mean-value.md)。

</details>

<details>
<summary><strong>Layer 3：已完成，含完整轮廓的统一估计（2026-11-07）</strong></summary>

本地验证：整库 `lake build`（**4,054 项**）及 **2,756 项**公理审计全部通过。
额外验证覆盖**全部 2,756 个项目定理声明**、9 个独立使用检查及 85 个 Lean 文件；
实际代码中 **`sorry`/`admit`/`sorryAx` 均为 0**。独立使用检查已加入 CI。
已验证证明提交：[`5c4be2780255`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/5c4be2780255ef78fd03bff6976596287d007c06)。

**统一入口：** `import Legendre.Layer3`。Layer 3 原定验收已完成，
见[验收证据与范围](docs/layer3-completion.md)。`layer3_pnt_package` 给出同一个 c>0，
同时满足 ψ/θ/π 的误差界，并保证充分大的 `(x,x+x exp(−c√log x)]` 内有素数。
区间长度的系数为 1，c 和起始阈值为存在性结果；`pnt_prime_gap_classical` 给出自然数素数间隙接口。

[`PrimeNumberTheorem.lean`](Legendre/PrimeNumberTheorem.lean) 实现
**ψ(x)=x+O(x exp(−c√log x))**、**θ(x)=x+O(x exp(−c√log x))** 以及
**π(x)=Li₂(x)+O(x exp(−c√log x))**，共用一个 c>0；这里
`Li₂(x)=∫₂ˣ dt/log t`。衰减常数、误差系数及起始阈值都是存在性结果，没有数值化。
ψ 的解析证明移植自 PNT+，部分求和的误差传递在本项目中新证；
`pnt_eventual_bound` 给出最终不等式接口。
精确的平滑有限高度轮廓分解及其尾项已接入；加强后的**截断零点和式**
见 [`PerronFullExplicit.lean`](Legendre/PerronFullExplicit.lean)：左边固定为
`Re(s)=−1/8`，包含高度 T 内全部临界带零点及解析重数、精确原点项 `−log(2π)`，
并给出**完整保留轮廓的统一余项界**。绝对常数先于 H 选取，高度 T∈(H,H+1)
先于 σ、x 选取。两条水平线的 `‖ζ′/ζ‖≤C(log H)²` 已覆盖 `Re(s)≥−1/8`；
整条左竖边积分的界为 `C x^(−1/8) log²(H+6)`。原有显式 Perron 截断误差界继续保留。
详见[完整公式、量词顺序与证明](docs/perron-uniform-explicit-formula.md)
及[验收证据](docs/layer3-completion.md)。

这是经典 de la Vallée Poussin 误差尺度。它是 o(x)；现已形式化证明对每个 a<1，
`x^a=o(classicalError c)`，且该误差尺度不是 O(x^a)，
因此不能仅凭它推出固定幂次的短区间结果、零密度估计或勒让德猜想。
详见[Layer 3 范围与验收](docs/formalization-roadmap.md#layer-3--prime-counting-and-pnt-with-error-term)
和[移植来源](docs/pnt-provenance.md)。

</details>

<details>
<summary><strong>Layer 2 文档所列完整范围已完成（2026-10-31）</strong></summary>

**Layer 2 四项验收已完成（2026-10-31）**：
此前无零区域/Perron 阶段源码：[`f83e5cb32a60`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/f83e5cb32a60112cfc4b41afd971dbadec1795e4)。
该阶段完整 `lake build`（3994 项构建任务）及全部 310 项公理审计通过。
[`ZetaZeroFree.lean`](Legendre/ZetaZeroFree.lean) 已证明有效无零区域：
**`|Im(s)|≥3` 且 `Re(s)>1−1/(2000000·log|Im(s)|)` 时 `ζ(s)≠0`**。
宽度系数 `c=1/2000000` 和高度阈值 3 均显式给出。局部零点按重数去除后，
Borel-Carathéodory 与 Cauchy 估计给出对数导数界，再与实轴极点界及 `3–4–1` 正性组合排除零点。
结合按重数计数的 N(T)、N(σ,T) 定义、带误差的截断 Perron 公式和公理审计，
已满足 [路线图中的 Layer 2 四项验收条件](docs/formalization-roadmap.md#layer-2--riemann-zeta-foundations)。
**完整范围补齐（2026-10-31）**：
已验证实现源码：[`6b921a2528fa`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/6b921a2528fa1567d37b1b9dea92b1ff92d6f14e)。
最新完整 `lake build`（3999 项构建任务）及全部 **347** 项公理审计通过。
[`ZetaGlobalCounting.lean`](Legendre/ZetaGlobalCounting.lean) 已证明保留解析重数的
全局 **`N(T)≤C·T·log T`（T≥7）** 和 `N(T)=O(T log T)`。
函数方程反射保留零点重数，较宽的 Jensen 圆盘覆盖右半临界带的正、负高度，
从而控制整个临界带。低高度部分明确保留为固定有限常数 B，且对 T≥0 有
`N(T)≤B+2(floor(T)+1)log(40(T+7))/log(14/13)`。
C 是包含 B 的固定正数表达式；已证明 B 有限，未计算其数值。这是全局上界，
不是 Riemann–von Mangoldt 主项渐近公式。
[`ZetaArgumentPrinciple.lean`](Legendre/ZetaArgumentPrinciple.lean) 另已证明高处圆盘在边界无零点时
`∮ ζ′/ζ = 2πi localZetaDegree`，按解析重数计数。
[范围检查表](docs/formalization-roadmap.md#layer-2--riemann-zeta-foundations) 现已为每项 Layer 2 范围与建议切片列出证明，
包括全局 N(T) 界和局部辐角原理接口。零密度估计及短区间 PNT 误差仍属后续层级，尚未证明勒让德猜想。

**带误差的截断 Perron 公式（2026-10-31）**：
[`PerronError.lean`](Legendre/PerronError.lean) 证明，对 x>0、σ>1、T>0，
**`|P(x,σ,T)−ψ₀(x)|≤U(x,σ)/T`**，其中 ψ₀ 在整数端点取半权。
先证明误差系数可求和，再以 `n≤floor(2x)` 的有限求和加闭式尾界
`[2x^σ/(π log 2)] [2/(σ−1)] [1+2/(σ−1)]` 上界化。
标量核在 y≠1 时误差不超过 `2y^σ/(π T |log y|)`，y=1 时不超过 `σ/(π T)`。
这满足 Layer 2 的截断 Perron 公式验收项。常数依赖 x、σ，尚不是短区间 PNT 的统一误差估计。

**有效无零区域的输入（2026-10-31）**：
[`ZetaPositivity.lean`](Legendre/ZetaPositivity.lean) 已证明 σ>1 上的 `3–4–1` 对数导数正性不等式。
[`ZetaGrowth.lean`](Legendre/ZetaGrowth.lean) 通过绝对收敛的分数部分 Mellin 余项，
将 Euler 求和延拓至 Re(s)>0，证明余项范数不超过 1/Re(s)，从而在 s≠1 时
`|ζ(s)|≤|s|/|s−1|+|s|/Re(s)`，并证明 Re(s)≥2 时 `|ζ(s)|≥1/2`。
[`ZetaLocalBound.lean`](Legendre/ZetaLocalBound.lean) 证明 |t|≥3 时，
以 2+it 为中心、半径 3/2 的闭圆盘上 `|ζ|≤12(|t|+2)`；由 Jensen 不等式，
半径 5/4 子圆盘内零点总重数不超过 `log(24(|t|+2))/log(6/5)`。
后续 `ZetaZeroRemoval.lean`、`ZetaRegularizedBound.lean`、`ZetaLogDerivativeLocal.lean`、
`ZetaPoleBounds.lean` 与 `ZetaZeroFree.lean` 已将这些输入组合为 c=1/2000000、高度阈值 3 的有效无零区域。

**ψ 的 Perron 反演（2026-10-31）**：
[`PerronInversion.lean`](Legendre/PerronInversion.lean) 证明：对 x>0、σ>1，
规范化的有限 Perron 积分在非整数端点趋于 **ψ(x)**，在正整数 m 处趋于
**ψ(m)−Λ(m)/2**。统一标量上界乘以 Λ(n) 后可求和：n≥2x 时
`|log(x/n)|≥log 2`，可与绝对收敛的 Dirichlet 级数比较。
Tannery 定理保证无限高度极限与级数交换，再由极限项的有限支撑识别半权 ψ。
固定 x 的截断误差界已在 `PerronError.lean` 中证明；`ZetaZeroFree.lean` 已给出有效对数型无零区域。

**标量 Perron 反演（2026-10-30）**：
[`PerronResidue.lean`](Legendre/PerronResidue.lean) 联同
[`PerronShift.lean`](Legendre/PerronShift.lean)、[`PerronZero.lean`](Legendre/PerronZero.lean)
证明，对每个 y>0、σ>0：**y<1 时 J(y,σ,T)→0，y=1 时→1/2，y>1 时→1**。
正竖直线平移、水平边趋零和与高度无关的范数界给出 y<1 的情形；
将 `(y^s-1)/s` 在零点解析延拓，再借助倒数底数反射计入极点贡献，得到 y>1 的情形。
这是标量核的反演；与 von Mangoldt 级数交换极限和半权 ψ 重建现已在
`PerronInversion.lean` 中证明。`PerronError.lean` 已给出固定 x 的截断误差界；有效对数型无零区域现已在 `ZetaZeroFree.lean` 中证明。

**标量核收敛性（2026-10-30）**：
已验证源码提交：[`262e64dd1d08`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/262e64dd1d081f339e63d682c4adbc42269e8b10)。
[`PerronTail.lean`](Legendre/PerronTail.lean) 证明，对每个 y>0、σ>0，
J(y,σ,T) 在 T→∞ 时存在极限。分部积分给出趋零边界项，以及在 (1,∞)
上绝对可积的余项；复共轭反射处理负半轴。这是标量核的条件收敛性，
并非原无限直线被积函数的绝对可积性。极限值现已在 `PerronResidue.lean`
中求出；与 von Mangoldt 级数交换极限现已在 `PerronInversion.lean` 中证明；Layer 2 的四项验收现已完成。

**振荡分子（2026-10-30）**：
已验证源码提交：[`13df761e6893`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/13df761e689301c0acc7d6d80d15093509473e17)
（verify 通过后经 review 合入 master）。
[`PerronOscillation.lean`](Legendre/PerronOscillation.lean) 在 y>0 时证明
`y^(σ+it)=y^σ exp(it log y)`。对 y≠1，已求出有限分子积分，并证明其范数
不超过 `2y^σ/|log y|`，与两端高度无关。这为与 `1/(σ+it)` 分部积分
提供输入；标量核的极限现已在 `PerronResidue.lean` 中求出。

**标量 Perron 核的端点（2026-10-30）**：
已验证源码提交：[`0baaeed095a6`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/0baaeed095a6b0f34cf83557858329d9a57d356b)
（PR #5 的 verify 通过后合入 review）。
[`PerronKernel.lean`](Legendre/PerronKernel.lean) 证明 `σ>0` 时
`J(1,σ,T)=arctan(T/σ)/π`，因此 `T→∞` 时极限为 `1/2`；
`T>0` 时端点误差满足 `|J(1,σ,T)-1/2|≤σ/(πT)`。
这确立了端点的半权约定；非端点极限值和与 von Mangoldt 求和的极限交换均已证明，固定 x 的截断误差界现已在 `PerronError.lean` 中证明。

**有限 Perron 积分与级数交换（2026-10-30）**：
[`PerronSeries.lean`](Legendre/PerronSeries.lean) 证明 `x>0`、`σ>1` 时，
可在任意有限竖直线段上对带权 von Mangoldt 级数逐项积分。与高度无关的可求和上界
保证交换合法，并证明积分后各项的绝对收敛性。得到精确恒等式
`P(x,σ,T)=∑ Λ(n)J(x/n,σ,T)`，其中 J 是有限标量 Perron 核。
J 的无限高度极限值已在 `PerronResidue.lean` 中求出；`PerronInversion.lean`
现已交换该级数的极限并重建半权 ψ。固定 x 的截断误差界现已在 `PerronError.lean` 中证明。

**有限竖直 Perron 积分（2026-10-30）**：
[`PerronTruncated.lean`](Legendre/PerronTruncated.lean) 定义了 `s=σ+it`
上的规范化有限竖直积分，证明 `x>0`、`σ>1` 时的可积性及显式有限高度范数界。
记 `B(σ)=(2/(σ-1))(1+2/(σ-1))`，核满足
`|K(x,σ+it)|≤B(σ)x^σ/σ`，且在 `t≠0` 时满足 `≤B(σ)x^σ/|t|`。
`PerronInversion.lean` 现已证明 Perron 反演；相对于半权 ψ 的固定 x 截断误差界已在 `PerronError.lean` 中证明。

**局部 Perron 围道积分（2026-10-30）**：
[`PerronContour.lean`](Legendre/PerronContour.lean) 证明，对每个 `x>0`，
存在 `δ>0`，使所有以 1 为圆心、半径满足 `0<r<δ` 的正向圆周均满足
**`∮ K(x,s) ds = 2πix`**。证明构造了 `(s-1)K(x,s)` 在 1 的解析延拓，
再应用 Cauchy 积分公式。半径尚非有效；后续模块已证明标量矩形移动与 Perron 反演，固定 x 的截断误差界现已在 `PerronError.lean` 中证明。

已验证的 Abel/Perron 基础阶段提交: [`83afea75433f`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/83afea75433f02e9900fafe5381db659b4fd1ba1).

**Abel 积分表示与带权极点系数（2026-10-30）**：新增
[`PerronFoundation.lean`](Legendre/PerronFoundation.lean)。对 `Re(s)>1`，
已证明 **`-ζ′/ζ(s)=s∫₁∞ψ(t)t^(-s-1)dt`**，并单独证明该积分绝对收敛。
部分和的线性控制来自已证明的 Chebyshev 界，随后接入 mathlib 的 Abel 部分求和。
对 `x>0`，带权核 `K(x,s)=(-ζ′/ζ(s))x^s/s` 满足
**`(s-1)K(x,s)→x`**。这是前向积分表示与局部系数极限，
**尚不是 Perron 反演或带截断误差的围道公式**。

已验证的极点局部结构阶段提交: [`c28a28c1a28c`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/c28a28c1a28c3fc382d48e0fb4f736d4d1cb6828).

**极点主部与局部增长已证明**：新增 [`ZetaPole.lean`](Legendre/ZetaPole.lean)。
将 `H(s)=(s-1)ζ(s)` 在 `s=1` 补为 `H(1)=1` 后，已证明 H 在 1 附近解析，
且 `ζ′/ζ(s)+1/(s-1)` 趋于有限值。由此得到 **`(s-1)ζ′/ζ(s)→-1`**，
以及 Perron 常用符号下 **`(s-1)(-ζ′/ζ(s))→+1`**。
还证明存在 `C>0`，在 1 的某个去心邻域有 `|ζ′/ζ(s)|≤1/|s-1|+C`。
补值只用于 H，不是把 ζ 本身延拓穿过极点；常数和邻域无显式估计，
尚未证明 Perron 围道积分公式或高虚部的定量无零点区域。

已验证的 ε 显式界阶段提交: [`bb75a8305f9f`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/bb75a8305f9fecb883d060dcbb7165c6c909738a).

**右侧半平面的 ε 显式界已证明**：新增
[`ZetaHalfPlane.lean`](Legendre/ZetaHalfPlane.lean)，对任意 `ε>0`，
**`Re(s)≥1+ε ⇒ |ζ′/ζ(s)|≤(2/ε)(1+2/ε)`**；当 `0<ε≤1` 时，
进一步有 **`|ζ′/ζ(s)|≤6/ε²`**。证明包括幂级数的积分比较、von Mangoldt
系数的幂控制及合法的级数比较，均为 Lean 内核检查的推论。
这使显式控制适用于任意靠近 `Re(s)=1` 的右侧闭半平面；没有延伸到该直线
左侧，也没有证明定量无零点区域或 Perron 公式。

已验证的对数导数阶段提交: [`2a395e71b4a8`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/2a395e71b4a8e1bff3f287a4d6253d4bfce0401f).

**对数导数与计数的连接已证明**：新增
[`ZetaLogDerivative.lean`](Legendre/ZetaLogDerivative.lean)。复用 mathlib 已证明的
von Mangoldt 级数绝对收敛及 `-ζ′/ζ` 恒等式（`Re(s)>1`）；新增整个闭半平面的
收敛级数控制，并证明显式界 **`Re(s) ≥ 3 ⇒ |ζ′(s)/ζ(s)| ≤ π²/6`**。
另外证明：对每个固定高度 `T`，存在 `0<σ<1` 使 `N(σ,T)=0`，把此前定性
无零点带连接到按重数计数的接口。该 `σ` 无显式估计；这些结果不包含
临界线附近的对数导数控制、`c/log T` 无零点区域或 Perron 公式。

已验证的零点计数基础提交: [`0c2b0574ec83`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/0c2b0574ec83a787bff4e61cd07ab51ccb7c0fce).

**零点计数基础已完成定义和检查**：新增 [`ZetaCounting.lean`](Legendre/ZetaCounting.lean)，
定义临界带内的 `NontrivialZero`、按解析重数计数的 `zeroCount`（`N(T)`）和
`zeroDensityCount`（`N(σ,T)`）。计数约定为 `0 < Re(s) < 1`、`0 < Im(s) ≤ T`，
密度计数额外要求 `σ ≤ Re(s)`。已证明重数有限且在零点处为正、计数集合有限、
计数的单调性、正计数与存在零点的等价性及边界情形；并非仅计不同零点。
**尚无零点计数渐近估计或零密度估计**，也未声称证明所有零点的分类。

已验证的形式化提交: [`63ba01a3a814`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/63ba01a3a81457bfab5b6f2d4cca378c2e7adf99).


**已接入并验证 ζ 基础接口**：绝对收敛、Euler 乘积及有限乘积收敛、
避开极点的解析延拓、完成 ζ 的函数方程、`Re(s) ≥ 1`（排除极点）非消失性，
以及紧集内不同零点的有限性。见 [`Legendre/Zeta.lean`](Legendre/Zeta.lean)。
这些基础定理直接复用 mathlib v4.35.0 的已证明结果，不作为本项目新证明。

**新增推论** `Legendre.Zeta.exists_zero_free_strip`：每个固定高度 `T` 都存在
`δ(T) > 0`，使 `Re(s) > 1 - δ(T)`、`|Im(s)| ≤ T`、`s ≠ 1` 时 `ζ(s) ≠ 0`。
这个早期定性结果的宽度无显式估计。后续 `ZetaZeroFree.lean` 已证明 c=1/2000000、
高度阈值 3 的定量对数型无零区域；第 2 层四项验收已完成。全局 `N(T)=O(T log T)` 界与局部辐角原理接口现已证明；PNT 误差项属后续层级。
固定版本、上游作者及逐项对应见 [出处说明](docs/zeta-provenance.md)。
适配并验证于 Lean 4.35.0 / mathlib v4.35.0；没有引入新的信任公理。

</details>

## 文献指数对照

下表及目标猜想共 **17 项**均已有[独立 Lean comparator](docs/literature-comparators.md)，
并建立覆盖全部项目 Lean 文件的 Layer 0～4 对照清单。
`python3 scripts/check_literature.py` 核对清单并编译独立的数值预期。
比较允许正 `ε` 损失、无害乘法常数及区间方向变换，但保留假设、有限范围与“最终成立”的区别。
目前只有 Bertrand、Nagura 两项历史素数区间定理已有无条件证明；其余条目对照通过不代表原定理已证明。

**来源勘误：** Heath-Brown–Iwaniec 1979 应为 `11/20`（Pintz 作者综述 §3 (3.13)）；
Iwaniec–Pintz 1984 应为 `23/42`（出版社摘要及同一综述）。
此前的 `13/23` 归属及缺乏所引文献支持的 `11/20−1/406` 已在 Lean 与文档中同步修正。
旧 `*Paper` 名称保留，含义明确为指数规范化结论，不再称作论文全部强结论的精确陈述。
Sorenson–Webster 期刊最终版范围为 `7.05×10^13`，arXiv v1 仅为 `3.33×10^13`。
[逐项来源、疑似引言笔误及核查限制](docs/literature-comparators.md#corrections-and-source-limitations)。
本次没有确立原始素数间隙定理证明中的数学漏洞。
另已明确：已完成 Layer 2 的 `c/log T` 无零区域本身不满足 Ingham 原始短区间传递
所用的更宽 `A log log T/log T` 区域；该文献输入仍待补齐。

<!-- comparator:legendre1808 -->
## 历史进展总览

**仓库当前状态（2026-11-14）：** Layer 3 的经典 PNT、Layer 4 的
**Ingham 1940 曲线密度**与**全局 Huxley 12/5 零密度指数**均已证明。下表九项历史短区间指数结果仍仅完成陈述形式化；
已证明的 1940 密度估计尚未闭合 **Ingham 1937 的两项素数间隙结论**。
Layer 4 路线图验收要求已齐备；更强的 Huxley 曲线密度及 Guth–Maynard 目标仍开放。
受限曲线密度现已覆盖 σ∈[1/2,5/6]、全部高度和解析重数；完整 benchmark 的 σ>5/6 部分仍开放。
这一进展尚不改变下表历史短区间结论的证明状态。

**目标.** 勒让德猜想（A.-M. Legendre, *Essai sur la théorie des nombres*,
第 2 版, Courcier, Paris, 1808）：开区间 `(n²,(n+1)²)` 中有素数。`θ < 1/2` 足以推出最终成立；
在端点 `θ = 1/2` 还需控制常数（例如 `< 2`）。
它仍未解决，也没有形式化证明。

这里的 `θ` 指 `p_{n+1} - p_n ≪ p_n^{θ+ε}` 中的指数；`+ε` 是论文陈述的一部分。
对九项指数结果，“无证明”表示指数规范化陈述已经编码（既作为
`Legendre/Conditional.lean` 中的粗粒度 `Prop`，也作为 `Legendre/Layer5.lean`
中的 `+ε`、常数与阈值约定），但**它的证明没有形式化**。RH 与 Cramér 保留相应条件或猜想身份；对照器不会把它们当作已证明。

| 里程碑 | 原始文献 | 指数 θ | Lean 证明状态 | Lean 代码 |
|---|---|---|---|---|
| **Bertrand 公设** | J. Bertrand, *Mémoire sur le nombre de valeurs que peut prendre une fonction quand on y permute ses variables*, J. École Polytechnique **17** (1845), 123–140；证明：P. L. Chebyshev, *Mémoire sur les nombres premiers*, J. Math. Pures Appl. **17** (1852), 366–390 | **1** | **[✅ 是 — mathlib 证明，已复用](Legendre/Bertrand.lean#L27)** | **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)**  [对照](docs/literature-comparators.md#bertrand1852) <!-- comparator:bertrand1852 --> |
| **Nagura 1952** | J. Nagura, *On the interval containing at least one prime number*, Proc. Japan Acad. **28** (1952), 177–181, [DOI 10.3792/pja/1195570997](https://doi.org/10.3792/pja/1195570997) | **1**（改进常数）：`(x, 6x/5]`，`x ≥ 25` | **[✅ 是 — 本仓库完整证明](Legendre/Nagura.lean#L50)** | **[Nagura.lean L41](Legendre/Nagura.lean#L41)** · **[L50](Legendre/Nagura.lean#L50)** · **[PsiBounds.lean L1671](Legendre/Nagura/PsiBounds.lean#L1671)**  [对照](docs/literature-comparators.md#nagura1952) <!-- comparator:nagura1952 --> |
| Hoheisel 1930 | G. Hoheisel, *Primzahlprobleme in der Analysis*, Sitzungsber. Preuss. Akad. Wiss. (1930), 580–588 | 32999/33000 | **[❌ 否 — 无证明，指数陈述 ✅](Legendre/Layer5/Statements.lean#L291)** | **[Conditional.lean L70](Legendre/Conditional.lean#L70)** · **[Statements.lean L291](Legendre/Layer5/Statements.lean#L291)**  [对照](docs/literature-comparators.md#hoheisel1930) <!-- comparator:hoheisel1930 --> |
| Ingham 1937（Lindelöf 路线） | A. E. Ingham, *On the difference between consecutive primes*, Quart. J. Math. Oxford **8** (1937), 255–266 | 5/8 | **[❌ 否 — 无证明，指数陈述 ✅](Legendre/Layer5/Statements.lean#L304)** | **[Conditional.lean L74](Legendre/Conditional.lean#L74)** · **[Statements.lean L304](Legendre/Layer5/Statements.lean#L304)**  [对照](docs/literature-comparators.md#ingham1937lindelof) <!-- comparator:ingham1937lindelof --> |
| Ingham 1937（零密度路线） | 同上 | 577/925 + ε | **[❌ 素数间隙仍待证明 — 指数陈述 ✅](Legendre/Layer5/Statements.lean#L317)**；[1940 密度指数已另行证明](Legendre/Layer4/InghamDensity.lean) | **[Conditional.lean L77](Legendre/Conditional.lean#L77)** · **[Statements.lean L317](Legendre/Layer5/Statements.lean#L317)**  [对照](docs/literature-comparators.md#ingham1937density) <!-- comparator:ingham1937density --> |
| Huxley 1972 | M. N. Huxley, *On the difference between consecutive primes*, Invent. Math. **15** (1972), 164–170 | 7/12 + ε | **[❌ 否 — 无证明，指数陈述 ✅](Legendre/Layer5/Statements.lean#L330)** | **[Conditional.lean L80](Legendre/Conditional.lean#L80)** · **[Statements.lean L330](Legendre/Layer5/Statements.lean#L330)**  [对照](docs/literature-comparators.md#huxley1972) <!-- comparator:huxley1972 --> |
| Heath-Brown–Iwaniec 1979 | D. R. Heath-Brown, H. Iwaniec, *On the difference between consecutive primes*, Invent. Math. **55** (1979), 49–69 | 11/20 + ε | **[❌ 否 — 无证明，指数陈述 ✅](Legendre/Layer5/Statements.lean#L342)** | **[Conditional.lean L83](Legendre/Conditional.lean#L83)** · **[Statements.lean L342](Legendre/Layer5/Statements.lean#L342)**  [对照](docs/literature-comparators.md#heathbrowniwaniec1979) <!-- comparator:heathbrowniwaniec1979 --> |
| Iwaniec–Pintz 1984 | H. Iwaniec, J. Pintz, *Primes in short intervals*, Monatsh. Math. **98** (1984), 115–143 | 23/42 + ε | **[❌ 否 — 无证明，指数陈述 ✅](Legendre/Layer5/Statements.lean#L355)** | **[Conditional.lean L86](Legendre/Conditional.lean#L86)** · **[Statements.lean L355](Legendre/Layer5/Statements.lean#L355)**  [对照](docs/literature-comparators.md#iwaniecpintz1984) <!-- comparator:iwaniecpintz1984 --> |
| Mozzochi 1986 | C. J. Mozzochi, *On the difference between consecutive primes*, J. Number Theory **24** (1986), 181–187 | 11/20 − 1/384 + ε | **[❌ 否 — 无证明，指数陈述 ✅](Legendre/Layer5/Statements.lean#L368)** | **[Conditional.lean L89](Legendre/Conditional.lean#L89)** · **[Statements.lean L368](Legendre/Layer5/Statements.lean#L368)**  [对照](docs/literature-comparators.md#mozzochi1986) <!-- comparator:mozzochi1986 --> |
| Baker–Harman 1996 | R. C. Baker, G. Harman, *The difference between consecutive primes*, Proc. London Math. Soc. (3) **72** (1996), 261–280 | 0.535 | **[❌ 否 — 无证明，指数陈述 ✅](Legendre/Layer5/Statements.lean#L382)** | **[Conditional.lean L92](Legendre/Conditional.lean#L92)** · **[Statements.lean L382](Legendre/Layer5/Statements.lean#L382)**  [对照](docs/literature-comparators.md#bakerharman1996) <!-- comparator:bakerharman1996 --> |
| Baker–Harman–Pintz 2001 | R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive primes, II*, Proc. London Math. Soc. (3) **83** (2001), 532–562 | **0.525**（当前纪录） | **[❌ 否 — 无证明，指数陈述 ✅](Legendre/Layer5/Statements.lean#L397)** | **[Conditional.lean L96](Legendre/Conditional.lean#L96)** · **[Statements.lean L397](Legendre/Layer5/Statements.lean#L397)**  [对照](docs/literature-comparators.md#bakerharmanpintz2001) <!-- comparator:bakerharmanpintz2001 --> |
| Riemann 假设（条件性） | H. Cramér, *Some theorems concerning prime numbers*, Ark. Mat. Astron. Fys. **15** (1920), no. 5, 1–32 | 1/2 + o(1) | **[❌ 否 — 无证明，粗粒度 `Prop`](Legendre/Conditional.lean#L130)** | **[Conditional.lean L130](Legendre/Conditional.lean#L130)**  [对照](docs/literature-comparators.md#cramer1920rh) <!-- comparator:cramer1920rh --> |
| Cramér 猜想（条件性） | H. Cramér, *On the order of the difference between consecutive primes*, Acta Arith. **2** (1936), 23–46 | 0 + ε（猜想） | **[❌ 否 — 无证明，粗粒度 `Prop`](Legendre/Conditional.lean#L137)** | **[Conditional.lean L137](Legendre/Conditional.lean#L137)**  [对照](docs/literature-comparators.md#cramer1936) <!-- comparator:cramer1936 --> |
| 显式验证 `n ≤ 7.05×10¹³` | J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's conjecture up to 7·10¹³*, Res. Number Theory **11** (2025), Paper 4 | 不适用（有限范围） | **[❌ 无证明 — 已有对照陈述](Legendre/Literature/Statements.lean)** | **[第 6 层路线图](docs/formalization-roadmap.md)**  [对照](docs/literature-comparators.md#sorensonwebster2025) <!-- comparator:sorensonwebster2025 --> |
| Chen 1975（`P₂`，最终） | Chen Jing-Run, *On the distribution of almost primes in an interval*, Sci. Sinica **18** (1975), 611–627 | 不适用（`P₂`） | **[❌ 无证明 — 已有对照陈述](Legendre/Literature/Statements.lean)** | **[Conditional.lean L146](Legendre/Conditional.lean#L146)**  [对照](docs/literature-comparators.md#chen1975) <!-- comparator:chen1975 --> |
| Dudek–Johnston 2026（`P₄`，所有 `n`） | A. W. Dudek, D. R. Johnston, *Almost primes between all squares*, J. Number Theory **278** (2026), 726–745 | 不适用（`P₄`） | **[❌ 无证明 — 已有对照陈述](Legendre/Literature/Statements.lean)** | **[第 7 层路线图](docs/formalization-roadmap.md)**  [对照](docs/literature-comparators.md#dudekjohnston2026) <!-- comparator:dudekjohnston2026 --> |

状态单元格本身可点击：**✅** 跳转到证明；**❌“无证明，指数陈述 ✅”** 跳转到
[`Layer5.lean`](Legendre/Layer5.lean) 中按论文原文编码的陈述（不是证明）；
**❌“无证明，粗粒度 `Prop`”** 跳转到粗粒度条件陈述编码；**❌“未编码”** 跳转到
路线图。完整 DOI/arXiv 链接与证据等级见
[docs/literature.md](docs/literature.md)。
这九项指数结果**没有**被证明。它们的粗粒度 `Prop` 在 `Conditional.lean`，
论文原文的 `+ε`/常数/阈值形式在 `Layer5.lean`，两者之间的等价性**已证明**。
把假设的 `θ < 1/2` 结果化为勒让德猜想的归约本身，另行在
**[Reduction.lean L110](Legendre/Reduction.lean#L110)** 中**证明**。

支撑上述目标的解析里程碑现已完成以下部分：

| 解析里程碑 | 当前已证明的估计 | Lean 证明与适用范围 |
|---|---|---|
| 经典 PNT（Layer 3） | ψ、θ、π 共用误差尺度 `x exp(−c√log x)`，并给出相应的最终素数区间 | **✅ 已证明**：[`layer3_pnt_package`](Legendre/Layer3.lean)。该误差尺度尚不能给出固定的素数间隙指数 `θ<1`。 |
| Ingham 1940 零密度（Layer 4），[原文 DOI](https://doi.org/10.1093/qmath/os-11.1.201) | 每个 `ε>0` 均有 `N(σ,T) ≪_ε T^(3(1−σ)/(2−σ)+ε)` | **✅ 已证明**：[`ingham_density_epsilon`](Legendre/Layer4/InghamDensity.lean) 及闭合的 [`layer4_ingham_comparator`](Legendre/Literature/LayerCoverage.lean)；对 σ∈[1/2,1]、T≥2 统一，保留解析重数。已证对数形式带 `log^10 T`，未声称原文尖锐的 `log^5 T`。 |
| 全局 Huxley 密度（Layer 4） | 每个 `ε>0` 均有 `N(σ,T) ≪_ε T^((12/5)(1−σ)+ε)` | **✅ 已证明**：[`hasZeroDensityEstimate_twelve_fifths`](Legendre/Layer4/HuxleyDensity.lean) 及闭合的 [`layer4_huxley_global_comparator`](Legendre/Literature/LayerCoverage.lean)；对 σ∈[1/2,1]、T≥2 统一，保留全部解析重数。σ∈[3/4,1] 上还得到更强的中间界；原文更强曲线 Huxley benchmark 仍开放。 |
| 受限 Huxley 曲线密度（Layer 4） | 每个 `ε>0` 均有 `N(σ,T) ≪_ε T^(3(1−σ)/(3σ−1)+ε)`，σ∈[1/2,5/6] | **✅ 已证明**：[`huxley_curved_restricted_density_epsilon`](Legendre/Layer4/HuxleyCurvedDensity.lean) 与闭合的 [`layer4_huxley_restricted_comparator`](Legendre/Literature/LayerCoverage.lean)；全部 T≥2、解析重数。完整 benchmark 的 σ>5/6 部分仍开放。 |
| 临界线四阶矩（Layer 4） | `∫₀ᵀ ‖ζ(1/2+it)‖⁴ dt ≪ T log^6 T`，从而有 `≪_ε T^(1+ε)` | **✅ 已证明**：[`ZetaFourthMoment.lean`](Legendre/Layer4/ZetaFourthMoment.lean)。尖锐的 `log^4 T` 目标仍开放。 |
| Halász 解析输入（Layer 4） | 二进块相关核 `≪ sqrt(abs(t))+U/abs(t)`；含显式 `R sqrt(T)` 项的能量界，并允许混合实部 | **✅ 已证明**：[`HalaszComplex.lean`](Legendre/Layer4/Exponential/HalaszComplex.lean)。区间细分、两项大值计数和实际 Möbius／临界质量矩的加强界均已证明；更强的 Huxley 曲线目标仍开放。 |
| 解析大值计数及实际 Möbius 矩（Layer 4） | `R ≪ log^6(2U) log(2T)(UE/W²+UTE³/W⁶)`；实际 Möbius 二阶矩中的加强项 `R^(2/3)(AT)^(1/3)` | **✅ 已证明**：闭合的 [`layer4_actual_halasz_large_values_comparator`](Legendre/Literature/LayerCoverage.lean)、[加权 Möbius 矩](Legendre/Layer4/HalaszMollifierMoment.lean) 及[实际临界质量矩](Legendre/Layer4/HalaszCriticalMass.lean)。全局 12/5 现已证明；更强的 Huxley 曲线目标仍开放。 |

**全局 `12/5` 指数已证明**；更强的 Huxley 曲线密度及 Guth–Maynard 密度仍**待证明**。
[`LayerCoverage.lean`](Legendre/Literature/LayerCoverage.lean) 中的相应对照桥仍需这些
开放的密度输入；其中的 Ingham 输入现已闭合证明。

## Lean 中真正验证了什么

`lake build` 证明以下内容，且没有 `sorry`、`admit`、自定义
`axiom`/`constant`/`opaque`，也没有 `False.elim`/`absurd` 爆炸捷径：

<details>
<summary><strong>点击展开：已验证声明及源码链接</strong></summary>

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
| `Legendre.HasPrimeIn` / `hasPrimeIn_self` | 显式区间谓词；对每个 `x ≥ 1`，`(x, 2x]` 中有素数 | **已证明** | **[ExplicitBounds.lean L38](Legendre/ExplicitBounds.lean#L38)** · **[L55](Legendre/ExplicitBounds.lean#L55)** |
| `Legendre.exists_prime_of_theta_lt` / `hasPrimeIn_of_theta_gap` | `θ` 严格增加 ⇒ `(x, y]` 中有素数 | **已证明** | **[L75](Legendre/ExplicitBounds.lean#L75)** · **[L107](Legendre/ExplicitBounds.lean#L107)** |
| `Legendre.theta_upper_explicit` / `theta_lower_explicit` | Chebyshev `θ` 显式上下界 | **已证明** | **[L118](Legendre/ExplicitBounds.lean#L118)** · **[L123](Legendre/ExplicitBounds.lean#L123)** |
| `Legendre.psi_upper_explicit` / `psi_lower_explicit` | Chebyshev `ψ` 显式上下界 | **已证明** | **[L129](Legendre/ExplicitBounds.lean#L129)** · **[L134](Legendre/ExplicitBounds.lean#L134)** |
| `Legendre.pi_lower_explicit` / `pi_upper_explicit` | `π` 显式上下界 | **已证明** | **[L139](Legendre/ExplicitBounds.lean#L139)** · **[L145](Legendre/ExplicitBounds.lean#L145)** |
| `Legendre.conjecture_of_almostPrimeSquareAtMost_one` | 几乎素数 `P₁` 平方区间命题就是勒让德猜想 | **已证明** | **[Conditional.lean L172](Legendre/Conditional.lean#L172)** |
| `Legendre.almostPrimeSquareAtMost_one_iff` | `P₁` 平方区间命题 ↔ 勒让德猜想 | **已证明** | **[Conditional.lean L190](Legendre/Conditional.lean#L190)** |
| `Legendre.nagura_hasPrimeIn` / `nagura_prime_gap` | Nagura 定理：对每个 `x ≥ 25`，`(x, 6x/5]` 中有素数 | **已证明** | **[Nagura.lean L50](Legendre/Nagura.lean#L50)** · **[L41](Legendre/Nagura.lean#L41)** |
| `Legendre.Nagura.naguraChebyshevSum_eq_log_factorial` | Ramanujan/Nagura 恒等式 `∑_{m≤n} ψ(n/m) = log n!` | **已证明** | **[PsiBounds.lean L109](Legendre/Nagura/PsiBounds.lean#L109)** |
| `Legendre.Nagura.psi_nat_lt_1_086_mul` / `psi_nat_gt_0_916_mul` | 显式 Chebyshev 界 `0.916n < ψ(n) < 1.086n` | **已证明** | **[PsiBounds.lean L1671](Legendre/Nagura/PsiBounds.lean#L1671)** · **[L1844](Legendre/Nagura/PsiBounds.lean#L1844)** |
| `Legendre.HasPrimeInShortInterval` / `ShortIntervalStatement` / `PrimeGapBound` | 指数规范化陈述约定：显式指数、常数与“充分大”阈值 | 定义 | **[Statements.lean L62](Legendre/Layer5/Statements.lean#L62)** · **[L72](Legendre/Layer5/Statements.lean#L72)** · **[L81](Legendre/Layer5/Statements.lean#L81)** |
| `Legendre.hasPrimeInShortInterval_iff_primeGapBound` | 区间形式 ↔ 间隙形式（相同的 `θ` 与 `C`，需 `θ ≥ 0`、`C ≥ 0`） | **已证明** | **[Statements.lean L162](Legendre/Layer5/Statements.lean#L162)** |
| `Legendre.shortIntervalStatement_iff_exponentLimit` | 指数规范化 `+ε` 形式 ↔ 粗粒度条件化接口 | **已证明** | **[Statements.lean L258](Legendre/Layer5/Statements.lean#L258)** |
| `Legendre.legendre_eventually_of_shortIntervalStatement_lt_half` | 指数规范化 `θ < 1/2` 陈述 ⇒ 大 `n` 的勒让德猜想 | **已证明** | **[Statements.lean L266](Legendre/Layer5/Statements.lean#L266)** |
| `Legendre.*Paper_iff`（九项结果） | 每项结果的指数规范化陈述 ↔ 其粗粒度 `Prop` | **已证明** | **[Statements.lean L295](Legendre/Layer5/Statements.lean#L295)** |
| `Legendre.PNT.psi_classical_error` | ψ=x+O(x exp(−c√log x))，c>0 | **已证明**；解析证明移植自 PNT+ | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.primeCount_error_of_theta` | 部分求和保留经典误差尺度 | **已证明**；本项目新增桥梁 | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.pnt_classical_error` / `pnt_eventual_bound` | ψ/θ/π−Li₂ 的共同经典误差与最终不等式 | **已证明**；常数为存在性结果 | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.classicalError_isLittleO` / `exists_smoothed_truncated_formula` | 次线性误差与精确平滑有限高度轮廓分解 | **已证明**；零点和式另有依赖轮廓的余项界 | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.Zeta.exists_truncated_explicit_formula` | ψ₀=x−∑m(ρ)x^ρ/ρ+E，计入绝对高度 T 内全部临界带零点 | **已证明**；余项界保留轮廓依赖 | [PerronExplicitBounds.lean](Legendre/PerronExplicitBounds.lean) |
| `Legendre.Zeta.unitZeroCount_le_log` / `zeroCount_increment_le_unitZeroCount` | 单位高度零点重数之和为 O(log H) | **已证明**；H≥4，包含临界线两侧 | [ZetaUnitCounting.lean](Legendre/ZetaUnitCounting.lean) |
| `Legendre.Zeta.exists_good_height_log_separation` / `exists_good_height_logDeriv_bound` | 定量避零距离 c/log H；两条水平线在 Re(s)≥7/8 上的对数平方界 | **已证明**；显式正常数，H≥7 | [ZetaGoodHeightBounds.lean](Legendre/ZetaGoodHeightBounds.lean) |
| `Legendre.Zeta.exists_good_height_perron_horizontal_bound` | 7/8≤α≤σ 的归一化 Perron 水平积分界 | **已证明**；含可积性；下方已加强到 Re(s)≥−1/8 | [PerronGoodHeight.lean](Legendre/PerronGoodHeight.lean) |
| `Legendre.Zeta.exists_full_truncated_explicit_formula` | ψ₀=x−∑m(ρ)x^ρ/ρ−log(2π)+E，固定左边界 Re(s)=−1/8 | **已证明**；完整轮廓绝对常数先于 H、T、σ、x；[精确界](docs/perron-uniform-explicit-formula.md) | [PerronFullExplicit.lean](Legendre/PerronFullExplicit.lean) |
| `Legendre.PNT.pnt_hasPrimeIn_classical_interval` / `pnt_prime_gap_classical` | 经典误差尺度的次线性素数区间与自然数间隙接口 | **已证明**；系数 1，c 与阈值为存在性结果 | [PrimeIntervals.lean](Legendre/PrimeIntervals.lean) |
| `Legendre.PNT.rpow_isLittleO_classicalError` / `classicalError_not_isBigO_rpow` | 任意固定 a<1 的 x^a 渐近小于经典误差尺度 | **已证明**；不能由此推断固定幂次指数 | [PrimeIntervals.lean](Legendre/PrimeIntervals.lean) |
| `Legendre.PNT.layer3_pnt_package` | 同一个 c>0 连接 ψ/θ/π 误差、次线性比较与系数 1 的素数区间 | **已证明**；Layer 3 统一入口 | [Layer3.lean](Legendre/Layer3.lean) |
| `Legendre.Density.norm_oscillatoryKernel_le` / `integral_exponentialSum_diagonal` | 有限指数和的精确均方对角项及振荡抵消 | **已证明**；抵消界显式要求频率单射 | [ExponentialKernel.lean](Legendre/ExponentialKernel.lean)、[ExponentialMeanValue.lean](Legendre/ExponentialMeanValue.lean) |
| `Legendre.Density.sum_inv_abs_log_gaps_le` / `meanValueError_le_energy` | 对数频率行和界及 Schur 能量估计 | **已证明**；显式调和数界 | [DirichletSpacing.lean](Legendre/DirichletSpacing.lean)、[ExponentialMeanValue.lean](Legendre/ExponentialMeanValue.lean) |
| `Legendre.Density.abs_integral_dirichletPolynomial_sub_diagonal_le` / `tendsto_dirichletPolynomial_mean_square` | 均方误差 ≤4NH_N E，极限均值为 E | **已证明**；任意复系数，对两个端点统一 | [DirichletMeanValue.lean](Legendre/DirichletMeanValue.lean) |
| `Legendre.Density.dirichlet_large_values_measure_le` | 连续大值集合测度 ≤(区间长度+4N(1+log N))E/V² | **已证明**；A≤B、V>0；离散采样点计数仍开放 | [DirichletLargeValues.lean](Legendre/DirichletLargeValues.lean) |
| `Legendre.Zeta.HasZeroDensityEstimate` / `hasZeroDensityEstimate_of_log_bound` | 对 σ 统一的密度约定及对数损失吸收 | Prop 定义 / **条件传递已证明**；未断言指数取值 | [ZeroDensity.lean](Legendre/ZeroDensity.lean) |
| `Legendre.Zeta.zeroDensityCount_rational_near_one` | T≥3 时 N(1−1/(4000000 log T),T)≤N(3) | **已证明**；固定紧集计数，不是固定带内的密度定理 | [ZeroDensity.lean](Legendre/ZeroDensity.lean) |
| `Legendre.LargeSieve.additive_large_sieve` / `separated_realPhase_large_sieve` | 系数 M+Q² 的有限加法大筛及圆周间隔形式 | **已证明**；覆盖零长度与空范围；已记录来源 | [LargeSieve.lean](Legendre/LargeSieve.lean) |
| `Legendre.Density.dirichlet_large_sample_card_le` / `halasz_montgomery_card_le` | 真正的间隔采样点计数及有限 Gram 大值不等式 | **已证明**；明确保留间隔、阈值或非对角核假设 | [DirichletSampling.lean](Legendre/DirichletSampling.lean)、[HalaszMontgomery.lean](Legendre/HalaszMontgomery.lean) |
| `Legendre.Zeta.exists_density_separated_representatives` | 间隔至少 1 的零点代表集控制完整解析重数计数 | **已证明**；同一绝对对数系数 | [ZetaDensitySelection.lean](Legendre/ZetaDensitySelection.lean) |
| `Legendre.Zeta.zeroDensityCount_le_of_dirichlet_detector` | 显式的零点检测到密度计数传递 | **条件定理已证明**；解析检测器性质仍为假设 | [ZeroDetectionReduction.lean](Legendre/ZeroDetectionReduction.lean) |
| `Legendre.Zeta.zetaXi_square_equation` | Re(s)=1/2 上的精确高斯恒等式 Xi(s)²=I(s)+I(1−s) | **已证明**；含可积性、水平边极限及中心留数 | [XiSquareContour.lean](Legendre/XiSquareContour.lean) |
| `Legendre.Zeta.riemannZeta_fourth_le_smoothed` | 临界线上的逐点四次幂由单个归一化高斯轮廓积分控制 | **已证明**；轮廓均方界及带六次对数损失的四阶矩已证明；尖锐四次对数界仍开放 | [XiSquareContour.lean](Legendre/XiSquareContour.lean) |
| `Legendre.Density.Detector.Smooth.detectorMean_eq_integral` | 紧支撑 Möbius 检测器与初始 Mellin 轮廓积分精确相等，保留绝对范数控制 | **已证明**；后续已补上带主极点项的路径移动 | [Layer4/DetectorIntegral.lean](Legendre/Layer4/DetectorIntegral.lean) |
| `Legendre.Density.Detector.Smooth.detectorMean_at_zero` / `detector_high_zero_dichotomy` | 带精确主极点项的临界线路径移动，以及显式高处范围内的多项式或积分检测分支 | **已证明**；现已用于闭合 Ingham 密度证明 | [Layer4/DetectorShift.lean](Legendre/Layer4/DetectorShift.lean) · [DetectorAlternative.lean](Legendre/Layer4/DetectorAlternative.lean) |
| `Legendre.Density.Oscillation.halasz_complex_large_values_two_term` / `Moment.packed_critical_mass_halasz` | 无条件两项大值计数，以及实际 Möbius／临界质量矩的加强界 | **已证明**；更强的 Huxley 曲线目标仍开放 | [HalaszTwoTermCount.lean](Legendre/Layer4/Exponential/HalaszTwoTermCount.lean)、[HalaszCriticalMass.lean](Legendre/Layer4/HalaszCriticalMass.lean) |
| `Legendre.Density.Oscillation.halasz_block_complex_energy` | 实际对数相位抵消、倒数求和的对数界，以及各样本实部可独立变化的 Halász 能量界 | **已证明**；更强的 Huxley 曲线目标仍开放 | [Exponential/HalaszComplex.lean](Legendre/Layer4/Exponential/HalaszComplex.lean) |
| `Legendre.Zeta.ingham_density_epsilon` / `Literature.layer4_ingham_comparator` | Ingham 1940 曲线密度指数 `3(1−σ)/(2−σ)+ε`，保留所有解析重数 | **已证明**，σ∈[1/2,1] 统一且 T≥2；并非 1937 素数间隙结论 | [Layer4/InghamDensity.lean](Legendre/Layer4/InghamDensity.lean) |
| `Legendre.Density.Moment.weighted_zeta_fourth_moment` / `packed_critical_mass_fourth` / `integral_alternative_count` | 整线带权矩、间隔采样临界线质量的四次幂界，以及积分分支的三次幂计数界 | **已证明**，使用实际积分；现已与多项式分支共同导出 Ingham 密度 | [Layer4/WeightedZetaMoment.lean](Legendre/Layer4/WeightedZetaMoment.lean) · [IntegralAlternative.lean](Legendre/Layer4/IntegralAlternative.lean) |
| `Legendre.Zeta.zeta_fourth_moment_log_six` / `zeta_fourth_moment_epsilon` | `[-T,T]` 上实际临界线四阶矩 `O(T log^6 T)`，并给出 `[0,T]` 上的高度指数 `1+ε` | **已证明**，对所有 `T≥2` 成立；尖锐 `log^4`、更强的 Huxley 曲线及 Guth–Maynard 密度仍开放 | [Layer4/ZetaFourthMoment.lean](Legendre/Layer4/ZetaFourthMoment.lean) |

每一行都直接链接到 GitHub 源码中的精确声明；点击 `Lnn` 锚点即可跳到对应行。

审计通过 `#print axioms` 完成：每个被审计定理只依赖
`propext`、`Classical.choice`、`Quot.sound`。

</details>

## 明确**没有**声称的内容

以下内容只被写成 `Prop` 定义（粗粒度形式与指数规范化形式），供后续工作接入；
它们的证明**没有**在本仓库形式化：

* Hoheisel 1930、Ingham 1937（`5/8` 与 `577/925` 两条路线）、Huxley 1972、
  Heath-Brown–Iwaniec 1979、Iwaniec–Pintz 1984、Mozzochi 1986、
  Baker–Harman 1996、Baker–Harman–Pintz 2001 — 粗粒度 `Prop` 与指数规范化形式
  都已编码（证明仍未形式化）；陈述代码：
  **[Hoheisel L70](Legendre/Conditional.lean#L70)** ·
  **[Ingham 5/8 L74](Legendre/Conditional.lean#L74)** ·
  **[Ingham 577/925 L77](Legendre/Conditional.lean#L77)** ·
  **[Huxley L80](Legendre/Conditional.lean#L80)** ·
  **[Heath-Brown–Iwaniec L83](Legendre/Conditional.lean#L83)** ·
  **[Iwaniec–Pintz L86](Legendre/Conditional.lean#L86)** ·
  **[Mozzochi L89](Legendre/Conditional.lean#L89)** ·
  **[Baker–Harman L92](Legendre/Conditional.lean#L92)** ·
  **[BHP L96](Legendre/Conditional.lean#L96)** ·
  **[Layer5.lean 中的指数规范化形式](Legendre/Layer5.lean)**；
* Dusart 型显式界（`ϑ(x) − x < x/36260`、`x ≥ 3 594 641` 时
  `|ϑ(x) − x| ≤ 0.2x/log²x`、`x ≥ 396 738` 时 `(x, x + x/(25 log²x)]` 中有素数）
  — 需要带无零点区域的显式素数定理，**尚未**声称（第 2–3 层）；
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

| 层级 | 需要形式化的工具 / 理论 | 为什么需要 | 当前状态（mathlib v4.35.0 / 本仓库） |
|---:|---|---|---|
| 0 | 自然数素数、素数间隙、平方区间、实数幂 | 陈述与 `θ < 1/2` 归约 | **本仓库已完成**：**[Basic.lean](Legendre/Basic.lean)** · **[Reduction.lean](Legendre/Reduction.lean)** |
| 1 | Bertrand 公设、Chebyshev 函数 `ψ(x)`、`θ(x)`、初等素数计数界 | 历史起点与定量直觉 | **已完成（Nagura）**：**[ExplicitBounds.lean](Legendre/ExplicitBounds.lean)** 与 **[Nagura.lean](Legendre/Nagura.lean)** 包含 `HasPrimeIn`、`(x,2x]` 素数定理、Chebyshev `θ` 桥、`θ/ψ/π` 显式界、**Nagura 的 `(x, 6x/5]`（`x ≥ 25`）** 以及显式 `ψ` 界；Dusart 型 PNT 强度常数仍未形式化 |
| 2 | Riemann ζ 函数：Euler 乘积、解析延拓、函数方程、无零点区域、辐角原理、对数导数 | 所有零密度与短区间定理的起点 | **文档所列完整范围完成**：ζ 基础、显式 c=1/2000000 无零区域（高度≥3）、局部辐角原理、保留重数的全局 N(T)=O(T log T)、带误差截断 Perron 公式及公理审计 |
| 3 | 素数计数基础：`π(x)`、`ψ(x)`、部分求和、Perron 公式、截断显式公式、带误差项的 PNT | 把 ζ 的信息转成素数计数信息 | **文档所列范围已完成**：半权 Perron 反演及截断误差、部分求和、ψ/θ/π 的经典 PNT 误差项、固定负左边界、精确原点留数及完整轮廓统一余项界的有限零点和式，以及经典误差尺度的次线性素数区间；[完整公式](docs/perron-uniform-explicit-formula.md) |
| 4 | 零密度理论：`N(σ,T)`、Ingham 零密度估计、Huxley 的 `12/5` 估计、大筛法、Dirichlet 多项式均值估计（含 Guth–Maynard 型大值估计） | 为短区间提供密度输入 | **基础已有证明**：统一零密度指数接口、近 1 计数界、由 Hilbert 不等式推出的 Dirichlet 多项式 `O(N)` 均方误差；连续大值测度、有限加法大筛、优化间隔采样、实际两分支零点检测及实部可变样本界**已有证明**；**路线图验收齐备**：Ingham 1940 与全局 Huxley `12/5` 及实际大值输入均已证明；更强曲线 Huxley/Guth–Maynard 与尖锐 `log^4` 仍明确标为开放目标；[范围](docs/layer4-huxley-density.md) |
| 5 | 短区间定理：Ingham 1937、Huxley 1972、Baker–Harman 1996 的加权零密度 + 筛法、Baker–Harman–Pintz 2001 | 给出 `p_{n+1} - p_n ≪ p_n^{θ+ε}` | **陈述级已在本仓库形式化**：**[Layer5.lean](Legendre/Layer5.lean)** 含指数规范化的 `+ε`、常数与阈值约定、区间 ↔ 间隙等价，以及到 **[Conditional.lean L70](Legendre/Conditional.lean#L70)** 中粗粒度 `Prop` 的等价；深层证明 **mathlib 中没有** |
| 6 | 显式计算层：区间算术、可验证素性证书、分段筛检查器、reflection / `native_decide` 风格的验证计算 | 覆盖有限范围 `n ≤ 7.05 × 10¹³`（以及旧纪录 `n ≤ 2 × 10⁹`） | **未形式化**；已发表计算是外部计算 |
| 7 | 几乎素数筛法：筛权重、Chen 的 `P₂` 定理、`P_k` 估计、Buchstab/线性筛 | 形式化几乎素数路线（所有 `n` 的 `P₄`、最终 `P₂`） | mathlib 有 `Nat.IsAtMostAlmostPrime` 与 `Ω`；**没有筛法**；`P₁` 等价性见 **[Conditional.lean L190](Legendre/Conditional.lean#L190)** |

### 依赖顺序与现实里程碑

```
(0) 定义/算术                    [已完成]
        │
(1) Bertrand + Chebyshev         [已完成；Nagura 已完成；Dusart 型仍开放]
        │
(2) ζ 基础                       [第一个真正的大里程碑]
        │
(3) 带误差项的 PNT
        │
(4) 零密度估计
        │
(5) Ingham → Huxley → BHP       [陈述级已完成；证明仍开放]
        │
(6) 显式有限验证                 [独立，可并行]
(7) 几乎素数/筛法路线            [独立，可并行]
```

对本仓库而言，现实顺序是：

1. ✅ **完成第 1 层——已完成，包含 Nagura。** `Legendre/ExplicitBounds.lean`
   证明了区间 API、`(x, 2x]` 素数定理、Chebyshev 桥，以及 `θ/ψ/π` 的显式界。
   `Legendre/Nagura.lean` 现在证明了 **Nagura 定理**（`nagura_hasPrimeIn`：
   对每个 `x ≥ 25`，`(x, 6x/5]` 中有素数）以及显式 `ψ` 界
   `0.916n < ψ(n) < 1.086n`。Dusart 型 PNT 强度常数仍然开放（第 2–3 层）。
2. ✅ **第 5 层陈述级——已完成。** `Legendre/Layer5.lean` 编码了 Hoheisel、
   Ingham（两条路线）、Huxley、Heath-Brown–Iwaniec、Iwaniec–Pintz、Mozzochi、
   Baker–Harman 与 Baker–Harman–Pintz 的精确 `+ε`、“充分大”和常数约定，证明
   区间形式等价于间隙形式，并把每篇论文的精确陈述连接到其粗粒度 `Prop`。
   解析证明仍然开放。
3. ✅ **第 3 层已完成，含完整轮廓统一估计。** 经典 PNT 误差、部分求和、
   Perron 反演、含 `−log(2π)` 与完整轮廓统一余项界的有限零点和式，
   以及经典误差尺度的次线性素数区间均已证明；见[验收证据](docs/layer3-completion.md)。
4. **第 4–5 层**：先 Ingham，再 Huxley，最后 BHP 的筛法精化。Ingham 未完成
   前不要声称 BHP 已完成。
5. **第 6 层**：可验证区间证书检查器可以并行推进，是覆盖有限范围最现实的
   路径。
6. **第 7 层**：`P₁ ↔ 勒让德猜想` 已经证明；下一个诚实目标是形式化筛法陈述，
   而不是伪造 `P₂` 证明。

每一层的验收标准见 [docs/formalization-roadmap.md](docs/formalization-roadmap.md)。

## 构建

```bash
# Lean 4.35.0 + mathlib v4.35.0
lake exe cache get
lake build
```

本仓库固定使用 **Lean 4.35.0** 与 **mathlib v4.35.0**（见 `lean-toolchain` 与
`lakefile.toml`）。Lean 源码已于 2026-10-18 重新校对并适配到该 mathlib 版本；
公开定理的陈述保持不变。

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
  ExplicitBounds.lean Layer 1：区间 API、(x,2x]、Chebyshev θ/ψ/π 界
  Layer5.lean        Layer 5 统一导入入口
  Layer5/           短区间陈述及后续解析证明
  Layer6/           预留：有限验证与证书
  Layer7/           预留：几乎素数与筛法证明
  Nagura.lean        Layer 1：Nagura 定理，(x, 6x/5]，x >= 25
  Nagura/            Nagura 证明：有限素数链 + 显式 psi 界
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

## 提交归属

仓库历史中有少量提交由自动化编码代理以通用 git 身份 `Legendre Formalization
<noreply@users.noreply.github.com>` 提交（例如 `8029c02`、`82bdd2a`、`a9a932b`、
`444b384`）。GitHub 会把这类提交关联到无关的 `noreply` 账号；它们不是第三方贡献。
相应改动已在本地通过 `lake build` 与 `python3 scripts/audit.py` 验证，并由维护者
（`lim-tan90`）合并。仓库的 git 身份现已更正为
`lim-tan90 <lim-tan90@users.noreply.github.com>`。

## 复用的形式化成果

<details open>
<summary><strong>来源与移植详情</strong></summary>

本项目优先**借鉴、移植已有的已验证形式化成果**，而不是从零重写。所有移植或改编
的开发都记录在此：上游仓库、固定 commit、许可证，以及在本仓库中的位置。

* **[ShouqiaoW/erdos](https://github.com/ShouqiaoW/erdos)** — MIT 许可，
  commit `d28713ac8245ca86a686b8c67370a8d19d81b242`（2026-08-02）。
  [`Legendre/Nagura/`](Legendre/Nagura/) 与
  [`Legendre/Nagura.lean`](Legendre/Nagura.lean) 改编自该项目的
  `Erdos390/WholePaper/Nagura*.lean`（Nagura 1952 定理的形式化）。改动包括：
  重命名模块/命名空间、删除依赖 PNT 的辅助结果、合并为三个模块、适配
  mathlib v4.33.1（仓库于 2026 年 10 月升级到 v4.35.0 时重新校对）；数学证明
  本身来自上游。原始 MIT 许可证保留在
  [`Legendre/Nagura/LICENSE`](Legendre/Nagura/LICENSE)。
* **[AlexKontorovich/PrimeNumberTheoremAnd（PNT+）](https://github.com/AlexKontorovich/PrimeNumberTheoremAnd)** —
  Apache-2.0，固定提交 `127b50e33f6033e2147921167a117af96d9ba4ea`。
  [`Legendre/PNT/`](Legendre/PNT/) 中的 14 个模块移植了 `StrongPNT` 的完整证明依赖切片，
  保留来源和贡献者信息，适配导入、模块可见性、蓝图元数据和六处非零性反证表达。
  原许可证保存在 [`licenses/PNTplus-Apache-2.0.txt`](licenses/PNTplus-Apache-2.0.txt)。
  ψ→θ→π 的误差传递证明位于 [`PrimeNumberTheorem.lean`](Legendre/PrimeNumberTheorem.lean)。
  Layer 4 另选取同一固定提交中 Robby Sneiderman 的
  `Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean`，保留正实部半平面的
  digamma 级数及尾和辅助证明，移至
  [`Legendre/PNT/Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean`](Legendre/PNT/Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean)。
  保留原贡献者说明及同一 Apache-2.0 许可证。
  详见[来源与限制](docs/pnt-provenance.md)。
* **[openai/math](https://github.com/openai/math)** — Apache-2.0，
  固定来源提交 `4eaee87548250b2682affda7d05d947c05554bae`。
  [`Legendre/LargeSieve/`](Legendre/LargeSieve/) 中选取的 23 个模块包含：22 个移植自
  `lean/OAI/NumberTheory/Ostmann/`：19 个 `Preliminaries` 模块、
  `Quadratic/KernelEigenvalueBound.lean`、`Characters/SkewKernelSquare.lean`
  及 `ZeroDensity/SeparatedSelection.lean`；
  另外一个间隔采样模块来自
  `lean/OAI/NumberTheory/Jacobsthal/Estimates/SeparatedSampling.lean`。
  范围为有限加法大筛的证明依赖链，包含圆周间隔、有限余割 Hilbert 不等式、
  Hermitian 矩阵及对偶性论证，以及既约分数的特化。
  本项目调整导入、命名空间及 Lean/mathlib v4.35.0 兼容性；每个移植文件均保留来源说明。
  原始许可证保存在 [`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt)。
  [`GramLargeValues.lean`](Legendre/GramLargeValues.lean) 还推广了同一来源的
  `Preliminaries/SymmetricQuadraticBound.lean` 中的行和估计论证；
  [`WeightedSeparation.lean`](Legendre/WeightedSeparation.lean) 将同一来源
  `ZeroDensity/SeparatedSelection.lean` 的覆盖论证推广到自然数权重。
  [`ReciprocalHilbert.lean`](Legendre/ReciprocalHilbert.lean) 还将
  `Preliminaries/CosecantHilbertBound.lean` 和 `CircleSeparatedPoints.lean`
  中的有限核与谱论证推广到实直线间隔频率。
  [`SeparatedMeanValue.lean`](Legendre/SeparatedMeanValue.lean) 将
  `SievePhaseGram.lean` 的相位扭转论证用于上述倒数核。
  零点检测器的系数部分另将同一固定提交中的
  `lean/OAI/NumberTheory/Ostmann/ZeroDensity/Mollifier.lean` 改编到
  [`ZeroDetector/Mollifier.lean`](Legendre/ZeroDetector/Mollifier.lean)，并将
  `FiniteDetector.lean` 改编到
  [`ZeroDetector/FiniteMollifier.lean`](Legendre/ZeroDetector/FiniteMollifier.lean)。
  沿用上述已保留的 Apache-2.0 许可证；后者移除特征扭转，证明无扭转的有限恒等式。
  [`ZeroDetector/ActualZetaDetector.lean`](Legendre/ZeroDetector/ActualZetaDetector.lean)
  还改编 `DetectorLength.lean` 的长度选择及 `ActualDetector.lean` 的小乘积组织，
  显式保留 ζ 的额外极点分支。
  [`ZeroDetector/BetaVariation.lean`](Legendre/ZeroDetector/BetaVariation.lean)
  改编同名文件；[`ComplexDirichlet.lean`](Legendre/ComplexDirichlet.lean)
  改编 `BetaDerivative.lean` 中不依赖特征的求导论证。
  系数能量部分还将上游 `lean/OAI/NumberTheory/Ostmann/` 下的
  `Arithmetic/FrequencyLCM.lean`、`Arithmetic/DivisorSquareMean.lean` 和
  `ZeroDensity/CoefficientEnergy.lean` 分别改编到
  [`ZeroDetector/FrequencyLCM.lean`](Legendre/ZeroDetector/FrequencyLCM.lean)、
  [`ZeroDetector/DivisorSquareMean.lean`](Legendre/ZeroDetector/DivisorSquareMean.lean) 和
  [`ZeroDetector/CoefficientEnergy.lean`](Legendre/ZeroDetector/CoefficientEnergy.lean)。
  [`Legendre/GammaBounds/`](Legendre/GammaBounds/) 中的 Gamma 商估计还改编
  `ZeroDensity/LogNormDerivative.lean`、`DigammaTailEstimate.lean`、
  `SharpDigammaStrip.lean`、`GammaNormDerivative.lean`、`SharpGammaHorizontal.lean`、
  `SharpGammaVertical.lean`、`SharpGammaRealShift.lean` 和 `GammaStripBound.lean`。
  [`GammaBounds/GaussianWeight.lean`](Legendre/GammaBounds/GaussianWeight.lean)
  特化 `ZeroDensity/CharacterGammaShift.lean` 的标量高斯权重论证；
  [`XiSquareKernel.lean`](Legendre/XiSquareKernel.lean) 将
  `DensityCompletedSquare.lean` 和 `DensitySquareGaussian.lean` 的高斯平方与归一化
  组织推广到本地证明的整函数 xi。
  [`XiGaussianEnvelope.lean`](Legendre/XiGaussianEnvelope.lean) 将
  `DensityGaussianEnvelope.lean` 推广到消去两个完成极点后所需的六次多项式包络。
  digamma 尾和仅导入所选 PNT+ 级数证明，省去与此处无关的特征及无零区域依赖链。
  来源提交和保留许可证均同上。
  此前已选取的大筛证明链已编译，并纳入整库公理审计；
  [逐文件来源、适配与验证记录](docs/openai-math-provenance.md)。
  紧支撑检测器现已证明 Ingham 1940 及全局 Huxley 12/5 密度；
  更强的 Huxley 曲线目标仍开放。
  [`XiSquareContour.lean`](Legendre/XiSquareContour.lean) 还改编了同一固定提交下
  `ZeroDensity/DensitySquareContour.lean`、`DensitySquareEquation.lean` 与
  `DensitySquareConjugation.lean` 的轮廓、反射及共轭证明组织，适配整函数 xi 分子，
  复用已注明来源的 PNT+ 矩形留数接口；沿用上述 Apache-2.0 许可。

四阶矩与紧支撑检测器证明另改编 **[openai/math](https://github.com/openai/math)** 固定提交
`4eaee87548250b2682affda7d05d947c05554bae` 下
`lean/OAI/NumberTheory/Ostmann/ZeroDensity/` 的以下代码。
许可证为 **Apache-2.0**，保留于
[`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt)。
以下本地文件均位于 `Legendre/Layer4/`，保留逐文件来源。四阶矩部分去除特征族并接入本地 xi 核，
使用原始纵坐标与更宽的高斯权重；紧支撑检测器将初始轮廓特化到 ζ，路径移动已保留精确主极点项。
没有新增移植 PNT+ 代码。

| Upstream / 上游 | Destination / 本地文件 |
|---|---|
| `DensityDetectorDyadicCover.lean` | [DetectorDyadicCover.lean](Legendre/Layer4/DetectorDyadicCover.lean) |
| `DensityDetectorPolynomial.lean`, `DensityDetectorBlocks.lean` | [DetectorPolynomial.lean](Legendre/Layer4/DetectorPolynomial.lean) |
| `DensityFiniteBlockSquare.lean` | [FiniteBlockSquare.lean](Legendre/Layer4/FiniteBlockSquare.lean) |
| `DensityPolynomialAlternative.lean` | [PolynomialAlternative.lean](Legendre/Layer4/PolynomialAlternative.lean) |
| `DensityBalanceParameters.lean`, `DensityPolynomialBalance.lean` | [DensityBalance.lean](Legendre/Layer4/DensityBalance.lean) |
| `DensityPolynomialBalanced.lean`, `DensityIntegralBalanced.lean` | [BalancedAlternatives.lean](Legendre/Layer4/BalancedAlternatives.lean) |
| `DensitySeparatedCount.lean` | [SeparatedShellDensity.lean](Legendre/Layer4/SeparatedShellDensity.lean)；其中有限分支合并结构在本仓库内复用于 [HuxleyShellDensity.lean](Legendre/Layer4/HuxleyShellDensity.lean) 及 [HuxleyCurvedShell.lean](Legendre/Layer4/HuxleyCurvedShell.lean)，沿用同一固定来源与许可证 |
| `DensityBlockCauchy.lean` | [BlockCauchy.lean](Legendre/Layer4/BlockCauchy.lean) |
| `DensityBlockWeights.lean` | [BlockWeights.lean](Legendre/Layer4/BlockWeights.lean) |
| `DensityCubicIntegrability.lean` | [CubicIntegrability.lean](Legendre/Layer4/CubicIntegrability.lean) |
| `DensityDetectorDichotomy.lean` | [DetectorAlternative.lean](Legendre/Layer4/DetectorAlternative.lean) |
| `DensityDetectorAnalytic.lean` | [DetectorAnalytic.lean](Legendre/Layer4/DetectorAnalytic.lean) |
| `DensityDetectorCoefficients.lean` | [DetectorCoefficients.lean](Legendre/Layer4/DetectorCoefficients.lean) |
| `DensityCriticalDetector.lean` | [DetectorCriticalMass.lean](Legendre/Layer4/DetectorCriticalMass.lean) |
| `DensityMollifierBound.lean` | [DetectorGrowth.lean](Legendre/Layer4/DetectorGrowth.lean) |
| `DensityDetectorHorizontal.lean` | [DetectorHorizontal.lean](Legendre/Layer4/DetectorHorizontal.lean) |
| `DensityDetectorIntegral.lean` | [DetectorIntegral.lean](Legendre/Layer4/DetectorIntegral.lean) |
| `DensityDetectorKernel.lean` | [DetectorKernel.lean](Legendre/Layer4/DetectorKernel.lean) |
| `DensityDetectorKernelLeft.lean` | [DetectorKernelLeft.lean](Legendre/Layer4/DetectorKernelLeft.lean) |
| `DensityMollifierProduct.lean` | [DetectorProduct.lean](Legendre/Layer4/DetectorProduct.lean) |
| `DensityDetectorSeries.lean` | [DetectorSeries.lean](Legendre/Layer4/DetectorSeries.lean) |
| `DensityDetectorShift.lean` | [DetectorShift.lean](Legendre/Layer4/DetectorShift.lean) |
| `DensityDetectorVertical.lean`, `DensityDetectorShift.lean` | [DetectorVertical.lean](Legendre/Layer4/DetectorVertical.lean) |
| `DensityDetectorWeight.lean` | [DetectorWeight.lean](Legendre/Layer4/DetectorWeight.lean) |
| `DensityHarmonicDivisors.lean`, `DensityShiftedDivisorEnergy.lean` | [DivisorEnergy.lean](Legendre/Layer4/DivisorEnergy.lean) |
| `DensityDyadicArithmetic.lean` | [DyadicArithmetic.lean](Legendre/Layer4/DyadicArithmetic.lean) |
| `DensityDyadicShells.lean` | [DyadicHeightShells.lean](Legendre/Layer4/DyadicHeightShells.lean) |
| `DensityDyadicPartition.lean` | [DyadicPartition.lean](Legendre/Layer4/DyadicPartition.lean) |
| `GaussianContourShift.lean` | [GaussianContourShift.lean](Legendre/Layer4/GaussianContourShift.lean) |
| `DensityGaussianFubini.lean` | [GaussianMean.lean](Legendre/Layer4/GaussianMean.lean) |
| `DensityHeightWeight.lean` | [HeightWeight.lean](Legendre/Layer4/HeightWeight.lean) |
| `DensityIntegralAlternative.lean` | [IntegralAlternative.lean](Legendre/Layer4/IntegralAlternative.lean) |
| `DensityKernelHeightPacking.lean` | [KernelHeightPacking.lean](Legendre/Layer4/KernelHeightPacking.lean) |
| `DensityKernelPacking.lean` | [KernelPacking.lean](Legendre/Layer4/KernelPacking.lean) |
| `DensityMomentCutoff.lean` | [MomentCutoff.lean](Legendre/Layer4/MomentCutoff.lean) |
| `DensityMomentDyadic.lean` | [MomentDyadic.lean](Legendre/Layer4/MomentDyadic.lean) |
| `DensityGaussianCauchy.lean` | [MomentGaussian.lean](Legendre/Layer4/MomentGaussian.lean) |
| `DensityCriticalMass.lean`, `DensityPackedProduct.lean` | [PackedCriticalMass.lean](Legendre/Layer4/PackedCriticalMass.lean) |
| `DensityPackedMoment.lean` | [PackedMoment.lean](Legendre/Layer4/PackedMoment.lean) |
| `DensityPackedMoment.lean`, `DensityPackedCharacterMoments.lean` | [PackedZetaMoment.lean](Legendre/Layer4/PackedZetaMoment.lean) |
| `DensityFatou.lean` | [PositiveLimit.lean](Legendre/Layer4/PositiveLimit.lean) |
| `DensityWeightedProductCauchy.lean` | [ProductCauchy.lean](Legendre/Layer4/ProductCauchy.lean) |
| `DensityWeightedMoment.lean` | [WeightedHeightMoment.lean](Legendre/Layer4/WeightedHeightMoment.lean) |
| `DensityWeightedCauchy.lean`, `DensityGaussianCauchy.lean` | [WeightedIntegral.lean](Legendre/Layer4/WeightedIntegral.lean) |
| `DensityWeightedFourth.lean`, `DensityWeightedMollifier.lean` | [WeightedZetaMoment.lean](Legendre/Layer4/WeightedZetaMoment.lean) |
| `DensityDyadicMean.lean` | [XiDyadicMean.lean](Legendre/Layer4/XiDyadicMean.lean) |
| `DensityFiniteContinuity.lean` | [XiFiniteContinuity.lean](Legendre/Layer4/XiFiniteContinuity.lean) |
| `DensityFiniteSquareMean.lean` | [XiFiniteMean.lean](Legendre/Layer4/XiFiniteMean.lean) |
| `DensityFiniteContourShift.lean`, `DensityFiniteSeriesBridge.lean`, `DensityFiniteSquareEnergy.lean` | [XiFiniteMellin.lean](Legendre/Layer4/XiFiniteMellin.lean) |
| `DensityHeadCutoff.lean` | [XiHeadMean.lean](Legendre/Layer4/XiHeadMean.lean) |
| `DensitySmoothedKernel.lean`, `DensityKernelStrip.lean`, `DensityKernelLineBound.lean`, `DensityKernelCost.lean` | [XiMellinKernel.lean](Legendre/Layer4/XiMellinKernel.lean) |
| `DensityPartialMean.lean` | [XiPartialMean.lean](Legendre/Layer4/XiPartialMean.lean) |
| `DensitySmoothedMean.lean` | [XiSmoothedMean.lean](Legendre/Layer4/XiSmoothedMean.lean) |
| `DensitySquareLimit.lean` | [XiSquareLimit.lean](Legendre/Layer4/XiSquareLimit.lean) |
| `DensitySquareTerms.lean`, `DensitySquareSeriesIntegral.lean` | [XiSquareSeries.lean](Legendre/Layer4/XiSquareSeries.lean) |
| `DensityTailAssembly.lean` | [XiTailAssembly.lean](Legendre/Layer4/XiTailAssembly.lean) |
| `DensityTailBlock.lean` | [XiTailMean.lean](Legendre/Layer4/XiTailMean.lean) |
| `DensityFourthMoment.lean` | [ZetaFourthMoment.lean](Legendre/Layer4/ZetaFourthMoment.lean) |
| `DensitySquareSeries.lean` | [ZetaSquareSeries.lean](Legendre/Layer4/ZetaSquareSeries.lean) |

* **[mathlib4](https://github.com/leanprover-community/mathlib4)** —
  Apache-2.0，作为基础库使用。`Legendre.bertrand` 是对 mathlib
  `Nat.exists_prime_lt_and_le_two_mul` 的轻量复用；本仓库没有整段复制
  mathlib 的证明。



指数和导数检验另改编自 **openai/math**，固定提交
`4eaee87548250b2682affda7d05d947c05554bae`，源目录
`lean/OAI/NumberTheory/EgyptianFractions/`，许可 **Apache-2.0**。
许可证保留于 [`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt)。
仅导入所需的 mathlib 模块，适配命名空间与模块可见性，保留相位求和论证。

| Upstream / 上游 | Destination / 本地文件 |
|---|---|
| `DiscreteFirstDerivative.lean` | [DiscreteFirstDerivative.lean](Legendre/Layer4/Exponential/DiscreteFirstDerivative.lean) |
| `DiscreteSecondDerivative.lean` | [DiscreteSecondDerivative.lean](Legendre/Layer4/Exponential/DiscreteSecondDerivative.lean) |
| `MonotoneBlocks.lean` | [MonotoneBlocks.lean](Legendre/Layer4/Exponential/MonotoneBlocks.lean) |
| `PhaseExtension.lean` | [PhaseExtension.lean](Legendre/Layer4/Exponential/PhaseExtension.lean) |
| `SecondDerivativeBudget.lean` | [SecondDerivativeBudget.lean](Legendre/Layer4/Exponential/SecondDerivativeBudget.lean) |
| `SecondDerivativeTest.lean` | [SecondDerivativeTest.lean](Legendre/Layer4/Exponential/SecondDerivativeTest.lean) |
| `SecondDifference.lean` | [SecondDifference.lean](Legendre/Layer4/Exponential/SecondDifference.lean) |
| `SeparatedIntervalCount.lean` | [SeparatedIntervalCount.lean](Legendre/Layer4/Exponential/SeparatedIntervalCount.lean) |

区间细分、吸收尺度优化、两项大值计数、有限二进分层求矩，以及实际
Möbius／临界质量矩的加强界，均为本仓库的本地推导；本步骤未复制新的上游代码。

### 对数相位所需的有限差分

Adapted from [openai/math](https://github.com/openai/math) at pinned commit
`4eaee87548250b2682affda7d05d947c05554bae`, Apache-2.0, source directory
`lean/OAI/NumberTheory/EgyptianFractions/`. The original proofs of finite
correlation expansion and interval van der Corput are retained; imports,
namespace and module visibility are adapted. Retained license:
[`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt).

| Upstream / 上游 | Destination / 本地文件 |
|---|---|
| [`FourierSecondMoment.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/EgyptianFractions/FourierSecondMoment.lean) | [FourierSecondMoment.lean](Legendre/Layer4/Exponential/FourierSecondMoment.lean) |
| [`VanDerCorput.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/EgyptianFractions/VanDerCorput.lean) | [VanDerCorput.lean](Legendre/Layer4/Exponential/VanDerCorput.lean) |

Natural-index overlap identities and logarithmic shifted-phase estimates are local deductions.

### 多项式幂所需的除数函数增长界

系数幂的工作另改编自 [openai/math](https://github.com/openai/math)，固定提交
`4eaee87548250b2682affda7d05d947c05554bae`，许可 Apache-2.0。源目录为
`lean/OAI/NumberTheory/Ostmann/Arithmetic/`；仅适配导入、命名空间与模块可见性。
许可证保留于
[`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt)。

| Upstream / 上游 | Destination / 本地文件 |
|---|---|
| [`DivisorGrowthLocal.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Arithmetic/DivisorGrowthLocal.lean) | [DivisorGrowthLocal.lean](Legendre/Layer4/Arithmetic/DivisorGrowthLocal.lean) |
| [`DivisorGrowth.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Arithmetic/DivisorGrowth.lean) | [DivisorGrowth.lean](Legendre/Layer4/Arithmetic/DivisorGrowth.lean) |

</details>

## 版权

仓库不包含 PDF、扫描件或受版权保护论文的长篇逐字摘录。
`docs/literature.md` 只包含书目信息、简短的数学陈述和出版社/arXiv 链接。
Lean 代码以 Apache-2.0 发布；例外是 `Legendre/Nagura/` 下的文件，它们改编自
MIT 许可项目 <https://github.com/ShouqiaoW/erdos>（commit
`d28713ac8245ca86a686b8c67370a8d19d81b242`），原始 MIT 许可证保留在
[`Legendre/Nagura/LICENSE`](Legendre/Nagura/LICENSE)。

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
* J. Nagura, *On the interval containing at least one prime number*,
  Proc. Japan Acad. **28** (1952), 177–181,
  [DOI](https://doi.org/10.3792/pja/1195570997).
* J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's
  conjecture up to 7·10¹³*, Res. Number Theory **11** (2025),
  [DOI](https://doi.org/10.1007/s40993-024-00589-4).
