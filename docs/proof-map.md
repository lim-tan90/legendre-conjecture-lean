# Proof map: literature step ↔ Lean declaration ↔ status

This table is the honesty contract of the repository.  “Statement only” means
the mathematical statement is encoded as a `Prop`, but its proof is **not**
formalized.  “Proved” means `lake build` checks a complete proof term.

Rows 9a–9g record the **statement-level Layer 5** infrastructure from
`Legendre/Layer5.lean`: the normalized exponent `+ε`/constant/threshold conventions
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
| 9e | normalized exponent `+ε` form ↔ coarse exponent-limit interface | `Legendre.shortIntervalStatement_iff_exponentLimit` | **proved** |
| 9f | normalized exponent `θ < 1/2` statement ⇒ Legendre eventually | `Legendre.legendre_eventually_of_shortIntervalStatement_lt_half` | **proved** |
| 9g | each normalized exponent statement ↔ its coarse `Prop` | `Legendre.*Paper_iff` (nine theorems) | **proved** |
| comparator.history | All 17 historical targets/results | `Legendre.Literature.*`; [catalog](literature-comparators.md) | Independent exponent specifications; 24 typed catalog/closed-proof consumers and 12 semantic regression guards; only Bertrand/Nagura supply closed historical interval proofs |
| comparator.elementary | Cramér conjectural log-square gap to eventual Legendre | `Legendre.Literature.cramer_positive_exponent`, `cramer_implies_eventual_legendre` | **proved conditional bridges**; no assertion of the conjectural input |
| comparator.endpoints | Strict real Nagura and strict Bertrand | `Legendre.Literature.nagura_comparator`, `bertrand_comparator` | **proved**, source endpoint/range retained |
| comparator.orientation | BHP backward interval to normalized gap/exponent | `Legendre.Literature.gapProgress_of_backward`, `bakerHarmanPintz_comparator`, `forwardProgress_of_gap` | **proved conditional bridges**, same exponent, harmless constant and arbitrary positive epsilon |
| comparator.density | Curved density estimates to global 12/5 and 30/13 targets | `Legendre.Literature.huxley_global_comparator`, `guthMaynard_global_comparator` | **proved conditional comparisons**, inputs remain open, sigma-uniform constants retained |
| comparator.layers | All project Lean files classified, Layer 0–4 benchmark coverage | `Legendre.Literature.layer2_comparator`, `layer3_comparator`, `layer3_no_fixed_power_comparator`, `layer4_mean_comparator` | **proved prerequisites / comparison guard**; no new historical power theorem claimed |
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
| 3.28 | common selected heights with horizontal Perron bounds uniform in x and endpoints | `Legendre.Zeta.exists_good_height_perron_horizontal_bound` | **proved**; 7/8≤α≤σ; full-contour extension below reaches −1/8 |
| 3.29 | full finite zero-sum formula on quantitatively separated heights | `Legendre.Zeta.exists_truncated_explicit_formula_good_height` | **proved**; original contour-dependent M retained |
| 3.goodheight.def | cells, forbidden ordinates, gap and explicit positive constants | `Legendre.Zeta.unitZeros`, `unitZeroCount`, `nearbyHeightZeros`, `nearbyZeroOrdinates`, `goodHeightGap`, `goodHeightSeparationConstant`, `goodHeightLogDerivativeConstant` | definitions; [precise constants and scope](zeta-good-heights.md) |
| 3.30 | positivity and two-point control of the classical error | `Legendre.PNT.classicalError_pos`, `classicalError_le_two_mul` | **proved**; for c≥0 and x≤y≤2x |
| 3.31 | theta endpoint errors give a prime interval | `Legendre.PNT.hasPrimeIn_of_classical_theta_error`, `eventually_hasPrimeIn_of_theta_classical_error` | **proved**; explicit coefficient 3C+1 |
| 3.32 | absorb fixed coefficients by decreasing the decay constant | `Legendre.PNT.eventually_mul_classicalError_le` | **proved** for d<c |
| 3.33 | unconditional classical PNT and prime intervals at a common rate | `Legendre.PNT.pnt_classical_error_with_prime_intervals` | **proved**; one c and positive interval coefficient |
| 3.34 | coefficient-one classical-rate prime intervals and relative intervals | `Legendre.PNT.pnt_hasPrimeIn_classical_interval`, `eventually_hasPrimeIn_relative` | **proved**; ∃c>0, ∃X≥1, prime in (x,x+E_c(x)] for all x≥X |
| 3.35 | domination of every fixed sublinear power | `Legendre.PNT.eventually_rpow_le_classicalError`, `rpow_isLittleO_classicalError`, `classicalError_not_isBigO_rpow` | **proved** for a<1; no fixed polynomial error inferred |
| 3.36 | natural-number prime-gap interface | `Legendre.PNT.pnt_prime_gap_classical` | **proved**; every sufficiently large prime has a larger prime within E_c(p) |
| 3.37 | final common-constant Layer 3 package | `Legendre.PNT.layer3_pnt_package` | **proved**; same c for ψ/θ/π error, coefficient-one prime intervals and asymptotic comparisons; [completion scope](layer3-completion.md) |
| 3.38 | Continuous periodic Euler primitive | `Legendre.Zeta.zetaEulerPrimitive_continuous`, `zetaEulerPrimitive_hasDerivWithinAt_right`; [ZetaEulerPrimitive.lean](../Legendre/ZetaEulerPrimitive.lean) | **proved**; including right derivatives at integers |
| 3.39 | Second Euler Mellin remainder | `Legendre.Zeta.zetaSecondMellinRemainder_convergent`, `norm_zetaSecondMellinRemainder_le`; [ZetaSecondMellin.lean](../Legendre/ZetaSecondMellin.lean) | **proved**; absolute convergence and analyticity on Re(s)>−1 |
| 3.40 | Second Euler continuation and polynomial bound | `Legendre.Zeta.zetaMellinRemainder_eq_second`, `riemannZeta_eq_second_euler`, `norm_riemannZeta_le_second_euler`; [ZetaSecondEuler.lean](../Legendre/ZetaSecondEuler.lean) | **proved**; integration by parts and identity theorem; bounds reach Re(s)=−1/2 |
| 3.41 | Negative-strip nonvanishing | `Legendre.Zeta.riemannZeta_ne_zero_negative_strip`, `riemannZeta_ne_zero_perron_left`; [ZetaNegativeStrip.lean](../Legendre/ZetaNegativeStrip.lean) | **proved**; −1<Re(s)≤0, including the origin |
| 3.42 | Wide local Jensen bound | `Legendre.Zeta.norm_riemannZeta_wide_disk_le`, `zeta_wide_divisor_sum_le`; [ZetaWideLocalBound.lean](../Legendre/ZetaWideLocalBound.lean) | **proved**; outer radius 5/2 around 2+it, abs(t)≥4 |
| 3.43 | Wide local divisor removal | `Legendre.Zeta.wideZetaRegularized_analyticOnNhd`, `logDeriv_riemannZeta_eq_wide_regularized_add`, `wideZetaDegree_le`; [ZetaWideZeroRemoval.lean](../Legendre/ZetaWideZeroRemoval.lean) | **proved**; analytic multiplicities preserved, inner radius 9/4 |
| 3.44 | Wide regularized analytic logarithm | `Legendre.Zeta.exists_wideZetaLog_bounded`, `norm_logDeriv_wideZetaRegularized_le`; [ZetaWideRegularizedBound.lean](../Legendre/ZetaWideRegularizedBound.lean) | **proved**; Cauchy estimate reaches radius 17/8 |
| 3.45 | Wide separated logarithmic derivative | `Legendre.Zeta.wide_disk_zero_nontrivial`, `norm_logDeriv_le_wide_separated`; [ZetaWideSeparated.lean](../Legendre/ZetaWideSeparated.lean) | **proved**; regularized bound plus degree/separation |
| 3.46 | Full horizontal good-height bound | `Legendre.Zeta.fullGoodHeightLogDerivativeConstant_pos`, `exists_full_good_height_logDeriv_bound`; [ZetaFullGoodHeightBounds.lean](../Legendre/ZetaFullGoodHeightBounds.lean) | **proved**; both ±T; every Re(s)≥−1/8; explicit positive coefficient |
| 3.47 | Absolute fixed-left-line bound | `Legendre.Zeta.continuous_logDeriv_perron_left`, `exists_uniform_perron_left_bound`; [ZetaPerronLeft.lean](../Legendre/ZetaPerronLeft.lean) | **proved**; one absolute C with norm≤C log(abs(t)+5) for all t |
| 3.48 | Meromorphic Perron kernel across the origin | `Legendre.Zeta.perronIntegrand_hasSimplePolesOn_all`, `residue_perronIntegrand_origin`; [PerronOriginResidue.lean](../Legendre/PerronOriginResidue.lean) | **proved**; at most simple poles; origin residue −ζ′(0)/ζ(0) |
| 3.49 | Evaluated zeta derivative at zero | `Legendre.Zeta.deriv_riemannZeta_origin`, `logDeriv_riemannZeta_origin`; [ZetaOriginValue.lean](../Legendre/ZetaOriginValue.lean) | **proved**; ζ′(0)=−log(2π)/2, log derivative=log(2π) |
| 3.50 | Fixed negative rectangle residue identity | `Legendre.Zeta.fullPerron_poles_subset`, `fullPerronRectangle_integral_eq`; [PerronFullRectangle.lean](../Legendre/PerronFullRectangle.lean) | **proved**; candidates {0,1}∪Z(T), removable candidates contribute zero |
| 3.51 | Uniform side integrals | `Legendre.Zeta.continuous_perronIntegrand_left`, `norm_perron_left_uniform`, `norm_perron_full_horizontal_le`; [PerronUniformBounds.lean](../Legendre/PerronUniformBounds.lean) | **proved**; genuine integrability; complete left and horizontal bounds |
| 3.52 | Full uniform finite explicit formula | `Legendre.Zeta.halfWeightedPsi_full_explicit`, `norm_fullExplicitError_le_uniform`, `exists_full_truncated_explicit_formula`; [PerronFullExplicit.lean](../Legendre/PerronFullExplicit.lean) | **proved**; ψ₀=x−zero sum−log(2π)+E; one absolute contour coefficient before H,T,σ,x |
| 3.validation | nine independently compiled consumer checks | `Legendre/Tests/Layer3.lean` | normal Layer3 import only; includes common height at x=1 and x=1/2, origin residue, small-x integrability and negative endpoints; all test declarations audited |
| 4.1 | Unit phases and endpoint-independent kernel cancellation | `Legendre.Density.realPhase_mul_conj`, `oscillatoryKernel_zero`, `oscillatoryKernel_eq`, `norm_oscillatoryKernel_le`; [ExponentialKernel.lean](../Legendre/ExponentialKernel.lean) | **proved**; exact zero-frequency case; nonzero u gives 2/abs(u) |
| 4.2 | Finite Gram-matrix integral and exact diagonal separation | `Legendre.Density.continuous_exponentialSum`, `exponentialSum_norm_sq`, `integral_exponentialSum_norm_sq`, `integral_exponentialSum_diagonal`; [ExponentialMeanValue.lean](../Legendre/ExponentialMeanValue.lean) | **proved**; valid with coincident frequencies, all cross terms retained |
| 4.3 | Uniform off-diagonal mean-value error | `Legendre.Density.norm_meanValueOffDiagonal_le`, `abs_integral_exponentialSum_sub_diagonal_le`; [ExponentialMeanValue.lean](../Legendre/ExponentialMeanValue.lean) | **proved**; explicit pair sum; injective frequencies required; independent of endpoints |
| 4.4 | Symmetric row bound transfers to coefficient energy | `Legendre.Density.meanValueError_eq_sum`, `meanValueError_le_energy`; [ExponentialMeanValue.lean](../Legendre/ExponentialMeanValue.lean) | **proved**; Schur estimate 2R times coefficient energy |
| 4.5 | Exact limiting mean of a fixed finite exponential sum | `Legendre.Density.tendsto_exponentialSum_mean_square`; [ExponentialMeanValue.lean](../Legendre/ExponentialMeanValue.lean) | **proved**; average converges to coefficient energy for injective frequencies |
| 4.6 | Logarithmic frequency spacing | `Legendre.Density.log_gap_lower`, `inv_log_gap_le`, `inv_abs_log_gap_le`; [DirichletSpacing.lean](../Legendre/DirichletSpacing.lean) | **proved**; reciprocal log gap ≤N/abs(m−n), distinct positive m,n≤N |
| 4.7 | Harmonic row bounds by two gap injections | `Legendre.Density.sum_inv_left_gaps_le`, `sum_inv_right_gaps_le`, `sum_inv_abs_nat_gaps_le`, `sum_inv_abs_log_gaps_le`; [DirichletSpacing.lean](../Legendre/DirichletSpacing.lean) | **proved**; integer-gap row≤2H_N; log-gap row≤2NH_N |
| 4.8 | Usual Dirichlet-polynomial convention and frequency injectivity | `Legendre.Density.realPhase_neg_log_eq_cpow`, `dirichletPolynomial_eq_sum`, `dirichlet_frequencies_inj`, `continuous_dirichletPolynomial`; [DirichletMeanValue.lean](../Legendre/DirichletMeanValue.lean) | **proved**; Σ over 1≤n≤N; arbitrary complex coefficients, N=0 allowed |
| 4.9 | Explicit quantitative Dirichlet mean square | `Legendre.Density.dirichlet_meanValueError_le`, `abs_integral_dirichletPolynomial_sub_diagonal_le`, `abs_integral_dirichletPolynomial_sub_diagonal_le_log`, `integral_dirichletPolynomial_norm_sq_le`; [DirichletMeanValue.lean](../Legendre/DirichletMeanValue.lean) | **proved**; error≤4NH_N E≤4N(1+log N)E, uniform in both endpoints |
| 4.10 | Long-interval Dirichlet mean square | `Legendre.Density.tendsto_dirichletPolynomial_mean_square`; [DirichletMeanValue.lean](../Legendre/DirichletMeanValue.lean) | **proved**; fixed N and coefficients, limit equals energy |
| 4.11 | Continuous large-value measure bound | `Legendre.Density.dirichlet_large_values_mul_measure_le`, `dirichlet_large_values_measure_le`; [DirichletLargeValues.lean](../Legendre/DirichletLargeValues.lean) | **proved**; A≤B, V>0, threshold equality included; no separated-point count asserted |
| 4.12 | Uniform density-exponent convention and weakening | `Legendre.Zeta.HasZeroDensityEstimate`, `HasZeroDensityEstimate.mono`; [ZeroDensity.lean](../Legendre/ZeroDensity.lean) | **proved**; Prop definition / proved implication; epsilon additive in exponent, C before sigma |
| 4.13 | Uniform logarithmic-loss absorption and conditional density transfer | `Legendre.Zeta.exists_log_pow_le_rpow`, `hasZeroDensityEstimate_of_log_bound`; [ZeroDensity.lean](../Legendre/ZeroDensity.lean) | **proved**; every fixed log power absorbed into T^epsilon; analytic density bound is a hypothesis |
| 4.14 | Unconditional near-one density count | `Legendre.Zeta.zero_height_lt_three_of_near_one`, `zeroDensityCount_le_low_of_near_one`, `zeroDensityCount_rational_near_one`; [ZeroDensity.lean](../Legendre/ZeroDensity.lean) | **proved**; rational moving cutoff count≤fixed N(3), T≥3; no fixed-strip power saving claimed |
| 4.15 | Finite reciprocal-square spacing and circle reduction | `Legendre.LargeSieve.positive_set_inverse_squares`, `separated_set_inverse_squares`, `circleSeparated_inverse_square_row`; [LargeSieve/SeparatedSetSquares.lean](../Legendre/LargeSieve/SeparatedSetSquares.lean) | **proved**; ported finite spacing proof chain |
| 4.16 | Concrete skew-kernel square identity and Hermitian eigenvector cancellation | `Legendre.LargeSieve.skew_kernel_square_entry`, `kernel_eigenvalue_bound`, `hermitian_eigenvector_commutator`; [LargeSieve/KernelEigenvalueBound.lean](../Legendre/LargeSieve/KernelEigenvalueBound.lean) | **proved**; ported generic matrix identity and spectral bound |
| 4.17 | Finite cosecant Hilbert inequality and spectral norm bound | `Legendre.LargeSieve.cosecant_eigenvalue_bound`, `cosecantMatrix_norm_bound`, `cosecant_hilbert_bound`; [LargeSieve/CosecantHilbertBound.lean](../Legendre/LargeSieve/CosecantHilbertBound.lean) | **proved**; circle-separated frequencies, explicit delta inverse |
| 4.18 | Finite phase Gram identity and matrix duality | `Legendre.LargeSieve.sieve_phase_gram`, `sieve_dual_energy_bound`, `finite_matrix_duality`; [LargeSieve/SieveDualEnergy.lean](../Legendre/LargeSieve/SieveDualEnergy.lean) | **proved**; source proof chain, all complex coefficients |
| 4.19 | Reduced-fraction separation and public additive large sieve | `Legendre.LargeSieve.reduced_fraction_circle_separation`, `publishedAdditiveLargeSieve`, `additive_large_sieve`, `separated_realPhase_large_sieve`; [LargeSieve.lean](../Legendre/LargeSieve.lean) | **proved**; M+Q²; zero M/Q included; phase conventions checked |
| 4.20 | Local Sobolev bound and separated sampling intervals | `Legendre.Density.length_mul_value_le_integral`, `LargeSieve.separated_sampling`; [SobolevSampling.lean](../Legendre/SobolevSampling.lean) | **proved**; genuine integrability, half-open disjoint sample intervals |
| 4.21 | Derivative polynomial and coefficient energy | `Legendre.Density.dirichletPolynomial_hasDerivAt`, `derivative_coefficientEnergy_le`, `abs_norm_sq_derivative_le`; [DirichletDerivative.lean](../Legendre/DirichletDerivative.lean) | **proved**; same support, derivative energy at most log²N times original energy |
| 4.22 | Actual separated-sample energy and large-value cardinality | `Legendre.Density.sum_dirichletPolynomial_samples_le`, `dirichlet_large_sample_card_le`; [DirichletSampling.lean](../Legendre/DirichletSampling.lean) | **proved**; arbitrary finite sample sets, positive spacing and threshold |
| 4.23 | Complex Gram row bound and Dirichlet correlation kernel | `Legendre.Density.complex_quadratic_le_norm_rows`, `finite_gram_row_bound`, `dirichlet_samples_le_gram_rows`; [GramLargeValues.lean](../Legendre/GramLargeValues.lean) | **proved**; generalizes attributed upstream quadratic argument |
| 4.24 | Finite Halasz--Montgomery energy and large-value counts | `Legendre.Density.halasz_montgomery_energy`, `halasz_montgomery_large_values`, `halasz_montgomery_card_le`; [HalaszMontgomery.lean](../Legendre/HalaszMontgomery.lean) | **proved**; off-diagonal correlation bound explicit, no density estimate assumed |
| 4.25 | Naturally weighted separated covers | `Legendre.Density.weighted_neighbor_le`, `exists_weighted_separated_representatives`; [WeightedSeparation.lean](../Legendre/WeightedSeparation.lean) | **proved**; generalizes upstream cover; natural weights retained |
| 4.26 | Separated representatives of actual zeta zeros | `Legendre.Zeta.density_window_mass_le`, `densityLocalMassBound_le_log`, `exists_density_separated_representatives`; [ZetaDensitySelection.lean](../Legendre/ZetaDensitySelection.lean) | **proved**; full analytic multiplicities; uniform absolute logarithmic loss |
| 4.27 | Detector-to-density reduction | `Legendre.Zeta.zeroDensityCount_le_of_dirichlet_detector`; [ZeroDetectionReduction.lean](../Legendre/ZeroDetectionReduction.lean) | **proved**; proved conditional theorem; analytic detector property explicit |
| 4.28 | Real-line reciprocal Hilbert inequality | `Legendre.LargeSieve.reciprocal_hilbert_bound`; [ReciprocalHilbert.lean](../Legendre/ReciprocalHilbert.lean) | **proved**; inverse-square rows, eigenvalues and operator norm; π/δ energy constant |
| 4.29 | Separated-frequency mean-square cancellation | `Legendre.Density.abs_integral_exponentialSum_sub_diagonal_le_separation`; [SeparatedMeanValue.lean](../Legendre/SeparatedMeanValue.lean) | **proved**; exact endpoint Hilbert forms; 2π/δ energy error |
| 4.30 | Linear Dirichlet mean-square error | `Legendre.Density.abs_integral_dirichletPolynomial_sub_diagonal_le_linear`; [DirichletMeanValueSharp.lean](../Legendre/DirichletMeanValueSharp.lean) | **proved**; 2πN energy error, all endpoints, N=0 included |
| 4.31 | Optimized separated sampling | `Legendre.Density.sum_dirichletPolynomial_samples_le_linear_log`, `dirichlet_large_sample_card_le_linear_log`; [DirichletSamplingSharp.lean](../Legendre/DirichletSamplingSharp.lean) | **proved**; factor δ⁻¹+2 log N for N>1, linear length error |
| 4.32 | Improved detector-to-density reduction | `Legendre.Zeta.zeroDensityCount_le_of_dirichlet_detector_linear_log`; [ZeroDetectionSharp.lean](../Legendre/ZeroDetectionSharp.lean) | **proved conditional theorem**; analytic detector property remains explicit |
| 4.33 | Finite Euler summation with the principal pole retained | `Legendre.Zeta.riemannZeta_eq_finite_euler`, `norm_riemannZeta_sub_finite_euler_le`; [ZetaFiniteEuler.lean](../Legendre/ZetaFiniteEuler.lean) | **proved**; Re(s)>0, N≥1, explicit half-unit remainder |
| 4.34 | Möbius cancellation and exact finite mollifier product | `Legendre.Density.Detector.finite_mollifier_identity`; [FiniteMollifier.lean](../Legendre/ZeroDetector/FiniteMollifier.lean) | **proved**; all complex arguments, low coefficients cancel, support and divisor bounds |
| 4.35 | Actual compensated zero detector | `Legendre.Density.Detector.actual_zero_detector_alternative`; [ActualZetaDetector.lean](../Legendre/ZeroDetector/ActualZetaDetector.lean) | **proved**; length (32HX)², remainder 9/64, both detection branches retained |
| 4.36 | Varying-real-part complex sampling | `Legendre.Density.sum_complexDirichletPolynomial_samples_le`; [ComplexDirichletSampling.lean](../Legendre/ComplexDirichletSampling.lean) | **proved**; ordinates separated, independently varying real parts in a strip of width ≤1 |
| 4.37 | Reciprocal-lcm, divisor-square mean and dyadic energy | `Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisor_square_mean`, `mollifier_dyadic_energy_le`; [CoefficientEnergy.lean](../Legendre/ZeroDetector/CoefficientEnergy.lean) | **proved**; explicit M log³M and U^(1−2σ) bounds |
| 4.38 | Actual separated zero sample bound | `Legendre.Density.Detector.actual_zero_sample_card_le`; [DetectorSamples.lean](../Legendre/ZeroDetector/DetectorSamples.lean) | **proved**; both detector energies and polar weight explicit; required Ingham/Huxley exponents still open |
| 4.39 | High-tail coefficient energy | `Legendre.Density.Detector.high_tail_coefficient_energy_le`, `detector_tail_energy_le`, `mollifier_vertical_energy_le`; [TailEnergy.lean](../Legendre/ZeroDetector/TailEnergy.lean) | **proved**; X^(1−2σ) decay with a positive geometric denominator, σ>1/2 |
| 4.40 | Full multiplicity-weighted count from actual detection | `Legendre.Zeta.zeroDensityCount_le_actual_detector`; [ZetaDetectedDensity.lean](../Legendre/ZetaDetectedDensity.lean) | **proved**; no detector hypothesis, both energies explicit, fixed low-height contribution retained; present height power still insufficient |
| 4.41 | Positive-half-plane digamma series and tail helpers | `Complex.hasSum_digamma_of_re_pos`; [DigammaSeries.lean](../Legendre/PNT/Mathlib/Analysis/SpecialFunctions/Gamma/DigammaSeries.lean) | **proved**, adapted from the credited PNT+ source |
| 4.42 | Sharp Gamma quotient and Gaussian weight | `Legendre.Density.GammaBounds.sharp_gammaReal_shift`, `gammaSquareGaussianWeight_bound`; [GammaBounds/](../Legendre/GammaBounds/) | **proved**, exact horizontal height exponent, fixed source/license recorded |
| 4.43 | Entire self-dual xi completion | `Legendre.Zeta.zetaXi_differentiable`, `zetaXi_one_sub`, `xi_polynomial_shift_ratio_le`; [ZetaXi.lean](../Legendre/ZetaXi.lean) | **proved**, removes both completed poles, polynomial shift costs no base-height power |
| 4.44 | Normalized entire Gaussian square | `Legendre.Zeta.xiSquareGaussian_normalized`, `xiSquareKernelWeight_bound`; [XiSquareKernel.lean](../Legendre/XiSquareKernel.lean) | **proved**, exact right-line identity and explicit normalized kernel bound |
| 4.45 | Integrable Gaussian contour envelope | `Legendre.Zeta.zetaXi_strip_bound`, `xiGaussianEnvelope_integrable`, `xiSquareGaussian_band_bound`; [XiGaussianEnvelope.lean](../Legendre/XiGaussianEnvelope.lean) | **proved**, reflection across the band, sixth-degree envelope and vanishing limit; sixth-log fourth moment supplied below |
| 4.46 | Exact Gaussian xi-square functional equation | `Legendre.Zeta.xiSquareContour_vertical_integrable`, `xiSquareGaussian_rectangle`, `zetaXi_square_equation`; [XiSquareContour.lean](../Legendre/XiSquareContour.lean) | **proved**, convergent vertical lines, vanishing horizontal edges, central residue and reflected orientation |
| 4.47 | Critical-line fourth-power reduction | `Legendre.Zeta.zetaXi_conj`, `xiSquareIntegral_conj`, `riemannZeta_fourth_le_smoothed`; [XiSquareContour.lean](../Legendre/XiSquareContour.lean) | **proved**, pointwise bound by one normalized contour; its mean and sixth-log fourth moment are supplied below |
| 4.48 | Harmonic divisor energy and actual zeta-square series | `Legendre.Density.Moment.divisor_square_harmonic`, `Legendre.Zeta.zeta_square_LSeries`, `xiSmoothedZetaSquare_series` | **proved**, absolute integral norms justify series interchange; cutoff zero included |
| 4.49 | Positive-line finite Mellin movement and weighted means | `Legendre.Zeta.xiFiniteKernel_shift`, `xiFiniteSquare_continuousOn`, `xiFiniteSquare_mean` | **proved**, exact contour normalization, translated mean independent of shift, xi polynomial absorbed without a height-power loss |
| 4.50 | Main segment and summable dyadic tails | `Legendre.Zeta.xiFiniteSquare_head_mean`, `xiFiniteSquare_dyadic_mean`, `xiFiniteSquare_partial_mean` | **proved**, head log^6 and tail (j+2)^3/2^j; uniform in partial length |
| 4.51 | Actual infinite contour mean | `Legendre.Zeta.xiSquare_partial_limit`, `xiSmoothedZetaSquare_mean` | **proved**, nonnegative Fatou supplies integrability and the uniform bound |
| 4.52 | Critical-line fourth moment and height exponent | `Legendre.Zeta.zeta_fourth_moment_log_six`, `zeta_fourth_moment_positive_log_six`, `zeta_fourth_moment_epsilon`; [Layer4/ZetaFourthMoment.lean](../Legendre/Layer4/ZetaFourthMoment.lean) | **proved**, O(T log^6 T) on [-T,T] and [0,T], hence O_epsilon(T^(1+epsilon)); sharp log^4 and Ingham/Huxley density remain open |
| 4.53 | Compact quadratic smoothing and Mellin inversion | `Legendre.Density.Detector.Smooth.detectorWeight_hasMellin`, `detectorWeight_mellin_inversion`, `detectorKernel_left_bound` | **proved**, compact support at 1, cubic vertical decay, critical-side delta up to 1/2 |
| 4.54 | Full truncated-Mobius divisor convolution | `Legendre.Density.Detector.Smooth.detectorCoefficient_initial`, `detectorCoefficient_harmonic_energy`, `mollifier_zeta_product` | **proved**, no second cutoff; exact coefficient cancellation and actual zeta product on Re(s)>1 |
| 4.55 | Exact initial compact detector contour | `Legendre.Density.Detector.Smooth.detectorMean_split`, `detectorMean_eq_integral` | **proved**, arbitrary positive smoothing scale; absolute integral norms justify the exchange. The compensated shift is supplied below |
| 4.56 | Principal-pole regularization and rectangle residue | `Legendre.Density.Detector.Smooth.detector_rectangle_principal`, `detectorRegularFactor_at_principal_pole` | **proved**, entire numerator, zero divided difference and exact principal-pole coefficient |
| 4.57 | Compensated critical-line detector shift | `Legendre.Density.Detector.Smooth.detector_zero_contour_shift`, `detectorMean_at_zero` | **proved**, both vertical lines integrable and horizontal edges vanish beyond the shifted pole |
| 4.58 | Explicit principal-pole smallness and genuine high-zero detection | `Legendre.Density.Detector.Smooth.detectorPrincipalPole_small`, `detector_high_zero_dichotomy` | **proved**, T>=64, |Im(s)|>=T, X<=4T, 4<=Y<=T^2; one branch is >=1/16 |
| 4.59 | Uniform critical-line cubic masses | `Legendre.Density.Detector.Smooth.criticalProduct_weighted_integrable`, `detectorCriticalIntegral_uniform_bound` | **proved**, no named density input; sharp packing/counting remains open |
| 4.60 | Dyadic whole-line moment transfer | `Legendre.Density.Moment.momentHeightShell_cover`, `moment_weighted_moment` | **proved**, disjoint measurable shells, summable cubic budgets and actual integrability |
| 4.61 | Actual weighted zeta fourth and Mobius second moments | `Legendre.Density.Moment.weighted_zeta_fourth_moment`, `weighted_mollifier_mean` | **proved**, C T log^6 T and C(X+T)(1+log X) on the whole real line |
| 4.62 | Uniform separated cubic kernel packing | `Legendre.Density.Moment.moment_kernel_height_packing`, `packed_zeta_fourth_moment`, `packed_mollifier_mean` | **proved**, one constant and the original height weight, no cardinality loss |
| 4.63 | Packed literal critical-mass fourth power | `Legendre.Density.Moment.packed_critical_mass_fourth` | **proved**, (sum masses)^4 <= C R T (X+T)^2 log^6 T (1+log X)^2 |
| 4.64 | Cubic count for the integral branch | `Legendre.Density.Moment.integral_alternative_count` | **proved**, R^3 <= C [256 Y^(1/2-sigma)/(sigma-1/2)]^4 T (X+T)^2 log^6 T (1+log X)^2; no zero-density estimate assumed |
| 4.65 | Compact polynomial blocks and sharp branch count | `Density.Moment.polynomial_alternative_count`; [PolynomialAlternative.lean](../Legendre/Layer4/PolynomialAlternative.lean) | **proved**; R ≤ C log^8(2Y+1)(Y^(2−2σ)+T X^(1−2σ)) |
| 4.66 | Balanced polynomial/integral branches | [BalancedAlternatives.lean](../Legendre/Layer4/BalancedAlternatives.lean) | **proved** with X=ceil(T), Y=T^(3/(2(2−σ))); principal-pole constraints retained |
| 4.67 | Near-critical band and dyadic real-height cover | [NearCriticalDensity.lean](../Legendre/Layer4/NearCriticalDensity.lean), [DyadicHeightDensity.lean](../Legendre/Layer4/DyadicHeightDensity.lean) | **proved**; uniform sigma including 1/2; no height-power loss |
| 4.68 | Actual multiplicities and fixed low-height count | `Zeta.ingham_density_log_bound`; [InghamMultiplicity.lean](../Legendre/Layer4/InghamMultiplicity.lean) | **proved**; all T≥2, N(σ,T) ≤ C T^(3(1−σ)/(2−σ)) log^10 T |
| 4.69 | Ingham 1940 curved density comparator | `Zeta.ingham_density_epsilon`, `Literature.layer4_ingham_comparator`; [InghamDensity.lean](../Legendre/Layer4/InghamDensity.lean) | **proved**, closed uniform epsilon theorem; 1937 prime-gap statements remain open |
| 4.interface | Initial Layer 4 public interface | `import Legendre.Layer4` | exports proved Ingham 1940 curved density, finite additive large sieve, linear mean-square error, optimized samples, Gram bounds, weighted detection and fourth-moment height exponent; Huxley/Guth–Maynard remain open |
| 4.validation | Fifty-six independent Layer 4 consumer checks | [Tests/Layer4.lean](../Legendre/Tests/Layer4.lean) | empty/singleton/two-term/coincident-frequency cases, translated interval, limiting mean, near-one cutoff, log-loss and conditional exponent weakening, reversed sharp-mean interval, optimized touching samples and zero-energy detector, nonzero mollifier endpoint, Euler cutoff one, actual counted zeros, mixed real parts, critical-line empty energy, full actual density, retained low heights, xi pole values, vertical Gamma shifts, zero-shift kernel, removed-pole rectangle residue, real-center reflection, all-ordinate fourth-power reduction and endpoint conjugation; all declarations audited; added empty harmonic energy, unit head energy, translated subset mean, zero series term, height-two moment and exponent 5/4 checks |
| 10 | Hoheisel 1930, `θ = 32999/33000` | `Legendre.Hoheisel`, `Legendre.HoheiselPaper` | **statement only**; normalized exponent form encoded, `hoheiselPaper_iff` proved |
| 11 | Ingham 1937, `θ = 5/8` | `Legendre.Ingham58`, `Legendre.Ingham58Paper` | **statement only**; normalized exponent form encoded, `ingham58Paper_iff` proved |
| 12 | Ingham 1937, `θ = 577/925 + ε` | `Legendre.Ingham577`, `Legendre.Ingham577Paper` | **statement only**; normalized exponent form encoded, `ingham577Paper_iff` proved |
| 13 | Huxley 1972, `θ = 7/12 + ε` | `Legendre.Huxley`, `Legendre.HuxleyPaper` | **statement only**; normalized exponent form encoded, `huxleyPaper_iff` proved |
| 14 | Heath-Brown–Iwaniec 1979, `θ = 11/20 + ε` | `Legendre.HeathBrownIwaniec`, `Legendre.HeathBrownIwaniecPaper` | **statement only**; normalized exponent form encoded, `heathBrownIwaniecPaper_iff` proved |
| 15 | Iwaniec–Pintz 1984, `θ = 23/42 + ε` | `Legendre.IwaniecPintz`, `Legendre.IwaniecPintzPaper` | **statement only**; normalized exponent form encoded, `iwaniecPintzPaper_iff` proved |
| 16 | Mozzochi 1986, `θ = 11/20 - 1/384 + ε` | `Legendre.Mozzochi`, `Legendre.MozzochiPaper` | **statement only**; normalized exponent form encoded, `mozzochiPaper_iff` proved |
| 17 | Baker–Harman 1996, `θ = 0.535` | `Legendre.BakerHarman`, `Legendre.BakerHarmanPaper` | **statement only**; normalized exponent form encoded, `bakerHarmanPaper_iff` proved |
| 18 | Baker–Harman–Pintz 2001, `θ = 0.525` | `Legendre.BakerHarmanPintz`, `Legendre.BakerHarmanPintzPaper` | **statement only**; normalized exponent form encoded, `bakerHarmanPintzPaper_iff` proved |
| 19 | RH gap bound `≪ √x log x` | `Legendre.RHGapBound` | **statement only** |
| 20 | Cramér conjecture `O((log x)²)` | `Legendre.CramerGapBound` | **statement only** |
| 21 | almost-prime `P_k` square statement | `Legendre.AlmostPrimeSquareAtMost`, `AlmostPrimeSquareEventually` | definition |
| 22 | `P₁` square statement ↔ Legendre | `Legendre.almostPrimeSquareAtMost_one_iff` | **proved** |
| 23 | Chen 1975: `P₂` for all sufficiently large `n` | — | **not encoded in Lean** (deep sieve theorem) |
| 24 | Dudek–Johnston 2026: `P₄` for all `n` | — | **not encoded in Lean** (deep sieve/computation) |
| 25 | explicit verification `n ≤ 7.05×10¹³` | — | **not encoded in Lean** (large external computation) |

Layer 3 full-contour validation (2026-11-07): full build passed 4,054 jobs and
the audit passed all 2,756 expected targets. These cover **all 2,756 project theorem declarations**,
including private/generated helpers and nine independently compiled consumer checks.
The parsed axiom output matches the complete Lean-environment enumeration exactly;
204 declarations were added in this refinement. All 85 project Lean files
contain no executable `sorry`, `admit` or `sorryAx`. See
[the exact uniform formula, proof chain and limits](perron-uniform-explicit-formula.md).

Layer 4 moment-contour validation (2026-11-08): full build passed
4,132 jobs, and all 3,311 project theorem declarations are audited, including
153 additional public/private/generated declarations after the actual-detector checkpoint. The complete module-data theorem inventory
agrees with the parsed audit output exactly. All 157 project Lean files have
zero executable placeholders. Thirty-three Layer 4 consumers and all nine
Layer 3 regression consumers compile and pass standalone checks, also required by CI.
See [the precise estimates and remaining obligations](layer4-moment-kernel.md).

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

## Literature-comparison checkpoint (2026-11-08)

Both READMEs now cover all 17 historical targets/results, and every project
Lean source has a coverage category. Historical exponent corrections are
Heath-Brown–Iwaniec `11/20` and Iwaniec–Pintz `23/42`; the source/evidence
limitations are recorded in [the comparator report](literature-comparators.md).
The existing `*Paper` names now explicitly denote normalized exponent statements.
Layer 5 statements moved to `Legendre/Layer5/Statements.lean`, keeping the public
import stable; Layer 6 and 7 have reserved implementation directories.

Full validation: 4,139 build jobs, all 3,422 distinct project theorem declarations
audited, 164 Lean sources without executable placeholders, and 78 independent
consumers (9 Layer 3, 33 Layer 4, 36 literature checks). Three intentional bad
comparison fixtures are rejected by Lean: the old unsupported exponent, a
conditional density bridge used as a closed proof, and a forged proved status.

### Sixth-log fourth-moment validation (2026-11-08)

The full build has 4,164 jobs. All 3,561 distinct project theorem declarations
(public, private and generated) are covered by the axiom audit and both
independent declaration inventories. The only axioms are propext,
Classical.choice and Quot.sound. All 189 project Lean files have zero
executable sorry, admit or sorryAx. Standalone checks cover 39 Layer 4,
9 Layer 3 and 36 literature consumers (84 total). The current Layer 4
comparison additionally checks the proved sixth-log fourth moment and the
1+epsilon height exponent; the sharp log^4 and density targets remain open.

### Initial compact-detector validation (2026-11-08)

Full build: 4,171 jobs. All 3,615 project theorem declarations, including
private/generated helpers, are audited against the three standard axioms.
Both independent inventories agree exactly with the audit. All 196 Lean
sources have zero executable sorry, admit or sorryAx. Standalone checks:
44 Layer 4, 9 Layer 3 and 36 literature consumers, 89 total. An intentional
bad consumer also confirms that the sixth-log proof cannot fill the sharp
fourth-log comparator. The initial compact contour is proved; the principal
pole shift and Ingham/Huxley density estimates remain open.

Compensated-detector validation (2026-11-09): 4,180 full-build jobs; all 3,701
project theorem declarations audited; 205 Lean sources without executable
placeholders. Both independent declaration inventories match the audit and
its actual axiom output. All 95 independent consumers pass: 50 Layer 4,
9 Layer 3 and 36 literature checks. Ingham/Huxley remain open.

Weighted-moment and integral-branch validation (2026-11-09): full build 4,193
jobs, all 3,788 project theorem declarations audited, 218 Lean sources without
executable placeholders. Both independent inventories match the axiom audit.
All 101 standalone consumers pass: 56 Layer 4, 9 Layer 3 and 36 literature.
The tests include zero height in the dyadic cover, adjacent separated samples,
T=2 weighted moments, X=1 and the singleton packed critical mass.

Ingham density validation (2026-11-10): full build 4,206 jobs. All 3,874
project theorem declarations, including private/generated helpers, are audited
against propext, Classical.choice and Quot.sound. Both independent declaration
inventories match the audit targets and actual axiom output exactly. All 231
Lean sources have zero executable sorry, admit or sorryAx. All 107 standalone
consumers pass: 62 Layer 4, 9 Layer 3 and 36 literature. The added consumers
cover the real-height top boundary, the balanced sigma=3/4 powers, density
exponents at sigma=1/2 and 3/4, T=2 uniformly in sigma, and linear exponent
three. An intentional Ingham-as-Huxley consumer is rejected by Lean.
