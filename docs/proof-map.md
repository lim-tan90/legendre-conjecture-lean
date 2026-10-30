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
| 8g | Nagura 1952: a prime in `(x, 6x/5]` for every `x ≥ 25` | `Legendre.nagura_hasPrimeIn`, `Legendre.nagura_prime_gap` | **proved** |
| 8h | explicit `ψ` bounds `0.916n < ψ(n) < 1.086n` (Nagura's Lemma 2) | `Legendre.Nagura.psi_nat_gt_0_916_mul`, `Legendre.Nagura.psi_nat_lt_1_086_mul` | **proved** |
| 8i | Ramanujan/Nagura identity `∑_{m≤n} ψ(n/m) = log n!` | `Legendre.Nagura.naguraChebyshevSum_eq_log_factorial` | **proved** |
| 9 | Bertrand's linear exponent is above `1/2` | `Legendre.bertrand_exponent_above_half` | **proved** |
| 9a | short-interval interval form with explicit constant and threshold | `Legendre.HasPrimeInShortInterval` | definition |
| 9b | `+ε` paper convention for short intervals | `Legendre.ShortIntervalStatement` | definition |
| 9c | explicit-threshold gap form | `Legendre.PrimeGapBound` | definition |
| 9d | interval form ↔ gap form (same `θ`, `C`; `θ ≥ 0`, `C ≥ 0`) | `Legendre.hasPrimeInShortInterval_iff_primeGapBound` | **proved** |
| 9e | paper-exact `+ε` form ↔ coarse exponent-limit interface | `Legendre.shortIntervalStatement_iff_exponentLimit` | **proved** |
| 9f | paper-exact `θ < 1/2` statement ⇒ Legendre eventually | `Legendre.legendre_eventually_of_shortIntervalStatement_lt_half` | **proved** |
| 9g | each paper-exact statement ↔ its coarse `Prop` | `Legendre.*Paper_iff` (nine theorems) | **proved** |
| 2.1 | Layer 2: absolute convergence | `Legendre.Zeta.series_norm_summable` | **proved**; mathlib result re-exported |
| 2.2 | Layer 2: convergent Dirichlet series | `Legendre.Zeta.eq_series` | **proved**; mathlib result re-exported |
| 2.3 | Layer 2: Euler product with convergence | `Legendre.Zeta.euler_product` | **proved**; mathlib result re-exported |
| 2.4 | Layer 2: finite Euler-product limit | `Legendre.Zeta.euler_product_limit` | **proved**; mathlib result re-exported |
| 2.5 | Layer 2: analytic continuation away from pole | `Legendre.Zeta.analytic_off_pole` | **proved**; mathlib result re-exported |
| 2.6 | Layer 2: completed functional equation | `Legendre.Zeta.completed_functional_equation` | **proved**; mathlib result re-exported |
| 2.7 | Layer 2: nonvanishing on Re(s) ≥ 1, excluding pole | `Legendre.Zeta.nonvanishing` | **proved**; mathlib result re-exported |
| 2.8 | Layer 2: finitely many distinct zeros in a compact set | `Legendre.Zeta.finite_zeros_on_compact` | **proved**; mathlib result re-exported |
| 2.9 | Layer 2: positive-width zero-free band at fixed height | `Legendre.Zeta.exists_zero_free_band` | **proved**; new deduction; no effective width estimate |
| 2.10 | Layer 2: qualitative left-hand strip, excluding pole | `Legendre.Zeta.exists_zero_free_strip` | **proved**; new deduction; no effective width estimate |
| 2.def | critical-strip zeros, analytic multiplicity and height/density counts | `Legendre.Zeta.NontrivialZero`, `zeroMultiplicity`, `zerosUpTo`, `zerosRightOf`, `zeroCount`, `zeroDensityCount` | definitions; `0 < Im(s) ≤ T`, `σ ≤ Re(s)` |
| 2.11 | Layer 2 counting foundation: analytic order finite | `Legendre.Zeta.analytic_order_finite` | **proved**; no quantitative zero-counting estimate |
| 2.12 | Layer 2 counting foundation: zeroMultiplicity cast | `Legendre.Zeta.zeroMultiplicity_cast` | **proved**; no quantitative zero-counting estimate |
| 2.13 | Layer 2 counting foundation: zeroMultiplicity pos | `Legendre.Zeta.zeroMultiplicity_pos` | **proved**; no quantitative zero-counting estimate |
| 2.14 | Layer 2 counting foundation: zeroMultiplicity eq zero | `Legendre.Zeta.zeroMultiplicity_eq_zero` | **proved**; no quantitative zero-counting estimate |
| 2.15 | Layer 2 counting foundation: zerosUpTo finite | `Legendre.Zeta.zerosUpTo_finite` | **proved**; no quantitative zero-counting estimate |
| 2.16 | Layer 2 counting foundation: zerosRightOf finite | `Legendre.Zeta.zerosRightOf_finite` | **proved**; no quantitative zero-counting estimate |
| 2.17 | Layer 2 counting foundation: zeroCount pos iff | `Legendre.Zeta.zeroCount_pos_iff` | **proved**; no quantitative zero-counting estimate |
| 2.18 | Layer 2 counting foundation: zeroDensityCount pos iff | `Legendre.Zeta.zeroDensityCount_pos_iff` | **proved**; no quantitative zero-counting estimate |
| 2.19 | Layer 2 counting foundation: zerosUpTo mono | `Legendre.Zeta.zerosUpTo_mono` | **proved**; no quantitative zero-counting estimate |
| 2.20 | Layer 2 counting foundation: zeroCount mono | `Legendre.Zeta.zeroCount_mono` | **proved**; no quantitative zero-counting estimate |
| 2.21 | Layer 2 counting foundation: zeroDensityCount le | `Legendre.Zeta.zeroDensityCount_le` | **proved**; no quantitative zero-counting estimate |
| 2.22 | Layer 2 counting foundation: zeroDensityCount mono height | `Legendre.Zeta.zeroDensityCount_mono_height` | **proved**; no quantitative zero-counting estimate |
| 2.23 | Layer 2 counting foundation: zeroDensityCount antitone | `Legendre.Zeta.zeroDensityCount_antitone` | **proved**; no quantitative zero-counting estimate |
| 2.24 | Layer 2 counting foundation: zeroCount eq zero of nonpos | `Legendre.Zeta.zeroCount_eq_zero_of_nonpos` | **proved**; no quantitative zero-counting estimate |
| 2.25 | Layer 2 counting foundation: zeroDensityCount eq zero of one le | `Legendre.Zeta.zeroDensityCount_eq_zero_of_one_le` | **proved**; no quantitative zero-counting estimate |
| 2.26 | Layer 2 counting foundation: zeroDensityCount eq count of nonpos | `Legendre.Zeta.zeroDensityCount_eq_count_of_nonpos` | **proved**; no quantitative zero-counting estimate |
| 2.27 | Layer 2 logarithmic derivative / counting bridge: vonMangoldt series summable | `Legendre.Zeta.vonMangoldt_series_summable` | **proved**; mathlib analytic result re-exported |
| 2.28 | Layer 2 logarithmic derivative / counting bridge: neg logDeriv eq vonMangoldt series | `Legendre.Zeta.neg_logDeriv_eq_vonMangoldt_series` | **proved**; mathlib analytic result re-exported |
| 2.29 | Layer 2 logarithmic derivative / counting bridge: norm logDeriv le majorant | `Legendre.Zeta.norm_logDeriv_le_majorant` | **proved**; new deduction; explicit bound only for Re(s) ≥ 3, cutoff non-effective |
| 2.30 | Layer 2 logarithmic derivative / counting bridge: vonMangoldt le nat | `Legendre.Zeta.vonMangoldt_le_nat` | **proved**; new deduction; explicit bound only for Re(s) ≥ 3, cutoff non-effective |
| 2.31 | Layer 2 logarithmic derivative / counting bridge: vonMangoldt term three le | `Legendre.Zeta.vonMangoldt_term_three_le` | **proved**; new deduction; explicit bound only for Re(s) ≥ 3, cutoff non-effective |
| 2.32 | Layer 2 logarithmic derivative / counting bridge: norm logDeriv le pi sq div six | `Legendre.Zeta.norm_logDeriv_le_pi_sq_div_six` | **proved**; new deduction; explicit bound only for Re(s) ≥ 3, cutoff non-effective |
| 2.33 | Layer 2 logarithmic derivative / counting bridge: zeroDensityCount eq zero of zero free | `Legendre.Zeta.zeroDensityCount_eq_zero_of_zero_free` | **proved**; new deduction; explicit bound only for Re(s) ≥ 3, cutoff non-effective |
| 2.34 | Layer 2 logarithmic derivative / counting bridge: exists zero density cutoff | `Legendre.Zeta.exists_zero_density_cutoff` | **proved**; new deduction; explicit bound only for Re(s) ≥ 3, cutoff non-effective |
| 2.35 | Layer 2 explicit right-half-plane estimate: tsum nat rpow neg le | `Legendre.Zeta.tsum_nat_rpow_neg_le` | **proved**; no left-of-1 zero-free claim |
| 2.36 | Layer 2 explicit right-half-plane estimate: vonMangoldt term one add two mul le | `Legendre.Zeta.vonMangoldt_term_one_add_two_mul_le` | **proved**; no left-of-1 zero-free claim |
| 2.37 | Layer 2 explicit right-half-plane estimate: vonMangoldt majorant le | `Legendre.Zeta.vonMangoldt_majorant_le` | **proved**; no left-of-1 zero-free claim |
| 2.38 | Layer 2 explicit right-half-plane estimate: norm logDeriv le of re ge one add | `Legendre.Zeta.norm_logDeriv_le_of_re_ge_one_add` | **proved**; no left-of-1 zero-free claim |
| 2.39 | Layer 2 explicit right-half-plane estimate: norm logDeriv le six div sq | `Legendre.Zeta.norm_logDeriv_le_six_div_sq` | **proved**; no left-of-1 zero-free claim |
| 2.40 | Layer 2 explicit right-half-plane estimate: norm logDeriv le re sub one | `Legendre.Zeta.norm_logDeriv_le_re_sub_one` | **proved**; no left-of-1 zero-free claim |
| 2.pole.def | pole-removed product with value 1 inserted at the pole | `Legendre.Zeta.poleRemovedZeta` | definition; differs from raw product at 1 |
| 2.41 | Layer 2 local pole structure: poleRemovedZeta one | `Legendre.Zeta.poleRemovedZeta_one` | **proved**; local result, no effective radius or Perron formula |
| 2.42 | Layer 2 local pole structure: poleRemovedZeta eq | `Legendre.Zeta.poleRemovedZeta_eq` | **proved**; local result, no effective radius or Perron formula |
| 2.43 | Layer 2 local pole structure: poleRemovedZeta eventuallyEq | `Legendre.Zeta.poleRemovedZeta_eventuallyEq` | **proved**; local result, no effective radius or Perron formula |
| 2.44 | Layer 2 local pole structure: poleRemovedZeta differentiableAt | `Legendre.Zeta.poleRemovedZeta_differentiableAt` | **proved**; local result, no effective radius or Perron formula |
| 2.45 | Layer 2 local pole structure: poleRemovedZeta continuousAt one | `Legendre.Zeta.poleRemovedZeta_continuousAt_one` | **proved**; local result, no effective radius or Perron formula |
| 2.46 | Layer 2 local pole structure: poleRemovedZeta analyticAt one | `Legendre.Zeta.poleRemovedZeta_analyticAt_one` | **proved**; local result, no effective radius or Perron formula |
| 2.47 | Layer 2 local pole structure: poleRemovedZeta logDeriv analyticAt one | `Legendre.Zeta.poleRemovedZeta_logDeriv_analyticAt_one` | **proved**; local result, no effective radius or Perron formula |
| 2.48 | Layer 2 local pole structure: logDeriv regularPart eventuallyEq | `Legendre.Zeta.logDeriv_regularPart_eventuallyEq` | **proved**; local result, no effective radius or Perron formula |
| 2.49 | Layer 2 local pole structure: tendsto logDeriv regularPart | `Legendre.Zeta.tendsto_logDeriv_regularPart` | **proved**; local result, no effective radius or Perron formula |
| 2.50 | Layer 2 local pole structure: tendsto sub mul logDeriv at one | `Legendre.Zeta.tendsto_sub_mul_logDeriv_at_one` | **proved**; local result, no effective radius or Perron formula |
| 2.51 | Layer 2 local pole structure: tendsto sub mul neg logDeriv at one | `Legendre.Zeta.tendsto_sub_mul_neg_logDeriv_at_one` | **proved**; local result, no effective radius or Perron formula |
| 2.52 | Layer 2 local pole structure: logDeriv regularPart eventually bounded | `Legendre.Zeta.logDeriv_regularPart_eventually_bounded` | **proved**; local result, no effective radius or Perron formula |
| 2.53 | Layer 2 local pole structure: norm logDeriv eventually le inv add | `Legendre.Zeta.norm_logDeriv_eventually_le_inv_add` | **proved**; local result, no effective radius or Perron formula |
| 2.perron.def | weight x^s/s and weighted -ζ′/ζ kernel | `Legendre.Zeta.perronWeight`, `perronIntegrand` | definitions; not an inversion assertion |
| 2.contour.def | analytic numerator for the local weighted pole | `Legendre.Zeta.perronPoleNumerator` | definition; F=(1-(s-1)logDeriv H(s))x^s/s |
| 2.contour.1 | numerator value at the pole | `Legendre.Zeta.perronPoleNumerator_one` | **proved**; F(x,1)=x |
| 2.contour.2 | analytic Perron weight at 1 | `Legendre.Zeta.perronWeight_analyticAt_one` | **proved** for x>0 |
| 2.contour.3 | analytic pole-cancelled numerator | `Legendre.Zeta.perronPoleNumerator_analyticAt_one` | **proved** for x>0 |
| 2.contour.4 | local quotient representation | `Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator` | **proved** off 1 in a neighborhood |
| 2.contour.5 | small-circle pole contribution | `Legendre.Zeta.exists_perronIntegrand_circleIntegral` | **proved**; ∃δ>0, ∀0<r<δ, integral=2πix; non-effective, no inversion or contour shift |
| 2.vertical.def | normalized finite vertical integral | `Legendre.Zeta.truncatedPerron` | definition; not an equality with ψ |
| 2.vertical.1 | exact norm of the Perron weight | `Legendre.Zeta.norm_perronWeight` | **proved** for x>0 |
| 2.vertical.2 | explicit weighted right-half-plane bound | `Legendre.Zeta.norm_perronIntegrand_le` | **proved** for x>0, Re(s)>1 |
| 2.vertical.3 | continuity of the weighted kernel | `Legendre.Zeta.perronIntegrand_continuousAt` | **proved** on Re(s)>1 for x>0 |
| 2.vertical.4 | uniform finite-line majorant | `Legendre.Zeta.norm_perronIntegrand_vertical_le` | **proved**; B(σ)x^σ/σ for σ>1 |
| 2.vertical.5 | inverse-height decay | `Legendre.Zeta.norm_perronIntegrand_vertical_le_div_abs` | **proved** for t≠0; no infinite-line integrability asserted |
| 2.vertical.6 | finite vertical kernel integrability | `Legendre.Zeta.perronIntegrand_vertical_intervalIntegrable` | **proved** for arbitrary finite endpoints, x>0, σ>1 |
| 2.vertical.7 | normalized finite integral bound | `Legendre.Zeta.norm_truncatedPerron_le` | **proved** for T≥0; not a truncation-error bound |
| 2.series.def | weighted Dirichlet term and finite scalar kernel | `Legendre.Zeta.perronSeriesTerm`, `truncatedPerronKernel` | definitions; zero-index convention from LSeries |
| 2.series.1 | classical weighted term identity | `Legendre.Zeta.perronSeriesTerm_eq_vonMangoldt_mul_weight` | **proved**; Λ(n)(x/n)^s/s, including n=0 |
| 2.series.2 | weighted series sum | `Legendre.Zeta.perronSeriesTerm_hasSum` | **proved** for Re(s)>1 |
| 2.series.3 | height-independent weight bound | `Legendre.Zeta.norm_perronWeight_vertical_le` | **proved** for x>0, σ>1 |
| 2.series.4 | summable uniform term majorant | `Legendre.Zeta.norm_perronSeriesTerm_vertical_le` | **proved**; norm of the σ-term times x^σ/σ |
| 2.series.5 | continuity of each vertical term | `Legendre.Zeta.perronSeriesTerm_vertical_continuous` | **proved** for x>0, σ>1 |
| 2.series.6 | series / finite integral exchange | `Legendre.Zeta.perronSeriesTerm_hasSum_intervalIntegral` | **proved** by dominated convergence on arbitrary finite intervals |
| 2.series.7 | absolute convergence after integration | `Legendre.Zeta.perronSeriesTerm_integrals_norm_summable` | **proved** for arbitrary finite height endpoints |
| 2.series.8 | normalized termwise integral representation | `Legendre.Zeta.truncatedPerron_eq_tsum_integrals` | **proved** for every finite T |
| 2.series.9 | scalar kernel series representation | `Legendre.Zeta.truncatedPerron_eq_tsum_kernels` | **proved**; no infinite-height limit or ψ identification |
| 2.kernel.1 | continuity of the reciprocal vertical kernel | `Legendre.Zeta.perronReciprocal_vertical_continuous` | **proved** for σ>0 |
| 2.kernel.2 | exact finite reciprocal integral | `Legendre.Zeta.integral_perronReciprocal` | **proved**; integral=2 arctan(T/σ) |
| 2.kernel.3 | scalar endpoint evaluation | `Legendre.Zeta.truncatedPerronKernel_one` | **proved**; J(1,σ,T)=arctan(T/σ)/π |
| 2.kernel.4 | half-weight endpoint limit | `Legendre.Zeta.tendsto_truncatedPerronKernel_one` | **proved** for σ>0; limit=1/2 |
| 2.kernel.5 | explicit endpoint error | `Legendre.Zeta.norm_truncatedPerronKernel_one_sub_half_le` | **proved** for σ,T>0; error≤σ/(πT), only y=1 |
| 2.54 | Layer 2 forward Abel / weighted pole foundation: vonMangoldt partialSums floor eq psi | `Legendre.Zeta.vonMangoldt_partialSums_floor_eq_psi` | **proved**; not Perron inversion |
| 2.55 | Layer 2 forward Abel / weighted pole foundation: vonMangoldt partialSums isBigO | `Legendre.Zeta.vonMangoldt_partialSums_isBigO` | **proved**; not Perron inversion |
| 2.56 | Layer 2 forward Abel / weighted pole foundation: vonMangoldt partialSums complex eq psi | `Legendre.Zeta.vonMangoldt_partialSums_complex_eq_psi` | **proved**; not Perron inversion |
| 2.57 | Layer 2 forward Abel / weighted pole foundation: norm psi mellin integrand le | `Legendre.Zeta.norm_psi_mellin_integrand_le` | **proved**; not Perron inversion |
| 2.58 | Layer 2 forward Abel / weighted pole foundation: psi mellin integrable | `Legendre.Zeta.psi_mellin_integrable` | **proved**; not Perron inversion |
| 2.59 | Layer 2 forward Abel / weighted pole foundation: neg logDeriv eq psi integral | `Legendre.Zeta.neg_logDeriv_eq_psi_integral` | **proved**; not Perron inversion |
| 2.60 | Layer 2 forward Abel / weighted pole foundation: perronWeight one | `Legendre.Zeta.perronWeight_one` | **proved**; not Perron inversion |
| 2.61 | Layer 2 forward Abel / weighted pole foundation: perronWeight continuousAt one | `Legendre.Zeta.perronWeight_continuousAt_one` | **proved**; not Perron inversion |
| 2.62 | Layer 2 forward Abel / weighted pole foundation: tendsto sub mul perronIntegrand at one | `Legendre.Zeta.tendsto_sub_mul_perronIntegrand_at_one` | **proved**; not Perron inversion |
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
