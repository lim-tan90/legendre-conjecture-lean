# Legendre's Conjecture — Exponent Progress, Formally Audited

[中文说明](#中文说明) · [English summary](#english-summary) · [Build](#build) · [PR workflow](docs/PR_WORKFLOW.md)

> **Status (2026-10): Legendre's conjecture is still open.**
> The best unconditional prime-gap exponent is still `θ = 0.525`
> (Baker–Harman–Pintz 2001), which is **above** `1/2`; it does not prove
> Legendre's conjecture. This repository does **not** claim a proof of the
> conjecture and does **not** claim to have formalized the deep analytic papers.
> It formalizes the definitions, the elementary reductions, and the exact
> conditional bridge from a future `θ < 1/2` result to Legendre's conjecture.

## What is actually verified in Lean

`lake build` proves the following, with no `sorry`, no `admit`, no user
`axiom`/`constant`/`opaque`, and no `False.elim`/`absurd` shortcuts:

| Lean declaration | Mathematical content | Status |
|---|---|---|
| `Legendre.LegendreAt` / `Legendre.Conjecture` | square-interval form of the conjecture | definition |
| `Legendre.legendreAt_iff_gapFormAt` | equivalence of the two standard formulations | **proved** |
| `Legendre.sq_interval_length` | `(n+1)^2 - n^2 = 2n+1` | **proved** |
| `Legendre.legendre_of_gap_lt_two_sqrt` | if every prime gap is `< 2√p`, then Legendre holds | **proved** |
| `Legendre.eventually_const_mul_rpow_lt` | `θ < 1/2 ⇒ C n^{2θ} < 2n` eventually | **proved** |
| `Legendre.eventually_legendre_of_gap_exponent_lt_half` | gap exponent `θ < 1/2` ⇒ Legendre eventually | **proved** |
| `Legendre.legendre_eventually_of_shortIntervalExponent_lt_half` | same, packaged as a literature-style exponent result | **proved** |
| `Legendre.legendre_eventually_of_shortIntervalExponentLimit_lt_half` | same for the `+ε` form used in papers | **proved** |
| `Legendre.bertrand` / `bertrand_gap_le` | Bertrand's postulate, re-exported from mathlib | mathlib proof |
| `Legendre.conjecture_of_almostPrimeSquareAtMost_one` | the `P₁` almost-prime square statement *is* Legendre | **proved** |
| `Legendre.almostPrimeSquareAtMost_one_iff` | `P₁` square statement ↔ Legendre | **proved** |

The audit works by `#print axioms`: every audited theorem depends only on
`propext`, `Classical.choice`, `Quot.sound`.

## What is deliberately **not** claimed

The following are encoded as precise `Prop`-valued definitions so that later
work can plug them in, but their proofs are **not** formalized here:

* Hoheisel 1930, Ingham 1937 (both `5/8` and `577/925` routes), Huxley 1972,
  Heath-Brown–Iwaniec 1979, Iwaniec–Pintz 1984, Mozzochi 1986,
  Baker–Harman 1996, Baker–Harman–Pintz 2001;
* the Riemann-Hypothesis gap bound and Cramér's conjecture;
* the explicit verification of Legendre up to `n ≤ 7.05 × 10¹³`;
* the almost-prime theorems of Chen (1975) and Dudek–Johnston (2026).

Formalizing these would require a formalized zero-density theory, the
Riemann zeta function, sieve theory, and large computations. That is a
multi-year project, not something this repository pretends to have done.
See [docs/literature.md](docs/literature.md) and
[docs/proof-map.md](docs/proof-map.md) for the exact status of every step.

## Why `θ = 0.525` does not suffice

If the gap after a prime `p ≤ n²` is at most `C p^θ`, then the next prime is
below `n² + C n^{2θ}`. To land below `(n+1)² = n² + 2n + 1` one needs
`2θ < 1`, i.e. `θ < 1/2`. For `θ = 0.525` the allowed gap is `n^{1.05}`, which
is much larger than the square interval length `2n`; a gap can jump over the
whole interval. This is formalized in
`Legendre/Reduction.lean` and explained in [docs/literature.md](docs/literature.md).

## Build

```bash
# Lean 4.33.1 + mathlib v4.33.1
lake exe cache get
lake build
```

Then run the audit:

```bash
python3 scripts/audit.py
```

On Windows:

```powershell
pwsh -File scripts/verify.ps1
```

The audit checks:

1. no `sorry` / `admit` / `axiom` / `constant` / `opaque` / `unsafe` in the
   project sources;
2. no `False.elim` / `absurd` / `nomatch` exploration shortcuts;
3. every `#print axioms` line lists only the three standard axioms;
4. no PDF files are present in the repository.

## Repository layout

```
Legendre/
  Basic.lean         definitions, equivalence, elementary facts
  Reduction.lean     square-gap criterion, θ < 1/2 reduction
  Conditional.lean   literature exponents as Props, conditional theorems, P_k
  Bertrand.lean      Bertrand's postulate re-exported and compared
  Audit.lean         #print axioms audit
docs/
  literature.md      primary-source timeline with evidence levels
  proof-map.md       literature step ↔ Lean declaration ↔ formalization status
  PR_WORKFLOW.md     two-branch PR and verification workflow
scripts/
  audit.py           no-sorry/no-axiom/no-explosion audit
  verify.ps1         Windows wrapper
.github/workflows/
  verify.yml         CI for pull requests into review/master
```

## Branches and pull requests

* `master` — verified, stable.
* `review` — staging branch. **All pull requests target `review`.**

When a pull request is received, the maintainer merges it into `review` only
after an explicit instruction; CI then runs the full Lean build and the
axiom/explosion audit. If it passes, `review` is merged into `master`. If it
fails, it stays on `review` for fixes. See
[docs/PR_WORKFLOW.md](docs/PR_WORKFLOW.md).

## Copyright

No PDFs, no scans, and no verbatim long excerpts of copyrighted papers are
uploaded. `docs/literature.md` contains only bibliographic data, short
mathematical statements, and links to the publishers/arXiv. The Lean code is
released under Apache-2.0.

## 中文说明

本仓库的目标是把勒让德猜想（Legendre's conjecture）的“指数推进”路线整理成
**可编译、可审计** 的 Lean 4 项目，并诚实标出哪些部分真的形式化了、哪些没有。

* 已经用 Lean 证明的：定义、平方区间与素数间隙的等价性、`θ < 1/2 ⇒ 大 n 的
  勒让德猜想`、`最大间隙 < 2√p ⇒ 勒让德猜想`、Bertrand  postulate 的复用、
  以及几乎素数 `P₁` 与勒让德猜想的等价性。
* **没有** 用 Lean 证明的：Hoheisel、Ingham、Huxley、Baker–Harman、
  Baker–Harman–Pintz 等深层解析数论定理。它们只被写成精确的 `Prop`，作为
  条件化推论的输入；仓库里没有 `axiom`，也没有 `sorry` 来冒充证明。
* 截至 2026 年 10 月，勒让德猜想仍未解决；当前最好的无条件指数是
  `0.525 > 1/2`，因此现有指数结果不能推出它。

如果将来有人给出 `θ < 1/2` 的严格结果，只需把对应的 `Prop` 实例化，
`legendre_eventually_of_shortIntervalExponentLimit_lt_half` 就会给出大 `n`
的勒让德猜想；再配合有限验证即可覆盖所有 `n`。

## References

The full bibliography, with DOI/arXiv links and evidence levels, is in
[docs/literature.md](docs/literature.md). Key entries:

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
