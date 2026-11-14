/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZeroDensity
public import Legendre.DirichletLargeValues
public import Legendre.LargeSieve
public import Legendre.SobolevSampling
public import Legendre.DirichletSampling
public import Legendre.GramLargeValues
public import Legendre.HalaszMontgomery
public import Legendre.ZeroDetectionReduction
public import Legendre.ReciprocalHilbert
public import Legendre.SeparatedMeanValue
public import Legendre.DirichletMeanValueSharp
public import Legendre.DirichletSamplingSharp
public import Legendre.ZeroDetectionSharp
public import Legendre.ZetaFiniteEuler
public import Legendre.ComplexDirichletSampling
public import Legendre.ZeroDetector.DetectorSamples
public import Legendre.ZeroDetector.TailEnergy
public import Legendre.ZetaDetectedDensity
public import Legendre.XiGaussianEnvelope
public import Legendre.XiSquareContour
public import Legendre.Layer4.ZetaFourthMoment
public import Legendre.Layer4.DetectorIntegral
public import Legendre.Layer4.DetectorKernelLeft
public import Legendre.Layer4.DetectorCriticalMass
public import Legendre.Layer4.IntegralAlternative
public import Legendre.Layer4.DetectorDyadicCover
public import Legendre.Layer4.DetectorPolynomial
public import Legendre.Layer4.FiniteBlockSquare
public import Legendre.Layer4.PolynomialBlockSampling
public import Legendre.Layer4.PolynomialBlockCost
public import Legendre.Layer4.PolynomialAlternative
public import Legendre.Layer4.DensityBalance
public import Legendre.Layer4.BalancedAlternatives
public import Legendre.Layer4.SeparatedShellDensity
public import Legendre.Layer4.NearCriticalDensity
public import Legendre.Layer4.DyadicHeightDensity
public import Legendre.Layer4.InghamMultiplicity
public import Legendre.Layer4.InghamDensity
public import Legendre.Layer4.Exponential.DiscreteFirstDerivative
public import Legendre.Layer4.Exponential.DiscreteSecondDerivative
public import Legendre.Layer4.Exponential.HalaszComplex
public import Legendre.Layer4.Exponential.HalaszEnergy
public import Legendre.Layer4.Exponential.HalaszKernel
public import Legendre.Layer4.Exponential.LogFirstDerivative
public import Legendre.Layer4.Exponential.LogKernel
public import Legendre.Layer4.Exponential.LogPhase
public import Legendre.Layer4.Exponential.MonotoneBlocks
public import Legendre.Layer4.Exponential.PhaseExtension
public import Legendre.Layer4.Exponential.SecondDerivativeBudget
public import Legendre.Layer4.Exponential.SecondDerivativeTest
public import Legendre.Layer4.Exponential.SecondDifference
public import Legendre.Layer4.Exponential.SeparatedIntervalCount
public import Legendre.Layer4.Exponential.SeparatedReciprocals

public import Legendre.Layer4.DistributionMomentCutoff
public import Legendre.Layer4.Exponential.BoundedCriticalBlocks
public import Legendre.Layer4.Exponential.CriticalBlockCount
public import Legendre.Layer4.Exponential.CriticalPolynomialCount
public import Legendre.Layer4.Exponential.CriticalPolynomialMoments
public import Legendre.Layer4.Exponential.CriticalPolynomialOptimizedMoment
public import Legendre.Layer4.Exponential.HalaszLargeValues
public import Legendre.Layer4.Exponential.HalaszPointwise
public import Legendre.Layer4.Exponential.HalaszScale
public import Legendre.Layer4.Exponential.HalaszSparseCount
public import Legendre.Layer4.Exponential.HalaszSubdivision
public import Legendre.Layer4.Exponential.HalaszTranslation
public import Legendre.Layer4.Exponential.HalaszTwoTermCount
public import Legendre.Layer4.Exponential.HeightSubdivision
public import Legendre.Layer4.FiniteDyadicMoment
public import Legendre.Layer4.FiniteSquareLayercake
public import Legendre.Layer4.HalaszCriticalMass
public import Legendre.Layer4.HalaszMollifierMoment

public import Legendre.Layer4.HalaszDivisorBlock
public import Legendre.Layer4.HalaszIntegralAlternative
public import Legendre.Layer4.HalaszPolynomialAlternative
public import Legendre.Layer4.HalaszUniformCosts
public import Legendre.Layer4.HuxleyBalance
public import Legendre.Layer4.HuxleyBalancedAlternatives
public import Legendre.Layer4.HuxleyDensity
public import Legendre.Layer4.IndividualCriticalFourth
public import Legendre.Layer4.TypeIIIntegralCount
public import Legendre.Layer4.SmallMollifierTypeII
public import Legendre.Layer4.Arithmetic.DivisorGrowthLocal
public import Legendre.Layer4.Arithmetic.DivisorGrowth
public import Legendre.Layer4.Arithmetic.PolynomialPowers
public import Legendre.Layer4.Arithmetic.BlockPolynomialPowers
public import Legendre.Layer4.HuxleyPowerSelection
public import Legendre.Layer4.HalaszScaledBlock
public import Legendre.Layer4.HalaszPoweredBlock
public import Legendre.Layer4.HuxleyPoweredLengths
public import Legendre.Layer4.HuxleyPoweredCount
public import Legendre.Layer4.HuxleyShortBlock
public import Legendre.Layer4.HuxleyShortTail
public import Legendre.Layer4.HuxleyCurvedShell
public import Legendre.Layer4.HuxleyCurvedDensity
public import Legendre.Layer4.Exponential.FourierSecondMoment
public import Legendre.Layer4.Exponential.VanDerCorput
public import Legendre.Layer4.Exponential.NaturalDifferencing
public import Legendre.Layer4.Exponential.LogShiftDerivatives
public import Legendre.Layer4.Exponential.LogShiftCorrelation
public import Legendre.Layer4.Exponential.LogShiftBudget
public import Legendre.Layer4.Exponential.LogDifferencing
public import Legendre.Layer4.Exponential.WeylBudget
public import Legendre.Layer4.Exponential.LogWeyl
public import Legendre.Layer4.Exponential.MonotoneWeights
public import Legendre.Layer4.Exponential.WeightedLogWeyl
public import Legendre.Layer4.Exponential.GeneralLogWeyl
public import Legendre.Layer4.LongDetectorTypeII
public import Legendre.Layer4.Arithmetic.PoweredBlockDecomposition
public import Legendre.Layer4.HuxleyHeightDensity
public import Legendre.Layer4.HuxleyParameters
public import Legendre.Layer4.HuxleyShellDensity

/-!
# Layer 4: actual zero detection, Ingham density and global Huxley density

The public interface exports sharp real-line Dirichlet mean square, separated
sampling with varying real parts, additive large sieve and Gram bounds.
An entire xi square gives a proved zeta fourth moment O(T log^6 T).
The compact Mobius detector has an exact critical-line contour shift with
its principal pole retained, and a proved high-zero dichotomy. Polynomial
and integral branch counts, balanced cutoffs, dyadic height covers and
multiplicity restoration prove Ingham's uniform curved density exponent
3(1-sigma)/(2-sigma)+epsilon for every epsilon>0 and T>=2.

Actual logarithmic-phase derivative tests give dyadic correlation cancellation
C(sqrt(abs(t))+U/abs(t)) for nonzero ordinates. Harmonic packing and Gram
duality prove unconditional Halasz energy with its R sqrt(T) term, including
independently varying real parts. Interval subdivision and window optimization
prove the unconditional two-term large-value count. Bounded critical-line
polynomials and actual Mobius values have the resulting improved second
moments, which enter the compact detector critical-mass fourth moment.
Improved actual polynomial and integral branch counts, a common parameter
balance and multiplicity restoration prove the global density exponent
(12/5)(1-sigma)+epsilon uniformly in sigma and for all T>=2.

The Layer 4 roadmap acceptance requirements are fulfilled. The stronger
curved Huxley benchmark, sharp fourth-moment log^4 and Guth--Maynard targets
remain explicitly open; they are not hypotheses of the global 12/5 proof.
The proved 1940 density theorem does not assert Ingham's 1937 prime-gap result.
-/
