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
> 4. Formalization code in a PR should be written against the **latest stable
>    Lean and mathlib releases**.  As of **2026-10-18** these are
>    **Lean `v4.35.0`** and **mathlib `v4.35.0`** (the versions pinned in
>    `lean-toolchain` and `lakefile.toml`).  If a newer stable release is out by
>    the time you open the PR, please adapt to it and say so in the PR
>    description.
> 5. CI must be green. The maintainer merges `review → master` only after an
>    explicit instruction and a green audit.
>
> Full guide: **[docs/PR_WORKFLOW.md](docs/PR_WORKFLOW.md)** ·
> PR checklist: [`.github/pull_request_template.md`](.github/pull_request_template.md)

> [!NOTE]
> **Status (October 2026): Legendre's conjecture is still open.**
> The best unconditional prime-gap exponent is still `θ = 0.525`
> (Baker–Harman–Pintz 2001), which is **above** `1/2`; it does not prove
> Legendre's conjecture. This repository does **not** claim a proof of the
> conjecture and does **not** claim to have formalized the deep exponent results
> of Hoheisel, Ingham, Huxley, Baker–Harman or Baker–Harman–Pintz.  It does
> formalize the definitions, the elementary reductions, **Nagura's 1952
> explicit interval theorem** (a prime in `(x, 6x/5]` for `x ≥ 25`, in
> [`Nagura.lean`](Legendre/Nagura.lean)), the exact statement-level conventions
> of the nine published short-interval results
> ([Layer5.lean](Legendre/Layer5.lean)), and the exact conditional bridge from a
> future `θ < 1/2` result to Legendre's conjecture.

> [!TIP]
> **Layer 1 is now complete (Nagura).**  `Legendre/ExplicitBounds.lean` proves the
> interval predicate `HasPrimeIn`, the explicit short-interval theorem
> “there is a prime in `(x, 2x]` for every `x ≥ 1`”, the Chebyshev bridge
> `θ(x) < θ(y) ⇒ ∃ prime in (x, y]`, and explicit upper/lower bounds for
> `θ`, `ψ`, and `π`.  **Nagura's theorem is now fully proved** in
> [`Legendre/Nagura.lean`](Legendre/Nagura.lean): for every real `x ≥ 25` the
> interval `(x, 6x/5]` contains a prime (`nagura_hasPrimeIn`), together with
> explicit Chebyshev bounds `0.916n < ψ(n) < 1.086n`.  Dusart-type
> `x + x/(25 log²x)` bounds remain open; see
> [docs/formalization-roadmap.md](docs/formalization-roadmap.md).
> The Nagura formalization is adapted from the MIT-licensed
> [ShouqiaoW/erdos](https://github.com/ShouqiaoW/erdos) project; see
> [Reused and adapted formalizations](#reused-and-adapted-formalizations).
>
> **Statement-level Layer 5 is now formalized.**  `Legendre/Layer5.lean`
> encodes the nine published short-interval results with the exact `+ε`,
> constant and “sufficiently large” conventions of the papers, and proves the
> interval form, the gap form, and the coarse `Prop`s in `Conditional.lean`
> equivalent.  The analytic proofs themselves remain **open**.

<details>
<summary><strong>Layer 3 — classical PNT error terms (2026-11-01)</strong></summary>

Local validation: full `lake build` (**4,030 jobs**) and all **1,918** axiom audit targets passed.

[`PrimeNumberTheorem.lean`](Legendre/PrimeNumberTheorem.lean) implements
**ψ(x)=x+O(x exp(−c√log x))**, **θ(x)=x+O(x exp(−c√log x))**, and
**π(x)=Li₂(x)+O(x exp(−c√log x))**, with one common c>0 and
`Li₂(x)=∫₂ˣ dt/log t`. The decay constant, coefficient and threshold are
existential; no numerical Dusart-type bound is claimed.
The analytic ψ estimate is adapted from PNT+; the partial-summation error
transfer is proved here. `pnt_eventual_bound` exposes eventual inequalities.
The exact smoothed finite-height contour decomposition and its tail terms
are also available. The truncated **zero-sum** explicit formula is now proved in
`PerronExplicitBounds.lean`, including all zeros through absolute height T
with analytic multiplicity and an explicit contour-dependent remainder.
The choices of contour and its boundary bound are existential; a universal
log-squared good-height error is not claimed. See [the exact statement](docs/perron-explicit-formula.md).

This is the classical de la Vallée Poussin error scale. It is sublinear,
but larger than every fixed x^a for a<1 at sufficiently large x.
Thus it does not by itself establish a fixed polynomial short-interval
exponent, a zero-density theorem, or Legendre's conjecture.
See [Layer 3 scope and acceptance](docs/formalization-roadmap.md#layer-3--prime-counting-and-pnt-with-error-term)
and [the fixed upstream source and license](docs/pnt-provenance.md).

</details>

<details>
<summary><strong>Layer 2 — full documented scope completed (2026-10-31)</strong></summary>

**Layer 2 four-item acceptance completed (2026-10-31):**
Earlier zero-free/Perron milestone source: [`f83e5cb32a60`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/f83e5cb32a60112cfc4b41afd971dbadec1795e4).
That milestone passed full `lake build` (3994 jobs) and all 310 axiom audit entries.
[`ZetaZeroFree.lean`](Legendre/ZetaZeroFree.lean) proves the effective region
**`|Im(s)|≥3` and `Re(s)>1−1/(2000000 log|Im(s)|) ⇒ ζ(s)≠0`**.
The coefficient `c=1/2000000` and height threshold 3 are explicit.
Local finite zero removal, Borel-Carathéodory and Cauchy estimates give a
quantitative logarithmic-derivative bound; the sharp real-axis pole estimate
and the 3–4–1 inequality exclude a zero in this region.
Together with the multiplicity-weighted N(T)/N(σ,T) definitions, the proved
truncated Perron formula below and the axiom audit, this meets all four
[Layer 2 acceptance criteria](docs/formalization-roadmap.md#layer-2--riemann-zeta-foundations).
**Full-scope completion (2026-10-31):**
Verified implementation source: [`6b921a2528fa`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/6b921a2528fa1567d37b1b9dea92b1ff92d6f14e).
Full local validation: `lake build` (3999 jobs) and all **347** axiom audit entries passed.
[`ZetaGlobalCounting.lean`](Legendre/ZetaGlobalCounting.lean) now proves
**`N(T)≤C T log T` for T≥7**, and `N(T)=O(T log T)`, counting analytic
multiplicity across the entire critical strip. Reflection preserves zero
orders; wider Jensen disks cover the right half of the strip at both signs
of height. A fixed compact low-height count B is kept explicitly:
`N(T) ≤ B + 2(floor(T)+1) log(40(T+7))/log(14/13)` for T≥0.
The coefficient C is a fixed positive expression involving B; B is proved
finite, not numerically evaluated. This is a global upper bound, not a
Riemann–von Mangoldt leading-term asymptotic.
[`ZetaArgumentPrinciple.lean`](Legendre/ZetaArgumentPrinciple.lean) also
proves `∮ ζ′/ζ = 2πi localZetaDegree` on the high disk with zero-free boundary.
The [scope checklist](docs/formalization-roadmap.md#layer-2--riemann-zeta-foundations)
now has proof references for every Layer 2 scope item and suggested slice,
including global N(T) bounds and the local argument-principle interface.
Zero-density estimates and the needed short-interval PNT error terms remain
later-layer work. Legendre's conjecture is not proved.

**Truncated Perron formula with error (2026-10-31):**
[`PerronError.lean`](Legendre/PerronError.lean) proves, for x>0, σ>1 and T>0,
**`|P(x,σ,T)−ψ₀(x)| ≤ U(x,σ)/T`**, where ψ₀ has half weight at integers.
The error coefficient is first proved summable, then bounded by a finite
sum over `n≤floor(2x)` plus the closed tail bound
`[2x^σ/(π log 2)] [2/(σ−1)] [1+2/(σ−1)]`.
The scalar error is at most `2y^σ/(π T |log y|)` away from y=1 and
`σ/(π T)` at y=1. This meets the Layer 2 truncated-Perron criterion.
The constant depends on x and σ; this is not a uniform short-interval
PNT error estimate.

**Inputs toward an effective zero-free region (2026-10-31):**
[`ZetaPositivity.lean`](Legendre/ZetaPositivity.lean) proves the 3–4–1
logarithmic-derivative inequality on σ>1.
[`ZetaGrowth.lean`](Legendre/ZetaGrowth.lean) proves Euler summation on
Re(s)>0, with an absolutely convergent fractional-part remainder of norm
at most 1/Re(s). Consequently `|ζ(s)|≤|s|/|s−1|+|s|/Re(s)` away from the
pole, and `|ζ(s)|≥1/2` on Re(s)≥2.
[`ZetaLocalBound.lean`](Legendre/ZetaLocalBound.lean) bounds ζ by
`12(|t|+2)` on the radius-3/2 disk centered at 2+it when |t|≥3.
Jensen's inequality bounds the zeros with multiplicity in its radius-5/4
subdisk by `log(24(|t|+2))/log(6/5)`.
The subsequent `ZetaZeroRemoval.lean`, `ZetaRegularizedBound.lean`,
`ZetaLogDerivativeLocal.lean`, `ZetaPoleBounds.lean` and `ZetaZeroFree.lean`
complete the effective region proof with c=1/2000000 and threshold 3.

**Perron inversion for ψ (2026-10-31):**
[`PerronInversion.lean`](Legendre/PerronInversion.lean) proves, for x>0 and σ>1,
that the normalized finite Perron integral converges to **ψ(x)** away from
integer endpoints and to **ψ(m)−Λ(m)/2** at a positive integer m.
A uniform scalar bound is summable after multiplication by Λ(n): for n≥2x,
`|log(x/n)|≥log 2`, giving a constant multiple of the absolutely convergent
Dirichlet series. Tannery's theorem justifies the infinite-height limit
under the series, and its finite support identifies the half-weighted ψ.
The fixed-x truncation error is proved in `PerronError.lean`;
`ZetaZeroFree.lean` supplies the effective logarithmic zero-free region.

**Scalar Perron inversion (2026-10-30):**
[`PerronResidue.lean`](Legendre/PerronResidue.lean), with
[`PerronShift.lean`](Legendre/PerronShift.lean) and
[`PerronZero.lean`](Legendre/PerronZero.lean), proves for every y>0 and σ>0:
**`J(y,σ,T) → 0` if y<1, `→1/2` if y=1, and `→1` if y>1**.
Positive-line shifts, vanishing horizontal sides and a uniform finite-height
bound give the y<1 case. An entire extension of `(y^s-1)/s` accounts for
the pole when crossing zero and proves the y>1 case by reciprocal-base
reflection. This evaluates the scalar kernel; `PerronInversion.lean` now
passes its limit through the von Mangoldt series and reconstructs the
half-weighted ψ. `PerronError.lean` now proves the fixed-x truncation error;
the effective logarithmic zero-free region is now proved in `ZetaZeroFree.lean`.

**Scalar kernel convergence (2026-10-30):**
Verified source commit: [`262e64dd1d08`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/262e64dd1d081f339e63d682c4adbc42269e8b10).
[`PerronTail.lean`](Legendre/PerronTail.lean) proves existence of the limit
of J(y,σ,T) as T→∞ for every y>0 and σ>0. Integration by parts gives a
vanishing boundary term and an absolutely integrable remainder on (1,∞);
reflection by complex conjugation supplies the negative half-line. This is
conditional convergence of the scalar kernel, not absolute integrability
of the original infinite-line integrand. The limit values are now identified
in `PerronResidue.lean`; passage through the von Mangoldt series is now
proved in `PerronInversion.lean`; all Layer 2 acceptance criteria are now met.

**Oscillatory numerator (2026-10-30):**
Verified source commit: [`13df761e6893`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/13df761e689301c0acc7d6d80d15093509473e17)
(merged through review to master after successful verify runs).
[`PerronOscillation.lean`](Legendre/PerronOscillation.lean) separates
`y^(σ+it)=y^σ exp(it log y)` for y>0. For y≠1 it evaluates the finite
numerator integral and bounds its norm by `2y^σ/|log y|`, uniformly in both
height endpoints. This supplies input for integration by parts with `1/(σ+it)`;
the scalar limit is now evaluated in `PerronResidue.lean`.

**Scalar Perron endpoint (2026-10-30):**
Verified source commit: [`0baaeed095a6`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/0baaeed095a6b0f34cf83557858329d9a57d356b)
(PR #5 verify passed before merging to review).
[`PerronKernel.lean`](Legendre/PerronKernel.lean) proves, for σ>0,
`J(1,σ,T)=arctan(T/σ)/π`, hence `J(1,σ,T)→1/2` as T→∞.
For T>0 the boundary error satisfies `|J(1,σ,T)-1/2|≤σ/(πT)`.
This establishes the half-weight endpoint convention. Nonendpoint values
are now proved, as is passage through the von Mangoldt sum;
the fixed-x truncation error is now proved in `PerronError.lean`.

**Finite Perron series exchange (2026-10-30):**
[`PerronSeries.lean`](Legendre/PerronSeries.lean) proves termwise integration
of the weighted von Mangoldt series on every finite vertical segment with
`x>0`, `σ>1`. A height-independent summable majorant proves the exchange and
absolute convergence of the integrated terms. The normalized integral is
exactly `P(x,σ,T)=∑ Λ(n)J(x/n,σ,T)`, with J the finite scalar Perron kernel.
J's infinite-height values are proved in `PerronResidue.lean`;
`PerronInversion.lean` now exchanges that limit with this series and
identifies the limit with half-weighted ψ. The fixed-x truncation error is now proved in `PerronError.lean`.

**Finite vertical Perron integrals (2026-10-30):**
[`PerronTruncated.lean`](Legendre/PerronTruncated.lean) defines the normalized
finite vertical integral on `s=σ+it`, proves its integrability for `x>0`,
`σ>1`, and gives an explicit finite-height norm bound. Writing
`B(σ)=(2/(σ-1))(1+2/(σ-1))`, the kernel satisfies
`|K(x,σ+it)|≤B(σ)x^σ/σ` and, for `t≠0`, `≤B(σ)x^σ/|t|`.
Perron inversion is now proved in `PerronInversion.lean`; these finite-height
bounds alone do not give the truncation error; see `PerronError.lean` for that bound.

**Local Perron contour (2026-10-30):**
[`PerronContour.lean`](Legendre/PerronContour.lean) proves that for every
`x>0` there is `δ>0` such that every positively oriented circle centered at
1 with `0<r<δ` satisfies **`∮ K(x,s) ds = 2πix`**. The proof constructs an
analytic extension of `(s-1)K(x,s)` and applies Cauchy's integral formula.
The radius is non-effective. Scalar rectangles and Perron inversion are now
proved in subsequent modules; see `PerronError.lean` for the fixed-x truncation error.

Verified Abel/Perron-foundation milestone: [`83afea75433f`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/83afea75433f02e9900fafe5381db659b4fd1ba1).

**Abel representation and weighted pole coefficient (2026-10-30):**
[`PerronFoundation.lean`](Legendre/PerronFoundation.lean) proves, for `Re(s)>1`,
**`-ζ′/ζ(s)=s∫₁∞ψ(t)t^(-s-1)dt`**, with a separate proof of absolute
integrability. The proved Chebyshev linear bound supplies coefficient-growth
control for mathlib’s Abel summation interface. For `x>0`, the weighted
kernel `K(x,s)=(-ζ′/ζ(s))x^s/s` satisfies **`(s-1)K(x,s)→x`**.
This is a forward integral representation and local coefficient limit,
**not Perron inversion or a truncated contour formula with error bounds**.

Verified local pole-structure milestone: [`c28a28c1a28c`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/c28a28c1a28c3fc382d48e0fb4f736d4d1cb6828).

**Pole principal part and local growth:** [`ZetaPole.lean`](Legendre/ZetaPole.lean)
updates `H(s)=(s-1)ζ(s)` to `H(1)=1` and proves H analytic at 1.
`ζ′/ζ(s)+1/(s-1)` has a finite limit, so
**`(s-1)ζ′/ζ(s)→-1`**, or **`(s-1)(-ζ′/ζ(s))→+1`** in the Perron sign convention.
For some `C>0`, the punctured-neighborhood bound
`|ζ′/ζ(s)|≤1/|s-1|+C` also holds. Only H is extended at 1, not ζ itself.
The constant and neighborhood are non-effective; no Perron contour formula
or quantitative high-imaginary-part zero-free region is claimed.

Verified explicit ε-bound milestone: [`bb75a8305f9f`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/bb75a8305f9fecb883d060dcbb7165c6c909738a).

**Explicit ε-bound on every right half-plane:**
[`ZetaHalfPlane.lean`](Legendre/ZetaHalfPlane.lean) proves, for every `ε>0`,
**`Re(s)≥1+ε ⇒ |ζ′/ζ(s)|≤(2/ε)(1+2/ε)`**. For `0<ε≤1` this implies
**`|ζ′/ζ(s)|≤6/ε²`**. Kernel-checked deductions include the integral-test
power-series bound, a power majorant for the von Mangoldt coefficients,
and summable-series comparison. The estimate reaches every closed
half-plane strictly to the right of 1. It does not extend to the left
of that line or establish a quantitative zero-free region or Perron formula.

Verified logarithmic-derivative milestone: [`2a395e71b4a8`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/2a395e71b4a8e1bff3f287a4d6253d4bfce0401f).

**Logarithmic derivative and counting bridge:**
[`ZetaLogDerivative.lean`](Legendre/ZetaLogDerivative.lean) reuses mathlib’s
absolute convergence and von Mangoldt series identity for `-ζ′/ζ` on `Re(s)>1`.
New deductions give a convergent-series majorant on each closed half-plane
and the explicit bound **`Re(s) ≥ 3 ⇒ |ζ′(s)/ζ(s)| ≤ π²/6`**.
The qualitative strip is also connected to the counting API: at each fixed
height `T` some `0<σ<1` satisfies `N(σ,T)=0`. This cutoff is non-effective.
No near-critical-line logarithmic-derivative estimate, `c/log T` zero-free
region, or Perron formula is claimed.

Verified counting-foundations commit: [`0c2b0574ec83`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/0c2b0574ec83a787bff4e61cd07ab51ccb7c0fce).

**Multiplicity-weighted counting foundations:** [`ZetaCounting.lean`](Legendre/ZetaCounting.lean)
defines critical-strip `NontrivialZero`, `zeroCount` (`N(T)`), and
`zeroDensityCount` (`N(σ,T)`). The convention is `0 < Re(s) < 1`,
`0 < Im(s) ≤ T`, with `σ ≤ Re(s)` for the density count. Proved: finite
analytic orders, positive multiplicity at zeros, finite counting sets,
monotonicity, positive-count/existence equivalences, and boundary cases.
These are multiplicity-weighted counts, not just counts of distinct zeros.
**No counting asymptotic or zero-density estimate is proved**, and no
classification of all zeros outside the strip is claimed.

Verified formalization commit: [`63ba01a3a814`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/63ba01a3a81457bfab5b6f2d4cca378c2e7adf99).


**Zeta foundations integrated and checked:** absolute convergence, the Euler
product and finite-product convergence, analytic continuation away from the
pole, the completed functional equation, nonvanishing on `Re(s) ≥ 1`
(excluding the pole), and finiteness of distinct zeros on compact sets.
See [`Legendre/Zeta.lean`](Legendre/Zeta.lean). These interfaces reuse proved
mathlib v4.35.0 results; they are not claimed as new analytic proofs.

**New deduction:** `Legendre.Zeta.exists_zero_free_strip` proves that for
each fixed height `T` there is `δ(T) > 0` such that `ζ(s) ≠ 0` whenever
`Re(s) > 1 - δ(T)`, `|Im(s)| ≤ T`, and `s ≠ 1`. The width is non-effective.

**Now proved:** an effective logarithmic zero-free region (c=1/2000000, threshold 3)
and a fixed-x truncated Perron formula with error. The four-item Layer 2 acceptance checklist is complete.
The global `N(T)=O(T log T)` bound and the local argument-principle interface are now proved; the needed PNT error terms remain later-layer work.

See [provenance and upstream mapping](docs/zeta-provenance.md) for fixed
commits and authors. Adapted and checked with Lean 4.35.0 / mathlib v4.35.0,
with no additional trusted axioms.

</details>

## Historical progress at a glance

**Target.** Legendre's conjecture (A.-M. Legendre, *Essai sur la théorie des
nombres*, 2nd ed., Courcier, Paris, 1808): `θ = 1/2` (or `θ = 1/2` with
constant `< 2`).  It is still **open** and has no formal proof.

Here `θ` means the exponent in `p_{n+1} - p_n ≪ p_n^{θ+ε}`; the `+ε` is part of
the published statements.  For the nine exponent results, “No proof” means the
exact statement is encoded (both as a coarse `Prop` in
`Legendre/Conditional.lean` and in the paper-exact conventions of
`Legendre/Layer5.lean`), but **its proof is not formalized**.  The RH and
Cramér rows are coarse-`Prop` only.

| Step (chronological) | Original literature | Exponent θ | Formalized in Lean? | Lean code |
|---|---|---|---|---|
| **Bertrand's postulate** | J. Bertrand, *Mémoire sur le nombre de valeurs que peut prendre une fonction quand on y permute ses variables*, J. École Polytechnique **17** (1845), 123–140; proof: P. L. Chebyshev, *Mémoire sur les nombres premiers*, J. Math. Pures Appl. **17** (1852), 366–390 | **1** | **[✅ Yes — mathlib proof, re-exported](Legendre/Bertrand.lean#L27)** | **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)** |
| **Nagura 1952** | J. Nagura, *On the interval containing at least one prime number*, Proc. Japan Acad. **28** (1952), 177–181, [DOI 10.3792/pja/1195570997](https://doi.org/10.3792/pja/1195570997) | n/a — `(x, 6x/5]`, `x ≥ 25` | **[✅ Yes — fully proved here](Legendre/Nagura.lean#L50)** | **[Nagura.lean L41](Legendre/Nagura.lean#L41)** · **[L50](Legendre/Nagura.lean#L50)** · **[PsiBounds.lean L1671](Legendre/Nagura/PsiBounds.lean#L1671)** |
| Hoheisel 1930 | G. Hoheisel, *Primzahlprobleme in der Analysis*, Sitzungsber. Preuss. Akad. Wiss. (1930), 580–588 | 32999/33000 | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L289)** | **[Conditional.lean L70](Legendre/Conditional.lean#L70)** · **[Layer5.lean L289](Legendre/Layer5.lean#L289)** |
| Ingham 1937 (Lindelöf route) | A. E. Ingham, *On the difference between consecutive primes*, Quart. J. Math. Oxford **8** (1937), 255–266 | 5/8 | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L302)** | **[Conditional.lean L74](Legendre/Conditional.lean#L74)** · **[Layer5.lean L302](Legendre/Layer5.lean#L302)** |
| Ingham 1937 (zero-density route) | same paper as above | 577/925 + ε | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L315)** | **[Conditional.lean L77](Legendre/Conditional.lean#L77)** · **[Layer5.lean L315](Legendre/Layer5.lean#L315)** |
| Huxley 1972 | M. N. Huxley, *On the difference between consecutive primes*, Invent. Math. **15** (1972), 164–170 | 7/12 + ε | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L328)** | **[Conditional.lean L80](Legendre/Conditional.lean#L80)** · **[Layer5.lean L328](Legendre/Layer5.lean#L328)** |
| Heath-Brown–Iwaniec 1979 | D. R. Heath-Brown, H. Iwaniec, *On the difference between consecutive primes*, Invent. Math. **55** (1979), 49–69 | 13/23 + ε | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L340)** | **[Conditional.lean L83](Legendre/Conditional.lean#L83)** · **[Layer5.lean L340](Legendre/Layer5.lean#L340)** |
| Iwaniec–Pintz 1984 | H. Iwaniec, J. Pintz, *Primes in short intervals*, Monatsh. Math. **98** (1984), 115–143 | 11/20 − 1/406 + ε | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L353)** | **[Conditional.lean L86](Legendre/Conditional.lean#L86)** · **[Layer5.lean L353](Legendre/Layer5.lean#L353)** |
| Mozzochi 1986 | C. J. Mozzochi, *On the difference between consecutive primes*, J. Number Theory **24** (1986), 181–187 | 11/20 − 1/384 + ε | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L366)** | **[Conditional.lean L89](Legendre/Conditional.lean#L89)** · **[Layer5.lean L366](Legendre/Layer5.lean#L366)** |
| Baker–Harman 1996 | R. C. Baker, G. Harman, *The difference between consecutive primes*, Proc. London Math. Soc. (3) **72** (1996), 261–280 | 0.535 | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L380)** | **[Conditional.lean L92](Legendre/Conditional.lean#L92)** · **[Layer5.lean L380](Legendre/Layer5.lean#L380)** |
| Baker–Harman–Pintz 2001 | R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive primes, II*, Proc. London Math. Soc. (3) **83** (2001), 532–562 | **0.525** (current record) | **[❌ No proof — exact statement ✅](Legendre/Layer5.lean#L395)** | **[Conditional.lean L96](Legendre/Conditional.lean#L96)** · **[Layer5.lean L395](Legendre/Layer5.lean#L395)** |
| Riemann Hypothesis (conditional) | H. Cramér, *Some theorems concerning prime numbers*, Ark. Mat. Astron. Fys. **15** (1920), no. 5, 1–32 | 1/2 + o(1) | **[❌ No proof — coarse `Prop`](Legendre/Conditional.lean#L130)** | **[Conditional.lean L130](Legendre/Conditional.lean#L130)** |
| Cramér's conjecture (conditional) | H. Cramér, *On the order of the difference between consecutive primes*, Acta Arith. **2** (1936), 23–46 | 0 (conjectural) | **[❌ No proof — coarse `Prop`](Legendre/Conditional.lean#L137)** | **[Conditional.lean L137](Legendre/Conditional.lean#L137)** |
| Explicit verification `n ≤ 7.05×10¹³` | J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's conjecture up to 7·10¹³*, Res. Number Theory **11** (2025), Paper 4 | n/a (finite range) | **[❌ No — not encoded](docs/formalization-roadmap.md)** | **[Layer 6 roadmap](docs/formalization-roadmap.md)** |
| Chen 1975 (`P₂`, eventually) | Chen Jing-Run, *On the distribution of almost primes in an interval*, Sci. Sinica **18** (1975), 611–627 | n/a (`P₂`) | **[❌ No — not encoded](Legendre/Conditional.lean#L146)** | **[Conditional.lean L146](Legendre/Conditional.lean#L146)** |
| Dudek–Johnston 2026 (`P₄`, all `n`) | A. W. Dudek, D. R. Johnston, *Almost primes between all squares*, J. Number Theory **278** (2026), 726–745 | n/a (`P₄`) | **[❌ No — not encoded](docs/formalization-roadmap.md)** | **[Layer 7 roadmap](docs/formalization-roadmap.md)** |

Status cells are clickable: **✅** jumps to the proof; **❌ “No proof — exact
statement ✅”** jumps to the paper-exact statement encoding in
[`Layer5.lean`](Legendre/Layer5.lean) (not a proof); **❌ “No proof — coarse
`Prop`”** jumps to the coarse conditional encoding; **❌ “not encoded”** jumps
to the roadmap.  Full DOI/arXiv links and evidence levels:
[docs/literature.md](docs/literature.md).
The nine exponent results are **not** proved.  Their coarse `Prop`s live in
`Conditional.lean`, their paper-exact `+ε`/constant/threshold forms live in
`Layer5.lean`, and the equivalence between the two is **proved**.  The
formalized reduction from a hypothetical `θ < 1/2` result to Legendre is
separately **proved** in **[Reduction.lean L110](Legendre/Reduction.lean#L110)**.

## What is actually verified in Lean

`lake build` proves the following, with no `sorry`, no `admit`, no user
`axiom`/`constant`/`opaque`, and no `False.elim`/`absurd` shortcuts:

<details>
<summary><strong>Click to expand: verified declarations and their source links</strong></summary>

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
| `Legendre.nagura_hasPrimeIn` / `nagura_prime_gap` | Nagura's theorem: a prime in `(x, 6x/5]` for every `x ≥ 25` | **proved** | **[Nagura.lean L50](Legendre/Nagura.lean#L50)** · **[L41](Legendre/Nagura.lean#L41)** |
| `Legendre.Nagura.naguraChebyshevSum_eq_log_factorial` | Ramanujan/Nagura identity `∑_{m≤n} ψ(n/m) = log n!` | **proved** | **[PsiBounds.lean L109](Legendre/Nagura/PsiBounds.lean#L109)** |
| `Legendre.Nagura.psi_nat_lt_1_086_mul` / `psi_nat_gt_0_916_mul` | explicit Chebyshev bounds `0.916n < ψ(n) < 1.086n` | **proved** | **[PsiBounds.lean L1671](Legendre/Nagura/PsiBounds.lean#L1671)** · **[L1844](Legendre/Nagura/PsiBounds.lean#L1844)** |
| `Legendre.HasPrimeInShortInterval` / `ShortIntervalStatement` / `PrimeGapBound` | paper-exact statement conventions with explicit exponent, constant and “sufficiently large” threshold | definition | **[Layer5.lean L60](Legendre/Layer5.lean#L60)** · **[L70](Legendre/Layer5.lean#L70)** · **[L79](Legendre/Layer5.lean#L79)** |
| `Legendre.hasPrimeInShortInterval_iff_primeGapBound` | interval form ↔ gap form with the same `θ` and `C` (for `θ ≥ 0`, `C ≥ 0`) | **proved** | **[Layer5.lean L160](Legendre/Layer5.lean#L160)** |
| `Legendre.shortIntervalStatement_iff_exponentLimit` | paper-exact `+ε` form ↔ the coarse conditional interface | **proved** | **[Layer5.lean L256](Legendre/Layer5.lean#L256)** |
| `Legendre.legendre_eventually_of_shortIntervalStatement_lt_half` | paper-exact `θ < 1/2` statement ⇒ Legendre eventually | **proved** | **[Layer5.lean L264](Legendre/Layer5.lean#L264)** |
| `Legendre.*Paper_iff` (nine results) | each paper-exact statement ↔ its coarse `Prop` | **proved** | **[Layer5.lean L293](Legendre/Layer5.lean#L293)** |
| `Legendre.PNT.psi_classical_error` | ψ=x+O(x exp(−c√log x)), c>0 | **proved**; analytic proof adapted from PNT+ | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.primeCount_error_of_theta` | partial summation preserves the classical error scale | **proved**; new downstream bridge | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.pnt_classical_error` / `pnt_eventual_bound` | common classical ψ/θ/π−Li₂ error and eventual inequalities | **proved**; constants existential | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.classicalError_isLittleO` / `exists_smoothed_truncated_formula` | sublinearity and exact finite-height smoothed contour decomposition | **proved**; zero-sum formula has a separate contour-dependent remainder bound | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.Zeta.exists_truncated_explicit_formula` | ψ₀=x−∑m(ρ)x^ρ/ρ+E, with all critical-strip zeros through absolute height T | **proved**; contour-dependent remainder bound | [PerronExplicitBounds.lean](Legendre/PerronExplicitBounds.lean) |

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
  Baker–Harman 1996, Baker–Harman–Pintz 2001 — coarse `Prop`s and paper-exact
  forms are both encoded (proofs remain open); statement code:
  **[Hoheisel L70](Legendre/Conditional.lean#L70)** ·
  **[Ingham 5/8 L74](Legendre/Conditional.lean#L74)** ·
  **[Ingham 577/925 L77](Legendre/Conditional.lean#L77)** ·
  **[Huxley L80](Legendre/Conditional.lean#L80)** ·
  **[Heath-Brown–Iwaniec L83](Legendre/Conditional.lean#L83)** ·
  **[Iwaniec–Pintz L86](Legendre/Conditional.lean#L86)** ·
  **[Mozzochi L89](Legendre/Conditional.lean#L89)** ·
  **[Baker–Harman L92](Legendre/Conditional.lean#L92)** ·
  **[BHP L96](Legendre/Conditional.lean#L96)** ·
  **[paper-exact forms in Layer5.lean](Legendre/Layer5.lean)**;
* Dusart-type explicit bounds (`ϑ(x) − x < x/36260`, `|ϑ(x) − x| ≤ 0.2x/log²x`
  for `x ≥ 3 594 641`, a prime in `(x, x + x/(25 log²x)]` for `x ≥ 396 738`) —
  these require a formalized explicit prime number theorem with a zero-free
  region and are **not** claimed (Layer 2–3);
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

| Layer | Tool / theory to formalize | Why it is needed | Current state (mathlib v4.35.0 / this repo) |
|---:|---|---|---|
| 0 | Natural-number primes, prime gaps, square intervals, basic real powers | statements and the `θ < 1/2` reduction | **done here**: **[Basic.lean](Legendre/Basic.lean)** · **[Reduction.lean](Legendre/Reduction.lean)** |
| 1 | Bertrand's postulate, Chebyshev functions `ψ(x)`, `θ(x)`, elementary prime-counting bounds | historical base case and quantitative intuition | **complete (Nagura)** in **[ExplicitBounds.lean](Legendre/ExplicitBounds.lean)** and **[Nagura.lean](Legendre/Nagura.lean)**: `HasPrimeIn`, prime in `(x,2x]`, Chebyshev `θ` bridge, explicit `θ/ψ/π` bounds, **Nagura's `(x, 6x/5]` for `x ≥ 25`**, and explicit `ψ` bounds; Dusart-type PNT-strength constants remain open |
| 2 | Riemann zeta: Euler product, analytic continuation, functional equation, zero-free region, argument principle, logarithmic derivative | every zero-density and short-interval theorem starts here | **documented scope complete**: zeta foundations, explicit c=1/2000000 zero-free region (height≥3), local argument principle, global multiplicity-weighted N(T)=O(T log T), truncated Perron with error and audit |
| 3 | Prime-counting foundations: `π(x)`, `ψ(x)`, partial summation, Perron's formula, truncated explicit formula, PNT with error term | turns zeta information into prime-counting information | **documented interfaces implemented**: half-weighted Perron inversion/error, partial summation, classical ψ/θ/π PNT error terms, and a finite multiplicity-weighted zero-sum formula with contour-dependent remainder; [quantitative limits](docs/perron-explicit-formula.md) |
| 4 | Zero-density theory: `N(σ,T)`, Ingham's zero-density estimate, Huxley's `12/5` estimate, large sieve, mean-value estimates for Dirichlet polynomials (including Guth–Maynard-type large-value estimates) | supplies the density input for short intervals | **not in mathlib** |
| 5 | Short-interval theorems: Ingham 1937, Huxley 1972, weighted zero-density + sieve for Baker–Harman 1996 and Baker–Harman–Pintz 2001 | gives `p_{n+1} - p_n ≪ p_n^{θ+ε}` | **statement level formalized here** in **[Layer5.lean](Legendre/Layer5.lean)**: paper-exact `+ε`, constant and threshold conventions, interval ↔ gap equivalence, and equivalence to the coarse `Prop`s in **[Conditional.lean L70](Legendre/Conditional.lean#L70)**; the deep proofs are **not in mathlib** |
| 6 | Explicit/computational layer: interval arithmetic, verified primality certificates, segmented-sieve checker, reflection or `native_decide`-style verified computation | covers the finite range `n ≤ 7.05 × 10¹³` (and the older `n ≤ 2 × 10⁹` record) | **not formalized**; the published computation is external |
| 7 | Sieve theory for almost primes: sieve weights, Chen's `P₂` theorem, `P_k` estimates, Buchstab/linear sieve | formalizes the almost-prime route (`P₄` for all `n`, `P₂` eventually) | mathlib has `Nat.IsAtMostAlmostPrime` and `Ω`; **no sieve theory**; `P₁` equivalence in **[Conditional.lean L190](Legendre/Conditional.lean#L190)** |

### Dependency order and realistic milestones

```
(0) definitions/arithmetic        [done]
        │
(1) Bertrand + Chebyshev          [done; Nagura done; Dusart-type open]
        │
(2) zeta foundations              [first hard milestone]
        │
(3) PNT with error term
        │
(4) zero-density estimates
        │
(5) Ingham → Huxley → BHP      [statement level done; proofs open]
        │
(6) explicit finite verification  [independent, parallel track]
(7) almost-prime/sieve track      [independent, parallel track]
```

A realistic order for this repository is:

1. ✅ **Finish Layer 1 — done, including Nagura.** `Legendre/ExplicitBounds.lean`
   proves the interval API, the `(x, 2x]` prime theorem, the Chebyshev bridge,
   and explicit `θ/ψ/π` bounds.  `Legendre/Nagura.lean` now proves **Nagura's
   theorem** (`nagura_hasPrimeIn`: a prime in `(x, 6x/5]` for every `x ≥ 25`)
   and the explicit `ψ` bounds `0.916n < ψ(n) < 1.086n`.  Dusart-type
   PNT-strength constants remain open (Layer 2–3).
2. ✅ **Statement-level Layer 5 — done.** `Legendre/Layer5.lean` encodes the
   exact `+ε`, “sufficiently large” and constant conventions of Hoheisel,
   Ingham (two routes), Huxley, Heath-Brown–Iwaniec, Iwaniec–Pintz, Mozzochi,
   Baker–Harman and Baker–Harman–Pintz, proves the interval form equivalent to
   the gap form, and connects each paper-exact statement to its coarse `Prop`.
   The analytic proofs are still open.
3. **Layer 3**: classical PNT error terms and a truncated zero-sum explicit formula are implemented; sharper uniform-in-height remainder estimates remain follow-up work.
   This is the first genuinely large project and should be split into many PRs.
4. **Layer 4–5 (proof level)**: Ingham's theorem first, then Huxley, then the
   BHP sieve refinement.  Do not claim BHP before Ingham is complete.
5. **Layer 6**: a verified interval-certificate checker can proceed in parallel
   and is the most realistic way to cover the finite range.
6. **Layer 7**: the `P₁ ↔ Legendre` equivalence is already proved; the next
   honest target is a formalized sieve statement, not a fake `P₂` proof.

Detailed acceptance criteria for each layer are in
[docs/formalization-roadmap.md](docs/formalization-roadmap.md).

## Build

```bash
# Lean 4.35.0 + mathlib v4.35.0
lake exe cache get
lake build
```

The repository is pinned to **Lean 4.35.0** and **mathlib v4.35.0** (see
`lean-toolchain` and `lakefile.toml`).  The Lean sources were re-checked and
adapted to that mathlib release on 2026-10-18; the public theorem statements are
unchanged.

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
2. no `False.elim` / `absurd` / `nomatch` explosion shortcuts;
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
  PrimeNumberTheorem.lean Layer 3: classical ψ/θ/π error terms and partial summation
  PNT/               selected Apache-2.0 PNT+ proof dependencies
  ExplicitBounds.lean Layer 1: interval API, (x,2x], Chebyshev θ/ψ/π bounds
  Layer5.lean        Layer 5: paper-exact short-interval statements and bridges
  Nagura.lean        Layer 1: Nagura's theorem, (x, 6x/5] for x >= 25
  Nagura/            Nagura's proof: finite prime chains + explicit psi bounds
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

## Commit attribution

Some commits in this repository's history were authored by an automated coding
agent under the generic git identity `Legendre Formalization
<noreply@users.noreply.github.com>` (for example `8029c02`, `82bdd2a`,
`a9a932b` and `444b384`).  GitHub happens to attribute such commits to the
unrelated `noreply` account; they are not third-party contributions.  The
corresponding changes were verified locally (`lake build`,
`python3 scripts/audit.py`) and merged by the maintainer (`lim-tan90`).  The
repository's git identity has since been corrected to
`lim-tan90 <lim-tan90@users.noreply.github.com>`.

## Reused and adapted formalizations

This project prefers to **adapt existing verified formalizations** instead of
rewriting proofs from scratch.  Every ported or adapted development is recorded
here with its upstream repository, pinned commit, license, and destination in
this repository.

* **[ShouqiaoW/erdos](https://github.com/ShouqiaoW/erdos)** — MIT License,
  commit `d28713ac8245ca86a686b8c67370a8d19d81b242` (2026-08-02).
  The files under [`Legendre/Nagura/`](Legendre/Nagura/) and
  [`Legendre/Nagura.lean`](Legendre/Nagura.lean) are adapted from its
  `Erdos390/WholePaper/Nagura*.lean` modules, which formalize J. Nagura's
  1952 theorem.  The adaptation consists of module/namespace renaming,
  removal of PNT-dependent auxiliary results, merging into three modules, and
  porting to mathlib v4.33.1 (re-checked against v4.35.0 when the repository was
  upgraded in October 2026); the mathematical proof is the upstream one.
  The original MIT license is retained in
  [`Legendre/Nagura/LICENSE`](Legendre/Nagura/LICENSE).
* **[AlexKontorovich/PrimeNumberTheoremAnd (PNT+)](https://github.com/AlexKontorovich/PrimeNumberTheoremAnd)** —
  Apache-2.0, commit `127b50e33f6033e2147921167a117af96d9ba4ea`.
  Fourteen selected modules under [`Legendre/PNT/`](Legendre/PNT/) adapt the
  complete `StrongPNT` proof dependency slice, including smoothing, Mellin
  calculus, rectangle residues, zeta bounds and the logarithmic zero-free region.
  Upstream proofs and contributor credits are retained; imports, module visibility,
  blueprint metadata and six nonzero contradiction expressions were adapted.
  The original license is in [`licenses/PNTplus-Apache-2.0.txt`](licenses/PNTplus-Apache-2.0.txt).
  The new ψ-to-θ-to-π error bridge is in
  [`Legendre/PrimeNumberTheorem.lean`](Legendre/PrimeNumberTheorem.lean).
  See [provenance and limits](docs/pnt-provenance.md).
* **[mathlib4](https://github.com/leanprover-community/mathlib4)** —
  Apache-2.0.  Used as the general library.  `Legendre.bertrand` is a thin
  re-export of mathlib's `Nat.exists_prime_lt_and_le_two_mul`; no other
  mathlib proof is copied into this repository.



## Copyright

No PDFs, no scans, and no verbatim long excerpts of copyrighted papers are
uploaded. `docs/literature.md` contains only bibliographic data, short
mathematical statements, and links to the publishers/arXiv. The Lean code is
released under Apache-2.0, except the files under `Legendre/Nagura/`, which are
adapted from the MIT-licensed project
<https://github.com/ShouqiaoW/erdos> (commit
`d28713ac8245ca86a686b8c67370a8d19d81b242`); their original MIT license is
retained in [`Legendre/Nagura/LICENSE`](Legendre/Nagura/LICENSE).

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
* J. Nagura, *On the interval containing at least one prime number*,
  Proc. Japan Acad. **28** (1952), 177–181,
  [DOI](https://doi.org/10.3792/pja/1195570997).
* J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's
  conjecture up to 7·10¹³*, Res. Number Theory **11** (2025),
  [DOI](https://doi.org/10.1007/s40993-024-00589-4).
