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

/-!
# Layer 4: verified initial zero-density and mean-value infrastructure

This interface exports the uniform density-exponent convention, a proved
near-one counting bound, elementary Dirichlet-polynomial mean-square and
continuous large-value measure estimates. Ingham and Huxley zero-density
bounds, sharper large-value estimates remain open. The finite additive large sieve and
separated-point sampling bounds are proved and exported here.
No named density theorem or exponent value is introduced as an assumption.
-/
