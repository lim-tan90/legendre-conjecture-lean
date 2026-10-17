# Proof map: literature step ↔ Lean declaration ↔ status

This table is the honesty contract of the repository.  “Statement only” means
the mathematical statement is encoded as a `Prop`, but its proof is **not**
formalized.  “Proved” means `lake build` checks a complete proof term.

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
| 9 | Bertrand's linear exponent is above `1/2` | `Legendre.bertrand_exponent_above_half` | **proved** |
| 10 | Hoheisel 1930, `θ = 32999/33000` | `Legendre.Hoheisel` | **statement only** |
| 11 | Ingham 1937, `θ = 5/8` | `Legendre.Ingham58` | **statement only** |
| 12 | Ingham 1937, `θ = 577/925 + ε` | `Legendre.Ingham577` | **statement only** |
| 13 | Huxley 1972, `θ = 7/12 + ε` | `Legendre.Huxley` | **statement only** |
| 14 | Heath-Brown–Iwaniec 1979, `θ = 13/23 + ε` | `Legendre.HeathBrownIwaniec` | **statement only** |
| 15 | Iwaniec–Pintz 1984, `θ = 11/20 - 1/406 + ε` | `Legendre.IwaniecPintz` | **statement only** |
| 16 | Mozzochi 1986, `θ = 11/20 - 1/384 + ε` | `Legendre.Mozzochi` | **statement only** |
| 17 | Baker–Harman 1996, `θ = 0.535` | `Legendre.BakerHarman` | **statement only** |
| 18 | Baker–Harman–Pintz 2001, `θ = 0.525` | `Legendre.BakerHarmanPintz` | **statement only** |
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
