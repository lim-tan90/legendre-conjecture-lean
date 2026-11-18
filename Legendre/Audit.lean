/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Literature
import all Legendre.Literature
import all Legendre.Literature.Statements
import all Legendre.Literature.Comparators
import all Legendre.Literature.LayerCoverage
public import Legendre.Tests.Literature
import all Legendre.Tests.Literature
public import Legendre.Tests.LiteratureRegression
import all Legendre.Tests.LiteratureRegression

public import Legendre.Conditional
public import Legendre.Bertrand
public import Legendre.ExplicitBounds
public import Legendre.Layer5
import all Legendre.Layer5.Statements
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
public import Legendre.XiSquareContour
import all Legendre.XiSquareContour

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
import all Legendre.Layer4.CubicIntegrability
import all Legendre.Layer4.DyadicHeightShells
import all Legendre.Layer4.HeightWeight
import all Legendre.Layer4.IntegralAlternative
import all Legendre.Layer4.KernelHeightPacking
import all Legendre.Layer4.KernelPacking
import all Legendre.Layer4.MomentDyadic
import all Legendre.Layer4.PackedCriticalMass
import all Legendre.Layer4.PackedMoment
import all Legendre.Layer4.PackedZetaMoment
import all Legendre.Layer4.ProductCauchy
import all Legendre.Layer4.WeightedHeightMoment
import all Legendre.Layer4.WeightedZetaMoment
import all Legendre.Layer4.DetectorAlternative
import all Legendre.Layer4.DetectorAnalytic
import all Legendre.Layer4.DetectorCriticalMass
import all Legendre.Layer4.DetectorGrowth
import all Legendre.Layer4.DetectorHorizontal
import all Legendre.Layer4.DetectorPoleBound
import all Legendre.Layer4.DetectorRectangle
import all Legendre.Layer4.DetectorShift
import all Legendre.Layer4.DetectorVertical
import all Legendre.Layer4.DetectorCoefficients
import all Legendre.Layer4.DetectorIntegral
import all Legendre.Layer4.DetectorKernel
import all Legendre.Layer4.DetectorKernelLeft
import all Legendre.Layer4.DetectorProduct
import all Legendre.Layer4.DetectorSeries
import all Legendre.Layer4.DetectorWeight
import all Legendre.Layer4.BlockCauchy
import all Legendre.Layer4.BlockWeights
import all Legendre.Layer4.DivisorEnergy
import all Legendre.Layer4.DyadicArithmetic
import all Legendre.Layer4.DyadicPartition
import all Legendre.Layer4.GaussianContourShift
import all Legendre.Layer4.GaussianMean
import all Legendre.Layer4.MomentCutoff
import all Legendre.Layer4.MomentGaussian
import all Legendre.Layer4.PositiveLimit
import all Legendre.Layer4.WeightedIntegral
import all Legendre.Layer4.XiDyadicMean
import all Legendre.Layer4.XiFiniteContinuity
import all Legendre.Layer4.XiFiniteMean
import all Legendre.Layer4.XiFiniteMellin
import all Legendre.Layer4.XiHeadMean
import all Legendre.Layer4.XiMellinKernel
import all Legendre.Layer4.XiPartialMean
import all Legendre.Layer4.XiSmoothedMean
import all Legendre.Layer4.XiSquareLimit
import all Legendre.Layer4.XiSquareSeries
import all Legendre.Layer4.XiTailAssembly
import all Legendre.Layer4.XiTailMean
import all Legendre.Layer4.ZetaFourthMoment
import all Legendre.Layer4.GaussianMellinPole
import all Legendre.Layer4.XiSmallGammaShift
import all Legendre.Layer4.XiMellinRemainder
import all Legendre.Layer4.XiSharpHeadMean
import all Legendre.Layer4.ZetaFourthMomentSharp
import all Legendre.Layer4.ZetaSquareSeries
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

import all Legendre.Layer4.DetectorDyadicCover
import all Legendre.Layer4.DetectorPolynomial
import all Legendre.Layer4.FiniteBlockSquare
import all Legendre.Layer4.PolynomialBlockSampling
import all Legendre.Layer4.PolynomialBlockCost
import all Legendre.Layer4.PolynomialAlternative
import all Legendre.Layer4.DyadicVariableSampling
import all Legendre.Layer4.DensityBalance
import all Legendre.Layer4.BalancedAlternatives
import all Legendre.Layer4.SeparatedShellDensity
import all Legendre.Layer4.NearCriticalDensity
import all Legendre.Layer4.DyadicHeightDensity
import all Legendre.Layer4.InghamMultiplicity
import all Legendre.Layer4.InghamDensity
import all Legendre.Layer4.DistributionMomentCutoff
import all Legendre.Layer4.Exponential.BoundedCriticalBlocks
import all Legendre.Layer4.Exponential.CriticalBlockCount
import all Legendre.Layer4.Exponential.CriticalPolynomialCount
import all Legendre.Layer4.Exponential.CriticalPolynomialMoments
import all Legendre.Layer4.Exponential.CriticalPolynomialOptimizedMoment
import all Legendre.Layer4.Exponential.HalaszLargeValues
import all Legendre.Layer4.Exponential.HalaszPointwise
import all Legendre.Layer4.Exponential.HalaszScale
import all Legendre.Layer4.Exponential.HalaszSparseCount
import all Legendre.Layer4.Exponential.HalaszSubdivision
import all Legendre.Layer4.Exponential.HalaszTranslation
import all Legendre.Layer4.Exponential.HalaszTwoTermCount
import all Legendre.Layer4.Exponential.HeightSubdivision
import all Legendre.Layer4.FiniteDyadicMoment
import all Legendre.Layer4.FiniteSquareLayercake
import all Legendre.Layer4.HalaszDivisorBlock
import all Legendre.Layer4.HalaszIntegralAlternative
import all Legendre.Layer4.HalaszPolynomialAlternative
import all Legendre.Layer4.HalaszUniformCosts
import all Legendre.Layer4.HuxleyBalance
import all Legendre.Layer4.HuxleyBalancedAlternatives
import all Legendre.Layer4.HuxleyDensity
import all Legendre.Layer4.IndividualCriticalFourth
import all Legendre.Layer4.TypeIIIntegralCount
import all Legendre.Layer4.SmallMollifierTypeII
import all Legendre.Layer4.Arithmetic.DivisorGrowthLocal
import all Legendre.Layer4.Arithmetic.DivisorGrowth
import all Legendre.Layer4.Arithmetic.PolynomialPowers
import all Legendre.Layer4.Arithmetic.BlockPolynomialPowers
import all Legendre.Layer4.HuxleyPowerSelection
import all Legendre.Layer4.HalaszScaledBlock
import all Legendre.Layer4.HalaszPoweredBlock
import all Legendre.Layer4.HuxleyPoweredLengths
import all Legendre.Layer4.HuxleyPoweredCount
import all Legendre.Layer4.HuxleyShortBlock
import all Legendre.Layer4.HuxleyShortTail
import all Legendre.Layer4.HuxleyCurvedShell
import all Legendre.Layer4.HuxleyCurvedDensity
import all Legendre.Layer4.Exponential.FourierSecondMoment
import all Legendre.Layer4.Exponential.VanDerCorput
import all Legendre.Layer4.Exponential.NaturalDifferencing
import all Legendre.Layer4.Exponential.LogShiftDerivatives
import all Legendre.Layer4.Exponential.LogShiftCorrelation
import all Legendre.Layer4.Exponential.LogShiftBudget
import all Legendre.Layer4.Exponential.LogDifferencing
import all Legendre.Layer4.Exponential.WeylBudget
import all Legendre.Layer4.Exponential.LogWeyl
import all Legendre.Layer4.Exponential.MonotoneWeights
import all Legendre.Layer4.Exponential.WeightedLogWeyl
import all Legendre.Layer4.Exponential.GeneralLogWeyl
import all Legendre.Layer4.LongDetectorTypeII
import all Legendre.Layer4.Exponential.WeightedLogBlocks
import all Legendre.Layer4.DetectorMonotoneWeight
import all Legendre.Layer4.DetectorDivisorBlocks
import all Legendre.Layer4.DetectorDividedPrefixes
import all Legendre.Layer4.DetectorMobiusPointwise
import all Legendre.Layer4.UpperHuxleyParameters
import all Legendre.Layer4.HuxleyWindowBlockEpsilon
import all Legendre.Layer4.UpperHuxleyShortBlocks
import all Legendre.Layer4.UpperHuxleyPowerBounds
import all Legendre.Layer4.UpperHuxleyCosts
import all Legendre.Layer4.UpperHuxleyLongBlocks
import all Legendre.Layer4.UpperHuxleyLongExclusion
import all Legendre.Layer4.UpperHuxleyTail
import all Legendre.Layer4.UpperHuxleyShell
import all Legendre.Layer4.HuxleyFullShell
import all Legendre.Layer4.HuxleyFullDensity
import all Legendre.Layer4.GuthMaynardOuterRange
import all Legendre.Layer4.GuthMaynard.Polynomial
import all Legendre.Layer4.GuthMaynard.Definitions
import all Legendre.Layer4.GuthMaynard.SamplingMatrix
import all Legendre.Layer4.GuthMaynard.TraceDispersion
import all Legendre.Layer4.GuthMaynard.SamplingDispersion
import all Legendre.Layer4.GuthMaynard.TracePoisson
import all Legendre.Layer4.GuthMaynard.TraceReflection
import all Legendre.Layer4.GuthMaynard.Separation
import all Legendre.Layer4.GuthMaynard.CubicTrace
import all Legendre.Layer4.GuthMaynard.CubicRemainder
import all Legendre.Layer4.GuthMaynard.PowerTail
import all Legendre.Layer4.GuthMaynard.QuantitativeReflection
import all Legendre.Layer4.GuthMaynard.CubicTwoTail
import all Legendre.Layer4.GuthMaynard.FinitePowers
import all Legendre.Layer4.GuthMaynard.SamplingMeanSquare
import all Legendre.Layer4.GuthMaynard.Localization
import all Legendre.Layer4.GuthMaynard.HeathBrown
import all Legendre.Layer4.GuthMaynard.LogarithmicPrefix
import all Legendre.Layer4.GuthMaynard.HeathBrownReflection
import all Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate
import all Legendre.Layer4.GuthMaynard.CubicThreeTailSupport
import all Legendre.Layer4.GuthMaynard.CubicThreeTail
import all Legendre.Layer4.GuthMaynard.EnergyTolerance
import all Legendre.Layer4.GuthMaynard.AffineLanguage
import all Legendre.Layer4.GuthMaynard.AffineTransform
import all Legendre.Layer4.GuthMaynard.AffineIteration
import all Legendre.Layer4.GuthMaynard.AffineHeight
import all Legendre.Layer4.GuthMaynard.CubicThreeTailRefined
import all Legendre.Layer4.GuthMaynard.EnergyDecomposition
import all Legendre.Layer4.GuthMaynard.EnergyFinal
import all Legendre.Layer4.GuthMaynard.ClassicalAdapter
import all Legendre.Layer4.GuthMaynard.SmoothAssembly
import all Legendre.Layer4.GuthMaynard.LargeValueAssembly
import all Legendre.Layer4.GuthMaynard.PublishedLargeValues
import all Legendre.Layer4.GuthMaynard.Section13Exponent
import all Legendre.Layer4.GuthMaynard.Section13Powering
import all Legendre.Layer4.GuthMaynard.FixedLineLocalization
import all Legendre.Layer4.GuthMaynard.ShiftedSamples
import all Legendre.Layer4.GuthMaynard.ActualTypeI
import all Legendre.Layer4.GuthMaynard.CentralShell
import all Legendre.Layer4.GuthMaynard.CentralDensity
import all Legendre.Layer4.Arithmetic.PoweredBlockDecomposition
import all Legendre.Layer4.HuxleyHeightDensity
import all Legendre.Layer4.HuxleyParameters
import all Legendre.Layer4.HuxleyShellDensity
import all Legendre.Layer4.HalaszCriticalMass
import all Legendre.Layer4.HalaszMollifierMoment
import all Legendre.Layer4.Exponential.DiscreteFirstDerivative
import all Legendre.Layer4.Exponential.DiscreteSecondDerivative
import all Legendre.Layer4.Exponential.HalaszComplex
import all Legendre.Layer4.Exponential.HalaszEnergy
import all Legendre.Layer4.Exponential.HalaszKernel
import all Legendre.Layer4.Exponential.LogFirstDerivative
import all Legendre.Layer4.Exponential.LogKernel
import all Legendre.Layer4.Exponential.LogPhase
import all Legendre.Layer4.Exponential.MonotoneBlocks
import all Legendre.Layer4.Exponential.PhaseExtension
import all Legendre.Layer4.Exponential.SecondDerivativeBudget
import all Legendre.Layer4.Exponential.SecondDerivativeTest
import all Legendre.Layer4.Exponential.SecondDifference
import all Legendre.Layer4.Exponential.SeparatedIntervalCount
import all Legendre.Layer4.Exponential.SeparatedReciprocals

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
#print axioms Legendre.IwaniecPintz.eq_1
#print axioms Legendre.IwaniecPintzPaper._proof_1
#print axioms Legendre.IwaniecPintzPaper._proof_2
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
#audit_private_axioms "_private.Legendre.Layer5.Statements.0.Legendre.bakerHarmanPaper_iff._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer5.Statements.0.Legendre.bakerHarmanPintzPaper_iff._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer5.Statements.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer5.Statements.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer5.Statements.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer5.Statements.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer5.Statements.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer5.Statements.0.Legendre.hasPrimeInShortInterval_of_primeGapBound._proof_1_6"
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

-- Entire xi-square contour and independent consumer declarations.
#print axioms Legendre.Zeta.riemannZeta_fourth_le_smoothed
#print axioms Legendre.Zeta.xiGaussianEnvelope.eq_1
#print axioms Legendre.Zeta.xiRectangleIntegral.eq_1
#print axioms Legendre.Zeta.xiSquareContour.eq_1
#print axioms Legendre.Zeta.xiSquareContour_bound
#print axioms Legendre.Zeta.xiSquareContour_conj
#print axioms Legendre.Zeta.xiSquareContour_horizontal_bound
#print axioms Legendre.Zeta.xiSquareContour_horizontal_tendsto
#print axioms Legendre.Zeta.xiSquareContour_left_reflection
#print axioms Legendre.Zeta.xiSquareContour_limit
#print axioms Legendre.Zeta.xiSquareContour_vertical_integrable
#print axioms Legendre.Zeta.xiSquareGaussian_conj
#print axioms Legendre.Zeta.xiSquareGaussian_rectangle
#print axioms Legendre.Zeta.xiSquareIntegral._proof_1
#print axioms Legendre.Zeta.xiSquareIntegral_conj
#print axioms Legendre.Zeta.zetaXi_conj
#print axioms Legendre.Zeta.zetaXi_square_equation
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_xi_conjugation_endpoints_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_xi_real_center_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_xi_rectangle_pole_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_zeta_fourth_reduction_consumer"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.riemannZeta_fourth_le_smoothed._simp_1_1"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.xiSquareGaussian_conj._simp_1_1"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.xiSquareGaussian_rectangle._simp_1_1"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.xiSquareGaussian_rectangle._simp_1_2"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.xiSquareGaussian_rectangle._simp_1_3"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.xiSquareGaussian_rectangle._simp_1_4"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.xiSquareGaussian_rectangle._simp_1_5"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.xiSquareGaussian_rectangle._simp_1_6"
#audit_private_axioms "_private.Legendre.XiSquareContour.0.Legendre.Zeta.xiSquareGaussian_rectangle._simp_1_7"

-- Independent literature comparisons, coverage and semantic regression guards.
#print axioms Legendre.HasPrimeIn.eq_1
#print axioms Legendre.HasPrimeInShortInterval.eq_1
#print axioms Legendre.LegendreAt.eq_1
#print axioms Legendre.Literature.BakerHarman1996Progress._proof_1
#print axioms Legendre.Literature.BakerHarman1996Progress._proof_2
#print axioms Legendre.Literature.BakerHarmanPintz2001._proof_1
#print axioms Legendre.Literature.ForwardProgress.eq_1
#print axioms Legendre.Literature.GuthMaynard2024Density._proof_1
#print axioms Legendre.Literature.HeathBrownIwaniec1979Progress._proof_1
#print axioms Legendre.Literature.HeathBrownIwaniec1979Progress._proof_2
#print axioms Legendre.Literature.Hoheisel1930Progress._proof_1
#print axioms Legendre.Literature.Hoheisel1930Progress._proof_2
#print axioms Legendre.Literature.Huxley1972Progress._proof_1
#print axioms Legendre.Literature.Huxley1972Progress._proof_2
#print axioms Legendre.Literature.Ingham1937DensityProgress._proof_1
#print axioms Legendre.Literature.Ingham1937DensityProgress._proof_2
#print axioms Legendre.Literature.Ingham1937LindelofProgress._proof_1
#print axioms Legendre.Literature.Ingham1940Density._proof_1
#print axioms Legendre.Literature.IwaniecPintz1984Progress._proof_1
#print axioms Legendre.Literature.IwaniecPintz1984Progress._proof_2
#print axioms Legendre.Literature.LinearMeanSquareBenchmark._proof_1
#print axioms Legendre.Literature.Mozzochi1986Progress._proof_1
#print axioms Legendre.Literature.Nagura1952._proof_1
#print axioms Legendre.Literature.Nagura1952._proof_2
#print axioms Legendre.Literature.Nagura1952._proof_3
#print axioms Legendre.Literature.RHGapProgress._proof_1
#print axioms Legendre.Literature.ZetaFoundationBenchmark._proof_1
#print axioms Legendre.Literature.ZetaFoundationBenchmark._proof_2
#print axioms Legendre.Literature.bakerHarmanPintz_comparator
#print axioms Legendre.Literature.bakerHarman_comparator_iff
#print axioms Legendre.Literature.bertrand_comparator
#print axioms Legendre.Literature.chen_comparator_iff
#print axioms Legendre.Literature.cramer1920_count_comparator
#print axioms Legendre.Literature.cramer_comparator_iff
#print axioms Legendre.Literature.cramer_implies_eventual_legendre
#print axioms Legendre.Literature.cramer_positive_exponent
#print axioms Legendre.Literature.densityPower_iff
#print axioms Legendre.Literature.densityPower_of_two
#print axioms Legendre.Literature.dudekJohnston_comparator_iff
#print axioms Legendre.Literature.exists_prime_of_count_lt
#print axioms Legendre.Literature.finiteLegendre_mono
#print axioms Legendre.Literature.finiteOppermann_implies_legendre
#print axioms Legendre.Literature.forwardProgress_iff
#print axioms Legendre.Literature.forwardProgress_of_gap
#print axioms Legendre.Literature.gapProgress_iff
#print axioms Legendre.Literature.gapProgress_of_backward
#print axioms Legendre.Literature.guthMaynard_global_comparator
#print axioms Legendre.Literature.heathBrownIwaniec_comparator_iff
#print axioms Legendre.Literature.hoheisel_comparator_iff
#print axioms Legendre.Literature.huxley_comparator_iff
#print axioms Legendre.Literature.huxley_global_comparator
#print axioms Legendre.Literature.ingham_density_comparator_iff
#print axioms Legendre.Literature.ingham_lindelof_comparator_iff
#print axioms Legendre.Literature.iwaniecPintz_comparator_iff
#print axioms Legendre.Literature.layer2_comparator
#print axioms Legendre.Literature.layer3_comparator
#print axioms Legendre.Literature.layer3_no_fixed_power_comparator
#print axioms Legendre.Literature.layer4_mean_comparator
#print axioms Legendre.Literature.legendre_comparator_iff
#print axioms Legendre.Literature.mozzochi_comparator_iff
#print axioms Legendre.Literature.nagura_comparator
#print axioms Legendre.Literature.nagura_comparator_implies_repository
#print axioms Legendre.Literature.rhGap_comparator_iff
#print axioms Legendre.Literature.rhGap_exponent_comparator
#print axioms Legendre.Literature.sorensonWebster_comparator
#print axioms Legendre.ShortIntervalStatement.eq_1
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.bertrand_comparator._proof_1_1"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.bertrand_comparator._proof_1_2"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.cramer_comparator_iff._simp_1_1"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.dudekJohnston_comparator_iff._proof_1_1"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.dudekJohnston_comparator_iff._proof_1_2"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.exists_prime_of_count_lt._proof_1_1"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.finiteOppermann_implies_legendre._proof_1_1"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.gapProgress_iff._simp_1_1"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.legendre_comparator_iff._proof_1_2"
#audit_private_axioms "_private.Legendre.Literature.Comparators.0.Legendre.Literature.legendre_comparator_iff._proof_1_3"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_bakerharman1996"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_bakerharmanpintz2001"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_bertrand1852"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_chen1975"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_cramer1920rh"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_cramer1936"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_dudekjohnston2026"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_heathbrowniwaniec1979"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_hoheisel1930"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_huxley1972"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_ingham1937density"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_ingham1937lindelof"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_iwaniecpintz1984"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_layer0"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_layer1"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_layer2"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_layer3"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_layer4"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_legendre1808"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_mozzochi1986"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_nagura1952"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.comparator_sorensonwebster2025"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.historical_proof_bertrand1852"
#audit_private_axioms "_private.Legendre.Tests.Literature.0.Legendre.Tests.Literature.historical_proof_nagura1952"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.almost_prime_scope_guard"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.bhp_epsilon_consumer"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.computation_version_guard"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.corrected_heathBrownIwaniec_value"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.corrected_iwaniecPintz_value"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.cramer_bridge_consumer"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.density_12_5_consumer"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.density_30_13_consumer"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.layer3_power_guard"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.oppermann_origin_guard"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.oppermann_origin_guard._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.rh_exponent_consumer"
#audit_private_axioms "_private.Legendre.Tests.LiteratureRegression.0.Legendre.Tests.Literature.strict_nagura_consumer"

-- Actual sixth-log fourth moment: complete new declaration inventory.
#print axioms Legendre.Density.Moment.coefficientEnergy_mask
#print axioms Legendre.Density.Moment.divisor_shifted_head
#print axioms Legendre.Density.Moment.divisor_shifted_tail
#print axioms Legendre.Density.Moment.divisor_square_as_sum
#print axioms Legendre.Density.Moment.divisor_square_harmonic
#print axioms Legendre.Density.Moment.gaussian_integral_cauchy
#print axioms Legendre.Density.Moment.gaussian_subset_fubini
#print axioms Legendre.Density.Moment.gaussian_subset_integrable
#print axioms Legendre.Density.Moment.gaussian_subset_mean
#print axioms Legendre.Density.Moment.harmonic_multiples
#print axioms Legendre.Density.Moment.harmonic_multiples_le
#print axioms Legendre.Density.Moment.momentBlockEnergyConstant._proof_1
#print axioms Legendre.Density.Moment.momentBlockEnergyConstant._proof_2
#print axioms Legendre.Density.Moment.momentBlockEnergyConstant_pos
#print axioms Legendre.Density.Moment.momentGaussian._proof_1
#print axioms Legendre.Density.Moment.momentGaussian_continuous
#print axioms Legendre.Density.Moment.momentGaussian_integrable
#print axioms Legendre.Density.Moment.momentGaussian_integral_pos
#print axioms Legendre.Density.Moment.momentGaussian_pos
#print axioms Legendre.Density.Moment.moment_block_energy_sum
#print axioms Legendre.Density.Moment.moment_block_energy_summable
#print axioms Legendre.Density.Moment.moment_block_weight_sum
#print axioms Legendre.Density.Moment.moment_cutoff
#print axioms Legendre.Density.Moment.moment_dyadic_fraction_bound
#print axioms Legendre.Density.Moment.moment_dyadic_log_bound
#print axioms Legendre.Density.Moment.moment_dyadic_partition
#print axioms Legendre.Density.Moment.moment_integral_limit_bound
#print axioms Legendre.Density.Moment.moment_weighted_block_mean
#print axioms Legendre.Density.Moment.moment_weighted_sum_norm_sq
#print axioms Legendre.Density.Moment.realPhase_add
#print axioms Legendre.Density.Moment.subsetPolynomial_add
#print axioms Legendre.Density.Moment.subsetPolynomial_continuous
#print axioms Legendre.Density.Moment.subsetPolynomial_mask
#print axioms Legendre.Density.Moment.subsetPolynomial_mean
#print axioms Legendre.Density.Moment.subsetPolynomial_norm
#print axioms Legendre.Density.Moment.subsetPolynomial_shifted_mean
#print axioms Legendre.Density.Moment.verticalCoefficients_square_div
#print axioms Legendre.Density.Moment.weighted_cauchy
#print axioms Legendre.Literature.layer4_fourth_moment_exponent_comparator
#print axioms Legendre.Literature.layer4_fourth_moment_log_six_comparator
#print axioms Legendre.Zeta.LSeries_term_add
#print axioms Legendre.Zeta.LSeries_term_vertical
#print axioms Legendre.Zeta.divisor_self_convolution
#print axioms Legendre.Zeta.finiteMellin_analytic
#print axioms Legendre.Zeta.finiteMellin_norm
#print axioms Legendre.Zeta.finiteMellin_original_polynomial
#print axioms Legendre.Zeta.gammaReal_analytic_of_re_pos
#print axioms Legendre.Zeta.gaussian_strip_vertical_eq
#print axioms Legendre.Zeta.norm_two_pi_inv_le_one
#print axioms Legendre.Zeta.polynomial_gaussian_absorb
#print axioms Legendre.Zeta.xiFiniteKernel.eq_1
#print axioms Legendre.Zeta.xiFiniteKernel_original_terms
#print axioms Legendre.Zeta.xiFiniteKernel_shift
#print axioms Legendre.Zeta.xiFiniteSquare_continuousOn
#print axioms Legendre.Zeta.xiFiniteSquare_dyadic_mean
#print axioms Legendre.Zeta.xiFiniteSquare_energy
#print axioms Legendre.Zeta.xiFiniteSquare_head_mean
#print axioms Legendre.Zeta.xiFiniteSquare_mean
#print axioms Legendre.Zeta.xiFiniteSquare_partial_mean
#print axioms Legendre.Zeta.xiFiniteSquare_tail_assembly
#print axioms Legendre.Zeta.xiFiniteSquare_tail_mean
#print axioms Legendre.Zeta.xiMellinConstant._proof_1
#print axioms Legendre.Zeta.xiMellinConstant_pos
#print axioms Legendre.Zeta.xiMellinCost._proof_1
#print axioms Legendre.Zeta.xiMellinCost.eq_1
#print axioms Legendre.Zeta.xiMellinCost_log
#print axioms Legendre.Zeta.xiMellinCost_pos
#print axioms Legendre.Zeta.xiMellinKernel.eq_1
#print axioms Legendre.Zeta.xiMellinKernel_analytic
#print axioms Legendre.Zeta.xiMellinKernel_common_bound
#print axioms Legendre.Zeta.xiMellinKernel_line_continuous
#print axioms Legendre.Zeta.xiMellinKernel_short_line
#print axioms Legendre.Zeta.xiMellinKernel_strip_bound
#print axioms Legendre.Zeta.xiMellinKernel_vertical_continuous
#print axioms Legendre.Zeta.xiSmoothedZetaSquare_integral
#print axioms Legendre.Zeta.xiSmoothedZetaSquare_mean
#print axioms Legendre.Zeta.xiSmoothedZetaSquare_series
#print axioms Legendre.Zeta.xiSquareIntegralTerm._proof_1
#print axioms Legendre.Zeta.xiSquareIntegralTerm.eq_1
#print axioms Legendre.Zeta.xiSquareIntegralTerm_sum
#print axioms Legendre.Zeta.xiSquareIntegralTerm_sum_shift
#print axioms Legendre.Zeta.xiSquareIntegralTerm_summable
#print axioms Legendre.Zeta.xiSquareIntegralTerm_zero
#print axioms Legendre.Zeta.xiSquareSeriesTerm.eq_1
#print axioms Legendre.Zeta.xiSquareSeriesTerm_bound
#print axioms Legendre.Zeta.xiSquareSeriesTerm_continuous
#print axioms Legendre.Zeta.xiSquareSeriesTerm_integrable
#print axioms Legendre.Zeta.xiSquareSeriesTerm_integral_summable
#print axioms Legendre.Zeta.xiSquare_partial_limit
#print axioms Legendre.Zeta.xi_shift_polynomial_bound
#print axioms Legendre.Zeta.zetaSquareCoefficient.eq_1
#print axioms Legendre.Zeta.zetaSquareCoefficient_one
#print axioms Legendre.Zeta.zetaSquareCoefficient_summable
#print axioms Legendre.Zeta.zetaSquareCoefficient_zero
#print axioms Legendre.Zeta.zeta_critical_fourth_integrable
#print axioms Legendre.Zeta.zeta_fourth_moment_epsilon
#print axioms Legendre.Zeta.zeta_fourth_moment_log_six
#print axioms Legendre.Zeta.zeta_fourth_moment_positive_log_six
#print axioms Legendre.Zeta.zeta_square_LSeries
#audit_private_axioms "_private.Legendre.Layer4.DivisorEnergy.0.Legendre.Density.Moment.divisor_shifted_tail._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DivisorEnergy.0.Legendre.Density.Moment.divisor_shifted_tail._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DivisorEnergy.0.Legendre.Density.Moment.divisor_square_as_sum._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicArithmetic.0.Legendre.Density.Moment.moment_dyadic_fraction_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicArithmetic.0.Legendre.Density.Moment.moment_dyadic_fraction_bound._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DyadicArithmetic.0.Legendre.Density.Moment.moment_dyadic_fraction_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DyadicArithmetic.0.Legendre.Density.Moment.moment_dyadic_fraction_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DyadicArithmetic.0.Legendre.Density.Moment.moment_dyadic_fraction_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DyadicArithmetic.0.Legendre.Density.Moment.moment_dyadic_fraction_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.DyadicArithmetic.0.Legendre.Density.Moment.moment_dyadic_fraction_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.DyadicArithmetic.0.Legendre.Density.Moment.moment_dyadic_log_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicPartition.0.Legendre.Density.Moment.moment_dyadic_partition._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DyadicPartition.0.Legendre.Density.Moment.moment_dyadic_partition._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DyadicPartition.0.Legendre.Density.Moment.moment_dyadic_partition._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicPartition.0.Legendre.Density.Moment.moment_dyadic_partition._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DyadicPartition.0.Legendre.Density.Moment.moment_dyadic_partition._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.XiDyadicMean.0.Legendre.Zeta.xiFiniteSquare_dyadic_mean._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.XiFiniteMellin.0.Legendre.Zeta.finiteMellin_analytic._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.XiHeadMean.0.Legendre.Zeta.xiMellinCost_log._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.XiHeadMean.0.Legendre.Zeta.xiMellinCost_log._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.XiHeadMean.0.Legendre.Zeta.xiMellinCost_log._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.XiHeadMean.0.Legendre.Zeta.xiMellinCost_log._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.XiHeadMean.0.Legendre.Zeta.xiMellinCost_log._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.XiHeadMean.0.Legendre.Zeta.xiMellinCost_log._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.XiHeadMean.0.Legendre.Zeta.xiMellinCost_log._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.XiSquareLimit.0.Legendre.Zeta.xiSquare_partial_limit._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.XiSquareLimit.0.Legendre.Zeta.xiSquare_partial_limit._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.XiSquareLimit.0.Legendre.Zeta.xiSquare_partial_limit._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.XiSquareLimit.0.Legendre.Zeta.xiSquare_partial_limit._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.XiSquareLimit.0.Legendre.Zeta.xiSquare_partial_limit._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.XiTailAssembly.0.Legendre.Zeta.xiFiniteSquare_tail_assembly._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.verticalCoefficients.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_divisor_energy_one_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_divisor_energy_zero_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_fourth_moment_exponent_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_fourth_moment_height_two_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_smoothed_zero_term_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_translated_subset_mean_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Zeta.zetaSquareCoefficient.eq_1"

-- Compact Mobius detector: complete new declaration inventory.
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_energy
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_harmonic_energy
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_initial
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_norm
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_one
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_small
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_summable
#print axioms Legendre.Density.Detector.Smooth.detectorKernel_high_bound
#print axioms Legendre.Density.Detector.Smooth.detectorKernel_left_bound
#print axioms Legendre.Density.Detector.Smooth.detectorKernel_line_bound
#print axioms Legendre.Density.Detector.Smooth.detectorKernel_verticalIntegrable
#print axioms Legendre.Density.Detector.Smooth.detectorMean_eq_integral
#print axioms Legendre.Density.Detector.Smooth.detectorMean_split
#print axioms Legendre.Density.Detector.Smooth.detectorMean_tsum
#print axioms Legendre.Density.Detector.Smooth.detectorVerticalTerm._proof_1
#print axioms Legendre.Density.Detector.Smooth.detectorVerticalTerm.eq_1
#print axioms Legendre.Density.Detector.Smooth.detectorVerticalTerm_continuous
#print axioms Legendre.Density.Detector.Smooth.detectorVerticalTerm_integrable
#print axioms Legendre.Density.Detector.Smooth.detectorVerticalTerm_inversion
#print axioms Legendre.Density.Detector.Smooth.detectorVerticalTerm_norm
#print axioms Legendre.Density.Detector.Smooth.detectorVerticalTerm_summable_norm
#print axioms Legendre.Density.Detector.Smooth.detectorWeight._proof_1
#print axioms Legendre.Density.Detector.Smooth.detectorWeight.eq_1
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_at_one_div
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_continuous
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_eq
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_hasMellin
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_mellin_inversion
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_nonneg
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_zero
#print axioms Legendre.Density.Detector.Smooth.detector_convolution
#print axioms Legendre.Density.Detector.Smooth.mobiusCutoff_eq_truncate
#print axioms Legendre.Density.Detector.Smooth.mobiusCutoff_norm
#print axioms Legendre.Density.Detector.Smooth.mollifier_eq_LSeries
#print axioms Legendre.Density.Detector.Smooth.mollifier_zeta_product
#audit_private_axioms "_private.Legendre.Layer4.DetectorCoefficients.0.Legendre.Density.Detector.Smooth.detectorCoefficient_small._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorIntegral.0.Legendre.Density.Detector.Smooth.detectorVerticalTerm_continuous._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorSeries.0.Legendre.Density.Detector.Smooth.detectorMean_split._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorSeries.0.Legendre.Density.Detector.Smooth.detectorMean_split._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DetectorSeries.0.Legendre.Density.Detector.Smooth.detectorMean_split._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DetectorSeries.0.Legendre.Density.Detector.Smooth.detectorMean_split._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DetectorSeries.0.Legendre.Density.Detector.Smooth.detectorMean_tsum._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorSeries.0.Legendre.Density.Detector.Smooth.detectorMean_tsum._proof_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Detector.Smooth.detectorMean.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Detector.Smooth.detectorWeight.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_cutoff_one_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_head_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_head_consumer._proof_1_4"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_head_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_head_consumer._simp_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_head_consumer._simp_1_3"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_initial_contour_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_left_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_weight_endpoint_consumer"

-- Compensated compact detector: complete new declaration inventory.
#print axioms Legendre.Density.Detector.Smooth.criticalMass_nonneg
#print axioms Legendre.Density.Detector.Smooth.criticalProduct._proof_1
#print axioms Legendre.Density.Detector.Smooth.criticalProduct.eq_1
#print axioms Legendre.Density.Detector.Smooth.criticalProduct_bound
#print axioms Legendre.Density.Detector.Smooth.criticalProduct_continuous
#print axioms Legendre.Density.Detector.Smooth.criticalProduct_weighted_integrable
#print axioms Legendre.Density.Detector.Smooth.criticalWeight.eq_1
#print axioms Legendre.Density.Detector.Smooth.criticalWeight_continuous
#print axioms Legendre.Density.Detector.Smooth.criticalWeight_eq_rpow
#print axioms Legendre.Density.Detector.Smooth.criticalWeight_nonneg
#print axioms Legendre.Density.Detector.Smooth.detectorCriticalIntegral._proof_1
#print axioms Legendre.Density.Detector.Smooth.detectorCriticalIntegral.eq_1
#print axioms Legendre.Density.Detector.Smooth.detectorCriticalIntegral_bound
#print axioms Legendre.Density.Detector.Smooth.detectorCriticalIntegral_uniform_bound
#print axioms Legendre.Density.Detector.Smooth.detectorGrowthCost._proof_1
#print axioms Legendre.Density.Detector.Smooth.detectorGrowthCost.eq_1
#print axioms Legendre.Density.Detector.Smooth.detectorIntegrand.eq_1
#print axioms Legendre.Density.Detector.Smooth.detectorIntegrand_line_continuous
#print axioms Legendre.Density.Detector.Smooth.detectorIntegrand_regularized
#print axioms Legendre.Density.Detector.Smooth.detectorMean_at_zero
#print axioms Legendre.Density.Detector.Smooth.detectorNumerator.eq_1
#print axioms Legendre.Density.Detector.Smooth.detectorNumerator_analytic
#print axioms Legendre.Density.Detector.Smooth.detectorNumerator_zero
#print axioms Legendre.Density.Detector.Smooth.detectorPrincipalPole.eq_1
#print axioms Legendre.Density.Detector.Smooth.detectorPrincipalPole_high_bound
#print axioms Legendre.Density.Detector.Smooth.detectorPrincipalPole_small
#print axioms Legendre.Density.Detector.Smooth.detectorRegularFactor._proof_1
#print axioms Legendre.Density.Detector.Smooth.detectorRegularFactor.eq_1
#print axioms Legendre.Density.Detector.Smooth.detectorRegularFactor_analytic
#print axioms Legendre.Density.Detector.Smooth.detectorRegularFactor_at_principal_pole
#print axioms Legendre.Density.Detector.Smooth.detector_critical_point_bound
#print axioms Legendre.Density.Detector.Smooth.detector_decay_mul
#print axioms Legendre.Density.Detector.Smooth.detector_high_bound
#print axioms Legendre.Density.Detector.Smooth.detector_high_zero_dichotomy
#print axioms Legendre.Density.Detector.Smooth.detector_horizontal_bound
#print axioms Legendre.Density.Detector.Smooth.detector_horizontal_tendsto
#print axioms Legendre.Density.Detector.Smooth.detector_left_bound
#print axioms Legendre.Density.Detector.Smooth.detector_left_integrable
#print axioms Legendre.Density.Detector.Smooth.detector_numerator_bound
#print axioms Legendre.Density.Detector.Smooth.detector_rectangle_principal
#print axioms Legendre.Density.Detector.Smooth.detector_right_bound
#print axioms Legendre.Density.Detector.Smooth.detector_right_integrable
#print axioms Legendre.Density.Detector.Smooth.detector_zero_contour_shift
#print axioms Legendre.Density.Detector.Smooth.detector_zero_dichotomy
#print axioms Legendre.Density.Detector.Smooth.mollifier_shift_analytic
#print axioms Legendre.Density.Detector.Smooth.norm_detectorPrincipalPole_le
#print axioms Legendre.Density.Detector.Smooth.rectangle_analytic_quotient
#print axioms Legendre.Density.Detector.Smooth.zeta_strip_away_bound
#print axioms Legendre.Literature.CompensatedDetectorBenchmark._proof_1
#print axioms Legendre.Literature.CompensatedDetectorBenchmark._proof_2
#print axioms Legendre.Literature.CompensatedDetectorBenchmark._proof_3
#print axioms Legendre.Literature.layer4_compensated_detector_comparator
#audit_private_axioms "_private.Legendre.Layer4.DetectorAnalytic.0.Legendre.Density.Detector.Smooth.detectorIntegrand_regularized._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DetectorAnalytic.0.Legendre.Density.Detector.Smooth.detectorIntegrand_regularized._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DetectorAnalytic.0.Legendre.Density.Detector.Smooth.detectorIntegrand_regularized._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DetectorAnalytic.0.Legendre.Density.Detector.Smooth.detectorIntegrand_regularized._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.DetectorAnalytic.0.Legendre.Density.Detector.Smooth.detectorIntegrand_regularized._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.DetectorAnalytic.0.Legendre.Density.Detector.Smooth.detectorIntegrand_regularized._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.DetectorAnalytic.0.Legendre.Density.Detector.Smooth.detectorIntegrand_regularized._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.DetectorHorizontal.0.Legendre.Density.Detector.Smooth.detector_high_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorHorizontal.0.Legendre.Density.Detector.Smooth.detector_high_bound._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DetectorHorizontal.0.Legendre.Density.Detector.Smooth.detector_high_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DetectorHorizontal.0.Legendre.Density.Detector.Smooth.detector_high_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DetectorHorizontal.0.Legendre.Density.Detector.Smooth.detector_high_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DetectorHorizontal.0.Legendre.Density.Detector.Smooth.detector_high_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.DetectorHorizontal.0.Legendre.Density.Detector.Smooth.detector_high_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.DetectorRectangle.0.Legendre.Density.Detector.Smooth.detector_rectangle_principal._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorShift.0.Legendre.Density.Detector.Smooth.detectorMean_at_zero._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorShift.0.Legendre.Density.Detector.Smooth.detectorMean_at_zero._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DetectorShift.0.Legendre.Density.Detector.Smooth.detectorMean_at_zero._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DetectorShift.0.Legendre.Density.Detector.Smooth.detectorMean_at_zero._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DetectorShift.0.Legendre.Density.Detector.Smooth.detectorMean_at_zero._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DetectorShift.0.Legendre.Density.Detector.Smooth.detectorMean_at_zero._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.DetectorShift.0.Legendre.Density.Detector.Smooth.detectorMean_at_zero._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.DetectorShift.0.Legendre.Density.Detector.Smooth.detectorMean_at_zero._simp_1_8"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Detector.Smooth.detectorKernel.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Detector.Smooth.detectorPrincipalPole.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_high_zero_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compact_high_zero_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compensated_mean_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_compensated_mean_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_critical_mass_integrable_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_principal_pole_empty_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_principal_pole_height64_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_principal_pole_nonzero_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_principal_pole_nonzero_consumer._simp_1_4"

-- Weighted whole-line moments and integral-branch count: complete inventory.
#print axioms Legendre.Density.Moment.count_cube
#print axioms Legendre.Density.Moment.criticalMass_eq_shift
#print axioms Legendre.Density.Moment.criticalWeight_integrable
#print axioms Legendre.Density.Moment.criticalWeight_le_inverse_square
#print axioms Legendre.Density.Moment.criticalWeight_le_one
#print axioms Legendre.Density.Moment.criticalWeight_separated_sum
#print axioms Legendre.Density.Moment.criticalWeight_shift_integrable
#print axioms Legendre.Density.Moment.criticalWeight_shift_integral
#print axioms Legendre.Density.Moment.critical_mollifier_mean
#print axioms Legendre.Density.Moment.dyadic_height_log
#print axioms Legendre.Density.Moment.integral_alternative_count
#print axioms Legendre.Density.Moment.mollifier_critical_continuous
#print axioms Legendre.Density.Moment.momentHeightBall._proof_1
#print axioms Legendre.Density.Moment.momentHeightBall_mem
#print axioms Legendre.Density.Moment.momentHeightBall_mono
#print axioms Legendre.Density.Moment.momentHeightEnergyConstant._proof_1
#print axioms Legendre.Density.Moment.momentHeightEnergyConstant._proof_2
#print axioms Legendre.Density.Moment.momentHeightEnergyConstant_pos
#print axioms Legendre.Density.Moment.momentHeightShell.eq_1
#print axioms Legendre.Density.Moment.momentHeightShell.eq_2
#print axioms Legendre.Density.Moment.momentHeightShell_cover
#print axioms Legendre.Density.Moment.momentHeightShell_disjoint
#print axioms Legendre.Density.Moment.momentHeightShell_measurable
#print axioms Legendre.Density.Moment.momentHeightShell_subset
#print axioms Legendre.Density.Moment.momentHeightWeight_continuous
#print axioms Legendre.Density.Moment.momentHeightWeight_eq
#print axioms Legendre.Density.Moment.momentHeightWeight_nonneg
#print axioms Legendre.Density.Moment.momentHeightWeight_shell
#print axioms Legendre.Density.Moment.momentKernelPackingConstant._proof_1
#print axioms Legendre.Density.Moment.momentKernelPackingConstant._proof_2
#print axioms Legendre.Density.Moment.momentKernelPackingConstant._proof_3
#print axioms Legendre.Density.Moment.momentKernelPackingConstant._proof_4
#print axioms Legendre.Density.Moment.momentKernelPackingConstant_pos
#print axioms Legendre.Density.Moment.momentShellBudget._proof_1
#print axioms Legendre.Density.Moment.momentShellBudget._proof_2
#print axioms Legendre.Density.Moment.momentShellBudget.eq_1
#print axioms Legendre.Density.Moment.momentShellBudget.eq_2
#print axioms Legendre.Density.Moment.momentShellBudget_nonneg
#print axioms Legendre.Density.Moment.momentShellBudget_sum
#print axioms Legendre.Density.Moment.momentShellBudget_summable
#print axioms Legendre.Density.Moment.moment_cubic_mixed_integrable
#print axioms Legendre.Density.Moment.moment_finite_product_cauchy
#print axioms Legendre.Density.Moment.moment_finite_product_fourth
#print axioms Legendre.Density.Moment.moment_height_energy_summable
#print axioms Legendre.Density.Moment.moment_indexed_kernel_packing
#print axioms Legendre.Density.Moment.moment_kernel_far_bound
#print axioms Legendre.Density.Moment.moment_kernel_height_packing
#print axioms Legendre.Density.Moment.moment_packed_moment
#print axioms Legendre.Density.Moment.moment_packed_pointwise
#print axioms Legendre.Density.Moment.moment_product_cauchy
#print axioms Legendre.Density.Moment.moment_separated_card
#print axioms Legendre.Density.Moment.moment_weighted_moment
#print axioms Legendre.Density.Moment.moment_weighted_shell_bound
#print axioms Legendre.Density.Moment.packed_critical_mass_fourth
#print axioms Legendre.Density.Moment.packed_mollifier_mean
#print axioms Legendre.Density.Moment.packed_scalar_moment
#print axioms Legendre.Density.Moment.packed_zeta_fourth_moment
#print axioms Legendre.Density.Moment.weighted_mollifier_mean
#print axioms Legendre.Density.Moment.weighted_zeta_fourth_moment
#print axioms Legendre.Density.Moment.zeta_critical_continuous
#print axioms Legendre.Literature.layer4_weighted_moment_comparator
#audit_private_axioms "_private.Legendre.Layer4.CubicIntegrability.0.Legendre.Density.Moment.criticalWeight_integrable._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicHeightShells.0.Legendre.Density.Moment.momentHeightShell_cover._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicHeightShells.0.Legendre.Density.Moment.momentHeightShell_disjoint._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicHeightShells.0.Legendre.Density.Moment.momentHeightShell_disjoint._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.IntegralAlternative.0.Legendre.Density.Moment.integral_alternative_count._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.ProductCauchy.0.Legendre.Density.Moment.moment_finite_product_fourth._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.WeightedHeightMoment.0.Legendre.Density.Moment.momentHeightShell.match_1.eq_1"
#audit_private_axioms "_private.Legendre.Layer4.WeightedHeightMoment.0.Legendre.Density.Moment.momentHeightShell.match_1.eq_2"
#audit_private_axioms "_private.Legendre.Layer4.WeightedHeightMoment.0.Legendre.Density.Moment.momentShellBudget.match_1.eq_1"
#audit_private_axioms "_private.Legendre.Layer4.WeightedHeightMoment.0.Legendre.Density.Moment.momentShellBudget.match_1.eq_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Detector.Smooth.criticalWeight.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.momentHeightBall.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.momentHeightShell.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.momentHeightShell.eq_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.momentHeightShell.match_1.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.momentHeightShell.match_1.eq_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.momentHeightWeight.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_cubic_kernel_adjacent_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_cubic_kernel_adjacent_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_cubic_kernel_adjacent_consumer._simp_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_height_shell_zero_scale_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_height_weight_origin_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_packed_mass_singleton_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_packed_mass_singleton_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weighted_fourth_height_two_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weighted_mollifier_one_consumer"

-- Compact polynomial branch, height cover and complete Ingham density.
#print axioms Legendre.Density.Detector.Smooth.detectorTail_blocks
#print axioms Legendre.Density.Detector.Smooth.detectorTail_extended
#print axioms Legendre.Density.Detector.Smooth.detectorTail_polynomial
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_norm_le_one
#print axioms Legendre.Density.Detector.Smooth.polynomialCoefficient.eq_1
#print axioms Legendre.Density.Detector.Smooth.polynomialCoefficient_above
#print axioms Legendre.Density.Detector.Smooth.polynomialCoefficient_below
#print axioms Legendre.Density.Detector.Smooth.polynomialCoefficient_norm
#print axioms Legendre.Density.Moment.balance_exponent_ge_one
#print axioms Legendre.Density.Moment.balance_exponent_le_three_halves
#print axioms Legendre.Density.Moment.balancedDensityExponent._proof_1
#print axioms Legendre.Density.Moment.balancedDensityExponent._proof_2
#print axioms Legendre.Density.Moment.balancedDensityExponent_ge_two_defect
#print axioms Legendre.Density.Moment.balancedDensityExponent_le_one
#print axioms Legendre.Density.Moment.balancedDensityExponent_nonneg
#print axioms Legendre.Density.Moment.balanced_count_from_cube
#print axioms Legendre.Density.Moment.balanced_detector_cutoff
#print axioms Legendre.Density.Moment.balanced_inverse_gap
#print axioms Legendre.Density.Moment.balanced_log_cost
#print axioms Legendre.Density.Moment.balanced_polynomial_powers
#print axioms Legendre.Density.Moment.balanced_power_identity
#print axioms Legendre.Density.Moment.balanced_scale_below_half_height_square
#print axioms Legendre.Density.Moment.block_endpoint_powers
#print axioms Legendre.Density.Moment.block_subset_initial
#print axioms Legendre.Density.Moment.four_logs_le_eight
#print axioms Legendre.Density.Moment.height_log_unit
#print axioms Legendre.Density.Moment.height_shell_card_le
#print axioms Legendre.Density.Moment.height_shell_mem
#print axioms Legendre.Density.Moment.height_shell_power_log
#print axioms Legendre.Density.Moment.indexed_separated_card
#print axioms Legendre.Density.Moment.integral_alternative_balanced
#print axioms Legendre.Density.Moment.log_eight_unit
#print axioms Legendre.Density.Moment.moment_detector_dyadic_cover
#print axioms Legendre.Density.Moment.moment_finite_block_square
#print axioms Legendre.Density.Moment.near_critical_height_power
#print axioms Legendre.Density.Moment.near_critical_separated_count
#print axioms Legendre.Density.Moment.one_le_two_log
#print axioms Legendre.Density.Moment.polynomialBlockCoefficient.eq_1
#print axioms Legendre.Density.Moment.polynomialBlockConstant._proof_1
#print axioms Legendre.Density.Moment.polynomialBlockConstant._proof_2
#print axioms Legendre.Density.Moment.polynomialBlockConstant._proof_3
#print axioms Legendre.Density.Moment.polynomialBlockConstant_pos
#print axioms Legendre.Density.Moment.polynomialBlockSamplingCost._proof_1
#print axioms Legendre.Density.Moment.polynomialBlockSamplingCost._proof_2
#print axioms Legendre.Density.Moment.polynomialBlockSamplingCost_nonneg
#print axioms Legendre.Density.Moment.polynomialBlock_cost_log
#print axioms Legendre.Density.Moment.polynomialBlock_divisor_energy
#print axioms Legendre.Density.Moment.polynomialBlock_energy
#print axioms Legendre.Density.Moment.polynomialBlock_mask
#print axioms Legendre.Density.Moment.polynomialBlock_samples
#print axioms Legendre.Density.Moment.polynomialBlock_uniform
#print axioms Legendre.Density.Moment.polynomial_actual_block
#print axioms Legendre.Density.Moment.polynomial_alternative_balanced
#print axioms Legendre.Density.Moment.polynomial_alternative_count
#print axioms Legendre.Density.Moment.real_height_dyadic_cover
#print axioms Legendre.Density.Moment.separated_high_density
#print axioms Legendre.Density.Moment.separated_high_shell_density
#print axioms Legendre.Density.Moment.separated_high_shell_density_uniform
#print axioms Legendre.Literature.layer4_ingham_comparator
#print axioms Legendre.Zeta.hasZeroDensityEstimate_three
#print axioms Legendre.Zeta.ingham_density_epsilon
#print axioms Legendre.Zeta.ingham_density_log_bound
#print axioms Legendre.Zeta.zeroDensityCount_le_of_cutoff_sample_bound
#audit_private_axioms "_private.Legendre.Layer4.DensityBalance.0.Legendre.Density.Moment.balanced_polynomial_powers._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DensityBalance.0.Legendre.Density.Moment.balanced_polynomial_powers._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DensityBalance.0.Legendre.Density.Moment.balanced_polynomial_powers._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DensityBalance.0.Legendre.Density.Moment.balanced_polynomial_powers._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DensityBalance.0.Legendre.Density.Moment.balanced_polynomial_powers._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DensityBalance.0.Legendre.Density.Moment.balanced_polynomial_powers._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.DensityBalance.0.Legendre.Density.Moment.balanced_polynomial_powers._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.DetectorPolynomial.0.Legendre.Density.Detector.Smooth.detectorTail_extended._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.InghamMultiplicity.0.Legendre.Density.Moment.height_log_unit._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.InghamMultiplicity.0.Legendre.Zeta.zeroDensityCount_le_of_cutoff_sample_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.NearCriticalDensity.0.Legendre.Density.Moment.log_eight_unit._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.PolynomialBlockCost.0.Legendre.Density.Moment.block_endpoint_powers._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.PolynomialBlockSampling.0.Legendre.Density.Moment.block_subset_initial._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.PolynomialBlockSampling.0.Legendre.Density.Moment.polynomialBlockSamplingCost_nonneg._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.PolynomialBlockSampling.0.Legendre.Density.Moment.polynomialBlock_samples._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.balancedDensityExponent.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.detectorBalanceExponent.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_density_three_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_ingham_balance_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_ingham_critical_line_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_ingham_height_two_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_ingham_three_quarters_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_shell_boundary_consumer"

-- Actual logarithmic-phase cancellation and analytic Halasz energy.
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.abs_cot_pi_le
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.cot_antitone_unit
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.discrete_second_derivative_partition_bound
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.discrete_second_derivative_sqrt_bound
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.discrete_second_derivative_sqrt_bound_local
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_Ico_bound
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_either
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_either_succ
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_strip
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_strip_succ
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_succ
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phase._proof_1
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phaseWeight_difference_norm
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phaseWeight_identity
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phaseWeight_norm_le
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phase_add
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phase_int
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phase_neg
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phase_norm
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phase_step_weight
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.phase_sub_int_mul
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.second_derivative_sqrt_bound
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.second_derivative_sqrt_bound_Ico
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.second_derivative_sqrt_bound_positive
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.second_derivative_test
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.second_derivative_test_Ico
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.sin_pi_lower
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.translated_sampled_increment_bounds
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.weighted_telescope
#print axioms Legendre.Density.Oscillation.Tools.ExponentialSum.weighted_telescope_succ
#print axioms Legendre.Density.Oscillation.Tools.adjacent_near_integer_card
#print axioms Legendre.Density.Oscillation.Tools.affineTailPhase.eq_1
#print axioms Legendre.Density.Oscillation.Tools.affineTailPhase_eq
#print axioms Legendre.Density.Oscillation.Tools.affineTailPhase_increment
#print axioms Legendre.Density.Oscillation.Tools.affineTailPhase_increment_antitone
#print axioms Legendre.Density.Oscillation.Tools.affineTailPhase_increment_eq
#print axioms Legendre.Density.Oscillation.Tools.affineTailPhase_increment_monotone
#print axioms Legendre.Density.Oscillation.Tools.antitone_filter_range_eq_Ico
#print axioms Legendre.Density.Oscillation.Tools.derivative_near_integer_card
#print axioms Legendre.Density.Oscillation.Tools.discrete_increment_bounds
#print axioms Legendre.Density.Oscillation.Tools.exists_antitone_increment_extension
#print axioms Legendre.Density.Oscillation.Tools.exists_monotone_increment_extension
#print axioms Legendre.Density.Oscillation.Tools.floor_interval_card_le
#print axioms Legendre.Density.Oscillation.Tools.monotone_filter_range_eq_Ico
#print axioms Legendre.Density.Oscillation.Tools.nat_separated_near_integer_card
#print axioms Legendre.Density.Oscillation.Tools.nearIntegerIndices.eq_1
#print axioms Legendre.Density.Oscillation.Tools.near_integer_sqrt_budget
#print axioms Legendre.Density.Oscillation.Tools.norm_sum_le_bad_card_add_good_blocks
#print axioms Legendre.Density.Oscillation.Tools.norm_sum_le_near_integer_bound
#print axioms Legendre.Density.Oscillation.Tools.norm_sum_le_near_integer_bound_local
#print axioms Legendre.Density.Oscillation.Tools.norm_sum_monotone_block_le
#print axioms Legendre.Density.Oscillation.Tools.phaseGoodBlock_pairwise_disjoint
#print axioms Legendre.Density.Oscillation.Tools.phase_bad_near_integer
#print axioms Legendre.Density.Oscillation.Tools.sampled_increment_abs_bounds
#print axioms Legendre.Density.Oscillation.Tools.sampled_increment_bounds
#print axioms Legendre.Density.Oscillation.Tools.sampled_increment_strictMono_or_strictAnti
#print axioms Legendre.Density.Oscillation.Tools.second_derivative_partition_sqrt_budget
#print axioms Legendre.Density.Oscillation.Tools.second_derivative_signed_bounds
#print axioms Legendre.Density.Oscillation.Tools.second_difference_bounds
#print axioms Legendre.Density.Oscillation.Tools.second_difference_eq_deriv
#print axioms Legendre.Density.Oscillation.Tools.separated_interval_card
#print axioms Legendre.Density.Oscillation.Tools.separated_near_integer_card
#print axioms Legendre.Density.Oscillation.Tools.separated_near_integer_card_nat
#print axioms Legendre.Density.Oscillation.Tools.slope_bounds_of_adjacent
#print axioms Legendre.Density.Oscillation.blockDirichletPolynomial.eq_1
#print axioms Legendre.Density.Oscillation.blockDirichletPolynomial_unit
#print axioms Legendre.Density.Oscillation.block_complex_vertical
#print axioms Legendre.Density.Oscillation.finite_positive_inverses
#print axioms Legendre.Density.Oscillation.halaszBlockCoefficient._proof_1
#print axioms Legendre.Density.Oscillation.halaszBlockCoefficient.eq_1
#print axioms Legendre.Density.Oscillation.halaszBlockCoefficient_nonneg
#print axioms Legendre.Density.Oscillation.halasz_block_card_le
#print axioms Legendre.Density.Oscillation.halasz_block_complex_energy
#print axioms Legendre.Density.Oscillation.halasz_block_energy
#print axioms Legendre.Density.Oscillation.halasz_block_large_values
#print axioms Legendre.Density.Oscillation.halasz_masked_fixed
#print axioms Legendre.Density.Oscillation.indexed_reciprocal_row
#print axioms Legendre.Density.Oscillation.logDerivative_mask
#print axioms Legendre.Density.Oscillation.logarithmicKernelConstant._proof_1
#print axioms Legendre.Density.Oscillation.logarithmicKernelConstant._proof_2
#print axioms Legendre.Density.Oscillation.logarithmicKernelConstant_pos
#print axioms Legendre.Density.Oscillation.logarithmicPhase._proof_1
#print axioms Legendre.Density.Oscillation.logarithmicPhase.eq_1
#print axioms Legendre.Density.Oscillation.logarithmicPhase_deriv
#print axioms Legendre.Density.Oscillation.logarithmicPhase_eq_cpow
#print axioms Legendre.Density.Oscillation.logarithmicPhase_increment
#print axioms Legendre.Density.Oscillation.logarithmicPhase_second_bounds
#print axioms Legendre.Density.Oscillation.logarithmicPhase_second_deriv
#print axioms Legendre.Density.Oscillation.logarithmicSecondConstant._proof_1
#print axioms Legendre.Density.Oscillation.logarithmicSecondConstant._proof_2
#print axioms Legendre.Density.Oscillation.logarithmicSecondConstant_pos
#print axioms Legendre.Density.Oscillation.logarithmic_block_first
#print axioms Legendre.Density.Oscillation.logarithmic_block_first_abs
#print axioms Legendre.Density.Oscillation.logarithmic_block_kernel
#print axioms Legendre.Density.Oscillation.logarithmic_block_neg
#print axioms Legendre.Density.Oscillation.logarithmic_block_second
#print axioms Legendre.Density.Oscillation.logarithmic_block_sqrt
#print axioms Legendre.Density.Oscillation.logarithmic_increment_antitone
#print axioms Legendre.Density.Oscillation.logarithmic_increment_bounds
#print axioms Legendre.Density.Oscillation.logarithmic_kernel_row
#print axioms Legendre.Density.Oscillation.logarithmic_scale_sqrt
#print axioms Legendre.Density.Oscillation.positive_separated_reciprocals
#print axioms Legendre.Density.Oscillation.separated_reciprocals
#print axioms Legendre.Literature.layer4_actual_halasz_comparator
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_11"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_12"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._proof_1_8"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_Icc._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_either._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_either_succ._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_succ._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_succ._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.sin_pi_lower._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.sin_pi_lower._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.sin_pi_lower._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.sin_pi_lower._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.sin_pi_lower._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.sin_pi_lower._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteFirstDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.sin_pi_lower._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteSecondDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_Ico_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteSecondDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_Ico_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteSecondDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_Ico_bound._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteSecondDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_Ico_bound._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.DiscreteSecondDerivative.0.Legendre.Density.Oscillation.Tools.ExponentialSum.first_derivative_Ico_bound._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszComplex.0.Legendre.Density.Oscillation.halasz_masked_fixed._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszKernel.0.Legendre.Density.Oscillation.logarithmic_kernel_row._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogFirstDerivative.0.Legendre.Density.Oscillation.logarithmic_block_first._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogFirstDerivative.0.Legendre.Density.Oscillation.logarithmic_block_first._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_eq_cpow._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_eq_cpow._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_eq_cpow._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_eq_cpow._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_eq_cpow._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_eq_cpow._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_eq_cpow._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_eq_cpow._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_second_bounds._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_second_bounds._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_second_bounds._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_second_bounds._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_second_bounds._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_second_bounds._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_second_bounds._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmicPhase_second_bounds._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmic_block_second._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogPhase.0.Legendre.Density.Oscillation.logarithmic_block_second._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.floor_interval_card_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.monotone_filter_range_eq_Ico._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.monotone_filter_range_eq_Ico._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.norm_sum_le_near_integer_bound_local._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.norm_sum_le_near_integer_bound_local._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.norm_sum_le_near_integer_bound_local._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.norm_sum_le_near_integer_bound_local._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.norm_sum_le_near_integer_bound_local._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.phaseGoodBlock_pairwise_disjoint._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneBlocks.0.Legendre.Density.Oscillation.Tools.phaseGoodBlock_pairwise_disjoint._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_eq._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_eq._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_increment_antitone._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_increment_antitone._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_increment_antitone._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_increment_eq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_increment_monotone._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_increment_monotone._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.PhaseExtension.0.Legendre.Density.Oscillation.Tools.affineTailPhase_increment_monotone._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SecondDerivativeTest.0.Legendre.Density.Oscillation.Tools.ExponentialSum.second_derivative_sqrt_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SecondDifference.0.Legendre.Density.Oscillation.Tools.discrete_increment_bounds._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SeparatedIntervalCount.0.Legendre.Density.Oscillation.Tools.separated_interval_card._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SeparatedIntervalCount.0.Legendre.Density.Oscillation.Tools.separated_interval_card._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SeparatedIntervalCount.0.Legendre.Density.Oscillation.Tools.slope_bounds_of_adjacent._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SeparatedIntervalCount.0.Legendre.Density.Oscillation.Tools.slope_bounds_of_adjacent._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SeparatedIntervalCount.0.Legendre.Density.Oscillation.Tools.slope_bounds_of_adjacent._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SeparatedIntervalCount.0.Legendre.Density.Oscillation.Tools.slope_bounds_of_adjacent._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SeparatedReciprocals.0.Legendre.Density.Oscillation.positive_separated_reciprocals._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.SeparatedReciprocals.0.Legendre.Density.Oscillation.positive_separated_reciprocals._proof_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Oscillation.blockDirichletPolynomial.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_first_derivative_phase_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_halasz_mixed_real_parts_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_halasz_two_samples_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_log_empty_block_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_log_negative_height_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_reciprocal_height_one_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_reciprocal_height_one_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_reciprocal_height_one_consumer._simp_1_2"

-- All declarations added by the analytic large-value and actual moment step.
#print axioms Legendre.Density.Moment.amplitude_dyadic_cover
#print axioms Legendre.Density.Moment.amplitude_square_dyadic
#print axioms Legendre.Density.Moment.exists_balanced_moment_cutoff
#print axioms Legendre.Density.Moment.finite_dyadic_second_moment
#print axioms Legendre.Density.Moment.finite_square_layercake
#print axioms Legendre.Density.Moment.halaszMollifierMomentBound._proof_1
#print axioms Legendre.Density.Moment.halaszMollifierMomentBound._proof_2
#print axioms Legendre.Density.Moment.halaszMollifierMomentBound._proof_3
#print axioms Legendre.Density.Moment.halaszMollifierMomentBound._proof_4
#print axioms Legendre.Density.Moment.halaszMollifierMomentBound_nonneg
#print axioms Legendre.Density.Moment.mollifier_sampled_halasz
#print axioms Legendre.Density.Moment.packed_critical_mass_halasz
#print axioms Legendre.Density.Moment.packed_mollifier_halasz
#print axioms Legendre.Density.Oscillation.block_vertical_energy_mono
#print axioms Legendre.Density.Oscillation.bounded_polynomial_norm
#print axioms Legendre.Density.Oscillation.complex_block_pointwise_sq
#print axioms Legendre.Density.Oscillation.complex_block_time_shift
#print axioms Legendre.Density.Oscillation.complex_polynomial_time_shift
#print axioms Legendre.Density.Oscillation.criticalCutoff.eq_1
#print axioms Legendre.Density.Oscillation.criticalCutoff_norm
#print axioms Legendre.Density.Oscillation.criticalPolynomialCountConstant._proof_1
#print axioms Legendre.Density.Oscillation.criticalPolynomialCountConstant._proof_2
#print axioms Legendre.Density.Oscillation.criticalPolynomialCountConstant._proof_3
#print axioms Legendre.Density.Oscillation.criticalPolynomialCountConstant_pos
#print axioms Legendre.Density.Oscillation.criticalPolynomialCountCost._proof_1
#print axioms Legendre.Density.Oscillation.criticalPolynomialCountCost_nonneg
#print axioms Legendre.Density.Oscillation.criticalPolynomialMomentCost._proof_1
#print axioms Legendre.Density.Oscillation.criticalPolynomialMomentCost_ge_four
#print axioms Legendre.Density.Oscillation.critical_block_count
#print axioms Legendre.Density.Oscillation.critical_block_energy_le_one
#print axioms Legendre.Density.Oscillation.critical_polynomial_blocks
#print axioms Legendre.Density.Oscillation.critical_polynomial_count
#print axioms Legendre.Density.Oscillation.critical_polynomial_count_dyadic
#print axioms Legendre.Density.Oscillation.critical_polynomial_extended
#print axioms Legendre.Density.Oscillation.critical_polynomial_optimized_second_moment
#print axioms Legendre.Density.Oscillation.critical_polynomial_second_moment
#print axioms Legendre.Density.Oscillation.critical_polynomial_shifted_count
#print axioms Legendre.Density.Oscillation.critical_threshold_compare
#print axioms Legendre.Density.Oscillation.exists_large_block
#print axioms Legendre.Density.Oscillation.halaszAbsorptionScale._proof_1
#print axioms Legendre.Density.Oscillation.halaszAbsorptionScale_pos
#print axioms Legendre.Density.Oscillation.halaszAbsorptionScale_sqrt
#print axioms Legendre.Density.Oscillation.halaszCountConstant._proof_1
#print axioms Legendre.Density.Oscillation.halaszCountConstant._proof_2
#print axioms Legendre.Density.Oscillation.halaszCountConstant._proof_3
#print axioms Legendre.Density.Oscillation.halaszCountConstant_pos
#print axioms Legendre.Density.Oscillation.halaszLargeValueBound._proof_1
#print axioms Legendre.Density.Oscillation.halaszLargeValueBound._proof_2
#print axioms Legendre.Density.Oscillation.halaszLargeValueBound._proof_3
#print axioms Legendre.Density.Oscillation.halaszLargeValueBound.eq_1
#print axioms Legendre.Density.Oscillation.halaszLargeValueBound_nonneg
#print axioms Legendre.Density.Oscillation.halaszLargeValueBound_two_term
#print axioms Legendre.Density.Oscillation.halaszRealPartCost._proof_1
#print axioms Legendre.Density.Oscillation.halaszRealPartCost.eq_1
#print axioms Legendre.Density.Oscillation.halaszRealPartCost_pos
#print axioms Legendre.Density.Oscillation.halasz_block_complex_centered
#print axioms Legendre.Density.Oscillation.halasz_complex_card_of_scale
#print axioms Legendre.Density.Oscillation.halasz_complex_large_values
#print axioms Legendre.Density.Oscillation.halasz_complex_large_values_two_term
#print axioms Legendre.Density.Oscillation.halasz_complex_sparse_count
#print axioms Legendre.Density.Oscillation.halasz_complex_window_count
#print axioms Legendre.Density.Oscillation.halasz_scale_absorbs
#print axioms Legendre.Density.Oscillation.halasz_window_overhead
#print axioms Legendre.Density.Oscillation.heightBin_centered
#print axioms Legendre.Density.Oscillation.heightBin_cover
#print axioms Legendre.Density.Oscillation.heightBin_subset
#print axioms Legendre.Density.Oscillation.height_subdivision_card
#print axioms Legendre.Density.Oscillation.norm_nat_imaginary_cpow
#print axioms Legendre.Density.Oscillation.one_le_halaszAbsorptionScale
#print axioms Legendre.Density.Oscillation.ordinateTwist.eq_1
#print axioms Legendre.Density.Oscillation.ordinateTwist_energy
#print axioms Legendre.Density.Oscillation.ordinateTwist_norm
#print axioms Legendre.Literature.layer4_actual_halasz_large_values_comparator
#audit_private_axioms "_private.Legendre.Layer4.Exponential.BoundedCriticalBlocks.0.Legendre.Density.Oscillation.critical_block_energy_le_one._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.BoundedCriticalBlocks.0.Legendre.Density.Oscillation.critical_block_energy_le_one._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.BoundedCriticalBlocks.0.Legendre.Density.Oscillation.critical_polynomial_blocks._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.BoundedCriticalBlocks.0.Legendre.Density.Oscillation.exists_large_block._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.CriticalBlockCount.0.Legendre.Density.Oscillation.critical_threshold_compare._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.CriticalPolynomialCount.0.Legendre.Density.Oscillation.critical_polynomial_count._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszPointwise.0.Legendre.Density.Oscillation.complex_block_pointwise_sq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszPointwise.0.Legendre.Density.Oscillation.complex_block_pointwise_sq._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTranslation.0.Legendre.Density.Oscillation.halasz_block_complex_centered._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTwoTermCount.0.Legendre.Density.Oscillation.halaszLargeValueBound_two_term._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTwoTermCount.0.Legendre.Density.Oscillation.halaszLargeValueBound_two_term._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTwoTermCount.0.Legendre.Density.Oscillation.halaszLargeValueBound_two_term._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTwoTermCount.0.Legendre.Density.Oscillation.halaszLargeValueBound_two_term._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTwoTermCount.0.Legendre.Density.Oscillation.halaszLargeValueBound_two_term._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTwoTermCount.0.Legendre.Density.Oscillation.halaszLargeValueBound_two_term._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTwoTermCount.0.Legendre.Density.Oscillation.halaszLargeValueBound_two_term._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HalaszTwoTermCount.0.Legendre.Density.Oscillation.halaszLargeValueBound_two_term._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.HeightSubdivision.0.Legendre.Density.Oscillation.heightBin_cover._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.FiniteDyadicMoment.0.Legendre.Density.Moment.finite_dyadic_second_moment._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.FiniteDyadicMoment.0.Legendre.Density.Moment.finite_dyadic_second_moment._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.FiniteDyadicMoment.0.Legendre.Density.Moment.finite_dyadic_second_moment._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.FiniteDyadicMoment.0.Legendre.Density.Moment.finite_dyadic_second_moment._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.FiniteDyadicMoment.0.Legendre.Density.Moment.finite_dyadic_second_moment._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.FiniteDyadicMoment.0.Legendre.Density.Moment.finite_dyadic_second_moment._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.FiniteDyadicMoment.0.Legendre.Density.Moment.finite_dyadic_second_moment._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.FiniteDyadicMoment.0.Legendre.Density.Moment.finite_dyadic_second_moment._simp_1_8"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Oscillation.halaszLargeValueBound.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_balanced_moment_cutoff_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_dyadic_amplitude_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_halasz_empty_polynomial_count_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_halasz_packed_height_two_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_halasz_shifted_mollifier_head_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_halasz_zero_energy_count_consumer"

-- Global 12/5 density: every new public, private and generated theorem.
#print axioms Legendre.Density.Moment.count_le_of_rpow_log_bound
#print axioms Legendre.Density.Moment.critical_integral_count_lower
#print axioms Legendre.Density.Moment.detectorBalanceExponent.eq_1
#print axioms Legendre.Density.Moment.divisor_block_energy_cubic
#print axioms Legendre.Density.Moment.divisor_block_energy_linear
#print axioms Legendre.Density.Moment.exists_large_dyadic_piece
#print axioms Legendre.Density.Moment.halaszUniformCoverConstant._proof_1
#print axioms Legendre.Density.Moment.halaszUniformCoverConstant._proof_2
#print axioms Legendre.Density.Moment.halaszUniformCoverConstant_pos
#print axioms Legendre.Density.Moment.halaszUniformMomentConstant._proof_1
#print axioms Legendre.Density.Moment.halaszUniformMomentConstant_ge_four
#print axioms Legendre.Density.Moment.halasz_divisor_block_count
#print axioms Legendre.Density.Moment.halasz_moment_square
#print axioms Legendre.Density.Moment.halasz_reciprocal_threshold
#print axioms Legendre.Density.Moment.halasz_uniform_cover
#print axioms Legendre.Density.Moment.halasz_uniform_fractional_cost
#print axioms Legendre.Density.Moment.halasz_uniform_kernel_cost
#print axioms Legendre.Density.Moment.halasz_uniform_moment_cost
#print axioms Legendre.Density.Moment.height_log_costs
#print axioms Legendre.Density.Moment.huxleyBalanceDenominator._proof_1
#print axioms Legendre.Density.Moment.huxleyDetectorExponent._proof_1
#print axioms Legendre.Density.Moment.huxleyDetectorExponent._proof_2
#print axioms Legendre.Density.Moment.huxley_book_exponent_bounds
#print axioms Legendre.Density.Moment.huxley_book_exponent_le_one
#print axioms Legendre.Density.Moment.huxley_denominator_pos
#print axioms Legendre.Density.Moment.huxley_detector_exponent_bounds
#print axioms Legendre.Density.Moment.huxley_detector_scale
#print axioms Legendre.Density.Moment.huxley_height_shell_power_log
#print axioms Legendre.Density.Moment.huxley_integer_cutoffs
#print axioms Legendre.Density.Moment.huxley_integral_exponents
#print axioms Legendre.Density.Moment.huxley_integral_power_bounds
#print axioms Legendre.Density.Moment.huxley_mollifier_exponent_bounds
#print axioms Legendre.Density.Moment.huxley_polynomial_exponents
#print axioms Legendre.Density.Moment.huxley_polynomial_powers
#print axioms Legendre.Density.Moment.huxley_separated_high_density
#print axioms Legendre.Density.Moment.huxley_separated_high_shell_density
#print axioms Legendre.Density.Moment.integral_alternative_halasz_dichotomy
#print axioms Legendre.Density.Moment.integral_alternative_huxley_balanced
#print axioms Legendre.Density.Moment.mixed_power_count_dichotomy
#print axioms Legendre.Density.Moment.polynomialHalaszConstant._proof_1
#print axioms Legendre.Density.Moment.polynomialHalaszConstant._proof_2
#print axioms Legendre.Density.Moment.polynomialHalaszConstant._proof_3
#print axioms Legendre.Density.Moment.polynomialHalaszConstant_pos
#print axioms Legendre.Density.Moment.polynomial_alternative_halasz_count
#print axioms Legendre.Density.Moment.polynomial_alternative_huxley_balanced
#print axioms Legendre.Density.Moment.polynomial_halasz_actual_block
#print axioms Legendre.Density.Moment.real_rpow_square
#print axioms Legendre.Literature.layer4_huxley_global_comparator
#print axioms Legendre.Zeta.hasZeroDensityEstimate_twelve_fifths
#print axioms Legendre.Zeta.huxley_book_density_log_bound
#print axioms Legendre.Zeta.huxley_global_density_log_bound
#print axioms Legendre.Zeta.ingham_exponent_le_twelve_fifths
#audit_private_axioms "_private.Legendre.Layer4.HalaszDivisorBlock.0.Legendre.Density.Moment.halasz_divisor_block_count._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HalaszIntegralAlternative.0.Legendre.Density.Moment.critical_integral_count_lower._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPolynomialAlternative.0.Legendre.Density.Moment.exists_large_dyadic_piece._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPolynomialAlternative.0.Legendre.Density.Moment.exists_large_dyadic_piece._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPolynomialAlternative.0.Legendre.Density.Moment.exists_large_dyadic_piece._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPolynomialAlternative.0.Legendre.Density.Moment.exists_large_dyadic_piece._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPolynomialAlternative.0.Legendre.Density.Moment.exists_large_dyadic_piece._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPolynomialAlternative.0.Legendre.Density.Moment.exists_large_dyadic_piece._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPolynomialAlternative.0.Legendre.Density.Moment.exists_large_dyadic_piece._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPolynomialAlternative.0.Legendre.Density.Moment.exists_large_dyadic_piece._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_integral_exponents._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_integral_exponents._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_integral_exponents._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_integral_exponents._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_integral_exponents._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_integral_exponents._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_integral_exponents._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_polynomial_exponents._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_polynomial_exponents._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_polynomial_exponents._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_polynomial_exponents._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_polynomial_exponents._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_polynomial_exponents._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyBalance.0.Legendre.Density.Moment.huxley_polynomial_exponents._simp_1_7"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.huxleyBalanceDenominator.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.huxleyBookExponent.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.huxleyDetectorExponent.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.huxleyMollifierExponent.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_balance_one_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_balance_three_quarters_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_height_two_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_integer_cutoff_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_nine_tenths_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_principal_pole_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_sigma_one_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_three_quarters_consumer"

-- Small mollifiers, exact convolution powers and independent edge-case consumers.
#print axioms Legendre.Density.Detector.finiteSeries.eq_1
#print axioms Legendre.Density.Moment.DivisorGrowth.divisors_card_le_rpow
#print axioms Legendre.Density.Moment.DivisorGrowth.divisors_card_pow_le_rpow
#print axioms Legendre.Density.Moment.DivisorGrowth.exists_linear_le_geometric
#print axioms Legendre.Density.Moment.DivisorGrowth.exponent_succ_le_two_pow
#print axioms Legendre.Density.Moment.DivisorGrowth.prime_local_divisor_bounds
#print axioms Legendre.Density.Moment.DivisorGrowth.prod_prime_factor_rpow
#print axioms Legendre.Density.Moment.DivisorGrowth.small_prime_cost_le
#print axioms Legendre.Density.Moment.DivisorGrowth.two_pow_primeFactors_card_le_divisors_card
#print axioms Legendre.Density.Moment.Powers.LSeries_power
#print axioms Legendre.Density.Moment.Powers.blockArithmeticCoefficient._proof_1
#print axioms Legendre.Density.Moment.Powers.blockArithmeticCoefficient.eq_1
#print axioms Legendre.Density.Moment.Powers.blockArithmeticCoefficient_apply
#print axioms Legendre.Density.Moment.Powers.blockArithmeticCoefficient_below
#print axioms Legendre.Density.Moment.Powers.blockArithmeticCoefficient_norm
#print axioms Legendre.Density.Moment.Powers.blockArithmeticCoefficient_support
#print axioms Legendre.Density.Moment.Powers.block_finiteSeries
#print axioms Legendre.Density.Moment.Powers.block_polynomial_power
#print axioms Legendre.Density.Moment.Powers.bounded_powers_coefficients_subpower
#print axioms Legendre.Density.Moment.Powers.convolution_divisor_norm
#print axioms Legendre.Density.Moment.Powers.convolution_support
#print axioms Legendre.Density.Moment.Powers.convolution_vanish_below
#print axioms Legendre.Density.Moment.Powers.divisors_card_mono_of_dvd
#print axioms Legendre.Density.Moment.Powers.exists_large_powered_block
#print axioms Legendre.Density.Moment.Powers.finiteSeries_power
#print axioms Legendre.Density.Moment.Powers.finite_support_summable
#print axioms Legendre.Density.Moment.Powers.positive_power_vanish_below
#print axioms Legendre.Density.Moment.Powers.power_coefficients_subpower
#print axioms Legendre.Density.Moment.Powers.power_divisor_norm
#print axioms Legendre.Density.Moment.Powers.power_support
#print axioms Legendre.Density.Moment.Powers.powered_block_dyadic_decomposition
#print axioms Legendre.Density.Moment.actual_typeII_given_cutoff_count
#print axioms Legendre.Density.Moment.actual_typeII_small_mollifier_count
#print axioms Legendre.Density.Moment.criticalWeightMassMajorant_pos
#print axioms Legendre.Density.Moment.critical_mass_individual_fourth
#print axioms Legendre.Density.Moment.huxleyCurvedExponent._proof_1
#print axioms Legendre.Density.Moment.huxleyPowerUpper._proof_1
#print axioms Legendre.Density.Moment.huxley_power_window_bounds
#print axioms Legendre.Density.Moment.huxley_power_window_exponents
#print axioms Legendre.Density.Moment.huxley_short_block_power
#print axioms Legendre.Density.Moment.integral_alternative_individual_fourth_count
#print axioms Legendre.Density.Moment.integral_alternative_small_cutoff_epsilon
#print axioms Legendre.Density.Moment.integral_alternative_sqrt_height_count
#print axioms Legendre.Density.Moment.small_integer_mollifier
#print axioms Legendre.Density.Moment.sqrt_detector_scale
#print axioms Legendre.Density.Moment.sum_critical_mass_fourth
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.BlockPolynomialPowers.0.Legendre.Density.Moment.Powers.blockArithmeticCoefficient_below._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.BlockPolynomialPowers.0.Legendre.Density.Moment.Powers.blockArithmeticCoefficient_below._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.BlockPolynomialPowers.0.Legendre.Density.Moment.Powers.blockArithmeticCoefficient_support._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.BlockPolynomialPowers.0.Legendre.Density.Moment.Powers.blockArithmeticCoefficient_support._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.BlockPolynomialPowers.0.Legendre.Density.Moment.Powers.block_finiteSeries._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.BlockPolynomialPowers.0.Legendre.Density.Moment.Powers.convolution_vanish_below._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.BlockPolynomialPowers.0.Legendre.Density.Moment.Powers.convolution_vanish_below._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.BlockPolynomialPowers.0.Legendre.Density.Moment.Powers.convolution_vanish_below._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.DivisorGrowth.0.Legendre.Density.Moment.DivisorGrowth.two_pow_primeFactors_card_le_divisors_card._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.DivisorGrowthLocal.0.Legendre.Density.Moment.DivisorGrowth.prime_local_divisor_bounds._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.PolynomialPowers.0.Legendre.Density.Moment.Powers.LSeries_power._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.PolynomialPowers.0.Legendre.Density.Moment.Powers.convolution_support._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.PolynomialPowers.0.Legendre.Density.Moment.Powers.finite_support_summable._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.PolynomialPowers.0.Legendre.Density.Moment.Powers.finite_support_summable._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.PolynomialPowers.0.Legendre.Density.Moment.Powers.finite_support_summable._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.PolynomialPowers.0.Legendre.Density.Moment.Powers.power_support._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Arithmetic.PoweredBlockDecomposition.0.Legendre.Density.Moment.Powers.powered_block_dyadic_decomposition._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPowerSelection.0.Legendre.Density.Moment.huxley_power_window_exponents._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPowerSelection.0.Legendre.Density.Moment.huxley_power_window_exponents._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPowerSelection.0.Legendre.Density.Moment.huxley_power_window_exponents._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPowerSelection.0.Legendre.Density.Moment.huxley_power_window_exponents._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPowerSelection.0.Legendre.Density.Moment.huxley_power_window_exponents._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPowerSelection.0.Legendre.Density.Moment.huxley_power_window_exponents._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPowerSelection.0.Legendre.Density.Moment.huxley_power_window_exponents._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPowerSelection.0.Legendre.Density.Moment.huxley_short_block_power._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.TypeIIIntegralCount.0.Legendre.Density.Moment.integral_alternative_individual_fourth_count._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.huxleyCurvedExponent.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.huxleyPowerLower.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.huxleyPowerUpper.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_convolution_power_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_empty_block_power_zero_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_power_exponents_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_power_window_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_huxley_short_power_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_individual_fourth_zero_cutoff_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_power_one_block_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_power_support_boundary_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_small_mollifier_zero_exponent_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_sqrt_detector_minimum_height_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_typeII_empty_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_uniform_power_coefficients_consumer"

-- Actual powered-block counts and restricted curved Huxley density.
#print axioms Legendre.Density.Moment.exists_one_add_log_pow_le_rpow
#print axioms Legendre.Density.Moment.halasz_powered_block_count
#print axioms Legendre.Density.Moment.halasz_powered_window_count
#print axioms Legendre.Density.Moment.halasz_scaled_divisor_block_count
#print axioms Legendre.Density.Moment.huxley_actual_tail_epsilon_count
#print axioms Legendre.Density.Moment.huxley_curved_exponent_bounds
#print axioms Legendre.Density.Moment.huxley_curved_separated_high_density
#print axioms Legendre.Density.Moment.huxley_curved_separated_high_shell_density
#print axioms Legendre.Density.Moment.huxley_powered_length_terms
#print axioms Legendre.Density.Moment.huxley_short_block_epsilon_count
#print axioms Legendre.Density.Moment.huxley_short_length_power
#print axioms Legendre.Density.Moment.powered_block_uniform_amplitude
#print axioms Legendre.Density.Moment.powered_length_log_bound
#print axioms Legendre.Literature.layer4_huxley_restricted_comparator
#print axioms Legendre.Zeta.huxley_curved_middle_density_epsilon
#print axioms Legendre.Zeta.huxley_curved_restricted_density_epsilon
#audit_private_axioms "_private.Legendre.Layer4.HalaszPoweredBlock.0.Legendre.Density.Moment.halasz_powered_block_count._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPoweredBlock.0.Legendre.Density.Moment.halasz_powered_block_count._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.HalaszPoweredBlock.0.Legendre.Density.Moment.halasz_powered_block_count._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPoweredCount.0.Legendre.Density.Moment.halasz_powered_window_count._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPoweredLengths.0.Legendre.Density.Moment.huxley_short_length_power._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPoweredLengths.0.Legendre.Density.Moment.huxley_short_length_power._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPoweredLengths.0.Legendre.Density.Moment.huxley_short_length_power._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPoweredLengths.0.Legendre.Density.Moment.huxley_short_length_power._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPoweredLengths.0.Legendre.Density.Moment.huxley_short_length_power._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPoweredLengths.0.Legendre.Density.Moment.huxley_short_length_power._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyPoweredLengths.0.Legendre.Density.Moment.huxley_short_length_power._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.HuxleyShortBlock.0.Legendre.Density.Moment.huxley_short_block_epsilon_count._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_curved_empty_short_block_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_curved_empty_short_block_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_curved_first_shell_empty_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_curved_five_sixths_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_curved_four_fifths_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_curved_height_two_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_curved_real_length_selection_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_curved_real_length_selection_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_one_add_log_zero_power_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_powered_amplitude_zero_budget_consumer"

-- Actual finite differencing and short logarithmic Weyl cancellation.
#print axioms Legendre.Density.Oscillation.Tools.averaged_columns_correlation_bound
#print axioms Legendre.Density.Oscillation.Tools.finite_complex_second_moment_bound
#print axioms Legendre.Density.Oscillation.Tools.finite_complex_second_moment_identity
#print axioms Legendre.Density.Oscillation.Tools.finite_complex_second_moment_normalized
#print axioms Legendre.Density.Oscillation.Tools.intervalZeroExtension.eq_1
#print axioms Legendre.Density.Oscillation.Tools.intervalZeroExtension_correlation
#print axioms Legendre.Density.Oscillation.Tools.intervalZeroExtension_sum
#print axioms Legendre.Density.Oscillation.Tools.interval_correlation_neg
#print axioms Legendre.Density.Oscillation.Tools.norm_sum_sq_le_card_mul_sum_norm_sq
#print axioms Legendre.Density.Oscillation.Tools.re_finset_sum
#print axioms Legendre.Density.Oscillation.Tools.sum_int_Icc_nat
#print axioms Legendre.Density.Oscillation.Tools.sum_shift_supported
#print axioms Legendre.Density.Oscillation.Tools.van_der_corput_interval
#print axioms Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact
#print axioms Legendre.Density.Oscillation.Tools.van_der_corput_interval_normalized
#print axioms Legendre.Density.Oscillation.Tools.van_der_corput_nat_interval
#print axioms Legendre.Density.Oscillation.logarithmicPhase_third_deriv
#print axioms Legendre.Density.Oscillation.logarithmicShiftConstant._proof_1
#print axioms Legendre.Density.Oscillation.logarithmicShiftConstant._proof_2
#print axioms Legendre.Density.Oscillation.logarithmicShiftConstant_pos
#print axioms Legendre.Density.Oscillation.logarithmicShiftFirst._proof_1
#print axioms Legendre.Density.Oscillation.logarithmicShiftFirst_deriv
#print axioms Legendre.Density.Oscillation.logarithmicShiftPhase.eq_1
#print axioms Legendre.Density.Oscillation.logarithmicShiftPhase_correlation
#print axioms Legendre.Density.Oscillation.logarithmicShiftPhase_deriv
#print axioms Legendre.Density.Oscillation.logarithmicShiftSecond_bounds
#print axioms Legendre.Density.Oscillation.logarithmicWeylConstant._proof_1
#print axioms Legendre.Density.Oscillation.logarithmicWeylConstant._proof_2
#print axioms Legendre.Density.Oscillation.logarithmicWeylConstant_pos
#print axioms Legendre.Density.Oscillation.logarithmic_block_weyl
#print axioms Legendre.Density.Oscillation.logarithmic_prefix_eq_block
#print axioms Legendre.Density.Oscillation.logarithmic_prefix_vdc_square
#print axioms Legendre.Density.Oscillation.logarithmic_prefix_weyl
#print axioms Legendre.Density.Oscillation.logarithmic_prefix_weyl_square
#print axioms Legendre.Density.Oscillation.logarithmic_shift_correlation_second
#print axioms Legendre.Density.Oscillation.logarithmic_shift_correlation_uniform
#print axioms Legendre.Density.Oscillation.logarithmic_shift_sum_second
#print axioms Legendre.Density.Oscillation.logarithmic_shift_uniform_budget
#print axioms Legendre.Density.Oscillation.logarithmic_weyl_square_budget
#print axioms Legendre.Literature.WeylShortSumBenchmark._proof_1
#print axioms Legendre.Literature.layer4_weyl_short_sum_comparator
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogDifferencing.0.Legendre.Density.Oscillation.logarithmic_prefix_eq_block._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogDifferencing.0.Legendre.Density.Oscillation.logarithmic_prefix_eq_block._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogDifferencing.0.Legendre.Density.Oscillation.logarithmic_prefix_eq_block._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogDifferencing.0.Legendre.Density.Oscillation.logarithmic_prefix_eq_block._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogDifferencing.0.Legendre.Density.Oscillation.logarithmic_prefix_eq_block._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogDifferencing.0.Legendre.Density.Oscillation.logarithmic_prefix_eq_block._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogDifferencing.0.Legendre.Density.Oscillation.logarithmic_prefix_eq_block._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftCorrelation.0.Legendre.Density.Oscillation.logarithmic_shift_sum_second._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftCorrelation.0.Legendre.Density.Oscillation.logarithmic_shift_sum_second._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftDerivatives.0.Legendre.Density.Oscillation.logarithmicPhase_third_deriv._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftDerivatives.0.Legendre.Density.Oscillation.logarithmicPhase_third_deriv._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftDerivatives.0.Legendre.Density.Oscillation.logarithmicPhase_third_deriv._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftDerivatives.0.Legendre.Density.Oscillation.logarithmicPhase_third_deriv._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftDerivatives.0.Legendre.Density.Oscillation.logarithmicPhase_third_deriv._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftDerivatives.0.Legendre.Density.Oscillation.logarithmicPhase_third_deriv._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogShiftDerivatives.0.Legendre.Density.Oscillation.logarithmicPhase_third_deriv._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.LogWeyl.0.Legendre.Density.Oscillation.logarithmic_block_weyl._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.intervalZeroExtension_correlation._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.intervalZeroExtension_correlation._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.intervalZeroExtension_correlation._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.intervalZeroExtension_correlation._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.intervalZeroExtension_correlation._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.intervalZeroExtension_correlation._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.sum_int_Icc_nat._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.sum_int_Icc_nat._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.sum_int_Icc_nat._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.van_der_corput_nat_interval._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.van_der_corput_nat_interval._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.van_der_corput_nat_interval._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.van_der_corput_nat_interval._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.van_der_corput_nat_interval._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.NaturalDifferencing.0.Legendre.Density.Oscillation.Tools.van_der_corput_nat_interval._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.interval_correlation_neg._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.interval_correlation_neg._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.sum_shift_supported._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.sum_shift_supported._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.sum_shift_supported._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.sum_shift_supported._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._simp_1_11"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._simp_1_12"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._simp_1_13"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._simp_1_14"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_exact._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_normalized._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.VanDerCorput.0.Legendre.Density.Oscillation.Tools.van_der_corput_interval_normalized._proof_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_differencing_empty_support_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_differencing_full_shift_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_log_shift_zero_derivative_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_vdc_unit_shift_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_vdc_zero_length_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weyl_empty_block_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weyl_length_boundary_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weyl_negative_height_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weyl_zero_overlap_consumer"

-- Real-part weights, general-length Weyl and the actual linear-scale Type II count.
#print axioms Legendre.Density.Moment.actual_typeII_linear_cutoff_epsilon
#print axioms Legendre.Density.Moment.integral_alternative_linear_cutoff_epsilon
#print axioms Legendre.Density.Moment.integral_alternative_linear_height_count
#print axioms Legendre.Density.Moment.linear_detector_scale
#print axioms Legendre.Density.Oscillation.logarithmic_block_general_weyl
#print axioms Legendre.Density.Oscillation.logarithmic_block_weighted_weyl
#print axioms Legendre.Density.Oscillation.logarithmic_prefix_general_weyl_square
#print axioms Legendre.Density.Oscillation.logarithmic_weyl_general_square_budget
#print axioms Legendre.Density.Oscillation.norm_sum_range_smul_antitone
#print axioms Legendre.Density.Oscillation.real_weight_cpow
#print axioms Legendre.Density.Oscillation.sum_range_offset_eq_Ioc
#print axioms Legendre.Density.Oscillation.sum_range_weight_drop
#print axioms Legendre.Literature.layer4_general_weyl_comparator
#print axioms Legendre.Literature.layer4_weighted_weyl_comparator
#audit_private_axioms "_private.Legendre.Layer4.Exponential.GeneralLogWeyl.0.Legendre.Density.Oscillation.logarithmic_block_general_weyl._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneWeights.0.Legendre.Density.Oscillation.norm_sum_range_smul_antitone._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneWeights.0.Legendre.Density.Oscillation.sum_range_offset_eq_Ioc._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneWeights.0.Legendre.Density.Oscillation.sum_range_offset_eq_Ioc._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneWeights.0.Legendre.Density.Oscillation.sum_range_offset_eq_Ioc._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneWeights.0.Legendre.Density.Oscillation.sum_range_offset_eq_Ioc._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.MonotoneWeights.0.Legendre.Density.Oscillation.sum_range_offset_eq_Ioc._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogWeyl.0.Legendre.Density.Oscillation.logarithmic_block_weighted_weyl._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogWeyl.0.Legendre.Density.Oscillation.logarithmic_block_weighted_weyl._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogWeyl.0.Legendre.Density.Oscillation.logarithmic_block_weighted_weyl._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogWeyl.0.Legendre.Density.Oscillation.logarithmic_block_weighted_weyl._proof_1_4"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_general_weyl_long_block_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_linear_detector_scale_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_linear_typeII_negative_exponent_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_linear_typeII_three_quarters_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_linear_typeII_zero_cutoff_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_monotone_weights_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weighted_weyl_critical_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weighted_weyl_empty_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_weighted_weyl_three_quarters_consumer"

-- Exact Mobius divisor blocks, smoothing, pointwise cancellation and upper window parameters.
#print axioms Legendre.Density.Detector.Smooth.complex_block_norm_term
#print axioms Legendre.Density.Detector.Smooth.complex_prefix_extra_endpoint
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_block_expansion
#print axioms Legendre.Density.Detector.Smooth.detectorCoefficient_divisibility_sum
#print axioms Legendre.Density.Detector.Smooth.detectorWeight_eq_real
#print axioms Legendre.Density.Detector.Smooth.divided_block_endpoints
#print axioms Legendre.Density.Detector.Smooth.divided_real_part_weight
#print axioms Legendre.Density.Detector.Smooth.mobiusCutoff.eq_1
#print axioms Legendre.Density.Detector.Smooth.norm_dilated_smoothed_block
#print axioms Legendre.Density.Detector.Smooth.norm_smoothed_block_of_prefix
#print axioms Legendre.Density.Detector.Smooth.polynomial_block_divisor_expansion
#print axioms Legendre.Density.Detector.Smooth.polynomial_block_general_weyl
#print axioms Legendre.Density.Detector.Smooth.polynomial_block_of_prefix_bound
#print axioms Legendre.Density.Detector.Smooth.polynomial_block_second_derivative
#print axioms Legendre.Density.Detector.Smooth.realDetectorWeight._proof_1
#print axioms Legendre.Density.Detector.Smooth.realDetectorWeight.eq_1
#print axioms Legendre.Density.Detector.Smooth.realDetectorWeight_antitone
#print axioms Legendre.Density.Detector.Smooth.realDetectorWeight_le_one
#print axioms Legendre.Density.Detector.Smooth.realDetectorWeight_nonneg
#print axioms Legendre.Density.Detector.Smooth.sum_Ioc_divisible
#print axioms Legendre.Density.Moment.huxleyShortCutoff._proof_1
#print axioms Legendre.Density.Moment.huxley_general_short_power
#print axioms Legendre.Density.Moment.huxley_general_window_bounds
#print axioms Legendre.Density.Moment.huxley_short_cutoff_bounds
#print axioms Legendre.Density.Moment.huxley_short_cutoff_eq
#print axioms Legendre.Density.Moment.huxley_upper_exponent_margins
#print axioms Legendre.Density.Oscillation.generalWeylCost._proof_1
#print axioms Legendre.Density.Oscillation.generalWeylCost._proof_2
#print axioms Legendre.Density.Oscillation.generalWeylCost._proof_3
#print axioms Legendre.Density.Oscillation.generalWeylCost_mono
#print axioms Legendre.Density.Oscillation.generalWeylCost_nonneg
#print axioms Legendre.Density.Oscillation.logarithmic_block_general_weighted
#print axioms Legendre.Density.Oscillation.logarithmic_block_second_weighted
#print axioms Legendre.Density.Oscillation.norm_complex_block_of_prefix
#print axioms Legendre.Density.Oscillation.norm_sum_Ioc_smul_antitone
#print axioms Legendre.Density.Oscillation.secondDerivativeCost_mono
#print axioms Legendre.Density.Oscillation.secondDerivativeCost_nonneg
#print axioms Legendre.Literature.layer4_actual_mobius_pointwise_comparator
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.complex_prefix_extra_endpoint._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.complex_prefix_extra_endpoint._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.complex_prefix_extra_endpoint._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.complex_prefix_extra_endpoint._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.divided_block_endpoints._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.divided_real_part_weight._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.norm_dilated_smoothed_block._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.norm_dilated_smoothed_block._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.norm_dilated_smoothed_block._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.norm_dilated_smoothed_block._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.norm_dilated_smoothed_block._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.norm_dilated_smoothed_block._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDividedPrefixes.0.Legendre.Density.Detector.Smooth.norm_dilated_smoothed_block._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDivisorBlocks.0.Legendre.Density.Detector.Smooth.detectorCoefficient_divisibility_sum._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDivisorBlocks.0.Legendre.Density.Detector.Smooth.detectorCoefficient_divisibility_sum._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DetectorDivisorBlocks.0.Legendre.Density.Detector.Smooth.detectorCoefficient_divisibility_sum._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DetectorMobiusPointwise.0.Legendre.Density.Detector.Smooth.polynomial_block_of_prefix_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DetectorMobiusPointwise.0.Legendre.Density.Detector.Smooth.polynomial_block_of_prefix_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogBlocks.0.Legendre.Density.Oscillation.norm_complex_block_of_prefix._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogBlocks.0.Legendre.Density.Oscillation.norm_complex_block_of_prefix._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogBlocks.0.Legendre.Density.Oscillation.norm_sum_Ioc_smul_antitone._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogBlocks.0.Legendre.Density.Oscillation.norm_sum_Ioc_smul_antitone._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogBlocks.0.Legendre.Density.Oscillation.norm_sum_Ioc_smul_antitone._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogBlocks.0.Legendre.Density.Oscillation.norm_sum_Ioc_smul_antitone._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.Exponential.WeightedLogBlocks.0.Legendre.Density.Oscillation.norm_sum_Ioc_smul_antitone._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_general_short_power._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_short_cutoff_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_short_cutoff_eq._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_short_cutoff_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_short_cutoff_eq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_short_cutoff_eq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_short_cutoff_eq._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_short_cutoff_eq._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_upper_exponent_margins._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_upper_exponent_margins._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_upper_exponent_margins._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_upper_exponent_margins._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_upper_exponent_margins._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_upper_exponent_margins._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyParameters.0.Legendre.Density.Moment.huxley_upper_exponent_margins._simp_1_7"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.Moment.huxleyShortCutoff.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_actual_mobius_second_negative_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_actual_mobius_weyl_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_divided_weight_remainder_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_divisor_extra_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_mobius_zero_cutoff_expansion_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_smoothed_cancelling_pair_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_upper_cutoff_endpoints_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_upper_margin_nine_tenths_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_upper_short_power_one_consumer"

-- Upper-range actual Type I count and its independent consumers.
#print axioms Legendre.Density.Moment.height_monomial_le
#print axioms Legendre.Density.Moment.huxley_actual_long_block_decay
#print axioms Legendre.Density.Moment.huxley_long_blocks_below_threshold
#print axioms Legendre.Density.Moment.huxley_long_cost_decay
#print axioms Legendre.Density.Moment.huxley_long_power_bounds
#print axioms Legendre.Density.Moment.huxley_medium_cost_decay
#print axioms Legendre.Density.Moment.huxley_medium_power_bounds
#print axioms Legendre.Density.Moment.huxley_upper_actual_tail_epsilon_count
#print axioms Legendre.Density.Moment.huxley_varying_cutoff_length_power
#print axioms Legendre.Density.Moment.huxley_varying_short_block_epsilon_count
#print axioms Legendre.Density.Moment.huxley_window_block_epsilon_count
#print axioms Legendre.Density.Moment.shell_negative_power
#print axioms Legendre.Density.Moment.shell_ratio_power
#print axioms Legendre.Density.Moment.shell_reciprocal_power
#print axioms Legendre.Literature.UpperHuxleyTypeIBenchmark._proof_1
#print axioms Legendre.Literature.UpperHuxleyTypeIBenchmark._proof_2
#print axioms Legendre.Literature.layer4_upper_typeI_comparator
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyShortBlocks.0.Legendre.Density.Moment.huxley_varying_cutoff_length_power._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyShortBlocks.0.Legendre.Density.Moment.huxley_varying_cutoff_length_power._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyShortBlocks.0.Legendre.Density.Moment.huxley_varying_cutoff_length_power._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyShortBlocks.0.Legendre.Density.Moment.huxley_varying_cutoff_length_power._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyShortBlocks.0.Legendre.Density.Moment.huxley_varying_cutoff_length_power._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyShortBlocks.0.Legendre.Density.Moment.huxley_varying_cutoff_length_power._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyShortBlocks.0.Legendre.Density.Moment.huxley_varying_cutoff_length_power._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyShortBlocks.0.Legendre.Density.Moment.huxley_varying_short_block_epsilon_count._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.UpperHuxleyTail.0.Legendre.Density.Moment.huxley_upper_actual_tail_epsilon_count._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_shell_reciprocal_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_upper_negative_shell_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_upper_typeI_one_consumer"

-- Full curved Huxley density and independent boundary consumers.
#print axioms Legendre.Density.Moment.huxleyCurvedExponent.eq_1
#print axioms Legendre.Density.Moment.huxley_full_curved_exponent_bounds
#print axioms Legendre.Density.Moment.huxley_full_separated_high_density
#print axioms Legendre.Density.Moment.huxley_full_separated_high_shell_density
#print axioms Legendre.Density.Moment.huxley_transition_exponent_loss
#print axioms Legendre.Density.Moment.huxley_upper_separated_shell_density
#print axioms Legendre.Literature.layer4_huxley_comparator
#print axioms Legendre.Zeta.huxley_curved_density_epsilon
#print axioms Legendre.Zeta.huxley_curved_full_upper_density_epsilon
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_full_huxley_common_endpoints_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_full_huxley_height_two_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_full_huxley_transition_band_consumer"

-- Guth--Maynard outer ranges and the explicitly open central reduction.
#print axioms Legendre.Density.Moment.huxley_le_guth_maynard_upper
#print axioms Legendre.Density.Moment.ingham_le_guth_maynard_lower
#print axioms Legendre.Literature.GuthMaynard2024OuterDensity._proof_1
#print axioms Legendre.Literature.guthMaynard_density_iff_central
#print axioms Legendre.Literature.layer4_guth_maynard_outer_comparator
#print axioms Legendre.Zeta.guth_maynard_outer_density_epsilon
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_guth_middle_strict_gap_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_guth_outer_common_endpoints_consumer"

-- Finite Guth--Maynard sampling and trace dispersion, including all ported private/generated theorems.
#print axioms Legendre.Density.GuthMaynard.ApproxAddEnergy.eq_1
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.bounded
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.equals_one
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_iteratedFDeriv_bound
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.mk.inj
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.mk.injEq
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.mk.sizeOf_spec
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.nonneg
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.smooth
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.support
#print axioms Legendre.Density.GuthMaynard.Matrix.IsHermitian.l2_opNorm_le_eigenvalue
#print axioms Legendre.Density.GuthMaynard.Matrix.IsHermitian.trace_cube_eq_sum_eigenvalues_cube
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_eq_zero_of_neg
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_le_card_pow_four
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_mono
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_nonneg
#print axioms Legendre.Density.GuthMaynard.approximateAdditiveQuadruples.eq_1
#print axioms Legendre.Density.GuthMaynard.approximateAdditiveQuadruples_mono
#print axioms Legendre.Density.GuthMaynard.card_sq_le_approxAddEnergy
#print axioms Legendre.Density.GuthMaynard.convolution_support
#print axioms Legendre.Density.GuthMaynard.coordinate_le_trace_dispersion
#print axioms Legendre.Density.GuthMaynard.coordinate_sixth_le_trace_dispersion_max
#print axioms Legendre.Density.GuthMaynard.dirichletPoly_translate
#print axioms Legendre.Density.GuthMaynard.dyadicInterval.eq_1
#print axioms Legendre.Density.GuthMaynard.exists_gmMatrixOperatorNorm_le_singularValue
#print axioms Legendre.Density.GuthMaynard.exists_gmSmoothCutoff
#print axioms Legendre.Density.GuthMaynard.gmCoefficientVector.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCoefficient_energy_le
#print axioms Legendre.Density.GuthMaynard.gmCubicSpectralDispersion.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSpectralDispersion_eq_trace
#print axioms Legendre.Density.GuthMaynard.gmCubicSpectralDispersion_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCutoffColumnMass.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCutoffColumnMass_le
#print axioms Legendre.Density.GuthMaynard.gmCutoffColumnMass_nonneg
#print axioms Legendre.Density.GuthMaynard.gmDyadicInterval_card
#print axioms Legendre.Density.GuthMaynard.gmMatrix.eq_1
#print axioms Legendre.Density.GuthMaynard.gmMatrixEntry.eq_1
#print axioms Legendre.Density.GuthMaynard.gmMatrixOperatorNorm.eq_1
#print axioms Legendre.Density.GuthMaynard.gmMatrixSingularValue_nonneg
#print axioms Legendre.Density.GuthMaynard.gmMatrixSingularValue_sixth
#print axioms Legendre.Density.GuthMaynard.gmMatrixSingularValue_sq
#print axioms Legendre.Density.GuthMaynard.gmMatrix_energy_le_operatorNorm
#print axioms Legendre.Density.GuthMaynard.gmMatrix_first_spectral_moment_eq
#print axioms Legendre.Density.GuthMaynard.gmMatrix_first_spectral_moment_le
#print axioms Legendre.Density.GuthMaynard.gmMatrix_first_spectral_moment_nonneg
#print axioms Legendre.Density.GuthMaynard.gmMatrix_gram_apply_eq_phase_sum
#print axioms Legendre.Density.GuthMaynard.gmMatrix_gram_eigenvalue_nonneg
#print axioms Legendre.Density.GuthMaynard.gmMatrix_gram_isHermitian
#print axioms Legendre.Density.GuthMaynard.gmMatrix_gram_posSemidef
#print axioms Legendre.Density.GuthMaynard.gmMatrix_gram_trace_eq_cutoff_sum
#print axioms Legendre.Density.GuthMaynard.gmMatrix_gram_trace_expand
#print axioms Legendre.Density.GuthMaynard.gmMatrix_mulVec_apply
#print axioms Legendre.Density.GuthMaynard.gmMatrix_mul_conjTranspose_apply
#print axioms Legendre.Density.GuthMaynard.gmMatrix_operatorNorm_le_trace_dispersion
#print axioms Legendre.Density.GuthMaynard.gmMatrix_operatorNorm_sixth_le_dispersion
#print axioms Legendre.Density.GuthMaynard.gmMatrix_sample_energy_lower
#print axioms Legendre.Density.GuthMaynard.gmMatrix_singularValue_le_trace_dispersion
#print axioms Legendre.Density.GuthMaynard.gmMatrix_singularValue_sixth_le_dispersion_max
#print axioms Legendre.Density.GuthMaynard.gmR.eq_1
#print axioms Legendre.Density.GuthMaynard.gmR_one
#print axioms Legendre.Density.GuthMaynard.gmR_reciprocal
#print axioms Legendre.Density.GuthMaynard.gmSmoothDirichletPoly.eq_1
#print axioms Legendre.Density.GuthMaynard.gm_largeValues_card_le_operatorNorm
#print axioms Legendre.Density.GuthMaynard.gm_largeValues_energy_dispersion
#print axioms Legendre.Density.GuthMaynard.gm_largeValues_raw_dispersion
#print axioms Legendre.Density.GuthMaynard.matrix_trace_cube_expand
#print axioms Legendre.Density.GuthMaynard.norm_conjugateCoeffs
#print axioms Legendre.Density.GuthMaynard.norm_gmR_le_card
#print axioms Legendre.Density.GuthMaynard.norm_gmR_reciprocal
#print axioms Legendre.Density.GuthMaynard.norm_normalizedCoeffs_le
#print axioms Legendre.Density.GuthMaynard.norm_phaseShiftCoeffs
#print axioms Legendre.Density.GuthMaynard.norm_sourceDirichletPoly_conjugateCoeffs
#print axioms Legendre.Density.GuthMaynard.phaseShiftCoeffs.eq_1
#print axioms Legendre.Density.GuthMaynard.publishedDyadicInterval.eq_1
#print axioms Legendre.Density.GuthMaynard.publishedSourceDirichletPoly.eq_1
#print axioms Legendre.Density.GuthMaynard.publishedSourceDirichletPoly_eq_left_add
#print axioms Legendre.Density.GuthMaynard.publishedSourceDirichletPoly_eq_source_of_left_eq_zero
#print axioms Legendre.Density.GuthMaynard.sixthMoment_dispersion_nonneg
#print axioms Legendre.Density.GuthMaynard.sixthMoment_tail_lower
#print axioms Legendre.Density.GuthMaynard.sixthRoot_cubic_bound
#print axioms Legendre.Density.GuthMaynard.sixthRoot_dispersion_bound
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly.eq_1
#print axioms Legendre.Literature.layer4_guth_sampling_trace_comparator
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Definitions.0.Legendre.Density.GuthMaynard.approximateAdditiveQuadruples_mono._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Definitions.0.Legendre.Density.GuthMaynard.approximateAdditiveQuadruples_mono._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Definitions.0.Legendre.Density.GuthMaynard.card_sq_le_approxAddEnergy._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Definitions.0.Legendre.Density.GuthMaynard.card_sq_le_approxAddEnergy._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Polynomial.0.Legendre.Density.GuthMaynard.dirichletPoly_translate._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Polynomial.0.Legendre.Density.GuthMaynard.norm_normalizedCoeffs_le._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Polynomial.0.Legendre.Density.GuthMaynard.norm_sourceDirichletPoly_conjugateCoeffs._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Polynomial.0.Legendre.Density.GuthMaynard.publishedSourceDirichletPoly_eq_left_add._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Polynomial.0.Legendre.Density.GuthMaynard.publishedSourceDirichletPoly_eq_left_add._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Polynomial.0.Legendre.Density.GuthMaynard.publishedSourceDirichletPoly_eq_left_add._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Polynomial.0.Legendre.Density.GuthMaynard.publishedSourceDirichletPoly_eq_left_add._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gmCubicSpectralDispersion_eq_trace._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gmDyadicInterval_card._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gm_largeValues_raw_dispersion._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gm_largeValues_raw_dispersion._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gm_largeValues_raw_dispersion._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gm_largeValues_raw_dispersion._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gm_largeValues_raw_dispersion._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gm_largeValues_raw_dispersion._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingDispersion.0.Legendre.Density.GuthMaynard.gm_largeValues_raw_dispersion._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMatrix.0.Legendre.Density.GuthMaynard.gmCoefficient_energy_le._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMatrix.0.Legendre.Density.GuthMaynard.gmMatrix_gram_apply_eq_phase_sum._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceDispersion.0.Legendre.Density.GuthMaynard.coordinate_sixth_le_trace_dispersion_max._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceDispersion.0.Legendre.Density.GuthMaynard.coordinate_sixth_le_trace_dispersion_max._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceDispersion.0.Legendre.Density.GuthMaynard.coordinate_sixth_le_trace_dispersion_max._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceDispersion.0.Legendre.Density.GuthMaynard.coordinate_sixth_le_trace_dispersion_max._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceDispersion.0.Legendre.Density.GuthMaynard.coordinate_sixth_le_trace_dispersion_max._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceDispersion.0.Legendre.Density.GuthMaynard.coordinate_sixth_le_trace_dispersion_max._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceDispersion.0.Legendre.Density.GuthMaynard.coordinate_sixth_le_trace_dispersion_max._simp_1_9"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.dyadicInterval.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.publishedDyadicInterval.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.publishedSourceDirichletPoly.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.sourceDirichletPoly.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_closed_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_flat_spectrum_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_negative_reciprocal_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_nonzero_matrix_consumer"

-- Poisson, complete reflection and cubic tail reductions: every new declaration.
#print axioms Complex.VerticalIntegrable.eq_1
#print axioms Legendre.Density.GuthMaynard.GMQuantitativeSmoothReflection._proof_1
#print axioms Legendre.Density.GuthMaynard.abs_sub_le_height_of_mem_baseInterval
#print axioms Legendre.Density.GuthMaynard.contDiff_gmMellinKernel
#print axioms Legendre.Density.GuthMaynard.contDiff_gmScaledTraceKernel
#print axioms Legendre.Density.GuthMaynard.contDiff_gmTraceKernel
#print axioms Legendre.Density.GuthMaynard.continuous_gmCutoffMellin
#print axioms Legendre.Density.GuthMaynard.continuous_gmReflectionDirichletPoly
#print axioms Legendre.Density.GuthMaynard.exists_gmReflectionScaleThreshold
#print axioms Legendre.Density.GuthMaynard.floorImage.eq_1
#print axioms Legendre.Density.GuthMaynard.floor_injective_on_of_separated
#print axioms Legendre.Density.GuthMaynard.gmCompleteSmoothReflection_bound_order
#print axioms Legendre.Density.GuthMaynard.gmCpowDerivativeCoeff_succ
#print axioms Legendre.Density.GuthMaynard.gmCpowDerivativeCoeff_zero
#print axioms Legendre.Density.GuthMaynard.gmCubicDiagonalMain.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicS1Summand.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicS1_estimate
#print axioms Legendre.Density.GuthMaynard.gmCubicS1_power_decay
#print axioms Legendre.Density.GuthMaynard.gmCubicS1_quantitative
#print axioms Legendre.Density.GuthMaynard.gmCubicS2FirstDiagonal_eq_difference_moment
#print axioms Legendre.Density.GuthMaynard.gmCubicS2FirstDiagonal_le_zeroModeConstant
#print axioms Legendre.Density.GuthMaynard.gmCubicS2FirstOffDiagonal_power_decay
#print axioms Legendre.Density.GuthMaynard.gmCubicS2FirstOffDiagonal_quantitative
#print axioms Legendre.Density.GuthMaynard.gmCubicS2FirstSummand_reflection_native
#print axioms Legendre.Density.GuthMaynard.gmCubicS2First_eq_diagonal_add_offDiagonal
#print axioms Legendre.Density.GuthMaynard.gmCubicS2SecondSummand_eq_first_cyclic
#print axioms Legendre.Density.GuthMaynard.gmCubicS2Second_sum_eq_first
#print axioms Legendre.Density.GuthMaynard.gmCubicS2ThirdSummand_eq_first_cyclic
#print axioms Legendre.Density.GuthMaynard.gmCubicS2Third_sum_eq_first
#print axioms Legendre.Density.GuthMaynard.gmCubicS2_eq_three_mul_first
#print axioms Legendre.Density.GuthMaynard.gmCubicZeroMode_eq_main_add_remainder
#print axioms Legendre.Density.GuthMaynard.gmCubicZeroMode_main_term
#print axioms Legendre.Density.GuthMaynard.gmCubicZeroRemainder_quantitative
#print axioms Legendre.Density.GuthMaynard.gmCutoffL2Sq.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCutoffMellin_eq_fourier
#print axioms Legendre.Density.GuthMaynard.gmCutoffMellin_polynomial_decay
#print axioms Legendre.Density.GuthMaynard.gmCutoffSq_eq_verticalMellinIntegral
#print axioms Legendre.Density.GuthMaynard.gmCutoffSq_mellinInversion
#print axioms Legendre.Density.GuthMaynard.gmMatrix_cubic_trace_moment_remainder
#print axioms Legendre.Density.GuthMaynard.gmMatrix_cubic_trace_poisson_expand
#print axioms Legendre.Density.GuthMaynard.gmMatrix_cubic_trace_split
#print axioms Legendre.Density.GuthMaynard.gmMatrix_cubic_trace_two_piece_remainder
#print axioms Legendre.Density.GuthMaynard.gmMatrix_gram_apply_eq_phase_mul_fourier_tsum
#print axioms Legendre.Density.GuthMaynard.gmMatrix_gram_trace_poisson_expand
#print axioms Legendre.Density.GuthMaynard.gmMatrix_hilbertSchmidt_trace_estimate
#print axioms Legendre.Density.GuthMaynard.gmMatrix_hilbertSchmidt_trace_estimate_hundred
#print axioms Legendre.Density.GuthMaynard.gmMellinKernel.eq_1
#print axioms Legendre.Density.GuthMaynard.gmMellinKernelSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmNegativeMellinCore_bound
#print axioms Legendre.Density.GuthMaynard.gmPositiveDualDirichletPoly.eq_1
#print axioms Legendre.Density.GuthMaynard.gmPositiveDualDirichletPoly_eq_scale_mul
#print axioms Legendre.Density.GuthMaynard.gmPositiveDualModeIntegrand.eq_1
#print axioms Legendre.Density.GuthMaynard.gmPositiveMellinCore_bound
#print axioms Legendre.Density.GuthMaynard.gmPositiveMellinTail_bound_order
#print axioms Legendre.Density.GuthMaynard.gmQuantitativeSmoothReflection_hundred
#print axioms Legendre.Density.GuthMaynard.gmQuantitativeSmoothReflection_native
#print axioms Legendre.Density.GuthMaynard.gmReflectionDecayOrder._proof_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionDecayOrder_budget
#print axioms Legendre.Density.GuthMaynard.gmReflectionDecayOrder_two_le
#print axioms Legendre.Density.GuthMaynard.gmReflectionDirichletPoly.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionEta._proof_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionEta.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionEta_le_one
#print axioms Legendre.Density.GuthMaynard.gmReflectionEta_lt_eps
#print axioms Legendre.Density.GuthMaynard.gmReflectionEta_pos
#print axioms Legendre.Density.GuthMaynard.gmReflectionFrequencyError_le
#print axioms Legendre.Density.GuthMaynard.gmReflectionHeight.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionIntegral._proof_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionIntegral.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionIntegral_eq_parts
#print axioms Legendre.Density.GuthMaynard.gmReflectionLength.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionLength_lower
#print axioms Legendre.Density.GuthMaynard.gmReflectionLength_pos
#print axioms Legendre.Density.GuthMaynard.gmReflectionLength_upper
#print axioms Legendre.Density.GuthMaynard.gmReflectionMellinError_le
#print axioms Legendre.Density.GuthMaynard.gmReflectionPrimitive.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionRatio.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionRatioReal.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReflectionRatio_mul_primitiveDeriv
#print axioms Legendre.Density.GuthMaynard.gmRescaledCutoffIntegral_eq_mellinReflection
#print axioms Legendre.Density.GuthMaynard.gmRetainedSignedReflection_bound_order
#print axioms Legendre.Density.GuthMaynard.gmScaledQuantitativeSmoothReflection_native
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceFourier_summable
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceKernel.eq_1
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceKernelSchwartz.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceKernelSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceKernel_fourier
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceKernel_poisson
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceMode.eq_1
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceMode_summable
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceMode_tsum_decompose
#print axioms Legendre.Density.GuthMaynard.gmSeparated_card_le_two_height
#print axioms Legendre.Density.GuthMaynard.gmSmoothCutoff_eq_zero_at_one
#print axioms Legendre.Density.GuthMaynard.gmSmoothCutoff_eq_zero_at_two
#print axioms Legendre.Density.GuthMaynard.gmSmoothCutoff_eq_zero_of_le_one
#print axioms Legendre.Density.GuthMaynard.gmSmoothCutoff_eq_zero_of_lt_one
#print axioms Legendre.Density.GuthMaynard.gmSmoothCutoff_eq_zero_of_two_le
#print axioms Legendre.Density.GuthMaynard.gmSmoothReflection_native
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier.eq_1
#print axioms Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed
#print axioms Legendre.Density.GuthMaynard.gmTraceFourierFarTail_bound_order
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_far_frequency_decay
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_fixed_t_decay
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_neg_eq_conj
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_neg_eq_mellinReflection
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_pos_eq_integral_dualMode
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_pos_eq_interval
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_pos_eq_mellinReflection
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_pos_eq_reflectedMode
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_pos_rescale
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_pos_sum_eq_integral_dualPoly
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_pos_sum_eq_mellinReflection
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_summable
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_uniform_decay
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_zero_eq_mellin
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_zero_eq_mellinKernel_fourier
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_zero_nonzero_pointwise_bound
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_zero_nonzero_tail_bound
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay_source
#print axioms Legendre.Density.GuthMaynard.gmTraceFourier_zero_zero_eq_cutoffL2Sq
#print axioms Legendre.Density.GuthMaynard.gmTraceKernel.eq_1
#print axioms Legendre.Density.GuthMaynard.gmTraceKernelSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmTraceKernel_mellinInversion
#print axioms Legendre.Density.GuthMaynard.gmTraceKernel_poisson
#print axioms Legendre.Density.GuthMaynard.gmTraceKernel_tsum_eq_column_sum
#print axioms Legendre.Density.GuthMaynard.gmTraceKernel_tsum_eq_intBlock
#print axioms Legendre.Density.GuthMaynard.gmTraceKernel_uniform_iteratedFDeriv
#print axioms Legendre.Density.GuthMaynard.gmTraceKernel_zero_tsum_eq_column_sum
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_eq_source
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroFourierSum_eq_signed_add_far
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroFourierSum_neg_eq_conj
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroTail.eq_1
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt.eq_1
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_eq_scale_mul
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_neg_eq_star
#print axioms Legendre.Density.GuthMaynard.gmTraceZeroMode.eq_1
#print axioms Legendre.Density.GuthMaynard.gmTraceZeroMode_bound
#print axioms Legendre.Density.GuthMaynard.gmTraceZeroMode_separated_bound
#print axioms Legendre.Density.GuthMaynard.gmTraceZeroMode_zero
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmMellinKernel
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmScaledTraceKernel
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmTraceKernel
#print axioms Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPowerWeight
#print axioms Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive
#print axioms Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatio
#print axioms Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatioReal
#print axioms Legendre.Density.GuthMaynard.integrableOn_abs_rpow_compl_Icc
#print axioms Legendre.Density.GuthMaynard.integrable_gmPositiveDualModeIntegrand
#print axioms Legendre.Density.GuthMaynard.integrable_norm_gmPositiveDualAggregate
#print axioms Legendre.Density.GuthMaynard.integral_abs_rpow_compl_Icc
#print axioms Legendre.Density.GuthMaynard.integral_norm_gmReflectionDirichletPoly_comp_neg
#print axioms Legendre.Density.GuthMaynard.integral_norm_gmReflectionDirichletPoly_neg_time
#print axioms Legendre.Density.GuthMaynard.intervalIntegrable_gmReflectionIntegrand
#print axioms Legendre.Density.GuthMaynard.intervalIntegrable_norm_gmReflectionDirichletPoly
#print axioms Legendre.Density.GuthMaynard.iteratedDeriv_ofReal_cpow
#print axioms Legendre.Density.GuthMaynard.mellinConvergent_gmCutoffSq_one
#print axioms Legendre.Density.GuthMaynard.norm_conj_powerWeighted_gmReflectionIntegral_le
#print axioms Legendre.Density.GuthMaynard.norm_gmCpowDerivativeCoeff_le
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS2FirstDiagonal_le
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS2FirstSummand_diagonal
#print axioms Legendre.Density.GuthMaynard.norm_gmPositiveDualDirichletPoly_eq
#print axioms Legendre.Density.GuthMaynard.norm_gmPositiveDualDirichletPoly_le
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionDirichletPoly_neg_time
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_le_endpoint_variation
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_le_left
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_le_length_div
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_le_log
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_le_right
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_le_ten_div_sqrt
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_neg_core_le
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_pos_core_le
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionIntegrand
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionPowerWeight
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionPrimitive
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionRatio
#print axioms Legendre.Density.GuthMaynard.norm_gmSmoothReflection_native_le
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceFourier_neg_sum_le_dualPoly
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_le_mellinReflection
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_sum_le_dualPoly
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceFourier_signed_sum_le_dualPoly
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceNonzeroFourierSum_neg
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceNonzeroTailAt_eq
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceNonzeroTailAt_neg
#print axioms Legendre.Density.GuthMaynard.norm_iteratedDeriv_ofReal_cpow_mul_I_le
#print axioms Legendre.Density.GuthMaynard.norm_powerWeighted_gmReflectionIntegral_le
#print axioms Legendre.Density.GuthMaynard.norm_weighted_gmReflectionIntegral_le
#print axioms Legendre.Density.GuthMaynard.star_gmReflectionPowerWeight
#print axioms Legendre.Density.GuthMaynard.sum_gmPositiveDualModeIntegrand_eq
#print axioms Legendre.Density.GuthMaynard.verticalIntegrable_mellin_gmCutoffSq_one
#print axioms Legendre.Literature.layer4_guth_complete_reflection_comparator
#print axioms Legendre.Literature.layer4_guth_cubic_moment_comparator
#print axioms Legendre.Literature.layer4_guth_cubic_remainder_comparator
#print axioms Legendre.Literature.layer4_guth_first_trace_comparator
#print axioms Legendre.Literature.layer4_guth_uniform_fourier_comparator
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmCubicPhase_cancel"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmCubicZeroRemainder_quantitative._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmCubicZeroRemainder_quantitative._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmCubicZeroRemainder_quantitative._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmCubicZeroRemainder_quantitative._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmCubicZeroRemainder_quantitative._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmCubicZeroRemainder_quantitative._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmCubicZeroRemainder_quantitative._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmMatrix_cubic_trace_split._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmMatrix_gram_apply_eq_phase_mul_fourier_tsum._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmRow_difference_abs_le"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmRow_difference_separated"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmSeparated_card_le_two_height._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceKernel_eq_scaled_phase"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceKernel_tsum_eq_column_sum._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceKernel_tsum_eq_column_sum._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceKernel_tsum_eq_column_sum._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceKernel_tsum_eq_column_sum._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceKernel_tsum_eq_column_sum._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._simp_1_11"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTrace.0.Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_bound._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integrableOn_abs_rpow_compl_Icc._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integrableOn_abs_rpow_compl_Icc._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integrableOn_abs_rpow_compl_Icc._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integrableOn_abs_rpow_compl_Icc._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integrableOn_abs_rpow_compl_Icc._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integral_abs_rpow_compl_Icc._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integral_abs_rpow_compl_Icc._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integral_abs_rpow_compl_Icc._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integral_abs_rpow_compl_Icc._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PowerTail.0.Legendre.Density.GuthMaynard.integral_abs_rpow_compl_Icc._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmPositiveMellinTail_bound_order._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmPositiveMellinTail_bound_order._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmPositiveMellinTail_bound_order._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmPositiveMellinTail_bound_order._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmPositiveMellinTail_bound_order._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmPositiveMellinTail_bound_order._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmPositiveMellinTail_bound_order._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmReflectionDecayOrder_two_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmReflectionFrequencyError_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmReflectionFrequencyError_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmReflectionFrequencyError_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmReflectionFrequencyError_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmReflectionFrequencyError_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmReflectionFrequencyError_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmReflectionFrequencyError_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._proof_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._proof_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceFourierCentral_eq_signed._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceNonzeroFourierSum_eq_signed_add_far._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceNonzeroFourierSum_eq_signed_add_far._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceNonzeroFourierSum_eq_signed_add_far._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceNonzeroFourierSum_eq_signed_add_far._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.QuantitativeReflection.0.Legendre.Density.GuthMaynard.gmTraceNonzeroFourierSum_eq_signed_add_far._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmMatrix_hilbertSchmidt_trace_estimate._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmMatrix_hilbertSchmidt_trace_estimate._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmScaledTraceKernel_fourier._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmScaledTraceKernel_fourier._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmScaledTraceKernel_fourier._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmScaledTraceKernel_fourier._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmScaledTraceKernel_fourier._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmScaledTraceKernel_fourier._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmScaledTraceKernel_fourier._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_nonzero_pointwise_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_nonzero_tail_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_nonzero_tail_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay_source._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay_source._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay_source._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay_source._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay_source._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay_source._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceFourier_zero_uniform_decay_source._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceKernel_zero_tsum_eq_column_sum._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceKernel_zero_tsum_eq_column_sum._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceKernel_zero_tsum_eq_column_sum._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceKernel_zero_tsum_eq_column_sum._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TracePoisson.0.Legendre.Density.GuthMaynard.gmTraceKernel_zero_tsum_eq_column_sum._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.contDiffAt_ofReal_cpow_mul_I"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.contDiff_gmCutoffSqComplex"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffMellin_polynomial_decay._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffMellin_polynomial_decay._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffMellin_polynomial_decay._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffMellin_polynomial_decay._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffMellin_polynomial_decay._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffMellin_polynomial_decay._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffMellin_polynomial_decay._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffPhase_eq_mellinIntegral"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffPhase_eq_mellinIntegral._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffPhase_eq_mellinIntegral._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffPhase_eq_mellinIntegral._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffPhase_eq_mellinIntegral._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffPhase_eq_mellinIntegral._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffPhase_eq_mellinIntegral._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffPhase_eq_mellinIntegral._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffSqComplex.eq_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmCutoffSqSchwartz_apply"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmMellinReflectionIntegrand._proof_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmMellinReflectionIntegrand.eq_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmReflectionRatio_mul_primitiveDeriv._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmReflectionRatio_mul_primitiveDeriv._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmReflectionRatio_mul_primitiveDeriv._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmReflectionRatio_mul_primitiveDeriv._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmReflectionRatio_mul_primitiveDeriv._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmReflectionRatio_mul_primitiveDeriv._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmReflectionRatio_mul_primitiveDeriv._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmRescaledCutoffIntegral_eq_mellinReflection._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmRescaledCutoffIntegral_eq_mellinReflection._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmRescaledCutoffIntegral_eq_mellinReflection._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmRescaledCutoffIntegral_eq_mellinReflection._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmRescaledCutoffIntegral_eq_mellinReflection._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmRescaledCutoffIntegral_eq_mellinReflection._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmRescaledCutoffIntegral_eq_mellinReflection._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_far_frequency_decay._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_far_frequency_decay._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_far_frequency_decay._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_far_frequency_decay._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_far_frequency_decay._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_far_frequency_decay._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_far_frequency_decay._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_pos_rescale._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_pos_rescale._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_pos_rescale._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_pos_rescale._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_pos_rescale._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_pos_rescale._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceFourier_pos_rescale._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.gmTraceKernel_eq_cutoffSq_mul_cpow"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmCutoffSqComplex"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionPrimitive._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatio._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatio._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatio._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatio._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatio._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatio._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.hasDerivAt_gmReflectionRatio._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.integrable_gmMellinReflectionIntegrand"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.integral_norm_iteratedFDeriv_gmTraceKernel_le"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.intervalIntegral_gmMellinReflectionIntegrand_eq"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.intervalIntegral_gmMellinReflectionIntegrand_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.intervalIntegral_gmMellinReflectionIntegrand_eq._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.intervalIntegral_gmMellinReflectionIntegrand_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.intervalIntegral_gmMellinReflectionIntegrand_eq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.intervalIntegral_gmMellinReflectionIntegrand_eq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.intervalIntegral_gmMellinReflectionIntegrand_eq._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.intervalIntegral_gmMellinReflectionIntegrand_eq._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.mellinDerivativePower_le"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.norm_gmReflectionIntegral_le_ten_div_sqrt._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_le_mellinReflection._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_le_mellinReflection._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_le_mellinReflection._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_le_mellinReflection._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_le_mellinReflection._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_le_mellinReflection._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.TraceReflection.0.Legendre.Density.GuthMaynard.norm_gmTraceFourier_pos_le_mellinReflection._simp_1_7"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmCutoffL2Sq.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmReflectionEta.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmReflectionHeight.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmReflectionLength.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_complete_reflection_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_cutoff_endpoints_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_fourier_negative_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_full_tail_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_one_tail_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_packing_endpoints_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_packing_endpoints_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_packing_endpoints_consumer._simp_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_poisson_first_trace_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_reflection_ceil_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_reflection_reserve_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_symmetric_power_tail_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_uniform_fourier_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_zero_main_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_zero_mode_decay_consumer"

-- Heath--Brown actual difference-set mean square: all private/generated declarations.
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_lipschitzWith
#print axioms Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound
#print axioms Legendre.Density.GuthMaynard.HeathBrownDifferenceSetMeanSquare._proof_1
#print axioms Legendre.Density.GuthMaynard.HeathBrownDifferenceSetMeanSquare._proof_2
#print axioms Legendre.Density.GuthMaynard.HeathBrownDifferenceSetMeanSquare._proof_3
#print axioms Legendre.Density.GuthMaynard.abs_cot_half_le_norm_phaseResolvent
#print axioms Legendre.Density.GuthMaynard.abs_inv_log_sub_sub_div_le_one
#print axioms Legendre.Density.GuthMaynard.abs_log_ratio_le_one
#print axioms Legendre.Density.GuthMaynard.add_add_add_sq_le_four_mul_sum_sq
#print axioms Legendre.Density.GuthMaynard.add_four_sq_le_four_mul_sum_sq
#print axioms Legendre.Density.GuthMaynard.centeredDerivCoeff.eq_1
#print axioms Legendre.Density.GuthMaynard.centeredDerivCoeff_l2_le
#print axioms Legendre.Density.GuthMaynard.centeredDirichletTime.eq_1
#print axioms Legendre.Density.GuthMaynard.centeredDirichletTime_eq
#print axioms Legendre.Density.GuthMaynard.complex_sum_sq_le_card_mul_sum_sq
#print axioms Legendre.Density.GuthMaynard.conjugateCoeffs.eq_1
#print axioms Legendre.Density.GuthMaynard.continuous_deriv_centeredDirichletTime
#print axioms Legendre.Density.GuthMaynard.continuous_dirichletTime
#print axioms Legendre.Density.GuthMaynard.continuous_trigPoly
#print axioms Legendre.Density.GuthMaynard.deriv_centeredDirichletTime
#print axioms Legendre.Density.GuthMaynard.differentiable_centeredDirichletTime
#print axioms Legendre.Density.GuthMaynard.dirichletPoly.eq_1
#print axioms Legendre.Density.GuthMaynard.dirichletPoly_differenceMoment_le_one
#print axioms Legendre.Density.GuthMaynard.dirichletPoly_difference_eq_translated
#print axioms Legendre.Density.GuthMaynard.dirichletPoly_neg_eq_sourceDirichletPoly
#print axioms Legendre.Density.GuthMaynard.dirichletPoly_one_differenceMoment_eq_coefficientOneMoment
#print axioms Legendre.Density.GuthMaynard.dirichletTime.eq_1
#print axioms Legendre.Density.GuthMaynard.divisorCountBound_native
#print axioms Legendre.Density.GuthMaynard.dyadicInterval_disjoint_double
#print axioms Legendre.Density.GuthMaynard.dyadicInterval_eq_Ico_succ
#print axioms Legendre.Density.GuthMaynard.endpointTwist.eq_1
#print axioms Legendre.Density.GuthMaynard.eventually_heathBrownLocalRecurrenceProfile_pow_ten_le_rpow
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownCoefficientOneMoment_dyadic_le_target_transfer
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownCoefficientOneMoment_dyadic_le_terminal_transfer
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicChildPackage_medium_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_all_scales_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_ge_thirty_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound_cube
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound_cube_total
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound_of_terminal_sq
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound_physical
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound_total
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_nonmedium_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_self_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_small_scale_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownPoweredBlockMoment_le_target
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownPoweredBlockMoment_le_weighted
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownPoweredCoeffs_l2_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownRawPoweredBlockMoment_le_target
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownRawPoweredBlockMoment_le_target_uniform
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownRawPoweredBlockMoment_le_weighted
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownRawPoweredBlockMoment_le_weighted_uniform
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownReflectionDyadicMoment_le_common
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownReflectionDyadicMoment_le_common_preserving_length
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownReflectionDyadicMoment_le_target_transfer
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownReflectionDyadicMoment_le_terminal_transfer
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownSourceReflectedMainSum_le
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownSourceReflectedMainSum_le_source_sharp
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownSourceReflectedMomentPackage_le_terminal
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_common_preserving_length
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_card_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownTraceHybridBound_le_common
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownTraceHybridBound_le_source_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownTraceSourceBound_le_corrected_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownTraceSourceBound_le_source_sharp_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownTransferCoeff_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownTransferredDifferenceMoment_two_dyadic_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_le_corrected_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_le_source_sharp_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_medium_child_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_pair_le_common_target
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_pow_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_pow_terminal_bound
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_powering_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_powering_recurrence_sharp
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_powering_recurrence_sharp_uniform
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_source_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_dyadic_parent_uniform
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq_sharp
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq_sharp_uniform
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_terminal_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_terminal_recurrence_factored
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_transfer
#print axioms Legendre.Density.GuthMaynard.exists_heathBrownWeightedPowerMoment_bound
#print axioms Legendre.Density.GuthMaynard.exists_large_gmSmooth_of_source_large
#print axioms Legendre.Density.GuthMaynard.exists_norm_heathBrownPoweredCoeffs_le
#print axioms Legendre.Density.GuthMaynard.exists_norm_heathBrownTracePolynomial_le_div
#print axioms Legendre.Density.GuthMaynard.factorizationCountBound_native
#print axioms Legendre.Density.GuthMaynard.finitePowCoeff.eq_1
#print axioms Legendre.Density.GuthMaynard.finitePowCoeff_bound
#print axioms Legendre.Density.GuthMaynard.finitePowCoeff_bound_uniform
#print axioms Legendre.Density.GuthMaynard.finitePowCoeff_lower_endpoint_eq_zero
#print axioms Legendre.Density.GuthMaynard.finitePowPoly.eq_1
#print axioms Legendre.Density.GuthMaynard.finitePoweredLineCoeffs.eq_1
#print axioms Legendre.Density.GuthMaynard.finite_polynomial_power_identity
#print axioms Legendre.Density.GuthMaynard.finite_polynomial_power_identity_Ioc
#print axioms Legendre.Density.GuthMaynard.finite_resolvent_telescoping
#print axioms Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_binMoment_le_dyadic
#print axioms Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_differenceMoment_le_dyadic
#print axioms Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_eq_one_add_wide
#print axioms Legendre.Density.GuthMaynard.gmRestrictedCoeffs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSmoothCutoff_terminal_traceWeight_zero
#print axioms Legendre.Density.GuthMaynard.gmSmoothDirichletPoly_restricted_eq_sum
#print axioms Legendre.Density.GuthMaynard.gmSmoothRestrictedOne_differenceMoment_le_trace
#print axioms Legendre.Density.GuthMaynard.gmSmoothRestrictedOne_eq_sourceRestrictedOne
#print axioms Legendre.Density.GuthMaynard.gmSourceLeftPiece.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_core
#print axioms Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_dyadic
#print axioms Legendre.Density.GuthMaynard.gmSourceMiddlePiece.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSourceMiddlePiece_mem_core
#print axioms Legendre.Density.GuthMaynard.gmSourceMiddlePiece_mem_dyadic
#print axioms Legendre.Density.GuthMaynard.gmSourcePieces_partition
#print axioms Legendre.Density.GuthMaynard.gmSourceRightPiece.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_core
#print axioms Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_dyadic
#print axioms Legendre.Density.GuthMaynard.harmonic_mul_heathBrownWeightedMoment_le_groupedTransfer
#print axioms Legendre.Density.GuthMaynard.harmonic_mul_heathBrownWeightedMoment_le_transferred
#print axioms Legendre.Density.GuthMaynard.hasDerivAt_centeredDirichletTime
#print axioms Legendre.Density.GuthMaynard.hasDerivAt_real_cot
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMeanSquare_native
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMeanSquare_of_offDiagonal
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMeanSquare_of_weighted
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_dyadic_le_terminal_weighted
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_dyadic_reflection
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_hybrid
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_reflection_schedule
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_source_bound
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOne_diagonal
#print axioms Legendre.Density.GuthMaynard.heathBrownCoefficientOne_moment_eq_diagonal_add_offDiagonal
#print axioms Legendre.Density.GuthMaynard.heathBrownCommonReflectionLength_le_target
#print axioms Legendre.Density.GuthMaynard.heathBrownCommonReflectionLength_lower
#print axioms Legendre.Density.GuthMaynard.heathBrownCommonReflectionLength_upper
#print axioms Legendre.Density.GuthMaynard.heathBrownCommonReflectionMomentBound._proof_1
#print axioms Legendre.Density.GuthMaynard.heathBrownCorrectedCommonScale_eq_two_mul_target
#print axioms Legendre.Density.GuthMaynard.heathBrownCorrectedCommonScale_le_physical
#print axioms Legendre.Density.GuthMaynard.heathBrownCorrectedCommonScale_le_twelve_mul_sq
#print axioms Legendre.Density.GuthMaynard.heathBrownCorrectedTraceRecurrenceBound._proof_1
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceBin.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceBin_bounds
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceBin_card_le
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceBin_card_le_transition
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceMoment_dyadic_eq_dirichletPoly
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceMoment_dyadic_le_weighted
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceMoment_le_of_norm_le
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceMoment_nonneg
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceMoment_ofReal_eq_kernel_sum
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferencePolynomial_dyadic_eq_dirichletPoly
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceScale_bounds
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceScale_mem_range
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceSetMeanSquare_native
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceSetMeanSquare_of_coefficientOne
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceTranslateSet.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceTranslateSet_card
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceTranslateSet_mem_base
#print axioms Legendre.Density.GuthMaynard.heathBrownDifferenceTranslateSet_separated
#print axioms Legendre.Density.GuthMaynard.heathBrownDyadicPairMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownDyadicReflectionHeight_bounds
#print axioms Legendre.Density.GuthMaynard.heathBrownDyadicReflectionLength_bounds_real
#print axioms Legendre.Density.GuthMaynard.heathBrownDyadicReflectionLength_lower
#print axioms Legendre.Density.GuthMaynard.heathBrownDyadicReflectionLength_pos
#print axioms Legendre.Density.GuthMaynard.heathBrownDyadicReflectionLength_upper
#print axioms Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window
#print axioms Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_bounds_real
#print axioms Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_cast_le
#print axioms Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_le_common
#print axioms Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_lower
#print axioms Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_pos
#print axioms Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_upper
#print axioms Legendre.Density.GuthMaynard.heathBrownHalfWeight.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownHalfWeight_mul_phase_eq_cpow
#print axioms Legendre.Density.GuthMaynard.heathBrownHalfWeight_nonneg
#print axioms Legendre.Density.GuthMaynard.heathBrownHybridErrorSum_le_uniform
#print axioms Legendre.Density.GuthMaynard.heathBrownLocalRecurrenceProfile_components
#print axioms Legendre.Density.GuthMaynard.heathBrownLocalRecurrenceProfile_le_explicit
#print axioms Legendre.Density.GuthMaynard.heathBrownMajorantKernel_eq_norm_gmR_ratio
#print axioms Legendre.Density.GuthMaynard.heathBrownMajorantKernel_mul_left_right
#print axioms Legendre.Density.GuthMaynard.heathBrownMajorantKernel_nonneg
#print axioms Legendre.Density.GuthMaynard.heathBrownNearPairs_card_le
#print axioms Legendre.Density.GuthMaynard.heathBrownPhase_mul_star
#print axioms Legendre.Density.GuthMaynard.heathBrownPoweredBlock_le_target
#print axioms Legendre.Density.GuthMaynard.heathBrownPoweredBlock_mul_aux_eq_target
#print axioms Legendre.Density.GuthMaynard.heathBrownPoweredTargetScale.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownPoweredWide_eq
#print axioms Legendre.Density.GuthMaynard.heathBrownRawPoweredWide_eq
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectedPrefixCoeff.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_uniform
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_two_le
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionDyadicMoment._proof_1
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionDyadicMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionDyadicMoment_eq
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionDyadicMoment_le_terminal_weighted
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionTargetScale_bounds_real
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionTargetScale_le_two_mul_common
#print axioms Legendre.Density.GuthMaynard.heathBrownScaledInterval.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownScaledInterval_subset_dyadic
#print axioms Legendre.Density.GuthMaynard.heathBrownSharpUniformReflectionError._proof_1
#print axioms Legendre.Density.GuthMaynard.heathBrownSharpUniformReflectionError_smoothing_le
#print axioms Legendre.Density.GuthMaynard.heathBrownSmoothingHeight_le_two_rpow
#print axioms Legendre.Density.GuthMaynard.heathBrownSmoothingHeight_pos
#print axioms Legendre.Density.GuthMaynard.heathBrownSmoothingHeight_rpow_one_sub_order_le
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceNearSum_le
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceReflectedErrorSum_le_hybridErrorSum
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceReflectedErrorSum_le_sharp_uniform
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceReflectedErrorSum_le_uniform
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceSharpTraceRecurrenceBound._proof_1
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceSharpTraceRecurrenceBound.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceSharpTraceRecurrenceBound_le_profile
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale_le_physical
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale_le_twenty_four_mul_sq
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceTerminal_sixteen_sq_le_of_physical
#print axioms Legendre.Density.GuthMaynard.heathBrownSourceTransitionSum_le
#print axioms Legendre.Density.GuthMaynard.heathBrownTerminalRecurrenceLoss._proof_1
#print axioms Legendre.Density.GuthMaynard.heathBrownTerminalRecurrenceLoss._proof_2
#print axioms Legendre.Density.GuthMaynard.heathBrownTerminalRecurrenceLoss_le_rpow
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceBinMoment_le_card_mul
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceBinMoment_le_reflection
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceDiagonal_le
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceMoment_eq_diagonal_add_offDiagonal
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceMoment_le_hybrid
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceMoment_le_reflection_schedule
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceMoment_le_source_bound
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceOffDiagonalMoment_eq_nested
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceOffDiagonalMoment_eq_sum_bins
#print axioms Legendre.Density.GuthMaynard.heathBrownTracePolynomial_eq_phase_mul_zero_add_tail
#print axioms Legendre.Density.GuthMaynard.heathBrownTracePolynomial_eq_source
#print axioms Legendre.Density.GuthMaynard.heathBrownTracePolynomial_eq_weighted_range
#print axioms Legendre.Density.GuthMaynard.heathBrownTracePolynomial_quantitative_reflection
#print axioms Legendre.Density.GuthMaynard.heathBrownTracePolynomial_reflection_with_length
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceSourceBound._proof_1
#print axioms Legendre.Density.GuthMaynard.heathBrownTraceSourceBound_eq_components
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferAuxiliary.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferAuxiliary_pos
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferCoeff.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferCoeff_eq_card_mul_halfWeight
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferCoeff_nonneg
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferCoeff_two_dyadic_bound
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferSupport.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferSupport_subset_two_dyadic
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferTuples.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownTransfer_fiber_card_le_divisors
#print axioms Legendre.Density.GuthMaynard.heathBrownTransfer_polynomial_identity
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferredDifferenceMoment_eq_grouped
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferredDifferenceMoment_eq_kernel
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferredDifferencePolynomial_eq_grouped
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferredDifferencePolynomial_eq_two_dyadic
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferredKernelMoment_nonneg
#print axioms Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq
#print axioms Legendre.Density.GuthMaynard.heathBrownUniformReflectionError.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMeanSquare_native
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMeanSquare_of_cutoff
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_direct_meanValue
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_eq_kernel_sum
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_eq_scaledKernel
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_card_sq_mul_length
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_hybrid
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_source_bound
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_three_smoothPieces
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_two_adjacent_of_comparable
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_nonneg
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_pow_le
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedMoment_scale_monotone
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedPowerMoment_eq_poweredPolynomial
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedSetMoment_dyadic
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedSetMoment_eq_kernel_sum
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedSetMoment_mono
#print axioms Legendre.Density.GuthMaynard.heathBrownWeightedSetMoment_union_le_two
#print axioms Legendre.Density.GuthMaynard.heathBrown_corrected_common_exponent_le_log
#print axioms Legendre.Density.GuthMaynard.heathBrown_displacement_bin_count_le_log
#print axioms Legendre.Density.GuthMaynard.heathBrown_eventually_log_le_rpow
#print axioms Legendre.Density.GuthMaynard.heathBrown_high_physical_of_cube
#print axioms Legendre.Density.GuthMaynard.heathBrown_large_scale_target_package
#print axioms Legendre.Density.GuthMaynard.heathBrown_mul_injective
#print axioms Legendre.Density.GuthMaynard.heathBrown_natCast_clog_two_le_one_add_log
#print axioms Legendre.Density.GuthMaynard.heathBrown_norm_weighted_range_le_of_partial_sum
#print axioms Legendre.Density.GuthMaynard.heathBrown_poweredBlock_subset
#print axioms Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_le
#print axioms Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le
#print axioms Legendre.Density.GuthMaynard.heathBrown_scaledKernel_le_full
#print axioms Legendre.Density.GuthMaynard.heathBrown_source_exponent_succ_le_terminal
#print axioms Legendre.Density.GuthMaynard.heathBrown_source_scales_comparable
#print axioms Legendre.Density.GuthMaynard.heathBrown_traceKernel_eq_scaled_phase
#print axioms Legendre.Density.GuthMaynard.heathBrown_weighted_range_eq_endpoint_sub_differences
#print axioms Legendre.Density.GuthMaynard.hilbertForm.eq_1
#print axioms Legendre.Density.GuthMaynard.hilbertForm_norm_le
#print axioms Legendre.Density.GuthMaynard.integral_cexp_int
#print axioms Legendre.Density.GuthMaynard.integral_conj_dirichletTime_mul_dirichletTime
#print axioms Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term
#print axioms Legendre.Density.GuthMaynard.integral_conj_fourier_term_mul_fourier_term
#print axioms Legendre.Density.GuthMaynard.integral_conj_trigPoly_mul_trigPoly
#print axioms Legendre.Density.GuthMaynard.integral_norm_sq_dirichletTime_le
#print axioms Legendre.Density.GuthMaynard.integral_norm_sq_trigPoly
#print axioms Legendre.Density.GuthMaynard.integral_sawtooth_cexp
#print axioms Legendre.Density.GuthMaynard.integral_sawtooth_cexp_all
#print axioms Legendre.Density.GuthMaynard.integral_sawtooth_conj_fourier_mul_fourier
#print axioms Legendre.Density.GuthMaynard.integral_sawtooth_conj_trigPoly_mul_trigPoly
#print axioms Legendre.Density.GuthMaynard.kusminLandau_interval
#print axioms Legendre.Density.GuthMaynard.kusminLandau_one_period
#print axioms Legendre.Density.GuthMaynard.kusminLandau_one_period_decreasing
#print axioms Legendre.Density.GuthMaynard.l2_norm_sq_nonneg
#print axioms Legendre.Density.GuthMaynard.l2_norm_sq_zero_iff
#print axioms Legendre.Density.GuthMaynard.le_two_mul_add_of_le_mul_add_of_sq_le_mul
#print axioms Legendre.Density.GuthMaynard.local_sample_le_energy
#print axioms Legendre.Density.GuthMaynard.logHilbertQuad.eq_1
#print axioms Legendre.Density.GuthMaynard.logHilbertQuad_eq_main_add_error
#print axioms Legendre.Density.GuthMaynard.logHilbertQuad_norm_le
#print axioms Legendre.Density.GuthMaynard.logKernelErrorQuad.eq_1
#print axioms Legendre.Density.GuthMaynard.logKernelErrorQuad_norm_le
#print axioms Legendre.Density.GuthMaynard.logarithmicPhase.eq_1
#print axioms Legendre.Density.GuthMaynard.logarithmicSum.eq_1
#print axioms Legendre.Density.GuthMaynard.logarithmicSum_eq_cpow
#print axioms Legendre.Density.GuthMaynard.mean_value_pos
#print axioms Legendre.Density.GuthMaynard.montgomery_mean_value_estimate
#print axioms Legendre.Density.GuthMaynard.montgomery_mean_value_native
#print axioms Legendre.Density.GuthMaynard.montgomery_mean_value_rhs_nonneg
#print axioms Legendre.Density.GuthMaynard.natCast_log_two_le_log
#print axioms Legendre.Density.GuthMaynard.natCast_mul_heathBrownHalfWeight_mul
#print axioms Legendre.Density.GuthMaynard.natCast_mul_heathBrownWeightedMoment_le_coefficientOne
#print axioms Legendre.Density.GuthMaynard.natMainQuad.eq_1
#print axioms Legendre.Density.GuthMaynard.natMainQuad_eq_scaled_hilbert
#print axioms Legendre.Density.GuthMaynard.natMainQuad_norm_le
#print axioms Legendre.Density.GuthMaynard.natScaledCoeff.eq_1
#print axioms Legendre.Density.GuthMaynard.natScaledCoeff_l2_le
#print axioms Legendre.Density.GuthMaynard.nat_cpow_neg_mul_I_eq
#print axioms Legendre.Density.GuthMaynard.nat_hilbertForm_norm_le
#print axioms Legendre.Density.GuthMaynard.norm_add_add_sq_le_three
#print axioms Legendre.Density.GuthMaynard.norm_add_sq_le_two
#print axioms Legendre.Density.GuthMaynard.norm_centeredDirichletTime
#print axioms Legendre.Density.GuthMaynard.norm_complex_log_kernel_error_le_one
#print axioms Legendre.Density.GuthMaynard.norm_endpointTwist
#print axioms Legendre.Density.GuthMaynard.norm_finitePoweredLineCoeffs_le
#print axioms Legendre.Density.GuthMaynard.norm_gmReflectionDirichletPoly_sq_le_dyadic
#print axioms Legendre.Density.GuthMaynard.norm_heathBrownPoweredWide_sq
#print axioms Legendre.Density.GuthMaynard.norm_heathBrownPoweredWide_sq_le_blocks
#print axioms Legendre.Density.GuthMaynard.norm_heathBrownReflectedPrefixCoeff_le_one
#print axioms Legendre.Density.GuthMaynard.norm_heathBrownTracePolynomial_le
#print axioms Legendre.Density.GuthMaynard.norm_heathBrownTracePolynomial_le_zero_add_tail
#print axioms Legendre.Density.GuthMaynard.norm_logarithmicPhase_prefix_le_div
#print axioms Legendre.Density.GuthMaynard.norm_logarithmicPhase_prefix_neg_eq_abs
#print axioms Legendre.Density.GuthMaynard.norm_logarithmicSum_le_length
#print axioms Legendre.Density.GuthMaynard.norm_phaseResolvent_le
#print axioms Legendre.Density.GuthMaynard.norm_phaseResolvent_sub_eq
#print axioms Legendre.Density.GuthMaynard.norm_phaseSum_le_card
#print axioms Legendre.Density.GuthMaynard.norm_sawtooth_conj_trigPoly_mul_trigPoly_le
#print axioms Legendre.Density.GuthMaynard.norm_sourceDirichletPoly_eq_dirichletPoly_conjugateCoeffs
#print axioms Legendre.Density.GuthMaynard.norm_sum_le_resolvent_variation
#print axioms Legendre.Density.GuthMaynard.norm_unitaryPhase
#print axioms Legendre.Density.GuthMaynard.ofReal_heathBrownDifferenceMoment_eq_kernel_sum
#print axioms Legendre.Density.GuthMaynard.ofReal_integral_norm_sq_dirichletTime
#print axioms Legendre.Density.GuthMaynard.offDiagonal_difference_mem_reflectionRange
#print axioms Legendre.Density.GuthMaynard.one_div_heathBrownSmoothingHeight_pow_order_le
#print axioms Legendre.Density.GuthMaynard.one_half_le_heathBrownTransferAuxiliary_harmonic
#print axioms Legendre.Density.GuthMaynard.one_le_abs_sub_of_mem_erase_of_separated
#print axioms Legendre.Density.GuthMaynard.one_le_sqrt_two_mul_mul_heathBrownHalfWeight
#print axioms Legendre.Density.GuthMaynard.orderedPairSum_eq_diagonal_add_offDiagonal
#print axioms Legendre.Density.GuthMaynard.phaseResolvent.eq_1
#print axioms Legendre.Density.GuthMaynard.phaseResolvent_eq
#print axioms Legendre.Density.GuthMaynard.phaseResolvent_variation
#print axioms Legendre.Density.GuthMaynard.powCoeff_product_mem_support
#print axioms Legendre.Density.GuthMaynard.pow_clog_two_le_two_mul
#print axioms Legendre.Density.GuthMaynard.pow_coeff_subset
#print axioms Legendre.Density.GuthMaynard.prod_natCast_cpow_eq
#print axioms Legendre.Density.GuthMaynard.rpow_le_heathBrownSmoothingHeight
#print axioms Legendre.Density.GuthMaynard.separated_annulus_card_le_two
#print axioms Legendre.Density.GuthMaynard.separated_near_card_le_two_mul
#print axioms Legendre.Density.GuthMaynard.sin_half_lower
#print axioms Legendre.Density.GuthMaynard.sourceCoefficientOne_differenceMoment_eq_gmR_ratioMoment
#print axioms Legendre.Density.GuthMaynard.sourceCoefficientOne_differenceMoment_le_three_trace
#print axioms Legendre.Density.GuthMaynard.sourceCoefficientOne_differenceMoment_le_two_mul_weighted
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_differenceMoment_le_of_norm_le
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_differenceMoment_le_one
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_eq_three_gmSmooth
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_halfWeight_eq_finitePowPoly
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_halfWeight_pow_eq_finitePowPoly
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_one_zero
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_orderedDifference_meanValue
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_real_smul_coeffs
#print axioms Legendre.Density.GuthMaynard.source_large_values_localize_to_matrix
#print axioms Legendre.Density.GuthMaynard.sq_integral_norm_gmReflectionDirichletPoly_le
#print axioms Legendre.Density.GuthMaynard.sq_intervalIntegral_le_length_mul_intervalIntegral_sq
#print axioms Legendre.Density.GuthMaynard.sqrt_mul_heathBrownHalfWeight_le_one
#print axioms Legendre.Density.GuthMaynard.star_heathBrownPhase_mul_eq_ratio_cpow
#print axioms Legendre.Density.GuthMaynard.strictAntiOn_real_cot
#print axioms Legendre.Density.GuthMaynard.sum_bin_sq_integral_norm_gmReflectionDirichletPoly_le
#print axioms Legendre.Density.GuthMaynard.sum_difference_eq_sum_differenceTranslateSet
#print axioms Legendre.Density.GuthMaynard.sum_heathBrownHalfWeight_sq_le_one
#print axioms Legendre.Density.GuthMaynard.sum_heathBrownOffDiagonalPairs_eq_sum_differenceBins
#print axioms Legendre.Density.GuthMaynard.sum_heathBrown_powered_scales_le
#print axioms Legendre.Density.GuthMaynard.sum_if_div_two_pow_le_two_mul
#print axioms Legendre.Density.GuthMaynard.sum_local_intervalIntegrals_le
#print axioms Legendre.Density.GuthMaynard.sum_norm_heathBrownPoweredWide_sq
#print axioms Legendre.Density.GuthMaynard.sum_norm_heathBrownPoweredWide_sq_le_blocks
#print axioms Legendre.Density.GuthMaynard.sum_norm_heathBrownPoweredWide_sq_le_meanValue
#print axioms Legendre.Density.GuthMaynard.sum_norm_heathBrownRawPoweredWide_sq
#print axioms Legendre.Density.GuthMaynard.sum_norm_heathBrownRawPoweredWide_sq_le_blocks
#print axioms Legendre.Density.GuthMaynard.sum_sq_le_card_mul_sum_sq
#print axioms Legendre.Density.GuthMaynard.trigPoly.eq_1
#print axioms Legendre.Density.GuthMaynard.two_mul_add_four_le_of_sixteen_mul_sq_le_pow
#print axioms Legendre.Density.GuthMaynard.two_mul_floor_mul_height_div_le_heathBrownSourceTerminalScale
#print axioms Legendre.Density.GuthMaynard.two_pow_le_floor_of_mem_difference_range
#print axioms Legendre.Density.GuthMaynard.unitaryPhase.eq_1
#print axioms Legendre.Density.GuthMaynard.unitaryPhase_add
#print axioms Legendre.Density.GuthMaynard.unitaryPhase_int_mul_two_pi
#print axioms Legendre.Density.GuthMaynard.unitaryPhase_logarithmicPhase_eq_cpow
#print axioms Legendre.Density.GuthMaynard.unitaryPhase_resolvent_step
#print axioms Legendre.Density.GuthMaynard.unitaryPhase_sub
#print axioms Legendre.Density.GuthMaynard.unitaryPhase_sub_int_mul_two_pi
#print axioms Legendre.Density.GuthMaynard.wideDirichletPoly.eq_1
#print axioms Legendre.Density.GuthMaynard.wideDirichletPoly_eq_sum_blocks
#print axioms Legendre.Density.GuthMaynard.wideDirichletPoly_finitePoweredLineCoeffs
#print axioms Legendre.Literature.layer4_heath_brown_difference_comparator
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.factorizationCountBound_native._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.factorizationCountBound_native._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.factorizationCountBound_native._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.factorizationCountBound_native._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.factorizationCountBound_native._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.factorizationCountBound_native._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.factorizationCountBound_native._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.finitePowCoeff_lower_endpoint_eq_zero._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.finitePowCoeff_lower_endpoint_eq_zero._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.finite_polynomial_power_identity_Ioc._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.wideDirichletPoly_eq_sum_blocks._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.FinitePowers.0.Legendre.Density.GuthMaynard.wideDirichletPoly_eq_sum_blocks._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.dyadicInterval_disjoint_double._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.exists_heathBrownPoweredCoeffs_l2_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.exists_heathBrownTransferredDifferenceMoment_two_dyadic_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_pow_terminal_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.exists_norm_heathBrownPoweredCoeffs_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownDifferencePolynomial_dyadic_eq_dirichletPoly._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownPoweredBlock_le_target._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferAuxiliary_pos._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferCoeff_two_dyadic_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferCoeff_two_dyadic_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferCoeff_two_dyadic_bound._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownTransferredKernel_diagonal_eq._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownWeightedMoment_eq_scaledKernel._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrownWeightedMoment_eq_scaledKernel._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrown_poweredBlock_subset._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrown_poweredBlock_subset._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.heathBrown_poweredBlock_subset._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.norm_heathBrownPoweredWide_sq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.ofReal_heathBrownDifferenceMoment_eq_kernel_sum._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.one_half_le_heathBrownTransferAuxiliary_harmonic._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.sourceCoefficientOne_differenceMoment_eq_gmR_ratioMoment._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_halfWeight_eq_finitePowPoly._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.sum_heathBrownHalfWeight_sq_le_one._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.sum_heathBrownHalfWeight_sq_le_one._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.sum_heathBrown_powered_scales_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrown.0.Legendre.Density.GuthMaynard.sum_norm_heathBrownPoweredWide_sq_le_meanValue._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.GMSmoothCutoff.exists_traceWeight_variation_bound._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.add_four_le_add_four"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.cast_four_mul_sq_pow_three"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.dyadicInterval_eq_Ico_succ._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.dyadicInterval_eq_Ico_succ._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.dyadicInterval_eq_Ico_succ._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownCoefficientOneMoment_dyadic_le_target_transfer._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownCoefficientOneMoment_dyadic_le_target_transfer._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownCoefficientOneMoment_dyadic_le_terminal_transfer._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownCoefficientOneMoment_dyadic_le_terminal_transfer._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicChildPackage_medium_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicChildPackage_medium_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicChildPackage_medium_bound._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicChildPackage_medium_bound._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicChildPackage_medium_bound._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicChildPackage_medium_bound._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_all_scales_bound._proof_1_11"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_all_scales_bound._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_all_scales_bound._proof_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_all_scales_bound._proof_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound_cube_total._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound_physical._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound_physical._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_high_bound_physical._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound._simp_1_11"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_large_scale_bound_total._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_medium_bound._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_nonmedium_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_nonmedium_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_recurrence._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_self_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_self_recurrence._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_self_recurrence._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_self_recurrence._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_small_scale_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownDyadicPairMoment_small_scale_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownReflectionDyadicMoment_le_common_preserving_length._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownReflectionDyadicMoment_le_common_preserving_length._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_common_preserving_length._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._proof_1_11"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownStationaryBinMain_le_source_sharp._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_card_bound._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_card_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_card_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_card_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_card_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_card_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceBinMoment_near_card_bound._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceHybridBound_le_common._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceHybridBound_le_common._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceHybridBound_le_common._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceHybridBound_le_common._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceSourceBound_le_corrected_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownTraceSourceBound_le_source_sharp_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_le_corrected_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_le_corrected_recurrence._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_le_corrected_recurrence._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_le_source_sharp_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_le_source_sharp_recurrence._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_le_source_sharp_recurrence._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_medium_child_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_medium_child_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_medium_child_bound._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_pair_le_common_target._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_pair_le_common_target._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_source_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_source_recurrence._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_dyadic_parent_uniform._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_dyadic_parent_uniform._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_dyadic_parent_uniform._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_dyadic_parent_uniform._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_dyadic_parent_uniform._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq_sharp._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq_sharp._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq_sharp_uniform._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_sq_le_four_mul_sq_sharp_uniform._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_heathBrownWeightedMoment_terminal_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_norm_heathBrownTracePolynomial_le_div._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.exists_norm_heathBrownTracePolynomial_le_div._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_eq_one_add_wide._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_eq_one_add_wide._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_eq_one_add_wide._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_eq_one_add_wide._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_eq_one_add_wide._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_eq_one_add_wide._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.gmReflectionDirichletPoly_eq_one_add_wide._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.gmSmoothRestrictedOne_differenceMoment_le_trace._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_dyadic_le_terminal_weighted._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_hybrid._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_hybrid._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_hybrid._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_reflection_schedule._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_reflection_schedule._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_reflection_schedule._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_source_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_source_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCoefficientOneMoment_le_source_bound._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCommonReflectionLength_le_target._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownCommonReflectionLength_upper._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDifferenceBin_card_le_transition._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDifferenceBin_card_le_transition._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDifferenceBin_card_le_transition._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDifferenceBin_card_le_transition._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDifferenceScale_mem_range._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicReflectionHeight_bounds._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicReflectionHeight_bounds._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicReflectionHeight_bounds._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicReflectionLength_pos._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicReflectionLength_upper._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownDyadicTerminals_enter_medium_window._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_cast_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_cast_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_cast_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_cast_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_cast_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_cast_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_cast_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_pos._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownFixedReflectionLength_upper._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownLocalRecurrenceProfile_le_explicit._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownLocalRecurrenceProfile_le_explicit._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_sharp_uniform._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_uniform._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_uniform._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_uniform._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_uniform._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionBinError_fixed_le_uniform._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionDerivativeOrder_budget._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownReflectionTargetScale_le_two_mul_common._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSmoothingHeight_pos._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSmoothingHeight_rpow_one_sub_order_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceSharpTraceRecurrenceBound_le_profile._proof_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceSharpTraceRecurrenceBound_le_profile._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceSharpTraceRecurrenceBound_le_profile._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceSharpTraceRecurrenceBound_le_profile._proof_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale_le_physical._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale_le_physical._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale_le_physical._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale_le_twenty_four_mul_sq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale_le_twenty_four_mul_sq._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownSourceTerminalScale_le_twenty_four_mul_sq._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownTraceBinMoment_le_reflection._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownTracePolynomial_eq_phase_mul_zero_add_tail._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownTracePolynomial_eq_weighted_range._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownTracePolynomial_eq_weighted_range._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownWeightedMeanSquare_of_cutoff._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_card_sq_mul_length._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_card_sq_mul_length._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_two_adjacent_of_comparable._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_two_adjacent_of_comparable._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownWeightedMoment_le_two_adjacent_of_comparable._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrownWeightedSetMoment_union_le_two._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_corrected_common_exponent_le_log._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_corrected_common_exponent_le_log._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_corrected_common_exponent_le_log._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_corrected_common_exponent_le_log._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_large_scale_target_package._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_large_scale_target_package._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_large_scale_target_package._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_natCast_clog_two_le_one_add_log._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_natCast_clog_two_le_one_add_log._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_norm_weighted_range_le_of_partial_sum._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_norm_weighted_range_le_of_partial_sum._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reciprocal_absorption"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_reflection_main_coefficient_mul_terminalScale_le._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_source_exponent_succ_le_terminal._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_source_scales_comparable._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_source_scales_comparable._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.heathBrown_source_scales_comparable._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.natCast_log_two_le_log._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.natCast_log_two_le_log._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.nonneg_le_add_one_sq"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.norm_heathBrownTracePolynomial_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.norm_heathBrownTracePolynomial_le._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.pow_clog_two_le_two_mul._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.pow_clog_two_le_two_mul._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.pow_clog_two_le_two_mul._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.pow_two_succ_eq_two_mul"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.pow_two_succ_eq_two_mul._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.rpow_five_four_mul_rpow_one_four"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.rpow_half_mul_rpow_half"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.rpow_one_mul_rpow_one_four"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.sqrt_mul_heathBrownHalfWeight_le_one._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.sum_norm_heathBrownRawPoweredWide_sq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_mul_add_four_le_of_sixteen_mul_sq_le_pow._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_mul_add_four_le_of_sixteen_mul_sq_le_pow._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_mul_add_four_le_of_sixteen_mul_sq_le_pow._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_mul_floor_mul_height_div_le_heathBrownSourceTerminalScale._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_mul_floor_mul_height_div_le_heathBrownSourceTerminalScale._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_mul_floor_mul_height_div_le_heathBrownSourceTerminalScale._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_pow_le_floor_of_mem_difference_range._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_pow_le_floor_of_mem_difference_range._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.two_pow_le_floor_of_mem_difference_range._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.HeathBrownReflection.0.Legendre.Density.GuthMaynard.zero_le_sixty_four"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_core._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_core._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_core._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_core._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_core._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_dyadic._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_dyadic._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceLeftPiece_mem_dyadic._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceMiddlePiece_mem_core._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceMiddlePiece_mem_core._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourcePieces_partition._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_core._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_core._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_core._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_core._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_core._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_dyadic._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_dyadic._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.gmSourceRightPiece_mem_dyadic._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.source_large_values_localize_to_matrix._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Localization.0.Legendre.Density.GuthMaynard.source_large_values_localize_to_matrix._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.kusminLandau_interval._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.kusminLandau_one_period._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.norm_logarithmicPhase_prefix_le_div._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.norm_logarithmicPhase_prefix_le_div._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.norm_logarithmicPhase_prefix_le_div._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.norm_logarithmicPhase_prefix_le_div._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.norm_sum_le_resolvent_variation._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.norm_sum_le_resolvent_variation._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.norm_sum_le_resolvent_variation._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.phaseResolvent_variation._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.phaseResolvent_variation._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.separated_annulus_card_le_two._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.separated_subset_card_le_one_of_diameter"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.unitaryPhase_resolvent_step._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.unitaryPhase_resolvent_step._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.unitaryPhase_resolvent_step._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.unitaryPhase_resolvent_step._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.unitaryPhase_resolvent_step._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.unitaryPhase_resolvent_step._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LogarithmicPrefix.0.Legendre.Density.GuthMaynard.unitaryPhase_resolvent_step._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_conj_dirichlet_term_mul_dirichlet_term._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_sawtooth_cexp._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_sawtooth_cexp._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_sawtooth_cexp._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_sawtooth_cexp._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_sawtooth_cexp._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_sawtooth_cexp._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_sawtooth_cexp._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.integral_sawtooth_cexp_all._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.logHilbertQuad_eq_main_add_error._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.logKernelErrorQuad_norm_le._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.logKernelErrorQuad_norm_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.natMainQuad_eq_scaled_hilbert._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.natMainQuad_eq_scaled_hilbert._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.natMainQuad_eq_scaled_hilbert._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.natMainQuad_eq_scaled_hilbert._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.natMainQuad_eq_scaled_hilbert._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.natMainQuad_eq_scaled_hilbert._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SamplingMeanSquare.0.Legendre.Density.GuthMaynard.natMainQuad_eq_scaled_hilbert._simp_1_9"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.finitePowCoeff.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmSourceLeftScale.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmSourceRightScale.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_hb_diagonal_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_hb_localization_rounding_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_hb_sampling_single_column_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_hb_two_point_moment_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_hb_two_point_moment_consumer._simp_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_hb_two_point_moment_consumer._simp_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_hb_zeroth_power_consumer"

-- Complete S2, S3 energy input and strict-tolerance bridge: every new declaration.
#print axioms Legendre.Density.GuthMaynard.Real.sqrt_le_self_of_one_le
#print axioms Legendre.Density.GuthMaynard.abs_additiveDefect_ge_intDefect_sub_one
#print axioms Legendre.Density.GuthMaynard.abs_pairSumFloorDefect_le_one_of_closed
#print axioms Legendre.Density.GuthMaynard.abs_pairSum_defect_lt_one_of_floor_eq
#print axioms Legendre.Density.GuthMaynard.abs_sub_pairSumFloorDefect_cast_lt_one
#print axioms Legendre.Density.GuthMaynard.card_gmCubicDyadicBoundingBox
#print axioms Legendre.Density.GuthMaynard.card_gmCubicDyadicFrequencyBlock_le
#print axioms Legendre.Density.GuthMaynard.card_gmCubicDyadicFrequencyBlock_le_scales
#print axioms Legendre.Density.GuthMaynard.card_gmCubicDyadicFrequencyBlock_sourceRadius_le
#print axioms Legendre.Density.GuthMaynard.card_gmCubicFrequencyBox
#print axioms Legendre.Density.GuthMaynard.card_gmCubicUnbalancedOrderedFrequencyBox_le
#print axioms Legendre.Density.GuthMaynard.card_gmCubicUnbalanced_sourceRadius_le
#print axioms Legendre.Density.GuthMaynard.closed_energy_le_three_strict
#print axioms Legendre.Density.GuthMaynard.complex_mul_integral_comp_mul_left
#print axioms Legendre.Density.GuthMaynard.complex_sq_mul_integral_integral_comp_mul_left
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicBaseWeight
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicCutoffSq
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicZWeight
#print axioms Legendre.Density.GuthMaynard.continuousAt_gmR
#print axioms Legendre.Density.GuthMaynard.continuousOn_gmCubicRAmplitude
#print axioms Legendre.Density.GuthMaynard.continuousOn_gmR_compl_zero
#print axioms Legendre.Density.GuthMaynard.continuousOn_norm_gmR_sq
#print axioms Legendre.Density.GuthMaynard.continuous_gmCubicRatioMap
#print axioms Legendre.Density.GuthMaynard.continuous_gmCubicRatioRawIntegrand
#print axioms Legendre.Density.GuthMaynard.continuous_gmCubicS3ModeIntegrand
#print axioms Legendre.Density.GuthMaynard.continuous_gmCubicS3ModeSummedIntegrand
#print axioms Legendre.Density.GuthMaynard.continuous_gmRPhase
#print axioms Legendre.Density.GuthMaynard.continuous_gmTraceOscillation
#print axioms Legendre.Density.GuthMaynard.continuous_norm_gmRPhase_pow
#print axioms Legendre.Density.GuthMaynard.dfiUnitRedundantBump._proof_1
#print axioms Legendre.Density.GuthMaynard.dfiUnitRedundantBump._proof_2
#print axioms Legendre.Density.GuthMaynard.dfiUnitRedundantBump._proof_3
#print axioms Legendre.Density.GuthMaynard.exists_dominant_gmCubicDyadicFrequencyBlock
#print axioms Legendre.Density.GuthMaynard.exists_gmCubicDyadicFrequencyBlock
#print axioms Legendre.Density.GuthMaynard.exists_gmCubicOrderedDyadicFrequencyBlock
#print axioms Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay
#print axioms Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound
#print axioms Legendre.Density.GuthMaynard.exists_gmS2SmoothingThreshold
#print axioms Legendre.Density.GuthMaynard.exists_norm_gmCubicS3FrequencyTail_le
#print axioms Legendre.Density.GuthMaynard.exists_norm_gmCubicS3FrequencyTail_le_mixed
#print axioms Legendre.Density.GuthMaynard.exists_norm_gmCubicS3Mode_le_decay
#print axioms Legendre.Density.GuthMaynard.exists_norm_gmTraceNonzeroTailAt_le_div
#print axioms Legendre.Density.GuthMaynard.exists_norm_gmTraceNonzeroTailAt_le_sqrt_near
#print axioms Legendre.Density.GuthMaynard.exists_ordered_gmCubicS3Mode
#print axioms Legendre.Density.GuthMaynard.gmCubicBalancedOrderedFrequencyBox._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicBalancedOrderedFrequencyBox.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicBaseWeightSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationMass.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationMass_eq_iterated
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationMass_eq_zero_of_unbalanced
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationMass_le_smoothedModeIntegral
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationMass_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationRadius_le_half_smoothingRadius
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationRadius_le_smoothingRadius
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationSlab.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationSlab_eq_empty_of_unbalanced
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationSlab_ordered_comparable
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationSlice_abs_sub_center_le
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationSlice_subset_reflected_preimage
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationSlice_subset_smoothingNeighborhood
#print axioms Legendre.Density.GuthMaynard.gmCubicCancellationWidth_le_one
#print axioms Legendre.Density.GuthMaynard.gmCubicCutoffSq.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicCutoffSqSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicBoundingBox.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicFrequencyBlock.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicFrequencyBlock_subset_boundingBox
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicIndexPairs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicIndexPairs_card_le
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicIndexPairs_nonempty
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicLogFactor_le
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicLogFactor_sq_le_realLog_sq
#print axioms Legendre.Density.GuthMaynard.gmCubicFourierIntegrand.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicFourierIntegrand_eq_zero_of_not_mem_ratioSquare
#print axioms Legendre.Density.GuthMaynard.gmCubicFourthConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicFourthConstant._proof_2
#print axioms Legendre.Density.GuthMaynard.gmCubicFourthConstant.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicFourthConstant_pos
#print axioms Legendre.Density.GuthMaynard.gmCubicFrequencyBox.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicFrequencyOscillation.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicFrequencyOscillation_ratioMap
#print axioms Legendre.Density.GuthMaynard.gmCubicFrequencyRadius_cast_lt_rpow_add_one
#print axioms Legendre.Density.GuthMaynard.gmCubicL2Constant_pos
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump_eq_zero_of_two_le_abs
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump_le_one
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump_one
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump_one_on_smoothingNeighborhood
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalFourthKernel.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNonzeroFrequencyBox.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicOrderedFrequencyBox.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRAmplitude.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRAmplitude_le_card_cubed
#print axioms Legendre.Density.GuthMaynard.gmCubicRAmplitude_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump._proof_2
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump._proof_3
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump._proof_4
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump._proof_5
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump_eq_zero_of_not_mem_Icc
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump_le_one
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBump_one
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioIntegrand.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioMap.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioRawIntegrand.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioRawIntegrand_eq_ratioIntegrand
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioRawIntegrand_eq_zero_of_not_mem_box
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioSquare.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRawSmoothedSliceMajorant_le
#print axioms Legendre.Density.GuthMaynard.gmCubicS2.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicS2_estimate
#print axioms Legendre.Density.GuthMaynard.gmCubicS3FourierIntegral_eq_integral
#print axioms Legendre.Density.GuthMaynard.gmCubicS3ModeIntegral_eq_integral_sum
#print axioms Legendre.Density.GuthMaynard.gmCubicS3ModeIntegral_eq_ratioIntegral
#print axioms Legendre.Density.GuthMaynard.gmCubicS3ModeSummedIntegrand_eq_RPhase
#print axioms Legendre.Density.GuthMaynard.gmCubicS3ModeSummedIntegrand_eq_kernelSum
#print axioms Legendre.Density.GuthMaynard.gmCubicS3ModeSummedIntegrand_eq_zero_of_not_mem_sourceCube
#print axioms Legendre.Density.GuthMaynard.gmCubicS3ModeSummedIntegrand_ratioMap
#print axioms Legendre.Density.GuthMaynard.gmCubicS3ModeSummedIntegrand_ratioMap_all
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_cyclic
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_eq_fourierIntegral
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_eq_integral
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_eq_zero_of_first_frequency_eq_zero
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_eq_zero_of_second_frequency_eq_zero
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_eq_zero_of_third_frequency_eq_zero
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_prop7_1
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_prop7_2
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_summable
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_swap12_neg_eq_star
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Mode_unbalanced_prop7_1
#print axioms Legendre.Density.GuthMaynard.gmCubicS3RatioIntegral_eq_fourierIntegral
#print axioms Legendre.Density.GuthMaynard.gmCubicS3Truncated_eq_sum_nonzero
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_eq_truncated_add_frequencyTail
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_eq_tsum_modes
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_frequencyTail_pow_100
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop7_2_explicit
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_explicit
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_native
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_physical_explicit
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_strict_energy
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_source_truncation_pow_100
#print axioms Legendre.Density.GuthMaynard.gmCubicSignedPermutations.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSignedPermutations_card_le_six
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedModeIntegral.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedModeIntegral_dyadic_le
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedModeIntegral_dyadic_simplified_le
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedModeIntegral_holder
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedModeIntegral_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedModeIntegrand.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedModeIntegrand_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRIntegrand_eq_on_neighborhood
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRIntegrand_eq_zero_of_not_mem_Icc
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRIntegrand_eq_zero_of_not_mem_support
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRIntegrand_le
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRIntegrand_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_eq_setIntegral_support
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_le
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_sq_le_localFourth
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedR_sq
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothingIncidence.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothingNeighborhood._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothingNeighborhood_integral_le_smoothedRSq
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothingScale_pos
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothingSupport._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothingSupport.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSourceCube.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicTail_scale_identity
#print axioms Legendre.Density.GuthMaynard.gmCubicTail_scale_ratio_le
#print axioms Legendre.Density.GuthMaynard.gmCubicTraceKernelSum_eq
#print axioms Legendre.Density.GuthMaynard.gmCubicUnbalancedOrderedFrequencyBox.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicUnbalanced_card_error_absorbed
#print axioms Legendre.Density.GuthMaynard.gmCubicZDerivativeBound._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicZDerivativeBound.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicZDerivativeBound_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicZFourier.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicZFourier_cancellation_pow
#print axioms Legendre.Density.GuthMaynard.gmCubicZFourier_cancellation_pow_100
#print axioms Legendre.Density.GuthMaynard.gmCubicZFourier_eq_integral
#print axioms Legendre.Density.GuthMaynard.gmCubicZFourier_far_frequency_pow
#print axioms Legendre.Density.GuthMaynard.gmCubicZFourier_far_frequency_pow_100
#print axioms Legendre.Density.GuthMaynard.gmCubicZFourier_uniform_decay
#print axioms Legendre.Density.GuthMaynard.gmCubicZWeight.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicZWeightSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicZWeight_eq_base_mul_scaled
#print axioms Legendre.Density.GuthMaynard.gmDifferenceMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.gmDifferenceMoment_le_heathBrown_roots
#print axioms Legendre.Density.GuthMaynard.gmDifferenceMoment_le_heathBrown_source_exponents
#print axioms Legendre.Density.GuthMaynard.gmDifferenceMoment_le_heathBrown_terminal_scale
#print axioms Legendre.Density.GuthMaynard.gmDifferenceMoment_nonneg
#print axioms Legendre.Density.GuthMaynard.gmDifferenceMoment_normalizedPowered
#print axioms Legendre.Density.GuthMaynard.gmDifferenceMoment_pow_le
#print axioms Legendre.Density.GuthMaynard.gmDifferenceMoment_pow_le_heathBrown
#print axioms Legendre.Density.GuthMaynard.gmEventuallyLogNatPower_le_rpow
#print axioms Legendre.Density.GuthMaynard.gmIntDecayProfile.eq_1
#print axioms Legendre.Density.GuthMaynard.gmIntDecayProfile_add_two_le
#print axioms Legendre.Density.GuthMaynard.gmIntDecayProfile_add_two_le_of_outside
#print axioms Legendre.Density.GuthMaynard.gmNearScaleBinSum_le_sqrt
#print axioms Legendre.Density.GuthMaynard.gmNonzeroScaledTraceMode.eq_1
#print axioms Legendre.Density.GuthMaynard.gmNonzeroScaledTraceMode_neg_neg_eq_star
#print axioms Legendre.Density.GuthMaynard.gmNonzeroScaledTraceMode_summable
#print axioms Legendre.Density.GuthMaynard.gmNonzeroTailBinError_eq_reflectionBinError_zero
#print axioms Legendre.Density.GuthMaynard.gmNonzeroTailBinMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.gmNonzeroTailBinMoment_le_powered_reflection
#print axioms Legendre.Density.GuthMaynard.gmNonzeroTailBinMoment_le_reflection
#print axioms Legendre.Density.GuthMaynard.gmNormalizedPoweredCoeffs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmOrdinatePairs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmPairSumFloorCorrelation_le_energy
#print axioms Legendre.Density.GuthMaynard.gmPairSumFloorCorrelation_le_strict_energy
#print axioms Legendre.Density.GuthMaynard.gmPairSumFloorCount_eq_zero_of_not_mem_support
#print axioms Legendre.Density.GuthMaynard.gmPairSumFloorDefectCount_eq_correlation
#print axioms Legendre.Density.GuthMaynard.gmPairSumFloorDefectCount_le_energy
#print axioms Legendre.Density.GuthMaynard.gmPairSumFloorDefectSupport_subset_Icc
#print axioms Legendre.Density.GuthMaynard.gmPairSumFloor_mem_Icc_of_inBaseInterval
#print axioms Legendre.Density.GuthMaynard.gmPhaseFloorDefectWeight._proof_1
#print axioms Legendre.Density.GuthMaynard.gmPhaseFloorDefectWeight.eq_1
#print axioms Legendre.Density.GuthMaynard.gmPhaseFloorDefectWeight_natCast_of_two_le
#print axioms Legendre.Density.GuthMaynard.gmPhaseFloorDefectWeight_natCast_one
#print axioms Legendre.Density.GuthMaynard.gmPhaseFloorDefectWeight_natCast_zero
#print axioms Legendre.Density.GuthMaynard.gmPhaseFloorDefectWeight_neg
#print axioms Legendre.Density.GuthMaynard.gmPhaseFloorDefectWeight_nonneg
#print axioms Legendre.Density.GuthMaynard.gmPhaseIntervalKernel.eq_1
#print axioms Legendre.Density.GuthMaynard.gmPhaseIntervalKernel_eq
#print axioms Legendre.Density.GuthMaynard.gmPhaseIntervalKernel_zero
#print axioms Legendre.Density.GuthMaynard.gmPoweredDifferenceSourceBound._proof_1
#print axioms Legendre.Density.GuthMaynard.gmPoweredDifferenceSourceBound._proof_2
#print axioms Legendre.Density.GuthMaynard.gmPoweredDifferenceSourceBound._proof_3
#print axioms Legendre.Density.GuthMaynard.gmPoweredDifferenceSourceBound_eq_physical
#print axioms Legendre.Density.GuthMaynard.gmPoweredDifferenceSourceBound_mono_scale
#print axioms Legendre.Density.GuthMaynard.gmPoweredDifferenceSourceBound_nonneg
#print axioms Legendre.Density.GuthMaynard.gmPoweredWide_eq
#print axioms Legendre.Density.GuthMaynard.gmRPhaseRows_eq_gmRPhase
#print axioms Legendre.Density.GuthMaynard.gmRPhase_neg
#print axioms Legendre.Density.GuthMaynard.gmR_eq_gmRPhase_log
#print axioms Legendre.Density.GuthMaynard.gmR_exp_eq_gmRPhase
#print axioms Legendre.Density.GuthMaynard.gmRetainedSignedReflection_near_bound
#print axioms Legendre.Density.GuthMaynard.gmS2FixedClog_add_one_le_commonExponent
#print axioms Legendre.Density.GuthMaynard.gmS2FixedLengthEpsilonLoss_le_profile_sq
#print axioms Legendre.Density.GuthMaynard.gmS2FixedReflectionLength_le_target
#print axioms Legendre.Density.GuthMaynard.gmS2PaperShape_eq
#print axioms Legendre.Density.GuthMaynard.gmS2PaperShape_nonneg
#print axioms Legendre.Density.GuthMaynard.gmS2PhysicalBinBound_eq_main_add_error
#print axioms Legendre.Density.GuthMaynard.gmS2PhysicalBinMain_le_paperShape
#print axioms Legendre.Density.GuthMaynard.gmS2PhysicalBinSourceBound._proof_1
#print axioms Legendre.Density.GuthMaynard.gmS2PhysicalBinSourceBound._proof_2
#print axioms Legendre.Density.GuthMaynard.gmS2PhysicalBinSourceBound_le_paperShape
#print axioms Legendre.Density.GuthMaynard.gmS2PoweredBinBound.eq_1
#print axioms Legendre.Density.GuthMaynard.gmS2PoweredBinBound_le_physical
#print axioms Legendre.Density.GuthMaynard.gmS2PoweredBinBound_nonneg
#print axioms Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_eq
#print axioms Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_le
#print axioms Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_sq_le
#print axioms Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_source_le_physical
#print axioms Legendre.Density.GuthMaynard.gmS2ScheduledError.eq_1
#print axioms Legendre.Density.GuthMaynard.gmS2ScheduledMain.eq_1
#print axioms Legendre.Density.GuthMaynard.gmS2ScheduledPhysicalBinBound.eq_1
#print axioms Legendre.Density.GuthMaynard.gmS2SourceScheduledBinBound.eq_1
#print axioms Legendre.Density.GuthMaynard.gmS2SourceScheduledBinBound_eq_main_add_error
#print axioms Legendre.Density.GuthMaynard.gmS2TracePaperShape.eq_1
#print axioms Legendre.Density.GuthMaynard.gmS2TracePaperShape_nonneg
#print axioms Legendre.Density.GuthMaynard.gmS2_card_rpow_sub_inv_le_sq
#print axioms Legendre.Density.GuthMaynard.gmS2_card_rpow_sub_three_quarter_inv_le_sq
#print axioms Legendre.Density.GuthMaynard.gmS2_dyadic_scale_le_height
#print axioms Legendre.Density.GuthMaynard.gmS2_not_near_inverse_scale
#print axioms Legendre.Density.GuthMaynard.gmS2_occupied_far_stationary
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceMode_cyclic_product_eq_integral
#print axioms Legendre.Density.GuthMaynard.gmScaledTraceMode_eq_integral
#print axioms Legendre.Density.GuthMaynard.gmTraceKernel_cyclic_phase
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDiagonalMoment_le
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_eq_diagonal_add_bins
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_eq_diagonal_add_offDiagonal
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_estimate
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_physical_schedule
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_powered_schedule
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_profile_paperShape
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_scheduled_physical
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_source_schedule
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroOffDiagonalMoment_eq_nested
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroOffDiagonalMoment_eq_sum_bins
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_eq_tsum_nonzeroScaledTraceMode
#print axioms Legendre.Density.GuthMaynard.gmTraceNonzeroTailAt_mul_mul_eq_tsum_modes
#print axioms Legendre.Density.GuthMaynard.gmTraceOscillation.eq_1
#print axioms Legendre.Density.GuthMaynard.gmTripleDecayProfile.eq_1
#print axioms Legendre.Density.GuthMaynard.gmTripleDecayProfile_add_two_le_of_outside
#print axioms Legendre.Density.GuthMaynard.gmTripleDecayProfile_nonneg
#print axioms Legendre.Density.GuthMaynard.gm_first_root_identity
#print axioms Legendre.Density.GuthMaynard.gm_powered_common_factor_eq
#print axioms Legendre.Density.GuthMaynard.gm_powered_scale_rpow_inv
#print axioms Legendre.Density.GuthMaynard.gm_powered_scale_rpow_two_inv
#print axioms Legendre.Density.GuthMaynard.gm_r_exponent_second_identity
#print axioms Legendre.Density.GuthMaynard.gm_r_exponent_third_identity
#print axioms Legendre.Density.GuthMaynard.gm_second_root_identity
#print axioms Legendre.Density.GuthMaynard.gm_third_root_identity
#print axioms Legendre.Density.GuthMaynard.harmonic_ceil_two_mul_le_epsilon_rpow
#print axioms Legendre.Density.GuthMaynard.harmonic_le_epsilon_rpow
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicBaseWeight
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicCutoffSq
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicRatioRawIntegrand
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicZWeight
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionDyadicMoment_le_native
#print axioms Legendre.Density.GuthMaynard.heathBrownReflectionDyadicMoment_le_powered
#print axioms Legendre.Density.GuthMaynard.integrableOn_gmCubicRAmplitude_cancellationSlab
#print axioms Legendre.Density.GuthMaynard.integrableOn_gmCubicRAmplitude_ratioSquare
#print axioms Legendre.Density.GuthMaynard.integrableOn_gmCubicSmoothedModeIntegrand
#print axioms Legendre.Density.GuthMaynard.integrableOn_norm_gmR_sq_smoothingNeighborhood
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicFourierIntegrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicLocalFourthKernel
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicRatioIntegrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicRatioRawIntegrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicS3ModeIntegrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicS3ModeSummedIntegrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicS3ModeSummedIntegrand_slice
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicSmoothedRIntegrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmCubicSmoothedR_fourth
#print axioms Legendre.Density.GuthMaynard.integrable_gmTraceOscillation_mul_kernel
#print axioms Legendre.Density.GuthMaynard.integral_cancellationSlice_amplitude_le_rawSmoothed
#print axioms Legendre.Density.GuthMaynard.integral_cancellationSlice_norm_gmR_div_sq_le
#print axioms Legendre.Density.GuthMaynard.integral_cancellationSlice_norm_gmR_sq_le_smoothedRSq_div
#print axioms Legendre.Density.GuthMaynard.integral_cancellationSlice_norm_mul_le_sqrt
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicFourierIntegrand_eq_ratioSquare
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicFourierIntegrand_split_slab
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicLocalFourthKernel_left
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicLocalFourthKernel_right
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicRatioIntegrand_eq_fourier
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicS3ModeSummedIntegrand_eq_sourceCube
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le_energy_epsilon
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le_epsilon_budget
#print axioms Legendre.Density.GuthMaynard.integral_integral_gmCubicS3ModeSummedIntegrand_eq_ratio
#print axioms Legendre.Density.GuthMaynard.integral_integral_gmCubicS3ModeSummedIntegrand_eq_ratio_all
#print axioms Legendre.Density.GuthMaynard.integral_localFourth_eq
#print axioms Legendre.Density.GuthMaynard.integral_triple_le_L2_L4_L4
#print axioms Legendre.Density.GuthMaynard.integral_z_v₁_v₂_gmCubicRatioIntegrand_eq_v₁_v₂_z
#print axioms Legendre.Density.GuthMaynard.intervalIntegral_norm_gmRPhase_fourth_le_defectWeights
#print axioms Legendre.Density.GuthMaynard.intervalIntegral_norm_gmRPhase_fourth_le_energy_epsilon
#print axioms Legendre.Density.GuthMaynard.intervalIntegral_norm_gmRPhase_fourth_le_energy_harmonic
#print axioms Legendre.Density.GuthMaynard.intervalIntegral_norm_gmRPhase_sq_le_epsilon
#print axioms Legendre.Density.GuthMaynard.intervalIntegral_norm_gmRPhase_sq_le_harmonic
#print axioms Legendre.Density.GuthMaynard.inv_abs_neg_div_eq_abs_div
#print axioms Legendre.Density.GuthMaynard.isCompact_gmCubicRatioBox
#print axioms Legendre.Density.GuthMaynard.le_rpow_inv_nat_of_pow_le
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmCubicCancellationSlab
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmCubicCancellationSlice
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmCubicRatioSquare
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmCubicSmoothingIncidence
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmCubicSmoothingNeighborhood
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmCubicSmoothingSupport
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmCubicSourceCube
#print axioms Legendre.Density.GuthMaynard.measurable_gmCubicLocalFourthKernel
#print axioms Legendre.Density.GuthMaynard.measurable_gmCubicSmoothedModeIntegrand
#print axioms Legendre.Density.GuthMaynard.measurable_gmCubicSmoothedR
#print axioms Legendre.Density.GuthMaynard.measurable_gmCubicSmoothedRIntegrand
#print axioms Legendre.Density.GuthMaynard.measurable_gmCubicSmoothedRIntegrand_uncurry
#print axioms Legendre.Density.GuthMaynard.measurable_gmCubicSmoothedRSq
#print axioms Legendre.Density.GuthMaynard.measurable_gmR
#print axioms Legendre.Density.GuthMaynard.measureReal_gmCubicSmoothingSupport_le
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicBalancedOrderedFrequencyBox
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicBalancedOrderedFrequencyBox._simp_1
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicDyadicFrequencyBlock
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicDyadicFrequencyBlock._simp_1
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicDyadicIndexPairs
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicDyadicIndexPairs._simp_1
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicFrequencyBox
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicFrequencyBox._simp_1
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicNonzeroFrequencyBox
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicNonzeroFrequencyBox._simp_1
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicOrderedFrequencyBox
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicOrderedFrequencyBox._simp_1
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicUnbalancedOrderedFrequencyBox
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicUnbalancedOrderedFrequencyBox._simp_1
#print axioms Legendre.Density.GuthMaynard.natAbs_frequencies_le_of_mem_gmCubicFrequencyBox
#print axioms Legendre.Density.GuthMaynard.natCast_sq_mul_twoPow_second_dyadicIndex_sq_le
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicFourierIntegrand_eq
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicFourierIntegrand_le_off_slab
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicFourierIntegrand_le_on_slab
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicFourierIntegrand_offSlabIntegral_le
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicFourierIntegrand_slabIntegral_le
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicFrequencyOscillation
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS3Mode_cyclic
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS3Mode_cyclic_two
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS3Mode_eq_of_mem_signedPermutations
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS3Mode_swap12_neg
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS3Truncated_le_ordered
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS3_le_balanced_source_box
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS3_le_one_dyadic_frequency_block
#print axioms Legendre.Density.GuthMaynard.norm_gmCubicS3_le_ordered_source_box
#print axioms Legendre.Density.GuthMaynard.norm_gmNormalizedPoweredCoeffs_le_one
#print axioms Legendre.Density.GuthMaynard.norm_gmPhaseIntervalKernel_le_floorDefectWeight
#print axioms Legendre.Density.GuthMaynard.norm_gmPhaseIntervalKernel_le_length
#print axioms Legendre.Density.GuthMaynard.norm_gmPhaseIntervalKernel_le_two_div
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_fourth_expand
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_le_card
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_neg
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_sq_expand
#print axioms Legendre.Density.GuthMaynard.norm_gmR_le_card_all
#print axioms Legendre.Density.GuthMaynard.norm_gmR_one_div
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceNonzeroTailAt_le_trace_add_zero
#print axioms Legendre.Density.GuthMaynard.norm_gmTraceOscillation
#print axioms Legendre.Density.GuthMaynard.norm_iteratedDeriv_gmCubicBaseWeight_le
#print axioms Legendre.Density.GuthMaynard.norm_iteratedDeriv_gmCubicCutoffSq_scaled_le
#print axioms Legendre.Density.GuthMaynard.norm_iteratedDeriv_gmCubicZWeight_le
#print axioms Legendre.Density.GuthMaynard.ofReal_intervalIntegral_norm_gmRPhase_fourth
#print axioms Legendre.Density.GuthMaynard.ofReal_intervalIntegral_norm_gmRPhase_sq
#print axioms Legendre.Density.GuthMaynard.one_div_frequencyRadius_add_one_pow_le
#print axioms Legendre.Density.GuthMaynard.pairSumFloor_energy_le
#print axioms Legendre.Density.GuthMaynard.pairSumFloor_square_le_strict_energy
#print axioms Legendre.Density.GuthMaynard.pow_rpow_inv_nat
#print axioms Legendre.Density.GuthMaynard.ratio_le_gmCubicFrequencyRadius
#print axioms Legendre.Density.GuthMaynard.rpow_inv_nat_add_three_le
#print axioms Legendre.Density.GuthMaynard.setIntegral_comp_affine_le_global
#print axioms Legendre.Density.GuthMaynard.setIntegral_comp_inv_le_four_mul
#print axioms Legendre.Density.GuthMaynard.setIntegral_gmCubicSmoothedR_fourth_cancellationCenter_dyadic_le
#print axioms Legendre.Density.GuthMaynard.setIntegral_gmCubicSmoothedR_fourth_cancellationCenter_le
#print axioms Legendre.Density.GuthMaynard.setIntegral_gmCubicSmoothedR_fourth_reflectedCenter_dyadic_le
#print axioms Legendre.Density.GuthMaynard.setIntegral_gmCubicSmoothedR_fourth_reflectedCenter_le
#print axioms Legendre.Density.GuthMaynard.setIntegral_norm_gmR_fourth_eq_logWeighted
#print axioms Legendre.Density.GuthMaynard.setIntegral_norm_gmR_fourth_le_energy_epsilon
#print axioms Legendre.Density.GuthMaynard.setIntegral_norm_gmR_sq_eq_logWeighted
#print axioms Legendre.Density.GuthMaynard.setIntegral_norm_gmR_sq_le_epsilon
#print axioms Legendre.Density.GuthMaynard.setIntegral_norm_gmR_sq_le_epsilon_budget
#print axioms Legendre.Density.GuthMaynard.setIntegral_preimage_div
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_gmNormalizedPoweredCoeffs
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_pow_eq_finitePowPoly
#print axioms Legendre.Density.GuthMaynard.sqrt_epsilon_moment_product_eq
#print axioms Legendre.Density.GuthMaynard.sqrt_holder_product_identity
#print axioms Legendre.Density.GuthMaynard.sqrt_two_mul_div_mul_sqrt_div_le
#print axioms Legendre.Density.GuthMaynard.strictAddEnergy.eq_1
#print axioms Legendre.Density.GuthMaynard.strict_energy_le_closed
#print axioms Legendre.Density.GuthMaynard.sum_Icc_gmPhaseFloorDefectWeight_le
#print axioms Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_le
#print axioms Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le
#print axioms Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_prop8_1
#print axioms Legendre.Density.GuthMaynard.sum_gmPhaseIntervalKernel_eq_pairPairs
#print axioms Legendre.Density.GuthMaynard.sum_gmS2ScheduledError_le_decay
#print axioms Legendre.Density.GuthMaynard.sum_gmS2ScheduledMain_le_paperShape
#print axioms Legendre.Density.GuthMaynard.sum_inv_distance_near_le_harmonic
#print axioms Legendre.Density.GuthMaynard.sum_norm_gmCubicNonzeroFrequencyBox_le_ordered
#print axioms Legendre.Density.GuthMaynard.sum_norm_gmCubicOrderedFrequencyBox_eq_balanced_add_unbalanced
#print axioms Legendre.Density.GuthMaynard.sum_norm_gmCubicOrdered_sourceRadius_le_balanced
#print axioms Legendre.Density.GuthMaynard.sum_norm_gmCubicSignedPermutations_le
#print axioms Legendre.Density.GuthMaynard.sum_norm_gmCubicUnbalancedOrderedFrequencyBox_le
#print axioms Legendre.Density.GuthMaynard.sum_norm_gmPoweredWide_sq
#print axioms Legendre.Density.GuthMaynard.sum_norm_gmPoweredWide_sq_le_blocks
#print axioms Legendre.Density.GuthMaynard.sum_pairPairs_comp_floorDefect
#print axioms Legendre.Density.GuthMaynard.sum_pairSumFloorCount_sq
#print axioms Legendre.Density.GuthMaynard.sum_pairSumFloorCount_sq_correlationSupport
#print axioms Legendre.Density.GuthMaynard.sum_range_gmPhaseFloorDefectWeight_le
#print axioms Legendre.Density.GuthMaynard.sum_shifted_pairSumFloorCount_sq_correlationSupport
#print axioms Legendre.Density.GuthMaynard.summable_gmIntDecayProfile
#print axioms Legendre.Density.GuthMaynard.summable_gmTripleDecayProfile
#print axioms Legendre.Density.GuthMaynard.summable_norm_gmNonzeroScaledTraceMode
#print axioms Legendre.Density.GuthMaynard.twoPow_second_dyadicIndex_le_two_ratio
#print axioms Legendre.Density.GuthMaynard.two_div_gmCubicSmoothingScale
#print axioms Legendre.Density.GuthMaynard.two_frequencyRadius_add_one_le_five_rpow
#print axioms Legendre.Density.GuthMaynard.volume_real_gmCubicRatioSquare
#print axioms Legendre.Literature.layer4_guth_poisson_tail_moment_comparator
#print axioms Legendre.Literature.layer4_guth_s2_comparator
#print axioms Legendre.Literature.layer4_guth_s3_energy_comparator
#print axioms Legendre.Literature.layer4_guth_s3_strict_energy_comparator
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.card_gmCubicDyadicFrequencyBlock_le_scales._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.card_gmCubicDyadicFrequencyBlock_le_scales._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.card_gmCubicDyadicFrequencyBlock_le_scales._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.continuous_fintype_sum"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.cubic_mode_far_error_le"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.cubic_mode_far_error_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.cubic_mode_far_error_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.cubic_mode_far_error_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.cubic_mode_far_error_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.cubic_mode_far_error_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.cubic_mode_far_error_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.cubic_mode_far_error_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmCubicDyadicFrequencyBlock._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmCubicOrderedDyadicFrequencyBlock._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmCubicOrderedDyadicFrequencyBlock._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmCubicOrderedDyadicFrequencyBlock._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_gmNonzeroScaledTraceMode_decay._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_norm_gmCubicS3FrequencyTail_le_mixed._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_norm_gmCubicS3FrequencyTail_le_mixed._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_norm_gmCubicS3FrequencyTail_le_mixed._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_norm_gmCubicS3FrequencyTail_le_mixed._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_norm_gmCubicS3Mode_le_decay._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_norm_gmCubicS3Mode_le_decay._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_ordered_gmCubicS3Mode._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_ordered_gmCubicS3Mode._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_ordered_gmCubicS3Mode._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_ordered_gmCubicS3Mode._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.exists_ordered_gmCubicS3Mode._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicCancellationSlab_eq_empty_of_unbalanced._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicCancellationSlab_ordered_comparable._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicCancellationSlab_ordered_comparable._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicDyadicFrequencyBlock_subset_boundingBox._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicDyadicLogFactor_sq_le_realLog_sq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicRatioRawIntegrand_eq_zero_of_not_mem_box._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicRatioRawIntegrand_eq_zero_of_not_mem_box._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicRatioRawIntegrand_eq_zero_of_not_mem_box._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3ModeSummedIntegrand_eq_zero_of_not_mem_sourceCube._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3ModeSummedIntegrand_eq_zero_of_not_mem_sourceCube._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3ModeSummedIntegrand_eq_zero_of_not_mem_sourceCube._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3Mode_prop7_2._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3Truncated_eq_sum_nonzero._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3Truncated_eq_sum_nonzero._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_explicit._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_explicit._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_explicit._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_explicit._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_explicit._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_explicit._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_explicit._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_native._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicS3_prop8_1_native._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicSmoothedModeIntegral_holder._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_sq_le_localFourth._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_sq_le_localFourth._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_sq_le_localFourth._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_sq_le_localFourth._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_sq_le_localFourth._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_sq_le_localFourth._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_sq_le_localFourth._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicTail_scale_identity._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicTail_scale_identity._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicTail_scale_identity._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicTail_scale_identity._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicTail_scale_identity._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicTail_scale_identity._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicTail_scale_identity._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmCubicUnbalanced_card_error_absorbed._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmIntDecayProfile_add_two_le_of_outside._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmIntDecayProfile_add_two_le_of_outside._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmIntDecayProfile_add_two_le_of_outside._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmIntDecayProfile_add_two_le_of_outside._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmIntDecayProfile_add_two_le_of_outside._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmIntDecayProfile_add_two_le_of_outside._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmPairSumFloorDefectCount_eq_correlation._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmPairSumFloorDefectCount_eq_correlation._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmPairSumFloorDefectSupport_subset_Icc._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmPairSumFloorDefectSupport_subset_Icc._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmPhaseFloorDefectWeight_natCast_of_two_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmTripleDecayProfile_add_two_le_of_outside._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.gmTripleDecayProfile_add_two_le_of_outside._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integrable_fintype_sum"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_fintype_sum"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicFourierIntegrand_split_slab._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicFourierIntegrand_split_slab._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicFourierIntegrand_split_slab._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicLocalFourthKernel_left._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicLocalFourthKernel_left._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_gmCubicSmoothedR_fourth_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.integral_norm_iteratedFDeriv_gmCubicZWeight_le"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.intervalIntegral_norm_gmRPhase_sq_le_harmonic._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.intervalIntegral_norm_gmRPhase_sq_le_harmonic._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.mem_gmCubicDyadicIndexPairs._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.mem_gmCubicFrequencyBox._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.norm_gmCubicS3Mode_eq_of_mem_signedPermutations._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.norm_gmCubicS3Mode_eq_of_mem_signedPermutations._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.norm_iteratedDeriv_mul_le_sum"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.pairSumFloor_energy_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.pairSumFloor_energy_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_affine_le_global._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_affine_le_global._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_affine_le_global._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_affine_le_global._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_affine_le_global._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_affine_le_global._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_affine_le_global._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_inv_le_four_mul._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_inv_le_four_mul._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_inv_le_four_mul._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_inv_le_four_mul._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_inv_le_four_mul._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_inv_le_four_mul._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.setIntegral_comp_inv_le_four_mul._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sqrt_two_mul_div_mul_sqrt_div_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sqrt_two_mul_div_mul_sqrt_div_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sqrt_two_mul_div_mul_sqrt_div_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sqrt_two_mul_div_mul_sqrt_div_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sqrt_two_mul_div_mul_sqrt_div_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sqrt_two_mul_div_mul_sqrt_div_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sqrt_two_mul_div_mul_sqrt_div_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_biUnion_le_sum_sum"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_dyadic_scale_le._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_pairSumFloorCount_sq._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_pairSumFloorCount_sq._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_pairSumFloorCount_sq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_pairSumFloorCount_sq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_pairSumFloorCount_sq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_range_gmPhaseFloorDefectWeight_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_range_gmPhaseFloorDefectWeight_le._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_shifted_pairSumFloorCount_sq_correlationSupport._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_shifted_pairSumFloorCount_sq_correlationSupport._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.sum_union_le_sum_add"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.summable_fintype_sum"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.tsum_fintype_sum"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.twoPow_second_dyadicIndex_le_two_ratio._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTail.0.Legendre.Density.GuthMaynard.twoPow_second_dyadicIndex_le_two_ratio._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_gmNonzeroTailBinMoment_near_bound._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.exists_norm_gmTraceNonzeroTailAt_le_sqrt_near._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmDifferenceMoment_pow_le_heathBrown._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmDifferenceMoment_pow_le_heathBrown._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmNonzeroTailBinMoment_le_reflection._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmRetainedSignedReflection_near_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmRetainedSignedReflection_near_bound._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmRetainedSignedReflection_near_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmRetainedSignedReflection_near_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmRetainedSignedReflection_near_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmRetainedSignedReflection_near_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmRetainedSignedReflection_near_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2FixedClog_add_one_le_commonExponent._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2FixedLengthEpsilonLoss_le_profile_sq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2PhysicalBinMain_le_paperShape._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2PhysicalBinMain_le_paperShape._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_eq._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_eq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_eq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_eq._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_eq._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_sq_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_sq_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_sq_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_sq_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_sq_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_sq_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2ReflectionCoefficient_mul_length_sq_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2_not_near_inverse_scale._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmS2_occupied_far_stationary._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_powered_schedule._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_profile_paperShape._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_profile_paperShape._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_scheduled_physical._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_le_source_schedule._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.norm_gmNormalizedPoweredCoeffs_le_one._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_gmNormalizedPoweredCoeffs._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_gmNormalizedPoweredCoeffs._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_gmNormalizedPoweredCoeffs._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_gmNormalizedPoweredCoeffs._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_gmNormalizedPoweredCoeffs._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_gmNormalizedPoweredCoeffs._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_gmNormalizedPoweredCoeffs._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicTwoTailEstimate.0.Legendre.Density.GuthMaynard.sum_norm_gmPoweredWide_sq._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyTolerance.0.Legendre.Density.GuthMaynard.abs_pairSumFloorDefect_le_one_of_closed._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyTolerance.0.Legendre.Density.GuthMaynard.abs_pairSumFloorDefect_le_one_of_closed._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyTolerance.0.Legendre.Density.GuthMaynard.pairSumFloor_square_le_strict_energy._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyTolerance.0.Legendre.Density.GuthMaynard.pairSumFloor_square_le_strict_energy._simp_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.IsSeparated.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmCubicS2.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmS2TracePaperShape.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_energy_boundary_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_energy_comparison_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_s2_empty_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_s2_k_two_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_s3_singleton_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_s3_singleton_consumer._simp_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_tail_moment_k_two_consumer"

-- Affine smoothing, height-family uniformity and physical S3/energy refinement.
#print axioms Legendre.Density.GuthMaynard.GMAffineDepthSupported.eq_1
#print axioms Legendre.Density.GuthMaynard.GMAffineDepthSupported.iterationSupported
#print axioms Legendre.Density.GuthMaynard.GMAffineFourierMassBound._proof_1
#print axioms Legendre.Density.GuthMaynard.GMAffineHeightFourierMassBound._proof_1
#print axioms Legendre.Density.GuthMaynard.GMAffineHeightFourierMassBound.eq_1
#print axioms Legendre.Density.GuthMaynard.GMAffineHeightFourierMassBound.nonneg_coefficient
#print axioms Legendre.Density.GuthMaynard.GMAffineHeightFourierMassBound.pointwise
#print axioms Legendre.Density.GuthMaynard.GMAffineHeightFourierMassProfile.atDepth_zero
#print axioms Legendre.Density.GuthMaynard.GMAffineHeightFourierMassProfileAtDepth._proof_1
#print axioms Legendre.Density.GuthMaynard.GMAffineHeightFourierMassProfileAtDepth.eq_1
#print axioms Legendre.Density.GuthMaynard.GMAffineIterationSupported._proof_1
#print axioms Legendre.Density.GuthMaynard.GMAffineLemma92RecurrenceAt._proof_1
#print axioms Legendre.Density.GuthMaynard.GMAffineLemma92RecurrenceAt.toMassRecurrence
#print axioms Legendre.Density.GuthMaynard.GMAffineSourceSupported._proof_1
#print axioms Legendre.Density.GuthMaynard.GMAffineSourceSupported.depthSupported_zero
#print axioms Legendre.Density.GuthMaynard.GMAffineSourceSupported.iterationSupported
#print axioms Legendre.Density.GuthMaynard.GMAffineSourceSupported.supportedOn
#print axioms Legendre.Density.GuthMaynard.GMAffineSupportedOn.iterationSupported
#print axioms Legendre.Density.GuthMaynard.GMAffineSupportedOn.mono
#print axioms Legendre.Density.GuthMaynard.GMAffineSupportedOn.wideDepthSupported_zero
#print axioms Legendre.Density.GuthMaynard.GMAffineWideDepthSupported._proof_1
#print axioms Legendre.Density.GuthMaynard.GMAffineWideDepthSupported._proof_2
#print axioms Legendre.Density.GuthMaynard.GMAffineWideDepthSupported.eq_1
#print axioms Legendre.Density.GuthMaynard.GMAffineWideDepthSupported.iterationSupported
#print axioms Legendre.Density.GuthMaynard.abs_add_product_lt_gmAffineFirstPoissonRadius
#print axioms Legendre.Density.GuthMaynard.abs_affine_ratio_le
#print axioms Legendre.Density.GuthMaynard.abs_directTriple_central_le
#print axioms Legendre.Density.GuthMaynard.abs_directTriple_first
#print axioms Legendre.Density.GuthMaynard.abs_gmAffinePositiveShell_le_scale
#print axioms Legendre.Density.GuthMaynard.abs_gmAffineSignedShell_le_scale
#print axioms Legendre.Density.GuthMaynard.abs_log_le_two_mul_abs_sub_one
#print axioms Legendre.Density.GuthMaynard.abs_reflectedTriple_central_le
#print axioms Legendre.Density.GuthMaynard.abs_reflectedTriple_first
#print axioms Legendre.Density.GuthMaynard.abs_sub_gmHalfDifferenceBin_le_half
#print axioms Legendre.Density.GuthMaynard.add_int_eq_fract_add_translated
#print axioms Legendre.Density.GuthMaynard.affine_ratio_lower_bound
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_affine
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_le_three_card_cubed
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_mul_largeValue_sq_le_thirdMoment_raw
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_one_eq_sum_floorEnergy
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_scale
#print axioms Legendre.Density.GuthMaynard.approxAddEnergy_translate
#print axioms Legendre.Density.GuthMaynard.approxFloorEnergy_zero_le_addEnergy
#print axioms Legendre.Density.GuthMaynard.card_cubed_le_gmDiscreteRatioMoment_three
#print axioms Legendre.Density.GuthMaynard.card_filter_abs_sub_le_one_le_three
#print axioms Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one
#print axioms Legendre.Density.GuthMaynard.card_gmAffineCentralShell
#print axioms Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonEllRange_real_le
#print axioms Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonEllRange_real_le_source
#print axioms Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonPair_fiber_le_divisorsAntidiag
#print axioms Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonPairs_eq_sum
#print axioms Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonPairs_le_sum_divisors
#print axioms Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonPairs_real_le_of_divisor
#print axioms Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonProductRange_real_le
#print axioms Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonProducts_real_le
#print axioms Legendre.Density.GuthMaynard.card_gmAffineIndexSet_le
#print axioms Legendre.Density.GuthMaynard.card_gmAffineIndexSet_le_scaleProduct
#print axioms Legendre.Density.GuthMaynard.card_gmAffineNegFrequencyImage
#print axioms Legendre.Density.GuthMaynard.card_gmAffinePoissonNearSet_le
#print axioms Legendre.Density.GuthMaynard.card_gmAffinePoissonNearSet_real_le
#print axioms Legendre.Density.GuthMaynard.card_gmAffinePositiveShell
#print axioms Legendre.Density.GuthMaynard.card_gmAffinePositiveShell_real_le_two_mul
#print axioms Legendre.Density.GuthMaynard.card_gmAffineScaledNearSet_le
#print axioms Legendre.Density.GuthMaynard.card_gmAffineSignedShell_le
#print axioms Legendre.Density.GuthMaynard.card_gmHalfDifferenceDyadicPairFiber_lt
#print axioms Legendre.Density.GuthMaynard.card_gmHalfDifferenceMatchedPairs_le_energy
#print axioms Legendre.Density.GuthMaynard.card_gmHalfDifferenceTranslatedClass
#print axioms Legendre.Density.GuthMaynard.card_gmReducedLogRatios
#print axioms Legendre.Density.GuthMaynard.card_gmReducedRatioPairs_le_four_mul_sq
#print axioms Legendre.Density.GuthMaynard.card_int_divisorsAntidiag_eq_two_mul_natAbs_divisors
#print axioms Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicRWeightSchwartz
#print axioms Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicTruncatedRWeightSchwartz
#print axioms Legendre.Density.GuthMaynard.card_sq_le_fortyeight_mul_T_mul_integral_normalizedRWeight
#print axioms Legendre.Density.GuthMaynard.card_sq_le_sixteen_mul_T_mul_integral_gmCubicRWeightSchwartz
#print axioms Legendre.Density.GuthMaynard.card_sq_le_sixteen_mul_T_mul_integral_gmCubicTruncatedRWeightSchwartz
#print axioms Legendre.Density.GuthMaynard.cast_card_filter_abs_sub_le_ratio
#print axioms Legendre.Density.GuthMaynard.cast_card_gmReducedRatioPairs_le_four_mul_sq
#print axioms Legendre.Density.GuthMaynard.conj_fourier_gmAffineComplexify_eq_integral
#print axioms Legendre.Density.GuthMaynard.contDiffAt_ofReal_cpow_mul_I_public
#print axioms Legendre.Density.GuthMaynard.contDiff_gmAffineCentralWeightFunction
#print axioms Legendre.Density.GuthMaynard.contDiff_gmAffineLocalBumpFunction
#print axioms Legendre.Density.GuthMaynard.contDiff_gmAffineScaledBumpFunction
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicAffineSourceFunction
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicPairMellinAtom
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicPreSmoothingWindowComplexFunction
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicRWeightFunction
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicRatioBumpComplexFunction
#print axioms Legendre.Density.GuthMaynard.contDiff_gmCubicTruncatedRWeightFunction
#print axioms Legendre.Density.GuthMaynard.contDiff_gmRPhase
#print axioms Legendre.Density.GuthMaynard.continuous_gmAffineMiddleFourierBlock
#print axioms Legendre.Density.GuthMaynard.continuous_gmAffineMiddleTauWeight
#print axioms Legendre.Density.GuthMaynard.continuous_gmAffineTransformSum
#print axioms Legendre.Density.GuthMaynard.continuous_gmCubicReflectedAffineAggregate
#print axioms Legendre.Density.GuthMaynard.continuous_gmFiniteExpSum
#print axioms Legendre.Density.GuthMaynard.disjoint_gmAffineLowFrequencyRegion_high
#print axioms Legendre.Density.GuthMaynard.disjoint_gmAffineLowFrequencyRegion_middle
#print axioms Legendre.Density.GuthMaynard.disjoint_gmAffineMiddleFrequencyRegion_high
#print axioms Legendre.Density.GuthMaynard.energy_sqrt_term_rearrangement
#print axioms Legendre.Density.GuthMaynard.exists_bounded_gmHalfDifferenceDyadicClass
#print axioms Legendre.Density.GuthMaynard.exists_card_gmAffineFirstPoissonPairs_middle_real_le
#print axioms Legendre.Density.GuthMaynard.exists_card_gmAffineFirstPoissonPairs_real_le
#print axioms Legendre.Density.GuthMaynard.exists_global_card_gmAffineFirstPoissonPairs_middle_real_le
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineFourierDecayUniform_with_product_le
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineHeightDecayConstant
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_explicit_frequency_regions
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_raw_lemma92
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_raw_lemma92_of_constants
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92_components
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92_components._proof_1
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92_components_of_constants
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92_recurrence
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_regionI_add_middle_add_high
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineLocalBumpFourier_tail_bound
#print axioms Legendre.Density.GuthMaynard.exists_gmAffineTransformIntegral_eq_J
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_J_aligned
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_J_at_cutoff
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_J_at_cutoff._proof_1
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_J_physical
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_J_physical._proof_1
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_sigmaIIReal_add_source_tails
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_sigmaIIReal_add_tails
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleFrequencyRegion_main_sq_le_sigmaIIReal_add_tail
#print axioms Legendre.Density.GuthMaynard.exists_integral_gmAffineMiddleTauWeightedBlockRealSq_le_source_decay
#print axioms Legendre.Density.GuthMaynard.exists_n_C_forall_gmAffineJ_le_source_lemma92_of_ratio
#print axioms Legendre.Density.GuthMaynard.exists_n_C_forall_gmAffineJ_le_source_lemma92_of_ratio._proof_1
#print axioms Legendre.Density.GuthMaynard.exists_n_Cdiv_forall_gmAffineLemma92HeightMassRecurrence
#print axioms Legendre.Density.GuthMaynard.exists_n_Cdiv_forall_gmAffineLemma92MassRecurrence
#print axioms Legendre.Density.GuthMaynard.exists_n_Cdiv_forall_gmAffineLemma92Recurrence
#print axioms Legendre.Density.GuthMaynard.exists_nat_mul_ge_of_pos
#print axioms Legendre.Density.GuthMaynard.exists_nat_three_halves_pow_mul_ge_hundred
#print axioms Legendre.Density.GuthMaynard.exists_norm_gmAffineMiddleFourierBlockReal_le_source_decay
#print axioms Legendre.Density.GuthMaynard.exists_sum_gmAffineMiddleBlockMass_neg_le_sigmaIIReal_add_source_tail
#print axioms Legendre.Density.GuthMaynard.exists_sum_gmAffineMiddleTail_mass_le_source_decay
#print axioms Legendre.Density.GuthMaynard.exists_uniform_card_gmAffineFirstPoissonPairs_middle_real_le
#print axioms Legendre.Density.GuthMaynard.exists_uniform_constants_gmAffineLemma92Components
#print axioms Legendre.Density.GuthMaynard.exists_uniform_constants_gmAffineLemma92Components_with_tail_product
#print axioms Legendre.Density.GuthMaynard.exists_uniform_constants_gmAffineLemma92Recurrence
#print axioms Legendre.Density.GuthMaynard.exists_uniform_gmAffineJ_le_finite_descent
#print axioms Legendre.Density.GuthMaynard.exists_uniform_gmAffineJ_le_height_finite_descent
#print axioms Legendre.Density.GuthMaynard.exists_uniform_gmAffineJ_le_source_lemma92
#print axioms Legendre.Density.GuthMaynard.finiteExpSum_fourier_reproduction
#print axioms Legendre.Density.GuthMaynard.finset_sum_comp_le_sum_of_injOn
#print axioms Legendre.Density.GuthMaynard.floorAdditiveDefect.eq_1
#print axioms Legendre.Density.GuthMaynard.floorAdditiveDefect_mem_Icc
#print axioms Legendre.Density.GuthMaynard.floorAdditiveQuadruple.eq_1
#print axioms Legendre.Density.GuthMaynard.four_mul_add_two_rpow_le_six_mul
#print axioms Legendre.Density.GuthMaynard.fourierDeweightFiniteBlock_logShift_coeffs_native
#print axioms Legendre.Density.GuthMaynard.fourier_gmAffineComplexify_eq_integral
#print axioms Legendre.Density.GuthMaynard.fourier_gmAffineComplexify_normalizedRWeight
#print axioms Legendre.Density.GuthMaynard.fourier_gmAffineComplexify_tilde
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_near_add_far
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_scaled
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_tau
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_polynomial_decay
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralShell.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralShell_subset_smooth
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeight._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeightFunction.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeightSchwartz.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeightSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeightSchwartz_int_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeight_eq_one
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeight_eq_zero_of_not_mem
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeight_le_one
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeight_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineCentralWeight_poisson
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify._proof_2
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify_cubicRWeight_eq_pair_sum
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify_normalizedRWeight_eq_affineTerm
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify_normalizedRWeight_eq_affineTerm._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify_normalizedRWeight_eq_affineTerm._proof_2
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify_tilde_eq_convolution
#print axioms Legendre.Density.GuthMaynard.gmAffineComplexify_truncatedRWeight_eq_mul
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonEllRange.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonPairTerm.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonPairTerm_eq_middleBlock
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonPair_product_ne_zero
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonPairs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonProductRange.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonProducts_subset_range
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonRadius._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonRadius_card_factor_mul_scale_le
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonRadius_le_of_scale
#print axioms Legendre.Density.GuthMaynard.gmAffineFirstPoissonRegionI_le_source_scale
#print axioms Legendre.Density.GuthMaynard.gmAffineFourierDecayAt_of_one_le
#print axioms Legendre.Density.GuthMaynard.gmAffineFourierDecayEnvelope_le_source
#print axioms Legendre.Density.GuthMaynard.gmAffineFourierDecayEnvelope_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineFourierDecayUniform
#print axioms Legendre.Density.GuthMaynard.gmAffineFourierPair_eq_iteratedIntegral
#print axioms Legendre.Density.GuthMaynard.gmAffineFourierPair_eq_prodIntegral
#print axioms Legendre.Density.GuthMaynard.gmAffineHighFrequencyIntegralFactor_le
#print axioms Legendre.Density.GuthMaynard.gmAffineHighFrequencyRegion.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineHighFrequencyRegion_eq_union
#print axioms Legendre.Density.GuthMaynard.gmAffineImage_eq_translate_scale
#print axioms Legendre.Density.GuthMaynard.gmAffineIndexSet.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineInitialFourierMassProfile_atDepth_zero
#print axioms Legendre.Density.GuthMaynard.gmAffineInitialFourierMassProfile_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineIntegralValues_nonempty
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationCorePower_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationDoubleSix_rpow_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationEta._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationEta_le_delta_div_twenty
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationEta_le_one
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationEta_pos
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationQ_cube_eq
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationQ_cube_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationQ_mul_M_le_four_Y
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationRegionIIFirstTail_scale_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationRegionIIHighTail_scale_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationRegionIII_height_scale_le_one
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationRegionIII_scale_le_one
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationRegionIII_source_scale_eq
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationRegionIIScaleFactor_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationRegionIISecondTail_height_ratio_le_one
#print axioms Legendre.Density.GuthMaynard.gmAffineIterationRegionIISecondTail_scale_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIteration_M_pow_add_three_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIteration_M_pow_four_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIteration_M_pow_three_le
#print axioms Legendre.Density.GuthMaynard.gmAffineIteration_Y_add_Q_add_one_le
#print axioms Legendre.Density.GuthMaynard.gmAffineJ.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineJ_le_crude
#print axioms Legendre.Density.GuthMaynard.gmAffineJ_le_proposition9_base
#print axioms Legendre.Density.GuthMaynard.gmAffineJ_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineLemma92ComponentsAt_to_heightMassRecurrence
#print axioms Legendre.Density.GuthMaynard.gmAffineLemma92ComponentsAt_to_heightMassRecurrence._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineLemma92ComponentsAt_to_recurrence
#print axioms Legendre.Density.GuthMaynard.gmAffineLemma92ComponentsAt_to_recurrence._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpDual.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpDual_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpDual_polynomial_decay
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpFourierSup._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpFourierSup_pos
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpFourierTailConstant.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpFourierTailConstant_bound
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpFourierTailConstant_pos
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpFourier_polynomial_decay
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpFunction.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineLocalBumpSchwartz_one_on_dyadicLog
#print axioms Legendre.Density.GuthMaynard.gmAffineLowFrequencyRegion.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineLowFrequencyRegion_eq_Icc
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleBlockMass_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleCenter.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleCore_subset_frequencySupport
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleEllSource_eq_equation97
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleFarSourceConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleFourierArgument_abs_lower
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_natCast
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_scale_tau
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleFrequencyRegion.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleFrequencySupport.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleNearKernelNormSum._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleNearKernelNormSum.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleNearKernelNormSum_le_physical
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddlePairPhase_exp_eq_Z₁_mul_Z₂
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleTail.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleTauWeight_eq_zero_of_not_mem
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleTauWeight_le_one
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleTauWeight_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleTauWeight_one
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleTauWeight_one_of_abs_lt
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleWeightedComponent_eq_Z₁
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleZ₂Finite_support_eq_Z₂
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_eq_near_add_far
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineMiddle_cutoff_eq_scaled
#print axioms Legendre.Density.GuthMaynard.gmAffineM₂FourierBlock_eq_middleBlock
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonEnvelopes_le_mass
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarFourier.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarMajorant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarMajorant._proof_2
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarMode.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_decayProfile
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_exception
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_majorant
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarSeries.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonFarTerm.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonMainFourier.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonMainFourier_eq_sum_pairs
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonNearKernelEnvelope.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonNearKernelEnvelope_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonNearTerm.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonNearTerm_eq_zero_of_not_mem
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonTailKernelEnvelope.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffinePoissonTailKernelEnvelope_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffinePositiveShell.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffinePositiveShell_ne_zero
#print axioms Legendre.Density.GuthMaynard.gmAffinePositiveShell_scale_le_abs
#print axioms Legendre.Density.GuthMaynard.gmAffinePositiveTransformSum_le_transformSum
#print axioms Legendre.Density.GuthMaynard.gmAffinePositiveTransformSum_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIFarConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIFarConstant._proof_2
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIFarConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIICoreConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIICoreConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIFirstPoissonTail_le
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIHighTail_le
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIIEnvelopeConstant_le_mass
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIIEnvelopeConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIIEnvelopeMassConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIIKernelConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIIKernelConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIIKernelEnvelope_le
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIIRawBound_le_source
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIISourceBound_le_constant
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIISourceBound_le_heightMass
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIPrefactor_le
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIRawBound._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIRawBound._proof_2
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIIRawBound_eq_core_add_tail
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIISecondPoissonTail_le
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailAbsorptionConstant_le_invariant
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailAbsorptionConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailInvariantBound_le_mass_sq
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailInvariantBound_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailMassConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailRawBound_le_source
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailSourceBound._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailSourceBound._proof_2
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailSourceBound._proof_3
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailSourceBound_le_constant
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailSourceBound_le_heightMass
#print axioms Legendre.Density.GuthMaynard.gmAffineRegionIITailSourceBound_le_scale_ratios
#print axioms Legendre.Density.GuthMaynard.gmAffineRetainedFirstPoissonPairSquare.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineRetainedFirstPoissonPairSquare_eq_scaled_profile
#print axioms Legendre.Density.GuthMaynard.gmAffineRetainedNeighborhoodSum_le_positiveTransform
#print axioms Legendre.Density.GuthMaynard.gmAffineRetainedNeighborhoodSum_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineScaleTriples.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineScaleTriples_nonempty
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBumpDual.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBumpDual.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_near_add_far
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_scaled
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_polynomial_decay
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBumpFunction.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBumpSchwartz.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBumpSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledBump_poisson
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledFarSeries.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledFarTerm.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledNearTerm.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineScaledNearTerm_eq_zero_of_not_mem
#print axioms Legendre.Density.GuthMaynard.gmAffineSecondPoissonCutoff_div_Q_eq
#print axioms Legendre.Density.GuthMaynard.gmAffineSecondPoissonCutoff_div_scale_le
#print axioms Legendre.Density.GuthMaynard.gmAffineSecondPoissonCutoff_ge_Q
#print axioms Legendre.Density.GuthMaynard.gmAffineSecondPoissonCutoff_pos
#print axioms Legendre.Density.GuthMaynard.gmAffineSecondPoissonCutoff_width
#print axioms Legendre.Density.GuthMaynard.gmAffineSecondPoissonSmoothingScale_ge
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIAtWidth_eq_finiteSupport
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIAtWidth_eq_real
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIEquation97_eq_integral_integrand
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIFarCoefficient_le
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIFarEnvelope_eq_coefficient_mul
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIFinite_eq_equation97
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIFinite_eq_expandedFourierPairs
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIFinite_eq_expanded_Z₁_Z₂_integrands
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIINearEnvelope.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIINearEnvelope_le_physical
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIPhysicalEnvelope.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIReal_eq_finiteSupport
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIReal_one_eq_sigmaII
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaIIReal_scale_window
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaII_eq_equation97
#print axioms Legendre.Density.GuthMaynard.gmAffineSigmaII_eq_finiteSupport
#print axioms Legendre.Density.GuthMaynard.gmAffineSignedShell.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineSignedShell_ne_zero
#print axioms Legendre.Density.GuthMaynard.gmAffineSignedShell_scale_le_abs
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothCentralShell.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothTransformSchwartz._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothTransformSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothTransformSchwartz_fourier
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothTransformSchwartz_fourier_eq_main_add_far
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothTransformSchwartz_fourier_poisson
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothTransformSchwartz_fourier_regroup
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothTransformSum_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothingKernel._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothingKernel.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothingKernel.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineSmoothingKernel_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineTerm.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartz._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartz._proof_2
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartz._proof_3
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartz._proof_4
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartz._proof_5
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartz.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartzTotal.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartzTotal_apply_of_ne
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartzTotal_fourier_of_ne
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineTermSchwartz_fourier
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeIterate.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeIterate_fourierDecayAt
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeIterate_iterationSupported
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeIterate_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeIterate_succ
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeIterate_supportedOn
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeIterate_zero
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz._proof_2
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz._proof_3
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz._proof_4
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz._proof_5
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz._proof_6
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_apply_sub
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_depthSupported_succ
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_eq_zero_of_not_mem_support
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_eq_zero_of_not_mem_support._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_fourierMassBound
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_fourierMassProfile
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_fourierMassProfileAtDepth_succ
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_heightFourierMassBound
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_heightFourierMassFamilyAtDepth_succ
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_heightFourierMassProfileAtDepth_succ
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_iterationSupported
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_supportedOn
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_weighted_norms_le_sixteen
#print axioms Legendre.Density.GuthMaynard.gmAffineTildeSchwartz_wideDepthSupported_succ
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformIntegral.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_J
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude_scales
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_indexSum
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_smooth_fourier
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformSum.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformSum_eq_indexSum
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformSum_le_smooth
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformSum_nonneg
#print axioms Legendre.Density.GuthMaynard.gmAffineTransformSum_sq_le
#print axioms Legendre.Density.GuthMaynard.gmAffineTranslationPhaseSum._proof_1
#print axioms Legendre.Density.GuthMaynard.gmAffineTranslationPhaseSum_eq_tsum
#print axioms Legendre.Density.GuthMaynard.gmAffineTranslationPhaseSum_poisson
#print axioms Legendre.Density.GuthMaynard.gmAffineUnitInterval.eq_1
#print axioms Legendre.Density.GuthMaynard.gmAffine_finite_exponent_descent
#print axioms Legendre.Density.GuthMaynard.gmAffine_frequency_regions_union
#print axioms Legendre.Density.GuthMaynard.gmAffine_mixed_weight_le
#print axioms Legendre.Density.GuthMaynard.gmAffine_proposition9_1_height_family_native
#print axioms Legendre.Density.GuthMaynard.gmAffine_proposition9_1_native
#print axioms Legendre.Density.GuthMaynard.gmAffine_proposition9_finite_induction
#print axioms Legendre.Density.GuthMaynard.gmApproxAddEnergy_largeValues_native
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineSourceFunction.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineSourceSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineSourceSchwartz_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineSourceSchwartz_supportedOn
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineTerminalScale_le_height_four
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineTerminalScale_le_ratio
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineWindow._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineWindow._proof_2
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineWindow._proof_3
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineWindow._proof_4
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineWindow._proof_5
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineWindow_eq_zero_of_not_mem_Icc
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineWindow_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicAffineWindow_one
#print axioms Legendre.Density.GuthMaynard.gmCubicCoherenceRadius._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicCoherenceRadius_pos
#print axioms Legendre.Density.GuthMaynard.gmCubicDirectAffineScales_mem_terminal
#print axioms Legendre.Density.GuthMaynard.gmCubicDyadicFrequencyBlock_denominator_split
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump_eq_one_of_mem_gmAffineMiddleCore
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump_middleFrequency_eq_zero_of_not_mem
#print axioms Legendre.Density.GuthMaynard.gmCubicLocalBump_mul_fourierPairIntegral_eq_tripleKernel
#print axioms Legendre.Density.GuthMaynard.gmCubicMellinDerivativePower_le
#print axioms Legendre.Density.GuthMaynard.gmCubicNativeAffineSourceSchwartz.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmCubicNativeAffineSourceSchwartz_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicNativeAffineSource_eq_original_on_activeInterval
#print axioms Legendre.Density.GuthMaynard.gmCubicNativeAffineSource_eq_original_on_sourceInterval
#print axioms Legendre.Density.GuthMaynard.gmCubicNativeAffineSource_heightFourierMassFamilyAtDepth_zero
#print axioms Legendre.Density.GuthMaynard.gmCubicNativeAffineSource_proposition9_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNativeAffineSource_supportedOn
#print axioms Legendre.Density.GuthMaynard.gmCubicNativeHeightProfileConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicNegativeDenominatorBlock.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSourceSchwartz._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSourceSchwartz._proof_2
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSourceSchwartz.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSourceSchwartz.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSourceSchwartz_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSource_directTriple
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSource_eq_original
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSource_heightFourierMassFamilyAtDepth_zero
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSource_proposition9_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSource_reflectedTriple
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedAffineSource_supportedOn
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_affine
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_neg
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_pos
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_mem_indexSet
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedHeightProfileConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedHeightProfileConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedNativeHeightProfileConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedNativeHeightProfileConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeightSchwartz._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeightSchwartz._proof_2
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeightSchwartz._proof_3
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeightSchwartz._proof_4
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeightSchwartz._proof_5
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeightSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeightSchwartz_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeight_heightFourierMassFamilyAtDepth_zero
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedRWeight_supportedOn
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_affine
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_neg
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_pos
#print axioms Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_mem_indexSet
#print axioms Legendre.Density.GuthMaynard.gmCubicPairMellinAtom.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicPairMellinAtom_eq_exp
#print axioms Legendre.Density.GuthMaynard.gmCubicPairMellinDerivativeConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicPairMellinDerivativeConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicPositiveDenominatorBlock.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindow._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindow._proof_2
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindow._proof_3
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindow._proof_4
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindow._proof_5
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindowComplexFunction.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindowComplexSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindow_eq_zero_of_not_mem_Icc
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindow_one
#print axioms Legendre.Density.GuthMaynard.gmCubicPreSmoothingWindow_one_wide
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightFourierConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightFourierConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightFunction._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightFunction._proof_2
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightFunction._proof_3
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightFunction.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightFunction_eq
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightSchwartz_ge_card_sq_half_on_coherenceInterval
#print axioms Legendre.Density.GuthMaynard.gmCubicRWeightSchwartz_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBumpComplexFunction.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicRatioBumpComplexSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicReflectedAffineAggregate_eq_scaleSum
#print axioms Legendre.Density.GuthMaynard.gmCubicReflectedAffineAggregate_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal
#print axioms Legendre.Density.GuthMaynard.gmCubicS3.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop10_1_native
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop10_1_physical_explicit
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop10_1_selected_explicit
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop11_2_native
#print axioms Legendre.Density.GuthMaynard.gmCubicSelectedScale_first_le
#print axioms Legendre.Density.GuthMaynard.gmCubicSelectedScale_second_le
#print axioms Legendre.Density.GuthMaynard.gmCubicSelectedSmoothedBlock_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicSelectedSmoothedBlock_pointwise_affine_le
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedR.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSqSchwartz.congr_simp
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSqSchwartz.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSqSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSqSchwartz_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicSmoothedRSq_le_affineSource_on_sourceInterval
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedHeightProfileConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedRWeightDerivativeConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedRWeightFourierConstant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedRWeightFunction.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedRWeightSchwartz_apply
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedRWeightSchwartz_ge_card_sq_half_on_coherenceInterval
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedRWeightSchwartz_nonneg
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedRWeight_heightFourierMassFamilyAtDepth_zero
#print axioms Legendre.Density.GuthMaynard.gmCubicTruncatedRWeight_supportedOn
#print axioms Legendre.Density.GuthMaynard.gmCubicWideFourthConstant.eq_1
#print axioms Legendre.Density.GuthMaynard.gmCubicWideFourthConstant_pos
#print axioms Legendre.Density.GuthMaynard.gmCubicWideL2Constant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmCubicWideL2Constant_pos
#print axioms Legendre.Density.GuthMaynard.gmCutoff_reciprocal_term_le
#print axioms Legendre.Density.GuthMaynard.gmDiagonalGcdThirdMoment_le
#print axioms Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_le_card_sq_mul_second
#print axioms Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_le_dyadicPairBlockMoments
#print axioms Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_native
#print axioms Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_raw_native
#print axioms Legendre.Density.GuthMaynard.gmDiscreteRatioMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.gmDiscreteRatioMoment_eq_iterated
#print axioms Legendre.Density.GuthMaynard.gmDiscreteRatioMoment_eq_sum_gcdSlices
#print axioms Legendre.Density.GuthMaynard.gmDiscreteRatioMoment_eq_sum_reduced
#print axioms Legendre.Density.GuthMaynard.gmDiscreteRatioSecondMoment_native
#print axioms Legendre.Density.GuthMaynard.gmDiscreteRatioThirdMoment_le_small_add_large
#print axioms Legendre.Density.GuthMaynard.gmDiscreteRatioThirdMoment_physical_native
#print axioms Legendre.Density.GuthMaynard.gmDiscreteSecondMoment_native
#print axioms Legendre.Density.GuthMaynard.gmDiscreteThirdMoment_le_card_mul_second
#print axioms Legendre.Density.GuthMaynard.gmDiscreteThirdMoment_le_sqrt
#print axioms Legendre.Density.GuthMaynard.gmDiscreteThirdMoment_sq_le_second_mul_fourth
#print axioms Legendre.Density.GuthMaynard.gmDyadicIntervalPlus.eq_1
#print axioms Legendre.Density.GuthMaynard.gmDyadicIntervalPlus_eq_insert
#print axioms Legendre.Density.GuthMaynard.gmDyadicMultiplicitySourceShape
#print axioms Legendre.Density.GuthMaynard.gmDyadicPairBlockMoment_native
#print axioms Legendre.Density.GuthMaynard.gmDyadicPairBlockMoment_sourceShape_native
#print axioms Legendre.Density.GuthMaynard.gmDyadicPlusFourthMoment_native
#print axioms Legendre.Density.GuthMaynard.gmDyadicPlusRatioMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.gmDyadicPlusRatioMoment_le
#print axioms Legendre.Density.GuthMaynard.gmDyadicPlusSecondMoment_native
#print axioms Legendre.Density.GuthMaynard.gmEnergy_prop11_1_native
#print axioms Legendre.Density.GuthMaynard.gmFiniteExpSum.eq_1
#print axioms Legendre.Density.GuthMaynard.gmFourthLocalPackingPrefactor_le
#print axioms Legendre.Density.GuthMaynard.gmFourthMomentShape._proof_1
#print axioms Legendre.Density.GuthMaynard.gmFourthMomentShape.eq_1
#print axioms Legendre.Density.GuthMaynard.gmFourthMomentShape_nonneg
#print axioms Legendre.Density.GuthMaynard.gmGcdCutoff_bounds
#print axioms Legendre.Density.GuthMaynard.gmGcdCutoff_le_N
#print axioms Legendre.Density.GuthMaynard.gmGcdSlice.eq_1
#print axioms Legendre.Density.GuthMaynard.gmGcdSliceMoment_eq_reduced
#print axioms Legendre.Density.GuthMaynard.gmGcdSliceThirdMoment_le_card_cubed_of_lt
#print axioms Legendre.Density.GuthMaynard.gmGcdSliceThirdMoment_le_dyadicPlus
#print axioms Legendre.Density.GuthMaynard.gmGcdSlice_fst_pos
#print axioms Legendre.Density.GuthMaynard.gmGcdSlice_index_pos
#print axioms Legendre.Density.GuthMaynard.gmGcdSlice_snd_pos
#print axioms Legendre.Density.GuthMaynard.gmGcdSlice_to_reduced_mem
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceBinCommonIntervalMeanSquare_native
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceBinShiftedMeanSquare_native
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceBin_bounds_of_base
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceBin_mem_dyadicClass_of_pair
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceDyadicClass.eq_1
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceDyadicCount_le_six_log
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceDyadicPairBlock_eq_sum_fibers
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceMatchedPairs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceMultiplicity.eq_1
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceMultiplicity_le_card
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceMultiplicity_pos_of_mem
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferencePairPhase.eq_1
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferencePairPhase_log_div_eq_sourcePhase
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferencePairScale_mem_range
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceTranslatedClass.eq_1
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceTranslatedClass_inBase
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceTranslatedClass_separated
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceTranslatedMeanSquare_native
#print axioms Legendre.Density.GuthMaynard.gmHalfDifferenceTranslated_sub
#print axioms Legendre.Density.GuthMaynard.gmHalfDifference_pair_displacement
#print axioms Legendre.Density.GuthMaynard.gmHalfMatchedToEnergy.eq_1
#print axioms Legendre.Density.GuthMaynard.gmHalfMatchedToEnergy_mem
#print axioms Legendre.Density.GuthMaynard.gmLargeFourthAggregateShape_le_paper
#print axioms Legendre.Density.GuthMaynard.gmLargeFourthAggregateShape_nonneg
#print axioms Legendre.Density.GuthMaynard.gmLargeFourthPaperShape.eq_1
#print axioms Legendre.Density.GuthMaynard.gmLargeGcdThirdMoment_eq_middle_add_diagonal
#print axioms Legendre.Density.GuthMaynard.gmLargeGcdThirdMoment_native
#print axioms Legendre.Density.GuthMaynard.gmLargePaperShapes_large_card
#print axioms Legendre.Density.GuthMaynard.gmLargePaperShapes_native
#print axioms Legendre.Density.GuthMaynard.gmLargePaperShapes_small_card
#print axioms Legendre.Density.GuthMaynard.gmLargeSecondAggregateShape_le_paper
#print axioms Legendre.Density.GuthMaynard.gmLargeSecondAggregateShape_nonneg
#print axioms Legendre.Density.GuthMaynard.gmLargeSecondPaperShape.eq_1
#print axioms Legendre.Density.GuthMaynard.gmLemma11ThreeFourierError_le
#print axioms Legendre.Density.GuthMaynard.gmMiddleGcdThirdMoment_native
#print axioms Legendre.Density.GuthMaynard.gmMiddleGcdThirdMoment_physical_native
#print axioms Legendre.Density.GuthMaynard.gmMiddleGcdThirdMoment_raw
#print axioms Legendre.Density.GuthMaynard.gmRPhase_fourth_eq_gmFiniteExpSum
#print axioms Legendre.Density.GuthMaynard.gmRPhase_pair_frequency_le
#print axioms Legendre.Density.GuthMaynard.gmRPhase_quad_frequency_le
#print axioms Legendre.Density.GuthMaynard.gmRPhase_sq_eq_gmFiniteExpSum
#print axioms Legendre.Density.GuthMaynard.gmR_ratio_pow_le_card_pow
#print axioms Legendre.Density.GuthMaynard.gmReducedLogRatios.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReducedLogRatios_bounds
#print axioms Legendre.Density.GuthMaynard.gmReducedLogRatios_image_injective
#print axioms Legendre.Density.GuthMaynard.gmReducedLogRatios_separated
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_eq_logSum
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_four_le_epsilon
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_four_le_local_raw
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_four_le_main_add_tail
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_le_plus
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_three_le_epsilon
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_two_le_epsilon
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_two_le_local_raw
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioMoment_two_le_main_add_tail
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPair_mem_plus
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPairs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPairs_coprime
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPairs_dilate_snd_le
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPairs_fst_pos
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPairs_ratio_bounds
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPairs_ratio_separated
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPairs_snd_pos
#print axioms Legendre.Density.GuthMaynard.gmReducedRatioPairs_to_gcdSlice_mem
#print axioms Legendre.Density.GuthMaynard.gmReducedThirdMoment_le_sqrt
#print axioms Legendre.Density.GuthMaynard.gmSecondLocalPackingPrefactor_le
#print axioms Legendre.Density.GuthMaynard.gmSecondMomentShape._proof_1
#print axioms Legendre.Density.GuthMaynard.gmSecondMomentShape._proof_2
#print axioms Legendre.Density.GuthMaynard.gmSecondMomentShape._proof_3
#print axioms Legendre.Density.GuthMaynard.gmSecondMomentShape.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSecondMomentShape_nonneg
#print axioms Legendre.Density.GuthMaynard.gmSection11CommonRadius._proof_1
#print axioms Legendre.Density.GuthMaynard.gmSection11CommonRadius_le_epsilonPower
#print axioms Legendre.Density.GuthMaynard.gmSection11PairMajorant_nonneg
#print axioms Legendre.Density.GuthMaynard.gmSection11RawCore_le_sqrtSix
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL2Constant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL2Constant._proof_2
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL2Constant_pos
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL2SliceConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL2SliceConstant_pos
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL3SliceConstant.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL3SliceConstant_pos
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL4Constant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL4Constant._proof_2
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL4Constant_pos
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL4SliceConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdL4SliceConstant_pos
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdSumConstant_pos
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdTailConstant._proof_1
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdTailConstant.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdThirdMoment_eq_reduced
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdThirdMoment_le_raw
#print axioms Legendre.Density.GuthMaynard.gmSmallGcdThirdMoment_native
#print axioms Legendre.Density.GuthMaynard.half_abs_intCast_le_abs_fract_add
#print axioms Legendre.Density.GuthMaynard.half_abs_sub_le_abs_log_sub
#print axioms Legendre.Density.GuthMaynard.harmonic_le_scale_rpow
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineCentralWeightFunction
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineLocalBumpFunction
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineMiddleTauWeight
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineScaledBumpFunction
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicAffineSourceFunction
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicPreSmoothingWindowComplexFunction
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicRWeightFunction
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicRatioBumpComplexFunction
#print axioms Legendre.Density.GuthMaynard.hasCompactSupport_gmCubicTruncatedRWeightFunction
#print axioms Legendre.Density.GuthMaynard.hasFiniteSupport_gmAffinePoissonNearTerm
#print axioms Legendre.Density.GuthMaynard.hasFiniteSupport_gmAffineScaledNearTerm
#print axioms Legendre.Density.GuthMaynard.integrableOn_gmAffineHighFrequencyRegion_abs_rpow
#print axioms Legendre.Density.GuthMaynard.integrable_finiteExpSum_fourier_kernel
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineFourierPairKernel
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineMiddleEquation97Term
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineMiddleSourceTerm
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineMiddleTauWeightedBlockRealSq
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineMiddleTauWeightedBlockRealSq_real
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineMiddleTauWeightedBlockSq
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineMiddleTripleKernel
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineMiddleZ₁_integrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffinePositiveTransformSum_sq
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineRetainedFirstPoissonPairSquare
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineRetainedMiddleProfile
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineSigmaIIEquation97Integrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineSigmaIIFarEnvelope
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineSigmaIIPhysicalEnvelope
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineSmoothTransformSum_sq
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineSmoothTransform_fourier_sq
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineSmoothingConvolution_integrand
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineTerm_sq
#print axioms Legendre.Density.GuthMaynard.integrable_gmAffineTransformSum_sq_native
#print axioms Legendre.Density.GuthMaynard.integrable_mul_gmAffineMiddlePhysicalWindowWeight
#print axioms Legendre.Density.GuthMaynard.integrable_sourceDirichletPoly_energyFourier
#print axioms Legendre.Density.GuthMaynard.integrable_sq_gmCubicReflectedAffineAggregate
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineHighFrequencyRegion_abs_rpow
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineHighFrequencyRegion_fourier_sq_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineHighFrequencyRegion_sq_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le_source_scale
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_sq_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_sigmaIIReal_add_source_tails_of_constants
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleFrequencyRegion_fourier_sq_le_uniform_pairs_add_far
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleFrequencyRegion_main_sq_le_uniform_pairs
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeight_blockReal_scale
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeightedBlockRealSq_eq_ofReal_mass
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeightedBlockRealSq_le_of_norm_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeightedBlockRealSq_le_source_decay_of_constant
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeightedBlockSq_eq_mass
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineMiddleTripleKernel_eq_Z₁
#print axioms Legendre.Density.GuthMaynard.integral_gmAffinePositiveTransformSum_sq_le_J
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_eq
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineRetainedMiddleProfile_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSigmaIIFarEnvelope_eq
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSigmaIIFarEnvelope_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSigmaIIPhysicalEnvelope_eq
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSigmaIIPhysicalEnvelope_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSigmaIIPhysicalEnvelope_le._proof_1
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSmoothTransformSum_sq_eq_fourier
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSmoothTransform_fourier_sq_eq_regions
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSmoothingKernelReal_eq
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineSmoothingKernelReal_le_four
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineTerm_sq
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineTildeSchwartz_eq_mul
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineTildeSchwartz_le
#print axioms Legendre.Density.GuthMaynard.integral_gmAffineTildeSchwartz_sq_le
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicLocalBump_le_four
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicNormalizedAffineSource_le_two_secondMoment
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicNormalizedRWeightSchwartz
#print axioms Legendre.Density.GuthMaynard.integral_gmCubicRWeightSchwartz_le_secondMoment
#print axioms Legendre.Density.GuthMaynard.integral_mul_gmAffineMiddlePhysicalWindowWeight
#print axioms Legendre.Density.GuthMaynard.integral_mul_gmAffinePositiveTransformSum_le
#print axioms Legendre.Density.GuthMaynard.integral_mul_gmAffineRetainedNeighborhoodSum_le
#print axioms Legendre.Density.GuthMaynard.integral_mul_middleWindowIndicator
#print axioms Legendre.Density.GuthMaynard.integral_norm_iteratedFDeriv_gmAffineComplexify_cubicRWeight_le
#print axioms Legendre.Density.GuthMaynard.integral_norm_iteratedFDeriv_gmAffineComplexify_truncatedRWeight_le
#print axioms Legendre.Density.GuthMaynard.integral_sq_gmCubicNormalizedAffineSource_le_six_fourthMoment
#print axioms Legendre.Density.GuthMaynard.integral_sq_gmCubicNormalizedRWeightSchwartz
#print axioms Legendre.Density.GuthMaynard.integral_sq_gmCubicRWeightSchwartz_le_fourthMoment
#print axioms Legendre.Density.GuthMaynard.integral_sq_gmCubicReflectedAffineAggregate_le_sixteen_J
#print axioms Legendre.Density.GuthMaynard.integral_sum_gmHalfDifferenceBin_sourceMoment
#print axioms Legendre.Density.GuthMaynard.integral_sum_triple_sourceMoment
#print axioms Legendre.Density.GuthMaynard.integral_tau_u'_u_gmAffineMiddleTripleKernel_eq_u'_u_tau
#print axioms Legendre.Density.GuthMaynard.log_gmHalfDifferenceMultiplicity_le_log_card
#print axioms Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock
#print axioms Legendre.Density.GuthMaynard.mapAdditiveQuadruple.eq_1
#print axioms Legendre.Density.GuthMaynard.mapAdditiveQuadruple_scale_mem
#print axioms Legendre.Density.GuthMaynard.mapAdditiveQuadruple_translate_mem
#print axioms Legendre.Density.GuthMaynard.mapAdditiveQuadruple_unscale_mem
#print axioms Legendre.Density.GuthMaynard.mapAdditiveQuadruple_untranslate_mem
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmAffineHighFrequencyRegion
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmAffineLowFrequencyRegion
#print axioms Legendre.Density.GuthMaynard.measurableSet_gmAffineMiddleFrequencyRegion
#print axioms Legendre.Density.GuthMaynard.memLp_sqrt_four_of_memLp_two
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineCentralShell
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineCentralShell_of_abs_bound
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineCentralShell_of_affine_support
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineFirstPoissonEllRange_of_pair
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineFirstPoissonPairs
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineIndexSet
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineMiddleTail
#print axioms Legendre.Density.GuthMaynard.mem_gmAffinePoissonNearSet_iff_firstPoissonTau
#print axioms Legendre.Density.GuthMaynard.mem_gmAffinePoissonNearSet_of_lt
#print axioms Legendre.Density.GuthMaynard.mem_gmAffinePositiveShell
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineScaleTriples
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineScaledNearSet_of_lt
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineSignedShell
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineSignedShell_of_abs_bounds
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineSmoothCentralShell
#print axioms Legendre.Density.GuthMaynard.mem_gmAffineUnitInterval_div_of_mem_scaledNear
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicNegativeDenominatorBlock
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicNegativeDenominatorBlock._simp_1
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicPositiveDenominatorBlock
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicPositiveDenominatorBlock._simp_1
#print axioms Legendre.Density.GuthMaynard.mem_gmCubicReflectedAffineIndexSet
#print axioms Legendre.Density.GuthMaynard.mem_gmHalfDifferenceDyadicClass
#print axioms Legendre.Density.GuthMaynard.mem_gmHalfDifferenceDyadicClass_log
#print axioms Legendre.Density.GuthMaynard.mul_sq_mul_rpow_five_four_factor
#print axioms Legendre.Density.GuthMaynard.natAbs_le_abs_add_gmAffineFirstPoissonRadius
#print axioms Legendre.Density.GuthMaynard.neg_mem_gmAffineCentralShell_of_mem_scaledNear
#print axioms Legendre.Density.GuthMaynard.norm_fourier_gmAffineComplexify_affine_le
#print axioms Legendre.Density.GuthMaynard.norm_fourier_gmAffineComplexify_normalizedRWeight
#print axioms Legendre.Density.GuthMaynard.norm_fourier_gmAffineSmoothingKernel_le_four
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineCentralPoissonKernel_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineFirstPoissonPairTerm_sq_eq
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineFirstPoissonPairTerm_sq_le_scaledMiddle
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineLocalBumpFourier_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineMiddleFourierBlockReal_le_of_fourier_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineMiddleFourierBlockReal_le_seminorm
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineMiddleFourierBlockReal_le_source_decay_of_constant
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineMiddleZ₁_le_four
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineMiddleZ₂_farSeries_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffinePoissonFarFourier_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffinePoissonFarFourier_le_of_fourier_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffinePoissonFarSeries_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffinePoissonFarTerm
#print axioms Legendre.Density.GuthMaynard.norm_gmAffinePoissonMainFourier_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffinePoissonMainFourier_le_of_fourier_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffinePoissonMainFourier_sq_le_pairs
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineScaledBumpDual_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineScaledFarSeries_le
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_exception
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_majorant
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_profile
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSigmaIIEquation97Integrand_le_near_add_far
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSigmaIIReal_eq_sum_mass
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSigmaIIReal_le_J_add_far
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSigmaIIReal_mul_width_le_J_add_far
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSigmaIIReal_mul_width_le_J_add_far._proof_1
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSigmaII_le_J_add_far
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSigmaII_le_physical_add_far
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_decay
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_decayEnvelope
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_envelopes
#print axioms Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_sq_le_main_add_far
#print axioms Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_coeffMass
#print axioms Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localFourier_add_tail
#print axioms Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localIntegral_add_tail
#print axioms Legendre.Density.GuthMaynard.norm_gmHalfDifferenceFiberPhase_le_multiplicity
#print axioms Legendre.Density.GuthMaynard.norm_gmHalfDifferenceFiberPhase_lt_twoPow_succ
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_fourth_le_dyadicPairBlocks
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_fourth_le_localIntegral_add_tail
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_sq_eq_sum_halfDifferenceDyadicPairBlock
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_sq_le_localIntegral_add_tail
#print axioms Legendre.Density.GuthMaynard.norm_gmRPhase_sub_card_le
#print axioms Legendre.Density.GuthMaynard.norm_gmR_ge_three_fourths_card_on_coherenceInterval
#print axioms Legendre.Density.GuthMaynard.norm_gmR_reducedRatio_eq_phase
#print axioms Legendre.Density.GuthMaynard.norm_iteratedDeriv_gmAffineComplexify_cubicRWeight_le
#print axioms Legendre.Density.GuthMaynard.norm_iteratedDeriv_gmAffineComplexify_truncatedRWeight_le
#print axioms Legendre.Density.GuthMaynard.norm_iteratedDeriv_gmCubicPairMellinAtom_le
#print axioms Legendre.Density.GuthMaynard.norm_iteratedDeriv_ofReal_cpow_mul_I_le_eight
#print axioms Legendre.Density.GuthMaynard.norm_sourceDirichletPoly_le_scale
#print axioms Legendre.Density.GuthMaynard.norm_sum_gmAffineCentralPoissonKernel_near_le
#print axioms Legendre.Density.GuthMaynard.ofReal_norm_finset_sum_sq_expand
#print axioms Legendre.Density.GuthMaynard.ofReal_norm_gmAffineMiddleFourierBlock_sq_expand
#print axioms Legendre.Density.GuthMaynard.ofReal_norm_gmHalfDifferenceDyadicPairBlock_sq_expand
#print axioms Legendre.Density.GuthMaynard.ofReal_norm_gmHalfDifferenceDyadicPairBlock_sq_expand'
#print axioms Legendre.Density.GuthMaynard.ofReal_norm_sourceDirichletPoly_one_sq_expand
#print axioms Legendre.Density.GuthMaynard.ofReal_norm_sourceDirichletPoly_one_sq_expand'
#print axioms Legendre.Density.GuthMaynard.ofReal_norm_sourceDirichletPoly_sq_expand
#print axioms Legendre.Density.GuthMaynard.ofReal_norm_sourceDirichletPoly_sq_expand'
#print axioms Legendre.Density.GuthMaynard.ofReal_sum_triple_sourceMoment_eq
#print axioms Legendre.Density.GuthMaynard.one_le_rpow_gmAffineIterationEta
#print axioms Legendre.Density.GuthMaynard.pow_mul_norm_fourier_gmCubicNormalizedRWeight_le
#print axioms Legendre.Density.GuthMaynard.pow_mul_norm_fourier_gmCubicRWeight_le
#print axioms Legendre.Density.GuthMaynard.pow_mul_norm_fourier_gmCubicTruncatedRWeight_le
#print axioms Legendre.Density.GuthMaynard.pow_rpow_eq_rpow_mul_nat
#print axioms Legendre.Density.GuthMaynard.reduced_nat_ratio_injective
#print axioms Legendre.Density.GuthMaynard.rpow_div_pow_rpow_le_one
#print axioms Legendre.Density.GuthMaynard.rpow_div_sq_pow_rpow_le_one
#print axioms Legendre.Density.GuthMaynard.rpow_gmAffineIterationEta_le_self
#print axioms Legendre.Density.GuthMaynard.seminorm_fourier_gmAffineComplexify_le_integral
#print axioms Legendre.Density.GuthMaynard.seminorm_fourier_gmAffineComplexify_tilde_le_four
#print axioms Legendre.Density.GuthMaynard.seminorm_fourier_gmCubicNormalizedRWeight_le
#print axioms Legendre.Density.GuthMaynard.seminorm_fourier_gmCubicRWeight_le
#print axioms Legendre.Density.GuthMaynard.seminorm_fourier_gmCubicTruncatedRWeight_le
#print axioms Legendre.Density.GuthMaynard.setIntegral_Icc_comp_mul_add
#print axioms Legendre.Density.GuthMaynard.setIntegral_gmAffineUnitInterval_le_tilde
#print axioms Legendre.Density.GuthMaynard.setIntegral_gmCubicSelectedSmoothedBlock_holder
#print axioms Legendre.Density.GuthMaynard.setIntegral_gmCubicSelectedSmoothedBlock_le_six
#print axioms Legendre.Density.GuthMaynard.setIntegral_norm_gmR_fourth_wide_le_epsilon_budget
#print axioms Legendre.Density.GuthMaynard.setIntegral_norm_gmR_sq_wide_eq_logWeighted
#print axioms Legendre.Density.GuthMaynard.setIntegral_norm_gmR_sq_wide_le_epsilon_budget
#print axioms Legendre.Density.GuthMaynard.setIntegral_sq_gmCubicDirectAffineTransform_le_J
#print axioms Legendre.Density.GuthMaynard.setIntegral_sq_gmCubicReflectedAffineAggregate_inv_le_sixtyfour_J
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_energyFourier_reproduction
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_norm_le_gmReflectionWindow_add_error
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_norm_le_gmReflectionWindow_add_error_uniform
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_norm_le_localFourier_add_tail
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_norm_sq_le_commonInterval_add_error
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_pairDifference_sq_le_commonInterval
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_pairDifference_sq_le_majorant
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_shift_eq_twisted
#print axioms Legendre.Density.GuthMaynard.sq_setIntegral_norm_sourceDirichletPoly_le
#print axioms Legendre.Density.GuthMaynard.sqrt_add_le_add_sqrt
#print axioms Legendre.Density.GuthMaynard.sqrt_const_mul_rpow_le
#print axioms Legendre.Density.GuthMaynard.sqrt_le_four_mul_sqrt_rpow_mul_sqrt
#print axioms Legendre.Density.GuthMaynard.sqrt_mul_sqrt_add_le_add
#print axioms Legendre.Density.GuthMaynard.sqrt_mul_sqrt_le_of_mul_le_sq
#print axioms Legendre.Density.GuthMaynard.sqrt_pow_four_mul
#print axioms Legendre.Density.GuthMaynard.sqrt_pow_six_mul_sq
#print axioms Legendre.Density.GuthMaynard.sqrt_product_le_common_mul
#print axioms Legendre.Density.GuthMaynard.sqrt_rpow_eq_rpow_half
#print axioms Legendre.Density.GuthMaynard.sqrt_rpow_mul_rpow
#print axioms Legendre.Density.GuthMaynard.sqrt_rpow_mul_rpow_mul_rpow
#print axioms Legendre.Density.GuthMaynard.stronglyMeasurable_gmAffineTransformSum
#print axioms Legendre.Density.GuthMaynard.sum_Icc_inv_sub_inv_succ
#print axioms Legendre.Density.GuthMaynard.sum_Icc_natDiv_le_harmonic
#print axioms Legendre.Density.GuthMaynard.sum_Icc_natDiv_sq_le
#print axioms Legendre.Density.GuthMaynard.sum_Icc_one_div_sq_le_two
#print axioms Legendre.Density.GuthMaynard.sum_Icc_one_div_sq_tail_le
#print axioms Legendre.Density.GuthMaynard.sum_approximateAdditiveQuadruples_le_three_mul_sum_triples
#print axioms Legendre.Density.GuthMaynard.sum_five_last_two_to_front
#print axioms Legendre.Density.GuthMaynard.sum_four_comm_middle_to_front
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineFirstPoissonPairTerm_sq_eq_sum_retained_range
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineFirstPoissonPairTerm_sq_eq_tsum_retained
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineFirstPoissonPairs
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineMiddleBlockMass_le_sigmaIIReal_add_tail
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineMiddleBlockMass_neg_eq_image
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineMiddleBlockMass_neg_le_sigmaIIReal_add_tail
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineMiddleCore_mass_le_norm_sigmaIIReal
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineMiddleEquation97Term_eq_Z₂Finite
#print axioms Legendre.Density.GuthMaynard.sum_gmAffineMiddleTail_mass_le_source_decay_of_constant
#print axioms Legendre.Density.GuthMaynard.sum_gmCubicDirectAffineSource_le_two_transform
#print axioms Legendre.Density.GuthMaynard.sum_gmCubicReflectedAffineSource_le_two_aggregate
#print axioms Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_selected_eq
#print axioms Legendre.Density.GuthMaynard.sum_gmCubicSmoothedModeIntegral_selected_le_six
#print axioms Legendre.Density.GuthMaynard.sum_gmFourthMomentShape_le
#print axioms Legendre.Density.GuthMaynard.sum_gmHalfDifferenceDyadicPairs_eq_sum_fibers
#print axioms Legendre.Density.GuthMaynard.sum_gmHalfDifferenceMultiplicity
#print axioms Legendre.Density.GuthMaynard.sum_gmHalfDifferenceMultiplicity_sq
#print axioms Legendre.Density.GuthMaynard.sum_gmHalfDifferenceMultiplicity_sq_le_energy
#print axioms Legendre.Density.GuthMaynard.sum_gmHalfDifferenceTranslatedClass_eq_bins
#print axioms Legendre.Density.GuthMaynard.sum_gmSecondMomentShape_le
#print axioms Legendre.Density.GuthMaynard.sum_gmSection11PairMajorant_native
#print axioms Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le
#print axioms Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le_sigmaIIReal_add_tail
#print axioms Legendre.Density.GuthMaynard.sum_norm_gmHalfDifferenceDyadicPairBlock_sq_eq_sourceMoment
#print axioms Legendre.Density.GuthMaynard.sum_range_one_div_succ_sq_le
#print axioms Legendre.Density.GuthMaynard.sum_setIntegral_Icc_le_packing_mul_setIntegral
#print axioms Legendre.Density.GuthMaynard.sum_smallGcd_local_scales_le
#print axioms Legendre.Density.GuthMaynard.sum_sourceMoment_dyadicPairs_le_binMajorants
#print axioms Legendre.Density.GuthMaynard.sum_three_source_phases_eq_gmRPhase
#print axioms Legendre.Density.GuthMaynard.sum_three_swap_first_third
#print axioms Legendre.Density.GuthMaynard.sum_triple_integral_sourceMoment_le
#print axioms Legendre.Density.GuthMaynard.sum_triple_sourceMoment_le_discreteThirdMoment
#print axioms Legendre.Density.GuthMaynard.summable_gmAffinePoissonFarMajorant
#print axioms Legendre.Density.GuthMaynard.summable_gmAffinePoissonFarMode
#print axioms Legendre.Density.GuthMaynard.summable_gmAffinePoissonFarTerm
#print axioms Legendre.Density.GuthMaynard.summable_gmAffinePoissonNearTerm
#print axioms Legendre.Density.GuthMaynard.summable_gmAffineScaledFarMajorant
#print axioms Legendre.Density.GuthMaynard.summable_gmAffineScaledFarTerm
#print axioms Legendre.Density.GuthMaynard.summable_gmAffineScaledNearTerm
#print axioms Legendre.Density.GuthMaynard.summable_gmIntDecayProfile_floorTranslate
#print axioms Legendre.Density.GuthMaynard.ten_mul_gmAffineIterationEta_le
#print axioms Legendre.Density.GuthMaynard.thirtytwo_le_gmCubicSmoothingScale
#print axioms Legendre.Density.GuthMaynard.three_fourths_card_le_norm_gmRPhase
#print axioms Legendre.Density.GuthMaynard.tsum_gmAffineCentralPoissonKernel_eq_near_add_far
#print axioms Legendre.Density.GuthMaynard.tsum_gmAffinePoissonFarMajorant
#print axioms Legendre.Density.GuthMaynard.tsum_gmAffinePoissonFarMode_le
#print axioms Legendre.Density.GuthMaynard.tsum_gmAffinePoissonNearTerm_eq_sum
#print axioms Legendre.Density.GuthMaynard.tsum_gmAffineScaledBumpDual_eq_near_add_far
#print axioms Legendre.Density.GuthMaynard.tsum_gmAffineScaledFarMajorant
#print axioms Legendre.Density.GuthMaynard.tsum_gmAffineScaledNearTerm_eq_sum
#print axioms Legendre.Density.GuthMaynard.tsum_gmIntDecayProfile_floorTranslate
#print axioms Legendre.Density.GuthMaynard.twoPowSucc_sq_mul_dyadicClass_card_five_four_le
#print axioms Legendre.Density.GuthMaynard.twoPowSucc_sq_mul_dyadicClass_card_le_energy
#print axioms Legendre.Density.GuthMaynard.twoPowSucc_sq_mul_dyadicClass_card_sq_le_card_four
#print axioms Legendre.Density.GuthMaynard.twoPow_mul_card_gmHalfDifferenceDyadicClass_le
#print axioms Legendre.Density.GuthMaynard.twoPow_sq_mul_card_gmHalfDifferenceDyadicClass_le_energy
#print axioms Legendre.Density.GuthMaynard.two_le_integral_gmCubicLocalBump
#print axioms Legendre.Density.GuthMaynard.two_le_sq_div_of_three_quarters_le
#print axioms Legendre.Density.GuthMaynard.two_mul_T_div_gmAffineSecondPoissonCutoff_le
#print axioms Legendre.Density.GuthMaynard.two_mul_integral_le_integral_gmAffineTildeSchwartz
#print axioms Legendre.Density.GuthMaynard.volume_real_gmAffineLowFrequencyRegion
#print axioms Legendre.Literature.GuthMaynardAffineHeightFamilyBenchmark._proof_1
#print axioms Legendre.Literature.GuthMaynardAffineHeightFamilyBenchmark._proof_2
#print axioms Legendre.Literature.GuthMaynardEnergyS3Benchmark._proof_1
#print axioms Legendre.Literature.GuthMaynardLargeValuesEnergyBenchmark._proof_1
#print axioms Legendre.Literature.GuthMaynardRefinedS3Benchmark._proof_1
#print axioms Legendre.Literature.layer4_guth_affine_comparator
#print axioms Legendre.Literature.layer4_guth_affine_height_comparator
#print axioms Legendre.Literature.layer4_guth_energy_s3_comparator
#print axioms Legendre.Literature.layer4_guth_large_values_energy_comparator
#print axioms Legendre.Literature.layer4_guth_refined_s3_comparator
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineHeight.0.Legendre.Density.GuthMaynard.exists_gmAffineHeightDecayConstant._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineHeight.0.Legendre.Density.GuthMaynard.exists_gmAffineHeightDecayConstant._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineHeight.0.Legendre.Density.GuthMaynard.exists_gmAffineHeightDecayConstant._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineHeight.0.Legendre.Density.GuthMaynard.exists_gmAffineHeightDecayConstant._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineHeight.0.Legendre.Density.GuthMaynard.exists_gmAffineHeightDecayConstant._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineHeight.0.Legendre.Density.GuthMaynard.exists_gmAffineHeightDecayConstant._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineHeight.0.Legendre.Density.GuthMaynard.exists_gmAffineHeightDecayConstant._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.abs_add_product_lt_gmAffineFirstPoissonRadius._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.abs_add_product_lt_gmAffineFirstPoissonRadius._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.abs_add_product_lt_gmAffineFirstPoissonRadius._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.abs_add_product_lt_gmAffineFirstPoissonRadius._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.abs_add_product_lt_gmAffineFirstPoissonRadius._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.abs_add_product_lt_gmAffineFirstPoissonRadius._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.abs_add_product_lt_gmAffineFirstPoissonRadius._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonEllRange_real_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.card_gmAffineFirstPoissonProductRange_real_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.card_gmAffinePositiveShell_real_le_two_mul._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.card_int_divisorsAntidiag_eq_two_mul_natAbs_divisors._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.card_int_divisorsAntidiag_eq_two_mul_natAbs_divisors._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineFourierDecayUniform_with_product_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineFourierDecayUniform_with_product_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineFourierDecayUniform_with_product_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineFourierDecayUniform_with_product_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineFourierDecayUniform_with_product_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineFourierDecayUniform_with_product_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineFourierDecayUniform_with_product_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92_recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_gmAffineJ_le_source_lemma92_recurrence._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_n_Cdiv_forall_gmAffineLemma92Recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.exists_uniform_constants_gmAffineLemma92Recurrence._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFirstPoissonRegionI_le_source_scale._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFirstPoissonRegionI_le_source_scale._simp_1_11"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFirstPoissonRegionI_le_source_scale._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFirstPoissonRegionI_le_source_scale._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFirstPoissonRegionI_le_source_scale._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFirstPoissonRegionI_le_source_scale._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFirstPoissonRegionI_le_source_scale._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFourierDecayEnvelope_le_source._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFourierDecayUniform._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFourierDecayUniform._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFourierDecayUniform._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFourierDecayUniform._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFourierDecayUniform._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFourierDecayUniform._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineFourierDecayUniform._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineIteration_Y_add_Q_add_one_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineLemma92ComponentsAt_to_recurrence._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFarBound_at_source_cutoff_le._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierArgument_abs_lower._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierArgument_abs_lower._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierArgument_abs_lower._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierArgument_abs_lower._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierArgument_abs_lower._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierArgument_abs_lower._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierArgument_abs_lower._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_scale_tau._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_scale_tau._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_scale_tau._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_scale_tau._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_scale_tau._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_scale_tau._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleFourierBlockReal_scale_tau._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleNearKernelNormSum_le_physical._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleTauWeight_eq_zero_of_not_mem._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleTauWeight_eq_zero_of_not_mem._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineMiddleTauWeight_eq_zero_of_not_mem._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarEnvelope_le_mass_div_pow._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffinePoissonMainEnvelope_le_mass._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIICoreRawBound_le_source._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineRegionIIPrefactor_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineSigmaIIFarEnvelope_eq_coefficient_mul._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineSigmaIINearEnvelope_le_physical._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineSigmaIINearEnvelope_le_physical._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmAffineTildeIterate_supportedOn._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmCubicLocalBump_middleFrequency_eq_zero_of_not_mem._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmCubicLocalBump_middleFrequency_eq_zero_of_not_mem._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.gmCubicLocalBump_middleFrequency_eq_zero_of_not_mem._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineMiddleTauWeight._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineMiddleTauWeight._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineMiddleTauWeight._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integrable_gmAffineRetainedFirstPoissonPairSquare._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integrable_gmAffineRetainedFirstPoissonPairSquare._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integrable_gmAffineRetainedFirstPoissonPairSquare._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integrable_gmAffineRetainedFirstPoissonPairSquare._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integrable_gmAffineRetainedFirstPoissonPairSquare._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integrable_gmAffineRetainedFirstPoissonPairSquare._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integrable_gmAffineRetainedFirstPoissonPairSquare._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le_source_scale._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le_source_scale._simp_1_11"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le_source_scale._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le_source_scale._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le_source_scale._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le_source_scale._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineLowFrequencyRegion_fourier_sq_le_source_scale._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeight_blockReal_scale._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeight_blockReal_scale._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeight_blockReal_scale._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeight_blockReal_scale._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeight_blockReal_scale._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeight_blockReal_scale._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineMiddleTauWeight_blockReal_scale._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffinePositiveTransformSum_sq_le_J._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_eq._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_eq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_eq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_eq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_eq._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineRetainedFirstPoissonPairSquare_eq._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_gmAffineSigmaIIPhysicalEnvelope_eq._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_gmAffineMiddlePhysicalWindowWeight._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_gmAffineMiddlePhysicalWindowWeight._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_gmAffineMiddlePhysicalWindowWeight._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_gmAffineMiddlePhysicalWindowWeight._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_gmAffineMiddlePhysicalWindowWeight._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_gmAffineMiddlePhysicalWindowWeight._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_gmAffineMiddlePhysicalWindowWeight._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_middleWindowIndicator._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_middleWindowIndicator._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_middleWindowIndicator._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_middleWindowIndicator._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_middleWindowIndicator._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_middleWindowIndicator._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.integral_mul_middleWindowIndicator._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.mem_gmAffineFirstPoissonPairs._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.mem_gmAffineFirstPoissonPairs._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.mem_gmAffineMiddleTail._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.mem_gmAffineMiddleTail._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.norm_gmAffineSigmaIIReal_eq_sum_mass._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineIteration.0.Legendre.Density.GuthMaynard.sum_integral_gmAffineRetainedFirstPoissonPairSquare_le._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.approxAddEnergy_one_eq_sum_floorEnergy._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.approxFloorEnergy_zero_le_addEnergy._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.approxFloorEnergy_zero_le_addEnergy._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.approxFloorEnergy_zero_le_addEnergy._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.floorAdditiveDefect_mem_Icc._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.floorAdditiveDefect_mem_Icc._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.mapAdditiveQuadruple_scale_mem._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.mapAdditiveQuadruple_scale_mem._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.mapAdditiveQuadruple_translate_mem._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.mapAdditiveQuadruple_translate_mem._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.mapAdditiveQuadruple_unscale_mem._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.mapAdditiveQuadruple_unscale_mem._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.mapAdditiveQuadruple_untranslate_mem._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineLanguage.0.Legendre.Density.GuthMaynard.mapAdditiveQuadruple_untranslate_mem._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.abs_gmAffineSignedShell_le_scale._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffineCentralShell._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffineCentralShell._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffineIndexSet_le_scaleProduct._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffineIndexSet_le_scaleProduct._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffineIndexSet_le_scaleProduct._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffinePoissonNearSet_real_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffinePositiveShell._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffinePositiveShell._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.card_gmAffineSignedShell_le._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_scaled._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_scaled._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_scaled._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_scaled._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_scaled._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_scaled._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralPoissonKernel_eq_scaled._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralShell_subset_smooth._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralShell_subset_smooth._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralWeight_eq_zero_of_not_mem._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralWeight_eq_zero_of_not_mem._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineCentralWeight_eq_zero_of_not_mem._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineHighFrequencyRegion_eq_union._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineHighFrequencyRegion_eq_union._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineHighFrequencyRegion_eq_union._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineLowFrequencyRegion_eq_Icc._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineLowFrequencyRegion_eq_Icc._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddleZ₂_poisson._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddle_cutoff_eq_scaled._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddle_cutoff_eq_scaled._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddle_cutoff_eq_scaled._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddle_cutoff_eq_scaled._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddle_cutoff_eq_scaled._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddle_cutoff_eq_scaled._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineMiddle_cutoff_eq_scaled._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_decayProfile._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_decayProfile._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_decayProfile._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_decayProfile._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_decayProfile._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_decayProfile._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffinePoissonFarMode_le_decayProfile._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_scaled._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_scaled._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_scaled._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_scaled._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_scaled._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_scaled._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineScaledBumpDual_eq_scaled._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineSignedShell_scale_le_abs._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineSmoothingKernel_apply._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineSmoothingKernel_apply._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineSmoothingKernel_apply._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineSmoothingKernel_apply._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineSmoothingKernel_apply._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineSmoothingKernel_apply._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineSmoothingKernel_apply._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_apply._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_apply._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_apply._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_apply._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_apply._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_apply._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_apply._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_fourier._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_fourier._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_fourier._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_fourier._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_fourier._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_fourier._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTermSchwartz_fourier._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffineTransformIntegral_le_crude._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffine_frequency_regions_union._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.gmAffine_frequency_regions_union._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.half_abs_intCast_le_abs_fract_add._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.half_abs_intCast_le_abs_fract_add._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineCentralWeightFunction._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineCentralWeightFunction._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineCentralWeightFunction._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineLocalBumpFunction._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineLocalBumpFunction._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineLocalBumpFunction._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineScaledBumpFunction._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineScaledBumpFunction._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasCompactSupport_gmAffineScaledBumpFunction._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasFiniteSupport_gmAffinePoissonNearTerm._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.hasFiniteSupport_gmAffineScaledNearTerm._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integrable_gmAffineTerm_sq._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integrable_gmAffineTerm_sq._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integrable_gmAffineTerm_sq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integrable_gmAffineTerm_sq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integrable_gmAffineTerm_sq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integrable_gmAffineTerm_sq._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integrable_gmAffineTerm_sq._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integral_gmAffineTerm_sq._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integral_gmAffineTerm_sq._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integral_gmAffineTerm_sq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integral_gmAffineTerm_sq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integral_gmAffineTerm_sq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integral_gmAffineTerm_sq._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.integral_gmAffineTerm_sq._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.mem_gmAffinePoissonNearSet_of_lt._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.mem_gmAffinePoissonNearSet_of_lt._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.mem_gmAffineScaledNearSet_of_lt._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.mem_gmAffineScaledNearSet_of_lt._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_profile._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_profile._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_profile._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_profile._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_profile._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_profile._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineScaledFarTerm_le_profile._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_decayEnvelope._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_decayEnvelope._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_decayEnvelope._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_decayEnvelope._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_decayEnvelope._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_decayEnvelope._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.norm_gmAffineSmoothTransformSchwartz_fourier_le_decayEnvelope._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.summable_gmAffinePoissonFarMajorant._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.summable_gmAffinePoissonFarMajorant._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.summable_gmAffineScaledFarMajorant._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.summable_gmAffineScaledFarMajorant._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.tsum_gmAffinePoissonFarMajorant._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.tsum_gmAffinePoissonFarMajorant._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.tsum_gmAffinePoissonFarMajorant._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.tsum_gmAffinePoissonFarMajorant._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.tsum_gmAffineScaledFarMajorant._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.tsum_gmAffineScaledFarMajorant._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.tsum_gmAffineScaledFarMajorant._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.AffineTransform.0.Legendre.Density.GuthMaynard.tsum_gmAffineScaledFarMajorant._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.abs_log_le_two_mul_abs_sub_one._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.abs_log_le_two_mul_abs_sub_one._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.abs_log_le_two_mul_abs_sub_one._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.abs_log_le_two_mul_abs_sub_one._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.abs_log_le_two_mul_abs_sub_one._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.abs_log_le_two_mul_abs_sub_one._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.abs_log_le_two_mul_abs_sub_one._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicRWeightSchwartz._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicRWeightSchwartz._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicRWeightSchwartz._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicRWeightSchwartz._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicRWeightSchwartz._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicRWeightSchwartz._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicRWeightSchwartz._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicTruncatedRWeightSchwartz._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicTruncatedRWeightSchwartz._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicTruncatedRWeightSchwartz._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicTruncatedRWeightSchwartz._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicTruncatedRWeightSchwartz._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicTruncatedRWeightSchwartz._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.card_sq_div_sixteen_mul_le_integral_gmCubicTruncatedRWeightSchwartz._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicDirectAffineScales_mem_terminal._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicDirectAffineScales_mem_terminal._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicDirectAffineScales_mem_terminal._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicDirectAffineScales_mem_terminal._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicDyadicFrequencyBlock_denominator_split._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicDyadicFrequencyBlock_denominator_split._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_neg._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_neg._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_neg._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_neg._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_pos._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_pos._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_pos._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedDirectTriple_injective_of_denominator_pos._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_neg._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_neg._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_neg._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_neg._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_pos._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_pos._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_pos._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_injective_of_denominator_pos._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicNormalizedReflectedTriple_mem_indexSet._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.gmCubicReflectedAffineScales_mem_terminal._proof_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.integral_sq_gmCubicReflectedAffineAggregate_le_sixteen_J._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.integral_sq_gmCubicReflectedAffineAggregate_le_sixteen_J._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.integral_sq_gmCubicReflectedAffineAggregate_le_sixteen_J._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.integral_sq_gmCubicReflectedAffineAggregate_le_sixteen_J._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.log_natAbs_third_mem_Icc_of_mem_dyadicBlock._proof_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.CubicThreeTailRefined.0.Legendre.Density.GuthMaynard.setIntegral_gmCubicSelectedSmoothedBlock_holder._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_cubed_le_gmDiscreteRatioMoment_three._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one._proof_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_filter_abs_sub_le_two_mul_ceil_add_one._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_gmHalfDifferenceDyadicPairFiber_lt._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.card_gmReducedRatioPairs_le_four_mul_sq._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.exists_bounded_gmHalfDifferenceDyadicClass._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.exists_gmAffineLocalBumpFourier_tail_bound._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.exists_gmAffineLocalBumpFourier_tail_bound._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.exists_gmAffineLocalBumpFourier_tail_bound._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.exists_gmAffineLocalBumpFourier_tail_bound._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.exists_gmAffineLocalBumpFourier_tail_bound._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.exists_gmAffineLocalBumpFourier_tail_bound._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.exists_gmAffineLocalBumpFourier_tail_bound._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.finiteExpSum_fourier_reproduction._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.finiteExpSum_fourier_reproduction._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.finiteExpSum_fourier_reproduction._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.finiteExpSum_fourier_reproduction._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.finiteExpSum_fourier_reproduction._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.finiteExpSum_fourier_reproduction._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.finiteExpSum_fourier_reproduction._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_le_dyadicPairBlockMoments._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_le_dyadicPairBlockMoments._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_native._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_native._simp_1_11"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_native._simp_1_12"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_native._simp_1_13"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_native._simp_1_14"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_native._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmDiscreteFourthMoment_native._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmFourthLocalPackingPrefactor_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmFourthLocalPackingPrefactor_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmFourthLocalPackingPrefactor_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmFourthLocalPackingPrefactor_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmFourthLocalPackingPrefactor_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmFourthLocalPackingPrefactor_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmFourthLocalPackingPrefactor_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSliceMoment_eq_reduced._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSliceMoment_eq_reduced._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSliceMoment_eq_reduced._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSliceMoment_eq_reduced._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSliceMoment_eq_reduced._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSliceMoment_eq_reduced._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSliceMoment_eq_reduced._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSlice_to_reduced_mem._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmGcdSlice_to_reduced_mem._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmHalfDifferenceDyadicPairBlock_eq_sum_fibers._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmHalfDifferenceDyadicPairBlock_eq_sum_fibers._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmHalfDifferenceMultiplicity_le_card._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmHalfDifferenceMultiplicity_le_card._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmHalfDifferenceMultiplicity_pos_of_mem._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmHalfDifferenceTranslatedClass_separated._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmHalfMatchedToEnergy_mem._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmHalfMatchedToEnergy_mem._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmReducedRatioPairs_ratio_separated._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmReducedRatioPairs_ratio_separated._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmSecondLocalPackingPrefactor_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmSecondLocalPackingPrefactor_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmSecondLocalPackingPrefactor_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmSecondLocalPackingPrefactor_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmSecondLocalPackingPrefactor_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmSecondLocalPackingPrefactor_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.gmSecondLocalPackingPrefactor_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.half_abs_sub_le_abs_log_sub._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.half_abs_sub_le_abs_log_sub._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.half_abs_sub_le_abs_log_sub._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.half_abs_sub_le_abs_log_sub._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.half_abs_sub_le_abs_log_sub._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.half_abs_sub_le_abs_log_sub._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.half_abs_sub_le_abs_log_sub._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localIntegral_add_tail._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localIntegral_add_tail._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localIntegral_add_tail._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localIntegral_add_tail._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localIntegral_add_tail._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localIntegral_add_tail._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.norm_gmFiniteExpSum_le_localIntegral_add_tail._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.norm_sourceDirichletPoly_le_scale._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_localFourier_le_commonInterval._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sum_gmHalfDifferenceMultiplicity_sq._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sum_gmHalfDifferenceMultiplicity_sq._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sum_gmHalfDifferenceMultiplicity_sq._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyDecomposition.0.Legendre.Density.GuthMaynard.sum_gmHalfDifferenceMultiplicity_sq._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.energy_sqrt_term_rearrangement._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.energy_sqrt_term_rearrangement._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.energy_sqrt_term_rearrangement._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.energy_sqrt_term_rearrangement._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.energy_sqrt_term_rearrangement._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.energy_sqrt_term_rearrangement._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.energy_sqrt_term_rearrangement._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmCubicS3_prop10_1_native._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmCubicS3_prop10_1_native._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDiagonalGcdThirdMoment_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDiscreteRatioThirdMoment_le_small_add_large._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDiscreteRatioThirdMoment_le_small_add_large._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDiscreteRatioThirdMoment_le_small_add_large._proof_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDiscreteRatioThirdMoment_le_small_add_large._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDiscreteRatioThirdMoment_le_small_add_large._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDiscreteRatioThirdMoment_physical_native._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDyadicIntervalPlus_eq_insert._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDyadicIntervalPlus_eq_insert._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmDyadicIntervalPlus_eq_insert._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmEnergy_prop11_1_native._simp_1_10"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmEnergy_prop11_1_native._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmEnergy_prop11_1_native._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmEnergy_prop11_1_native._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmEnergy_prop11_1_native._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmEnergy_prop11_1_native._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmEnergy_prop11_1_native._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmLargeGcdThirdMoment_eq_middle_add_diagonal._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmLargeGcdThirdMoment_eq_middle_add_diagonal._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmLargeGcdThirdMoment_eq_middle_add_diagonal._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.gmLargeGcdThirdMoment_eq_middle_add_diagonal._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.EnergyFinal.0.Legendre.Density.GuthMaynard.sum_Icc_inv_sub_inv_succ._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Density.GuthMaynard.gmDyadicIntervalPlus.eq_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_affine_mass_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_affine_negative_scale_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_affine_translated_boundary_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_affine_zero_source_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_energy_s3_sigma_three_quarters_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_energy_sigma_three_quarters_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_gcd_rounding_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_gcd_rounding_consumer._proof_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_refined_s3_singleton_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_refined_s3_singleton_consumer._simp_1_2"

-- Guth–Maynard large values: classical inputs, Section 12, and the closed-sum theorem.
#print axioms Legendre.Density.GuthMaynard.GuthMaynardLargeValues._proof_1
#print axioms Legendre.Density.GuthMaynard.GuthMaynardLargeValues._proof_2
#print axioms Legendre.Density.GuthMaynard.GuthMaynardLargeValues._proof_3
#print axioms Legendre.Density.GuthMaynard.GuthMaynardLargeValues._proof_4
#print axioms Legendre.Density.GuthMaynard.GuthMaynardLargeValues._proof_5
#print axioms Legendre.Density.GuthMaynard.InBaseInterval.eq_1
#print axioms Legendre.Density.GuthMaynard.IsSeparated.eq_1
#print axioms Legendre.Density.GuthMaynard.PublishedGuthMaynardLargeValues._proof_1
#print axioms Legendre.Density.GuthMaynard.PublishedGuthMaynardLargeValues._proof_2
#print axioms Legendre.Density.GuthMaynard.PublishedGuthMaynardLargeValues._proof_3
#print axioms Legendre.Density.GuthMaynard.PublishedGuthMaynardLargeValues._proof_4
#print axioms Legendre.Density.GuthMaynard.PublishedGuthMaynardLargeValues._proof_5
#print axioms Legendre.Density.GuthMaynard.PublishedGuthMaynardLargeValues.eq_1
#print axioms Legendre.Density.GuthMaynard.adapter_dyadic_energy_le_length
#print axioms Legendre.Density.GuthMaynard.adapter_log_factor
#print axioms Legendre.Density.GuthMaynard.classical_large_values_second_branch_unrestricted
#print axioms Legendre.Density.GuthMaynard.classical_large_values_sixth_branch
#print axioms Legendre.Density.GuthMaynard.classical_montgomery_halasz_huxley_native
#print axioms Legendre.Density.GuthMaynard.exists_dilated_separated_subset
#print axioms Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded
#print axioms Legendre.Density.GuthMaynard.gmCubicS3_prop11_2_smooth
#print axioms Legendre.Density.GuthMaynard.gmCubicSpectralDispersion_le_trace_pieces
#print axioms Legendre.Density.GuthMaynard.gmCutoffCoeffs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmEquation12PhysicalRootShape_specialize
#print axioms Legendre.Density.GuthMaynard.gmEquation12PhysicalRootShape_specialize_le
#print axioms Legendre.Density.GuthMaynard.gmProposition3_1_smooth
#print axioms Legendre.Density.GuthMaynard.gmProposition3_1_smooth_fullHeight
#print axioms Legendre.Density.GuthMaynard.gmProposition3_1_smooth_interval
#print axioms Legendre.Density.GuthMaynard.gmProposition3_1_smooth_oneSeparated
#print axioms Legendre.Density.GuthMaynard.gmProposition3_1_smooth_physical
#print axioms Legendre.Density.GuthMaynard.gmS2PaperShape.eq_1
#print axioms Legendre.Density.GuthMaynard.gmS3PhysicalShape._proof_1
#print axioms Legendre.Density.GuthMaynard.gmS3PhysicalShape._proof_2
#print axioms Legendre.Density.GuthMaynard.gmS3PhysicalShape._proof_3
#print axioms Legendre.Density.GuthMaynard.gmS3PhysicalShape._proof_4
#print axioms Legendre.Density.GuthMaynard.gmS3PhysicalShape._proof_5
#print axioms Legendre.Density.GuthMaynard.gmS3PhysicalShape._proof_6
#print axioms Legendre.Density.GuthMaynard.gmS3PhysicalShape.eq_1
#print axioms Legendre.Density.GuthMaynard.gmS3PhysicalShape_nonneg
#print axioms Legendre.Density.GuthMaynard.gmScaleSet.eq_1
#print axioms Legendre.Density.GuthMaynard.gmScaleSet_card
#print axioms Legendre.Density.GuthMaynard.gmSection12RawShape.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSection12RawShape_eq_eight
#print axioms Legendre.Density.GuthMaynard.gmSection12RawShape_nonneg
#print axioms Legendre.Density.GuthMaynard.gmSection12RootShape._proof_1
#print axioms Legendre.Density.GuthMaynard.gmSection12RootShape._proof_2
#print axioms Legendre.Density.GuthMaynard.gmSection12RootShape._proof_3
#print axioms Legendre.Density.GuthMaynard.gmSection12RootShape_le_physical
#print axioms Legendre.Density.GuthMaynard.gmSection12_eq12_1_roots
#print axioms Legendre.Density.GuthMaynard.gmSection12_equation12_1_smooth
#print axioms Legendre.Density.GuthMaynard.gmSection12_raw_smooth
#print axioms Legendre.Density.GuthMaynard.gmShiftCoeffs.eq_1
#print axioms Legendre.Density.GuthMaynard.gmSmoothDirichletPoly_shift_eq
#print axioms Legendre.Density.GuthMaynard.gm_classical_min_high
#print axioms Legendre.Density.GuthMaynard.gm_classical_min_low
#print axioms Legendre.Density.GuthMaynard.gm_classical_source_high
#print axioms Legendre.Density.GuthMaynard.gm_classical_source_low
#print axioms Legendre.Density.GuthMaynard.gm_classical_source_near_height
#print axioms Legendre.Density.GuthMaynard.gm_div_three_rpow_neg_four
#print axioms Legendre.Density.GuthMaynard.gm_each_le_eight_sum
#print axioms Legendre.Density.GuthMaynard.gm_inv_rpow_four
#print axioms Legendre.Density.GuthMaynard.gm_inv_rpow_two
#print axioms Legendre.Density.GuthMaynard.gm_le_one_of_eight_terms
#print axioms Legendre.Density.GuthMaynard.gm_mul_rpow_le_mul
#print axioms Legendre.Density.GuthMaynard.gm_rpow_div_root
#print axioms Legendre.Density.GuthMaynard.gm_rpow_root_bound
#print axioms Legendre.Density.GuthMaynard.gm_rpow_scale_le_eight
#print axioms Legendre.Density.GuthMaynard.gm_rpow_scale_le_sixteen
#print axioms Legendre.Density.GuthMaynard.gm_solve_monomial
#print axioms Legendre.Density.GuthMaynard.gm_source_large_values_critical
#print axioms Legendre.Density.GuthMaynard.gm_source_scale_bounds
#print axioms Legendre.Density.GuthMaynard.gm_source_scale_critical_lower
#print axioms Legendre.Density.GuthMaynard.gm_source_scale_critical_upper
#print axioms Legendre.Density.GuthMaynard.gm_source_scale_gt_one
#print axioms Legendre.Density.GuthMaynard.guthMaynardLargeValues_native
#print axioms Legendre.Density.GuthMaynard.guthMaynardLargeValues_neg
#print axioms Legendre.Density.GuthMaynard.guthMaynardLargeValues_published_native
#print axioms Legendre.Density.GuthMaynard.norm_gmCutoffCoeffs_le_one
#print axioms Legendre.Density.GuthMaynard.norm_gmShiftCoeffs_le_one
#print axioms Legendre.Density.GuthMaynard.rpow_log_div_log
#print axioms Legendre.Density.GuthMaynard.rpow_three_halves_sub_log_ratio
#print axioms Legendre.Density.GuthMaynard.rpow_three_sub_two_log_ratio
#print axioms Legendre.Density.GuthMaynard.sourceDirichletPoly_gmCutoffCoeffs
#print axioms Legendre.Literature.GuthMaynardPublishedLargeValuesBenchmark._proof_1
#print axioms Legendre.Literature.GuthMaynardPublishedLargeValuesBenchmark.eq_1
#print axioms Legendre.Literature.layer4_guth_published_large_values_comparator
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.ClassicalAdapter.0.Legendre.Density.GuthMaynard.adapter_dyadic_energy_le_length._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LargeValueAssembly.0.Legendre.Density.GuthMaynard.gm_source_large_values_critical._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LargeValueAssembly.0.Legendre.Density.GuthMaynard.gm_source_scale_bounds._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LargeValueAssembly.0.Legendre.Density.GuthMaynard.gm_source_scale_bounds._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LargeValueAssembly.0.Legendre.Density.GuthMaynard.gm_source_scale_bounds._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.LargeValueAssembly.0.Legendre.Density.GuthMaynard.gm_source_scale_gt_one._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PublishedLargeValues.0.Legendre.Density.GuthMaynard.guthMaynardLargeValues_published_native._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PublishedLargeValues.0.Legendre.Density.GuthMaynard.norm_restrictDyadicCoeffs_le_one"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PublishedLargeValues.0.Legendre.Density.GuthMaynard.restrictDyadicCoeffs.eq_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.PublishedLargeValues.0.Legendre.Density.GuthMaynard.sourceDirichletPoly_restrictDyadicCoeffs"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.exists_dilated_separated_subset._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.exists_dilated_separated_subset._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.exists_dilated_separated_subset._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.exists_dilated_separated_subset._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.exists_dilated_separated_subset._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.exists_dilated_separated_subset._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.exists_dilated_separated_subset._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmCubicDiagonalMain_sub_spectralAverage_bounded._simp_1_9"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gmProposition3_1_smooth_fullHeight._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gm_solve_monomial._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gm_solve_monomial._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gm_solve_monomial._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gm_solve_monomial._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gm_solve_monomial._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gm_solve_monomial._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.gm_solve_monomial._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.rpow_log_div_log._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.rpow_log_div_log._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.rpow_log_div_log._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.rpow_log_div_log._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.rpow_log_div_log._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.rpow_log_div_log._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.SmoothAssembly.0.Legendre.Density.GuthMaynard.rpow_log_div_log._simp_1_7"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_closed_left_endpoint_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_closed_left_endpoint_consumer._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_closed_left_endpoint_consumer._simp_1_4"

-- Guth–Maynard central transfer and the uniform zero-density estimates.
#print axioms Legendre.Density.GuthMaynard.alpha._proof_1
#print axioms Legendre.Density.GuthMaynard.alpha._proof_2
#print axioms Legendre.Density.GuthMaynard.alpha._proof_3
#print axioms Legendre.Density.GuthMaynard.alpha._proof_4
#print axioms Legendre.Density.GuthMaynard.alpha._proof_5
#print axioms Legendre.Density.GuthMaynard.alpha_pos
#print axioms Legendre.Density.GuthMaynard.central_denominators_pos
#print axioms Legendre.Density.GuthMaynard.denom_pos
#print axioms Legendre.Density.GuthMaynard.differentiable_finiteDirichletSeries_add
#print axioms Legendre.Density.GuthMaynard.dyadic_block_subset_powered_support
#print axioms Legendre.Density.GuthMaynard.exists_dyadic_block_and_subset
#print axioms Legendre.Density.GuthMaynard.exists_large_dyadic_block
#print axioms Legendre.Density.GuthMaynard.exists_nearby_large_value_finiteDirichlet
#print axioms Legendre.Density.GuthMaynard.final_exponent_nonneg
#print axioms Legendre.Density.GuthMaynard.first_term_exponent_identity
#print axioms Legendre.Density.GuthMaynard.gm_actual_typeI_count
#print axioms Legendre.Density.GuthMaynard.gm_central_separated_high_count
#print axioms Legendre.Density.GuthMaynard.gm_central_separated_shell_count
#print axioms Legendre.Density.GuthMaynard.gm_residual_with_cutoff_le
#print axioms Legendre.Density.GuthMaynard.gm_section13_fixed_line_count
#print axioms Legendre.Density.GuthMaynard.gm_section13_selected_block_count
#print axioms Legendre.Density.GuthMaynard.gm_section13_varying_line_count
#print axioms Legendre.Density.GuthMaynard.k_selection
#print axioms Legendre.Density.GuthMaynard.large_values_first_term_le
#print axioms Legendre.Density.GuthMaynard.large_values_second_term_le
#print axioms Legendre.Density.GuthMaynard.large_values_terms_le
#print axioms Legendre.Density.GuthMaynard.large_values_third_term_le
#print axioms Legendre.Density.GuthMaynard.localizedFiniteDirichlet.eq_1
#print axioms Legendre.Density.GuthMaynard.localizedFiniteDirichlet_halfPlane_bound
#print axioms Legendre.Density.GuthMaynard.localizedFiniteDirichlet_le_mass
#print axioms Legendre.Density.GuthMaynard.localizer_factor_gt_three_fourths
#print axioms Legendre.Density.GuthMaynard.localizer_norm_boundary_le
#print axioms Legendre.Density.GuthMaynard.localizer_norm_le_one
#print axioms Legendre.Density.GuthMaynard.mean_value_exponent_le
#print axioms Legendre.Density.GuthMaynard.mean_value_height_term_le
#print axioms Legendre.Density.GuthMaynard.mean_value_terms_le
#print axioms Legendre.Density.GuthMaynard.norm_finiteDirichletSeries_le_mass
#print axioms Legendre.Density.GuthMaynard.residual_exponent_le_final
#print axioms Legendre.Density.GuthMaynard.second_term_exponent_identity
#print axioms Legendre.Density.GuthMaynard.selected_block_large_value_terms_le
#print axioms Legendre.Density.GuthMaynard.selected_block_mean_value_terms_le
#print axioms Legendre.Density.GuthMaynard.shifted_separated_image
#print axioms Legendre.Density.GuthMaynard.third_term_exponent_identity
#print axioms Legendre.Density.Moment.actual_typeII_given_cutoff_count_central
#print axioms Legendre.Density.Moment.halasz_uniform_kernel_cost_of_gap
#print axioms Legendre.Density.Moment.integral_alternative_small_cutoff_epsilon_central
#print axioms Legendre.Density.Moment.integral_alternative_sqrt_height_count_central
#print axioms Legendre.Literature.layer4_guth_central_comparator
#print axioms Legendre.Literature.layer4_guth_density_comparator
#print axioms Legendre.Literature.layer4_guth_global_30_13_comparator
#print axioms Legendre.Zeta.guth_maynard_central_density_epsilon
#print axioms Legendre.Zeta.guth_maynard_density_epsilon
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.first_term_exponent_identity._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.first_term_exponent_identity._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.first_term_exponent_identity._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.first_term_exponent_identity._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.first_term_exponent_identity._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.first_term_exponent_identity._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.first_term_exponent_identity._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.mean_value_exponent_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.mean_value_exponent_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.mean_value_exponent_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.mean_value_exponent_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.mean_value_exponent_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.mean_value_exponent_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.mean_value_exponent_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.second_term_exponent_identity._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.second_term_exponent_identity._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.second_term_exponent_identity._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.second_term_exponent_identity._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.second_term_exponent_identity._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.second_term_exponent_identity._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Exponent.0.Legendre.Density.GuthMaynard.second_term_exponent_identity._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.dyadic_block_subset_powered_support._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.dyadic_block_subset_powered_support._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.dyadic_block_subset_powered_support._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.exists_dyadic_block_and_subset._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.exists_dyadic_block_and_subset._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.exists_dyadic_block_and_subset._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.exists_dyadic_block_and_subset._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.exists_dyadic_block_and_subset._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.exists_dyadic_block_and_subset._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.exists_dyadic_block_and_subset._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.gm_section13_fixed_line_count._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.gm_section13_fixed_line_count._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.gm_section13_fixed_line_count._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.GuthMaynard.Section13Powering.0.Legendre.Density.GuthMaynard.pigeonhole_real_sum"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_central_three_quarters_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gm_central_three_quarters_consumer._simp_1_1"

-- Sharp critical-line fourth moment and its independent consumers.
#print axioms Legendre.Density.GammaBounds.gammaReal_small_shift_signed
#print axioms Legendre.Density.GammaBounds.sharp_gamma_log_horizontal_signed
#print axioms Legendre.Density.Moment.momentGaussian.eq_1
#print axioms Legendre.Literature.layer4_fourth_moment_log_four_comparator
#print axioms Legendre.Zeta.finiteMellin.eq_1
#print axioms Legendre.Zeta.gaussianPoleCoefficient.eq_1
#print axioms Legendre.Zeta.gaussian_pole_line_eq
#print axioms Legendre.Zeta.gaussian_pole_line_integrable
#print axioms Legendre.Zeta.gaussian_pole_line_uniform
#print axioms Legendre.Zeta.xiFiniteSquare_head_log_four
#print axioms Legendre.Zeta.xiFiniteSquare_head_pointwise
#print axioms Legendre.Zeta.xiFiniteSquare_partial_le_head_tail
#print axioms Legendre.Zeta.xiFiniteSquare_shell_log_four
#print axioms Legendre.Zeta.xiGaussianPole.eq_1
#print axioms Legendre.Zeta.xiGaussianPole_div_cpow
#print axioms Legendre.Zeta.xiGaussianPole_polynomial_integral
#print axioms Legendre.Zeta.xiGaussianPole_vertical_continuous
#print axioms Legendre.Zeta.xiPoleNormalizedDifference.eq_1
#print axioms Legendre.Zeta.xiPoleNormalizedDifference_analytic
#print axioms Legendre.Zeta.xiPoleNormalizedDifference_ball_bound
#print axioms Legendre.Zeta.xiPoleNormalizedDifference_zero
#print axioms Legendre.Zeta.xiPoleRemainder.eq_1
#print axioms Legendre.Zeta.xiPoleRemainder_gaussian_bound
#print axioms Legendre.Zeta.xiPoleRemainder_small
#print axioms Legendre.Zeta.zeta_fourth_moment_log_four
#print axioms Legendre.Zeta.zeta_fourth_moment_shell_log_four
#print axioms Legendre.Zeta.zeta_fourth_moment_symmetric_log_four
#audit_private_axioms "_private.Legendre.Layer4.XiMellinRemainder.0.Legendre.Zeta.xiPoleRemainder_small._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.XiMellinRemainder.0.Legendre.Zeta.xiPoleRemainder_small._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.XiPartialMean.0.Legendre.Zeta.xiFiniteSquare_partial_le_head_tail._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.XiSharpHeadMean.0.Legendre.Zeta.xiGaussianPole_div_cpow._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.XiSharpHeadMean.0.Legendre.Zeta.xiGaussianPole_div_cpow._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.XiSharpHeadMean.0.Legendre.Zeta.xiGaussianPole_polynomial_integral._simp_1_2"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_gaussian_pole_width_consumer"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_sharp_fourth_moment_height_two_consumer"

-- Dyadic variable-line sampling and the sharper Ingham detector count.
#print axioms Legendre.Density.Moment.balancedDensityExponent.eq_1
#print axioms Legendre.Density.Moment.dyadicHorizontalFactor_mem
#print axioms Legendre.Density.Moment.dyadicHorizontalFactor_sub_mem
#print axioms Legendre.Density.Moment.dyadic_horizontal_twist
#print axioms Legendre.Density.Moment.dyadic_prefix_sample_bound
#print axioms Legendre.Density.Moment.dyadic_variable_line_samples
#print axioms Legendre.Density.Moment.four_logs_le_of_le
#print axioms Legendre.Density.Moment.norm_abel_dyadic_le
#print axioms Legendre.Density.Moment.polynomial_actual_block_log_three
#print axioms Legendre.Density.Moment.polynomial_alternative_balanced_log_five
#print axioms Legendre.Density.Moment.polynomial_alternative_balanced_of_count
#print axioms Legendre.Density.Moment.polynomial_alternative_count_log_five
#print axioms Legendre.Density.Moment.polynomial_alternative_count_of_block
#print axioms Legendre.Density.Moment.separated_high_shell_density_log_five
#print axioms Legendre.Density.Moment.separated_high_shell_density_of_polynomial
#print axioms Legendre.Density.Moment.sum_dyadic_prefix_range
#print axioms Legendre.Density.Moment.sum_range_abel
#print axioms Legendre.Literature.InghamShellLogFiveBenchmark._proof_1
#print axioms Legendre.Literature.layer4_ingham_shell_log_five_comparator
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_horizontal_twist._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_prefix_sample_bound._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_prefix_sample_bound._proof_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_prefix_sample_bound._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_variable_line_samples._proof_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_variable_line_samples._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_variable_line_samples._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_variable_line_samples._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_variable_line_samples._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_variable_line_samples._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_variable_line_samples._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.dyadic_variable_line_samples._simp_1_8"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.norm_abel_dyadic_le._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.norm_abel_dyadic_le._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.norm_abel_dyadic_le._simp_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.norm_abel_dyadic_le._simp_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.norm_abel_dyadic_le._simp_1_5"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.norm_abel_dyadic_le._simp_1_6"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.norm_abel_dyadic_le._simp_1_7"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.sum_dyadic_prefix_range._proof_1_3"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.sum_dyadic_prefix_range._proof_1_4"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.sum_dyadic_prefix_range._simp_1_1"
#audit_private_axioms "_private.Legendre.Layer4.DyadicVariableSampling.0.Legendre.Density.Moment.sum_dyadic_prefix_range._simp_1_2"
#audit_private_axioms "_private.Legendre.Layer4.SeparatedShellDensity.0.Legendre.Density.Moment.four_logs_le_of_le._proof_1_1"
#audit_private_axioms "_private.Legendre.Tests.Layer4.0.Legendre.Tests.layer4_dyadic_variable_one_term_consumer"
