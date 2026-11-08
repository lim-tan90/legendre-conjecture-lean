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
public import Legendre.ZetaUnitCounting
public import Legendre.FiniteHeightAvoidance
public import Legendre.ZetaGoodHeight
public import Legendre.ZetaLogDerivativeSeparated
public import Legendre.ZetaGoodHeightBounds
public import Legendre.PerronGoodHeight
public import Legendre.PrimeIntervals
public import Legendre.Layer3
public import Legendre.ZetaEulerPrimitive
public import Legendre.ZetaSecondMellin
public import Legendre.ZetaSecondEuler
public import Legendre.ZetaNegativeStrip
public import Legendre.ZetaWideLocalBound
public import Legendre.ZetaWideZeroRemoval
public import Legendre.ZetaWideRegularizedBound
public import Legendre.ZetaWideSeparated
public import Legendre.ZetaFullGoodHeightBounds
public import Legendre.ZetaPerronLeft
public import Legendre.PerronOriginResidue
public import Legendre.ZetaOriginValue
public import Legendre.PerronFullRectangle
public import Legendre.PerronUniformBounds
public import Legendre.PerronFullExplicit
public import Lean.Elab.Print

/- Import implementation declarations solely for exhaustive dependency auditing. -/
public import Legendre.ExponentialKernel
public import Legendre.ExponentialMeanValue
public import Legendre.DirichletSpacing
public import Legendre.DirichletMeanValue
public import Legendre.DirichletLargeValues
public import Legendre.ZeroDensity
public import Legendre.Layer4
public import Legendre.Tests.Layer4

public import Legendre.LargeSieve.AdditiveSieveProof
public import Legendre.LargeSieve.CircleSeparatedPoints
public import Legendre.LargeSieve.CosecantDistanceBound
public import Legendre.LargeSieve.CosecantHilbertBound
public import Legendre.LargeSieve.CosecantKernel
public import Legendre.LargeSieve.CosecantMatrix
public import Legendre.LargeSieve.CosecantRowSum
public import Legendre.LargeSieve.FiniteMatrixDuality
public import Legendre.LargeSieve.HermitianEigenvector
public import Legendre.LargeSieve.HermitianNormBound
public import Legendre.LargeSieve.KernelEigenvalueBound
public import Legendre.LargeSieve.PublishedAdditiveSieve
public import Legendre.LargeSieve.ReducedFractionSeparation
public import Legendre.LargeSieve.SeparatedAdditiveSieve
public import Legendre.LargeSieve.SeparatedInverseSquares
public import Legendre.LargeSieve.SeparatedSampling
public import Legendre.LargeSieve.SeparatedSetSquares
public import Legendre.LargeSieve.SieveDualEnergy
public import Legendre.LargeSieve.SieveGeometricKernel
public import Legendre.LargeSieve.SievePhaseGram
public import Legendre.LargeSieve.SkewKernelSquare
public import Legendre.LargeSieve.SymmetricQuadraticBound
public import Legendre.LargeSieve
public import Legendre.SobolevSampling
public import Legendre.DirichletDerivative
public import Legendre.DirichletSampling
public import Legendre.GramLargeValues
public import Legendre.HalaszMontgomery

public import Legendre.LargeSieve.SeparatedSelection
public import Legendre.WeightedSeparation
public import Legendre.ZetaDensitySelection
public import Legendre.ZeroDetectionReduction
public import Legendre.ReciprocalHilbert
public import Legendre.SeparatedMeanValue
public import Legendre.DirichletMeanValueSharp
public import Legendre.DirichletSamplingSharp
public import Legendre.ZeroDetectionSharp

import all Legendre.LargeSieve.SeparatedSelection
import all Legendre.WeightedSeparation
import all Legendre.ZetaDensitySelection
import all Legendre.ZeroDetectionReduction
import all Legendre.ReciprocalHilbert
import all Legendre.SeparatedMeanValue
import all Legendre.DirichletMeanValueSharp
import all Legendre.DirichletSamplingSharp
import all Legendre.ZeroDetectionSharp
public import Legendre.ZeroDetector.Mollifier
import all Legendre.ZeroDetector.Mollifier
public import Legendre.ZeroDetector.FiniteMollifier
import all Legendre.ZeroDetector.FiniteMollifier
public import Legendre.ZeroDetector.BetaVariation
import all Legendre.ZeroDetector.BetaVariation
public import Legendre.ZeroDetector.FrequencyLCM
import all Legendre.ZeroDetector.FrequencyLCM
public import Legendre.ZeroDetector.DivisorSquareMean
import all Legendre.ZeroDetector.DivisorSquareMean
public import Legendre.ZeroDetector.CoefficientEnergy
import all Legendre.ZeroDetector.CoefficientEnergy
public import Legendre.ZeroDetector.ActualZetaDetector
import all Legendre.ZeroDetector.ActualZetaDetector
public import Legendre.ZeroDetector.DetectorSamples
import all Legendre.ZeroDetector.DetectorSamples
public import Legendre.ZetaFiniteEuler
import all Legendre.ZetaFiniteEuler
public import Legendre.ComplexDirichlet
import all Legendre.ComplexDirichlet
public import Legendre.ComplexDirichletSampling
import all Legendre.ComplexDirichletSampling
public import Legendre.ZeroDetector.TailEnergy
import all Legendre.ZeroDetector.TailEnergy
public import Legendre.ZetaDetectedDensity
import all Legendre.ZetaDetectedDensity
public import Legendre.PNT.Mathlib.Analysis.SpecialFunctions.Gamma.DigammaSeries
import all Legendre.PNT.Mathlib.Analysis.SpecialFunctions.Gamma.DigammaSeries
public import Legendre.GammaBounds.LogNormDerivative
import all Legendre.GammaBounds.LogNormDerivative
public import Legendre.GammaBounds.DigammaTailEstimate
import all Legendre.GammaBounds.DigammaTailEstimate
public import Legendre.GammaBounds.SharpDigammaStrip
import all Legendre.GammaBounds.SharpDigammaStrip
public import Legendre.GammaBounds.GammaNormDerivative
import all Legendre.GammaBounds.GammaNormDerivative
public import Legendre.GammaBounds.SharpGammaHorizontal
import all Legendre.GammaBounds.SharpGammaHorizontal
public import Legendre.GammaBounds.SharpGammaVertical
import all Legendre.GammaBounds.SharpGammaVertical
public import Legendre.GammaBounds.SharpGammaRealShift
import all Legendre.GammaBounds.SharpGammaRealShift
public import Legendre.GammaBounds.GammaStripBound
import all Legendre.GammaBounds.GammaStripBound
public import Legendre.GammaBounds.GaussianWeight
import all Legendre.GammaBounds.GaussianWeight
public import Legendre.ZetaXi
import all Legendre.ZetaXi
public import Legendre.XiSquareKernel
import all Legendre.XiSquareKernel
public import Legendre.XiGaussianEnvelope
import all Legendre.XiGaussianEnvelope

import all Legendre.LargeSieve.AdditiveSieveProof
import all Legendre.LargeSieve.CircleSeparatedPoints
import all Legendre.LargeSieve.CosecantDistanceBound
import all Legendre.LargeSieve.CosecantHilbertBound
import all Legendre.LargeSieve.CosecantKernel
import all Legendre.LargeSieve.CosecantMatrix
import all Legendre.LargeSieve.CosecantRowSum
import all Legendre.LargeSieve.FiniteMatrixDuality
import all Legendre.LargeSieve.HermitianEigenvector
import all Legendre.LargeSieve.HermitianNormBound
import all Legendre.LargeSieve.KernelEigenvalueBound
import all Legendre.LargeSieve.PublishedAdditiveSieve
import all Legendre.LargeSieve.ReducedFractionSeparation
import all Legendre.LargeSieve.SeparatedAdditiveSieve
import all Legendre.LargeSieve.SeparatedInverseSquares
import all Legendre.LargeSieve.SeparatedSampling
import all Legendre.LargeSieve.SeparatedSetSquares
import all Legendre.LargeSieve.SieveDualEnergy
import all Legendre.LargeSieve.SieveGeometricKernel
import all Legendre.LargeSieve.SievePhaseGram
import all Legendre.LargeSieve.SkewKernelSquare
import all Legendre.LargeSieve.SymmetricQuadraticBound
import all Legendre.LargeSieve
import all Legendre.SobolevSampling
import all Legendre.DirichletDerivative
import all Legendre.DirichletSampling
import all Legendre.GramLargeValues
import all Legendre.HalaszMontgomery

import all Legendre.ExponentialKernel
import all Legendre.ExponentialMeanValue
import all Legendre.DirichletSpacing
import all Legendre.DirichletMeanValue
import all Legendre.DirichletLargeValues
import all Legendre.ZeroDensity
import all Legendre.Layer4
import all Legendre.Tests.Layer4

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
import all Legendre.ZetaUnitCounting
import all Legendre.FiniteHeightAvoidance
import all Legendre.ZetaGoodHeight
import all Legendre.ZetaLogDerivativeSeparated
import all Legendre.ZetaGoodHeightBounds
import all Legendre.PerronGoodHeight
import all Legendre.PrimeIntervals
import all Legendre.Layer3
import all Legendre.Tests.Layer3
import all Legendre.Basic
import all Legendre.Bertrand
import all Legendre.Conditional
import all Legendre.ExplicitBounds
import all Legendre.Layer5
import all Legendre.Nagura
import all Legendre.Nagura.FiniteCertificates
import all Legendre.Nagura.PsiBounds
import all Legendre.Nagura.Theorem
import all Legendre.PerronContour
import all Legendre.PerronError
import all Legendre.PerronFoundation
import all Legendre.PerronInversion
import all Legendre.PerronKernel
import all Legendre.PerronOscillation
import all Legendre.PerronResidue
import all Legendre.PerronSeries
import all Legendre.PerronShift
import all Legendre.PerronTail
import all Legendre.PerronTruncated
import all Legendre.PerronZero
import all Legendre.Reduction
import all Legendre.Zeta
import all Legendre.ZetaArgumentPrinciple
import all Legendre.ZetaCounting
import all Legendre.ZetaCountingCover
import all Legendre.ZetaCountingDisks
import all Legendre.ZetaGlobalCounting
import all Legendre.ZetaGrowth
import all Legendre.ZetaHalfPlane
import all Legendre.ZetaLocalBound
import all Legendre.ZetaLogDerivative
import all Legendre.ZetaLogDerivativeLocal
import all Legendre.ZetaPole
import all Legendre.ZetaPoleBounds
import all Legendre.ZetaPositivity
import all Legendre.ZetaReflection
import all Legendre.ZetaRegularizedBound
import all Legendre.ZetaZeroFree
import all Legendre.ZetaZeroRemoval

import all Legendre.ZetaEulerPrimitive
import all Legendre.ZetaSecondMellin
import all Legendre.ZetaSecondEuler
import all Legendre.ZetaNegativeStrip
import all Legendre.ZetaWideLocalBound
import all Legendre.ZetaWideZeroRemoval
import all Legendre.ZetaWideRegularizedBound
import all Legendre.ZetaWideSeparated
import all Legendre.ZetaFullGoodHeightBounds
import all Legendre.ZetaPerronLeft
import all Legendre.PerronOriginResidue
import all Legendre.ZetaOriginValue
import all Legendre.PerronFullRectangle
import all Legendre.PerronUniformBounds
import all Legendre.PerronFullExplicit


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

#print axioms Legendre.Nagura.exists_prime_nagura
#print axioms Legendre.Nagura.exists_prime_nagura_91639_to_16000000
#print axioms Legendre.Nagura.exists_prime_nagura_analytic_tail
#print axioms Legendre.Nagura.psi_nat_lt_1_086_mul
#print axioms Legendre.Nagura.psi_nat_gt_0_916_mul
#print axioms Legendre.Nagura.naguraGeneralUpperCombination_lt_1_0851_mul
#print axioms Legendre.Nagura.naguraGeneralLowerCombination_gt_0_916_mul

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

/- Quantitative good heights: all theorem declarations, including generated helpers. -/
#print axioms Legendre.Zeta.exists_good_height_logDeriv_bound
#print axioms Legendre.Zeta.exists_good_height_log_separation
#print axioms Legendre.Zeta.exists_good_height_perron_horizontal_bound
#print axioms Legendre.Zeta.exists_good_height_quantitative
#print axioms Legendre.Zeta.exists_height_avoiding_finset
#print axioms Legendre.Zeta.exists_truncated_explicit_formula_good_height
#print axioms Legendre.Zeta.goodHeightGap._proof_1
#print axioms Legendre.Zeta.goodHeightGap._proof_2
#print axioms Legendre.Zeta.goodHeightGap._proof_3
#print axioms Legendre.Zeta.goodHeightGap._proof_4
#print axioms Legendre.Zeta.goodHeightGap._proof_5
#print axioms Legendre.Zeta.goodHeightGap_bounds
#print axioms Legendre.Zeta.goodHeightGap_ge_inv_log
#print axioms Legendre.Zeta.goodHeightLogDerivativeConstant._proof_1
#print axioms Legendre.Zeta.goodHeightLogDerivativeConstant._proof_2
#print axioms Legendre.Zeta.goodHeightLogDerivativeConstant._proof_3
#print axioms Legendre.Zeta.goodHeightLogDerivativeConstant._proof_4
#print axioms Legendre.Zeta.goodHeightLogDerivativeConstant._proof_5
#print axioms Legendre.Zeta.goodHeightLogDerivativeConstant_pos
#print axioms Legendre.Zeta.goodHeightSeparationConstant._proof_1
#print axioms Legendre.Zeta.goodHeightSeparationConstant._proof_2
#print axioms Legendre.Zeta.goodHeightSeparationConstant_pos
#print axioms Legendre.Zeta.localZeta_log_le_at_good_height
#print axioms Legendre.Zeta.mem_nearbyZeroOrdinates
#print axioms Legendre.Zeta.nearbyHeightZeros._proof_1
#print axioms Legendre.Zeta.nearbyHeightZeros._proof_2
#print axioms Legendre.Zeta.nearbyZeroOrdinates_card_le_counts
#print axioms Legendre.Zeta.nearbyZeroOrdinates_card_le_log
#print axioms Legendre.Zeta.nontrivialZero_exists_positive_ordinate
#print axioms Legendre.Zeta.norm_localZetaPrincipalParts_le
#print axioms Legendre.Zeta.norm_logDeriv_le_at_good_height
#print axioms Legendre.Zeta.norm_logDeriv_le_local_separated
#print axioms Legendre.Zeta.norm_logDeriv_localZetaRegularized_le_wide
#print axioms Legendre.Zeta.norm_perron_horizontal_le_of_segment_bound
#print axioms Legendre.Zeta.perron_horizontal_intervalIntegrable
#print axioms Legendre.Zeta.rightHalfZero_mem_unit_cover
#print axioms Legendre.Zeta.unitCell_mem_counting_disk
#print axioms Legendre.Zeta.unitZeroCount.eq_1
#print axioms Legendre.Zeta.unitZeroCount_le_countingDegrees
#print axioms Legendre.Zeta.unitZeroCount_le_log
#print axioms Legendre.Zeta.unitZeros_card_le_count
#print axioms Legendre.Zeta.unitZeros_finite
#print axioms Legendre.Zeta.zeroCount_increment_le_unitZeroCount
#print axioms Legendre.Zeta.zero_distance_of_height_separation
#print axioms Legendre.Zeta.zeta_ne_zero_at_good_height
#print axioms Legendre.Zeta.zeta_ne_zero_of_local_separation
#audit_private_axioms "_private.Legendre.ZetaGoodHeight.0.Legendre.Zeta.nearbyZeroOrdinates_card_le_counts._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaLogDerivativeSeparated.0.Legendre.Zeta.norm_logDeriv_localZetaRegularized_le_wide._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaLogDerivativeSeparated.0.Legendre.Zeta.norm_logDeriv_localZetaRegularized_le_wide._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaLogDerivativeSeparated.0.Legendre.Zeta.norm_logDeriv_localZetaRegularized_le_wide._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaLogDerivativeSeparated.0.Legendre.Zeta.norm_logDeriv_localZetaRegularized_le_wide._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaUnitCounting.0.Legendre.Zeta.zeroCount_increment_le_unitZeroCount._proof_1_1"

/- Layer 3 completion: every theorem declaration in PrimeIntervals and Layer3. -/
#print axioms Legendre.PNT.classicalError_le_two_mul
#print axioms Legendre.PNT.classicalError_not_isBigO_rpow
#print axioms Legendre.PNT.classicalError_pos
#print axioms Legendre.PNT.eventually_hasPrimeIn_of_theta_classical_error
#print axioms Legendre.PNT.eventually_hasPrimeIn_relative
#print axioms Legendre.PNT.eventually_mul_classicalError_le
#print axioms Legendre.PNT.eventually_rpow_le_classicalError
#print axioms Legendre.PNT.hasPrimeIn_of_classical_theta_error
#print axioms Legendre.PNT.layer3_pnt_package
#print axioms Legendre.PNT.pnt_classical_error_with_prime_intervals
#print axioms Legendre.PNT.pnt_hasPrimeIn_classical_interval
#print axioms Legendre.PNT.pnt_prime_gap_classical
#print axioms Legendre.PNT.rpow_isLittleO_classicalError

/- Independently compiled Layer 3 consumer regression checks. -/
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.common_constant_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.finite_explicit_formula_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.natural_gap_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.near_one_power_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.one_percent_interval_consumer"

/- Exhaustive project-wide dependency coverage, including older generated/private lemmas. -/
#print axioms Legendre.BakerHarman._proof_1
#print axioms Legendre.BakerHarman._proof_2
#print axioms Legendre.BakerHarman.eq_1
#print axioms Legendre.BakerHarmanPaper._proof_1
#print axioms Legendre.BakerHarmanPaper._proof_2
#print axioms Legendre.BakerHarmanPaper.eq_1
#print axioms Legendre.BakerHarmanPintz._proof_1
#print axioms Legendre.BakerHarmanPintz.eq_1
#print axioms Legendre.BakerHarmanPintzPaper._proof_1
#print axioms Legendre.BakerHarmanPintzPaper.eq_1
#print axioms Legendre.HasPrimeIn.mono
#print axioms Legendre.HeathBrownIwaniec._proof_1
#print axioms Legendre.HeathBrownIwaniec._proof_2
#print axioms Legendre.HeathBrownIwaniec.eq_1
#print axioms Legendre.HeathBrownIwaniecPaper._proof_1
#print axioms Legendre.HeathBrownIwaniecPaper._proof_2
#print axioms Legendre.HeathBrownIwaniecPaper.eq_1
#print axioms Legendre.Hoheisel._proof_1
#print axioms Legendre.Hoheisel._proof_2
#print axioms Legendre.Hoheisel.eq_1
#print axioms Legendre.HoheiselPaper._proof_1
#print axioms Legendre.HoheiselPaper._proof_2
#print axioms Legendre.HoheiselPaper.eq_1
#print axioms Legendre.Huxley._proof_1
#print axioms Legendre.Huxley._proof_2
#print axioms Legendre.Huxley.eq_1
#print axioms Legendre.HuxleyPaper._proof_1
#print axioms Legendre.HuxleyPaper._proof_2
#print axioms Legendre.HuxleyPaper.eq_1
#print axioms Legendre.Ingham577._proof_1
#print axioms Legendre.Ingham577._proof_2
#print axioms Legendre.Ingham577.eq_1
#print axioms Legendre.Ingham577Paper._proof_1
#print axioms Legendre.Ingham577Paper._proof_2
#print axioms Legendre.Ingham577Paper.eq_1
#print axioms Legendre.Ingham58._proof_1
#print axioms Legendre.Ingham58._proof_2
#print axioms Legendre.Ingham58.eq_1
#print axioms Legendre.Ingham58Paper._proof_1
#print axioms Legendre.Ingham58Paper._proof_2
#print axioms Legendre.Ingham58Paper.eq_1
#print axioms Legendre.IwaniecPintz._proof_1
#print axioms Legendre.IwaniecPintz._proof_2
#print axioms Legendre.IwaniecPintz._proof_3
#print axioms Legendre.IwaniecPintz.eq_1
#print axioms Legendre.IwaniecPintzPaper._proof_1
#print axioms Legendre.IwaniecPintzPaper._proof_2
#print axioms Legendre.IwaniecPintzPaper._proof_3
#print axioms Legendre.IwaniecPintzPaper.eq_1
#print axioms Legendre.Mozzochi._proof_1
#print axioms Legendre.Mozzochi.eq_1
#print axioms Legendre.MozzochiPaper._proof_1
#print axioms Legendre.MozzochiPaper.eq_1
#print axioms Legendre.Nagura.consecutivePrime_ratio_of_naguraWitness
#print axioms Legendre.Nagura.consecutivePrimes_ratio_finite
#print axioms Legendre.Nagura.exists_prime_Ioc_of_theta_lt
#print axioms Legendre.Nagura.exists_prime_nagura_1046959_to_1482617
#print axioms Legendre.Nagura.exists_prime_nagura_1482617_to_16000000
#print axioms Legendre.Nagura.exists_prime_nagura_1482617_to_3538187
#print axioms Legendre.Nagura.exists_prime_nagura_218737_to_522059
#print axioms Legendre.Nagura.exists_prime_nagura_3538187_to_8443433
#print axioms Legendre.Nagura.exists_prime_nagura_522059_to_1046959
#print axioms Legendre.Nagura.exists_prime_nagura_8443433_to_16000000
#print axioms Legendre.Nagura.exists_prime_nagura_91639_to_218737
#print axioms Legendre.Nagura.exists_prime_nagura_below_91639
#print axioms Legendre.Nagura.exists_prime_nagura_finite
#print axioms Legendre.Nagura.exists_prime_nagura_medium
#print axioms Legendre.Nagura.exists_prime_nagura_to_1482617
#print axioms Legendre.Nagura.first_sub_1806_le_nagura_weighted_sum
#print axioms Legendre.Nagura.hasNaguraPrime_of_psi_gap
#print axioms Legendre.Nagura.log_factorial_le_integral_upper
#print axioms Legendre.Nagura.log_factorial_le_naguraFactorialLogUpper
#print axioms Legendre.Nagura.log_factorial_le_stirling_elementary
#print axioms Legendre.Nagura.log_five_gt_1_609
#print axioms Legendre.Nagura.log_forty_three_lt_3_762
#print axioms Legendre.Nagura.log_forty_three_lt_three_point_seven_seven
#print axioms Legendre.Nagura.log_lt_sqrt_div_two_hundred
#print axioms Legendre.Nagura.log_nat_lt_div_one_hundred_add_four
#print axioms Legendre.Nagura.log_nat_lt_div_ten_thousand_add_nine
#print axioms Legendre.Nagura.log_one_sub_le_neg_sum_add_remainder
#print axioms Legendre.Nagura.log_one_thousand_eight_hundred_six_lt_seven_point_five
#print axioms Legendre.Nagura.log_seven_lt_1_9465
#print axioms Legendre.Nagura.log_seven_lt_1_949
#print axioms Legendre.Nagura.log_seven_lt_one_point_nine_five
#print axioms Legendre.Nagura.log_shifted_div_lower
#print axioms Legendre.Nagura.log_thirty_lt_3_402
#print axioms Legendre.Nagura.log_three_gt_1_098
#print axioms Legendre.Nagura.log_three_lt_1_099
#print axioms Legendre.Nagura.log_three_lt_eleven_tenths
#print axioms Legendre.Nagura.naguraChebyshevCombination.eq_1
#print axioms Legendre.Nagura.naguraChebyshevCombination_le_stirlingMajorant
#print axioms Legendre.Nagura.naguraChebyshevCombination_lt_1_083_mul
#print axioms Legendre.Nagura.naguraChebyshevCombination_lt_1_085_mul
#print axioms Legendre.Nagura.naguraChebyshevCombination_lt_1_086_mul
#print axioms Legendre.Nagura.naguraChebyshevSum.eq_1
#print axioms Legendre.Nagura.naguraChebyshevSum_eq_log_factorial
#print axioms Legendre.Nagura.naguraChebyshevSum_eq_sum_log
#print axioms Legendre.Nagura.naguraChebyshevSum_eq_sum_range
#print axioms Legendre.Nagura.naguraChebyshevSum_le_integral_upper
#print axioms Legendre.Nagura.naguraChebyshevSum_le_stirling_elementary
#print axioms Legendre.Nagura.naguraDivisorLogSum_eq_log_factorial
#print axioms Legendre.Nagura.naguraDivisorLogSum_eq_sum_log
#print axioms Legendre.Nagura.naguraFactorialLogLower._proof_1
#print axioms Legendre.Nagura.naguraFactorialLogLower.eq_1
#print axioms Legendre.Nagura.naguraFactorialLogLower_le_log_factorial
#print axioms Legendre.Nagura.naguraFactorialLogUpper.eq_1
#print axioms Legendre.Nagura.naguraFactorialLogUpper_div_le_coarse
#print axioms Legendre.Nagura.naguraFactorialUpperDivCoarseModel.eq_1
#print axioms Legendre.Nagura.naguraFloorFactorialCoarseModel.eq_1
#print axioms Legendre.Nagura.naguraFloorFactorialCoarseModel_le
#print axioms Legendre.Nagura.naguraFloorFactorialLowerModel.eq_1
#print axioms Legendre.Nagura.naguraFloorFactorialLowerModel_le
#print axioms Legendre.Nagura.naguraGeneralLowerModel.eq_1
#print axioms Legendre.Nagura.naguraGeneralLowerModel_eq
#print axioms Legendre.Nagura.naguraGeneralLowerModel_le_combination
#print axioms Legendre.Nagura.naguraGeneralUpperCoarseModel.eq_1
#print axioms Legendre.Nagura.naguraGeneralUpperCoarseModel_eq
#print axioms Legendre.Nagura.naguraGeneralUpperCombination.eq_1
#print axioms Legendre.Nagura.naguraGeneralUpperCombination_le_model
#print axioms Legendre.Nagura.naguraGeneralUpperCombination_lt_1_083_mul
#print axioms Legendre.Nagura.naguraGeneralUpperModel_le_coarse
#print axioms Legendre.Nagura.naguraLowerChebyshevCombination.eq_1
#print axioms Legendre.Nagura.naguraLowerChebyshevCombination_gt_0_916_mul
#print axioms Legendre.Nagura.naguraLowerChebyshevCombination_le_psi
#print axioms Legendre.Nagura.naguraLowerMainCoefficient._proof_1
#print axioms Legendre.Nagura.naguraLowerMainCoefficient.eq_1
#print axioms Legendre.Nagura.naguraLowerMainCoefficient_gt_0_9209
#print axioms Legendre.Nagura.naguraLowerRoundingError._proof_1
#print axioms Legendre.Nagura.naguraLowerRoundingError.eq_1
#print axioms Legendre.Nagura.naguraLowerRoundingError_le_half
#print axioms Legendre.Nagura.naguraLowerStirlingMinorant.eq_1
#print axioms Legendre.Nagura.naguraLowerStirlingMinorant_eq_main_add_remainder
#print axioms Legendre.Nagura.naguraLowerStirlingMinorant_le_combination
#print axioms Legendre.Nagura.naguraLowerStirlingRemainder.eq_1
#print axioms Legendre.Nagura.naguraLowerWeight.eq_1
#print axioms Legendre.Nagura.naguraLowerWeightArithmetic._proof_1
#print axioms Legendre.Nagura.naguraLowerWeightArithmetic.eq_1
#print axioms Legendre.Nagura.naguraLowerWeightArithmetic_apply
#print axioms Legendre.Nagura.naguraLowerWeightPrefix_mem_unitInterval
#print axioms Legendre.Nagura.naguraMainCoefficient._proof_1
#print axioms Legendre.Nagura.naguraMainCoefficient._proof_2
#print axioms Legendre.Nagura.naguraMainCoefficient._proof_3
#print axioms Legendre.Nagura.naguraMainCoefficient._proof_4
#print axioms Legendre.Nagura.naguraMainCoefficient.eq_1
#print axioms Legendre.Nagura.naguraMainCoefficient_lt_1_0827
#print axioms Legendre.Nagura.naguraMainCoefficient_lt_1_083
#print axioms Legendre.Nagura.naguraMainCoefficient_lt_1_085
#print axioms Legendre.Nagura.naguraMainCoefficient_lt_1_086
#print axioms Legendre.Nagura.naguraStirlingMajorant.eq_1
#print axioms Legendre.Nagura.naguraStirlingMajorant_eq_main_add_remainder
#print axioms Legendre.Nagura.naguraStirlingRemainder._proof_1
#print axioms Legendre.Nagura.naguraStirlingRemainder.eq_1
#print axioms Legendre.Nagura.naguraStirlingRemainder_lt_zero
#print axioms Legendre.Nagura.naguraStrictUpper.eq_1
#print axioms Legendre.Nagura.naguraStrictUpper_spec
#print axioms Legendre.Nagura.naguraUpperRoundingError._proof_1
#print axioms Legendre.Nagura.naguraUpperRoundingError._proof_2
#print axioms Legendre.Nagura.naguraUpperRoundingError._proof_3
#print axioms Legendre.Nagura.naguraUpperRoundingError.eq_1
#print axioms Legendre.Nagura.naguraUpperRoundingError_le_two_point_five
#print axioms Legendre.Nagura.naguraWeight.eq_1
#print axioms Legendre.Nagura.naguraWeightPrefix_nonneg
#print axioms Legendre.Nagura.nagura_floor_coarse_algebra
#print axioms Legendre.Nagura.nagura_reciprocal_numerators
#print axioms Legendre.Nagura.neg_eleven_sub_two_log_lt_naguraLowerStirlingRemainder
#print axioms Legendre.Nagura.neg_sum_sub_remainder_le_log_one_sub
#print axioms Legendre.Nagura.one_le_naguraWeightPrefix
#print axioms Legendre.Nagura.psi_gt_0_916_mul_sub_27_48
#print axioms Legendre.Nagura.psi_lt_1_086_mul_add_1961_316
#print axioms Legendre.Nagura.psi_mul_1806_lt_1_086
#print axioms Legendre.Nagura.psi_mul_30_gt_0_916
#print axioms Legendre.Nagura.psi_sub_psi_div_1806_le_generalUpperCombination
#print axioms Legendre.Nagura.psi_sub_psi_le_naguraChebyshevCombination
#print axioms Legendre.Nagura.sum_Ioc_zero_eq_sum_range_succ
#print axioms Legendre.Nagura.sum_dvd_indicator_apply_eq
#print axioms Legendre.Nagura.sum_dvd_indicator_eq_div
#print axioms Legendre.Nagura.sum_dvd_indicator_psi_eq_chebyshevSum
#print axioms Legendre.Nagura.sum_lowerWeight_mul_psi_eq_sum_vonMangoldt_mul_prefix
#print axioms Legendre.Nagura.sum_naguraLowerWeight_eq_prefix
#print axioms Legendre.Nagura.sum_naguraLowerWeight_mul_psi_eq_combination
#print axioms Legendre.Nagura.sum_naguraWeight_eq_prefix
#print axioms Legendre.Nagura.sum_naguraWeight_mul_psi_eq
#print axioms Legendre.Nagura.sum_naguraWeight_mul_psi_eq_combination
#print axioms Legendre.Nagura.sum_range_mul_eq_partial_sum
#print axioms Legendre.Nagura.two_sqrt_mul_log_lt_div_one_hundred
#print axioms Legendre.ShortIntervalExponent.eq_1
#print axioms Legendre.Zeta.countingDegree.eq_1
#print axioms Legendre.Zeta.countingDivisor._proof_1
#print axioms Legendre.Zeta.countingDivisor._proof_2
#print axioms Legendre.Zeta.countingDivisor._proof_3
#print axioms Legendre.Zeta.countingDivisor.eq_1
#print axioms Legendre.Zeta.countingHeight._proof_1
#print axioms Legendre.Zeta.countingHeight._proof_2
#print axioms Legendre.Zeta.globalZeroCountConstant._proof_1
#print axioms Legendre.Zeta.globalZeroCountConstant._proof_2
#print axioms Legendre.Zeta.globalZeroCountConstant._proof_3
#print axioms Legendre.Zeta.globalZeroCountConstant._proof_4
#print axioms Legendre.Zeta.globalZeroCountConstant._proof_5
#print axioms Legendre.Zeta.localZetaDegree.eq_1
#print axioms Legendre.Zeta.localZetaDivisor._proof_1
#print axioms Legendre.Zeta.localZetaDivisor._proof_2
#print axioms Legendre.Zeta.localZetaDivisor._proof_3
#print axioms Legendre.Zeta.localZetaDivisor.eq_1
#print axioms Legendre.Zeta.localZetaFactor.eq_1
#print axioms Legendre.Zeta.localZetaLogBound._proof_1
#print axioms Legendre.Zeta.localZetaLogBound._proof_2
#print axioms Legendre.Zeta.localZetaLogBound._proof_3
#print axioms Legendre.Zeta.localZetaLogBound._proof_4
#print axioms Legendre.Zeta.localZetaRegularized._proof_1
#print axioms Legendre.Zeta.localZetaRegularized.eq_1
#print axioms Legendre.Zeta.lowCountingSet._proof_1
#print axioms Legendre.Zeta.perronErrorConstant.eq_1
#print axioms Legendre.Zeta.perronHorizontal.eq_1
#print axioms Legendre.Zeta.perronIntegrand.eq_1
#print axioms Legendre.Zeta.perronKernelBound._proof_1
#print axioms Legendre.Zeta.perronKernelBound.eq_1
#print axioms Legendre.Zeta.perronOscPrimitive.eq_1
#print axioms Legendre.Zeta.perronPoleNumerator.eq_1
#print axioms Legendre.Zeta.perronReciprocalDeriv.eq_1
#print axioms Legendre.Zeta.perronRegularizedWeight.eq_1
#print axioms Legendre.Zeta.perronScalarError._proof_1
#print axioms Legendre.Zeta.perronScalarError.eq_1
#print axioms Legendre.Zeta.perronSeriesTerm.eq_1
#print axioms Legendre.Zeta.perronWeight.eq_1
#print axioms Legendre.Zeta.poleRemovedZeta.eq_1
#print axioms Legendre.Zeta.rightHalfZero._proof_1
#print axioms Legendre.Zeta.scalarPerronValue._proof_1
#print axioms Legendre.Zeta.scalarPerronValue.eq_1
#print axioms Legendre.Zeta.truncatedPerron._proof_1
#print axioms Legendre.Zeta.truncatedPerron.eq_1
#print axioms Legendre.Zeta.truncatedPerronKernel._proof_1
#print axioms Legendre.Zeta.truncatedPerronKernel.eq_1
#print axioms Legendre.Zeta.zeroCount.eq_1
#print axioms Legendre.Zeta.zeroDensityCount.eq_1
#print axioms Legendre.Zeta.zeroMultiplicity.eq_1
#print axioms Legendre.Zeta.zerosRightOf.eq_1
#print axioms Legendre.Zeta.zerosUpTo.eq_1
#print axioms Legendre.Zeta.zetaFractionalPart.eq_1
#print axioms Legendre.Zeta.zetaMellinRemainder.eq_1
#print axioms Legendre.Zeta.zetaZeroFreeConstant._proof_1
#print axioms Legendre.Zeta.zetaZeroFreeCost._proof_1
#print axioms Legendre.Zeta.zetaZeroFreeCost._proof_2
#print axioms Legendre.Zeta.zetaZeroFreeCost._proof_3
#print axioms Legendre.Zeta.zetaZeroFreeK._proof_1
#print axioms Legendre.Zeta.zetaZeroFreeK._proof_2
#print axioms Legendre.almostPrimeSquareAtMost_one_iff
#print axioms Legendre.almostPrimeSquareAtMost_one_of_conjecture
#print axioms Legendre.bakerHarmanPaper_iff
#print axioms Legendre.bakerHarmanPintzPaper_iff
#print axioms Legendre.bakerHarmanPintz_above_half
#print axioms Legendre.bakerHarman_above_half
#print axioms Legendre.bertrand
#print axioms Legendre.bertrand_exponent_above_half
#print axioms Legendre.bertrand_gap_le
#print axioms Legendre.bhp_exponent_not_below_half
#print axioms Legendre.conjecture_of_almostPrimeSquareAtMost_one
#print axioms Legendre.eventually_const_mul_rpow_lt
#print axioms Legendre.eventually_legendre_of_gap_exponent_lt_half
#print axioms Legendre.exists_prime_of_theta_lt
#print axioms Legendre.hasPrimeInShortInterval_iff_primeGapBound
#print axioms Legendre.hasPrimeInShortInterval_mono
#print axioms Legendre.hasPrimeInShortInterval_of_primeGapBound
#print axioms Legendre.hasPrimeIn_iff
#print axioms Legendre.hasPrimeIn_of_theta_gap
#print axioms Legendre.hasPrimeIn_self
#print axioms Legendre.heathBrownIwaniecPaper_iff
#print axioms Legendre.heathBrownIwaniec_above_half
#print axioms Legendre.hoheiselPaper_iff
#print axioms Legendre.hoheisel_above_half
#print axioms Legendre.huxleyPaper_iff
#print axioms Legendre.huxley_above_half
#print axioms Legendre.ingham577Paper_iff
#print axioms Legendre.ingham577_above_half
#print axioms Legendre.ingham58Paper_iff
#print axioms Legendre.ingham58_above_half
#print axioms Legendre.iwaniecPintzPaper_iff
#print axioms Legendre.iwaniecPintz_above_half
#print axioms Legendre.legendreAt_iff_gapFormAt
#print axioms Legendre.legendreAt_one
#print axioms Legendre.legendreAt_two
#print axioms Legendre.legendre_eventually_of_shortIntervalExponentLimit_lt_half
#print axioms Legendre.legendre_eventually_of_shortIntervalExponent_lt_half
#print axioms Legendre.legendre_eventually_of_shortIntervalStatement_lt_half
#print axioms Legendre.legendre_of_gap_lt_two_sqrt
#print axioms Legendre.mozzochiPaper_iff
#print axioms Legendre.mozzochi_above_half
#print axioms Legendre.nagura_hasPrimeIn
#print axioms Legendre.nagura_hasPrimeIn_nat
#print axioms Legendre.nagura_prime_gap
#print axioms Legendre.pi_lower_explicit
#print axioms Legendre.pi_upper_explicit
#print axioms Legendre.primeGapBound_iff_eventuallyGapBound
#print axioms Legendre.primeGapBound_of_hasPrimeInShortInterval
#print axioms Legendre.prime_of_isAtMostAlmostPrime_one
#print axioms Legendre.psi_lower_explicit
#print axioms Legendre.psi_upper_explicit
#print axioms Legendre.shortIntervalExponentLimit_of_statement
#print axioms Legendre.shortIntervalStatement_iff_exponentLimit
#print axioms Legendre.shortIntervalStatement_mono
#print axioms Legendre.sq_interval_length
#print axioms Legendre.square_interval_shorter_than_linear_gap
#print axioms Legendre.statement_of_shortIntervalExponentLimit
#print axioms Legendre.theta_lower_explicit
#print axioms Legendre.theta_upper_explicit
#audit_private_axioms "_private.Legendre.Basic.0.Legendre.sq_interval_length._proof_1_1"
#audit_private_axioms "_private.Legendre.Conditional.0.Legendre.conjecture_of_almostPrimeSquareAtMost_one._proof_1_1"
#audit_private_axioms "_private.Legendre.Conditional.0.Legendre.prime_of_isAtMostAlmostPrime_one._proof_1_1"
#audit_private_axioms "_private.Legendre.ExplicitBounds.0.Legendre.exists_prime_of_theta_lt._simp_1_1"
#audit_private_axioms "_private.Legendre.ExplicitBounds.0.Legendre.exists_prime_of_theta_lt._simp_1_2"
#audit_private_axioms "_private.Legendre.ExplicitBounds.0.Legendre.hasPrimeIn_self._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer5.0.Legendre.bakerHarmanPaper_iff._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer5.0.Legendre.bakerHarmanPintzPaper_iff._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer5.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer5.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer5.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer5.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer5.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer5.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_6"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.consecutivePrime_ratio_of_naguraWitness._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.consecutivePrimes_ratio_finite._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.consecutivePrimes_ratio_finite._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.consecutivePrimes_ratio_finite._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.consecutivePrimes_ratio_finite._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1046959_to_1482617._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1046959_to_1482617._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1482617_to_16000000._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1482617_to_16000000._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1482617_to_3538187._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1482617_to_3538187._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1482617_to_3538187._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1482617_to_3538187._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_1482617_to_3538187._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_218737_to_522059._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_218737_to_522059._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_218737_to_522059._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_218737_to_522059._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_218737_to_522059._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_3538187_to_8443433._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_3538187_to_8443433._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_3538187_to_8443433._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_3538187_to_8443433._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_3538187_to_8443433._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_522059_to_1046959._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_522059_to_1046959._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_522059_to_1046959._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_522059_to_1046959._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_8443433_to_16000000._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_8443433_to_16000000._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_8443433_to_16000000._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_8443433_to_16000000._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_8443433_to_16000000._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_91639_to_16000000._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_91639_to_218737._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_91639_to_218737._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_91639_to_218737._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_91639_to_218737._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_91639_to_218737._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_below_91639._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_10"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_11"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_12"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_13"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_14"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_15"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_16"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_17"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_18"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_19"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_20"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_21"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_22"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_23"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_24"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_25"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_26"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_27"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_28"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_29"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_6"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_7"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_8"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_finite._proof_1_9"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_10"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_11"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_12"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_13"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_14"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_15"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_16"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_17"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_18"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_19"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_20"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_6"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_7"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_8"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_medium._proof_1_9"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_to_1482617._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_to_1482617._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.FiniteCertificates.0.Legendre.Nagura.exists_prime_nagura_to_1482617._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.first_sub_1806_le_nagura_weighted_sum._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.first_sub_1806_le_nagura_weighted_sum._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.first_sub_1806_le_nagura_weighted_sum._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.first_sub_1806_le_nagura_weighted_sum._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.log_factorial_le_integral_upper._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraChebyshevSum_eq_sum_log._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraChebyshevSum_eq_sum_log._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraChebyshevSum_eq_sum_log._simp_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraChebyshevSum_eq_sum_log._simp_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraDivisorLogSum_eq_log_factorial._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraFactorialLogUpper_div_le_coarse._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraFloorFactorialCoarseModel_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraFloorFactorialLowerModel_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerCombination_gt_0_916_mul._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_10"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_6"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_7"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_8"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralLowerModel_le_combination._proof_1_9"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_10"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_11"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_6"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_7"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_8"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_le_model._proof_1_9"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_lt_1_083_mul._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_lt_1_083_mul._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperCombination_lt_1_0851_mul._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperModel_le_coarse._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperModel_le_coarse._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperModel_le_coarse._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperModel_le_coarse._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraGeneralUpperModel_le_coarse._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraLowerChebyshevCombination_gt_0_916_mul._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraLowerStirlingMinorant_le_combination._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraLowerStirlingMinorant_le_combination._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraLowerStirlingMinorant_le_combination._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraLowerStirlingMinorant_le_combination._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraLowerWeightPrefix_mem_unitInterval._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.naguraWeightPrefix_nonneg._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.one_le_naguraWeightPrefix._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_gt_0_916_mul_sub_27_48._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_gt_0_916_mul_sub_27_48._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_gt_0_916_mul_sub_27_48._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_lt_1_086_mul_add_1961_316._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_lt_1_086_mul_add_1961_316._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_lt_1_086_mul_add_1961_316._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_nat_lt_1_086_mul._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_sub_psi_div_1806_le_generalUpperCombination._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_sub_psi_le_naguraChebyshevCombination._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_sub_psi_le_naguraChebyshevCombination._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.psi_sub_psi_le_naguraChebyshevCombination._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.sum_Ioc_zero_eq_sum_range_succ._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.sum_Ioc_zero_eq_sum_range_succ._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.sum_lowerWeight_mul_psi_eq_sum_vonMangoldt_mul_prefix._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.sum_naguraWeight_mul_psi_eq_combination._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.sum_naguraWeight_mul_psi_eq_combination._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.sum_naguraWeight_mul_psi_eq_combination._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.sum_naguraWeight_mul_psi_eq_combination._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.PsiBounds.0.Legendre.Nagura.sum_naguraWeight_mul_psi_eq_combination._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_Ioc_of_theta_lt._simp_1_1"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_Ioc_of_theta_lt._simp_1_2"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_nagura._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_nagura._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_nagura_analytic_tail._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_nagura_analytic_tail._proof_1_2"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_nagura_analytic_tail._proof_1_3"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_nagura_analytic_tail._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.exists_prime_nagura_analytic_tail._proof_1_5"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.hasNaguraPrime_of_psi_gap._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.naguraStrictUpper_spec._proof_1_1"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.naguraStrictUpper_spec._proof_1_4"
#audit_private_axioms "_private.Legendre.Nagura.Theorem.0.Legendre.Nagura.naguraStrictUpper_spec._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronContour.0.Legendre.Zeta.exists_perronIntegrand_circleIntegral._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronContour.0.Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronContour.0.Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronContour.0.Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronContour.0.Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronContour.0.Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronContour.0.Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronContour.0.Legendre.Zeta.perronIntegrand_eventuallyEq_poleNumerator._simp_1_7"
#audit_private_axioms "_private.Legendre.PerronError.0.Legendre.Zeta.perronScalarError_le_bound._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronError.0.Legendre.Zeta.perronScalarError_le_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronError.0.Legendre.Zeta.perronScalarError_le_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronError.0.Legendre.Zeta.perronScalarError_le_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronError.0.Legendre.Zeta.perronScalarError_le_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronError.0.Legendre.Zeta.perronScalarError_le_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.PerronError.0.Legendre.Zeta.perronScalarError_le_bound._simp_1_8"
#audit_private_axioms "_private.Legendre.PerronInversion.0.Legendre.Zeta.vonMangoldt_mul_scalarPerronValue_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronInversion.0.Legendre.Zeta.vonMangoldt_scalarPerronValue_tsum_eq_psi._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronInversion.0.Legendre.Zeta.vonMangoldt_scalarPerronValue_tsum_eq_psi._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronInversion.0.Legendre.Zeta.vonMangoldt_scalarPerronValue_tsum_eq_psi._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.tendsto_truncatedPerronKernel_one._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.tendsto_truncatedPerronKernel_one._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.tendsto_truncatedPerronKernel_one._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.tendsto_truncatedPerronKernel_one._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.tendsto_truncatedPerronKernel_one._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.tendsto_truncatedPerronKernel_one._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.tendsto_truncatedPerronKernel_one._simp_1_7"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.truncatedPerronKernel_one._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.truncatedPerronKernel_one._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.truncatedPerronKernel_one._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.truncatedPerronKernel_one._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.truncatedPerronKernel_one._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.truncatedPerronKernel_one._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronKernel.0.Legendre.Zeta.truncatedPerronKernel_one._simp_1_7"
#audit_private_axioms "_private.Legendre.PerronResidue.0.Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronResidue.0.Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronResidue.0.Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronResidue.0.Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronResidue.0.Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronResidue.0.Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronResidue.0.Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq._simp_1_7"
#audit_private_axioms "_private.Legendre.PerronResidue.0.Legendre.Zeta.truncatedPerronKernel_crossing_sub_eq._simp_1_8"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.perronWeight_rectangle._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal._simp_1_7"
#audit_private_axioms "_private.Legendre.PerronShift.0.Legendre.Zeta.truncatedPerronKernel_sub_eq_horizontal._simp_1_8"
#audit_private_axioms "_private.Legendre.PerronTail.0.Legendre.Zeta.perronOscPrimitive_hasDerivAt._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronTail.0.Legendre.Zeta.perronOscPrimitive_hasDerivAt._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronTail.0.Legendre.Zeta.perronOscPrimitive_hasDerivAt._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronTail.0.Legendre.Zeta.perronOscPrimitive_hasDerivAt._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronTail.0.Legendre.Zeta.perronOscPrimitive_hasDerivAt._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronTail.0.Legendre.Zeta.perronOscPrimitive_hasDerivAt._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronTail.0.Legendre.Zeta.perronOscPrimitive_hasDerivAt._simp_1_7"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.eventually_legendre_of_gap_exponent_lt_half._proof_1_1"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.eventually_legendre_of_gap_exponent_lt_half._proof_1_2"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.eventually_legendre_of_gap_exponent_lt_half._proof_1_3"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.eventually_legendre_of_gap_exponent_lt_half._proof_1_4"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.eventually_legendre_of_gap_exponent_lt_half._proof_1_5"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.eventually_legendre_of_gap_exponent_lt_half._proof_1_6"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.eventually_legendre_of_gap_exponent_lt_half._proof_1_7"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.legendre_of_gap_lt_two_sqrt._proof_1_1"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.legendre_of_gap_lt_two_sqrt._proof_1_2"
#audit_private_axioms "_private.Legendre.Reduction.0.Legendre.legendre_of_gap_lt_two_sqrt._proof_1_3"
#audit_private_axioms "_private.Legendre.ZetaArgumentPrinciple.0.Legendre.Zeta.localZetaDivisor_mem_ball._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaCounting.0.Legendre.Zeta.zeroCount_eq_zero_of_nonpos._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaCounting.0.Legendre.Zeta.zeroDensityCount_eq_zero_of_one_le._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaCountingCover.0.Legendre.Zeta.countingHeightIndex_lt._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaCountingDisks.0.Legendre.Zeta.counting_disk_coordinates._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaCountingDisks.0.Legendre.Zeta.norm_riemannZeta_counting_disk_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaGlobalCounting.0.Legendre.Zeta.sum_zeroMultiplicity_union_le._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaGlobalCounting.0.Legendre.Zeta.zeroCount_le_mul_log._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaGlobalCounting.0.Legendre.Zeta.zeroCount_le_mul_log._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaGlobalCounting.0.Legendre.Zeta.zeroCount_le_mul_log._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaGlobalCounting.0.Legendre.Zeta.zeroCount_le_mul_log._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaGlobalCounting.0.Legendre.Zeta.zeroCount_le_mul_log._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaGlobalCounting.0.Legendre.Zeta.zeroCount_le_mul_log._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaGlobalCounting.0.Legendre.Zeta.zeroCount_le_mul_log._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.poleRemovedZeta_eq_euler_sum._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.poleRemovedZeta_eq_euler_sum._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.poleRemovedZeta_eq_euler_sum._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.poleRemovedZeta_eq_euler_sum._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.poleRemovedZeta_eq_euler_sum._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.poleRemovedZeta_eq_euler_sum._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.poleRemovedZeta_eq_euler_sum._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.poleRemovedZeta_eq_euler_sum._simp_1_8"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.riemannZeta_eq_euler_sum._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.riemannZeta_eq_euler_sum._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.riemannZeta_eq_euler_sum._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.riemannZeta_eq_euler_sum._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.riemannZeta_eq_euler_sum._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.riemannZeta_eq_euler_sum._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaGrowth.0.Legendre.Zeta.riemannZeta_eq_euler_sum._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaHalfPlane.0.Legendre.Zeta.tsum_nat_rpow_neg_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaHalfPlane.0.Legendre.Zeta.tsum_nat_rpow_neg_le._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaHalfPlane.0.Legendre.Zeta.tsum_nat_rpow_neg_le._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaHalfPlane.0.Legendre.Zeta.tsum_nat_rpow_neg_le._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaHalfPlane.0.Legendre.Zeta.tsum_nat_rpow_neg_le._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaHalfPlane.0.Legendre.Zeta.tsum_nat_rpow_neg_le._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaHalfPlane.0.Legendre.Zeta.tsum_nat_rpow_neg_le._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaLocalBound.0.Legendre.Zeta.norm_riemannZeta_disk_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaLocalBound.0.Legendre.Zeta.zeta_disk_coordinates._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaLogDerivative.0.Legendre.Zeta.zeroDensityCount_eq_zero_of_zero_free._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaLogDerivativeLocal.0.Legendre.Zeta.neg_logDeriv_re_le_local_sub_zero._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaPole.0.Legendre.Zeta.poleRemovedZeta_continuousAt_one._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaPoleBounds.0.Legendre.Zeta.norm_deriv_poleRemovedZeta_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaPoleBounds.0.Legendre.Zeta.norm_deriv_zetaMellinRemainder_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_8"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.exists_localZetaLog._simp_1_9"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.norm_logDeriv_localZetaRegularized_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.norm_logDeriv_localZetaRegularized_le._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.norm_logDeriv_localZetaRegularized_le._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaRegularizedBound.0.Legendre.Zeta.norm_logDeriv_localZetaRegularized_le._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaZeroRemoval.0.Legendre.Zeta.norm_localZetaFactor_center_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaZeroRemoval.0.Legendre.Zeta.one_fourth_pow_le_norm_localZetaFactor._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaZeroRemoval.0.Legendre.Zeta.one_fourth_pow_le_norm_localZetaFactor._simp_1_2"

-- Full-strip uniform Perron refinement: all public, private and generated theorems.
#print axioms Legendre.Zeta.Gamma_analyticAt_one
#print axioms Legendre.Zeta.centeredEuler_integrable
#print axioms Legendre.Zeta.centeredEuler_integral
#print axioms Legendre.Zeta.continuous_logDeriv_perron_left
#print axioms Legendre.Zeta.continuous_perronIntegrand_left
#print axioms Legendre.Zeta.cos_functional_factor_ne_zero
#print axioms Legendre.Zeta.deriv_riemannZeta_origin
#print axioms Legendre.Zeta.eulerPrimitive_power_tendsto_zero
#print axioms Legendre.Zeta.euler_power_hasDerivAt
#print axioms Legendre.Zeta.exists_full_good_height_logDeriv_bound
#print axioms Legendre.Zeta.exists_full_truncated_explicit_formula
#print axioms Legendre.Zeta.exists_uniform_perron_left_bound
#print axioms Legendre.Zeta.exists_wideZetaLog
#print axioms Legendre.Zeta.exists_wideZetaLog_bounded
#print axioms Legendre.Zeta.fullGoodHeightLogDerivativeConstant._proof_1
#print axioms Legendre.Zeta.fullGoodHeightLogDerivativeConstant._proof_2
#print axioms Legendre.Zeta.fullGoodHeightLogDerivativeConstant._proof_3
#print axioms Legendre.Zeta.fullGoodHeightLogDerivativeConstant._proof_4
#print axioms Legendre.Zeta.fullGoodHeightLogDerivativeConstant._proof_5
#print axioms Legendre.Zeta.fullGoodHeightLogDerivativeConstant._proof_6
#print axioms Legendre.Zeta.fullGoodHeightLogDerivativeConstant_pos
#print axioms Legendre.Zeta.fullPerronCandidates_finite
#print axioms Legendre.Zeta.fullPerronCandidates_subset_rectangle
#print axioms Legendre.Zeta.fullPerronRectangle_integral_eq
#print axioms Legendre.Zeta.fullPerron_border_nonvanishing
#print axioms Legendre.Zeta.fullPerron_poles_inter_eq
#print axioms Legendre.Zeta.fullPerron_poles_subset
#print axioms Legendre.Zeta.fullPerron_zero_nontrivial
#print axioms Legendre.Zeta.halfWeightedPsi_full_explicit
#print axioms Legendre.Zeta.hasDerivAt_riemannZetaOne_one
#print axioms Legendre.Zeta.integral_one_div_one_add_abs
#print axioms Legendre.Zeta.logDeriv_riemannZeta_analyticAt_origin
#print axioms Legendre.Zeta.logDeriv_riemannZeta_eq_wide_regularized_add
#print axioms Legendre.Zeta.logDeriv_riemannZeta_origin
#print axioms Legendre.Zeta.norm_fullExplicitError_le_uniform
#print axioms Legendre.Zeta.norm_logDeriv_le_at_full_good_height
#print axioms Legendre.Zeta.norm_logDeriv_le_wide_separated
#print axioms Legendre.Zeta.norm_logDeriv_perron_left_high
#print axioms Legendre.Zeta.norm_logDeriv_wideZetaRegularized_le
#print axioms Legendre.Zeta.norm_perronIntegrand_left_le
#print axioms Legendre.Zeta.norm_perron_full_horizontal_le
#print axioms Legendre.Zeta.norm_perron_left_uniform
#print axioms Legendre.Zeta.norm_riemannZeta_le_second_euler
#print axioms Legendre.Zeta.norm_riemannZeta_wide_disk_le
#print axioms Legendre.Zeta.norm_wideZetaFactor_center_le
#print axioms Legendre.Zeta.norm_wideZetaPrincipalParts_le
#print axioms Legendre.Zeta.norm_wideZetaRegularized_disk_le
#print axioms Legendre.Zeta.norm_wideZetaRegularized_ratio_le
#print axioms Legendre.Zeta.norm_wideZetaRegularized_sphere_le
#print axioms Legendre.Zeta.norm_zetaCenteredFractionalPart_le
#print axioms Legendre.Zeta.norm_zetaEulerPrimitive_le
#print axioms Legendre.Zeta.norm_zetaSecondKernel_le
#print axioms Legendre.Zeta.norm_zetaSecondMellinRemainder_le
#print axioms Legendre.Zeta.one_fourth_pow_le_norm_wideZetaFactor
#print axioms Legendre.Zeta.perronIntegrand_hasSimplePolesOn_all
#print axioms Legendre.Zeta.perronIntegrand_meromorphicAt_all
#print axioms Legendre.Zeta.perronIntegrand_order_origin_ge
#print axioms Legendre.Zeta.perronLeftHighConstant._proof_1
#print axioms Legendre.Zeta.perronLeftHighConstant._proof_2
#print axioms Legendre.Zeta.perronLeftHighConstant._proof_3
#print axioms Legendre.Zeta.perronLeftHighConstant._proof_4
#print axioms Legendre.Zeta.perronLeftHighConstant._proof_5
#print axioms Legendre.Zeta.perronLeftHighConstant._proof_6
#print axioms Legendre.Zeta.perronLeftHighConstant.eq_1
#print axioms Legendre.Zeta.perronLeftHighConstant_pos
#print axioms Legendre.Zeta.perron_left_norm_geometry
#print axioms Legendre.Zeta.perron_left_zero_separation
#print axioms Legendre.Zeta.perron_origin_numerator_analyticAt
#print axioms Legendre.Zeta.poleRemovedZeta_eq_second_euler
#print axioms Legendre.Zeta.poleRemovedZeta_eq_second_euler_positive
#print axioms Legendre.Zeta.residue_perronIntegrand_origin
#print axioms Legendre.Zeta.riemannZeta_analyticOnNhd_wide_disk
#print axioms Legendre.Zeta.riemannZeta_eq_second_euler
#print axioms Legendre.Zeta.riemannZeta_ne_zero_negative_strip
#print axioms Legendre.Zeta.riemannZeta_ne_zero_origin
#print axioms Legendre.Zeta.riemannZeta_ne_zero_perron_left
#print axioms Legendre.Zeta.truncatedPerron_full_explicit
#print axioms Legendre.Zeta.wideZetaDegree.eq_1
#print axioms Legendre.Zeta.wideZetaDegree_cast
#print axioms Legendre.Zeta.wideZetaDegree_le
#print axioms Legendre.Zeta.wideZetaDivisor._proof_1
#print axioms Legendre.Zeta.wideZetaDivisor._proof_2
#print axioms Legendre.Zeta.wideZetaDivisor._proof_3
#print axioms Legendre.Zeta.wideZetaDivisor.eq_1
#print axioms Legendre.Zeta.wideZetaDivisor_eq_multiplicity
#print axioms Legendre.Zeta.wideZetaDivisor_eq_zero_of_ne_zero
#print axioms Legendre.Zeta.wideZetaDivisor_eq_zero_of_not_mem
#print axioms Legendre.Zeta.wideZetaDivisor_finite
#print axioms Legendre.Zeta.wideZetaDivisor_nonneg
#print axioms Legendre.Zeta.wideZetaDivisor_support_zero
#print axioms Legendre.Zeta.wideZetaFactor.eq_1
#print axioms Legendre.Zeta.wideZetaFactor_analyticAt
#print axioms Legendre.Zeta.wideZetaFactor_eq_prod
#print axioms Legendre.Zeta.wideZetaFactor_eq_prod_nat
#print axioms Legendre.Zeta.wideZetaFactor_logDeriv
#print axioms Legendre.Zeta.wideZetaFactor_ne_zero
#print axioms Legendre.Zeta.wideZetaFactor_order
#print axioms Legendre.Zeta.wideZetaLogBound._proof_1
#print axioms Legendre.Zeta.wideZetaLogBound._proof_2
#print axioms Legendre.Zeta.wideZetaLogBound._proof_3
#print axioms Legendre.Zeta.wideZetaLogBound._proof_4
#print axioms Legendre.Zeta.wideZetaLogBound_pos
#print axioms Legendre.Zeta.wideZetaLog_re_le
#print axioms Legendre.Zeta.wideZetaPrincipalPart_re_nonneg
#print axioms Legendre.Zeta.wideZetaQuotient_meromorphicOn
#print axioms Legendre.Zeta.wideZetaQuotient_order
#print axioms Legendre.Zeta.wideZetaRegularized._proof_1
#print axioms Legendre.Zeta.wideZetaRegularized.eq_1
#print axioms Legendre.Zeta.wideZetaRegularized_analyticOnNhd
#print axioms Legendre.Zeta.wideZetaRegularized_eq
#print axioms Legendre.Zeta.wideZetaRegularized_eventuallyEq
#print axioms Legendre.Zeta.wideZetaRegularized_ne_zero
#print axioms Legendre.Zeta.wideZetaRegularized_order
#print axioms Legendre.Zeta.wideZeta_log_le_at_good_height
#print axioms Legendre.Zeta.wideZeta_log_le_left
#print axioms Legendre.Zeta.wide_disk_zero_nontrivial
#print axioms Legendre.Zeta.wide_zeta_disk_coordinates
#print axioms Legendre.Zeta.wide_zeta_disk_ne_one
#print axioms Legendre.Zeta.zero_not_mem_fullPerron_border
#print axioms Legendre.Zeta.zetaCenteredFractionalPart._proof_1
#print axioms Legendre.Zeta.zetaCenteredFractionalPart.eq_1
#print axioms Legendre.Zeta.zetaCenteredFractionalPart_eq
#print axioms Legendre.Zeta.zetaCenteredFractionalPart_measurable
#print axioms Legendre.Zeta.zetaEulerPrimitive._proof_1
#print axioms Legendre.Zeta.zetaEulerPrimitive.eq_1
#print axioms Legendre.Zeta.zetaEulerPrimitive_continuous
#print axioms Legendre.Zeta.zetaEulerPrimitive_hasDerivWithinAt_right
#print axioms Legendre.Zeta.zetaEulerPrimitive_int
#print axioms Legendre.Zeta.zetaMellinRemainder_eq_second
#print axioms Legendre.Zeta.zetaOriginFunctionalFactor._proof_1
#print axioms Legendre.Zeta.zetaOriginFunctionalFactor_analyticAt
#print axioms Legendre.Zeta.zetaOriginFunctionalFactor_hasDerivAt
#print axioms Legendre.Zeta.zetaOrigin_functional_eventuallyEq
#print axioms Legendre.Zeta.zetaSecondEulerNumerator.eq_1
#print axioms Legendre.Zeta.zetaSecondEulerNumerator_differentiableAt
#print axioms Legendre.Zeta.zetaSecondKernel.eq_1
#print axioms Legendre.Zeta.zetaSecondKernel_isBigO_atTop
#print axioms Legendre.Zeta.zetaSecondKernel_isBigO_at_zero
#print axioms Legendre.Zeta.zetaSecondKernel_locallyIntegrable
#print axioms Legendre.Zeta.zetaSecondKernel_measurable
#print axioms Legendre.Zeta.zetaSecondMellinRemainder.eq_1
#print axioms Legendre.Zeta.zetaSecondMellinRemainder_convergent
#print axioms Legendre.Zeta.zetaSecondMellinRemainder_differentiableAt
#print axioms Legendre.Zeta.zetaSecondMellinRemainder_eq_integral
#print axioms Legendre.Zeta.zetaSecondMellinRemainder_integrable
#print axioms Legendre.Zeta.zetaSecondMellin_integrand_eq_indicator
#print axioms Legendre.Zeta.zeta_ne_zero_at_full_good_height
#print axioms Legendre.Zeta.zeta_ne_zero_of_wide_separation
#print axioms Legendre.Zeta.zeta_wide_divisor_sum_le
#audit_private_axioms "_private.Legendre.PerronFullRectangle.0.Legendre.Zeta.fullPerron_border_nonvanishing._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronFullRectangle.0.Legendre.Zeta.fullPerron_border_nonvanishing._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronFullRectangle.0.Legendre.Zeta.fullPerron_border_nonvanishing._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronFullRectangle.0.Legendre.Zeta.zero_not_mem_fullPerron_border._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronOriginResidue.0.Legendre.Zeta.residue_perronIntegrand_origin._simp_1_1"
#audit_private_axioms "_private.Legendre.PerronOriginResidue.0.Legendre.Zeta.residue_perronIntegrand_origin._simp_1_2"
#audit_private_axioms "_private.Legendre.PerronOriginResidue.0.Legendre.Zeta.residue_perronIntegrand_origin._simp_1_3"
#audit_private_axioms "_private.Legendre.PerronOriginResidue.0.Legendre.Zeta.residue_perronIntegrand_origin._simp_1_4"
#audit_private_axioms "_private.Legendre.PerronOriginResidue.0.Legendre.Zeta.residue_perronIntegrand_origin._simp_1_5"
#audit_private_axioms "_private.Legendre.PerronOriginResidue.0.Legendre.Zeta.residue_perronIntegrand_origin._simp_1_6"
#audit_private_axioms "_private.Legendre.PerronOriginResidue.0.Legendre.Zeta.residue_perronIntegrand_origin._simp_1_7"
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.evaluated_origin_residue_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.full_formula_shared_height_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.full_negative_horizontal_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer3.0.Legendre.Tests.small_x_left_integrability_consumer"
#audit_private_axioms "_private.Legendre.ZetaNegativeStrip.0.Legendre.Zeta.cos_functional_factor_ne_zero._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOriginFunctionalFactor_hasDerivAt._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOriginFunctionalFactor_hasDerivAt._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOriginFunctionalFactor_hasDerivAt._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOriginFunctionalFactor_hasDerivAt._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOriginFunctionalFactor_hasDerivAt._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOriginFunctionalFactor_hasDerivAt._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOriginFunctionalFactor_hasDerivAt._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOrigin_functional_eventuallyEq._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOrigin_functional_eventuallyEq._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOrigin_functional_eventuallyEq._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOrigin_functional_eventuallyEq._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOrigin_functional_eventuallyEq._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOrigin_functional_eventuallyEq._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaOriginValue.0.Legendre.Zeta.zetaOrigin_functional_eventuallyEq._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaPerronLeft.0.Legendre.Zeta.exists_uniform_perron_left_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaPerronLeft.0.Legendre.Zeta.exists_uniform_perron_left_bound._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaPerronLeft.0.Legendre.Zeta.exists_uniform_perron_left_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaPerronLeft.0.Legendre.Zeta.exists_uniform_perron_left_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaPerronLeft.0.Legendre.Zeta.exists_uniform_perron_left_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaPerronLeft.0.Legendre.Zeta.exists_uniform_perron_left_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaPerronLeft.0.Legendre.Zeta.exists_uniform_perron_left_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaWideLocalBound.0.Legendre.Zeta.norm_riemannZeta_wide_disk_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaWideLocalBound.0.Legendre.Zeta.wide_zeta_disk_coordinates._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_8"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.exists_wideZetaLog._simp_1_9"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.norm_logDeriv_wideZetaRegularized_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.norm_logDeriv_wideZetaRegularized_le._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.norm_logDeriv_wideZetaRegularized_le._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaWideRegularizedBound.0.Legendre.Zeta.norm_logDeriv_wideZetaRegularized_le._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaWideZeroRemoval.0.Legendre.Zeta.norm_wideZetaFactor_center_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaWideZeroRemoval.0.Legendre.Zeta.one_fourth_pow_le_norm_wideZetaFactor._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaWideZeroRemoval.0.Legendre.Zeta.one_fourth_pow_le_norm_wideZetaFactor._simp_1_2"

-- Layer 4: all public, private and generated theorem declarations.
#print axioms Legendre.Density.abs_integral_dirichletPolynomial_sub_diagonal_le
#print axioms Legendre.Density.abs_integral_dirichletPolynomial_sub_diagonal_le_log
#print axioms Legendre.Density.abs_integral_exponentialSum_sub_diagonal_le
#print axioms Legendre.Density.coefficientEnergy.eq_1
#print axioms Legendre.Density.coefficientEnergy_nonneg
#print axioms Legendre.Density.conj_realPhase
#print axioms Legendre.Density.continuous_dirichletPolynomial
#print axioms Legendre.Density.continuous_exponentialSum
#print axioms Legendre.Density.continuous_realPhase
#print axioms Legendre.Density.dirichletPolynomial_eq_sum
#print axioms Legendre.Density.dirichlet_frequencies_inj
#print axioms Legendre.Density.dirichlet_large_values_measure_le
#print axioms Legendre.Density.dirichlet_large_values_mul_measure_le
#print axioms Legendre.Density.dirichlet_meanValueError_le
#print axioms Legendre.Density.exponentialSum.eq_1
#print axioms Legendre.Density.exponentialSum_norm_sq
#print axioms Legendre.Density.harmonic_real_eq_sum
#print axioms Legendre.Density.integral_dirichletPolynomial_norm_sq_le
#print axioms Legendre.Density.integral_exponentialSum_diagonal
#print axioms Legendre.Density.integral_exponentialSum_norm_sq
#print axioms Legendre.Density.inv_abs_log_gap_le
#print axioms Legendre.Density.inv_log_gap_le
#print axioms Legendre.Density.log_gap_lower
#print axioms Legendre.Density.meanValueError._proof_1
#print axioms Legendre.Density.meanValueError_eq_sum
#print axioms Legendre.Density.meanValueError_le_energy
#print axioms Legendre.Density.norm_meanValueOffDiagonal_le
#print axioms Legendre.Density.norm_oscillatoryKernel_le
#print axioms Legendre.Density.norm_realPhase
#print axioms Legendre.Density.oscillatoryKernel.eq_1
#print axioms Legendre.Density.oscillatoryKernel_eq
#print axioms Legendre.Density.oscillatoryKernel_zero
#print axioms Legendre.Density.realPhase.eq_1
#print axioms Legendre.Density.realPhase_mul_conj
#print axioms Legendre.Density.realPhase_neg_log_eq_cpow
#print axioms Legendre.Density.sum_inv_abs_log_gaps_le
#print axioms Legendre.Density.sum_inv_abs_nat_gaps_le
#print axioms Legendre.Density.sum_inv_left_gaps_le
#print axioms Legendre.Density.sum_inv_right_gaps_le
#print axioms Legendre.Density.tendsto_dirichletPolynomial_mean_square
#print axioms Legendre.Density.tendsto_exponentialSum_mean_square
#print axioms Legendre.Zeta.HasZeroDensityEstimate._proof_1
#print axioms Legendre.Zeta.HasZeroDensityEstimate.mono
#print axioms Legendre.Zeta.exists_log_pow_le_rpow
#print axioms Legendre.Zeta.hasZeroDensityEstimate_of_log_bound
#print axioms Legendre.Zeta.zeroDensityCount_le_low_of_near_one
#print axioms Legendre.Zeta.zeroDensityCount_rational_near_one
#print axioms Legendre.Zeta.zero_height_lt_three_of_near_one
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.log_gap_lower._simp_1_1"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.log_gap_lower._simp_1_2"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.log_gap_lower._simp_1_3"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.log_gap_lower._simp_1_4"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.log_gap_lower._simp_1_5"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.log_gap_lower._simp_1_6"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.log_gap_lower._simp_1_7"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_abs_nat_gaps_le._proof_1_5"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_abs_nat_gaps_le._proof_1_6"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_abs_nat_gaps_le._simp_1_1"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_abs_nat_gaps_le._simp_1_2"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_abs_nat_gaps_le._simp_1_3"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_abs_nat_gaps_le._simp_1_4"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_left_gaps_le._proof_1_1"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_left_gaps_le._proof_1_2"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_left_gaps_le._proof_1_3"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_right_gaps_le._proof_1_1"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_right_gaps_le._proof_1_2"
#audit_private_axioms "_private.Legendre.DirichletSpacing.0.Legendre.Density.sum_inv_right_gaps_le._proof_1_3"
#audit_private_axioms "_private.Legendre.ExponentialKernel.0.Legendre.Density.conj_realPhase._simp_1_2"
#audit_private_axioms "_private.Legendre.ExponentialKernel.0.Legendre.Density.realPhase_mul_conj._simp_1_2"
#audit_private_axioms "_private.Legendre.ExponentialMeanValue.0.Legendre.Density.tendsto_exponentialSum_mean_square._simp_1_1"
#audit_private_axioms "_private.Legendre.ExponentialMeanValue.0.Legendre.Density.tendsto_exponentialSum_mean_square._simp_1_2"
#audit_private_axioms "_private.Legendre.ExponentialMeanValue.0.Legendre.Density.tendsto_exponentialSum_mean_square._simp_1_3"
#audit_private_axioms "_private.Legendre.ExponentialMeanValue.0.Legendre.Density.tendsto_exponentialSum_mean_square._simp_1_4"
#audit_private_axioms "_private.Legendre.ExponentialMeanValue.0.Legendre.Density.tendsto_exponentialSum_mean_square._simp_1_5"
#audit_private_axioms "_private.Legendre.ExponentialMeanValue.0.Legendre.Density.tendsto_exponentialSum_mean_square._simp_1_6"
#audit_private_axioms "_private.Legendre.ExponentialMeanValue.0.Legendre.Density.tendsto_exponentialSum_mean_square._simp_1_7"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.coefficientEnergy.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.dirichletPolynomial.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.exponentialSum.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.realPhase.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_coincident_frequency_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_density_weaken_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_empty_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_large_values_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_log_loss_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_mean_limit_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_near_one_count_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_singleton_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_two_term_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.harmonic.eq_1"

-- Additive large sieve, separated samples and multiplicity-preserving detection reduction.
#print axioms Legendre.Density.abs_norm_sq_derivative_le
#print axioms Legendre.Density.abs_sub_le_integral_abs_deriv
#print axioms Legendre.Density.complex_quadratic_le_norm_rows
#print axioms Legendre.Density.derivative_coefficientEnergy_le
#print axioms Legendre.Density.dirichletDerivativeCoefficients.eq_1
#print axioms Legendre.Density.dirichletPolynomial.eq_1
#print axioms Legendre.Density.dirichletPolynomial_hasDerivAt
#print axioms Legendre.Density.dirichletPolynomial_norm_sq_hasDerivAt
#print axioms Legendre.Density.dirichlet_large_sample_card_le
#print axioms Legendre.Density.dirichlet_large_sample_card_mul_le
#print axioms Legendre.Density.dirichlet_mean_coefficient_nonneg
#print axioms Legendre.Density.dirichlet_samples_le_gram_rows
#print axioms Legendre.Density.dirichlet_unit_at_zero
#print axioms Legendre.Density.exists_weighted_separated_representatives
#print axioms Legendre.Density.exponential_samples_le_gram_rows
#print axioms Legendre.Density.finite_gram_row_bound
#print axioms Legendre.Density.gram_norm_symmetric
#print axioms Legendre.Density.halasz_montgomery_card_le
#print axioms Legendre.Density.halasz_montgomery_energy
#print axioms Legendre.Density.halasz_montgomery_large_values
#print axioms Legendre.Density.length_mul_value_le_integral
#print axioms Legendre.Density.log_nat_nonneg
#print axioms Legendre.Density.norm_dirichletDerivativeCoefficients
#print axioms Legendre.Density.realPhase_hasDerivAt
#print axioms Legendre.Density.realPhase_time_difference
#print axioms Legendre.Density.sum_dirichletPolynomial_samples_le
#print axioms Legendre.Density.sum_nat_weight_biUnion_le
#print axioms Legendre.Density.sum_nat_weight_union_le
#print axioms Legendre.Density.weighted_neighbor_le
#print axioms Legendre.LargeSieve.additiveSieveSum.eq_1
#print axioms Legendre.LargeSieve.additive_large_sieve
#print axioms Legendre.LargeSieve.centeredCircleRemainder._proof_1
#print axioms Legendre.LargeSieve.centeredCircleRemainder_bounds
#print axioms Legendre.LargeSieve.circleSeparated_inverse_square_row
#print axioms Legendre.LargeSieve.circleSeparated_remainders
#print axioms Legendre.LargeSieve.circleSeparated_sine_ne_zero
#print axioms Legendre.LargeSieve.complex_diagonal_quadratic
#print axioms Legendre.LargeSieve.complex_self_quadratic
#print axioms Legendre.LargeSieve.cos_quartic_upper
#print axioms Legendre.LargeSieve.cosecantKernel.eq_1
#print axioms Legendre.LargeSieve.cosecantKernel_self
#print axioms Legendre.LargeSieve.cosecantKernel_skew
#print axioms Legendre.LargeSieve.cosecantKernel_triple
#print axioms Legendre.LargeSieve.cosecantMatrix.eq_1
#print axioms Legendre.LargeSieve.cosecantMatrix_hermitian
#print axioms Legendre.LargeSieve.cosecantMatrix_norm_bound
#print axioms Legendre.LargeSieve.cosecantRowWeight._proof_1
#print axioms Legendre.LargeSieve.cosecantRowWeight.eq_1
#print axioms Legendre.LargeSieve.cosecantRowWeight_abs
#print axioms Legendre.LargeSieve.cosecantRowWeight_bound
#print axioms Legendre.LargeSieve.cosecantRowWeight_eq
#print axioms Legendre.LargeSieve.cosecantRowWeight_shift
#print axioms Legendre.LargeSieve.cosecant_eigenvalue_bound
#print axioms Legendre.LargeSieve.cosecant_hilbert_bound
#print axioms Legendre.LargeSieve.cosecant_row_sum_bound
#print axioms Legendre.LargeSieve.cotangentKernel.eq_1
#print axioms Legendre.LargeSieve.cotangentKernel_self
#print axioms Legendre.LargeSieve.cotangentKernel_skew
#print axioms Legendre.LargeSieve.disjoint_sample_intervals
#print axioms Legendre.LargeSieve.endpoint_sample
#print axioms Legendre.LargeSieve.exists_separated_cover
#print axioms Legendre.LargeSieve.exists_separated_selection
#print axioms Legendre.LargeSieve.finite_complex_cauchy_schwarz
#print axioms Legendre.LargeSieve.finite_complex_norm_expansion
#print axioms Legendre.LargeSieve.finite_matrix_duality
#print axioms Legendre.LargeSieve.finite_positive_inverse_squares
#print axioms Legendre.LargeSieve.hermitian_eigenvector_commutator
#print axioms Legendre.LargeSieve.hermitian_eigenvector_left
#print axioms Legendre.LargeSieve.hermitian_norm_bound
#print axioms Legendre.LargeSieve.imaginaryKernelMatrix.eq_1
#print axioms Legendre.LargeSieve.imaginaryKernelMatrix_hermitian
#print axioms Legendre.LargeSieve.imaginaryKernelMatrix_square
#print axioms Legendre.LargeSieve.imaginaryKernelMatrix_square_entry
#print axioms Legendre.LargeSieve.kernel_eigenvalue_bound
#print axioms Legendre.LargeSieve.matrix_quadratic_norm_bound
#print axioms Legendre.LargeSieve.neighbor_card_le_two_local
#print axioms Legendre.LargeSieve.ordered_separated_inverse_squares
#print axioms Legendre.LargeSieve.ordered_separated_lower
#print axioms Legendre.LargeSieve.positive_set_inverse_squares
#print axioms Legendre.LargeSieve.publishedAdditiveLargeSieve
#print axioms Legendre.LargeSieve.realPhase_eq_sieveHalfPhase
#print axioms Legendre.LargeSieve.real_symmetric_quadratic_upper
#print axioms Legendre.LargeSieve.reducedFractionPoint_separated
#print axioms Legendre.LargeSieve.reducedFraction_sum
#print axioms Legendre.LargeSieve.reducedNumerators.eq_1
#print axioms Legendre.LargeSieve.reduced_fraction_circle_separation
#print axioms Legendre.LargeSieve.reduced_fraction_cross_injective
#print axioms Legendre.LargeSieve.separated_additive_sieve
#print axioms Legendre.LargeSieve.separated_realPhase_large_sieve
#print axioms Legendre.LargeSieve.separated_sampling
#print axioms Legendre.LargeSieve.separated_set_inverse_squares
#print axioms Legendre.LargeSieve.sieveAdditivePhase._proof_1
#print axioms Legendre.LargeSieve.sieveAdditivePhase_eq_half
#print axioms Legendre.LargeSieve.sieveHalfPhase.eq_1
#print axioms Legendre.LargeSieve.sieveHalfPhase_add
#print axioms Legendre.LargeSieve.sieveHalfPhase_difference
#print axioms Legendre.LargeSieve.sieveHalfPhase_norm
#print axioms Legendre.LargeSieve.sieveHalfPhase_sine
#print axioms Legendre.LargeSieve.sieveHalfPhase_star
#print axioms Legendre.LargeSieve.sieveHalfPhase_two_step
#print axioms Legendre.LargeSieve.sieveHalfPhase_zero
#print axioms Legendre.LargeSieve.sievePhaseMatrix._proof_1
#print axioms Legendre.LargeSieve.sievePhaseMatrix.eq_1
#print axioms Legendre.LargeSieve.sievePhaseMatrix_adjoint
#print axioms Legendre.LargeSieve.sieve_dual_energy_bound
#print axioms Legendre.LargeSieve.sieve_dual_energy_identity
#print axioms Legendre.LargeSieve.sieve_geometric_kernel
#print axioms Legendre.LargeSieve.sieve_geometric_kernel_mul
#print axioms Legendre.LargeSieve.sieve_pair_kernel
#print axioms Legendre.LargeSieve.sieve_phase_gram
#print axioms Legendre.LargeSieve.sine_cosecant_majorant
#print axioms Legendre.LargeSieve.skew_kernel_square_entry
#print axioms Legendre.LargeSieve.sum_local_integrals_le
#print axioms Legendre.LargeSieve.twistedCosecantSum.eq_1
#print axioms Legendre.LargeSieve.twisted_cosecant_bound
#print axioms Legendre.Zeta.densityLocalMassBound._proof_1
#print axioms Legendre.Zeta.densityLocalMassBound._proof_2
#print axioms Legendre.Zeta.densityLocalMassBound._proof_3
#print axioms Legendre.Zeta.densityLocalMassBound._proof_4
#print axioms Legendre.Zeta.densityLocalMassBound._proof_5
#print axioms Legendre.Zeta.densityLocalMassBound._proof_6
#print axioms Legendre.Zeta.densityLocalMassBound_le_log
#print axioms Legendre.Zeta.densitySelectionConstant._proof_1
#print axioms Legendre.Zeta.densitySelectionConstant_pos
#print axioms Legendre.Zeta.density_window_le_unit_count
#print axioms Legendre.Zeta.density_window_mass_le
#print axioms Legendre.Zeta.exists_density_separated_representatives
#print axioms Legendre.Zeta.zeroDensityCount_le_of_dirichlet_detector
#audit_private_axioms "_private.Legendre.GramLargeValues.0.Legendre.Density.complex_quadratic_le_norm_rows._simp_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.AdditiveSieveProof.0.Legendre.LargeSieve.publishedAdditiveLargeSieve._proof_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.AdditiveSieveProof.0.Legendre.LargeSieve.reducedFractionPoint_separated._proof_1_5"
#audit_private_axioms "_private.Legendre.LargeSieve.AdditiveSieveProof.0.Legendre.LargeSieve.reducedFractionPoint_separated._proof_1_6"
#audit_private_axioms "_private.Legendre.LargeSieve.AdditiveSieveProof.0.Legendre.LargeSieve.reducedFractionPoint_separated._simp_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.AdditiveSieveProof.0.Legendre.LargeSieve.reducedFractionPoint_separated._simp_1_3"
#audit_private_axioms "_private.Legendre.LargeSieve.AdditiveSieveProof.0.Legendre.LargeSieve.reducedFractionPoint_separated._simp_1_4"
#audit_private_axioms "_private.Legendre.LargeSieve.ReducedFractionSeparation.0.Legendre.LargeSieve.reduced_fraction_circle_separation._proof_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.ReducedFractionSeparation.0.Legendre.LargeSieve.reduced_fraction_circle_separation._simp_1_2"
#audit_private_axioms "_private.Legendre.LargeSieve.ReducedFractionSeparation.0.Legendre.LargeSieve.reduced_fraction_circle_separation._simp_1_3"
#audit_private_axioms "_private.Legendre.LargeSieve.ReducedFractionSeparation.0.Legendre.LargeSieve.reduced_fraction_circle_separation._simp_1_4"
#audit_private_axioms "_private.Legendre.LargeSieve.ReducedFractionSeparation.0.Legendre.LargeSieve.reduced_fraction_circle_separation._simp_1_5"
#audit_private_axioms "_private.Legendre.LargeSieve.ReducedFractionSeparation.0.Legendre.LargeSieve.reduced_fraction_circle_separation._simp_1_6"
#audit_private_axioms "_private.Legendre.LargeSieve.ReducedFractionSeparation.0.Legendre.LargeSieve.reduced_fraction_circle_separation._simp_1_7"
#audit_private_axioms "_private.Legendre.LargeSieve.ReducedFractionSeparation.0.Legendre.LargeSieve.reduced_fraction_circle_separation._simp_1_8"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedInverseSquares.0.Legendre.LargeSieve.ordered_separated_lower._proof_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedSampling.0.Legendre.LargeSieve.separated_sampling._simp_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedSampling.0.Legendre.LargeSieve.separated_sampling._simp_1_2"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedSampling.0.Legendre.LargeSieve.separated_sampling._simp_1_3"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedSampling.0.Legendre.LargeSieve.separated_sampling._simp_1_4"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedSampling.0.Legendre.LargeSieve.separated_sampling._simp_1_5"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedSampling.0.Legendre.LargeSieve.separated_sampling._simp_1_6"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedSampling.0.Legendre.LargeSieve.separated_sampling._simp_1_7"
#audit_private_axioms "_private.Legendre.LargeSieve.SeparatedSelection.0.Legendre.LargeSieve.exists_separated_cover._proof_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.SieveDualEnergy.0.Legendre.LargeSieve.sieve_dual_energy_identity._simp_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.SieveDualEnergy.0.Legendre.LargeSieve.sieve_dual_energy_identity._simp_1_2"
#audit_private_axioms "_private.Legendre.LargeSieve.SievePhaseGram.0.Legendre.LargeSieve.finite_complex_norm_expansion._simp_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.SkewKernelSquare.0.Legendre.LargeSieve.skew_kernel_square_entry._simp_1_1"
#audit_private_axioms "_private.Legendre.LargeSieve.SkewKernelSquare.0.Legendre.LargeSieve.skew_kernel_square_entry._simp_1_2"
#audit_private_axioms "_private.Legendre.LargeSieve.SymmetricQuadraticBound.0.Legendre.LargeSieve.real_symmetric_quadratic_upper._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.dirichletDerivativeCoefficients.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_additive_sieve_shift_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_constant_derivative_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_phase_normalization_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_touching_samples_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weighted_cluster_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weighted_cluster_consumer._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weighted_cluster_consumer._proof_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_zero_detector_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_zero_large_samples_consumer"
#audit_private_axioms "_private.Legendre.WeightedSeparation.0.Legendre.Density.sum_nat_weight_union_le._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaDensitySelection.0.Legendre.Zeta.densityLocalMassBound_le_log._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaDensitySelection.0.Legendre.Zeta.densityLocalMassBound_le_log._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaDensitySelection.0.Legendre.Zeta.densityLocalMassBound_le_log._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaDensitySelection.0.Legendre.Zeta.densityLocalMassBound_le_log._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaDensitySelection.0.Legendre.Zeta.densityLocalMassBound_le_log._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaDensitySelection.0.Legendre.Zeta.densityLocalMassBound_le_log._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaDensitySelection.0.Legendre.Zeta.densityLocalMassBound_le_log._simp_1_7"

-- Linear-error mean values and optimized sampling: all public/private/generated theorems.
#print axioms Legendre.Density.abs_integral_dirichletPolynomial_sub_diagonal_le_linear
#print axioms Legendre.Density.abs_integral_exponentialSum_sub_diagonal_le_separation
#print axioms Legendre.Density.abs_norm_sq_derivative_le_weighted
#print axioms Legendre.Density.dirichlet_frequencies_separated
#print axioms Legendre.Density.dirichlet_large_sample_card_le_linear_log
#print axioms Legendre.Density.hilbertPhaseSum.eq_1
#print axioms Legendre.Density.integral_dirichletPolynomial_norm_sq_le_linear
#print axioms Legendre.Density.integral_exponentialSum_hilbert_decomposition
#print axioms Legendre.Density.norm_hilbertPhaseSum_le
#print axioms Legendre.Density.sum_dirichletPolynomial_samples_le_linear_log
#print axioms Legendre.Density.sum_dirichletPolynomial_samples_le_linear_weighted
#print axioms Legendre.LargeSieve.lineSeparated_injective
#print axioms Legendre.LargeSieve.line_inverse_square_row
#print axioms Legendre.LargeSieve.reciprocalKernel.eq_1
#print axioms Legendre.LargeSieve.reciprocalKernel_self
#print axioms Legendre.LargeSieve.reciprocalKernel_skew
#print axioms Legendre.LargeSieve.reciprocalKernel_triple
#print axioms Legendre.LargeSieve.reciprocalMatrix.eq_1
#print axioms Legendre.LargeSieve.reciprocalMatrix_hermitian
#print axioms Legendre.LargeSieve.reciprocalMatrix_norm_bound
#print axioms Legendre.LargeSieve.reciprocal_eigenvalue_bound
#print axioms Legendre.LargeSieve.reciprocal_hilbert_bound
#print axioms Legendre.LargeSieve.reciprocal_row_budget
#print axioms Legendre.Zeta.zeroDensityCount_le_of_dirichlet_detector_linear_log
#audit_private_axioms "_private.Legendre.DirichletMeanValueSharp.0.Legendre.Density.dirichlet_frequencies_separated._proof_1_1"
#audit_private_axioms "_private.Legendre.SeparatedMeanValue.0.Legendre.Density.integral_exponentialSum_hilbert_decomposition._simp_1_1"
#audit_private_axioms "_private.Legendre.SeparatedMeanValue.0.Legendre.Density.integral_exponentialSum_hilbert_decomposition._simp_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_sharp_reversed_interval_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_sharp_touching_samples_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_sharp_zero_energy_detector_consumer"

-- Actual zeta detection and varying-real-part samples: all declarations.
#print axioms Legendre.Density.BetaVariation.abs_norm_sq_derivative_le
#print axioms Legendre.Density.BetaVariation.norm_sq_le_base_add_energy
#print axioms Legendre.Density.BetaVariation.point_le_base_add_variation
#print axioms Legendre.Density.BetaVariation.sum_norm_sq_varying_parameter_le
#print axioms Legendre.Density.BetaVariation.sum_norm_sq_varying_parameter_le_of_uniform
#print axioms Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisor_square_eq_double_sum
#print axioms Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisor_square_mean
#print axioms Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisor_square_sum_eq
#print axioms Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisors_eq_bounded_filter
#print axioms Legendre.Density.Detector.Arithmetic.DivisorSquareMean.sum_dvd_indicator
#print axioms Legendre.Density.Detector.Arithmetic.FrequencyLCM.gcdCoordinates.eq_1
#print axioms Legendre.Density.Detector.Arithmetic.FrequencyLCM.gcdCoordinates_injective
#print axioms Legendre.Density.Detector.Arithmetic.FrequencyLCM.lcm_gcdCoordinates
#print axioms Legendre.Density.Detector.Arithmetic.FrequencyLCM.reciprocal_lcm_sum_le
#print axioms Legendre.Density.Detector.Arithmetic.FrequencyLCM.reciprocal_lcm_sum_le_log
#print axioms Legendre.Density.Detector.LSeries_eq_finiteSeries_of_support
#print axioms Legendre.Density.Detector.LSeries_truncate_eq_finiteSeries
#print axioms Legendre.Density.Detector.actual_zero_compensated_product_le
#print axioms Legendre.Density.Detector.actual_zero_detector_alternative
#print axioms Legendre.Density.Detector.actual_zero_sample_card_le
#print axioms Legendre.Density.Detector.complexSampleCoefficient._proof_1
#print axioms Legendre.Density.Detector.complexSampleCoefficient.eq_1
#print axioms Legendre.Density.Detector.detectorPolynomial_eq_complexDirichlet
#print axioms Legendre.Density.Detector.detector_large_of_small_product
#print axioms Legendre.Density.Detector.dyadic_coefficient_energy_le
#print axioms Legendre.Density.Detector.finiteSeries_zeta_eq
#print axioms Legendre.Density.Detector.finite_mollifier_identity
#print axioms Legendre.Density.Detector.mollifierCoefficient.eq_1
#print axioms Legendre.Density.Detector.mollifierCoefficient_initial
#print axioms Legendre.Density.Detector.mollifierCoefficient_one
#print axioms Legendre.Density.Detector.mollifierCoefficient_support
#print axioms Legendre.Density.Detector.mollifierCoefficient_vanish
#print axioms Legendre.Density.Detector.mollifier_dyadic_energy_le
#print axioms Legendre.Density.Detector.mollifier_polynomial_split
#print axioms Legendre.Density.Detector.mollifier_product
#print axioms Legendre.Density.Detector.norm_detectorTailCoefficients_le
#print axioms Legendre.Density.Detector.norm_moebius_le_one
#print axioms Legendre.Density.Detector.norm_mollifierCoefficient_le
#print axioms Legendre.Density.Detector.norm_mollifier_finiteSeries_le
#print axioms Legendre.Density.Detector.norm_poleCompensation_le
#print axioms Legendre.Density.Detector.poleCompensation.eq_1
#print axioms Legendre.Density.Detector.truncate._proof_1
#print axioms Legendre.Density.Detector.truncate_apply
#print axioms Legendre.Density.Detector.truncated_summable
#print axioms Legendre.Density.Detector.zetaDetectorLength.eq_1
#print axioms Legendre.Density.Detector.zetaDetectorLength_ge
#print axioms Legendre.Density.Detector.zetaDetectorLength_rpow_le
#print axioms Legendre.Density.complexDirichletPolynomial_hasDerivAt_beta
#print axioms Legendre.Density.complexDirichletPolynomial_vertical
#print axioms Legendre.Density.complexDirichlet_large_sample_card_le
#print axioms Legendre.Density.continuous_complexDirichletPolynomial_beta
#print axioms Legendre.Density.logDerivativeCoefficients.eq_1
#print axioms Legendre.Density.logDerivative_vertical_energy_le
#print axioms Legendre.Density.norm_logDerivativeCoefficients_le
#print axioms Legendre.Density.norm_verticalCoefficients
#print axioms Legendre.Density.sum_complexDirichletPolynomial_samples_le
#print axioms Legendre.Density.verticalCoefficients.eq_1
#print axioms Legendre.Density.vertical_coefficientEnergy_mono
#print axioms Legendre.Zeta.finite_sum_cpow_euler
#print axioms Legendre.Zeta.norm_riemannZeta_sub_finite_euler_le
#print axioms Legendre.Zeta.norm_zetaCenteredFractionalPart_le_half
#print axioms Legendre.Zeta.norm_zetaEulerTail_le
#print axioms Legendre.Zeta.ofReal_B1_eq_zetaCenteredFractionalPart
#print axioms Legendre.Zeta.riemannZeta_eq_finite_euler
#print axioms Legendre.Zeta.zetaEulerTail_integrable
#audit_private_axioms "_private.Legendre.ComplexDirichlet.0.Legendre.Density.complexDirichletPolynomial_hasDerivAt_beta._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Detector.finiteSeries.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_actual_zero_detector_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_actual_zero_detector_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_euler_cutoff_one_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_mollifier_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_varying_real_parts_consumer"
#audit_private_axioms "_private.Legendre.ZeroDetector.ActualZetaDetector.0.Legendre.Density.Detector.zetaDetectorLength_ge._proof_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.CoefficientEnergy.0.Legendre.Density.Detector.dyadic_coefficient_energy_le._proof_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.DetectorSamples.0.Legendre.Density.Detector.actual_zero_sample_card_le._simp_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.DetectorSamples.0.Legendre.Density.Detector.actual_zero_sample_card_le._simp_1_3"
#audit_private_axioms "_private.Legendre.ZeroDetector.DetectorSamples.0.Legendre.Density.Detector.detectorPolynomial_eq_complexDirichlet._proof_1_4"
#audit_private_axioms "_private.Legendre.ZeroDetector.DetectorSamples.0.Legendre.Density.Detector.detectorPolynomial_eq_complexDirichlet._simp_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.DetectorSamples.0.Legendre.Density.Detector.detectorPolynomial_eq_complexDirichlet._simp_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.DetectorSamples.0.Legendre.Density.Detector.detectorPolynomial_eq_complexDirichlet._simp_1_3"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisor_square_sum_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisors_eq_bounded_filter._simp_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisors_eq_bounded_filter._simp_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.divisors_eq_bounded_filter._simp_1_3"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.sum_dvd_indicator._proof_1_5"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.sum_dvd_indicator._simp_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.sum_dvd_indicator._simp_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.sum_dvd_indicator._simp_1_3"
#audit_private_axioms "_private.Legendre.ZeroDetector.DivisorSquareMean.0.Legendre.Density.Detector.Arithmetic.DivisorSquareMean.sum_dvd_indicator._simp_1_4"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.LSeries_eq_finiteSeries_of_support._proof_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.LSeries_eq_finiteSeries_of_support._simp_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.finiteSeries_zeta_eq._proof_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.mollifier_polynomial_split._proof_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.mollifier_polynomial_split._proof_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.mollifier_polynomial_split._proof_1_3"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.mollifier_polynomial_split._proof_1_4"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.mollifier_polynomial_split._proof_1_6"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.mollifier_polynomial_split._proof_1_7"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.mollifier_polynomial_split._proof_1_8"
#audit_private_axioms "_private.Legendre.ZeroDetector.FiniteMollifier.0.Legendre.Density.Detector.mollifier_polynomial_split._simp_1_5"
#audit_private_axioms "_private.Legendre.ZeroDetector.FrequencyLCM.0.Legendre.Density.Detector.Arithmetic.FrequencyLCM.reciprocal_lcm_sum_le._simp_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.FrequencyLCM.0.Legendre.Density.Detector.Arithmetic.FrequencyLCM.reciprocal_lcm_sum_le._simp_1_3"
#audit_private_axioms "_private.Legendre.ZeroDetector.Mollifier.0.Legendre.Density.Detector.mollifierCoefficient_support._proof_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.Mollifier.0.Legendre.Density.Detector.mollifierCoefficient_vanish._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaFiniteEuler.0.Legendre.Zeta.finite_sum_cpow_euler._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaFiniteEuler.0.Legendre.Zeta.riemannZeta_eq_finite_euler._simp_1_1"

-- Tail density and moment kernel: all public/private/generated declarations.
#print axioms Complex.cauchySeq_logGammaSeq
#print axioms Complex.exp_logGammaSeq
#print axioms Complex.hasSum_digamma_of_re_pos
#print axioms Complex.hasSum_sub_succ_of_tendsto_zero
#print axioms Complex.inv_add_one_sub_inv_eq
#print axioms Complex.logGammaSeq.eq_1
#print axioms Complex.logGammaSeq_succ_sub
#print axioms Complex.norm_inv_add_one_sub_inv_le
#print axioms Complex.norm_inv_add_one_sub_inv_le'
#print axioms Complex.norm_natCast_add_one
#print axioms Complex.sum_inv_natCast_add_one
#print axioms Complex.sum_inv_natCast_add_one_real
#print axioms Complex.summable_one_div_natCast_add_one_sq
#print axioms Complex.tsum_one_div_natCast_add_add_one_sq_le
#print axioms Legendre.Density.Detector.actualDetectorSampleBound._proof_1
#print axioms Legendre.Density.Detector.actualDetectorSampleBound._proof_2
#print axioms Legendre.Density.Detector.actual_zero_sample_card_le_explicit
#print axioms Legendre.Density.Detector.complexSampleCoefficient_nonneg
#print axioms Legendre.Density.Detector.detectorTailEnergyBound._proof_1
#print axioms Legendre.Density.Detector.detector_tail_energy_eq
#print axioms Legendre.Density.Detector.detector_tail_energy_le
#print axioms Legendre.Density.Detector.dyadic_density_ratio_lt_one
#print axioms Legendre.Density.Detector.dyadic_geometric_energy_le
#print axioms Legendre.Density.Detector.dyadic_power_weight
#print axioms Legendre.Density.Detector.dyadic_tail_coefficient_energy_le
#print axioms Legendre.Density.Detector.high_tail_coefficient_energy_le
#print axioms Legendre.Density.Detector.mollifier_vertical_energy_le
#print axioms Legendre.Density.Detector.norm_verticalCoefficients_sq
#print axioms Legendre.Density.Detector.sum_dyadic_blocks
#print axioms Legendre.Density.GammaBounds.densityDigammaTerm.eq_1
#print axioms Legendre.Density.GammaBounds.density_digamma_hasSum
#print axioms Legendre.Density.GammaBounds.density_digamma_tail_bound
#print axioms Legendre.Density.GammaBounds.gammaGaussianConstant._proof_1
#print axioms Legendre.Density.GammaBounds.gammaGaussianConstant._proof_2
#print axioms Legendre.Density.GammaBounds.gammaGaussianConstant._proof_3
#print axioms Legendre.Density.GammaBounds.gammaGaussianConstant.eq_1
#print axioms Legendre.Density.GammaBounds.gammaReal_shift_quotient
#print axioms Legendre.Density.GammaBounds.gammaSquareGaussianWeight.eq_1
#print axioms Legendre.Density.GammaBounds.gammaSquareGaussianWeight_bound
#print axioms Legendre.Density.GammaBounds.gamma_differentiableAt_pos
#print axioms Legendre.Density.GammaBounds.gamma_log_norm_horizontal
#print axioms Legendre.Density.GammaBounds.gamma_log_norm_vertical
#print axioms Legendre.Density.GammaBounds.gamma_norm_le_real
#print axioms Legendre.Density.GammaBounds.gamma_positive_strip_bound
#print axioms Legendre.Density.GammaBounds.gaussian_linear_abs_bound
#print axioms Legendre.Density.GammaBounds.hasDerivAt_log_norm
#print axioms Legendre.Density.GammaBounds.sharp_digamma_strip
#print axioms Legendre.Density.GammaBounds.sharp_gammaReal_shift
#print axioms Legendre.Density.GammaBounds.sharp_gamma_horizontal_ordered
#print axioms Legendre.Density.GammaBounds.sharp_gamma_log_horizontal_ordered
#print axioms Legendre.Density.GammaBounds.sharp_gamma_log_vertical
#print axioms Legendre.Density.GammaBounds.sharp_gamma_log_vertical_ordered
#print axioms Legendre.Density.GammaBounds.sharp_gamma_quotient
#print axioms Legendre.Density.GammaBounds.sharp_gamma_vertical
#print axioms Legendre.Zeta.exists_density_subset_separated_representatives
#print axioms Legendre.Zeta.gammaReal_positive_strip_bound
#print axioms Legendre.Zeta.xiGaussianEnvelope_integrable
#print axioms Legendre.Zeta.xiGaussianEnvelope_nonneg
#print axioms Legendre.Zeta.xiGaussianEnvelope_tendsto
#print axioms Legendre.Zeta.xiSquareGaussian.eq_1
#print axioms Legendre.Zeta.xiSquareGaussian_analytic
#print axioms Legendre.Zeta.xiSquareGaussian_band_bound
#print axioms Legendre.Zeta.xiSquareGaussian_normalized
#print axioms Legendre.Zeta.xiSquareGaussian_reflection
#print axioms Legendre.Zeta.xiSquareKernelWeight.eq_1
#print axioms Legendre.Zeta.xiSquareKernelWeight_bound
#print axioms Legendre.Zeta.xiSquareNormalizer_ne_zero
#print axioms Legendre.Zeta.xi_polynomial_shift_ratio_le
#print axioms Legendre.Zeta.zeroDensityCount_le_actual_detector
#print axioms Legendre.Zeta.zeroDensityCount_le_of_high_sample_bound
#print axioms Legendre.Zeta.zetaXi.eq_1
#print axioms Legendre.Zeta.zetaXi_differentiable
#print axioms Legendre.Zeta.zetaXi_eq_completed
#print axioms Legendre.Zeta.zetaXi_eq_gamma_poleRemoved
#print axioms Legendre.Zeta.zetaXi_eq_gamma_zeta
#print axioms Legendre.Zeta.zetaXi_one
#print axioms Legendre.Zeta.zetaXi_one_sub
#print axioms Legendre.Zeta.zetaXi_strip_bound
#print axioms Legendre.Zeta.zetaXi_zero
#print axioms Legendre.Zeta.zetaXi_zero_iff
#audit_private_axioms "_private.Legendre.GammaBounds.SharpDigammaStrip.0.Legendre.Density.GammaBounds.sharp_digamma_strip._proof_1_1"
#audit_private_axioms "_private.Legendre.GammaBounds.SharpGammaVertical.0.Legendre.Density.GammaBounds.sharp_gamma_quotient._simp_1_1"
#audit_private_axioms "_private.Legendre.GammaBounds.SharpGammaVertical.0.Legendre.Density.GammaBounds.sharp_gamma_quotient._simp_1_2"
#audit_private_axioms "_private.Legendre.GammaBounds.SharpGammaVertical.0.Legendre.Density.GammaBounds.sharp_gamma_quotient._simp_1_3"
#audit_private_axioms "_private.Legendre.GammaBounds.SharpGammaVertical.0.Legendre.Density.GammaBounds.sharp_gamma_quotient._simp_1_4"
#audit_private_axioms "_private.Legendre.GammaBounds.SharpGammaVertical.0.Legendre.Density.GammaBounds.sharp_gamma_quotient._simp_1_5"
#audit_private_axioms "_private.Legendre.GammaBounds.SharpGammaVertical.0.Legendre.Density.GammaBounds.sharp_gamma_quotient._simp_1_6"
#audit_private_axioms "_private.Legendre.GammaBounds.SharpGammaVertical.0.Legendre.Density.GammaBounds.sharp_gamma_quotient._simp_1_7"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GammaBounds.gammaSquareGaussianWeight.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_actual_density_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_empty_mollifier_energy_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gamma_vertical_shift_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_low_height_retained_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_xi_kernel_zero_shift_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_xi_pole_values_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Zeta.xiSquareKernelWeight.eq_1"
#audit_private_axioms "_private.Legendre.XiSquareKernel.0.Legendre.Zeta.xiSquareGaussian_normalized._simp_1_2"
#audit_private_axioms "_private.Legendre.XiSquareKernel.0.Legendre.Zeta.xiSquareGaussian_normalized._simp_1_3"
#audit_private_axioms "_private.Legendre.XiSquareKernel.0.Legendre.Zeta.xiSquareGaussian_normalized._simp_1_4"
#audit_private_axioms "_private.Legendre.XiSquareKernel.0.Legendre.Zeta.xiSquareGaussian_normalized._simp_1_5"
#audit_private_axioms "_private.Legendre.XiSquareKernel.0.Legendre.Zeta.xiSquareGaussian_normalized._simp_1_6"
#audit_private_axioms "_private.Legendre.XiSquareKernel.0.Legendre.Zeta.xiSquareGaussian_normalized._simp_1_7"
#audit_private_axioms "_private.Legendre.XiSquareKernel.0.Legendre.Zeta.xiSquareGaussian_normalized._simp_1_8"
#audit_private_axioms "_private.Legendre.ZeroDetector.TailEnergy.0.Legendre.Density.Detector.detector_tail_energy_eq._proof_1_4"
#audit_private_axioms "_private.Legendre.ZeroDetector.TailEnergy.0.Legendre.Density.Detector.detector_tail_energy_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.TailEnergy.0.Legendre.Density.Detector.detector_tail_energy_eq._simp_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.TailEnergy.0.Legendre.Density.Detector.detector_tail_energy_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.ZeroDetector.TailEnergy.0.Legendre.Density.Detector.dyadic_tail_coefficient_energy_le._proof_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.TailEnergy.0.Legendre.Density.Detector.high_tail_coefficient_energy_le._proof_1_1"
#audit_private_axioms "_private.Legendre.ZeroDetector.TailEnergy.0.Legendre.Density.Detector.high_tail_coefficient_energy_le._proof_1_2"
#audit_private_axioms "_private.Legendre.ZeroDetector.TailEnergy.0.Legendre.Density.Detector.sum_dyadic_blocks._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaDetectedDensity.0.Legendre.Zeta.zeroDensityCount_le_actual_detector._proof_1_1"
#audit_private_axioms "_private.Legendre.ZetaDetectedDensity.0.Legendre.Zeta.zeroDensityCount_le_of_high_sample_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_eq_gamma_poleRemoved._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_eq_gamma_poleRemoved._simp_1_2"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_eq_gamma_poleRemoved._simp_1_3"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_eq_gamma_poleRemoved._simp_1_4"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_eq_gamma_poleRemoved._simp_1_5"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_eq_gamma_poleRemoved._simp_1_6"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_eq_gamma_poleRemoved._simp_1_7"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_eq_gamma_poleRemoved._simp_1_8"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_zero_iff._simp_1_1"
#audit_private_axioms "_private.Legendre.ZetaXi.0.Legendre.Zeta.zetaXi_zero_iff._simp_1_2"
