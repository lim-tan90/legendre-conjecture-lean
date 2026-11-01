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
| 2.osc.1 | magnitude / oscillation separation | `Legendre.Zeta.cpow_vertical_eq_exp` | **proved** for y>0 and arbitrary real σ,t |
| 2.osc.2 | oscillatory scalar weight | `Legendre.Zeta.perronWeight_vertical_eq_exp` | **proved**; retains the reciprocal vertical factor |
| 2.osc.3 | finite numerator primitive | `Legendre.Zeta.integral_cpow_vertical` | **proved** for y>0, y≠1; arbitrary finite endpoints |
| 2.osc.4 | bounded numerator integrals | `Legendre.Zeta.norm_integral_cpow_vertical_le` | **proved**; bound 2y^σ/abs(log y), independent of endpoints; not a full kernel bound |
| 2.tail.def | numerator primitive and reciprocal derivative | `Legendre.Zeta.perronOscPrimitive`, `perronReciprocalDeriv` | definitions used for integration by parts |
| 2.tail.1 | vertical line avoids zero | `Legendre.Zeta.perronVertical_ne_zero` | **proved** for σ>0 |
| 2.tail.2 | numerator primitive derivative | `Legendre.Zeta.perronOscPrimitive_hasDerivAt` | **proved** for y>0, y≠1 |
| 2.tail.3 | constant primitive norm | `Legendre.Zeta.norm_perronOscPrimitive` | **proved**; y^σ/abs(log y) |
| 2.tail.4 | reciprocal derivative | `Legendre.Zeta.perronReciprocal_hasDerivAt` | **proved** for σ>0 |
| 2.tail.5 | reciprocal derivative continuity | `Legendre.Zeta.perronReciprocalDeriv_continuous` | **proved** for σ>0 |
| 2.tail.6 | reciprocal derivative height bound | `Legendre.Zeta.norm_perronReciprocalDeriv_le` | **proved** for t>0; norm≤1/t² |
| 2.tail.7 | finite scalar integration by parts | `Legendre.Zeta.integral_perronWeight_parts` | **proved** for y>0, y≠1, σ>0 and arbitrary finite endpoints |
| 2.tail.8 | absolute integrability of the remainder | `Legendre.Zeta.perronTail_remainder_integrable` | **proved** on (1,∞); not absolute integrability of the original kernel |
| 2.tail.9 | vanishing boundary term | `Legendre.Zeta.perronTail_boundary_tendsto_zero` | **proved** at positive infinity |
| 2.tail.10 | conditional positive-half convergence | `Legendre.Zeta.tendsto_integral_perronWeight_Ioi_one` | **proved** with an explicit remainder-integral limit |
| 2.tail.11 | scalar weight continuity | `Legendre.Zeta.perronWeight_vertical_continuous` | **proved** for y,σ>0 |
| 2.tail.12 | conjugation reflection | `Legendre.Zeta.perronWeight_vertical_neg` | **proved** for y>0 |
| 2.tail.13 | symmetric integral decomposition | `Legendre.Zeta.integral_perronWeight_symmetric` | **proved** for y,σ>0 |
| 2.tail.14 | nonendpoint scalar limit existence | `Legendre.Zeta.exists_tendsto_truncatedPerronKernel` | **proved** for y>0, y≠1, σ>0; no limit value asserted |
| 2.tail.15 | all-positive-base scalar convergence | `Legendre.Zeta.exists_tendsto_truncatedPerronKernel_pos` | **proved** for y,σ>0, including y=1; no full Perron formula |
| 2.shift.def | horizontal scalar contour side | `Legendre.Zeta.perronHorizontal` | definition |
| 2.shift.1 | weight differentiability off zero | `Legendre.Zeta.perronWeight_differentiableAt` | **proved** for y>0 |
| 2.shift.2 | positive rectangle identity | `Legendre.Zeta.perronWeight_rectangle` | **proved** for 0<σ≤ρ |
| 2.shift.3 | endpoint maximum bounds real powers | `Legendre.Zeta.rpow_le_max_endpoints` | **proved** for y>0 |
| 2.shift.4 | horizontal pointwise bound | `Legendre.Zeta.norm_perronWeight_horizontal_le` | **proved** at nonzero height |
| 2.shift.5 | horizontal integral bound | `Legendre.Zeta.norm_perronHorizontal_le` | **proved**; endpoint-power maximum times width/abs(height) |
| 2.shift.6 | positive-height side vanishes | `Legendre.Zeta.perronHorizontal_tendsto_zero` | **proved** |
| 2.shift.7 | negative-height side vanishes | `Legendre.Zeta.perronHorizontal_neg_tendsto_zero` | **proved** |
| 2.shift.8 | finite change of positive line | `Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal` | **proved** without crossing zero |
| 2.shift.9 | positive-line difference vanishes | `Legendre.Zeta.tendsto_truncatedPerronKernel_sub` | **proved** |
| 2.shift.10 | scalar limits independent of positive line | `Legendre.Zeta.perronKernel_limit_independent_line` | **proved** for any two existing limits |
| 2.zero.1 | exact reciprocal derivative norm | `Legendre.Zeta.norm_perronReciprocalDeriv_eq` | **proved**; 1/(σ²+t²) |
| 2.zero.2 | boundary term uniform bound | `Legendre.Zeta.norm_perronTail_boundary_le` | **proved** for y,σ>0 |
| 2.zero.3 | symmetric remainder uniform bound | `Legendre.Zeta.norm_integral_perronTail_remainder_le` | **proved** for T≥0 |
| 2.zero.4 | height-independent scalar kernel bound | `Legendre.Zeta.norm_truncatedPerronKernel_uniform_le` | **proved** for y>0, y≠1, σ>0, T≥0 |
| 2.zero.5 | right-line decay below endpoint | `Legendre.Zeta.norm_truncatedPerronKernel_le_of_lt_one` | **proved** for 0<y<1 |
| 2.zero.6 | scalar kernel limit below endpoint | `Legendre.Zeta.tendsto_truncatedPerronKernel_of_lt_one` | **proved**; limit 0 for 0<y<1, σ>0 |
| 2.residue.def | entire regularization and endpoint step | `Legendre.Zeta.perronRegularizedWeight`, `scalarPerronValue` | definitions; latter is 0/half/1 |
| 2.residue.1 | entire regularization | `Legendre.Zeta.perronRegularizedWeight_differentiable` | **proved** for y>0 using dslope |
| 2.residue.2 | regularization off zero | `Legendre.Zeta.perronRegularizedWeight_eq` | **proved**; subtracts the reciprocal kernel |
| 2.residue.3 | continuity along a curve | `Legendre.Zeta.perronWeight_continuous_comp` | **proved** for curves avoiding zero |
| 2.residue.4 | regularized integral decomposition | `Legendre.Zeta.integral_perronRegularizedWeight_eq` | **proved** with genuine finite integrability |
| 2.residue.5 | reflected weight identity | `Legendre.Zeta.perronWeight_neg_eq_inv` | **proved**; reciprocal base |
| 2.residue.6 | reflected scalar kernel identity | `Legendre.Zeta.truncatedPerronKernel_neg_line` | **proved** at finite height |
| 2.residue.7 | finite pole-crossing identity | `Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq` | **proved** by an entire regularized rectangle |
| 2.residue.8 | limiting pole contribution comparison | `Legendre.Zeta.tendsto_truncatedPerronKernel_crossing_sub` | **proved** via horizontal-side decay |
| 2.residue.9 | scalar kernel limit above endpoint | `Legendre.Zeta.tendsto_truncatedPerronKernel_of_one_lt` | **proved**; limit 1 for y>1, σ>0 |
| 2.residue.10 | unified scalar Perron inversion | `Legendre.Zeta.tendsto_truncatedPerronKernel` | **proved**; 0/half/1 for all y,σ>0; no ψ reconstruction asserted |
| 2.inversion.def | scalar bound including the endpoint | `Legendre.Zeta.perronKernelBound` | definition |
| 2.inversion.1 | nonnegative scalar majorant | `Legendre.Zeta.perronKernelBound_nonneg` | **proved**; for y≥0, σ>0 |
| 2.inversion.2 | uniform scalar bound including endpoint | `Legendre.Zeta.norm_truncatedPerronKernel_le_bound` | **proved**; for y,σ>0, T≥0 |
| 2.inversion.3 | logarithmic separation on coefficient tail | `Legendre.Zeta.log_ratio_abs_ge_log_two` | **proved**; for n≥2x, x>0 |
| 2.inversion.4 | Dirichlet-power bound for scalar majorant | `Legendre.Zeta.perronKernelBound_ratio_le` | **proved**; for n≥2x, x,σ>0 |
| 2.inversion.5 | summable coefficient majorant | `Legendre.Zeta.summable_vonMangoldt_perronKernelBound` | **proved**; for x>0, σ>1; uniform in T≥0 |
| 2.inversion.6 | Perron limit and von Mangoldt sum exchange | `Legendre.Zeta.tendsto_truncatedPerron_tsum` | **proved**; by Tannery; includes the zero-index case |
| 2.inversion.7 | limiting coefficients vanish above x | `Legendre.Zeta.vonMangoldt_mul_scalarPerronValue_eq_zero` | **proved**; includes the zero-index convention |
| 2.inversion.8 | finite support of limiting series | `Legendre.Zeta.vonMangoldt_scalarPerronValue_tsum_eq_sum` | **proved**; sum over 0≤n≤floor(x) |
| 2.inversion.9 | endpoint coefficient correction | `Legendre.Zeta.vonMangoldt_mul_scalarPerronValue_eq` | **proved**; full weight below x, half at x |
| 2.inversion.10 | limiting series equals half-weighted ψ | `Legendre.Zeta.vonMangoldt_scalarPerronValue_tsum_eq_psi` | **proved**; exact floor-based endpoint correction |
| 2.inversion.11 | Perron inversion | `Legendre.Zeta.tendsto_truncatedPerron` | **proved**; for x>0, σ>1; half weight at integer endpoints |
| 2.inversion.12 | Perron inversion away from integers | `Legendre.Zeta.tendsto_truncatedPerron_of_not_nat` | **proved**; limit ψ(x) for positive nonintegers |
| 2.inversion.13 | Perron inversion at integers | `Legendre.Zeta.tendsto_truncatedPerron_nat` | **proved**; limit ψ(m)−Λ(m)/2 for positive integers |
| 2.error.1 | integral perron inv sq | `Legendre.Zeta.integral_perron_inv_sq` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.2 | norm perronTail boundary height le | `Legendre.Zeta.norm_perronTail_boundary_height_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.3 | norm integral perronTail remainder height le | `Legendre.Zeta.norm_integral_perronTail_remainder_height_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.4 | norm integral perronWeight tail le | `Legendre.Zeta.norm_integral_perronWeight_tail_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.5 | norm truncatedPerronKernel sub le | `Legendre.Zeta.norm_truncatedPerronKernel_sub_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.6 | norm truncatedPerronKernel sub value le | `Legendre.Zeta.norm_truncatedPerronKernel_sub_value_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.7 | perronScalarError nonneg | `Legendre.Zeta.perronScalarError_nonneg` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.8 | norm truncatedPerronKernel error le | `Legendre.Zeta.norm_truncatedPerronKernel_error_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.9 | perronScalarError le bound | `Legendre.Zeta.perronScalarError_le_bound` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.10 | summable vonMangoldt perronScalarError | `Legendre.Zeta.summable_vonMangoldt_perronScalarError` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.11 | perronErrorConstant nonneg | `Legendre.Zeta.perronErrorConstant_nonneg` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.12 | summable vonMangoldt truncatedPerronKernel | `Legendre.Zeta.summable_vonMangoldt_truncatedPerronKernel` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.13 | summable vonMangoldt scalarPerronValue | `Legendre.Zeta.summable_vonMangoldt_scalarPerronValue` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.14 | norm truncatedPerron sub psi le | `Legendre.Zeta.norm_truncatedPerron_sub_psi_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.15 | vonMangoldt dirichlet norm sum le | `Legendre.Zeta.vonMangoldt_dirichlet_norm_sum_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.16 | vonMangoldt perronScalarError tail le | `Legendre.Zeta.vonMangoldt_perronScalarError_tail_le` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.17 | perronErrorConstant le upper | `Legendre.Zeta.perronErrorConstant_le_upper` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.error.18 | norm truncatedPerron sub psi le upper | `Legendre.Zeta.norm_truncatedPerron_sub_psi_le_upper` | **proved**; finite Perron error; x>0, σ>1, T>0 for the final bound |
| 2.positivity.1 | vonMangoldt term re | `Legendre.Zeta.vonMangoldt_term_re` | **proved**; 3–4–1 positivity; σ>1 for the logarithmic derivative |
| 2.positivity.2 | vonMangoldt term three four one nonneg | `Legendre.Zeta.vonMangoldt_term_three_four_one_nonneg` | **proved**; 3–4–1 positivity; σ>1 for the logarithmic derivative |
| 2.positivity.3 | neg logDeriv three four one nonneg | `Legendre.Zeta.neg_logDeriv_three_four_one_nonneg` | **proved**; 3–4–1 positivity; σ>1 for the logarithmic derivative |
| 2.growth.1 | zetaFractionalPart measurable | `Legendre.Zeta.zetaFractionalPart_measurable` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.2 | norm zetaFractionalPart le | `Legendre.Zeta.norm_zetaFractionalPart_le` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.3 | zetaFractionalPart locallyIntegrable | `Legendre.Zeta.zetaFractionalPart_locallyIntegrable` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.4 | zetaFractionalPart isBigO atTop | `Legendre.Zeta.zetaFractionalPart_isBigO_atTop` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.5 | zetaFractionalPart isBigO at zero | `Legendre.Zeta.zetaFractionalPart_isBigO_at_zero` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.6 | zetaMellinRemainder convergent | `Legendre.Zeta.zetaMellinRemainder_convergent` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.7 | zetaMellinRemainder differentiableAt | `Legendre.Zeta.zetaMellinRemainder_differentiableAt` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.8 | zetaMellin integrand eq indicator | `Legendre.Zeta.zetaMellin_integrand_eq_indicator` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.9 | zetaMellinRemainder eq integral | `Legendre.Zeta.zetaMellinRemainder_eq_integral` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.10 | zetaMellinRemainder integrable | `Legendre.Zeta.zetaMellinRemainder_integrable` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.11 | norm zetaMellinRemainder le | `Legendre.Zeta.norm_zetaMellinRemainder_le` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.12 | riemannZeta eq euler sum right | `Legendre.Zeta.riemannZeta_eq_euler_sum_right` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.13 | poleRemovedZeta differentiable | `Legendre.Zeta.poleRemovedZeta_differentiable` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.14 | zetaEulerNumerator differentiableAt | `Legendre.Zeta.zetaEulerNumerator_differentiableAt` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.15 | poleRemovedZeta eq euler sum | `Legendre.Zeta.poleRemovedZeta_eq_euler_sum` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.16 | riemannZeta eq euler sum | `Legendre.Zeta.riemannZeta_eq_euler_sum` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.17 | norm riemannZeta le positive re | `Legendre.Zeta.norm_riemannZeta_le_positive_re` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.18 | norm riemannZeta le three mul norm | `Legendre.Zeta.norm_riemannZeta_le_three_mul_norm` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.19 | norm moebius LSeries le two | `Legendre.Zeta.norm_moebius_LSeries_le_two` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.growth.20 | one half le norm riemannZeta | `Legendre.Zeta.one_half_le_norm_riemannZeta` | **proved**; Euler summation and explicit growth; Re(s)>0, excluding the pole where needed |
| 2.local.1 | zeta disk coordinates | `Legendre.Zeta.zeta_disk_coordinates` | **proved**; local disk estimates; abs(t)≥3 for the disk and Jensen bounds |
| 2.local.2 | riemannZeta analyticOnNhd disk | `Legendre.Zeta.riemannZeta_analyticOnNhd_disk` | **proved**; local disk estimates; abs(t)≥3 for the disk and Jensen bounds |
| 2.local.3 | norm riemannZeta disk le | `Legendre.Zeta.norm_riemannZeta_disk_le` | **proved**; local disk estimates; abs(t)≥3 for the disk and Jensen bounds |
| 2.local.4 | one half le norm riemannZeta disk center | `Legendre.Zeta.one_half_le_norm_riemannZeta_disk_center` | **proved**; local disk estimates; abs(t)≥3 for the disk and Jensen bounds |
| 2.local.5 | zeta local divisor sum le | `Legendre.Zeta.zeta_local_divisor_sum_le` | **proved**; local disk estimates; abs(t)≥3 for the disk and Jensen bounds |
| 2.error.def | explicit scalar/series/finite error bounds | `Legendre.Zeta.perronScalarError`, `perronErrorConstant`, `perronErrorUpper` | definitions; summability proved before use |
| 2.growth.def | cutoff fractional part and Mellin remainder | `Legendre.Zeta.zetaFractionalPart`, `zetaMellinRemainder` | definitions; convergence and holomorphy on Re(s)>0 proved |
| 2.removal.1 | localZetaDivisor finite | `Legendre.Zeta.localZetaDivisor_finite` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.2 | localZetaDivisor nonneg | `Legendre.Zeta.localZetaDivisor_nonneg` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.3 | localZetaFactor analyticAt | `Legendre.Zeta.localZetaFactor_analyticAt` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.4 | localZetaFactor order | `Legendre.Zeta.localZetaFactor_order` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.5 | localZetaFactor ne zero | `Legendre.Zeta.localZetaFactor_ne_zero` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.6 | riemannZeta meromorphicOrderAt eq | `Legendre.Zeta.riemannZeta_meromorphicOrderAt_eq` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.7 | localZetaDivisor eq multiplicity | `Legendre.Zeta.localZetaDivisor_eq_multiplicity` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.8 | localZetaQuotient meromorphicOn | `Legendre.Zeta.localZetaQuotient_meromorphicOn` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.9 | localZetaQuotient order | `Legendre.Zeta.localZetaQuotient_order` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.10 | localZetaRegularized order | `Legendre.Zeta.localZetaRegularized_order` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.11 | zeta disk ne one | `Legendre.Zeta.zeta_disk_ne_one` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.12 | localZetaDivisor eq zero of not mem | `Legendre.Zeta.localZetaDivisor_eq_zero_of_not_mem` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.13 | localZetaRegularized analyticOnNhd | `Legendre.Zeta.localZetaRegularized_analyticOnNhd` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.14 | localZetaRegularized ne zero | `Legendre.Zeta.localZetaRegularized_ne_zero` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.15 | localZetaDivisor eq zero of ne zero | `Legendre.Zeta.localZetaDivisor_eq_zero_of_ne_zero` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.16 | localZetaRegularized eq | `Legendre.Zeta.localZetaRegularized_eq` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.17 | localZetaRegularized eventuallyEq | `Legendre.Zeta.localZetaRegularized_eventuallyEq` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.18 | localZetaFactor eq prod | `Legendre.Zeta.localZetaFactor_eq_prod` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.19 | localZetaFactor logDeriv | `Legendre.Zeta.localZetaFactor_logDeriv` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.20 | logDeriv riemannZeta eq regularized add | `Legendre.Zeta.logDeriv_riemannZeta_eq_regularized_add` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.21 | localZetaDivisor support zero | `Legendre.Zeta.localZetaDivisor_support_zero` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.22 | localZetaPrincipalPart re nonneg | `Legendre.Zeta.localZetaPrincipalPart_re_nonneg` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.23 | localZetaDegree cast | `Legendre.Zeta.localZetaDegree_cast` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.24 | localZetaDegree le | `Legendre.Zeta.localZetaDegree_le` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.25 | localZetaFactor eq prod nat | `Legendre.Zeta.localZetaFactor_eq_prod_nat` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.26 | norm localZetaFactor center le | `Legendre.Zeta.norm_localZetaFactor_center_le` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.removal.27 | one fourth pow le norm localZetaFactor | `Legendre.Zeta.one_fourth_pow_le_norm_localZetaFactor` | **proved**; finite local zero removal; abs(t)≥3 |
| 2.regularized.1 | norm localZetaRegularized sphere le | `Legendre.Zeta.norm_localZetaRegularized_sphere_le` | **proved**; explicit bounds for the zero-removed quotient; abs(t)≥3 |
| 2.regularized.2 | norm localZetaRegularized disk le | `Legendre.Zeta.norm_localZetaRegularized_disk_le` | **proved**; explicit bounds for the zero-removed quotient; abs(t)≥3 |
| 2.regularized.3 | norm localZetaRegularized ratio le | `Legendre.Zeta.norm_localZetaRegularized_ratio_le` | **proved**; explicit bounds for the zero-removed quotient; abs(t)≥3 |
| 2.regularized.4 | exists localZetaLog | `Legendre.Zeta.exists_localZetaLog` | **proved**; explicit bounds for the zero-removed quotient; abs(t)≥3 |
| 2.regularized.5 | localZetaLogBound pos | `Legendre.Zeta.localZetaLogBound_pos` | **proved**; explicit bounds for the zero-removed quotient; abs(t)≥3 |
| 2.regularized.6 | localZetaLog re le | `Legendre.Zeta.localZetaLog_re_le` | **proved**; explicit bounds for the zero-removed quotient; abs(t)≥3 |
| 2.regularized.7 | exists localZetaLog bounded | `Legendre.Zeta.exists_localZetaLog_bounded` | **proved**; explicit bounds for the zero-removed quotient; abs(t)≥3 |
| 2.regularized.8 | norm logDeriv localZetaRegularized le | `Legendre.Zeta.norm_logDeriv_localZetaRegularized_le` | **proved**; explicit bounds for the zero-removed quotient; abs(t)≥3 |
| 2.localderiv.1 | neg logDeriv re le local | `Legendre.Zeta.neg_logDeriv_re_le_local` | **proved**; local principal-part estimates on Re(s)>1 |
| 2.localderiv.2 | neg logDeriv re le local sub zero | `Legendre.Zeta.neg_logDeriv_re_le_local_sub_zero` | **proved**; local principal-part estimates on Re(s)>1 |
| 2.polebound.1 | norm deriv zetaMellinRemainder le | `Legendre.Zeta.norm_deriv_zetaMellinRemainder_le` | **proved**; explicit real-axis pole estimates; 1<σ≤9/8 for the final bound |
| 2.polebound.2 | deriv poleRemovedZeta eq | `Legendre.Zeta.deriv_poleRemovedZeta_eq` | **proved**; explicit real-axis pole estimates; 1<σ≤9/8 for the final bound |
| 2.polebound.3 | one half le norm poleRemovedZeta | `Legendre.Zeta.one_half_le_norm_poleRemovedZeta` | **proved**; explicit real-axis pole estimates; 1<σ≤9/8 for the final bound |
| 2.polebound.4 | norm deriv poleRemovedZeta le | `Legendre.Zeta.norm_deriv_poleRemovedZeta_le` | **proved**; explicit real-axis pole estimates; 1<σ≤9/8 for the final bound |
| 2.polebound.5 | norm logDeriv poleRemovedZeta le | `Legendre.Zeta.norm_logDeriv_poleRemovedZeta_le` | **proved**; explicit real-axis pole estimates; 1<σ≤9/8 for the final bound |
| 2.polebound.6 | neg logDeriv real le pole | `Legendre.Zeta.neg_logDeriv_real_le_pole` | **proved**; explicit real-axis pole estimates; 1<σ≤9/8 for the final bound |
| 2.zerofree.1 | zetaZeroFreeK pos | `Legendre.Zeta.zetaZeroFreeK_pos` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.2 | zetaZeroFreeCost pos | `Legendre.Zeta.zetaZeroFreeCost_pos` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.3 | zetaZeroFreeConstant pos | `Legendre.Zeta.zetaZeroFreeConstant_pos` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.4 | zeta local log le | `Legendre.Zeta.zeta_local_log_le` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.5 | localZetaLogBound le five log | `Legendre.Zeta.localZetaLogBound_le_five_log` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.6 | localZetaLogBound two mul le | `Legendre.Zeta.localZetaLogBound_two_mul_le` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.7 | eighteen le log term | `Legendre.Zeta.eighteen_le_log_term` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.8 | eighteen le zeroFreeCost mul log | `Legendre.Zeta.eighteen_le_zeroFreeCost_mul_log` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.9 | riemannZeta ne zero of log region | `Legendre.Zeta.riemannZeta_ne_zero_of_log_region` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.10 | zetaZeroFreeK le ten | `Legendre.Zeta.zetaZeroFreeK_le_ten` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.11 | zetaZeroFreeCost le | `Legendre.Zeta.zetaZeroFreeCost_le` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.12 | rational le zetaZeroFreeConstant | `Legendre.Zeta.rational_le_zetaZeroFreeConstant` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.zerofree.13 | riemannZeta ne zero of explicit log region | `Legendre.Zeta.riemannZeta_ne_zero_of_explicit_log_region` | **proved**; effective logarithmic zero-free region and explicit constants |
| 2.removal.def | selected divisor, finite factor, regularized quotient and degree | `Legendre.Zeta.localZetaDivisor`, `localZetaFactor`, `localZetaRegularized`, `localZetaDegree` | definitions; finite support and order preservation proved |
| 2.zerofree.def | explicit analytic bounds and width coefficient | `Legendre.Zeta.localZetaLogBound`, `zetaZeroFreeK`, `zetaZeroFreeCost`, `zetaZeroFreeConstant` | definitions; positivity and rational width comparison proved |
| 2.argument.1 | localZetaDivisor mem ball | `Legendre.Zeta.localZetaDivisor_mem_ball` | **proved**; high-disk argument principle with zero-free boundary, not a global N(T) estimate |
| 2.argument.2 | localZetaRegularized logDeriv analyticOnNhd | `Legendre.Zeta.localZetaRegularized_logDeriv_analyticOnNhd` | **proved**; high-disk argument principle with zero-free boundary, not a global N(T) estimate |
| 2.argument.3 | circleIntegral localZetaRegularized logDeriv | `Legendre.Zeta.circleIntegral_localZetaRegularized_logDeriv` | **proved**; high-disk argument principle with zero-free boundary, not a global N(T) estimate |
| 2.argument.4 | circleIntegral logDeriv riemannZeta eq degree | `Legendre.Zeta.circleIntegral_logDeriv_riemannZeta_eq_degree` | **proved**; high-disk argument principle with zero-free boundary, not a global N(T) estimate |
| 2.reflection.1 | completedZeta analyticAt | `Legendre.Zeta.completedZeta_analyticAt` | **proved**; critical-strip reflection preserving analytic multiplicity |
| 2.reflection.2 | zeta order eq completed | `Legendre.Zeta.zeta_order_eq_completed` | **proved**; critical-strip reflection preserving analytic multiplicity |
| 2.reflection.3 | zeta order one sub | `Legendre.Zeta.zeta_order_one_sub` | **proved**; critical-strip reflection preserving analytic multiplicity |
| 2.reflection.4 | zeroMultiplicity one sub | `Legendre.Zeta.zeroMultiplicity_one_sub` | **proved**; critical-strip reflection preserving analytic multiplicity |
| 2.reflection.5 | NontrivialZero.one sub | `Legendre.Zeta.NontrivialZero.one_sub` | **proved**; critical-strip reflection preserving analytic multiplicity |
| 2.reflection.6 | rightHalfZero properties | `Legendre.Zeta.rightHalfZero_properties` | **proved**; critical-strip reflection preserving analytic multiplicity |
| 2.reflection.7 | rightHalfZero injOn | `Legendre.Zeta.rightHalfZero_injOn` | **proved**; critical-strip reflection preserving analytic multiplicity |
| 2.countdisk.1 | counting disk coordinates | `Legendre.Zeta.counting_disk_coordinates` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countdisk.2 | counting disk ne one | `Legendre.Zeta.counting_disk_ne_one` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countdisk.3 | riemannZeta analyticOnNhd counting disk | `Legendre.Zeta.riemannZeta_analyticOnNhd_counting_disk` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countdisk.4 | norm riemannZeta counting disk le | `Legendre.Zeta.norm_riemannZeta_counting_disk_le` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countdisk.5 | countingDivisor finite | `Legendre.Zeta.countingDivisor_finite` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countdisk.6 | countingDivisor eq multiplicity | `Legendre.Zeta.countingDivisor_eq_multiplicity` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countdisk.7 | countingDegree cast | `Legendre.Zeta.countingDegree_cast` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countdisk.8 | mem countingZeros | `Legendre.Zeta.mem_countingZeros` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countdisk.9 | countingDegree le | `Legendre.Zeta.countingDegree_le` | **proved**; wider Jensen counting disks; abs(t)≥4 |
| 2.countcover.1 | lowCountingSet finite | `Legendre.Zeta.lowCountingSet_finite` | **proved**; finite multiplicity-preserving cover of the full critical strip |
| 2.countcover.2 | countingHeight abs ge | `Legendre.Zeta.countingHeight_abs_ge` | **proved**; finite multiplicity-preserving cover of the full critical strip |
| 2.countcover.3 | countingHeightIndex lt | `Legendre.Zeta.countingHeightIndex_lt` | **proved**; finite multiplicity-preserving cover of the full critical strip |
| 2.countcover.4 | countingHeight index eq | `Legendre.Zeta.countingHeight_index_eq` | **proved**; finite multiplicity-preserving cover of the full critical strip |
| 2.countcover.5 | rightHalf mem counting disk | `Legendre.Zeta.rightHalf_mem_counting_disk` | **proved**; finite multiplicity-preserving cover of the full critical strip |
| 2.countcover.6 | rightHalf mem countingZeros | `Legendre.Zeta.rightHalf_mem_countingZeros` | **proved**; finite multiplicity-preserving cover of the full critical strip |
| 2.countcover.7 | rightHalfZero mem cover | `Legendre.Zeta.rightHalfZero_mem_cover` | **proved**; finite multiplicity-preserving cover of the full critical strip |
| 2.globalcount.1 | sum zeroMultiplicity union le | `Legendre.Zeta.sum_zeroMultiplicity_union_le` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.2 | sum zeroMultiplicity biUnion le | `Legendre.Zeta.sum_zeroMultiplicity_biUnion_le` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.3 | zeroCount le cover | `Legendre.Zeta.zeroCount_le_cover` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.4 | zeroCount le sum countingDegree | `Legendre.Zeta.zeroCount_le_sum_countingDegree` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.5 | zeroCount le global bound | `Legendre.Zeta.zeroCount_le_global_bound` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.6 | globalZeroCountConstant pos | `Legendre.Zeta.globalZeroCountConstant_pos` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.7 | global counting log le | `Legendre.Zeta.global_counting_log_le` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.8 | zeroCount le mul log | `Legendre.Zeta.zeroCount_le_mul_log` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.9 | zeroCount isBigO | `Legendre.Zeta.zeroCount_isBigO` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.10 | zeroDensityCount le mul log | `Legendre.Zeta.zeroDensityCount_le_mul_log` | **proved**; global N(T) bounds; final C T log T bound for T≥7 |
| 2.globalcount.def | reflected zeros, finite counting disks and cover, fixed low-height degree, global constant | `Legendre.Zeta.rightHalfZero`, `countingDivisor`, `countingZeros`, `countingDegree`, `lowCountingSet`, `lowCountingDegree`, `countingHeight`, `countingHeightIndex`, `globalCountingCover`, `globalZeroCountConstant` | definitions; finiteness, multiplicity preservation and positive fixed coefficient proved |
| 2.54 | Layer 2 forward Abel / weighted pole foundation: vonMangoldt partialSums floor eq psi | `Legendre.Zeta.vonMangoldt_partialSums_floor_eq_psi` | **proved**; not Perron inversion |
| 2.55 | Layer 2 forward Abel / weighted pole foundation: vonMangoldt partialSums isBigO | `Legendre.Zeta.vonMangoldt_partialSums_isBigO` | **proved**; not Perron inversion |
| 2.56 | Layer 2 forward Abel / weighted pole foundation: vonMangoldt partialSums complex eq psi | `Legendre.Zeta.vonMangoldt_partialSums_complex_eq_psi` | **proved**; not Perron inversion |
| 2.57 | Layer 2 forward Abel / weighted pole foundation: norm psi mellin integrand le | `Legendre.Zeta.norm_psi_mellin_integrand_le` | **proved**; not Perron inversion |
| 2.58 | Layer 2 forward Abel / weighted pole foundation: psi mellin integrable | `Legendre.Zeta.psi_mellin_integrable` | **proved**; not Perron inversion |
| 2.59 | Layer 2 forward Abel / weighted pole foundation: neg logDeriv eq psi integral | `Legendre.Zeta.neg_logDeriv_eq_psi_integral` | **proved**; not Perron inversion |
| 2.60 | Layer 2 forward Abel / weighted pole foundation: perronWeight one | `Legendre.Zeta.perronWeight_one` | **proved**; not Perron inversion |
| 2.61 | Layer 2 forward Abel / weighted pole foundation: perronWeight continuousAt one | `Legendre.Zeta.perronWeight_continuousAt_one` | **proved**; not Perron inversion |
| 2.62 | Layer 2 forward Abel / weighted pole foundation: tendsto sub mul perronIntegrand at one | `Legendre.Zeta.tendsto_sub_mul_perronIntegrand_at_one` | **proved**; not Perron inversion |
| 3.def | real prime counting, offset logarithmic integral, classical error and derivative | `Legendre.PNT.primeCount`, `logarithmicIntegral`, `classicalError`, `classicalErrorDeriv` | definitions; offset Li from 2 |
| 3.1 | PNT+ smoothing and Mellin-calculus slice | `Legendre/PNT/{Auxiliary,Sobolev,Fourier,SmoothExistence,MellinCalculus}.lean` | **proved upstream, adapted**; Apache-2.0, pinned source in `docs/pnt-provenance.md` |
| 3.2 | PNT+ rectangular Cauchy/residue calculations | `Legendre/PNT/{Rectangle,ResidueCalcOnRectangles}.lean` | **proved upstream, adapted**; generic simple-pole theorem, not a zeta zero-sum specialization |
| 3.3 | PNT+ analytic zeta inputs | `Legendre/PNT/{EulerMaclaurin,ZetaBounds,ZetaConj}.lean`, two small `PNT/Mathlib/` modules | **proved upstream, adapted**; no new dependency pins |
| 3.4 | PNT+ general-strength PNT and classical ψ estimate | `GenStrengthPNT`, `MediumPNT`, `StrongPNT` | **proved upstream, adapted**; selected dependency chain only |
| 3.5 | derivative of the classical error scale | `Legendre.PNT.classicalError_hasDerivAt`, `exp_le_two_mul_classicalErrorDeriv` | **proved** for x>1 under the stated comparison |
| 3.6 | absorption of the elementary prime-power contribution | `Legendre.PNT.sqrt_le_classicalError`, `sqrt_isBigO_classicalError` | **proved**; eventual logarithmic threshold |
| 3.7 | eventual positivity and growth of the error scale | `Legendre.PNT.eventually_classicalError_bounds`, `classicalError_eventually_ge_one` | **proved** |
| 3.8 | offset logarithmic-integral identity | `Legendre.PNT.logarithmicIntegral_eq` | **proved** by integration by parts, x≥2 |
| 3.9 | exact Abel identity and integrability for the π error | `Legendre.PNT.primeCount_sub_logarithmicIntegral`, `theta_error_intervalIntegrable` | **proved**; integrability precedes integral subtraction/splitting |
| 3.10 | θ error ⇒ π−Li₂ error, preserving c | `Legendre.PNT.primeCount_error_of_theta` | **proved**; original downstream partial-summation transfer |
| 3.11 | ψ=x+O(x exp(−c√log x)) | `Legendre.PNT.psi_classical_error` | **proved**; PNT+ interface, c>0 existential |
| 3.12 | common classical error for ψ, θ and π−Li₂ | `Legendre.PNT.pnt_classical_error`, `pnt_eventual_bound` | **proved**; existential coefficient/threshold, no numerical Dusart claim |
| 3.13 | classical error is o(x) | `Legendre.PNT.classicalError_isLittleO` | **proved** for c>0 |
| 3.14 | exact smoothed finite-height contour decomposition | `Legendre.PNT.exists_smoothed_truncated_formula` | **proved**; five contour/tail terms retained, strip existence proved |
| 3.15 | arbitrary-multiplicity logarithmic residue and weighted kernel poles | `Legendre.Zeta.tendsto_mul_logDeriv_of_analytic`, `residue_perronIntegrand_at_zero/one`, `perronIntegrand_order_at_zero/one` | **proved**; no simple-zero assumption |
| 3.16 | finite symmetric zero set, positive cutoff and admissible heights | `Legendre.Zeta.symmetricZeros_finite`, `exists_symmetricZeroCutoff`, `exists_good_zero_height`, `perronRectangleBorder_nonvanishing` | **proved**; both signs of height, cutoff strictly left of every zero |
| 3.17 | specialized rectangle residue formula and exact finite zero sum | `Legendre.Zeta.perronRectangle_integral_eq`, `truncatedPerron_explicit`, `halfWeightedPsi_explicit` | **proved**; all critical-strip zeros at the selected height counted with analytic multiplicity |
| 3.18 | contour integrability, finite boundary bound and quantitative remainder | `Legendre.Zeta.perron_rectangleBorderIntegrable`, `exists_perron_boundary_bound`, `norm_truncatedExplicitError_le_boundary_bound` | **proved**; bound depends on the selected a, T and M |
| 3.19 | unconditional finite-height explicit formula | `Legendre.Zeta.exists_truncated_explicit_formula` | **proved**; T in (H,H+1), no universal log-squared height bound claimed |
| 3.20 | finite unit-height cells, signed disk cover and multiplicity-weighted logarithmic count | `Legendre.Zeta.unitZeros_finite`, `unitCell_mem_counting_disk`, `rightHalfZero_mem_unit_cover`, `unitZeroCount_le_countingDegrees`, `unitZeroCount_le_log`, `unitZeros_card_le_count`, `zeroCount_increment_le_unitZeroCount` | **proved**; count bound for H≥4, includes zeros left of 1/2 |
| 3.21 | quantitative avoidance of any finite set of real ordinates | `Legendre.Zeta.exists_height_avoiding_finset` | **proved**; gap 1/(4(n+1)) in an open unit interval |
| 3.22 | logarithmic count of nearby ordinates, including both signs | `Legendre.Zeta.nearbyZeroOrdinates_card_le_counts`, `nearbyZeroOrdinates_card_le_log`, `nontrivialZero_exists_positive_ordinate`, `mem_nearbyZeroOrdinates` | **proved**; three unit cells, H≥5 for the logarithmic bound |
| 3.23 | explicit good-height gap and inverse-log lower bound | `Legendre.Zeta.goodHeightGap_bounds`, `exists_good_height_quantitative`, `goodHeightSeparationConstant_pos`, `goodHeightGap_ge_inv_log`, `exists_good_height_log_separation` | **proved**; c/log H separation for H≥7, explicit c>0 |
| 3.24 | regularized Cauchy estimate and finite principal parts at separated points | `Legendre.Zeta.norm_logDeriv_localZetaRegularized_le_wide`, `zeta_ne_zero_of_local_separation`, `norm_localZetaPrincipalParts_le`, `norm_logDeriv_le_local_separated` | **proved**; radius 9/8 from 2+it, principal-parts bound degree/δ |
| 3.25 | explicit coefficient and uniform local estimates at good heights | `Legendre.Zeta.goodHeightLogDerivativeConstant_pos`, `zero_distance_of_height_separation`, `localZeta_log_le_at_good_height` | **proved**; constant independent of H |
| 3.26 | paired horizontal log-squared bound and nonvanishing | `Legendre.Zeta.norm_logDeriv_le_at_good_height`, `zeta_ne_zero_at_good_height`, `exists_good_height_logDeriv_bound` | **proved**; both ±T, H≥7, Re(s)≥7/8 |
| 3.27 | horizontal Perron estimate from segment data and genuine integrability | `Legendre.Zeta.norm_perron_horizontal_le_of_segment_bound`, `perron_horizontal_intervalIntegrable` | **proved**; no whole-boundary hypothesis needed |
| 3.28 | common selected heights with horizontal Perron bounds uniform in x and endpoints | `Legendre.Zeta.exists_good_height_perron_horizontal_bound` | **proved**; 7/8≤α≤σ; full left contour still uncontrolled |
| 3.29 | full finite zero-sum formula on quantitatively separated heights | `Legendre.Zeta.exists_truncated_explicit_formula_good_height` | **proved**; original contour-dependent M retained |
| 3.goodheight.def | cells, forbidden ordinates, gap and explicit positive constants | `Legendre.Zeta.unitZeros`, `unitZeroCount`, `nearbyHeightZeros`, `nearbyZeroOrdinates`, `goodHeightGap`, `goodHeightSeparationConstant`, `goodHeightLogDerivativeConstant` | definitions; [precise constants and scope](zeta-good-heights.md) |
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

Layer 3 validation (2026-11-01): full build passed 4,036 jobs and the audit
passed all 1,970 expected targets, including the finite zero-sum formula, its
contour-dependent remainder, and all 52 declarations from the six quantitative
good-height modules (including generated helpers).

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
