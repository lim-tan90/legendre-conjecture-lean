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

/-!
# Layer 4: mean values, actual zero detection and Ingham density

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
independently varying real parts. Optimized Huxley counts remain open.

The sharp fourth-moment log^4, Huxley's curved/global 12/5 estimates and
Guth--Maynard density/large-value targets remain open. Layer 4 is incomplete.
The proved 1940 density theorem does not assert Ingham's 1937 prime-gap result.
-/
