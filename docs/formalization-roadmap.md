# Formalization roadmap: from the reduction layer to proof-level results

This is the detailed companion to the roadmap table in `README.md`.  It states
what must be formalized, in what order, and what counts as “done” for each
layer.  Nothing here is claimed as already done unless it appears in
`docs/proof-map.md` as **proved**.

## Guiding rules

1. **No `sorry`, no `axiom`, no `constant`, no `opaque`, no `unsafe`.**
   Deep results must be proved, not assumed.  Open statements stay as
   `Prop`-valued definitions and are clearly labelled.
2. **No vacuous proofs.**  Do not introduce `False`, `False.elim`, `absurd`, or
   an inconsistent hypothesis.  The audit rejects these.
3. **One paper at a time.**  Do not claim Baker–Harman–Pintz before Ingham and
   Huxley are formalized.  The dependency graph is real.
4. **Every new theorem gets a `#print axioms` entry** in
   `Legendre/Audit.lean`, and every new statement gets a row in
   `docs/proof-map.md`.
5. **No PDFs** and no long verbatim excerpts of copyrighted papers.  Cite DOI
   or arXiv.

## Layer 0 — Definitions and elementary reductions

**Scope.** `LegendreAt`, `Conjecture`, the square/gap equivalence, the
`θ < 1/2` reduction, and the `P₁ ↔ Legendre` equivalence.

**Status.** Done in this repository.

**Acceptance criteria.**

* `lake build` succeeds;
* the audit reports only the three standard axioms;
* `docs/proof-map.md` marks every declaration as `proved`, `definition`, or
  `statement only`.

## Layer 1 — Bertrand and explicit Chebyshev bounds

**Scope.** Bertrand's postulate, Chebyshev's `ψ` and `θ`, and explicit bounds
for `π(x)`, `ψ(x)`, `θ(x)` strong enough to recover classical interval
estimates.

**Status (2026-10-17). Complete for Nagura.**

`Legendre/ExplicitBounds.lean` proves:

* `HasPrimeIn x h`, the clean interval predicate
  “there is a prime in `(x, x+h]`”;
* `hasPrimeIn_self`: for every real `x ≥ 1`, `(x, 2x]` contains a prime
  (the sharp form of Bertrand's postulate, applied to `⌊x⌋`);
* `exists_prime_of_theta_lt` and `hasPrimeIn_of_theta_gap`: a strict increase
  of `θ` from `x` to `y` forces a prime in `(x, y]`;
* `theta_upper_explicit`, `theta_lower_explicit`;
* `psi_upper_explicit`, `psi_lower_explicit`;
* `pi_lower_explicit`, `pi_upper_explicit`.

`Legendre/Nagura.lean` (with the modules in `Legendre/Nagura/`) now proves
**Nagura's theorem** (J. Nagura, Proc. Japan Acad. **28** (1952), 177--181):
for every real `x ≥ 25`, the interval `(x, 6x/5]` contains a prime
(`nagura_hasPrimeIn`); equivalently there is a prime `p` with `n < p` and
`5p < 6n` for every natural `n ≥ 25` (`nagura_prime_gap`).  The formalization
follows Nagura's argument:

* `naguraChebyshevSum_eq_log_factorial`: the Ramanujan/Nagura identity
  `∑_{m≤n} ψ(n/m) = log n!`;
* two-sided explicit Stirling bounds for factorials and the weighted Chebyshev
  combinations with weights `1,2,3,7,43,1806` and `1,2,3,5,30`;
* explicit bounds `0.916 n < ψ(n) < 1.086 n`
  (`psi_nat_gt_0_916_mul`, `psi_nat_lt_1_086_mul`);
* a kernel-checked finite prime chain covering `25 ≤ n < 16 000 000`;
* the analytic tail `n ≥ 16 000 000` via the Chebyshev `ψ`/`θ` bridge.

The code under `Legendre/Nagura/` is adapted from the MIT-licensed project
<https://github.com/ShouqiaoW/erdos> at commit
`d28713ac8245ca86a686b8c67370a8d19d81b242`.  The original MIT license is
retained in `Legendre/Nagura/LICENSE`.

**What is still missing in Layer 1.**

Dusart-type explicit PNT-strength bounds are **not** formalized: for example
`ϑ(x) − x < x/36260` for all `x > 0`, `|ϑ(x) − x| ≤ 0.2 x / log²x` for
`x ≥ 3 594 641`, and a prime in `(x, x + x/(25 log² x)]` for `x ≥ 396 738`
(Dusart 2010).  These require a formalized explicit prime number theorem with
a zero-free region; see Layers 2--3.

**Acceptance criteria.**

* a new module `Legendre/ExplicitBounds.lean` proves at least one explicit
  short-interval statement with a named constant and range — **met**
  (`(x, 2x]` for `x ≥ 1`) — and `Legendre/Nagura.lean` proves the sharper
  `(x, 6x/5]` for `x ≥ 25` — **met**;
* the statement is compared against the published constant in
  `docs/literature.md` — see the Bertrand and Nagura rows;
* no `native_decide` without an explicit soundness note (or a kernel-checked
  certificate) — **met** (no `native_decide` used).

## Layer 2 — Riemann zeta foundations

**Scope.** Euler product, analytic continuation, functional equation,
non-vanishing on `Re(s) = 1`, a zero-free region, the argument principle, and
bounds for `ζ'/ζ`.

**Why.** Every zero-density theorem and every short-interval PNT proof starts
from these.

**Current state (2026-10-29).** `Legendre/Zeta.lean` integrates proved
mathlib v4.35.0 absolute convergence, Euler products, analytic continuation,
the completed functional equation, nonvanishing on `Re(s) ≥ 1` (excluding
the pole), and finiteness of distinct zeros on compact sets. The new
`exists_zero_free_strip` derives a positive-width strip at every fixed height
by compactness of a vertical segment and closedness of the zero set.
Its width is non-effective and height-dependent, **not** a `c/log T` estimate.
The total function's value at 1 is not an analytic extension through the pole.
See [provenance](zeta-provenance.md) for exact upstream mappings.

The first two suggested slices below are now integrated from mathlib;
the boundary nonvanishing part of slice 3 is integrated, with a qualitative
compact-height neighborhood. The effective logarithmic region and fixed-x
Perron truncation are now proved below, meeting the four acceptance criteria.
The wider Layer 2 suggested slice on global zero-counting bounds is now
proved in `ZetaGlobalCounting.lean` as N(T)=O(T log T).

**Counting foundations (2026-10-29).** `Legendre/ZetaCounting.lean` now defines
`NontrivialZero` in the open critical strip, `zeroCount` (`N(T)`) and
`zeroDensityCount` (`N(σ,T)`), including analytic multiplicities.
The height convention is `0 < Im(s) ≤ T`; the density cutoff is `σ ≤ Re(s)`.
Finite analytic orders away from the pole and positive multiplicities at
critical-strip zeros are proved before the natural-valued sums are used.
Finiteness, height monotonicity, antitonicity in σ, positivity/existence
and the nonpositive-height / outside-strip boundary cases are proved.
The definitions part of the first acceptance criterion is met; quantitative
global zero counting is now proved below as N(T)=O(T log T); the logarithmic zero-free region and fixed-x Perron truncation are also proved.

**Logarithmic derivative milestone (2026-10-29).**
`Legendre/ZetaLogDerivative.lean` reuses the proved, absolutely convergent
von Mangoldt representation of `-ζ′/ζ` for `Re(s)>1`. It proves a
convergent-series majorant on every closed half-plane `Re(s)≥σ>1`, then
the explicit bound `|ζ′/ζ(s)| ≤ π²/6` for `Re(s)≥3` via `Λ(n)≤n` and the
Basel sum. This is a bound well to the right of the critical strip, not
the near-critical-line estimate needed for a logarithmic zero-free region.
The same module proves `∃ σ, 0<σ ∧ σ<1 ∧ N(σ,T)=0` at every fixed height,
by moving the closed density cutoff strictly inside the earlier open
zero-free strip. No effective dependence on T or Perron formula is proved.

**Every right half-plane (2026-10-29).** `Legendre/ZetaHalfPlane.lean`
proves `|ζ′/ζ(s)| ≤ (2/ε)(1+2/ε)` for `ε>0` and `Re(s)≥1+ε`.
For `0<ε≤1` it also proves the simpler `6/ε²` bound. The proof uses
`Λ(n)≤log n≤n^a/a` with `a=ε/2`, followed by an integral-test estimate
`∑ n^(-p)≤1+1/(p-1)` for `p>1`. This is explicit control arbitrarily
close to 1 from the right, but does not provide an effective region to the
left of 1, the estimates on zero-counting contours, or Perron's formula.
The previously stated `π²/6` bound remains available for `Re(s)≥3`.

**Local pole structure (2026-10-29).** `Legendre/ZetaPole.lean` fills the
removable singularity of `(s-1)ζ(s)` with the residue value 1, proves the
updated function H analytic at 1, and transfers the logarithmic product rule
off 1. The regular part `ζ′/ζ(s)+1/(s-1)` tends to `logDeriv H 1`.
Consequently `(s-1)ζ′/ζ(s)→-1` and `(s-1)(-ζ′/ζ(s))→+1` in the
punctured complex neighborhood. The regular part is locally bounded, giving
`|ζ′/ζ(s)|≤1/|s-1|+C` for some C>0 and some neighborhood.
Neither C nor the neighborhood radius is explicit. This does not extend ζ
holomorphically through 1, evaluate the finite regular-part constant, prove
a high-height zero-free region, or supply a Perron contour formula.

**Forward Abel and weighted kernel (2026-10-30).**
`Legendre/PerronFoundation.lean` identifies the von Mangoldt partial sums
with ψ, proves their O(n) bound from the existing Chebyshev inequality, and
specializes mathlib's proved Abel representation to
`-ζ′/ζ(s)=s∫₁∞ψ(t)t^(-s-1)dt` for `Re(s)>1`.
The integrand's absolute integrability is proved separately, using the
measurability of the monotone ψ function and the majorant
`(log 4+4)t^(-Re(s))` on t>1. For x>0, the weight x^s/s is continuous at 1,
and the weighted kernel satisfies `(s-1)(-ζ′/ζ(s))x^s/s→x`.
These are a forward transform and a local pole-coefficient limit, not an
inverse transform, a contour-integral evaluation or a truncation/error theorem.
This module alone does not meet the Perron criterion; `PerronError.lean` now supplies a proved truncated formula.

**Local Perron contour (2026-10-30).** `Legendre/PerronContour.lean`
constructs `F(x,s)=(1-(s-1)logDeriv H(s))x^s/s`, analytic at 1 for x>0,
with F(x,1)=x and K(x,s)=F(x,s)/(s-1) locally off 1.
Cauchy's integral formula then gives `∮ K(x,s) ds=2πix` on every sufficiently
small positively oriented circle about 1. The radius is non-effective.
This evaluates the local pole contribution; it does not move a rectangular
contour or prove inversion, truncation errors, or the Perron acceptance criterion.

**Acceptance criteria.**

* a definition of the nontrivial zeros and a counting function `N(T)` /
  `N(σ,T)`;
* a proved zero-free region of the form
  `σ > 1 - c / log t` (with explicit `c` and threshold);
* a proved explicit formula or a Perron-type truncated formula;
* all axioms audited.

| Layer 2 acceptance item | Current status |
|---|---|
| Nontrivial zeros and multiplicity-weighted N(T), N(σ,T) definitions | proved |
| Effective logarithmic zero-free region, explicit c and threshold | **proved** in `ZetaZeroFree.lean`: c=1/2000000, threshold 3 |
| Explicit formula or truncated Perron formula | **proved** in `PerronError.lean`, fixed-x error O(1/T) |
| Audit of implemented theorems | `Legendre/Audit.lean` and `scripts/audit.py`; all new declarations included |

**Finite vertical integrals (2026-10-30).** `Legendre/PerronTruncated.lean`
proves continuity of K on Re(s)>1 and integrability of its parametrization
on every finite height interval. It defines
`P(x,σ,T)=(2π)⁻¹∫[-T,T]K(x,σ+it)dt`, with x>0 and σ>1 for the proved bounds.
For `B(σ)=(2/(σ-1))(1+2/(σ-1))`, the pointwise bounds are
`|K|≤B(σ)x^σ/σ` and `|K|≤B(σ)x^σ/|t|` for t≠0. For T≥0,
`|P|≤(2π)⁻¹(B(σ)x^σ/σ)(2T)`. This is only a crude finite-height bound,
not a bound on `P-ψ`, and does not establish infinite-line convergence.
The truncated-Perron criterion is now met by `PerronError.lean` below.

**Finite series exchange (2026-10-30).** `Legendre/PerronSeries.lean`
proves that the weighted von Mangoldt series can be integrated term by term
on any finite vertical segment with σ>1 and x>0. The dominating sequence is
`‖LSeries.term Λ σ n‖ x^σ/σ`, independent of height and summable in n.
Continuity of every term gives measurability; a constant function bounds
the sum on each finite interval. Dominated convergence proves the exchange,
and the integrated terms are separately proved absolutely summable.
Writing `J(y,σ,T)=(2π)⁻¹∫[-T,T]y^(σ+it)/(σ+it)dt`, the result is
`P(x,σ,T)=∑ Λ(n)J(x/n,σ,T)`, including the zero-index convention.
The scalar kernel's infinite-height values and passage through the outer
series are now proved below. The fixed-x truncation-error bound is proved in
`PerronError.lean`, meeting the truncated-Perron acceptance criterion.

**Scalar endpoint (2026-10-30).** `Legendre/PerronKernel.lean` evaluates
the boundary y=1 as `J(1,σ,T)=arctan(T/σ)/π` for σ>0 and every real T.
The real and imaginary parts of the integrable reciprocal vertical kernel
are integrated using the arctangent and logarithm primitives. Its limit
as T→∞ is 1/2; for T>0 the error is at most σ/(πT). This supplies the
half-weight at a prime-power endpoint, without yet reconstructing ψ.
The later scalar inversion milestone handles y<1 and y>1, and
`PerronInversion.lean` reconstructs ψ, and `PerronError.lean` now proves
a fixed-x O(1/T) truncation error, meeting the Perron criterion.

**Oscillatory numerator (2026-10-30).** `Legendre/PerronOscillation.lean`
separates the real magnitude and oscillatory exponential for y>0. For
y≠1 the finite integral of y^(σ+it) has an explicit exponential primitive
and norm at most `2y^σ/|log y|`, uniformly in both endpoints and for any
real σ. This prepares an integration-by-parts argument with the reciprocal
vertical factor; it is not a bound on the full kernel's truncation error
and does not establish its infinite-height limit.

**Scalar convergence (2026-10-30).** `Legendre/PerronTail.lean` uses the
oscillatory primitive to integrate the reciprocal vertical factor by parts.
For y>0, y≠1 and σ>0, its derivative has norm at most 1/t² at positive
heights, and the primitive has constant norm y^σ/|log y|. Thus the remainder
is absolutely integrable on (1,∞), while the boundary term tends to zero.
The finite positive-half integrals converge. Conjugation symmetry gives
convergence of J(y,σ,T); the earlier endpoint theorem handles y=1.
The result is existence of a scalar limit for every positive y and σ,
not evaluation of that limit away from y=1, absolute integrability of the
original kernel, a full ψ reconstruction, or a truncation-error estimate.
The scalar inversion milestone below now identifies the limits as 0/1.
The outer-series limit and fixed-x truncation error are now controlled in
`PerronInversion.lean` and `PerronError.lean`; `ZetaZeroFree.lean` now also meets the effective zero-free-region criterion.

**Scalar Perron inversion (2026-10-30).** `Legendre/PerronShift.lean`
applies Cauchy-Goursat to a positive-half-plane rectangle. The horizontal
sides have norm at most `max(y^σ,y^ρ)|ρ-σ|/|T|`, so scalar kernel limits
are independent of the positive line. `Legendre/PerronZero.lean` bounds
the finite kernel uniformly in T≥0 by
`(y^σ/|log y|)(2+π)/(2πσ)` for y>0, y≠1, σ>0. If 0<y<1, moving the
line to the right forces the limit to zero.

`Legendre/PerronResidue.lean` uses the entire divided difference of y^s
at zero to remove the pole: off zero this is `(y^s-1)/s`. A rectangle
crossing zero therefore compares the weighted kernel with the y=1
reciprocal kernel. Reciprocal-base reflection turns the negative line
into the already proved y⁻¹<1 case, while the two endpoint half-weights
give total pole contribution 1. The unified theorem proves
`J(y,σ,T)→0,1/2,1` according as `y<1`, `y=1`, `y>1`, for every y,σ>0.
This scalar result now feeds the ψ inversion milestone below.

**Perron inversion for ψ (2026-10-31).** `Legendre/PerronInversion.lean`
bounds all scalar kernels uniformly in T≥0, including y=1. For n≥2x,
`|log(x/n)|≥log 2`, so the coefficient-weighted majorant is bounded by
a constant times the absolutely convergent von Mangoldt Dirichlet series
at σ>1. Finitely many exceptional indices cause no summability issue.
Tannery's theorem exchanges the infinite-height limit with the full series;
the zero-index coefficient is handled separately. Above x the limiting
coefficients vanish, below x they have full weight, and at x they have
half weight. Thus for every x>0 and σ>1:
`P(x,σ,T) → ψ(x) - (if floor(x)=x then Λ(floor(x))/2 else 0)`.
Specializations give ψ(x) for nonintegers and ψ(m)−Λ(m)/2 for positive integers.
This module proves qualitative Perron inversion. The next milestone adds
a quantitative finite-height bound.

**Truncated Perron formula (2026-10-31).** `Legendre/PerronError.lean`
proves `|P(x,σ,T)−ψ₀(x)|≤E(x,σ)/T` for all x>0, σ>1, T>0.
Here `ψ₀(x)=ψ(x)−(if floor(x)=x then Λ(floor(x))/2 else 0)`.
The explicit error series is summable before it is used. Its summand is
Λ(n) times `2(x/n)^σ/(π|log(x/n)|)` off the endpoint and σ/π at x/n=1.
The zero-index term is zero. Moreover `E≤U`, where
`U = ∑[n≤floor(2x)] Λ(n) perronScalarError(x/n,σ)
     + [2x^σ/(π log 2)] [2/(σ−1)] [1+2/(σ−1)]`.
Thus `norm_truncatedPerron_sub_psi_le_upper` gives a finite explicit bound.
This meets the truncated-Perron acceptance criterion; no uniform
short-interval PNT error or absolute infinite-line integrability is asserted.

**Effective zero-free-region inputs (2026-10-31).**
`Legendre/ZetaPositivity.lean` proves the 3–4–1 logarithmic-derivative
inequality on Re(s)>1 by summing the nonnegative trigonometric polynomial.
`Legendre/ZetaGrowth.lean` proves convergence and holomorphy of
`M(s)=∫₁∞{t}t^(−s−1)dt` on Re(s)>0, with `|M(s)|≤1/Re(s)`.
Abel summation first gives `ζ(s)=s/(s−1)−sM(s)` on Re(s)>1;
the identity principle for the pole-removed function extends this to
Re(s)>0, s≠1. In particular `|ζ(s)|≤|s|/|s−1|+|s|/Re(s)`;
when Re(s)≥1/2 and |Im(s)|≥1, `|ζ(s)|≤3|s|`.
The reciprocal Möbius series gives `|ζ(s)|≥1/2` on Re(s)≥2.
`Legendre/ZetaLocalBound.lean` deduces `|ζ|≤12(|t|+2)` on the radius-3/2
disk centered at 2+it for |t|≥3. Jensen's inequality bounds the zeros
with multiplicity in the radius-5/4 disk by
`log(24(|t|+2))/log(6/5)`. This is a local divisor count, not a global
N(T) estimate or a zero-free region.

**Effective logarithmic zero-free region (2026-10-31).**
`Legendre/ZetaZeroRemoval.lean` forms the finite local divisor factor P and
regularizes ζ/P on the radius-3/2 disk. It proves holomorphy there,
nonvanishing on the radius-5/4 disk, and the exact logarithmic-derivative
principal-part decomposition. If N is the factor degree, then
`|P(2+it)|≤(5/4)^N` and `|P|≥(1/4)^N` on the larger boundary.
`Legendre/ZetaRegularizedBound.lean` uses maximum modulus and center
normalization to bound the regularized ratio by `24(|t|+2)5^N`.
A normalized analytic logarithm has real part bounded by
`K log(24(|t|+2))`, where `K=1+log 5/log(6/5)`.
Borel-Carathéodory and Cauchy's estimate bound the remaining logarithmic
derivative within unit distance of 2+it by `144K log(24(|t|+2))`.
`Legendre/ZetaLogDerivativeLocal.lean` retains any selected zero's negative
principal part in -Re(ζ'/ζ); the other real principal parts are nonnegative.
`Legendre/ZetaPoleBounds.lean` proves
`-Re(ζ'/ζ(σ))≤1/(σ−1)+6` for `1<σ≤9/8`.

`Legendre/ZetaZeroFree.lean` combines these bounds with 3–4–1 positivity.
For |t|≥3 the local logarithm is at most 5 log|t| (and at doubled height
at most 10 log|t|). Put `C=4320K+18/log 2` and `δ=1/(4C log|t|)`.
A zero with real part greater than `1−δ/8` makes its principal part
incompatible with positivity at `σ=1+δ`. The resulting coefficient
`1/(32C)` is at least `1/2000000`, by rational inequalities for fixed
logarithms. Thus the final audited theorem is:

`|Im(s)|≥3 ∧ Re(s)>1−1/(2000000 log|Im(s)|) ⇒ ζ(s)≠0`.

**Global zero counting (2026-10-31).** `ZetaReflection.lean` proves that
reflection s↦1−s preserves analytic zero orders in the critical strip.
`rightHalfZero` sends every positive-height zero to Re(s)≥1/2, preserving
absolute height and multiplicity; its two branches have opposite signs
of height, so this map is injective on positive-height zeros.
`ZetaCountingDisks.lean` uses inner radius 13/8 and outer radius 7/4 at 2+it
for |t|≥4. The outer disk stays in Re(s)≥1/4, its zeta norm is at most
`20(|t|+2)`, and Jensen bounds its inner multiplicity by
`log(40(|t|+2))/log(14/13)`.
`ZetaCountingCover.lean` covers the right half of the full critical strip
by unit-height cells at centers ±(k+9/2), plus a fixed compact low-height
set |Im(s)|≤5. The latter has a proved finite total multiplicity B.

`ZetaGlobalCounting.lean` uses the multiplicity-preserving injection and
finite-union sum inequalities, allowing disk overlaps without undercounting.
For all T≥0 it proves
`N(T) ≤ B + 2(floor(T)+1) log(40(T+7))/log(14/13)`.
It then proves, for T≥7, `N(T)≤C T log T`, where
`C = B/log 2 + 4(1+log 80/log 2)/log(14/13) + 1 > 0`.
Thus `zeroCount_isBigO` establishes the global upper order O(T log T),
and the same crude bound holds for N(σ,T), uniformly in σ. The fixed
low-height count B is not numerically evaluated. No leading-term
Riemann–von Mangoldt asymptotic or σ-sensitive density estimate is claimed.

**The complete documented Layer 2 scope is now covered.** The four
acceptance items and all five suggested slices have the following evidence:

| Layer 2 scope / suggested slice | Proof evidence |
|---|---|
| Euler product and convergence | `Zeta.lean`: `euler_product`, `euler_product_limit`, `series_norm_summable` |
| Analytic continuation and functional equation | `Zeta.lean`: `analytic_off_pole`, `completed_functional_equation`; `ZetaReflection.lean`: zero-order reflection |
| Boundary nonvanishing and effective zero-free region | `Zeta.lean`: `nonvanishing`; `ZetaZeroFree.lean`: explicit c=1/2000000, height 3 |
| Bounds for ζ'/ζ | `ZetaHalfPlane.lean`, `ZetaLogDerivativeLocal.lean`, `ZetaPoleBounds.lean` |
| Perron formula | `PerronInversion.lean`, `PerronError.lean`: half-weight ψ and explicit fixed-x O(1/T) error |
| Argument principle counting interface | `ZetaArgumentPrinciple.lean`: high-disk circle integral counts analytic multiplicity, assuming a zero-free boundary |
| Global N(T) quantitative bound (suggested slice 4) | `ZetaGlobalCounting.lean`: global finite-cover bound and N(T)=O(T log T), counting both halves with multiplicity |
| Axiom audit | Every new theorem is listed in `Legendre/Audit.lean` and `docs/proof-map.md` |

This completes the documented Layer 2 scope without moving its global
counting task elsewhere. Zero-density theorems and the strong
PNT/short-interval error terms remain the later-layer goals already listed
below. The argument-principle interface and global counting bound have the
precise scope stated above; neither asserts an unproved asymptotic formula.

**Suggested PR slicing.**

1. Euler product and convergence;
2. analytic continuation and functional equation;
3. non-vanishing on `Re(s) = 1` and a weak zero-free region;
4. zero-counting and `N(T)` bounds;
5. `ζ'/ζ` bounds and Perron.

## Layer 3 — Prime counting and PNT with error term

**Scope.** `π(x)`, `ψ(x)`, partial summation, Perron's formula, truncated
explicit formula, and a PNT with an error term strong enough to feed
short-interval arguments.

**Current state (2026-11-01).** The classical PNT error terms for ψ, θ and π
are implemented in `Legendre/PrimeNumberTheorem.lean`, using the pinned,
Apache-2.0 PNT+ proof slice under `Legendre/PNT/`. The rate is
`x exp(-c sqrt(log x))`, with c>0 and existential coefficient/threshold.
See [provenance, proof outline and limits](pnt-provenance.md).

**Four acceptance items verified (2026-11-01):** full `lake build` (4,036 jobs)
and all 1,970 axiom targets passed, including the zero-sum specialization and
the quantitative good-height extension.

**Acceptance criteria and proof references.**

* `ψ(x)=x+O(x exp(-c sqrt(log x)))`: `Legendre.PNT.psi_classical_error`.
* `π(x)=Li₂(x)+O(x exp(-c sqrt(log x)))`: `Legendre.PNT.pnt_classical_error`;
  `Li₂(x)=∫₂ˣ dt/log t`. `pnt_eventual_bound` exposes eventual inequalities.
* The comparison with the classical de la Vallée Poussin error is documented
  in `docs/pnt-provenance.md`; `classicalError_isLittleO` proves sublinearity.
* All selected analytic proof dependencies and new bridge theorems are
  included in `Legendre/Audit.lean`, permitting only the three standard axioms.

**Broader scope checklist (separate from acceptance).**

| Scope item | Implementation / status |
|---|---|
| π, ψ, θ conventions | `primeCount`, mathlib `Chebyshev.psi/theta` |
| Partial summation | `primeCount_sub_logarithmicIntegral`, `primeCount_error_of_theta` |
| Perron inversion and fixed-x error | `PerronInversion.lean`, `PerronError.lean` (Layer 2) |
| Finite-height smoothed contour decomposition with tails | `exists_smoothed_truncated_formula`, `SmoothedChebyshevPull1/Pull2`, `ZetaBoxEval` |
| Truncated multiplicity-weighted zero-sum explicit formula | `halfWeightedPsi_explicit`, `exists_truncated_explicit_formula`; contour-dependent remainder, [exact statement and limits](perron-explicit-formula.md) |
| Quantitative good heights and horizontal estimates | `exists_good_height_log_separation`, `exists_good_height_logDeriv_bound`, `exists_good_height_perron_horizontal_bound`; explicit c/log H and C(log H)² for Re(s)≥7/8, [scope](zeta-good-heights.md) |
| Classical PNT error terms | `pnt_classical_error`, `pnt_eventual_bound` |

The classical error alone is larger than x^a for every fixed a<1 eventually.
It is useful analytic infrastructure, but does not itself prove the polynomial
short-interval results of later layers or Legendre's conjecture. No numerical
Dusart constants or Riemann-hypothesis estimates are claimed. The documented Layer 3 interfaces are implemented. The zero-sum remainder
retains its dependence on the chosen contour; a uniform log-squared
good-height error for the full contour remains a stronger refinement. Explicit constants
for zero separation and horizontal Re(s)≥7/8 bounds are now proved; these do
not bound the left part of the rectangle.
See [the formula and its limits](perron-explicit-formula.md).

## Layer 4 — Zero-density estimates

**Scope.** `N(σ,T)`, Ingham's estimate, Huxley's `12/5` estimate, the large
sieve, and mean-value/large-value estimates for Dirichlet polynomials
(including Guth–Maynard-type estimates).

**Why.** This is the input that makes short intervals possible.

**Acceptance criteria.**

* a formal definition of `N(σ,T)` and the zero-density exponent;
* Ingham's zero-density theorem with explicit constants/range;
* Huxley's theorem with `b = 12/5`;
* a clear statement of which large-value estimate is used, and a proof or a
  clearly labelled open `Prop` if it is not yet formalized.

**Do not** import a numerical zero-density bound as an axiom.  If a bound is
not proved, it must be a hypothesis of a conditional theorem, exactly as in
`Legendre/Conditional.lean`.

## Layer 5 — Short-interval theorems

**Order.**

1. Ingham 1937, `θ = 5/8` (and the zero-density route `577/925`);
2. Huxley 1972, `θ = 7/12 + ε`;
3. Heath-Brown–Iwaniec 1979, `θ = 13/23 + ε`;
4. Iwaniec–Pintz 1984 and Mozzochi 1986 refinements;
5. Baker–Harman 1996, `θ = 0.535`;
6. Baker–Harman–Pintz 2001, `θ = 0.525`.

**Status (2026-10-17). Statement level formalized.**

`Legendre/Layer5.lean` implements this milestone:

* `HasPrimeInShortInterval θ C`, `ShortIntervalStatement θ` and
  `PrimeGapBound θ C` encode the interval and gap conventions with explicit
  constants and explicit “sufficiently large” thresholds
  (`∃ X, 1 ≤ X, ∀ x ≥ X` and `∃ P, ∀ p ≥ P`);
* `hasPrimeInShortInterval_iff_primeGapBound` proves the interval and gap
  forms equivalent (same `θ` and `C`, for `θ ≥ 0`, `C ≥ 0`);
* `shortIntervalStatement_iff_exponentLimit` proves the paper-exact `+ε`
  form equivalent to the coarse exponent-limit `Prop` used by the conditional
  reduction in `Conditional.lean`;
* `legendre_eventually_of_shortIntervalStatement_lt_half` proves the
  statement-level reduction: any paper-exact `θ < 1/2` statement implies
  Legendre's conjecture for all sufficiently large `n`;
* the nine paper-exact declarations `HoheiselPaper`, `Ingham58Paper`,
  `Ingham577Paper`, `HuxleyPaper`, `HeathBrownIwaniecPaper`,
  `IwaniecPintzPaper`, `MozzochiPaper`, `BakerHarmanPaper`,
  `BakerHarmanPintzPaper` are `Prop` definitions, not theorems.  Each is
  proved equivalent to its coarse counterpart by `*Paper_iff`.

**The proofs of these nine deep analytic results remain open.**  Layer 5 is
“statement-level done”, not “proof-level done”.

**Acceptance criteria for each.**

* the exact statement matches the paper's quantifiers, `+ε` convention, and
  “sufficiently large” threshold;
* the proof uses only earlier layers plus published, formalized lemmas;
* the statement is linked to the paper's DOI/arXiv in
  `docs/literature.md`;
* the declaration is added to `Legendre/Audit.lean`;
* if the proof is incomplete, the declaration is a `Prop` definition, not a
  theorem.

**Proof-level status.** None of the nine results is proved.  The declarations
are `Prop` definitions; the only proved content is the statement-level
infrastructure listed above.

**A useful intermediate target — achieved at statement level.**  Ingham's
statement is encoded exactly (`Ingham58Paper`, `Ingham577Paper`), and the
generic consequence “the hypothesis implies a prime in every short interval of
the required length” is proved via the interval/gap bridge.  The analytic
content of Ingham remains open until Layer 2–4 is done.

## Layer 6 — Explicit finite verification

**Scope.** Verify Legendre for `n ≤ N` by a kernel-checked computation or a
certificate checker.

**Published record.** `n ≤ 7.05 × 10¹³` (Sorenson–Webster 2025), equivalent to
primality information up to about `4.97 × 10²⁷`.  The older `n ≤ 2 × 10⁹`
record corresponds to prime gaps computed up to `4 × 10¹⁸`.

**Acceptance criteria.**

* a certificate format (e.g. a list of primes covering each square interval,
  or a segmented-sieve transcript);
* a Lean checker that verifies the certificate against `Nat.Prime` (or a
  proved primality criterion);
* a proved theorem `Legendre_verified_up_to N` whose statement explicitly
  includes `N`;
* no `native_decide` without a kernel-checked certificate or a documented
  soundness argument.

**Realistic first PR.** A small checker for `n ≤ 10^4` with a generated
certificate is a good proof of concept.  Scaling to `10^13` is a separate
engineering project.

## Layer 7 — Almost primes and sieve theory

**Scope.** Sieve weights, the linear sieve, Buchstab's identity, Chen's `P₂`
theorem, and the Dudek–Johnston `P₄` result.

**Current state.** mathlib has `Nat.IsAtMostAlmostPrime` and `Ω`; this
repository proves the exact `P₁ ↔ Legendre` equivalence.  There is no sieve
theory in mathlib.

**Acceptance criteria.**

* a formalized sieve setup with a proved upper-bound sieve;
* a proved `P_k` square-interval theorem for some explicit `k`, with the same
  quantifier shape as the paper;
* a clear distinction between “for all sufficiently large `n`” and “for all
  `n ≥ 1`”;
* no claim of `P₂`/`P₃` for all `n` unless the paper actually proves it.

## Suggested PR sequence

1. README/roadmap maintenance and CI hardening.
2. ✅ Explicit Chebyshev bounds from mathlib — initial version in
   `Legendre/ExplicitBounds.lean`.
3. ✅ A prime-in-interval API with explicit `h` — `Legendre.HasPrimeIn` and
   `Legendre.hasPrimeIn_self`.
4. ✅ Paper-exact Layer 5 statements, the interval/gap bridge and the
   statement-level conditional consequence — `Legendre/Layer5.lean`.
5. ✅ Nagura's theorem `(x, 6x/5]` for `x ≥ 25` with explicit `ψ` bounds —
   `Legendre/Nagura.lean` (adapted from the MIT-licensed `ShouqiaoW/erdos`).
6. A verified small-range interval-certificate checker.
7. Zeta: Euler product and convergence.
8. Zeta: analytic continuation.
9. Zeta: non-vanishing on `Re(s) = 1`.
10. Zeta: weak zero-free region.
11. `N(T)` and zero counting.
12. Perron formula / truncated explicit formula.

Each PR must target `review` and pass `verify`.  See
[`PR_WORKFLOW.md`](PR_WORKFLOW.md).
