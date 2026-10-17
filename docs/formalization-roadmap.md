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

**What exists.** mathlib has `Nat.exists_prime_lt_and_le_two_mul`
(Bertrand) and `Mathlib.NumberTheory.Chebyshev` with `ψ`, `θ`, monotonicity,
and several elementary inequalities.  This repository re-exports Bertrand.

**What is missing.**

* a clean API for “there is a prime in `(x, x + h]`” with explicit `h`;
* explicit Nagura/Dusart-type bounds;
* a verified bridge from `ψ`/`θ` bounds to prime-gap bounds.

**Acceptance criteria.**

* a new module `Legendre/ExplicitBounds.lean` proves at least one explicit
  short-interval statement with a named constant and range;
* the statement is compared against the published constant in
  `docs/literature.md`;
* no `native_decide` without an explicit soundness note (or a kernel-checked
  certificate).

## Layer 2 — Riemann zeta foundations

**Scope.** Euler product, analytic continuation, functional equation,
non-vanishing on `Re(s) = 1`, a zero-free region, the argument principle, and
bounds for `ζ'/ζ`.

**Why.** Every zero-density theorem and every short-interval PNT proof starts
from these.

**Current state.** mathlib has a partial `Mathlib.NumberTheory.LSeries.RiemannZeta`
API and some zeta values, but not a complete zero-free-region and zero-counting
development suitable for Ingham/Huxley.

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

**Acceptance criteria for each.**

* the exact statement matches the paper's quantifiers, `+ε` convention, and
  “sufficiently large” threshold;
* the proof uses only earlier layers plus published, formalized lemmas;
* the statement is linked to the paper's DOI/arXiv in
  `docs/literature.md`;
* the declaration is added to `Legendre/Audit.lean`;
* if the proof is incomplete, the declaration is a `Prop` definition, not a
  theorem.

**A useful intermediate target.** Formalize Ingham's *statement* and prove the
generic consequence “Ingham's hypothesis ⇒ short-interval PNT”.  This is
already the shape of the conditional reduction, but the analytic content of
Ingham remains open until Layer 2–4 is done.

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

## Suggested first ten PRs

1. README/roadmap maintenance and CI hardening.
2. Explicit Chebyshev bounds from mathlib.
3. A prime-in-interval API with explicit `h`.
4. A verified small-range interval-certificate checker.
5. Zeta: Euler product and convergence.
6. Zeta: analytic continuation.
7. Zeta: non-vanishing on `Re(s) = 1`.
8. Zeta: weak zero-free region.
9. `N(T)` and zero counting.
10. Perron formula / truncated explicit formula.

Each PR must target `review` and pass `verify`.  See
[`PR_WORKFLOW.md`](PR_WORKFLOW.md).
