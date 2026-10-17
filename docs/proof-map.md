# Proof map: literature step ↔ Lean declaration ↔ status

This table is the honesty contract of the repository.  “Statement only” means
the mathematical statement is encoded as a `Prop`, but its proof is **not**
formalized.  “Proved” means `lake build` checks a complete proof term.

Rows 9a–9g record the **statement-level Layer 5** infrastructure from
`Legendre/Layer5.lean`: the paper-exact `+ε`/constant/threshold conventions
and the proved bridges between the interval form, the gap form and the coarse
`Prop`s of `Conditional.lean`.  A row marked “statement only” is still
**not a proved theorem**.

| # | Literature step | Lean declaration | Formalization status |
|---:|---|---|---|
| 0 | Legendre's conjecture (square form) | `Legendre.LegendreAt`, `Legendre.Conjecture` | definition |
| 1 | equivalence of square and gap formulations | `Legendre.legendreAt_iff_gapFormAt` | **proved** |
| 2 | `(n+1)² - n² = 2n+1` | `Legendre.sq_interval_length` | **proved** |
| 3 | gap `< 2√p` ⇒ Legendre | `Legendre.legendre_of_gap_lt_two_sqrt` | **proved** |
| 4 | power smallness `θ < 1/2 ⇒ C n^{2θ} < 2n` | `Legendre.eventually_const_mul_rpow_lt` | **proved** |
| 5 | gap exponent `θ < 1/2` ⇒ Legendre eventually | `Legendre.eventually_legendre_of_gap_exponent_lt_half` | **proved** |
| 6 | same, packaged as a literature-style exponent result | `Legendre.legendre_eventually_of_shortIntervalExponent_lt_half` | **proved** |
| 7 | same for the `+ε` form | `Legendre.legendre_eventually_of_shortIntervalExponentLimit_lt_half` | **proved** |
| 8 | Bertrand's postulate | `Legendre.bertrand`, `Legendre.bertrand_gap_le` | mathlib proof, re-exported |
| 8a | interval predicate `(x, x+h]` | `Legendre.HasPrimeIn` | definition |
| 8b | explicit prime in `(x, 2x]` for `x ≥ 1` | `Legendre.hasPrimeIn_self` | **proved** |
| 8c | strict `θ` increase forces a prime in `(x, y]` | `Legendre.exists_prime_of_theta_lt`, `Legendre.hasPrimeIn_of_theta_gap` | **proved** |
| 8d | explicit upper/lower bounds for `θ` | `Legendre.theta_upper_explicit`, `Legendre.theta_lower_explicit` | **proved** |
| 8e | explicit upper/lower bounds for `ψ` | `Legendre.psi_upper_explicit`, `Legendre.psi_lower_explicit` | **proved** |
| 8f | explicit lower/upper bounds for `π` | `Legendre.pi_lower_explicit`, `Legendre.pi_upper_explicit` | **proved** |
| 9 | Bertrand's linear exponent is above `1/2` | `Legendre.bertrand_exponent_above_half` | **proved** |
| 9a | short-interval interval form with explicit constant and threshold | `Legendre.HasPrimeInShortInterval` | definition |
| 9b | `+ε` paper convention for short intervals | `Legendre.ShortIntervalStatement` | definition |
| 9c | explicit-threshold gap form | `Legendre.PrimeGapBound` | definition |
| 9d | interval form ↔ gap form (same `θ`, `C`; `θ ≥ 0`, `C ≥ 0`) | `Legendre.hasPrimeInShortInterval_iff_primeGapBound` | **proved** |
| 9e | paper-exact `+ε` form ↔ coarse exponent-limit interface | `Legendre.shortIntervalStatement_iff_exponentLimit` | **proved** |
| 9f | paper-exact `θ < 1/2` statement ⇒ Legendre eventually | `Legendre.legendre_eventually_of_shortIntervalStatement_lt_half` | **proved** |
| 9g | each paper-exact statement ↔ its coarse `Prop` | `Legendre.*Paper_iff` (nine theorems) | **proved** |
| 10 | Hoheisel 1930, `θ = 32999/33000` | `Legendre.Hoheisel`, `Legendre.HoheiselPaper` | **statement only**; paper-exact form encoded, `hoheiselPaper_iff` proved |
| 11 | Ingham 1937, `θ = 5/8` | `Legendre.Ingham58`, `Legendre.Ingham58Paper` | **statement only**; paper-exact form encoded, `ingham58Paper_iff` proved |
| 12 | Ingham 1937, `θ = 577/925 + ε` | `Legendre.Ingham577`, `Legendre.Ingham577Paper` | **statement only**; paper-exact form encoded, `ingham577Paper_iff` proved |
| 13 | Huxley 1972, `θ = 7/12 + ε` | `Legendre.Huxley`, `Legendre.HuxleyPaper` | **statement only**; paper-exact form encoded, `huxleyPaper_iff` proved |
| 14 | Heath-Brown–Iwaniec 1979, `θ = 13/23 + ε` | `Legendre.HeathBrownIwaniec`, `Legendre.HeathBrownIwaniecPaper` | **statement only**; paper-exact form encoded, `heathBrownIwaniecPaper_iff` proved |
| 15 | Iwaniec–Pintz 1984, `θ = 11/20 - 1/406 + ε` | `Legendre.IwaniecPintz`, `Legendre.IwaniecPintzPaper` | **statement only**; paper-exact form encoded, `iwaniecPintzPaper_iff` proved |
| 16 | Mozzochi 1986, `θ = 11/20 - 1/384 + ε` | `Legendre.Mozzochi`, `Legendre.MozzochiPaper` | **statement only**; paper-exact form encoded, `mozzochiPaper_iff` proved |
| 17 | Baker–Harman 1996, `θ = 0.535` | `Legendre.BakerHarman`, `Legendre.BakerHarmanPaper` | **statement only**; paper-exact form encoded, `bakerHarmanPaper_iff` proved |
| 18 | Baker–Harman–Pintz 2001, `θ = 0.525` | `Legendre.BakerHarmanPintz`, `Legendre.BakerHarmanPintzPaper` | **statement only**; paper-exact form encoded, `bakerHarmanPintzPaper_iff` proved |
| 19 | RH gap bound `≪ √x log x` | `Legendre.RHGapBound` | **statement only** |
| 20 | Cramér conjecture `O((log x)²)` | `Legendre.CramerGapBound` | **statement only** |
| 21 | almost-prime `P_k` square statement | `Legendre.AlmostPrimeSquareAtMost`, `AlmostPrimeSquareEventually` | definition |
| 22 | `P₁` square statement ↔ Legendre | `Legendre.almostPrimeSquareAtMost_one_iff` | **proved** |
| 23 | Chen 1975: `P₂` for all sufficiently large `n` | — | **not encoded in Lean** (deep sieve theorem) |
| 24 | Dudek–Johnston 2026: `P₄` for all `n` | — | **not encoded in Lean** (deep sieve/computation) |
| 25 | explicit verification `n ≤ 7.05×10¹³` | — | **not encoded in Lean** (large external computation) |

## What the audit proves — and what it does not

`scripts/audit.py` proves the *absence* of the usual formalization cheats:

* no `sorry`/`admit`;
* no user `axiom`, `constant`, `opaque`, or `unsafe`;
* no `False.elim`/`absurd`/`nomatch` shortcut in project code;
* every audited theorem's `#print axioms` list is a subset of
  `{propext, Classical.choice, Quot.sound}`.

It does **not** prove that rows marked “statement only” are true.  Those rows
are inputs/hypotheses, not theorems.  In particular, no row claims that
Legendre's conjecture has been proved.

## Why the deep proofs are absent

Formalizing Ingham/Huxley/BHP at proof level would require, at minimum:

* the Riemann zeta function, its analytic continuation, functional equation,
  and zero-free regions;
* zero-density estimates `N(σ,T)`;
* Perron's formula and short-interval prime-counting asymptotics;
* weighted sieves for the Baker–Harman–Pintz refinements;
* the explicit computations and interval arithmetic for the finite range.

Mathlib currently has fragments of the zeta function but not a formalized
zero-density theory or the BHP theorem.  Pretending otherwise with `axiom` or
`sorry` would violate the project's core rule.
