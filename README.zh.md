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
<summary><strong>Layer 2 验收完成 — 进度（2026-10-31）</strong></summary>

**Layer 2 四项验收已完成（2026-10-31）**：
已验证源码提交：[`f83e5cb32a60`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/f83e5cb32a60112cfc4b41afd971dbadec1795e4)。
本地完整 `lake build`（3994 项构建任务）及全部 310 项公理审计通过。
[`ZetaZeroFree.lean`](Legendre/ZetaZeroFree.lean) 已证明有效无零区域：
**`|Im(s)|≥3` 且 `Re(s)>1−1/(2000000·log|Im(s)|)` 时 `ζ(s)≠0`**。
宽度系数 `c=1/2000000` 和高度阈值 3 均显式给出。局部零点按重数去除后，
Borel-Carathéodory 与 Cauchy 估计给出对数导数界，再与实轴极点界及 `3–4–1` 正性组合排除零点。
结合按重数计数的 N(T)、N(σ,T) 定义、带误差的截断 Perron 公式和公理审计，
已满足 [路线图中的 Layer 2 四项验收条件](docs/formalization-roadmap.md#layer-2--riemann-zeta-foundations)。
全局零点计数渐近、零密度估计及短区间 PNT 所需误差项仍属后续工作，尚未证明勒让德猜想。

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
高度阈值 3 的定量对数型无零区域；第 2 层验收已完成。全局 `N(T)` 渐近与所需 PNT 误差项仍属后续工作。
固定版本、上游作者及逐项对应见 [出处说明](docs/zeta-provenance.md)。
适配并验证于 Lean 4.35.0 / mathlib v4.35.0；没有引入新的信任公理。

</details>

## 历史进展总览

**目标.** 勒让德猜想（A.-M. Legendre, *Essai sur la théorie des nombres*,
第 2 版, Courcier, Paris, 1808）：`θ = 1/2`（或 `θ = 1/2` 且常数 `< 2`）。
它仍未解决，也没有形式化证明。

这里的 `θ` 指 `p_{n+1} - p_n ≪ p_n^{θ+ε}` 中的指数；`+ε` 是论文陈述的一部分。
对九项指数结果，“无证明”表示精确陈述已经编码（既作为
`Legendre/Conditional.lean` 中的粗粒度 `Prop`，也作为 `Legendre/Layer5.lean`
中论文原文的精确约定），但**它的证明没有形式化**。RH 与 Cramér 两行只有粗粒度
`Prop`。

| 步骤（按时间） | 原始文献 | 指数 θ | Lean 形式化？ | Lean 代码 |
|---|---|---|---|---|
| **Bertrand 公设** | J. Bertrand, *Mémoire sur le nombre de valeurs que peut prendre une fonction quand on y permute ses variables*, J. École Polytechnique **17** (1845), 123–140；证明：P. L. Chebyshev, *Mémoire sur les nombres premiers*, J. Math. Pures Appl. **17** (1852), 366–390 | **1** | **[✅ 是 — mathlib 证明，已复用](Legendre/Bertrand.lean#L27)** | **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)** |
| **Nagura 1952** | J. Nagura, *On the interval containing at least one prime number*, Proc. Japan Acad. **28** (1952), 177–181, [DOI 10.3792/pja/1195570997](https://doi.org/10.3792/pja/1195570997) | 不适用 — `(x, 6x/5]`，`x ≥ 25` | **[✅ 是 — 本仓库完整证明](Legendre/Nagura.lean#L50)** | **[Nagura.lean L41](Legendre/Nagura.lean#L41)** · **[L50](Legendre/Nagura.lean#L50)** · **[PsiBounds.lean L1671](Legendre/Nagura/PsiBounds.lean#L1671)** |
| Hoheisel 1930 | G. Hoheisel, *Primzahlprobleme in der Analysis*, Sitzungsber. Preuss. Akad. Wiss. (1930), 580–588 | 32999/33000 | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L289)** | **[Conditional.lean L70](Legendre/Conditional.lean#L70)** · **[Layer5.lean L289](Legendre/Layer5.lean#L289)** |
| Ingham 1937（Lindelöf 路线） | A. E. Ingham, *On the difference between consecutive primes*, Quart. J. Math. Oxford **8** (1937), 255–266 | 5/8 | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L302)** | **[Conditional.lean L74](Legendre/Conditional.lean#L74)** · **[Layer5.lean L302](Legendre/Layer5.lean#L302)** |
| Ingham 1937（零密度路线） | 同上 | 577/925 + ε | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L315)** | **[Conditional.lean L77](Legendre/Conditional.lean#L77)** · **[Layer5.lean L315](Legendre/Layer5.lean#L315)** |
| Huxley 1972 | M. N. Huxley, *On the difference between consecutive primes*, Invent. Math. **15** (1972), 164–170 | 7/12 + ε | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L328)** | **[Conditional.lean L80](Legendre/Conditional.lean#L80)** · **[Layer5.lean L328](Legendre/Layer5.lean#L328)** |
| Heath-Brown–Iwaniec 1979 | D. R. Heath-Brown, H. Iwaniec, *On the difference between consecutive primes*, Invent. Math. **55** (1979), 49–69 | 13/23 + ε | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L340)** | **[Conditional.lean L83](Legendre/Conditional.lean#L83)** · **[Layer5.lean L340](Legendre/Layer5.lean#L340)** |
| Iwaniec–Pintz 1984 | H. Iwaniec, J. Pintz, *Primes in short intervals*, Monatsh. Math. **98** (1984), 115–143 | 11/20 − 1/406 + ε | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L353)** | **[Conditional.lean L86](Legendre/Conditional.lean#L86)** · **[Layer5.lean L353](Legendre/Layer5.lean#L353)** |
| Mozzochi 1986 | C. J. Mozzochi, *On the difference between consecutive primes*, J. Number Theory **24** (1986), 181–187 | 11/20 − 1/384 + ε | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L366)** | **[Conditional.lean L89](Legendre/Conditional.lean#L89)** · **[Layer5.lean L366](Legendre/Layer5.lean#L366)** |
| Baker–Harman 1996 | R. C. Baker, G. Harman, *The difference between consecutive primes*, Proc. London Math. Soc. (3) **72** (1996), 261–280 | 0.535 | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L380)** | **[Conditional.lean L92](Legendre/Conditional.lean#L92)** · **[Layer5.lean L380](Legendre/Layer5.lean#L380)** |
| Baker–Harman–Pintz 2001 | R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive primes, II*, Proc. London Math. Soc. (3) **83** (2001), 532–562 | **0.525**（当前纪录） | **[❌ 否 — 无证明，精确陈述 ✅](Legendre/Layer5.lean#L395)** | **[Conditional.lean L96](Legendre/Conditional.lean#L96)** · **[Layer5.lean L395](Legendre/Layer5.lean#L395)** |
| Riemann 假设（条件性） | H. Cramér, *Some theorems concerning prime numbers*, Ark. Mat. Astron. Fys. **15** (1920), no. 5, 1–32 | 1/2 + o(1) | **[❌ 否 — 无证明，粗粒度 `Prop`](Legendre/Conditional.lean#L130)** | **[Conditional.lean L130](Legendre/Conditional.lean#L130)** |
| Cramér 猜想（条件性） | H. Cramér, *On the order of the difference between consecutive primes*, Acta Arith. **2** (1936), 23–46 | 0（猜想） | **[❌ 否 — 无证明，粗粒度 `Prop`](Legendre/Conditional.lean#L137)** | **[Conditional.lean L137](Legendre/Conditional.lean#L137)** |
| 显式验证 `n ≤ 7.05×10¹³` | J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's conjecture up to 7·10¹³*, Res. Number Theory **11** (2025), Paper 4 | 不适用（有限范围） | **[❌ 否 — 未编码](docs/formalization-roadmap.md)** | **[第 6 层路线图](docs/formalization-roadmap.md)** |
| Chen 1975（`P₂`，最终） | Chen Jing-Run, *On the distribution of almost primes in an interval*, Sci. Sinica **18** (1975), 611–627 | 不适用（`P₂`） | **[❌ 否 — 未编码](Legendre/Conditional.lean#L146)** | **[Conditional.lean L146](Legendre/Conditional.lean#L146)** |
| Dudek–Johnston 2026（`P₄`，所有 `n`） | A. W. Dudek, D. R. Johnston, *Almost primes between all squares*, J. Number Theory **278** (2026), 726–745 | 不适用（`P₄`） | **[❌ 否 — 未编码](docs/formalization-roadmap.md)** | **[第 7 层路线图](docs/formalization-roadmap.md)** |

状态单元格本身可点击：**✅** 跳转到证明；**❌“无证明，精确陈述 ✅”** 跳转到
[`Layer5.lean`](Legendre/Layer5.lean) 中按论文原文编码的陈述（不是证明）；
**❌“无证明，粗粒度 `Prop`”** 跳转到粗粒度条件陈述编码；**❌“未编码”** 跳转到
路线图。完整 DOI/arXiv 链接与证据等级见
[docs/literature.md](docs/literature.md)。
这九项指数结果**没有**被证明。它们的粗粒度 `Prop` 在 `Conditional.lean`，
论文原文的 `+ε`/常数/阈值形式在 `Layer5.lean`，两者之间的等价性**已证明**。
把假设的 `θ < 1/2` 结果化为勒让德猜想的归约本身，另行在
**[Reduction.lean L110](Legendre/Reduction.lean#L110)** 中**证明**。

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
| `Legendre.HasPrimeInShortInterval` / `ShortIntervalStatement` / `PrimeGapBound` | 论文精确陈述约定：显式指数、常数与“充分大”阈值 | 定义 | **[Layer5.lean L60](Legendre/Layer5.lean#L60)** · **[L70](Legendre/Layer5.lean#L70)** · **[L79](Legendre/Layer5.lean#L79)** |
| `Legendre.hasPrimeInShortInterval_iff_primeGapBound` | 区间形式 ↔ 间隙形式（相同的 `θ` 与 `C`，需 `θ ≥ 0`、`C ≥ 0`） | **已证明** | **[Layer5.lean L160](Legendre/Layer5.lean#L160)** |
| `Legendre.shortIntervalStatement_iff_exponentLimit` | 论文精确 `+ε` 形式 ↔ 粗粒度条件化接口 | **已证明** | **[Layer5.lean L256](Legendre/Layer5.lean#L256)** |
| `Legendre.legendre_eventually_of_shortIntervalStatement_lt_half` | 论文精确 `θ < 1/2` 陈述 ⇒ 大 `n` 的勒让德猜想 | **已证明** | **[Layer5.lean L264](Legendre/Layer5.lean#L264)** |
| `Legendre.*Paper_iff`（九项结果） | 每项结果的精确陈述 ↔ 其粗粒度 `Prop` | **已证明** | **[Layer5.lean L293](Legendre/Layer5.lean#L293)** |

每一行都直接链接到 GitHub 源码中的精确声明；点击 `Lnn` 锚点即可跳到对应行。

审计通过 `#print axioms` 完成：每个被审计定理只依赖
`propext`、`Classical.choice`、`Quot.sound`。

</details>

## 明确**没有**声称的内容

以下内容只被写成 `Prop` 定义（粗粒度形式与论文精确形式），供后续工作接入；
它们的证明**没有**在本仓库形式化：

* Hoheisel 1930、Ingham 1937（`5/8` 与 `577/925` 两条路线）、Huxley 1972、
  Heath-Brown–Iwaniec 1979、Iwaniec–Pintz 1984、Mozzochi 1986、
  Baker–Harman 1996、Baker–Harman–Pintz 2001 — 粗粒度 `Prop` 与论文精确形式
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
  **[Layer5.lean 中的论文精确形式](Legendre/Layer5.lean)**；
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
| 2 | Riemann ζ 函数：Euler 乘积、解析延拓、函数方程、无零点区域、辐角原理、对数导数 | 所有零密度与短区间定理的起点 | **第 2 层验收完成**：ζ 基础、按重数计数的定义、显式 c=1/2000000 无零区域（高度≥3）、带误差截断 Perron 公式及公理审计；全局计数渐近仍待后续工作 |
| 3 | 素数计数基础：`π(x)`、`ψ(x)`、部分求和、Perron 公式、截断显式公式、带误差项的 PNT | 把 ζ 的信息转成素数计数信息 | 已证明端点半权的 Perron 反演（`PerronInversion.lean`）；已证明固定 x 的 O(1/T) 截断误差；所需误差项的 PNT 仍开放 |
| 4 | 零密度理论：`N(σ,T)`、Ingham 零密度估计、Huxley 的 `12/5` 估计、大筛法、Dirichlet 多项式均值估计（含 Guth–Maynard 型大值估计） | 为短区间提供密度输入 | **mathlib 中没有** |
| 5 | 短区间定理：Ingham 1937、Huxley 1972、Baker–Harman 1996 的加权零密度 + 筛法、Baker–Harman–Pintz 2001 | 给出 `p_{n+1} - p_n ≪ p_n^{θ+ε}` | **陈述级已在本仓库形式化**：**[Layer5.lean](Legendre/Layer5.lean)** 含论文精确的 `+ε`、常数与阈值约定、区间 ↔ 间隙等价，以及到 **[Conditional.lean L70](Legendre/Conditional.lean#L70)** 中粗粒度 `Prop` 的等价；深层证明 **mathlib 中没有** |
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
  Layer5.lean        Layer 5：论文精确的短区间陈述与桥接
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
* **[mathlib4](https://github.com/leanprover-community/mathlib4)** —
  Apache-2.0，作为基础库使用。`Legendre.bertrand` 是对 mathlib
  `Nat.exists_prime_lt_and_le_two_mul` 的轻量复用；本仓库没有整段复制
  mathlib 的证明。

目前没有收录其他第三方形式化代码。

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
