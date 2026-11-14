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
> 6. **Organize new Layer 5 and later work by layer:** put implementations in
>    `Legendre/LayerN/`; use `Legendre/LayerN.lean` as the public entry point.
>    Layer 5 statements are in `Layer5/Statements.lean`; Layer 6 and 7 directories
>    are reserved for future proofs and certificates.
> 7. Update the historical exponent comparators, both READMEs and proof map when
>    a milestone changes. Run `python3 scripts/check_literature.py`; statement
>    correspondence alone must not be labelled a proof.
> 8. Record every adapted formalization's source, pinned commit, license and
>    destination in both READMEs; retain the license and attribution in the code.
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
<summary><strong>Layer 4 — global 12/5 density, small mollifiers and powers (2026-11-14)</strong></summary>

**Import:** `import Legendre.Layer4`. For every finite Dirichlet polynomial
`P(t)=Σ_{1≤n≤N} a(n)n^(−it)`, the proved mean-square deviation from
`(B−A)Σ|a(n)|²` is now at most **`2πN Σ|a(n)|²`**, uniformly in both endpoints,
by a proved real-line Hilbert inequality. Optimized separated sampling has
a single `log N` cost for N>1. The earlier harmonic estimate, exact limiting
mean and continuous large-value measure bound remain available. Coefficients
may be arbitrary complex numbers; the mean-square theorem includes N=0.

The density-exponent interface has a coefficient uniform in σ∈[1/2,1].
Logarithmic losses are absorbed into `T^ε` by a proved conditional bridge.
The effective zero-free region also gives a fixed low-height bound for
`N(1−1/(4000000 log T),T)`, T≥3.
The finite additive large sieve, separated-point sampling and Gram/Halasz–Montgomery
interfaces are now proved. Weighted selection preserves zero multiplicities
and gives a conditional detector-to-density reduction. Finite Euler summation
now supplies an actual two-branch zero detector with its principal pole term
retained. Sampling permits independently varying real parts; the resulting
sample bound displays both detector energies. This older long-detector bound is superseded by the compact-detector Ingham proof below.
[Exact detector and remaining analytic steps](docs/layer4-zero-detector.md).
The high-tail energy now has explicit X^(1−2σ) decay, and actual detection
also bounds the full multiplicity-weighted count with its fixed low-height
term. An entire self-dual xi square, sharp Gamma quotients and an integrable
Gaussian envelope now justify an exact contour functional equation and a
pointwise reduction `|ζ(s)|⁴ ≤ 4|xiSmoothedZetaSquare(s)|²` on Re(s)=1/2.
The normalized contour mean and the actual fourth moment `O(T log^6 T)` are proved, hence `O_ε(T^(1+ε))` for every `ε>0`. The sharp `log^4` target remains open. [Proof chain](docs/layer4-moment-kernel.md).
The compact Möbius detector now has an exact initial right-contour integral,
with its smoothing scale independent of the former squared-length choice.
The critical-line shift is now proved with the exact principal zeta residue.
Its explicit smallness at high ordinates gives a genuine polynomial-or-integral
zero detector. Whole-line weighted moments and separated kernel packing now give a proved
cubic cardinality bound for the integral alternative. The polynomial branch now has
`R ≤ C log^8(2Y+1)(Y^(2−2σ)+T X^(1−2σ))`. Balancing X=ceil(T),
Y=T^(3/(2(2−σ))), covering heights, and restoring analytic multiplicities prove
**`N(σ,T) ≤ C T^(3(1−σ)/(2−σ)) log^10 T`** for all σ∈[1/2,1], T≥2.
Thus **Ingham 1940 density is proved with arbitrary positive height epsilon**,
uniformly in σ; `layer4_ingham_comparator` is a closed proof. This does not
prove the different Ingham 1937 short-interval results. [Exact scope](docs/layer4-compact-detector.md).
The actual logarithmic-phase kernel is now proved with bound
`C(sqrt(|t|)+U/|t|)` on dyadic blocks. Harmonic packing and finite Gram duality
give an unconditional Halasz energy bound with an explicit `R sqrt(T)` term,
also allowing independently varying real parts. Interval subdivision and window
optimization now prove the unconditional two-term count
`R ≪ log^6(2U) log(2T) (UE/W²+UTE³/W⁶)`. The resulting actual Möbius second
moment has the improved `R^(2/3)(AT)^(1/3)` term, uniformly under a common
vertical translation, and is integrated into the compact detector critical-mass
fourth moment. The improved polynomial and integral alternatives now prove
**`N(σ,T) ≤ C T^((12/5)(1−σ)) (1+log T)^38`**, uniformly for σ∈[1/2,1], T≥2,
with all analytic multiplicities. Thus `hasZeroDensityEstimate_twelve_fifths`
and the independent `layer4_huxley_global_comparator` are closed proofs.
[Full density proof and parameter balance](docs/layer4-huxley-density.md). [Exact statements and constants](docs/layer4-exponential-large-values.md).
**New (2026-11-14):** the actual Type II detector branch with a chosen small
integer mollifier now has the uniform sample bound `T^(2−2σ+ε)`. Exact finite
Dirichlet convolution powers, uniform subpower coefficients, their dyadic
pieces, and bounded power selection on σ∈[3/4,5/6] are proved.
These are ingredients toward the curved Huxley target; they do not yet close
that target. [Exact hypotheses, source and remaining steps](docs/layer4-small-mollifier-powers.md).

**The Layer 4 roadmap acceptance requirements are fulfilled.** The stronger
curved Huxley benchmark, Guth–Maynard and the sharp fourth-moment `log^4` remain
explicit open targets. None is assumed in the global `12/5` proof.

Validation (2026-11-14): **4,281 build jobs**, all **4,351 project theorem
declarations** audited with only the three standard axioms, and **283 Lean files**
with zero executable `sorry`/`admit`/`sorryAx`. Both independent declaration
inventories match the audit targets and actual axiom output exactly.
All **139 independent consumers** pass: **94 Layer 4**, nine Layer 3 and
36 literature checks. The 12 added consumers cover zero cutoff, empty actual
zero families, rounding, detector height, exact convolution coefficients,
support boundaries, uniform bounded powers and the sigma=5/6 power window.
Lean rejects confusing pointwise coefficient powers with Dirichlet convolution;
the global theorem is still not a proof of the stronger curved benchmark.
Locally verified global 12/5 density proof commit: `484d8dfc70c24cb715743a2fc6ca811f800f0c67` ([proof and scope](docs/layer4-huxley-density.md)).
Locally verified analytic large-value/moment proof commit: [`3c358dd2af95`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/3c358dd2af95dcc46071df0fa860cd38d0559a34).
Locally verified Ingham proof commit: [`6e5dd7031d2c`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/6e5dd7031d2c1af9ff40aafefcc9ccca974e81de).
Previous verified large-sieve checkpoint: [`897139fbb45d`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/897139fbb45d96b98270f24bf5b196c411df1c19).
Initial Layer 4 proof commit: [`4f31d764b243`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/4f31d764b243f6a093dc9cbf34a677a5ad3bc17c).
[Initial mean values](docs/layer4-mean-values.md) ·
[Large sieve, separated samples and weighted detection](docs/layer4-large-sieve.md) ·
[Linear mean-square error and optimized sampling](docs/layer4-linear-mean-value.md).

</details>

<details>
<summary><strong>Layer 3 — complete, including the uniform full contour (2026-11-07)</strong></summary>

Local validation: full `lake build` (**4,054 jobs**) and all **2,756** axiom audit targets passed.
Additional verification covers all **2,756 project theorem declarations**, nine
standalone consumer checks, and all 85 project Lean files with **zero actual
`sorry`/`admit`/`sorryAx` placeholders**. The consumer check is a dedicated CI step.
Verified proof commit: [`5c4be2780255`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/5c4be2780255ef78fd03bff6976596287d007c06).

**Import interface:** `import Legendre.Layer3`. The documented Layer 3 acceptance
criteria are complete; [acceptance evidence and limits](docs/layer3-completion.md).
`layer3_pnt_package` provides one c>0 for the ψ/θ/π errors and a prime in
`(x, x+x exp(−c√log x)]` for every sufficiently large x. The coefficient is
one; c and the threshold are existential. `pnt_prime_gap_classical` exposes
the corresponding natural-number gap interface.

[`PrimeNumberTheorem.lean`](Legendre/PrimeNumberTheorem.lean) implements
**ψ(x)=x+O(x exp(−c√log x))**, **θ(x)=x+O(x exp(−c√log x))**, and
**π(x)=Li₂(x)+O(x exp(−c√log x))**, with one common c>0 and
`Li₂(x)=∫₂ˣ dt/log t`. The decay constant, coefficient and threshold are
existential; no numerical Dusart-type bound is claimed.
The analytic ψ estimate is adapted from PNT+; the partial-summation error
transfer is proved here. `pnt_eventual_bound` exposes eventual inequalities.
The exact smoothed finite-height contour decomposition and its tail terms
are also available. The strengthened **zero-sum explicit formula** in
[`PerronFullExplicit.lean`](Legendre/PerronFullExplicit.lean) now uses a fixed
negative left edge, `Re(s)=−1/8`, and includes all critical-strip zeros through
absolute height T with analytic multiplicity, the evaluated term `−log(2π)`,
and a **uniform bound on the complete retained contour**. One absolute error
coefficient is chosen before H; the height T∈(H,H+1) is chosen before σ and x.
Both horizontal lines have `|ζ′/ζ|≤C(log H)²` for every `Re(s)≥−1/8`;
the complete left integral is bounded by `C x^(−1/8) log²(H+6)`.
The existing explicit Perron truncation majorant is retained.
See [the exact uniform formula, quantifiers and proof](docs/perron-uniform-explicit-formula.md)
and [acceptance evidence](docs/layer3-completion.md).

This is the classical de la Vallée Poussin error scale. It is sublinear,
and `rpow_isLittleO_classicalError` now proves that it dominates every fixed
x^a for a<1. `classicalError_not_isBigO_rpow` excludes a fixed polynomial
bound for this error scale.
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

## Literature exponent comparison

All **17 historical targets/results** below now have [typed comparators](docs/literature-comparators.md)
and a complete Layer 0–4 source map. `python3 scripts/check_literature.py`
checks coverage and compiles independent numeric expectations. Comparison allows
positive epsilon losses, harmless constants and changes of interval direction;
it preserves hypotheses and finite/eventual scope. Only Bertrand and Nagura
have closed historical prime-interval proofs here; comparison bridges do not
prove the other historical claims.

**Source corrections:** Heath-Brown–Iwaniec 1979 is `11/20` (Pintz §3 (3.13)),
and Iwaniec–Pintz 1984 is `23/42` (publisher abstract and the same author survey).
The former `13/23` attribution and unsupported `11/20−1/406` expectation are
corrected in Lean as well as this table. Legacy `*Paper` names denote normalized
exponent consequences, rather than all stronger conclusions of their papers.
The final Sorenson–Webster range is `7.05×10^13`; arXiv v1 has `3.33×10^13`.
[Sources, apparent introductory typos and limits](docs/literature-comparators.md#corrections-and-source-limitations).
No proof gap in the original prime-gap theorems has been established.
The completed Layer 2 `c/log T` zero-free region also does not by itself
supply the stronger `A log log T/log T` input in Ingham’s original
short-interval transmission; that source obligation remains open.

## Historical progress at a glance

**Repository status (2026-11-14).** The classical PNT in Layer 3, Ingham
**1940 curved density** and the **global Huxley 12/5 density exponent** in
Layer 4 are proved. The nine
historical short-interval exponent results below still have statement-level
formalizations only. In particular, the proved 1940 density estimate does
not close either Ingham **1937 prime-gap** result. The Layer 4 roadmap
acceptance requirements are fulfilled; the stronger curved Huxley and
Guth–Maynard benchmarks remain open.
The actual Type II branch now has the small-mollifier bound `T^(2−2σ+ε)`;
exact polynomial powers and the restricted power-selection algebra are also
proved, without changing the historical short-interval proof statuses below.

<!-- comparator:legendre1808 -->
**Target.** Legendre's conjecture (A.-M. Legendre, *Essai sur la théorie des
nombres*, 2nd ed., Courcier, Paris, 1808): primes in the open square intervals.
An exponent strictly below `1/2` suffices eventually; at `1/2` an additional
constant restriction, such as `< 2`, is needed.  It is still **open** and has no formal proof.

Here `θ` means the exponent in `p_{n+1} - p_n ≪ p_n^{θ+ε}`; the `+ε` is part of
the published statements.  For the nine exponent results, “No proof” means the
exact statement is encoded (both as a coarse `Prop` in
`Legendre/Conditional.lean` and in the normalized exponent conventions of
`Legendre/Layer5.lean`), but **its proof is not formalized**.  The RH and
Cramér comparators preserve their hypothesis or conjectural status.

| Milestone | Original literature | Exponent θ | Lean proof status | Lean code |
|---|---|---|---|---|
| **Bertrand's postulate** | J. Bertrand, *Mémoire sur le nombre de valeurs que peut prendre une fonction quand on y permute ses variables*, J. École Polytechnique **17** (1845), 123–140; proof: P. L. Chebyshev, *Mémoire sur les nombres premiers*, J. Math. Pures Appl. **17** (1852), 366–390 | **1** | **[✅ Yes — mathlib proof, re-exported](Legendre/Bertrand.lean#L27)** | **[Bertrand.lean L27](Legendre/Bertrand.lean#L27)**  [compare](docs/literature-comparators.md#bertrand1852) <!-- comparator:bertrand1852 --> |
| **Nagura 1952** | J. Nagura, *On the interval containing at least one prime number*, Proc. Japan Acad. **28** (1952), 177–181, [DOI 10.3792/pja/1195570997](https://doi.org/10.3792/pja/1195570997) | **1** (constant improvement): `(x, 6x/5]`, `x ≥ 25` | **[✅ Yes — fully proved here](Legendre/Nagura.lean#L50)** | **[Nagura.lean L41](Legendre/Nagura.lean#L41)** · **[L50](Legendre/Nagura.lean#L50)** · **[PsiBounds.lean L1671](Legendre/Nagura/PsiBounds.lean#L1671)**  [compare](docs/literature-comparators.md#nagura1952) <!-- comparator:nagura1952 --> |
| Hoheisel 1930 | G. Hoheisel, *Primzahlprobleme in der Analysis*, Sitzungsber. Preuss. Akad. Wiss. (1930), 580–588 | 32999/33000 | **[❌ No proof — exponent statement ✅](Legendre/Layer5/Statements.lean#L291)** | **[Conditional.lean L70](Legendre/Conditional.lean#L70)** · **[Statements.lean L291](Legendre/Layer5/Statements.lean#L291)**  [compare](docs/literature-comparators.md#hoheisel1930) <!-- comparator:hoheisel1930 --> |
| Ingham 1937 (Lindelöf route) | A. E. Ingham, *On the difference between consecutive primes*, Quart. J. Math. Oxford **8** (1937), 255–266 | 5/8 | **[❌ No proof — exponent statement ✅](Legendre/Layer5/Statements.lean#L304)** | **[Conditional.lean L74](Legendre/Conditional.lean#L74)** · **[Statements.lean L304](Legendre/Layer5/Statements.lean#L304)**  [compare](docs/literature-comparators.md#ingham1937lindelof) <!-- comparator:ingham1937lindelof --> |
| Ingham 1937 (zero-density route) | same paper as above | 577/925 + ε | **[❌ Prime-gap proof open — exponent statement ✅](Legendre/Layer5/Statements.lean#L317)**; [1940 density exponent separately proved](Legendre/Layer4/InghamDensity.lean) | **[Conditional.lean L77](Legendre/Conditional.lean#L77)** · **[Statements.lean L317](Legendre/Layer5/Statements.lean#L317)**  [compare](docs/literature-comparators.md#ingham1937density) <!-- comparator:ingham1937density --> |
| Huxley 1972 | M. N. Huxley, *On the difference between consecutive primes*, Invent. Math. **15** (1972), 164–170 | 7/12 + ε | **[❌ No proof — exponent statement ✅](Legendre/Layer5/Statements.lean#L330)** | **[Conditional.lean L80](Legendre/Conditional.lean#L80)** · **[Statements.lean L330](Legendre/Layer5/Statements.lean#L330)**  [compare](docs/literature-comparators.md#huxley1972) <!-- comparator:huxley1972 --> |
| Heath-Brown–Iwaniec 1979 | D. R. Heath-Brown, H. Iwaniec, *On the difference between consecutive primes*, Invent. Math. **55** (1979), 49–69 | 11/20 + ε | **[❌ No proof — exponent statement ✅](Legendre/Layer5/Statements.lean#L342)** | **[Conditional.lean L83](Legendre/Conditional.lean#L83)** · **[Statements.lean L342](Legendre/Layer5/Statements.lean#L342)**  [compare](docs/literature-comparators.md#heathbrowniwaniec1979) <!-- comparator:heathbrowniwaniec1979 --> |
| Iwaniec–Pintz 1984 | H. Iwaniec, J. Pintz, *Primes in short intervals*, Monatsh. Math. **98** (1984), 115–143 | 23/42 + ε | **[❌ No proof — exponent statement ✅](Legendre/Layer5/Statements.lean#L355)** | **[Conditional.lean L86](Legendre/Conditional.lean#L86)** · **[Statements.lean L355](Legendre/Layer5/Statements.lean#L355)**  [compare](docs/literature-comparators.md#iwaniecpintz1984) <!-- comparator:iwaniecpintz1984 --> |
| Mozzochi 1986 | C. J. Mozzochi, *On the difference between consecutive primes*, J. Number Theory **24** (1986), 181–187 | 11/20 − 1/384 + ε | **[❌ No proof — exponent statement ✅](Legendre/Layer5/Statements.lean#L368)** | **[Conditional.lean L89](Legendre/Conditional.lean#L89)** · **[Statements.lean L368](Legendre/Layer5/Statements.lean#L368)**  [compare](docs/literature-comparators.md#mozzochi1986) <!-- comparator:mozzochi1986 --> |
| Baker–Harman 1996 | R. C. Baker, G. Harman, *The difference between consecutive primes*, Proc. London Math. Soc. (3) **72** (1996), 261–280 | 0.535 | **[❌ No proof — exponent statement ✅](Legendre/Layer5/Statements.lean#L382)** | **[Conditional.lean L92](Legendre/Conditional.lean#L92)** · **[Statements.lean L382](Legendre/Layer5/Statements.lean#L382)**  [compare](docs/literature-comparators.md#bakerharman1996) <!-- comparator:bakerharman1996 --> |
| Baker–Harman–Pintz 2001 | R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive primes, II*, Proc. London Math. Soc. (3) **83** (2001), 532–562 | **0.525** (current record) | **[❌ No proof — exponent statement ✅](Legendre/Layer5/Statements.lean#L397)** | **[Conditional.lean L96](Legendre/Conditional.lean#L96)** · **[Statements.lean L397](Legendre/Layer5/Statements.lean#L397)**  [compare](docs/literature-comparators.md#bakerharmanpintz2001) <!-- comparator:bakerharmanpintz2001 --> |
| Riemann Hypothesis (conditional) | H. Cramér, *Some theorems concerning prime numbers*, Ark. Mat. Astron. Fys. **15** (1920), no. 5, 1–32 | 1/2 + o(1) | **[❌ No proof — coarse `Prop`](Legendre/Conditional.lean#L130)** | **[Conditional.lean L130](Legendre/Conditional.lean#L130)**  [compare](docs/literature-comparators.md#cramer1920rh) <!-- comparator:cramer1920rh --> |
| Cramér's conjecture (conditional) | H. Cramér, *On the order of the difference between consecutive primes*, Acta Arith. **2** (1936), 23–46 | 0 + ε (conjectural) | **[❌ No proof — coarse `Prop`](Legendre/Conditional.lean#L137)** | **[Conditional.lean L137](Legendre/Conditional.lean#L137)**  [compare](docs/literature-comparators.md#cramer1936) <!-- comparator:cramer1936 --> |
| Explicit verification `n ≤ 7.05×10¹³` | J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's conjecture up to 7·10¹³*, Res. Number Theory **11** (2025), Paper 4 | n/a (finite range) | **[❌ No proof — comparator encoded](Legendre/Literature/Statements.lean)** | **[Layer 6 roadmap](docs/formalization-roadmap.md)**  [compare](docs/literature-comparators.md#sorensonwebster2025) <!-- comparator:sorensonwebster2025 --> |
| Chen 1975 (`P₂`, eventually) | Chen Jing-Run, *On the distribution of almost primes in an interval*, Sci. Sinica **18** (1975), 611–627 | n/a (`P₂`) | **[❌ No proof — comparator encoded](Legendre/Literature/Statements.lean)** | **[Conditional.lean L146](Legendre/Conditional.lean#L146)**  [compare](docs/literature-comparators.md#chen1975) <!-- comparator:chen1975 --> |
| Dudek–Johnston 2026 (`P₄`, all `n`) | A. W. Dudek, D. R. Johnston, *Almost primes between all squares*, J. Number Theory **278** (2026), 726–745 | n/a (`P₄`) | **[❌ No proof — comparator encoded](Legendre/Literature/Statements.lean)** | **[Layer 7 roadmap](docs/formalization-roadmap.md)**  [compare](docs/literature-comparators.md#dudekjohnston2026) <!-- comparator:dudekjohnston2026 --> |

Status cells are clickable: **✅** jumps to the proof; **❌ “No proof — exact
statement ✅”** jumps to the normalized exponent statement encoding in
[`Layer5.lean`](Legendre/Layer5.lean) (not a proof); **❌ “No proof — coarse
`Prop`”** jumps to the coarse conditional encoding; **❌ “not encoded”** jumps
to the roadmap.  Full DOI/arXiv links and evidence levels:
[docs/literature.md](docs/literature.md).
The nine exponent results are **not** proved.  Their coarse `Prop`s live in
`Conditional.lean`, their normalized exponent `+ε`/constant/threshold forms live in
`Layer5.lean`, and the equivalence between the two is **proved**.  The
formalized reduction from a hypothetical `θ < 1/2` result to Legendre is
separately **proved** in **[Reduction.lean L110](Legendre/Reduction.lean#L110)**.

The completed analytic milestones supporting this program are:

| Analytic milestone | Current proved estimate | Lean proof and scope |
|---|---|---|
| Classical PNT (Layer 3) | Common error scale `x exp(−c√log x)` for ψ, θ and π; corresponding eventual prime intervals | **✅ Proved**: [`layer3_pnt_package`](Legendre/Layer3.lean). This error scale does not give a fixed prime-gap exponent `θ<1`. |
| Ingham 1940 zero density (Layer 4), [original DOI](https://doi.org/10.1093/qmath/os-11.1.201) | `N(σ,T) ≪_ε T^(3(1−σ)/(2−σ)+ε)` for every `ε>0` | **✅ Proved**: [`ingham_density_epsilon`](Legendre/Layer4/InghamDensity.lean) and the closed [`layer4_ingham_comparator`](Legendre/Literature/LayerCoverage.lean), uniformly for σ∈[1/2,1], T≥2, with analytic multiplicities. The proved logarithmic form has `log^10 T`; the original sharp `log^5 T` is not claimed. |
| Global Huxley density (Layer 4) | `N(σ,T) ≪_ε T^((12/5)(1−σ)+ε)` for every `ε>0` | **✅ Proved**: [`hasZeroDensityEstimate_twelve_fifths`](Legendre/Layer4/HuxleyDensity.lean), closed [`layer4_huxley_global_comparator`](Legendre/Literature/LayerCoverage.lean); uniform σ∈[1/2,1], T≥2, all analytic multiplicities. A stronger intermediate bound holds on σ∈[3/4,1]. The paper-exact curved Huxley benchmark remains open. |
| Critical-line fourth moment (Layer 4) | `∫₀ᵀ ‖ζ(1/2+it)‖⁴ dt ≪ T log^6 T`, hence `≪_ε T^(1+ε)` | **✅ Proved**: [`ZetaFourthMoment.lean`](Legendre/Layer4/ZetaFourthMoment.lean). The sharp `log^4 T` target remains open. |
| Actual Halasz analytic input (Layer 4) | Dyadic correlation `≪ sqrt(abs(t))+U/abs(t)`; energy with an explicit `R sqrt(T)` term, including mixed real parts | **✅ Proved**: [`HalaszComplex.lean`](Legendre/Layer4/Exponential/HalaszComplex.lean). Interval subdivision, the two-term large-value count and improved actual Möbius/critical-mass moments are proved; the stronger curved Huxley target remains open. |
| Analytic large values and actual mollifier moments (Layer 4) | `R ≪ log^6(2U) log(2T)(UE/W²+UTE³/W⁶)`; improved `R^(2/3)(AT)^(1/3)` term in the actual Möbius second moment | **✅ Proved**: closed [`layer4_actual_halasz_large_values_comparator`](Legendre/Literature/LayerCoverage.lean), [weighted mollifier moment](Legendre/Layer4/HalaszMollifierMoment.lean) and [actual critical-mass moment](Legendre/Layer4/HalaszCriticalMass.lean). Global 12/5 is now proved; the stronger curved Huxley target remains open. |

The **global `12/5` exponent is proved**. Huxley's stronger curved density
estimate and the Guth–Maynard density estimate remain **open**; the older
conditional comparison bridges still require those stronger inputs. The new
`layer4_huxley_global_comparator` is unconditional.

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
| `Legendre.HasPrimeInShortInterval` / `ShortIntervalStatement` / `PrimeGapBound` | normalized exponent statement conventions with explicit exponent, constant and “sufficiently large” threshold | definition | **[Statements.lean L62](Legendre/Layer5/Statements.lean#L62)** · **[L72](Legendre/Layer5/Statements.lean#L72)** · **[L81](Legendre/Layer5/Statements.lean#L81)** |
| `Legendre.hasPrimeInShortInterval_iff_primeGapBound` | interval form ↔ gap form with the same `θ` and `C` (for `θ ≥ 0`, `C ≥ 0`) | **proved** | **[Statements.lean L162](Legendre/Layer5/Statements.lean#L162)** |
| `Legendre.shortIntervalStatement_iff_exponentLimit` | normalized exponent `+ε` form ↔ the coarse conditional interface | **proved** | **[Statements.lean L258](Legendre/Layer5/Statements.lean#L258)** |
| `Legendre.legendre_eventually_of_shortIntervalStatement_lt_half` | normalized exponent `θ < 1/2` statement ⇒ Legendre eventually | **proved** | **[Statements.lean L266](Legendre/Layer5/Statements.lean#L266)** |
| `Legendre.*Paper_iff` (nine results) | each normalized exponent statement ↔ its coarse `Prop` | **proved** | **[Statements.lean L295](Legendre/Layer5/Statements.lean#L295)** |
| `Legendre.PNT.psi_classical_error` | ψ=x+O(x exp(−c√log x)), c>0 | **proved**; analytic proof adapted from PNT+ | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.primeCount_error_of_theta` | partial summation preserves the classical error scale | **proved**; new downstream bridge | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.pnt_classical_error` / `pnt_eventual_bound` | common classical ψ/θ/π−Li₂ error and eventual inequalities | **proved**; constants existential | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.PNT.classicalError_isLittleO` / `exists_smoothed_truncated_formula` | sublinearity and exact finite-height smoothed contour decomposition | **proved**; zero-sum formula has a separate contour-dependent remainder bound | [PrimeNumberTheorem.lean](Legendre/PrimeNumberTheorem.lean) |
| `Legendre.Zeta.exists_truncated_explicit_formula` | ψ₀=x−∑m(ρ)x^ρ/ρ+E, with all critical-strip zeros through absolute height T | **proved**; contour-dependent remainder bound | [PerronExplicitBounds.lean](Legendre/PerronExplicitBounds.lean) |
| `Legendre.Zeta.unitZeroCount_le_log` / `zeroCount_increment_le_unitZeroCount` | multiplicity-weighted unit-height zero count of order log H | **proved**; H≥4, includes both sides of the critical line | [ZetaUnitCounting.lean](Legendre/ZetaUnitCounting.lean) |
| `Legendre.Zeta.exists_good_height_log_separation` / `exists_good_height_logDeriv_bound` | separation c/log H and ‖ζ′/ζ‖≤C(log H)² on both selected horizontal lines, Re(s)≥7/8 | **proved**; explicit positive c,C; H≥7 | [ZetaGoodHeightBounds.lean](Legendre/ZetaGoodHeightBounds.lean) |
| `Legendre.Zeta.exists_good_height_perron_horizontal_bound` | normalized horizontal Perron estimates for 7/8≤α≤σ | **proved**; integrability included; strengthened to Re(s)≥−1/8 below | [PerronGoodHeight.lean](Legendre/PerronGoodHeight.lean) |
| `Legendre.Zeta.exists_full_truncated_explicit_formula` | ψ₀=x−∑m(ρ)x^ρ/ρ−log(2π)+E, fixed Re(s)=−1/8 | **proved**; one absolute contour coefficient before H,T,σ,x; [exact bound](docs/perron-uniform-explicit-formula.md) | [PerronFullExplicit.lean](Legendre/PerronFullExplicit.lean) |
| `Legendre.PNT.pnt_hasPrimeIn_classical_interval` / `pnt_prime_gap_classical` | primes in classical-rate sublinear intervals and the natural-number gap interface | **proved**; coefficient one, c and threshold existential | [PrimeIntervals.lean](Legendre/PrimeIntervals.lean) |
| `Legendre.PNT.rpow_isLittleO_classicalError` / `classicalError_not_isBigO_rpow` | every fixed x^a, a<1, is asymptotically smaller than the error scale | **proved**; no fixed polynomial exponent inferred | [PrimeIntervals.lean](Legendre/PrimeIntervals.lean) |
| `Legendre.PNT.layer3_pnt_package` | one c>0 for ψ/θ/π error, sublinearity and coefficient-one prime intervals | **proved**; final Layer 3 import interface | [Layer3.lean](Legendre/Layer3.lean) |
| `Legendre.Density.norm_oscillatoryKernel_le` / `integral_exponentialSum_diagonal` | Exact mean-value diagonal and oscillatory cancellation for finite exponential sums | **proved**; pairwise injectivity required for cancellation | [ExponentialKernel.lean](Legendre/ExponentialKernel.lean), [ExponentialMeanValue.lean](Legendre/ExponentialMeanValue.lean) |
| `Legendre.Density.sum_inv_abs_log_gaps_le` / `meanValueError_le_energy` | Logarithmic-frequency row bound and Schur energy estimate | **proved**; explicit harmonic bounds | [DirichletSpacing.lean](Legendre/DirichletSpacing.lean), [ExponentialMeanValue.lean](Legendre/ExponentialMeanValue.lean) |
| `Legendre.Density.abs_integral_dirichletPolynomial_sub_diagonal_le` / `tendsto_dirichletPolynomial_mean_square` | Mean-square error ≤4NH_N E and limiting average E | **proved**; arbitrary complex coefficients, uniform endpoints | [DirichletMeanValue.lean](Legendre/DirichletMeanValue.lean) |
| `Legendre.Density.dirichlet_large_values_measure_le` | Continuous large-value measure ≤(length+4N(1+log N))E/V² | **proved**; A≤B, V>0; separated-point counts remain open | [DirichletLargeValues.lean](Legendre/DirichletLargeValues.lean) |
| `Legendre.Zeta.HasZeroDensityEstimate` / `hasZeroDensityEstimate_of_log_bound` | Uniform σ density convention and log-loss absorption | Prop definition / **proved conditional bridge**; no exponent asserted | [ZeroDensity.lean](Legendre/ZeroDensity.lean) |
| `Legendre.Zeta.zeroDensityCount_rational_near_one` | N(1−1/(4000000 log T),T)≤N(3) for T≥3 | **proved**; fixed compact count, not a fixed-strip density theorem | [ZeroDensity.lean](Legendre/ZeroDensity.lean) |
| `Legendre.LargeSieve.additive_large_sieve` / `separated_realPhase_large_sieve` | Finite additive large sieve with M+Q² and circle-separated form | **proved**; zero-length/empty-range cases included; attributed source slice | [LargeSieve.lean](Legendre/LargeSieve.lean) |
| `Legendre.Density.dirichlet_large_sample_card_le` / `halasz_montgomery_card_le` | Actual separated-point counts and the finite Gram large-value inequality | **proved**; spacing/threshold or off-diagonal kernel hypotheses explicit | [DirichletSampling.lean](Legendre/DirichletSampling.lean), [HalaszMontgomery.lean](Legendre/HalaszMontgomery.lean) |
| `Legendre.Zeta.exists_density_separated_representatives` | One-separated zero representatives retain the complete analytic multiplicity count | **proved**; one absolute logarithmic mass coefficient | [ZetaDensitySelection.lean](Legendre/ZetaDensitySelection.lean) |
| `Legendre.Zeta.zeroDensityCount_le_of_dirichlet_detector` | Explicit detector-to-density count reduction | **proved conditional theorem**; analytic detector property remains a hypothesis | [ZeroDetectionReduction.lean](Legendre/ZeroDetectionReduction.lean) |
| `Legendre.Zeta.zetaXi_square_equation` | Exact Gaussian identity Xi(s)²=I(s)+I(1−s), Re(s)=1/2 | **proved**; integrability, horizontal limits and central residue included | [XiSquareContour.lean](Legendre/XiSquareContour.lean) |
| `Legendre.Zeta.riemannZeta_fourth_le_smoothed` | Critical-line pointwise fourth power bounded by one normalized Gaussian contour | **proved**; contour mean and sixth-log fourth moment now supplied; sharp log^4 remains open | [XiSquareContour.lean](Legendre/XiSquareContour.lean) |
| `Legendre.Density.Detector.Smooth.detectorMean_eq_integral` | Compact Möbius detector equals its initial Mellin contour, with absolute norm control | **proved**; the compensated shift is supplied below | [Layer4/DetectorIntegral.lean](Legendre/Layer4/DetectorIntegral.lean) |
| `Legendre.Density.Detector.Smooth.detectorMean_at_zero` / `detector_high_zero_dichotomy` | Exact critical-line shift with principal-pole contribution; polynomial-or-integral alternative at explicit high ordinates | **proved**; now used in the closed Ingham proof | [Layer4/DetectorShift.lean](Legendre/Layer4/DetectorShift.lean) · [DetectorAlternative.lean](Legendre/Layer4/DetectorAlternative.lean) |
| `Legendre.Density.Oscillation.halasz_complex_large_values_two_term` / `Moment.packed_critical_mass_halasz` | Unconditional two-term large-value count and improved actual mollifier/critical-mass moments | **proved**; the stronger curved Huxley target remains open | [HalaszTwoTermCount.lean](Legendre/Layer4/Exponential/HalaszTwoTermCount.lean), [HalaszCriticalMass.lean](Legendre/Layer4/HalaszCriticalMass.lean) |
| `Legendre.Density.Oscillation.halasz_block_complex_energy` | Actual logarithmic-phase cancellation, harmonic rows and Halasz energy with independently varying real parts | **proved**; the stronger curved Huxley target remains open | [Exponential/HalaszComplex.lean](Legendre/Layer4/Exponential/HalaszComplex.lean) |
| `Legendre.Zeta.ingham_density_epsilon` / `Literature.layer4_ingham_comparator` | Ingham 1940 curved density, `3(1−σ)/(2−σ)+ε`, with all analytic multiplicities | **proved**, uniform σ∈[1/2,1], all T≥2; not the 1937 prime-gap theorem | [Layer4/InghamDensity.lean](Legendre/Layer4/InghamDensity.lean) |
| `Legendre.Density.Moment.weighted_zeta_fourth_moment` / `packed_critical_mass_fourth` / `integral_alternative_count` | Whole-line weighted moments, separated critical-mass fourth power and integral-branch cubic count | **proved**, actual integrals; both branches now yield Ingham density | [Layer4/WeightedZetaMoment.lean](Legendre/Layer4/WeightedZetaMoment.lean) · [IntegralAlternative.lean](Legendre/Layer4/IntegralAlternative.lean) |
| `Legendre.Zeta.zeta_fourth_moment_log_six` / `zeta_fourth_moment_epsilon` | Actual critical-line fourth moment `O(T log^6 T)` on `[-T,T]`, and height exponent `1+ε` on `[0,T]` | **proved**, for all `T≥2`; sharp `log^4`, Huxley and Guth–Maynard density remain open | [Layer4/ZetaFourthMoment.lean](Legendre/Layer4/ZetaFourthMoment.lean) |

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
  Baker–Harman 1996, Baker–Harman–Pintz 2001 — coarse `Prop`s and normalized exponent
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
  **[normalized exponent forms in Layer5.lean](Legendre/Layer5.lean)**;
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
| 3 | Prime-counting foundations: `π(x)`, `ψ(x)`, partial summation, Perron's formula, truncated explicit formula, PNT with error term | turns zeta information into prime-counting information | **documented scope complete**: half-weighted Perron inversion/error, partial summation, classical ψ/θ/π PNT error terms, a finite multiplicity-weighted zero-sum formula with fixed negative edge, evaluated origin residue and uniform full-contour bound, and sublinear classical-rate prime intervals; [exact uniform formula](docs/perron-uniform-explicit-formula.md) |
| 4 | Zero-density theory: `N(σ,T)`, Ingham's zero-density estimate, Huxley's `12/5` estimate, large sieve, mean-value estimates for Dirichlet polynomials (including Guth–Maynard-type large-value estimates) | supplies the density input for short intervals | **proved here**: uniform density-exponent convention, near-one count, `O(N)` Dirichlet-polynomial mean-square error from a proved Hilbert inequality; continuous large-value measure, finite additive large sieve, optimized separated samples, actual two-branch zero detection and varying-real-part sample bounds **proved**; **roadmap acceptance complete**: Ingham 1940 and global Huxley `12/5` proved, with actual large-value input; stronger curved Huxley/Guth–Maynard and sharp `log^4` remain explicit open targets; [scope](docs/layer4-huxley-density.md) |
| 5 | Short-interval theorems: Ingham 1937, Huxley 1972, weighted zero-density + sieve for Baker–Harman 1996 and Baker–Harman–Pintz 2001 | gives `p_{n+1} - p_n ≪ p_n^{θ+ε}` | **statement level formalized here** in **[Layer5.lean](Legendre/Layer5.lean)**: normalized exponent `+ε`, constant and threshold conventions, interval ↔ gap equivalence, and equivalence to the coarse `Prop`s in **[Conditional.lean L70](Legendre/Conditional.lean#L70)**; the deep proofs are **not in mathlib** |
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
   the gap form, and connects each normalized exponent statement to its coarse `Prop`.
   The analytic proofs are still open.
3. ✅ **Layer 3 — complete, including the uniform full contour.** Classical PNT
   errors, partial summation, Perron inversion, the multiplicity-weighted
   zero-sum formula with `−log(2π)` and a uniform complete-contour bound,
   and classical-rate sublinear prime intervals are proved.
   [Completion evidence and limits](docs/layer3-completion.md).
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
  ZetaGoodHeight*.lean Quantitative zero avoidance and horizontal log-squared bounds
  PerronGoodHeight.lean Horizontal Perron estimates at selected heights
  PerronFullExplicit.lean Fixed negative contour, origin residue and uniform explicit formula
  Layer3.lean         Complete Layer 3 import interface and common-constant theorem
  Layer4.lean         Initial density and quantitative mean-value interface
  DirichletMeanValue.lean Explicit 4NH_N mean-square error for Dirichlet polynomials
  DirichletLargeValues.lean Continuous-time large-value measure bounds
  ZeroDensity.lean    Uniform exponent convention, log-loss bridge and near-one count
  PrimeIntervals.lean Classical-rate prime intervals, gaps and scale comparisons
  PrimeNumberTheorem.lean Layer 3: classical ψ/θ/π error terms and partial summation
  PNT/               selected Apache-2.0 PNT+ proof dependencies
  ExplicitBounds.lean Layer 1: interval API, (x,2x], Chebyshev θ/ψ/π bounds
  Layer5.lean        Stable public entry point for Layer 5
  Layer5/           Short-interval specifications and future analytic proofs
  Layer6/           Reserved: finite verification and certificates
  Layer7/           Reserved: almost-prime and sieve proofs
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

<details open>
<summary><strong>Upstream sources and adaptation details</strong></summary>

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
  Layer 4 additionally selects Robby Sneiderman's positive-half-plane digamma
  series and tail helpers from upstream
  `Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean`, at the same commit,
  into [`Legendre/PNT/Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean`](Legendre/PNT/Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean).
  The original contributor notice and the same Apache-2.0 license are retained.
  See [provenance and limits](docs/pnt-provenance.md).
* **[openai/math](https://github.com/openai/math)** — Apache-2.0,
  pinned commit `4eaee87548250b2682affda7d05d947c05554bae`.
  Twenty-three selected modules under [`Legendre/LargeSieve/`](Legendre/LargeSieve/)
  adapt the finite additive large-sieve and separated-sampling proof dependency slices.
  Twenty-two come from
  `lean/OAI/NumberTheory/Ostmann/`: nineteen `Preliminaries` modules,
  `Quadratic/KernelEigenvalueBound.lean`, `Characters/SkewKernelSquare.lean`,
  and `ZeroDensity/SeparatedSelection.lean`.
  The additional sampling module comes from
  `lean/OAI/NumberTheory/Jacobsthal/Estimates/SeparatedSampling.lean`.
  The slice covers circle separation, the finite cosecant Hilbert inequality,
  Hermitian matrix and duality arguments, and reduced-fraction specialization.
  Imports, namespaces and Lean/mathlib v4.35.0 compatibility are adapted;
  upstream source notices are included in every ported file. The original license
  is retained in [`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt).
  [`GramLargeValues.lean`](Legendre/GramLargeValues.lean) generalizes the
  same source project's `Preliminaries/SymmetricQuadraticBound.lean` argument;
  [`WeightedSeparation.lean`](Legendre/WeightedSeparation.lean) generalizes its
  `ZeroDensity/SeparatedSelection.lean` cover argument to natural weights.
  [`ReciprocalHilbert.lean`](Legendre/ReciprocalHilbert.lean) generalizes the
  finite kernel/spectral argument from `Preliminaries/CosecantHilbertBound.lean`
  and `CircleSeparatedPoints.lean` to separated real frequencies.
  [`SeparatedMeanValue.lean`](Legendre/SeparatedMeanValue.lean) adapts the
  `SievePhaseGram.lean` phase-twisting argument to this reciprocal kernel.
  The zero-detector coefficient work additionally adapts
  `lean/OAI/NumberTheory/Ostmann/ZeroDensity/Mollifier.lean` to
  [`ZeroDetector/Mollifier.lean`](Legendre/ZeroDetector/Mollifier.lean), and
  `FiniteDetector.lean` to
  [`ZeroDetector/FiniteMollifier.lean`](Legendre/ZeroDetector/FiniteMollifier.lean),
  at the same pinned commit and under the same retained Apache-2.0 license.
  The latter removes the character twist and proves the untwisted finite identity.
  [`ZeroDetector/ActualZetaDetector.lean`](Legendre/ZeroDetector/ActualZetaDetector.lean)
  adapts the length choice and small-product organization of `DetectorLength.lean`
  and `ActualDetector.lean`, retaining zeta's additional pole branch.
  [`ZeroDetector/BetaVariation.lean`](Legendre/ZeroDetector/BetaVariation.lean)
  adapts `BetaVariation.lean`, while
  [`ComplexDirichlet.lean`](Legendre/ComplexDirichlet.lean) adapts the
  character-independent differentiation argument from `BetaDerivative.lean`.
  The coefficient-energy slice also adapts
  `Arithmetic/FrequencyLCM.lean`, `Arithmetic/DivisorSquareMean.lean` and
  `ZeroDensity/CoefficientEnergy.lean` to
  [`ZeroDetector/FrequencyLCM.lean`](Legendre/ZeroDetector/FrequencyLCM.lean),
  [`ZeroDetector/DivisorSquareMean.lean`](Legendre/ZeroDetector/DivisorSquareMean.lean)
  and [`ZeroDetector/CoefficientEnergy.lean`](Legendre/ZeroDetector/CoefficientEnergy.lean).
  The Gamma-quotient slice under [`Legendre/GammaBounds/`](Legendre/GammaBounds/)
  additionally adapts `ZeroDensity/LogNormDerivative.lean`, `DigammaTailEstimate.lean`,
  `SharpDigammaStrip.lean`, `GammaNormDerivative.lean`, `SharpGammaHorizontal.lean`,
  `SharpGammaVertical.lean`, `SharpGammaRealShift.lean` and `GammaStripBound.lean`.
  [`GammaBounds/GaussianWeight.lean`](Legendre/GammaBounds/GaussianWeight.lean)
  specializes the scalar Gaussian-weight argument in `ZeroDensity/CharacterGammaShift.lean`.
  [`XiSquareKernel.lean`](Legendre/XiSquareKernel.lean) generalizes the Gaussian
  square/normalization organization in `DensityCompletedSquare.lean` and
  `DensitySquareGaussian.lean`, using a locally proved entire xi function.
  [`XiGaussianEnvelope.lean`](Legendre/XiGaussianEnvelope.lean) generalizes
  `DensityGaussianEnvelope.lean` to the sixth-degree polynomial envelope
  needed after removing the two completed poles.
  [`XiSquareContour.lean`](Legendre/XiSquareContour.lean) adapts the contour,
  reflection and conjugation organization of `ZeroDensity/DensitySquareContour.lean`,
  `DensitySquareEquation.lean` and `DensitySquareConjugation.lean` to this entire
  xi numerator, reusing the already credited PNT+ rectangle residue API.
  The digamma tail imports only the selected PNT+ series proof, avoiding the
  unrelated character and zero-free-region dependency chain.
  All paths are under upstream `lean/OAI/NumberTheory/Ostmann/` and use the
  same pinned commit and retained license.
  The selected large-sieve slice builds and is included in the project-wide axiom audit;
  [exact inventory, adaptations and validation](docs/openai-math-provenance.md).
  The compact detector proves Ingham 1940 and global Huxley 12/5 density;
  the stronger curved Huxley benchmark remains open.

The fourth-moment and compact-detector proofs additionally adapt the following files from
**[openai/math](https://github.com/openai/math)**, pinned commit
`4eaee87548250b2682affda7d05d947c05554bae`, under
`lean/OAI/NumberTheory/Ostmann/ZeroDensity/`.
License: **Apache-2.0**, retained in
[`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt).
Every destination is under `Legendre/Layer4/` and retains its source notice.
The moment specialization removes character families, uses the local xi
kernel, raw ordinates and a wider Gaussian. The compact detector specializes
the initial contour to zeta and retains the principal pole in its proved shift.
No additional PNT+ source is copied.

| Upstream / 上游 | Destination / 本地文件 |
|---|---|
| `DensityDetectorDyadicCover.lean` | [DetectorDyadicCover.lean](Legendre/Layer4/DetectorDyadicCover.lean) |
| `DensityDetectorPolynomial.lean`, `DensityDetectorBlocks.lean` | [DetectorPolynomial.lean](Legendre/Layer4/DetectorPolynomial.lean) |
| `DensityFiniteBlockSquare.lean` | [FiniteBlockSquare.lean](Legendre/Layer4/FiniteBlockSquare.lean) |
| `DensityPolynomialAlternative.lean` | [PolynomialAlternative.lean](Legendre/Layer4/PolynomialAlternative.lean) |
| `DensityBalanceParameters.lean`, `DensityPolynomialBalance.lean` | [DensityBalance.lean](Legendre/Layer4/DensityBalance.lean) |
| `DensityPolynomialBalanced.lean`, `DensityIntegralBalanced.lean` | [BalancedAlternatives.lean](Legendre/Layer4/BalancedAlternatives.lean) |
| `DensitySeparatedCount.lean` | [SeparatedShellDensity.lean](Legendre/Layer4/SeparatedShellDensity.lean); its finite branch assembly is reused internally in [HuxleyShellDensity.lean](Legendre/Layer4/HuxleyShellDensity.lean), with the same pinned source and license |
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
  Apache-2.0.  Used as the general library.  `Legendre.bertrand` is a thin
  re-export of mathlib's `Nat.exists_prime_lt_and_le_two_mul`; no other
  mathlib proof is copied into this repository.



The exponential-sum derivative tests additionally adapt **openai/math**,
pinned commit `4eaee87548250b2682affda7d05d947c05554bae`, source directory
`lean/OAI/NumberTheory/EgyptianFractions/`, **Apache-2.0**. The retained license
is [`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt).
Imports are restricted to the required mathlib modules; namespaces and module
visibility are adapted. The phase-sum arguments are retained.

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

Interval subdivision, absorption-scale optimization, the two-term count, finite
dyadic moment summation and the improved actual Möbius/critical-mass moments
are local deductions in this repository; this step copies no additional upstream code.

### Divisor growth for polynomial powers

The coefficient-power work additionally adapts the following files from
[openai/math](https://github.com/openai/math), pinned commit
`4eaee87548250b2682affda7d05d947c05554bae`, Apache-2.0. Source directory:
`lean/OAI/NumberTheory/Ostmann/Arithmetic/`. Imports, namespaces and module
visibility are adapted; the retained license is
[`licenses/openai-math-Apache-2.0.txt`](licenses/openai-math-Apache-2.0.txt).

| Upstream / 上游 | Destination / 本地文件 |
|---|---|
| [`DivisorGrowthLocal.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Arithmetic/DivisorGrowthLocal.lean) | [DivisorGrowthLocal.lean](Legendre/Layer4/Arithmetic/DivisorGrowthLocal.lean) |
| [`DivisorGrowth.lean`](https://github.com/openai/math/blob/4eaee87548250b2682affda7d05d947c05554bae/lean/OAI/NumberTheory/Ostmann/Arithmetic/DivisorGrowth.lean) | [DivisorGrowth.lean](Legendre/Layer4/Arithmetic/DivisorGrowth.lean) |

</details>

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
