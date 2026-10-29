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
compact-height neighborhood. Effective zero-free regions, multiplicity-weighted
zero-counting estimates and Perron remain open. Layer 2 acceptance is **not** fully met.

**Counting foundations (2026-10-29).** `Legendre/ZetaCounting.lean` now defines
`NontrivialZero` in the open critical strip, `zeroCount` (`N(T)`) and
`zeroDensityCount` (`N(σ,T)`), including analytic multiplicities.
The height convention is `0 < Im(s) ≤ T`; the density cutoff is `σ ≤ Re(s)`.
Finite analytic orders away from the pole and positive multiplicities at
critical-strip zeros are proved before the natural-valued sums are used.
Finiteness, height monotonicity, antitonicity in σ, positivity/existence
and the nonpositive-height / outside-strip boundary cases are proved.
The definitions part of the first acceptance criterion is met; quantitative
zero counting, the logarithmic zero-free region and Perron remain open.

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

**Acceptance criteria.**

* a definition of the nontrivial zeros and a counting function `N(T)` /
  `N(σ,T)`;
* a proved zero-free region of the form
  `σ > 1 - c / log t` (with explicit `c` and threshold);
* a proved explicit formula or a Perron-type truncated formula;
* all axioms audited.

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

**Current state.** mathlib has `π`, `ψ`, `θ` and some relations, but not the
needed Perron/PNT error term.

**Acceptance criteria.**

* a theorem `ψ(x) = x + O(...)` with an explicit error term;
* a theorem `π(x) = li(x) + O(...)`;
* a documented comparison with the classical de la Vallée Poussin error
  `x exp(-c sqrt(log x))`;
* no hidden axioms in the analytic estimates.

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
