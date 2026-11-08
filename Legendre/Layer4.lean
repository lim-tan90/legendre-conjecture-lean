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
xi square, sharp Gamma quotients, and an integrable Gaussian envelope prepare
the critical-line fourth-moment contour. The fourth-moment theorem remains open.
-/
