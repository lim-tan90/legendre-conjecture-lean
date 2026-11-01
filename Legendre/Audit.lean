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
public import Legendre.PrimeNumberTheorem
public import Legendre.PerronResidues
public import Legendre.PerronRectangle
public import Legendre.PerronExplicit
public import Legendre.PerronExplicitBounds
public import Lean.Elab.Print

/- Import implementation declarations solely for exhaustive dependency auditing. -/
import all Legendre.PNT.Auxiliary
import all Legendre.PNT.EulerMaclaurin
import all Legendre.PNT.Fourier
import all Legendre.PNT.Mathlib.Algebra.Notation.Support
import all Legendre.PNT.Mathlib.Analysis.SpecialFunctions.Log.Basic
import all Legendre.PNT.MediumPNT
import all Legendre.PNT.MellinCalculus
import all Legendre.PNT.Rectangle
import all Legendre.PNT.ResidueCalcOnRectangles
import all Legendre.PNT.SmoothExistence
import all Legendre.PNT.Sobolev
import all Legendre.PNT.StrongPNT
import all Legendre.PNT.ZetaBounds
import all Legendre.PNT.ZetaConj
import all Legendre.PrimeNumberTheorem
import all Legendre.PerronResidues
import all Legendre.PerronRectangle
import all Legendre.PerronExplicit
import all Legendre.PerronExplicitBounds


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

/- Layer 3: generated numeric name components cannot be written as ordinary Lean
identifiers. This command reconstructs the exact name and emits the standard
#print command; scripts/audit.py checks every listed expectation. -/
open Lean Elab Command in
elab "#audit_private_axioms " target:str : command => do
  let name := (target.getString.splitOn ".").foldl (fun name part =>
    match part.toNat? with
    | some n => Name.num name n
    | none => Name.str name part) Name.anonymous
  unless (← getEnv).contains name do
    throwError "Unknown audit target: {name}"
  elabCommand (← `(#print axioms $(mkIdent name)))

/- Layer 3: every theorem in the selected PNT+ slice and the downstream bridge. -/
#print axioms AnalyticOn.norm_le_of_norm_le_on_sphere
#print axioms B1._proof_1
#print axioms B1.eq_1
#print axioms BddAboveOnRect
#print axioms BddAbove_on_rectangle_of_bdd_near
#print axioms BddAbove_to_IsBigO
#print axioms BlaschkeAnalytic
#print axioms BlaschkeB.eq_1
#print axioms BlaschkeNonzero
#print axioms BlaschkeOfZero
#print axioms BorelCaratheodoryDeriv
#print axioms CS.bounded
#print axioms CS.continuous
#print axioms CS.deriv._proof_1
#print axioms CS.deriv._proof_2
#print axioms CS.deriv.eq_1
#print axioms CS.deriv_apply
#print axioms CS.deriv_scale
#print axioms CS.deriv_scale'
#print axioms CS.deriv_smul
#print axioms CS.ext
#print axioms CS.ext_iff
#print axioms CS.h1
#print axioms CS.h2
#print axioms CS.hasDerivAt
#print axioms CS.hasDerivAt_scale
#print axioms CS.instCoeRealComplex._proof_1
#print axioms CS.instCoeRealComplex._proof_2
#print axioms CS.mk.congr_simp
#print axioms CS.mk.inj
#print axioms CS.mk.injEq
#print axioms CS.mk.sizeOf_spec
#print axioms CS.neg._proof_1
#print axioms CS.neg._proof_2
#print axioms CS.neg_apply
#print axioms CS.scale._proof_1
#print axioms CS.scale._proof_2
#print axioms CS.scale._proof_3
#print axioms CS.scale._proof_4
#print axioms CS.scale.eq_1
#print axioms CS.smul._proof_1
#print axioms CS.smul._proof_2
#print axioms CS.smul_apply
#print axioms CS.tendsto_scale
#print axioms Cf.eq_1
#print axioms CfAnalytic
#print axioms Chebyshev.psi_eq_sum_range
#print axioms Complex.cpow_inv_tendsto
#print axioms Complex.cpow_tendsto
#print axioms Complex.deriv_ofReal
#print axioms Complex.differentiableAt_ofReal
#print axioms Complex.hasDerivAt_ofReal
#print axioms Complex.inv_re_add_im
#print axioms Complex.nhds_hasBasis_square
#print axioms Complex.ofReal_rpow
#print axioms Complex.one_div_cpow_eq
#print axioms ContinuousLinearEquiv.coe_toLinearEquiv_symm
#print axioms ContinuousOn.rectangleBorderIntegrable
#print axioms ContinuousOn.rectangleBorderNoPIntegrable
#print axioms ContinuousOn.rectangleBorder_integrable
#print axioms DeltaRange
#print axioms DeltaSpikeContinuous
#print axioms DeltaSpikeMass
#print axioms DeltaSpikeNonNeg_of_NonNeg
#print axioms DeltaSpikeOfRealContinuous
#print axioms DeltaSpikeSupport
#print axioms DeltaSpikeSupport'
#print axioms DeltaSpikeSupport_aux
#print axioms DeltaT.eq_1
#print axioms DerivUpperBnd_aux1
#print axioms DerivUpperBnd_aux2
#print axioms DerivUpperBnd_aux3
#print axioms DerivUpperBnd_aux4
#print axioms DerivUpperBnd_aux5
#print axioms DerivUpperBnd_aux6
#print axioms DerivUpperBnd_aux7
#print axioms DerivUpperBnd_aux7_1
#print axioms DerivUpperBnd_aux7_2
#print axioms DerivUpperBnd_aux7_3
#print axioms DerivUpperBnd_aux7_3'
#print axioms DerivUpperBnd_aux7_4
#print axioms DerivUpperBnd_aux7_5
#print axioms DerivUpperBnd_aux7_integral_eq
#print axioms DerivUpperBnd_aux7_nonneg
#print axioms DerivUpperBnd_aux7_tendsto
#print axioms DerivZeta0EqDerivZeta
#print axioms DerivativeBound
#print axioms DiffVertRect_eq_UpperLowerUs
#print axioms Differentiable.comp_ofReal
#print axioms Differentiable.ofReal_comp
#print axioms Differentiable.ofReal_comp_iff
#print axioms DifferentiableAt.comp_ofReal
#print axioms DifferentiableAt.ofReal_comp
#print axioms DifferentiableAt.ofReal_comp_iff
#print axioms DiskBound
#print axioms E._proof_1
#print axioms EinIoo
#print axioms FLogTtoDeltaT
#print axioms F_add
#print axioms F_mul
#print axioms F_neg
#print axioms F_sub
#print axioms Fequ
#print axioms Filter.BigO_zero_atTop_of_support_in_Icc
#print axioms Filter.BigO_zero_atZero_of_support_in_Icc
#print axioms Filter.TendstoAtTop_of_support_in_Icc
#print axioms Filter.TendstoAtZero_of_support_in_Icc
#print axioms FinIoo
#print axioms FinalBound
#print axioms Finset.Icc0_eq
#print axioms Finset.Icc_eq_Ico
#print axioms Finset.Ioc_eq_Icc
#print axioms Finset.Ioc_eq_Ico
#print axioms Function.support_abs
#print axioms Function.support_deriv_subset_Icc
#print axioms Function.support_id
#print axioms Function.support_id'
#print axioms Function.support_mul_subset_of_subset
#print axioms Function.support_ofReal
#print axioms Function.support_of_along_fiber_subset_subset
#print axioms GapSize
#print axioms GenStrengthPNT
#print axioms GlobalBound
#print axioms HIntegral'._proof_1
#print axioms HIntegral.eq_1
#print axioms HIntegral_symm
#print axioms HasDerivAt.of_hasDerivAt_ofReal_comp
#print axioms HasDerivAtZeta0
#print axioms HasDerivAt_cpow_over_var
#print axioms HasDerivAt_neg_cpow_over2
#print axioms HasProd.nnnorm
#print axioms HasSimplePolesOn.mono
#print axioms HolomorphicOn.rectangleBorderIntegrable
#print axioms HolomorphicOn.rectangleBorderIntegrable'
#print axioms HolomorphicOn.vanishesOnRectangle
#print axioms HolomorphicOn_riemannZeta
#print axioms HolomorphicOn_riemannZeta0
#print axioms I1Bound
#print axioms I2GenBound
#print axioms I3GenBound
#print axioms I4GenBound
#print axioms I5Bound
#print axioms I6GenBound
#print axioms I6I4
#print axioms I7GenBound
#print axioms I7I3
#print axioms I8GenBound
#print axioms I8I2
#print axioms I9Bound
#print axioms I9I1
#print axioms IBound_aux1
#print axioms IntervalIntegral.integral_eq_integral_of_support_subset_Icc
#print axioms Ioi_union_Iio_mem_cocompact
#print axioms IsBigO_to_BddAbove
#print axioms I₁._proof_1
#print axioms I₄.eq_1
#print axioms I₅.eq_1
#print axioms I₆.eq_1
#print axioms JBlaschke._proof_1
#print axioms JBlaschke.congr_simp
#print axioms JBlaschkeDerivBound
#print axioms Legendre.PNT.classicalError.eq_1
#print axioms Legendre.PNT.classicalError_eventually_ge_one
#print axioms Legendre.PNT.classicalError_hasDerivAt
#print axioms Legendre.PNT.classicalError_isLittleO
#print axioms Legendre.PNT.eventually_classicalError_bounds
#print axioms Legendre.PNT.exists_smoothed_truncated_formula
#print axioms Legendre.PNT.exp_le_two_mul_classicalErrorDeriv
#print axioms Legendre.PNT.logarithmicIntegral._proof_1
#print axioms Legendre.PNT.logarithmicIntegral.eq_1
#print axioms Legendre.PNT.logarithmicIntegral_eq
#print axioms Legendre.PNT.pnt_classical_error
#print axioms Legendre.PNT.pnt_eventual_bound
#print axioms Legendre.PNT.primeCount.eq_1
#print axioms Legendre.PNT.primeCount_error_of_theta
#print axioms Legendre.PNT.primeCount_sub_logarithmicIntegral
#print axioms Legendre.PNT.psi_classical_error
#print axioms Legendre.PNT.sqrt_isBigO_classicalError
#print axioms Legendre.PNT.sqrt_le_classicalError
#print axioms Legendre.PNT.theta_error_intervalIntegrable
#print axioms LogDerivZetaBdd_of_Re_ge_three_halves
#print axioms LogDerivZetaBnd
#print axioms LogDerivZetaBndUnif12
#print axioms LogDerivZetaBndUnif99
#print axioms LogDerivZetaBoundedAndHolo12
#print axioms LogDerivZetaBoundedAndHolo99
#print axioms LogDerivZetaBoundedAndHoloGen
#print axioms LogDerivZetaFinalBound
#print axioms LogDerivZetaHasBound._proof_1
#print axioms LogDerivZetaHolcLargeT1
#print axioms LogDerivZetaHolcLargeT9
#print axioms LogDerivZetaHolcLargeTGen
#print axioms LogDerivZetaHolcSmallT
#print axioms LogDerivZetaHolcSmallT'
#print axioms LogDerivZetaHoloOn
#print axioms LogDerivZetaUniformLogSquaredBound
#print axioms LogDerivZetaUniformLogSquaredBoundStrip
#print axioms LogDerivZetaUniformLogSquaredBoundStripSpec
#print axioms LogDerivativeDirichlet
#print axioms LogOfAnalyticFunction
#print axioms LogOfAnalyticFunction'
#print axioms LowerUIntegral.eq_1
#print axioms MeasureTheory.integral_comp_div_I0i_haar
#print axioms MeasureTheory.integral_comp_inv_I0i_haar
#print axioms MeasureTheory.integral_comp_mul_left_I0i_haar
#print axioms MeasureTheory.integral_comp_mul_right_I0i_haar
#print axioms MeasureTheory.integral_comp_mul_right_I0i_haar_real
#print axioms MeasureTheory.integral_comp_rpow_I0i_haar_real
#print axioms MeasureTheory.setIntegral_integral_swap
#print axioms MediumPNT
#print axioms MellinConvNonNeg_of_NonNeg
#print axioms MellinConvolution.eq_1
#print axioms MellinConvolutionSymmetric
#print axioms MellinConvolutionTransform
#print axioms MellinOf1
#print axioms MellinOfDeltaSpike
#print axioms MellinOfDeltaSpikeAt1
#print axioms MellinOfDeltaSpikeAt1_asymp
#print axioms MellinOfPsi
#print axioms MellinOfPsi_aux
#print axioms MellinOfSmooth1a
#print axioms MellinOfSmooth1b
#print axioms MellinOfSmooth1c
#print axioms MellinOfSmooth1cExplicit
#print axioms Multipliable.nnnorm
#print axioms Multipliable.nnnorm_tprod
#print axioms Nat.self_div_floor_bound
#print axioms PartialIntegration
#print axioms PartialIntegration_of_support_in_Icc
#print axioms Real.differentiableAt_cpow_const_of_ne
#print axioms Real.log_le_const_mul_rpow
#print axioms Real.log_natCast_monotone
#print axioms Real.tendsto_pow_log_div_pow_atTop
#print axioms RectSubRect
#print axioms RectSubRect'
#print axioms Rectangle.symm
#print axioms Rectangle.symm_re
#print axioms RectangleBorder.eq_1
#print axioms RectangleBorderIntegrable.add
#print axioms RectangleIntegral'.eq_1
#print axioms RectangleIntegral'_congr
#print axioms RectangleIntegral'_eq_sumResiduesIn
#print axioms RectangleIntegral.const_mul'
#print axioms RectangleIntegral.const_smul
#print axioms RectangleIntegral.eq_1
#print axioms RectangleIntegral.translate
#print axioms RectangleIntegral.translate'
#print axioms RectangleIntegralHSplit
#print axioms RectangleIntegralHSplit'
#print axioms RectangleIntegralVSplit
#print axioms RectangleIntegralVSplit'
#print axioms RectangleIntegral_congr
#print axioms RectanglePullToNhdOfPole
#print axioms RectanglePullToNhdOfPole'
#print axioms RectanglePullToNhdOfPole''
#print axioms ResidueMult
#print axioms ResidueOfTendsTo
#print axioms ResidueTheoremAtOrigin
#print axioms ResidueTheoremAtOrigin'
#print axioms ResidueTheoremAtOrigin_aux1c
#print axioms ResidueTheoremAtOrigin_aux1c'
#print axioms ResidueTheoremAtOrigin_aux2c
#print axioms ResidueTheoremAtOrigin_aux2c'
#print axioms ResidueTheoremInRectangle
#print axioms ResidueTheoremOnRectangleWithSimplePole
#print axioms ResidueTheoremOnRectangleWithSimplePole'
#print axioms Set.left_not_mem_uIoo
#print axioms Set.ne_left_of_mem_uIoo
#print axioms Set.ne_right_of_mem_uIoo
#print axioms Set.right_not_mem_uIoo
#print axioms SetIntegral.integral_eq_integral_inter_of_support_subset
#print axioms SetIntegral.integral_eq_integral_inter_of_support_subset_Icc
#print axioms SetOfZeros.eq_1
#print axioms ShiftOneBound
#print axioms ShiftTwoBound
#print axioms ShiftZeroBound
#print axioms SmallSquareInRectangle
#print axioms Smooth1ContinuousAt
#print axioms Smooth1LeOne
#print axioms Smooth1LeOne_aux
#print axioms Smooth1MellinConvergent
#print axioms Smooth1MellinDifferentiable
#print axioms Smooth1Nonneg
#print axioms Smooth1Properties_above
#print axioms Smooth1Properties_above_aux
#print axioms Smooth1Properties_above_aux2
#print axioms Smooth1Properties_below
#print axioms Smooth1Properties_below_aux
#print axioms Smooth1Properties_estimate
#print axioms Smooth1_def_ite
#print axioms SmoothExistence
#print axioms SmoothedChebyshevClose
#print axioms SmoothedChebyshevClose_aux
#print axioms SmoothedChebyshevDirichlet
#print axioms SmoothedChebyshevDirichlet_aux_integrable
#print axioms SmoothedChebyshevDirichlet_aux_tsum_integral
#print axioms SmoothedChebyshevPull1
#print axioms SmoothedChebyshevPull1_aux_integrable
#print axioms SmoothedChebyshevPull2
#print axioms SmoothedChebyshevPull2_aux1
#print axioms Square.eq_1
#print axioms Square_apply
#print axioms StrongPNT
#print axioms SumBoundI
#print axioms SumBoundII
#print axioms Tendsto_nhdsWithin_punctured_add
#print axioms Tendsto_nhdsWithin_punctured_map_add
#print axioms UpperBnd_aux
#print axioms UpperBnd_aux2
#print axioms UpperBnd_aux3
#print axioms UpperBnd_aux5
#print axioms UpperBnd_aux6
#print axioms UpperUIntegral.eq_1
#print axioms VIntegral.eq_1
#print axioms VIntegral_symm
#print axioms VerticalIntegral.eq_1
#print axioms W1.continuous
#print axioms W1.deriv._proof_1
#print axioms W1.deriv._proof_2
#print axioms W1.differentiable
#print axioms W1.hasDerivAt
#print axioms W1.integrable
#print axioms W1.integrable_iteratedDeriv_Schwarz
#print axioms W1.iteratedDeriv_sub
#print axioms W1.mk.inj
#print axioms W1.mk.injEq
#print axioms W1.mk.sizeOf_spec
#print axioms W1.of_Schwartz._proof_1
#print axioms W1.smooth
#print axioms W1.sub._proof_1
#print axioms W1.sub._proof_2
#print axioms W21.hf
#print axioms W21.hf'
#print axioms W21.hf''
#print axioms W21.instHMulCSOfNatNatComplex._proof_1
#print axioms W21.instHMulCSOfNatNatComplex._proof_2
#print axioms W21.instHMulCSOfNatNatRealComplex._proof_1
#print axioms W21.instHMulCSOfNatNatRealComplex._proof_2
#print axioms W21.norm._proof_1
#print axioms W21.norm_nonneg
#print axioms W21.ofCS2._proof_1
#print axioms W21.ofCS2._proof_2
#print axioms W21_approximation
#print axioms ZeroFactor._proof_1
#print axioms ZeroFactor.eq_1
#print axioms ZeroFactorization
#print axioms ZeroInequality
#print axioms ZeroInequalitySpec
#print axioms ZeroWindow._proof_1
#print axioms ZeroWindow._proof_2
#print axioms ZeroWindow._proof_3
#print axioms ZeroWindow.eq_1
#print axioms ZeroWindowFinite
#print axioms ZerosBound
#print axioms Zeta0EqZeta
#print axioms Zeta1AltFormula
#print axioms ZetaAltFormula
#print axioms ZetaBnd_aux1
#print axioms ZetaBnd_aux1a
#print axioms ZetaBnd_aux1b
#print axioms ZetaBnd_aux1p
#print axioms ZetaBnd_aux2
#print axioms ZetaBoxEval
#print axioms ZetaCont
#print axioms ZetaDerivUpperBnd
#print axioms ZetaDerivUpperBnd'
#print axioms ZetaFixedLowerBound
#print axioms ZetaInvBnd
#print axioms ZetaInvBnd_aux
#print axioms ZetaInvBnd_aux'
#print axioms ZetaInvBnd_aux2
#print axioms ZetaInvBound1
#print axioms ZetaInvBound2
#print axioms ZetaLowerBnd
#print axioms ZetaLowerBound1
#print axioms ZetaLowerBound1_aux1
#print axioms ZetaLowerBound2
#print axioms ZetaLowerBound3
#print axioms ZetaLowerBound3_aux1
#print axioms ZetaLowerBound3_aux2
#print axioms ZetaLowerBound3_aux3
#print axioms ZetaLowerBound3_aux4
#print axioms ZetaLowerBound3_aux5
#print axioms ZetaNear1BndExact
#print axioms ZetaNear1BndFilter
#print axioms ZetaNoZerosInBox
#print axioms ZetaNoZerosOn1Line
#print axioms ZetaShiftFiniteZeros
#print axioms ZetaSum_aux1
#print axioms ZetaSum_aux1_1
#print axioms ZetaSum_aux1_1'
#print axioms ZetaSum_aux1_2
#print axioms ZetaSum_aux1_3
#print axioms ZetaSum_aux1_4
#print axioms ZetaSum_aux1_4'
#print axioms ZetaSum_aux1_5
#print axioms ZetaSum_aux1_5a
#print axioms ZetaSum_aux1_5b
#print axioms ZetaSum_aux1_5c
#print axioms ZetaSum_aux1_5d
#print axioms ZetaSum_aux1derivφCont
#print axioms ZetaSum_aux1φDiff
#print axioms ZetaSum_aux1φderiv
#print axioms ZetaSum_aux1₁
#print axioms ZetaSum_aux2
#print axioms ZetaSum_aux2a
#print axioms ZetaSum_aux3
#print axioms ZetaUpperBnd
#print axioms ZetaUpperBnd'
#print axioms ZetaZeroFree1
#print axioms ZetaZeroFree9
#print axioms ZetaZeroFreeGenProp._proof_1
#print axioms Zeta_diff_Bnd
#print axioms Zeta_eq_int_derivZeta
#audit_private_axioms "_private.Legendre.PNT.EulerMaclaurin.0.abs_B1_le_half._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.EulerMaclaurin.0.abs_B1_le_half._proof_1_2"
#audit_private_axioms "_private.Legendre.PNT.EulerMaclaurin.0.integral_deriv_mul_add_const._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.fourierIntegral_self_add_deriv_deriv._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.fourierIntegral_self_add_deriv_deriv._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.fourierIntegral_self_add_deriv_deriv._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.fourierIntegral_self_add_deriv_deriv._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.fourierIntegral_self_add_deriv_deriv._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.fourierIntegral_self_add_deriv_deriv._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.fourierIntegral_self_add_deriv_deriv._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.fourierIntegral_self_add_deriv_deriv._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div_abs._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div_abs._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div_abs._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div_abs._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div_abs._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div_abs._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div_abs._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.Fourier.0.norm_oscillatory_integral_le_integral_deriv_div_abs._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.GenStrengthPNT._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_17"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I1Bound._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I2GenBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I2GenBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I2GenBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I2GenBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I2GenBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I3GenBound._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I4GenBound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_17"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_18"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.I5Bound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.IBound_aux1._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.LogDerivZetaBoundedAndHoloGen._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.LogDerivZetaBoundedAndHoloGen._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.LogDerivZetaBoundedAndHoloGen._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.MediumPNT._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._proof_1_11"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._proof_1_12"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._proof_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_19"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevClose_aux._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet_aux_integrable._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet_aux_tsum_integral._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet_aux_tsum_integral._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet_aux_tsum_integral._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevDirichlet_aux_tsum_integral._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull1._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2_aux1._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2_aux1._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.SmoothedChebyshevPull2_aux1._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.integral_evaluation._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.integral_evaluation._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.integral_evaluation._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.integral_evaluation._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.integral_evaluation._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.integral_evaluation._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.integral_evaluation._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.integral_evaluation._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.log_pow_over_xsq_integral_bounded._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.log_pow_over_xsq_integral_bounded._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.log_pow_over_xsq_integral_bounded._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.log_pow_over_xsq_integral_bounded._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MediumPNT.0.log_pow_over_xsq_integral_bounded._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Complex.ofReal_rpow._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeMass._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeMass._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeSupport_aux._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeSupport_aux._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeSupport_aux._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeSupport_aux._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeSupport_aux._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeSupport_aux._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeSupport_aux._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.DeltaSpikeSupport_aux._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Function.support_abs._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Function.support_mul_subset_of_subset._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Function.support_of_along_fiber_subset_subset._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_inv_I0i_haar._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_inv_I0i_haar._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_inv_I0i_haar._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_inv_I0i_haar._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_inv_I0i_haar._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_inv_I0i_haar._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_inv_I0i_haar._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_rpow_I0i_haar_real._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_rpow_I0i_haar_real._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_rpow_I0i_haar_real._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_rpow_I0i_haar_real._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_rpow_I0i_haar_real._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_rpow_I0i_haar_real._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MeasureTheory.integral_comp_rpow_I0i_haar_real._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinConvNonNeg_of_NonNeg._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinConvolutionTransform._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinConvolutionTransform._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinConvolutionTransform._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinConvolutionTransform._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinConvolutionTransform._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinConvolutionTransform._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinConvolutionTransform._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfPsi._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfPsi_aux._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfPsi_aux._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfPsi_aux._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfSmooth1a._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfSmooth1a._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfSmooth1a._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfSmooth1a._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfSmooth1a._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfSmooth1a._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfSmooth1a._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.MellinOfSmooth1a._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1ContinuousAt._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1ContinuousAt._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1ContinuousAt._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1ContinuousAt._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1ContinuousAt._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1ContinuousAt._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1ContinuousAt._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne_aux._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne_aux._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne_aux._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne_aux._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne_aux._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne_aux._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1LeOne_aux._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1MellinConvergent._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1MellinDifferentiable._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above_aux._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above_aux._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above_aux._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above_aux._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above_aux._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above_aux._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_above_aux._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_below._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_below._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_below._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_below._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_below._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_below._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_estimate._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_estimate._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_estimate._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_estimate._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1Properties_estimate._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.Smooth1_def_ite._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.MellinCalculus.0.support_MellinConvolution_subsets._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.Complex.nhds_hasBasis_square._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.rectangleBorder_disjoint_singleton._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.rectangleBorder_disjoint_singleton._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.rectangle_in_convex._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.rectangle_mem_nhds_iff._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.segment_reProdIm_segment_eq_convexHull._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.segment_reProdIm_segment_eq_convexHull._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.segment_reProdIm_segment_eq_convexHull._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.Rectangle.0.segment_reProdIm_segment_eq_convexHull._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.BddAbove_on_rectangle_of_bdd_near._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.BddAbove_on_rectangle_of_bdd_near._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.BddAbove_on_rectangle_of_bdd_near._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.BddAbove_on_rectangle_of_bdd_near._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.DiffVertRect_eq_UpperLowerUs._abel_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.HIntegral_congr_codiscreteWithin"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.IsBigO_to_BddAbove._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.IsBigO_to_BddAbove._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.IsBigO_to_BddAbove._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.IsBigO_to_BddAbove._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.IsBigO_to_BddAbove._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.RectangleIntegral'_eq_sumResiduesIn._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.RectangleIntegral'_eq_sumResiduesIn._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.RectangleIntegral.translate._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.RectangleIntegral.translate._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.RectangleIntegralHSplit._abel_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.RectanglePullToNhdOfPole'._abel_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin'._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin'._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin'._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin'._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin'._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin'._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin'._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin_aux1c'._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin_aux1c._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin_aux2c'._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremAtOrigin_aux2c._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.ResidueTheoremInRectangle._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.VIntegral_congr_codiscreteWithin"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.holoPart_holomorphicOn"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.horizontalPath_not_eventuallyConst"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_re_add_self._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_re_add_self._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_re_add_self._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_re_add_self._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_re_add_self._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_re_add_self._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_re_add_self._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_sq_add_sq._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_sq_add_sq._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_const_div_sq_add_sq._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_self_div_sq_add_sq._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_self_div_sq_add_sq._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_self_div_sq_add_sq._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_self_div_sq_add_sq._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_self_div_sq_add_sq._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_self_div_sq_add_sq._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.integral_self_div_sq_add_sq._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.intervalIntegral_congr_ae_of_codiscreteWithin_along_path"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.meromorphicOrderAt_eq_neg_one_of_simplePole"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.meromorphicOrderAt_eq_neg_one_of_simplePole._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.meromorphicOrderAt_sub_principalPart_nonneg"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.principalPart_borderIntegrable"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.principalPart_meromorphicOn"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.rectangleIntegral'_sum_div_sub"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.rectangleIntegral'_toMeromorphicNFOn_eq"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.rectangleIntegral_symm._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.rectangleIntegral_symm_re._abel_1_3"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.rectangleIntegral_symm_re._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.rectangle_mem_nhds_of_interior"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.rectangle_mem_nhds_of_interior._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.residue_toMeromorphicNFOn_eq_residue"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.sub_principalPart_analyticAt_of_not_mem_poles"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.sum_div_rectangleBorderIntegrable"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.toMeromorphicNFOn_add_integral"
#audit_private_axioms "_private.Legendre.PNT.ResidueCalcOnRectangles.0.verticalIntegral_split_three._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.SmoothExistence._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_17"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_18"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_19"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.SmoothExistence.0.smooth_urysohn_support_Ioo._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.Sobolev.0.W21_approximation._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.Sobolev.0.W21_approximation._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.Sobolev.0.W21_approximation._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.Sobolev.0.W21_approximation._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.Sobolev.0.W21_approximation._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.BlaschkeNonzero._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.BlaschkeNonzero._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.BlaschkeNonzero._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.BlaschkeOfZero._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.CfAnalytic._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DerivativeBound._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DiskBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DiskBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DiskBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DiskBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DiskBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DiskBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.DiskBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinIoo._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinIoo._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinIoo._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_17"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_18"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_19"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_20"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_21"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_22"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_23"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_26"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.FinalBound._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.GlobalBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.GlobalBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.GlobalBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.GlobalBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.HasProd.nnnorm._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaBdd_of_Re_ge_three_halves._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaFinalBound._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBound._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_18"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_19"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_20"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_21"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_22"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_23"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_24"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_25"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_26"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_27"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_28"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_29"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogDerivZetaUniformLogSquaredBoundStrip._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogOfAnalyticFunction._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogOfAnalyticFunction._proof_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogOfAnalyticFunction._proof_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogOfAnalyticFunction._proof_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.LogOfAnalyticFunction._proof_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_17"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_18"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftOneBound._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftTwoBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftTwoBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftTwoBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftTwoBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftTwoBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftTwoBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftTwoBound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_17"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_18"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_19"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_20"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_21"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_22"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_23"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_24"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_25"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ShiftZeroBound._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.StrongPNT._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundI._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundII._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundII._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundII._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundII._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundII._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.SumBoundII._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_17"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_18"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_19"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_20"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_21"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_22"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_23"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroInequality._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroWindowFinite._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroWindowFinite._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroWindowFinite._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroWindowFinite._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroWindowFinite._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroWindowFinite._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroWindowFinite._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZeroWindowFinite._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.Zeta1AltFormula._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.Zeta1AltFormula._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.Zeta1AltFormula._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.Zeta1AltFormula._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.Zeta1AltFormula._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.Zeta1AltFormula._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.Zeta1AltFormula._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZetaFixedLowerBound._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZetaShiftFiniteZeros._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZetaShiftFiniteZeros._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZetaShiftFiniteZeros._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZetaShiftFiniteZeros._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZetaZeroFree1._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.ZetaZeroFree1._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.analyticOrderNatAt_fun_comp_add_left._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.analyticOrderNatAt_fun_comp_add_left._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.analyticOrderNatAt_fun_comp_add_left._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.analyticOrderNatAt_fun_comp_add_right._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.analyticOrderNatAt_fun_comp_add_right._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.analyticOrderNatAt_fun_comp_add_right._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.analyticOrderNatAt_fun_div_const._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.norm_fOfZero_le_norm_BlaschkeOfZero._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.norm_zeta_strict_mono_ofReal._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.StrongPNT.0.norm_zeta_strict_mono_ofReal._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.BddAbove_to_IsBigO._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.BddAbove_to_IsBigO._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.BddAbove_to_IsBigO._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.BddAbove_to_IsBigO._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.BddAbove_to_IsBigO._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux1._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux1._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux1._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux5._proof_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux5._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux7._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux7_1._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux7_1._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux7_1._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux7_1._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux7_1._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux7_1._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.DerivUpperBnd_aux7_1._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc0_eq._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc_eq_Ico._proof_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc_eq_Ico._proof_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc_eq_Ico._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Icc_eq_Ico._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Ioc_eq_Icc._proof_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Ioc_eq_Icc._proof_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Ioc_eq_Icc._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Ioc_eq_Icc._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Ioc_eq_Ico._proof_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Ioc_eq_Ico._proof_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Ioc_eq_Ico._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Finset.Ioc_eq_Ico._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.HasDerivAtZeta0._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Ioi_union_Iio_mem_cocompact._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBnd._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_17"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaBndUnif99._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT'._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT'._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT'._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT'._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT'._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT'._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.LogDerivZetaHolcSmallT._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Nat.self_div_floor_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Real.log_natCast_monotone._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueMult._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueMult._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ResidueOfTendsTo._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Tendsto_nhdsWithin_punctured_map_add._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.UpperBnd_aux._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.UpperBnd_aux3._proof_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.UpperBnd_aux3._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta0EqZeta._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta0EqZeta._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta0EqZeta._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta0EqZeta._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta0EqZeta._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaBnd_aux2._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaCont._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaCont._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaCont._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd_aux2._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBnd_aux2._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound1._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound1._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound1._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound1._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound1._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound1._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound2._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound2._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound2._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound2._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaInvBound2._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_16"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_18"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_19"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_26"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_29"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_30"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_31"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_32"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_33"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_34"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBnd._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound1._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound1._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound1_aux1._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound3._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound3._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound3._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound3._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound3._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaLowerBound3._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNear1BndExact._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNear1BndExact._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNear1BndExact._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNear1BndExact._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNear1BndExact._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNear1BndExact._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNear1BndExact._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNear1BndFilter._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaNoZerosInBox._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaSum_aux1._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaSum_aux1_4'._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaSum_aux1φDiff._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaSum_aux1₁._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaUpperBnd'._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaUpperBnd'._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.ZetaUpperBnd'._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta_diff_Bnd._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta_eq_int_derivZeta._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta_eq_int_derivZeta._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta_eq_int_derivZeta._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.Zeta_eq_int_derivZeta._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.deriv_f_minus_A_inv_sub_clean._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.deriv_inv_sub._proof_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.div_rpow_neg_eq_rpow_div._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.div_rpow_neg_eq_rpow_div._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.div_rpow_neg_eq_rpow_div._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.div_rpow_neg_eq_rpow_div._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.div_rpow_neg_eq_rpow_div._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.div_rpow_neg_eq_rpow_div._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.div_rpow_neg_eq_rpow_div._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.harmonic_eq_sum_Icc0_aux._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.harmonic_eq_sum_Icc0_aux._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.harmonic_eq_sum_Icc0_aux._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.harmonic_eq_sum_Icc0_aux._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.harmonic_eq_sum_Icc0_aux._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._proof_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.hasDerivAt_Zeta0Integral._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.integrableOn_of_Zeta0_fun._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.integrableOn_of_Zeta0_fun_log._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.integrableOn_of_Zeta0_fun_log._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.integrableOn_of_Zeta0_fun_log._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.integrableOn_of_Zeta0_fun_log._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.integrableOn_of_Zeta0_fun_log._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.integrableOn_of_Zeta0_fun_log._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.isPathConnected_aux._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.isPathConnected_aux._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_12"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_13"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_15"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.logDerivResidue'._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.lt_abs_mem_cocompact._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.lt_abs_mem_cocompact._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.lt_abs_mem_cocompact._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.lt_abs_mem_cocompact._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.lt_abs_mem_cocompact._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.norm_add₅_le._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.norm_add₆_le._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZeta0_zero_aux._proof_1_7"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZeta0_zero_aux._proof_1_8"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZeta0_zero_aux._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZeta0_zero_aux._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZeta0_zero_aux._simp_1_3"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZeta0_zero_aux._simp_1_4"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZeta0_zero_aux._simp_1_5"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZeta0_zero_aux._simp_1_6"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZetaLogDerivResidue._simp_1_1"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.riemannZetaLogDerivResidue._simp_1_2"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.triv_bound_zeta._simp_1_10"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.triv_bound_zeta._simp_1_11"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.triv_bound_zeta._simp_1_14"
#audit_private_axioms "_private.Legendre.PNT.ZetaBounds.0.triv_bound_zeta._simp_1_9"
#audit_private_axioms "_private.Legendre.PNT.ZetaConj.0.deriv_riemannZeta_conj._simp_1_1"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.logarithmicIntegral_eq._simp_1_2"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.logarithmicIntegral_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.logarithmicIntegral_eq._simp_1_4"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.logarithmicIntegral_eq._simp_1_5"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.logarithmicIntegral_eq._simp_1_6"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.logarithmicIntegral_eq._simp_1_7"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.logarithmicIntegral_eq._simp_1_8"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_error_of_theta._simp_1_1"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_error_of_theta._simp_1_2"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_error_of_theta._simp_1_3"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_error_of_theta._simp_1_4"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_error_of_theta._simp_1_5"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_error_of_theta._simp_1_6"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_error_of_theta._simp_1_7"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_sub_logarithmicIntegral._simp_1_3"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_sub_logarithmicIntegral._simp_1_4"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_sub_logarithmicIntegral._simp_1_5"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_sub_logarithmicIntegral._simp_1_6"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_sub_logarithmicIntegral._simp_1_7"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_sub_logarithmicIntegral._simp_1_8"
#audit_private_axioms "_private.Legendre.PrimeNumberTheorem.0.Legendre.PNT.primeCount_sub_logarithmicIntegral._simp_1_9"
#print axioms abs_B1_le_half
#print axioms ae_volume_of_contains_compl_singleton_zero
#print axioms aestronglyMeasurable_B1
#print axioms analyticAt_finset_prod_sub_pow
#print axioms analyticAt_riemannZeta
#print axioms analyticOrderNatAt_fun_comp_add_left
#print axioms analyticOrderNatAt_fun_comp_add_right
#print axioms analyticOrderNatAt_fun_div_const
#print axioms analytic_deriv_bounded_near_point
#print axioms borelCaratheodory'
#print axioms cauchy_formula_deriv
#print axioms contDiff_ofReal
#print axioms continuous_self_div_sq_add_sq
#print axioms deriv.comp_ofReal
#print axioms deriv.comp_ofReal'
#print axioms deriv.ofReal_comp
#print axioms deriv.ofReal_comp'
#print axioms deriv_conj_conj'
#print axioms deriv_eqOn_of_eqOn_punctured
#print axioms deriv_f_minus_A_inv_sub_clean
#print axioms deriv_fun_re
#print axioms deriv_inv_sub
#print axioms deriv_ofReal
#print axioms deriv_riemannZeta_conj
#print axioms derivative_const_plus_product
#print axioms differentiableAt_deriv_riemannZeta
#print axioms div_cpow_eq_cpow_neg
#print axioms div_rpow_eq_rpow_div_neg
#print axioms div_rpow_eq_rpow_neg
#print axioms div_rpow_neg_eq_rpow_div
#print axioms dlog_riemannZeta_bdd_on_vertical_lines
#print axioms dlog_riemannZeta_bdd_on_vertical_lines_explicit
#print axioms dlog_riemannZeta_bdd_on_vertical_lines_generalized
#print axioms e._proof_1
#print axioms e._proof_2
#print axioms e._proof_3
#print axioms e_apply
#print axioms existsDifferentiableOn_of_bddAbove
#print axioms finiteSetOfZeros_mono
#print axioms finsetSum_tendsto_tsum
#print axioms fourierIntegral_deriv_aux2
#print axioms fourierIntegral_self_add_deriv_deriv
#print axioms funscale.eq_1
#print axioms harmonic_eq_sum_Icc0
#print axioms harmonic_eq_sum_Icc0_aux
#print axioms hasDerivAt_Zeta0Integral
#print axioms hasDerivAt_e
#print axioms integrableOn_of_Zeta0_fun
#print axioms integrableOn_of_Zeta0_fun_log
#print axioms integrable_log_over_pow
#print axioms integral_const_div_re_add_self
#print axioms integral_const_div_self_add_im
#print axioms integral_const_div_sq_add_sq
#print axioms integral_deriv_mul_add_const
#print axioms integral_deriv_mul_floor_add_one
#print axioms integral_evaluation
#print axioms integral_self_div_sq_add_sq
#print axioms intervalIntegrable_deriv_mul_B1
#print axioms intervalIntegral.norm_integral_le_of_norm_le_const'
#print axioms intervalIntegral_conj
#print axioms interval_membership
#print axioms isOpen_aux
#print axioms isPathConnected_aux
#print axioms le_trans₄
#print axioms left_mem_rect
#print axioms logDerivResidue
#print axioms logDerivResidue'
#print axioms logDerivResidue''
#print axioms logDerivZeta_conj
#print axioms logDerivZeta_conj'
#print axioms log_pow_over_xsq_integral_bounded
#print axioms logt_gt_one
#print axioms lt_abs_mem_cocompact
#print axioms lt_trans₄
#print axioms mapsTo_rectangleBorder_left_im
#print axioms mapsTo_rectangleBorder_left_re
#print axioms mapsTo_rectangleBorder_right_im
#print axioms mapsTo_rectangleBorder_right_re
#print axioms mapsTo_rectangle_left_im
#print axioms mapsTo_rectangle_left_im_NoP
#print axioms mapsTo_rectangle_left_re
#print axioms mapsTo_rectangle_left_re_NoP
#print axioms mapsTo_rectangle_right_im
#print axioms mapsTo_rectangle_right_im_NoP
#print axioms mapsTo_rectangle_right_re
#print axioms mapsTo_rectangle_right_re_NoP
#print axioms measurable_floor_add_half_sub
#print axioms mem_Rect
#print axioms mem_within_strip
#print axioms mul_le_mul₃
#print axioms nnnorm_circle_smul
#print axioms nnnorm_eq_of_mem_circle
#print axioms nonZeroOfBddAbove
#print axioms norm_add₅_le
#print axioms norm_add₆_le
#print axioms norm_complex_log_ofNat
#print axioms norm_fOfZero_le_norm_BlaschkeOfZero
#print axioms norm_fourier_le_integral_deriv_div
#print axioms norm_oscillatory_integral_le_integral_deriv_div
#print axioms norm_oscillatory_integral_le_integral_deriv_div_abs
#print axioms norm_zeta_product_ge_one
#print axioms norm_zeta_strict_mono_ofReal
#print axioms not_mem_rectangleBorder_of_rectangle_mem_nhds
#print axioms one_add_inv_log
#print axioms one_div_cpow_eq_cpow_neg
#print axioms poisson_kernel_integrable
#print axioms preimage_equivRealProdCLM_reProdIm
#print axioms realDiff_of_complexDiff
#print axioms rect_subset_iff
#print axioms rectangleBorder_disjoint_singleton
#print axioms rectangleBorder_subset_punctured_rect
#print axioms rectangleBorder_subset_rectangle
#print axioms rectangleIntegral_symm
#print axioms rectangleIntegral_symm_re
#print axioms rectangle_disjoint_singleton
#print axioms rectangle_in_convex
#print axioms rectangle_mem_nhds_iff
#print axioms rectangle_subset_punctured_rect
#print axioms residue.eq_1
#print axioms residue_analyticAt_eq_zero
#print axioms residue_eq_of_tendsto
#print axioms residue_eq_zero_of_not_pole_of_meromorphicAt
#print axioms riemannZeta0._proof_1
#print axioms riemannZeta0.eq_1
#print axioms riemannZeta0_apply
#print axioms riemannZeta0_zero_aux
#print axioms riemannZeta1.eq_1
#print axioms riemannZetaLogDerivResidue
#print axioms riemannZetaLogDerivResidueBigO
#print axioms riemannZetaResidue
#print axioms riemannZeta_isBigO_near_one_horizontal
#print axioms right_mem_rect
#print axioms segment_reProdIm_segment_eq_convexHull
#print axioms simplePole_sub_residue_isBigO_one
#print axioms smooth_urysohn_support_Ioo
#print axioms smoothedChebyshevIntegrand_conj
#print axioms sq_add_sq_ne_zero
#print axioms square_mem_nhds
#print axioms square_neg
#print axioms square_subset_square
#print axioms sumResiduesIn.eq_1
#print axioms sumResiduesIn_inter_eq_of_set_eq
#print axioms sum_eq_int_deriv
#print axioms sum_eq_integral_add_integral_deriv
#print axioms summable_complex_then_summable_real_part
#print axioms support_MellinConvolution
#print axioms support_MellinConvolution_subsets
#print axioms tendsto_const_mul_log_add_two_div_add_two_atTop
#print axioms tendsto_funscale
#print axioms tendsto_intervalIntegral_zero_of_uniform_norm_bound
#print axioms triv_bound_zeta
#print axioms trunc.h3
#print axioms trunc.h4
#print axioms trunc.le_one
#print axioms trunc.mk.inj
#print axioms trunc.mk.injEq
#print axioms trunc.mk.sizeOf_spec
#print axioms trunc.nonneg
#print axioms trunc.zero
#print axioms trunc.zero_at
#print axioms verticalIntegral_split_three
#print axioms verticalIntegral_split_three_finite
#print axioms verticalIntegral_split_three_finite'
#print axioms verticalPath_not_eventuallyConst
#print axioms vonMangoldtLSeriesSummable
#print axioms x_ε_to_inf
#print axioms xpos_of_uIcc

/- Layer 3: multiplicity-weighted finite zero sums and contour error bounds. -/
#print axioms HIntegral'.eq_1
#print axioms Legendre.Zeta.NontrivialZero.eq_1
#print axioms Legendre.Zeta.VIntegral'_eq_truncatedPerron
#print axioms Legendre.Zeta.exists_good_zero_height
#print axioms Legendre.Zeta.exists_perron_boundary_bound
#print axioms Legendre.Zeta.exists_symmetricZeroCutoff
#print axioms Legendre.Zeta.exists_truncated_explicit_formula
#print axioms Legendre.Zeta.halfWeightedPsi._proof_1
#print axioms Legendre.Zeta.halfWeightedPsi_explicit
#print axioms Legendre.Zeta.isCompact_rectangleBorder
#print axioms Legendre.Zeta.mem_perronRectangle
#print axioms Legendre.Zeta.ne_zero_of_mem_perronRectangle
#print axioms Legendre.Zeta.norm_perron_horizontal_le
#print axioms Legendre.Zeta.norm_perron_left_le
#print axioms Legendre.Zeta.norm_perron_normalization
#print axioms Legendre.Zeta.norm_truncatedExplicitError_le
#print axioms Legendre.Zeta.norm_truncatedExplicitError_le_boundary_bound
#print axioms Legendre.Zeta.one_mem_perronRectangle
#print axioms Legendre.Zeta.one_not_mem_perronRectangleBorder
#print axioms Legendre.Zeta.perronContourRemainder.eq_1
#print axioms Legendre.Zeta.perronIntegrand_analyticAt
#print axioms Legendre.Zeta.perronIntegrand_meromorphicAt
#print axioms Legendre.Zeta.perronIntegrand_order_at_zero
#print axioms Legendre.Zeta.perronIntegrand_order_one
#print axioms Legendre.Zeta.perronIntegrand_pole_iff
#print axioms Legendre.Zeta.perronIntegrand_simple_poles
#print axioms Legendre.Zeta.perronRectangle.eq_1
#print axioms Legendre.Zeta.perronRectangleBorder_nonvanishing
#print axioms Legendre.Zeta.perronRectangle_integral_eq
#print axioms Legendre.Zeta.perronRectangle_poles
#print axioms Legendre.Zeta.perronRectangle_zeros
#print axioms Legendre.Zeta.perronWeight_analyticAt
#print axioms Legendre.Zeta.perronWeight_ne_zero
#print axioms Legendre.Zeta.perron_horizontal_mem_boundary
#print axioms Legendre.Zeta.perron_left_mem_boundary
#print axioms Legendre.Zeta.perron_rectangleBorderIntegrable
#print axioms Legendre.Zeta.residue_perronIntegrand_at_zero
#print axioms Legendre.Zeta.residue_perronIntegrand_one
#print axioms Legendre.Zeta.sumResiduesIn_eq_sum
#print axioms Legendre.Zeta.symmetricZeros.eq_1
#print axioms Legendre.Zeta.symmetricZeros_finite
#print axioms Legendre.Zeta.tendsto_mul_logDeriv_of_analytic
#print axioms Legendre.Zeta.truncatedExplicitError.eq_1
#print axioms Legendre.Zeta.truncatedPerron_explicit
#print axioms Legendre.Zeta.truncatedZeroSum.eq_1
#print axioms Legendre.Zeta.zeroMultiplicity_pos_of_zero
#print axioms Legendre.Zeta.zeta_meromorphicOrder_eq_multiplicity
#print axioms VIntegral'.eq_1
#audit_private_axioms "_private.Legendre.PerronExplicit.0.Legendre.Zeta.VIntegral'_eq_truncatedPerron._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronExplicit.0.Legendre.Zeta.VIntegral'_eq_truncatedPerron._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronExplicit.0.Legendre.Zeta.VIntegral'_eq_truncatedPerron._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronExplicit.0.Legendre.Zeta.VIntegral'_eq_truncatedPerron._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronExplicit.0.Legendre.Zeta.VIntegral'_eq_truncatedPerron._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronExplicit.0.Legendre.Zeta.VIntegral'_eq_truncatedPerron._simp_1_7"
#audit_private_axioms "_private.Legendre.PerronExplicit.0.Legendre.Zeta.VIntegral'_eq_truncatedPerron._simp_1_8"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.norm_perron_left_le._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.norm_perron_left_le._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.norm_perron_left_le._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.norm_perron_left_le._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.norm_perron_left_le._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.norm_perron_left_le._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.norm_perron_left_le._simp_1_7"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.perron_horizontal_mem_boundary._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.perron_left_mem_boundary._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronExplicitBounds.0.Legendre.Zeta.perron_left_mem_boundary._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronRectangle.0.Legendre.Zeta.mem_perronRectangle._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronRectangle.0.Legendre.Zeta.mem_perronRectangle._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronRectangle.0.Legendre.Zeta.mem_perronRectangle._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronRectangle.0.Legendre.Zeta.one_not_mem_perronRectangleBorder._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronRectangle.0.Legendre.Zeta.perronRectangleBorder_nonvanishing._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronRectangle.0.Legendre.Zeta.perronRectangleBorder_nonvanishing._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronRectangle.0.Legendre.Zeta.perronRectangleBorder_nonvanishing._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronResidues.0.Legendre.Zeta.tendsto_mul_logDeriv_of_analytic._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronResidues.0.Legendre.Zeta.tendsto_mul_logDeriv_of_analytic._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronResidues.0.Legendre.Zeta.tendsto_mul_logDeriv_of_analytic._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronResidues.0.Legendre.Zeta.tendsto_mul_logDeriv_of_analytic._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronResidues.0.Legendre.Zeta.tendsto_mul_logDeriv_of_analytic._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronResidues.0.Legendre.Zeta.tendsto_mul_logDeriv_of_analytic._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronResidues.0.Legendre.Zeta.tendsto_mul_logDeriv_of_analytic._simp_1_7"
