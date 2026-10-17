# Legendre's Conjecture — Exponent Progress, Formally Audited

**English** · [中文](README.zh.md)

[![verify](https://github.com/lim-tan90/legendre-conjecture-lean/actions/workflows/verify.yml/badge.svg?branch=master)](https://github.com/lim-tan90/legendre-conjecture-lean/actions/workflows/verify.yml)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](LICENSE)

> [!IMPORTANT]
> **Pull requests must target the `review` branch, never `master`.**
>
> 1. Fork the repository and branch from `review`.
> 2. Run `lake build` and `python3 scripts/audit.py` locally.
> 3. Open the PR **against `review`**.
> 4. CI must be green. The maintainer merges `review → master` only after an
>    explicit instruction and a green audit.
>
> Full guide: **[docs/PR_WORKFLOW.md](docs/PR_WORKFLOW.md)** ·
> PR checklist: [`.github/pull_request_template.md`](.github/pull_request_template.md)

> [!NOTE]
> **Status (October 2026): Legendre's conjecture is still open.**
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

See [docs/literature.md](docs/literature.md) and
[docs/proof-map.md](docs/proof-map.md) for the exact status of every step.

## Why `θ = 0.525` does not suffice

If the gap after a prime `p ≤ n²` is at most `C p^θ`, then the next prime is
below `n² + C n^{2θ}`. To land below `(n+1)² = n² + 2n + 1` one needs
`2θ < 1`, i.e. `θ < 1/2`. For `θ = 0.525` the allowed gap is `n^{1.05}`, which
is much larger than the square interval length `2n`; a gap can jump over the
whole interval. This is formalized in
`Legendre/Reduction.lean` and explained in [docs/literature.md](docs/literature.md).

## What a full proof-level formalization would require

The current repository is a **verified reduction layer**, not a formalized
analytic number theory library.  A proof-level formalization of the published
exponent results needs the following tools, roughly in dependency order.
This table is the roadmap, not a claim that the work is done.

| Layer | Tool / theory to formalize | Why it is needed | Current state (mathlib v4.33.1 / this repo) |
|---:|---|---|---|
| 0 | Natural-number primes, prime gaps, square intervals, basic real powers | statements and the `θ < 1/2` reduction | **done here** |
| 1 | Bertrand's postulate, Chebyshev functions `ψ(x)`, `θ(x)`, elementary prime-counting bounds | historical base case and quantitative intuition | Bertrand is in mathlib; `Chebyshev.lean` has `ψ`, `θ` and basic bounds; no full explicit prime-gap development |
| 2 | Riemann zeta: Euler product, analytic continuation, functional equation, zero-free region, argument principle, logarithmic derivative | every zero-density and short-interval theorem starts here | partial zeta API in mathlib; no complete zero-free-region / zero-counting development |
| 3 | Prime-counting foundations: `π(x)`, `ψ(x)`, partial summation, Perron's formula, truncated explicit formula, PNT with error term | turns zeta information into prime-counting information | `PrimeCounting.lean` and `Chebyshev.lean` exist; no Perron formula or PNT with the needed error term |
| 4 | Zero-density theory: `N(σ,T)`, Ingham's zero-density estimate, Huxley's `12/5` estimate, large sieve, mean-value estimates for Dirichlet polynomials (including Guth–Maynard-type large-value estimates) | supplies the density input for short intervals | **not in mathlib** |
| 5 | Short-interval theorems: Ingham 1937, Huxley 1972, weighted zero-density + sieve for Baker–Harman 1996 and Baker–Harman–Pintz 2001 | gives `p_{n+1} - p_n ≪ p_n^{θ+ε}` | **not in mathlib**; only `Prop` statements are encoded here |
| 6 | Explicit/computational layer: interval arithmetic, verified primality certificates, segmented-sieve checker, reflection or `native_decide`-style verified computation | covers the finite range `n ≤ 7.05 × 10¹³` (and the older `n ≤ 2 × 10⁹` record) | **not formalized**; the published computation is external |
| 7 | Sieve theory for almost primes: sieve weights, Chen's `P₂` theorem, `P_k` estimates, Buchstab/linear sieve | formalizes the almost-prime route (`P₄` for all `n`, `P₂` eventually) | mathlib has `Nat.IsAtMostAlmostPrime` and `Ω`; **no sieve theory** |

### Dependency order and realistic milestones

```
(0) definitions/arithmetic        [done]
        │
(1) Bertrand + Chebyshev          [partly in mathlib]
        │
(2) zeta foundations              [first hard milestone]
        │
(3) PNT with error term
        │
(4) zero-density estimates
        │
(5) Ingham → Huxley → BHP
        │
(6) explicit finite verification  [independent, parallel track]
(7) almost-prime/sieve track      [independent, parallel track]
```

A realistic order for this repository is:

1. **Finish Layer 1**: formalize explicit Chebyshev/π bounds and Bertrand-type
   interval estimates from mathlib's existing API.
2. **Statement-level Layer 5**: already present as `Prop`s; add the precise
   `+ε`, “sufficiently large”, and constant conventions for each paper.
3. **Layer 2–3 first**: zeta foundations and Perron/PNT with error term.  This
   is the first genuinely large project and should be split into many PRs.
4. **Layer 4–5**: Ingham's theorem first, then Huxley, then the BHP sieve
   refinement.  Do not claim BHP before Ingham is complete.
5. **Layer 6**: a verified interval-certificate checker can proceed in parallel
   and is the most realistic way to cover the finite range.
6. **Layer 7**: the `P₁ ↔ Legendre` equivalence is already proved; the next
   honest target is a formalized sieve statement, not a fake `P₂` proof.

Detailed acceptance criteria for each layer are in
[docs/formalization-roadmap.md](docs/formalization-roadmap.md).

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
  formalization-roadmap.md  tools, dependencies and acceptance criteria
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
