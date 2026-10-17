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

> [!TIP]
> **Layer 1 core is now formalized.**  `Legendre/ExplicitBounds.lean` proves the
> interval predicate `HasPrimeIn`, the explicit short-interval theorem
> “there is a prime in `(x, 2x]` for every `x ≥ 1`”, the Chebyshev bridge
> `θ(x) < θ(y) ⇒ ∃ prime in (x, y]`, and explicit upper/lower bounds for
> `θ`, `ψ`, and `π`.  Nagura/Dusart-type sharper constants are **not** yet
> formalized; see [docs/formalization-roadmap.md](docs/formalization-roadmap.md).

## Historical progress at a glance

**Target.** Legendre's conjecture (A.-M. Legendre, *Essai sur la théorie des
nombres*, 2nd ed., Courcier, Paris, 1808): `θ = 1/2` (or `θ = 1/2` with
constant `< 2`).  It is still **open** and has no formal proof.

Here `θ` means the exponent in `p_{n+1} - p_n ≪ p_n^{θ+ε}`; the `+ε` is part of
the published statements.  “Prop only” means the exact statement is encoded in
`Legendre/Conditional.lean`, but **its proof is not formalized**.

| Step (chronological) | Original literature | Exponent θ | Formalized in Lean? | Lean code |
|---|---|---|---|---|
| **Bertrand's postulate** | J. Bertrand, *Mémoire sur le nombre de valeurs que peut prendre une fonction quand on y permute ses variables*, J. École Polytechnique **17** (1845), 123–140; proof: P. L. Chebyshev, *Mémoire sur les nombres premiers*, J. Math. Pures Appl. **17** (1852), 366–390 | **1** | **[✅ Yes — mathlib proof, re-exported](Legendre/Bertrand.lean#L27)** | **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)** |
| Hoheisel 1930 | G. Hoheisel, *Primzahlprobleme in der Analysis*, Sitzungsber. Preuss. Akad. Wiss. (1930), 580–588 | 32999/33000 | **[❌ No — Prop only](Legendre/Conditional.lean#L70)** | **[Conditional.lean L70](Legendre/Conditional.lean#L70)** |
| Ingham 1937 (Lindelöf route) | A. E. Ingham, *On the difference between consecutive primes*, Quart. J. Math. Oxford **8** (1937), 255–266 | 5/8 | **[❌ No — Prop only](Legendre/Conditional.lean#L74)** | **[Conditional.lean L74](Legendre/Conditional.lean#L74)** |
| Ingham 1937 (zero-density route) | same paper as above | 577/925 + ε | **[❌ No — Prop only](Legendre/Conditional.lean#L77)** | **[Conditional.lean L77](Legendre/Conditional.lean#L77)** |
| Huxley 1972 | M. N. Huxley, *On the difference between consecutive primes*, Invent. Math. **15** (1972), 164–170 | 7/12 + ε | **[❌ No — Prop only](Legendre/Conditional.lean#L80)** | **[Conditional.lean L80](Legendre/Conditional.lean#L80)** |
| Heath-Brown–Iwaniec 1979 | D. R. Heath-Brown, H. Iwaniec, *On the difference between consecutive primes*, Invent. Math. **55** (1979), 49–69 | 13/23 + ε | **[❌ No — Prop only](Legendre/Conditional.lean#L83)** | **[Conditional.lean L83](Legendre/Conditional.lean#L83)** |
| Iwaniec–Pintz 1984 | H. Iwaniec, J. Pintz, *Primes in short intervals*, Monatsh. Math. **98** (1984), 115–143 | 11/20 − 1/406 + ε | **[❌ No — Prop only](Legendre/Conditional.lean#L86)** | **[Conditional.lean L86](Legendre/Conditional.lean#L86)** |
| Mozzochi 1986 | C. J. Mozzochi, *On the difference between consecutive primes*, J. Number Theory **24** (1986), 181–187 | 11/20 − 1/384 + ε | **[❌ No — Prop only](Legendre/Conditional.lean#L89)** | **[Conditional.lean L89](Legendre/Conditional.lean#L89)** |
| Baker–Harman 1996 | R. C. Baker, G. Harman, *The difference between consecutive primes*, Proc. London Math. Soc. (3) **72** (1996), 261–280 | 0.535 | **[❌ No — Prop only](Legendre/Conditional.lean#L92)** | **[Conditional.lean L92](Legendre/Conditional.lean#L92)** |
| Baker–Harman–Pintz 2001 | R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive primes, II*, Proc. London Math. Soc. (3) **83** (2001), 532–562 | **0.525** (current record) | **[❌ No — Prop only](Legendre/Conditional.lean#L96)** | **[Conditional.lean L96](Legendre/Conditional.lean#L96)** |
| Riemann Hypothesis (conditional) | H. Cramér, *Some theorems concerning prime numbers*, Ark. Mat. Astron. Fys. **15** (1920), no. 5, 1–32 | 1/2 + o(1) | **[❌ No — Prop only](Legendre/Conditional.lean#L130)** | **[Conditional.lean L130](Legendre/Conditional.lean#L130)** |
| Cramér's conjecture (conditional) | H. Cramér, *On the order of the difference between consecutive primes*, Acta Arith. **2** (1936), 23–46 | 0 (conjectural) | **[❌ No — Prop only](Legendre/Conditional.lean#L137)** | **[Conditional.lean L137](Legendre/Conditional.lean#L137)** |
| Explicit verification `n ≤ 7.05×10¹³` | J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's conjecture up to 7·10¹³*, Res. Number Theory **11** (2025), Paper 4 | n/a (finite range) | **[❌ No — not encoded](docs/formalization-roadmap.md)** | **[Layer 6 roadmap](docs/formalization-roadmap.md)** |
| Chen 1975 (`P₂`, eventually) | Chen Jing-Run, *On the distribution of almost primes in an interval*, Sci. Sinica **18** (1975), 611–627 | n/a (`P₂`) | **[❌ No — not encoded](Legendre/Conditional.lean#L146)** | **[Conditional.lean L146](Legendre/Conditional.lean#L146)** |
| Dudek–Johnston 2026 (`P₄`, all `n`) | A. W. Dudek, D. R. Johnston, *Almost primes between all squares*, J. Number Theory **278** (2026), 726–745 | n/a (`P₄`) | **[❌ No — not encoded](docs/formalization-roadmap.md)** | **[Layer 7 roadmap](docs/formalization-roadmap.md)** |

Status cells are clickable: **✅** jumps to the proof; **❌ “Prop only”** jumps
to the encoded statement (not a proof); **❌ “not encoded”** jumps to the
roadmap.  Full DOI/arXiv links and evidence levels:
[docs/literature.md](docs/literature.md).
“Prop only” rows are **not** proved; they are hypotheses/definitions for future
work.  The formalized reduction from a hypothetical `θ < 1/2` result to
Legendre is separately **proved** in **[Reduction.lean L110](Legendre/Reduction.lean#L110)**.

## What is actually verified in Lean

`lake build` proves the following, with no `sorry`, no `admit`, no user
`axiom`/`constant`/`opaque`, and no `False.elim`/`absurd` shortcuts:

<details>
<summary><strong>Click to expand: 16 verified declarations and their source links</strong></summary>

| Lean declaration | Mathematical content | Status | Code (GitHub) |
|---|---|---|---|
| `Legendre.LegendreAt` / `Legendre.Conjecture` | square-interval form of the conjecture | definition | **[Basic.lean L32](Legendre/Basic.lean#L32)** · **[Basic.lean L36](Legendre/Basic.lean#L36)** |
| `Legendre.legendreAt_iff_gapFormAt` | equivalence of the two standard formulations | **proved** | **[Basic.lean L49](Legendre/Basic.lean#L49)** |
| `Legendre.sq_interval_length` | `(n+1)^2 - n^2 = 2n+1` | **proved** | **[Basic.lean L62](Legendre/Basic.lean#L62)** |
| `Legendre.legendre_of_gap_lt_two_sqrt` | if every prime gap is `< 2√p`, then Legendre holds | **proved** | **[Reduction.lean L41](Legendre/Reduction.lean#L41)** |
| `Legendre.eventually_const_mul_rpow_lt` | `θ < 1/2 ⇒ C n^{2θ} < 2n` eventually | **proved** | **[Reduction.lean L79](Legendre/Reduction.lean#L79)** |
| `Legendre.eventually_legendre_of_gap_exponent_lt_half` | gap exponent `θ < 1/2` ⇒ Legendre eventually | **proved** | **[Reduction.lean L110](Legendre/Reduction.lean#L110)** |
| `Legendre.legendre_eventually_of_shortIntervalExponent_lt_half` | same, packaged as a literature-style exponent result | **proved** | **[Conditional.lean L45](Legendre/Conditional.lean#L45)** |
| `Legendre.legendre_eventually_of_shortIntervalExponentLimit_lt_half` | same for the `+ε` form used in papers | **proved** | **[Conditional.lean L54](Legendre/Conditional.lean#L54)** |
| `Legendre.bertrand` / `bertrand_gap_le` | Bertrand's postulate, re-exported from mathlib | mathlib proof | **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)** · **[Bertrand.lean L33](Legendre/Bertrand.lean#L33)** |
| `Legendre.HasPrimeIn` / `hasPrimeIn_self` | explicit interval API; a prime in `(x, 2x]` for every `x ≥ 1` | **proved** | **[ExplicitBounds.lean L38](Legendre/ExplicitBounds.lean#L38)** · **[L55](Legendre/ExplicitBounds.lean#L55)** |
| `Legendre.exists_prime_of_theta_lt` / `hasPrimeIn_of_theta_gap` | strict increase of `θ` forces a prime in `(x, y]` | **proved** | **[L75](Legendre/ExplicitBounds.lean#L75)** · **[L107](Legendre/ExplicitBounds.lean#L107)** |
| `Legendre.theta_upper_explicit` / `theta_lower_explicit` | explicit Chebyshev `θ` upper/lower bounds | **proved** | **[L118](Legendre/ExplicitBounds.lean#L118)** · **[L123](Legendre/ExplicitBounds.lean#L123)** |
| `Legendre.psi_upper_explicit` / `psi_lower_explicit` | explicit Chebyshev `ψ` upper/lower bounds | **proved** | **[L129](Legendre/ExplicitBounds.lean#L129)** · **[L134](Legendre/ExplicitBounds.lean#L134)** |
| `Legendre.pi_lower_explicit` / `pi_upper_explicit` | explicit `π` lower/upper bounds | **proved** | **[L139](Legendre/ExplicitBounds.lean#L139)** · **[L145](Legendre/ExplicitBounds.lean#L145)** |
| `Legendre.conjecture_of_almostPrimeSquareAtMost_one` | the `P₁` almost-prime square statement *is* Legendre | **proved** | **[Conditional.lean L172](Legendre/Conditional.lean#L172)** |
| `Legendre.almostPrimeSquareAtMost_one_iff` | `P₁` square statement ↔ Legendre | **proved** | **[Conditional.lean L190](Legendre/Conditional.lean#L190)** |

Each row links directly to the exact declaration in the GitHub source; click the
`Lnn` anchor to jump to that line.

The audit works by `#print axioms`: every audited theorem depends only on
`propext`, `Classical.choice`, `Quot.sound`.

</details>

## What is deliberately **not** claimed

The following are encoded as precise `Prop`-valued definitions so that later
work can plug them in, but their proofs are **not** formalized here:

* Hoheisel 1930, Ingham 1937 (both `5/8` and `577/925` routes), Huxley 1972,
  Heath-Brown–Iwaniec 1979, Iwaniec–Pintz 1984, Mozzochi 1986,
  Baker–Harman 1996, Baker–Harman–Pintz 2001 — statement code:
  **[Hoheisel L70](Legendre/Conditional.lean#L70)** ·
  **[Ingham 5/8 L74](Legendre/Conditional.lean#L74)** ·
  **[Ingham 577/925 L77](Legendre/Conditional.lean#L77)** ·
  **[Huxley L80](Legendre/Conditional.lean#L80)** ·
  **[Heath-Brown–Iwaniec L83](Legendre/Conditional.lean#L83)** ·
  **[Iwaniec–Pintz L86](Legendre/Conditional.lean#L86)** ·
  **[Mozzochi L89](Legendre/Conditional.lean#L89)** ·
  **[Baker–Harman L92](Legendre/Conditional.lean#L92)** ·
  **[BHP L96](Legendre/Conditional.lean#L96)**;
* the Riemann-Hypothesis gap bound and Cramér's conjecture —
  **[RH gap L130](Legendre/Conditional.lean#L130)** ·
  **[Cramér L137](Legendre/Conditional.lean#L137)**;
* the explicit verification of Legendre up to `n ≤ 7.05 × 10¹³` —
  **[Layer 6 roadmap](docs/formalization-roadmap.md)**;
* the almost-prime theorems of Chen (1975) and Dudek–Johnston (2026) —
  **[P_k definitions L146](Legendre/Conditional.lean#L146)** ·
  **[Layer 7 roadmap](docs/formalization-roadmap.md)**.

See [docs/literature.md](docs/literature.md) and
[docs/proof-map.md](docs/proof-map.md) for the exact status of every step.

## Why `θ = 0.525` does not suffice

If the gap after a prime `p ≤ n²` is at most `C p^θ`, then the next prime is
below `n² + C n^{2θ}`. To land below `(n+1)² = n² + 2n + 1` one needs
`2θ < 1`, i.e. `θ < 1/2`. For `θ = 0.525` the allowed gap is `n^{1.05}`, which
is much larger than the square interval length `2n`; a gap can jump over the
whole interval. This is formalized in
**[Reduction.lean L110](Legendre/Reduction.lean#L110)** and explained in
[docs/literature.md](docs/literature.md).

## What a full proof-level formalization would require

The current repository is a **verified reduction layer**, not a formalized
analytic number theory library.  A proof-level formalization of the published
exponent results needs the following tools, roughly in dependency order.
This table is the roadmap, not a claim that the work is done.

| Layer | Tool / theory to formalize | Why it is needed | Current state (mathlib v4.33.1 / this repo) |
|---:|---|---|---|
| 0 | Natural-number primes, prime gaps, square intervals, basic real powers | statements and the `θ < 1/2` reduction | **done here**: **[Basic.lean](Legendre/Basic.lean)** · **[Reduction.lean](Legendre/Reduction.lean)** |
| 1 | Bertrand's postulate, Chebyshev functions `ψ(x)`, `θ(x)`, elementary prime-counting bounds | historical base case and quantitative intuition | **core formalized** in **[ExplicitBounds.lean](Legendre/ExplicitBounds.lean)**: `HasPrimeIn`, prime in `(x,2x]`, Chebyshev `θ` bridge, explicit `θ/ψ/π` bounds; Nagura/Dusart constants remain open |
| 2 | Riemann zeta: Euler product, analytic continuation, functional equation, zero-free region, argument principle, logarithmic derivative | every zero-density and short-interval theorem starts here | partial zeta API in mathlib; no complete zero-free-region / zero-counting development |
| 3 | Prime-counting foundations: `π(x)`, `ψ(x)`, partial summation, Perron's formula, truncated explicit formula, PNT with error term | turns zeta information into prime-counting information | `PrimeCounting.lean` and `Chebyshev.lean` exist; no Perron formula or PNT with the needed error term |
| 4 | Zero-density theory: `N(σ,T)`, Ingham's zero-density estimate, Huxley's `12/5` estimate, large sieve, mean-value estimates for Dirichlet polynomials (including Guth–Maynard-type large-value estimates) | supplies the density input for short intervals | **not in mathlib** |
| 5 | Short-interval theorems: Ingham 1937, Huxley 1972, weighted zero-density + sieve for Baker–Harman 1996 and Baker–Harman–Pintz 2001 | gives `p_{n+1} - p_n ≪ p_n^{θ+ε}` | **not in mathlib**; only `Prop` statements are encoded in **[Conditional.lean L70](Legendre/Conditional.lean#L70)** |
| 6 | Explicit/computational layer: interval arithmetic, verified primality certificates, segmented-sieve checker, reflection or `native_decide`-style verified computation | covers the finite range `n ≤ 7.05 × 10¹³` (and the older `n ≤ 2 × 10⁹` record) | **not formalized**; the published computation is external |
| 7 | Sieve theory for almost primes: sieve weights, Chen's `P₂` theorem, `P_k` estimates, Buchstab/linear sieve | formalizes the almost-prime route (`P₄` for all `n`, `P₂` eventually) | mathlib has `Nat.IsAtMostAlmostPrime` and `Ω`; **no sieve theory**; `P₁` equivalence in **[Conditional.lean L190](Legendre/Conditional.lean#L190)** |

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
README.md            English (default)
README.zh.md         Chinese translation
Legendre/
  Basic.lean         definitions, equivalence, elementary facts
  Reduction.lean     square-gap criterion, θ < 1/2 reduction
  Conditional.lean   literature exponents as Props, conditional theorems, P_k
  Bertrand.lean      Bertrand's postulate re-exported and compared
  ExplicitBounds.lean Layer 1: interval API, (x,2x], Chebyshev θ/ψ/π bounds
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
