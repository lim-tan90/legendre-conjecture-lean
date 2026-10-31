/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Conditional
public import Legendre.Bertrand
public import Legendre.ExplicitBounds
public import Legendre.Layer5
public import Legendre.Nagura
public import Legendre.Zeta
public import Legendre.ZetaCounting
public import Legendre.ZetaLogDerivative
public import Legendre.ZetaHalfPlane
public import Legendre.ZetaPole
public import Legendre.PerronFoundation
public import Legendre.PerronContour
public import Legendre.PerronTruncated
public import Legendre.PerronSeries
public import Legendre.PerronKernel
public import Legendre.PerronOscillation
public import Legendre.PerronTail
public import Legendre.PerronShift
public import Legendre.PerronZero
public import Legendre.PerronResidue
public import Legendre.PerronInversion

public import Legendre.PerronError

public import Legendre.ZetaPositivity

public import Legendre.ZetaGrowth

public import Legendre.ZetaLocalBound

public import Legendre.ZetaZeroRemoval

public import Legendre.ZetaRegularizedBound

public import Legendre.ZetaLogDerivativeLocal

public import Legendre.ZetaPoleBounds

public import Legendre.ZetaZeroFree

public import Legendre.ZetaArgumentPrinciple

public import Legendre.ZetaReflection

public import Legendre.ZetaCountingDisks

public import Legendre.ZetaCountingCover

public import Legendre.ZetaGlobalCounting

/-!
# Axiom audit

`#print axioms` lists every axiom a theorem depends on.  For this project the
only permitted axioms are Lean's standard classical axioms:

* `propext`
* `Classical.choice`
* `Quot.sound`

In particular, no `sorryAx`, no user `axiom`, and no `False.elim`-style
"explosion" shortcut may appear.  `scripts/audit.py` parses this output and
fails the build if any other axiom is reported.
-/

namespace Legendre

#print axioms legendreAt_one
#print axioms sq_interval_length
#print axioms legendre_of_gap_lt_two_sqrt
#print axioms eventually_const_mul_rpow_lt
#print axioms eventually_legendre_of_gap_exponent_lt_half
#print axioms legendre_eventually_of_shortIntervalExponent_lt_half
#print axioms legendre_eventually_of_shortIntervalExponentLimit_lt_half
#print axioms hoheisel_above_half
#print axioms ingham58_above_half
#print axioms ingham577_above_half
#print axioms huxley_above_half
#print axioms heathBrownIwaniec_above_half
#print axioms iwaniecPintz_above_half
#print axioms mozzochi_above_half
#print axioms bakerHarman_above_half
#print axioms bakerHarmanPintz_above_half
#print axioms bhp_exponent_not_below_half
#print axioms prime_of_isAtMostAlmostPrime_one
#print axioms conjecture_of_almostPrimeSquareAtMost_one
#print axioms almostPrimeSquareAtMost_one_of_conjecture
#print axioms almostPrimeSquareAtMost_one_iff
#print axioms bertrand
#print axioms bertrand_gap_le
#print axioms square_interval_shorter_than_linear_gap
#print axioms hasPrimeIn_self
#print axioms exists_prime_of_theta_lt
#print axioms hasPrimeIn_of_theta_gap
#print axioms theta_upper_explicit
#print axioms theta_lower_explicit
#print axioms psi_upper_explicit
#print axioms psi_lower_explicit
#print axioms pi_lower_explicit
#print axioms pi_upper_explicit
#print axioms primeGapBound_iff_eventuallyGapBound
#print axioms primeGapBound_of_hasPrimeInShortInterval
#print axioms hasPrimeInShortInterval_of_primeGapBound
#print axioms hasPrimeInShortInterval_iff_primeGapBound
#print axioms hasPrimeInShortInterval_mono
#print axioms shortIntervalStatement_mono
#print axioms shortIntervalExponentLimit_of_statement
#print axioms statement_of_shortIntervalExponentLimit
#print axioms shortIntervalStatement_iff_exponentLimit
#print axioms legendre_eventually_of_shortIntervalStatement_lt_half
#print axioms hoheiselPaper_iff
#print axioms ingham58Paper_iff
#print axioms ingham577Paper_iff
#print axioms huxleyPaper_iff
#print axioms heathBrownIwaniecPaper_iff
#print axioms iwaniecPintzPaper_iff
#print axioms mozzochiPaper_iff
#print axioms bakerHarmanPaper_iff
#print axioms bakerHarmanPintzPaper_iff
#print axioms Legendre.Nagura.exists_prime_nagura
#print axioms Legendre.Nagura.exists_prime_nagura_91639_to_16000000
#print axioms Legendre.Nagura.exists_prime_nagura_analytic_tail
#print axioms Legendre.Nagura.psi_nat_lt_1_086_mul
#print axioms Legendre.Nagura.psi_nat_gt_0_916_mul
#print axioms Legendre.Nagura.naguraGeneralUpperCombination_lt_1_0851_mul
#print axioms Legendre.Nagura.naguraGeneralLowerCombination_gt_0_916_mul
#print axioms nagura_prime_gap
#print axioms nagura_hasPrimeIn
#print axioms nagura_hasPrimeIn_nat

end Legendre

#print axioms Legendre.Zeta.series_norm_summable
#print axioms Legendre.Zeta.eq_series
#print axioms Legendre.Zeta.euler_product
#print axioms Legendre.Zeta.euler_product_limit
#print axioms Legendre.Zeta.analytic_off_pole
#print axioms Legendre.Zeta.completed_functional_equation
#print axioms Legendre.Zeta.nonvanishing
#print axioms Legendre.Zeta.finite_zeros_on_compact
#print axioms Legendre.Zeta.exists_zero_free_band
#print axioms Legendre.Zeta.exists_zero_free_strip

#print axioms Legendre.Zeta.analytic_order_finite
#print axioms Legendre.Zeta.zeroMultiplicity_cast
#print axioms Legendre.Zeta.zeroMultiplicity_pos
#print axioms Legendre.Zeta.zeroMultiplicity_eq_zero
#print axioms Legendre.Zeta.zerosUpTo_finite
#print axioms Legendre.Zeta.zerosRightOf_finite
#print axioms Legendre.Zeta.zeroCount_pos_iff
#print axioms Legendre.Zeta.zeroDensityCount_pos_iff
#print axioms Legendre.Zeta.zerosUpTo_mono
#print axioms Legendre.Zeta.zeroCount_mono
#print axioms Legendre.Zeta.zeroDensityCount_le
#print axioms Legendre.Zeta.zeroDensityCount_mono_height
#print axioms Legendre.Zeta.zeroDensityCount_antitone
#print axioms Legendre.Zeta.zeroCount_eq_zero_of_nonpos
#print axioms Legendre.Zeta.zeroDensityCount_eq_zero_of_one_le
#print axioms Legendre.Zeta.zeroDensityCount_eq_count_of_nonpos

#print axioms Legendre.Zeta.vonMangoldt_series_summable
#print axioms Legendre.Zeta.neg_logDeriv_eq_vonMangoldt_series
#print axioms Legendre.Zeta.norm_logDeriv_le_majorant
#print axioms Legendre.Zeta.vonMangoldt_le_nat
#print axioms Legendre.Zeta.vonMangoldt_term_three_le
#print axioms Legendre.Zeta.norm_logDeriv_le_pi_sq_div_six
#print axioms Legendre.Zeta.zeroDensityCount_eq_zero_of_zero_free
#print axioms Legendre.Zeta.exists_zero_density_cutoff

#print axioms Legendre.Zeta.tsum_nat_rpow_neg_le
#print axioms Legendre.Zeta.vonMangoldt_term_one_add_two_mul_le
#print axioms Legendre.Zeta.vonMangoldt_majorant_le
#print axioms Legendre.Zeta.norm_logDeriv_le_of_re_ge_one_add
#print axioms Legendre.Zeta.norm_logDeriv_le_six_div_sq
#print axioms Legendre.Zeta.norm_logDeriv_le_re_sub_one

#print axioms Legendre.Zeta.poleRemovedZeta_one
#print axioms Legendre.Zeta.poleRemovedZeta_eq
#print axioms Legendre.Zeta.poleRemovedZeta_eventuallyEq
#print axioms Legendre.Zeta.poleRemovedZeta_differentiableAt
#print axioms Legendre.Zeta.poleRemovedZeta_continuousAt_one
#print axioms Legendre.Zeta.poleRemovedZeta_analyticAt_one
#print axioms Legendre.Zeta.poleRemovedZeta_logDeriv_analyticAt_one
#print axioms Legendre.Zeta.logDeriv_regularPart_eventuallyEq
#print axioms Legendre.Zeta.tendsto_logDeriv_regularPart
#print axioms Legendre.Zeta.tendsto_sub_mul_logDeriv_at_one
#print axioms Legendre.Zeta.tendsto_sub_mul_neg_logDeriv_at_one
#print axioms Legendre.Zeta.logDeriv_regularPart_eventually_bounded
#print axioms Legendre.Zeta.norm_logDeriv_eventually_le_inv_add

#print axioms Legendre.Zeta.vonMangoldt_partialSums_floor_eq_psi
#print axioms Legendre.Zeta.vonMangoldt_partialSums_isBigO
#print axioms Legendre.Zeta.vonMangoldt_partialSums_complex_eq_psi
#print axioms Legendre.Zeta.norm_psi_mellin_integrand_le
#print axioms Legendre.Zeta.psi_mellin_integrable
#print axioms Legendre.Zeta.neg_logDeriv_eq_psi_integral
#print axioms Legendre.Zeta.perronWeight_one
#print axioms Legendre.Zeta.perronWeight_continuousAt_one
#print axioms Legendre.Zeta.tendsto_sub_mul_perronIntegrand_at_one

#print axioms Legendre.Zeta.perronPoleNumerator_one
#print axioms Legendre.Zeta.perronWeight_analyticAt_one
#print axioms Legendre.Zeta.perronPoleNumerator_analyticAt_one
#print axioms Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator
#print axioms Legendre.Zeta.exists_perronIntegrand_circleIntegral

#print axioms Legendre.Zeta.norm_perronWeight
#print axioms Legendre.Zeta.norm_perronIntegrand_le
#print axioms Legendre.Zeta.perronIntegrand_continuousAt
#print axioms Legendre.Zeta.norm_perronIntegrand_vertical_le
#print axioms Legendre.Zeta.norm_perronIntegrand_vertical_le_div_abs
#print axioms Legendre.Zeta.perronIntegrand_vertical_intervalIntegrable
#print axioms Legendre.Zeta.norm_truncatedPerron_le

#print axioms Legendre.Zeta.perronSeriesTerm_eq_vonMangoldt_mul_weight
#print axioms Legendre.Zeta.perronSeriesTerm_hasSum
#print axioms Legendre.Zeta.norm_perronWeight_vertical_le
#print axioms Legendre.Zeta.norm_perronSeriesTerm_vertical_le
#print axioms Legendre.Zeta.perronSeriesTerm_vertical_continuous
#print axioms Legendre.Zeta.perronSeriesTerm_hasSum_intervalIntegral
#print axioms Legendre.Zeta.perronSeriesTerm_integrals_norm_summable
#print axioms Legendre.Zeta.truncatedPerron_eq_tsum_integrals
#print axioms Legendre.Zeta.truncatedPerron_eq_tsum_kernels

#print axioms Legendre.Zeta.perronReciprocal_vertical_continuous
#print axioms Legendre.Zeta.integral_perronReciprocal
#print axioms Legendre.Zeta.truncatedPerronKernel_one
#print axioms Legendre.Zeta.tendsto_truncatedPerronKernel_one
#print axioms Legendre.Zeta.norm_truncatedPerronKernel_one_sub_half_le

#print axioms Legendre.Zeta.cpow_vertical_eq_exp
#print axioms Legendre.Zeta.perronWeight_vertical_eq_exp
#print axioms Legendre.Zeta.integral_cpow_vertical
#print axioms Legendre.Zeta.norm_integral_cpow_vertical_le

#print axioms Legendre.Zeta.perronVertical_ne_zero
#print axioms Legendre.Zeta.perronOscPrimitive_hasDerivAt
#print axioms Legendre.Zeta.norm_perronOscPrimitive
#print axioms Legendre.Zeta.perronReciprocal_hasDerivAt
#print axioms Legendre.Zeta.perronReciprocalDeriv_continuous
#print axioms Legendre.Zeta.norm_perronReciprocalDeriv_le
#print axioms Legendre.Zeta.integral_perronWeight_parts
#print axioms Legendre.Zeta.perronTail_remainder_integrable
#print axioms Legendre.Zeta.perronTail_boundary_tendsto_zero
#print axioms Legendre.Zeta.tendsto_integral_perronWeight_Ioi_one
#print axioms Legendre.Zeta.perronWeight_vertical_continuous
#print axioms Legendre.Zeta.perronWeight_vertical_neg
#print axioms Legendre.Zeta.integral_perronWeight_symmetric
#print axioms Legendre.Zeta.exists_tendsto_truncatedPerronKernel
#print axioms Legendre.Zeta.exists_tendsto_truncatedPerronKernel_pos

#print axioms Legendre.Zeta.perronWeight_differentiableAt
#print axioms Legendre.Zeta.perronWeight_rectangle
#print axioms Legendre.Zeta.rpow_le_max_endpoints
#print axioms Legendre.Zeta.norm_perronWeight_horizontal_le
#print axioms Legendre.Zeta.norm_perronHorizontal_le
#print axioms Legendre.Zeta.perronHorizontal_tendsto_zero
#print axioms Legendre.Zeta.perronHorizontal_neg_tendsto_zero
#print axioms Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal
#print axioms Legendre.Zeta.tendsto_truncatedPerronKernel_sub
#print axioms Legendre.Zeta.perronKernel_limit_independent_line

#print axioms Legendre.Zeta.norm_perronReciprocalDeriv_eq
#print axioms Legendre.Zeta.norm_perronTail_boundary_le
#print axioms Legendre.Zeta.norm_integral_perronTail_remainder_le
#print axioms Legendre.Zeta.norm_truncatedPerronKernel_uniform_le
#print axioms Legendre.Zeta.norm_truncatedPerronKernel_le_of_lt_one
#print axioms Legendre.Zeta.tendsto_truncatedPerronKernel_of_lt_one

#print axioms Legendre.Zeta.perronRegularizedWeight_differentiable
#print axioms Legendre.Zeta.perronRegularizedWeight_eq
#print axioms Legendre.Zeta.perronWeight_continuous_comp
#print axioms Legendre.Zeta.integral_perronRegularizedWeight_eq
#print axioms Legendre.Zeta.perronWeight_neg_eq_inv
#print axioms Legendre.Zeta.truncatedPerronKernel_neg_line
#print axioms Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq
#print axioms Legendre.Zeta.tendsto_truncatedPerronKernel_crossing_sub
#print axioms Legendre.Zeta.tendsto_truncatedPerronKernel_of_one_lt
#print axioms Legendre.Zeta.tendsto_truncatedPerronKernel

#print axioms Legendre.Zeta.perronKernelBound_nonneg
#print axioms Legendre.Zeta.norm_truncatedPerronKernel_le_bound
#print axioms Legendre.Zeta.log_ratio_abs_ge_log_two
#print axioms Legendre.Zeta.perronKernelBound_ratio_le
#print axioms Legendre.Zeta.summable_vonMangoldt_perronKernelBound
#print axioms Legendre.Zeta.tendsto_truncatedPerron_tsum
#print axioms Legendre.Zeta.vonMangoldt_mul_scalarPerronValue_eq_zero
#print axioms Legendre.Zeta.vonMangoldt_scalarPerronValue_tsum_eq_sum
#print axioms Legendre.Zeta.vonMangoldt_mul_scalarPerronValue_eq
#print axioms Legendre.Zeta.vonMangoldt_scalarPerronValue_tsum_eq_psi
#print axioms Legendre.Zeta.tendsto_truncatedPerron
#print axioms Legendre.Zeta.tendsto_truncatedPerron_of_not_nat
#print axioms Legendre.Zeta.tendsto_truncatedPerron_nat

#print axioms Legendre.Zeta.integral_perron_inv_sq
#print axioms Legendre.Zeta.norm_perronTail_boundary_height_le
#print axioms Legendre.Zeta.norm_integral_perronTail_remainder_height_le
#print axioms Legendre.Zeta.norm_integral_perronWeight_tail_le
#print axioms Legendre.Zeta.norm_truncatedPerronKernel_sub_le
#print axioms Legendre.Zeta.norm_truncatedPerronKernel_sub_value_le
#print axioms Legendre.Zeta.perronScalarError_nonneg
#print axioms Legendre.Zeta.norm_truncatedPerronKernel_error_le
#print axioms Legendre.Zeta.perronScalarError_le_bound
#print axioms Legendre.Zeta.summable_vonMangoldt_perronScalarError
#print axioms Legendre.Zeta.perronErrorConstant_nonneg
#print axioms Legendre.Zeta.summable_vonMangoldt_truncatedPerronKernel
#print axioms Legendre.Zeta.summable_vonMangoldt_scalarPerronValue
#print axioms Legendre.Zeta.norm_truncatedPerron_sub_psi_le
#print axioms Legendre.Zeta.vonMangoldt_dirichlet_norm_sum_le
#print axioms Legendre.Zeta.vonMangoldt_perronScalarError_tail_le
#print axioms Legendre.Zeta.perronErrorConstant_le_upper
#print axioms Legendre.Zeta.norm_truncatedPerron_sub_psi_le_upper

#print axioms Legendre.Zeta.vonMangoldt_term_re
#print axioms Legendre.Zeta.vonMangoldt_term_three_four_one_nonneg
#print axioms Legendre.Zeta.neg_logDeriv_three_four_one_nonneg

#print axioms Legendre.Zeta.zetaFractionalPart_measurable
#print axioms Legendre.Zeta.norm_zetaFractionalPart_le
#print axioms Legendre.Zeta.zetaFractionalPart_locallyIntegrable
#print axioms Legendre.Zeta.zetaFractionalPart_isBigO_atTop
#print axioms Legendre.Zeta.zetaFractionalPart_isBigO_at_zero
#print axioms Legendre.Zeta.zetaMellinRemainder_convergent
#print axioms Legendre.Zeta.zetaMellinRemainder_differentiableAt
#print axioms Legendre.Zeta.zetaMellin_integrand_eq_indicator
#print axioms Legendre.Zeta.zetaMellinRemainder_eq_integral
#print axioms Legendre.Zeta.zetaMellinRemainder_integrable
#print axioms Legendre.Zeta.norm_zetaMellinRemainder_le
#print axioms Legendre.Zeta.riemannZeta_eq_euler_sum_right
#print axioms Legendre.Zeta.poleRemovedZeta_differentiable
#print axioms Legendre.Zeta.zetaEulerNumerator_differentiableAt
#print axioms Legendre.Zeta.poleRemovedZeta_eq_euler_sum
#print axioms Legendre.Zeta.riemannZeta_eq_euler_sum
#print axioms Legendre.Zeta.norm_riemannZeta_le_positive_re
#print axioms Legendre.Zeta.norm_riemannZeta_le_three_mul_norm
#print axioms Legendre.Zeta.norm_moebius_LSeries_le_two
#print axioms Legendre.Zeta.one_half_le_norm_riemannZeta

#print axioms Legendre.Zeta.zeta_disk_coordinates
#print axioms Legendre.Zeta.riemannZeta_analyticOnNhd_disk
#print axioms Legendre.Zeta.norm_riemannZeta_disk_le
#print axioms Legendre.Zeta.one_half_le_norm_riemannZeta_disk_center
#print axioms Legendre.Zeta.zeta_local_divisor_sum_le

#print axioms Legendre.Zeta.localZetaDivisor_finite
#print axioms Legendre.Zeta.localZetaDivisor_nonneg
#print axioms Legendre.Zeta.localZetaFactor_analyticAt
#print axioms Legendre.Zeta.localZetaFactor_order
#print axioms Legendre.Zeta.localZetaFactor_ne_zero
#print axioms Legendre.Zeta.riemannZeta_meromorphicOrderAt_eq
#print axioms Legendre.Zeta.localZetaDivisor_eq_multiplicity
#print axioms Legendre.Zeta.localZetaQuotient_meromorphicOn
#print axioms Legendre.Zeta.localZetaQuotient_order
#print axioms Legendre.Zeta.localZetaRegularized_order
#print axioms Legendre.Zeta.zeta_disk_ne_one
#print axioms Legendre.Zeta.localZetaDivisor_eq_zero_of_not_mem
#print axioms Legendre.Zeta.localZetaRegularized_analyticOnNhd
#print axioms Legendre.Zeta.localZetaRegularized_ne_zero
#print axioms Legendre.Zeta.localZetaDivisor_eq_zero_of_ne_zero
#print axioms Legendre.Zeta.localZetaRegularized_eq
#print axioms Legendre.Zeta.localZetaRegularized_eventuallyEq
#print axioms Legendre.Zeta.localZetaFactor_eq_prod
#print axioms Legendre.Zeta.localZetaFactor_logDeriv
#print axioms Legendre.Zeta.logDeriv_riemannZeta_eq_regularized_add
#print axioms Legendre.Zeta.localZetaDivisor_support_zero
#print axioms Legendre.Zeta.localZetaPrincipalPart_re_nonneg
#print axioms Legendre.Zeta.localZetaDegree_cast
#print axioms Legendre.Zeta.localZetaDegree_le
#print axioms Legendre.Zeta.localZetaFactor_eq_prod_nat
#print axioms Legendre.Zeta.norm_localZetaFactor_center_le
#print axioms Legendre.Zeta.one_fourth_pow_le_norm_localZetaFactor

#print axioms Legendre.Zeta.norm_localZetaRegularized_sphere_le
#print axioms Legendre.Zeta.norm_localZetaRegularized_disk_le
#print axioms Legendre.Zeta.norm_localZetaRegularized_ratio_le
#print axioms Legendre.Zeta.exists_localZetaLog
#print axioms Legendre.Zeta.localZetaLogBound_pos
#print axioms Legendre.Zeta.localZetaLog_re_le
#print axioms Legendre.Zeta.exists_localZetaLog_bounded
#print axioms Legendre.Zeta.norm_logDeriv_localZetaRegularized_le

#print axioms Legendre.Zeta.neg_logDeriv_re_le_local
#print axioms Legendre.Zeta.neg_logDeriv_re_le_local_sub_zero

#print axioms Legendre.Zeta.norm_deriv_zetaMellinRemainder_le
#print axioms Legendre.Zeta.deriv_poleRemovedZeta_eq
#print axioms Legendre.Zeta.one_half_le_norm_poleRemovedZeta
#print axioms Legendre.Zeta.norm_deriv_poleRemovedZeta_le
#print axioms Legendre.Zeta.norm_logDeriv_poleRemovedZeta_le
#print axioms Legendre.Zeta.neg_logDeriv_real_le_pole

#print axioms Legendre.Zeta.zetaZeroFreeK_pos
#print axioms Legendre.Zeta.zetaZeroFreeCost_pos
#print axioms Legendre.Zeta.zetaZeroFreeConstant_pos
#print axioms Legendre.Zeta.zeta_local_log_le
#print axioms Legendre.Zeta.localZetaLogBound_le_five_log
#print axioms Legendre.Zeta.localZetaLogBound_two_mul_le
#print axioms Legendre.Zeta.eighteen_le_log_term
#print axioms Legendre.Zeta.eighteen_le_zeroFreeCost_mul_log
#print axioms Legendre.Zeta.riemannZeta_ne_zero_of_log_region
#print axioms Legendre.Zeta.zetaZeroFreeK_le_ten
#print axioms Legendre.Zeta.zetaZeroFreeCost_le
#print axioms Legendre.Zeta.rational_le_zetaZeroFreeConstant
#print axioms Legendre.Zeta.riemannZeta_ne_zero_of_explicit_log_region

#print axioms Legendre.Zeta.localZetaDivisor_mem_ball
#print axioms Legendre.Zeta.localZetaRegularized_logDeriv_analyticOnNhd
#print axioms Legendre.Zeta.circleIntegral_localZetaRegularized_logDeriv
#print axioms Legendre.Zeta.circleIntegral_logDeriv_riemannZeta_eq_degree

#print axioms Legendre.Zeta.completedZeta_analyticAt
#print axioms Legendre.Zeta.zeta_order_eq_completed
#print axioms Legendre.Zeta.zeta_order_one_sub
#print axioms Legendre.Zeta.zeroMultiplicity_one_sub
#print axioms Legendre.Zeta.NontrivialZero.one_sub
#print axioms Legendre.Zeta.rightHalfZero_properties
#print axioms Legendre.Zeta.rightHalfZero_injOn

#print axioms Legendre.Zeta.counting_disk_coordinates
#print axioms Legendre.Zeta.counting_disk_ne_one
#print axioms Legendre.Zeta.riemannZeta_analyticOnNhd_counting_disk
#print axioms Legendre.Zeta.norm_riemannZeta_counting_disk_le
#print axioms Legendre.Zeta.countingDivisor_finite
#print axioms Legendre.Zeta.countingDivisor_eq_multiplicity
#print axioms Legendre.Zeta.countingDegree_cast
#print axioms Legendre.Zeta.mem_countingZeros
#print axioms Legendre.Zeta.countingDegree_le

#print axioms Legendre.Zeta.lowCountingSet_finite
#print axioms Legendre.Zeta.countingHeight_abs_ge
#print axioms Legendre.Zeta.countingHeightIndex_lt
#print axioms Legendre.Zeta.countingHeight_index_eq
#print axioms Legendre.Zeta.rightHalf_mem_counting_disk
#print axioms Legendre.Zeta.rightHalf_mem_countingZeros
#print axioms Legendre.Zeta.rightHalfZero_mem_cover

#print axioms Legendre.Zeta.sum_zeroMultiplicity_union_le
#print axioms Legendre.Zeta.sum_zeroMultiplicity_biUnion_le
#print axioms Legendre.Zeta.zeroCount_le_cover
#print axioms Legendre.Zeta.zeroCount_le_sum_countingDegree
#print axioms Legendre.Zeta.zeroCount_le_global_bound
#print axioms Legendre.Zeta.globalZeroCountConstant_pos
#print axioms Legendre.Zeta.global_counting_log_le
#print axioms Legendre.Zeta.zeroCount_le_mul_log
#print axioms Legendre.Zeta.zeroCount_isBigO
#print axioms Legendre.Zeta.zeroDensityCount_le_mul_log
