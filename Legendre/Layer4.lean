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

/-!
# Layer 4: verified initial zero-density and mean-value infrastructure

This interface exports the uniform density-exponent convention, a proved
near-one counting bound, elementary Dirichlet-polynomial mean-square and
continuous large-value measure estimates. Ingham and Huxley zero-density
bounds, sharper large-value estimates remain open. The finite additive large sieve and
separated-point sampling bounds are proved and exported here. The real-line
Hilbert inequality sharpens mean-square error to 2πN times coefficient energy;
optimized discrete sampling has a single logarithmic factor.
The actual finite zeta detector now retains two branches, including principal
pole compensation. Sampling allows independently varying real parts. Neither
Ingham nor Huxley is asserted, and no exponent value is assumed. An entire
xi square, sharp Gamma quotients, and an integrable Gaussian envelope justify
an exact contour functional equation and pointwise fourth-power reduction.
The normalized contour mean and a sixth-log fourth moment are proved:
integral from -T to T of |zeta(1/2+it)|^4 is O(T log^6 T).
The height exponent is consequently 1+epsilon. The sharp log^4 bound and
the Ingham/Huxley zero-density estimates remain open.
The compact Mobius detector has an exact initial contour and a proved shift
to the critical line, retaining the principal zeta residue. Explicit high
ordinates make that residue small and give a polynomial-or-integral detector.
Uniform cubic-weight critical masses are integrable. Counting the two
alternatives sharply enough for Ingham/Huxley remains open.
-/
