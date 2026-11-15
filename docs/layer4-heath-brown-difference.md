# Heath--Brown ordered difference-set mean square (2026-11-15)

The classical difference-set input recalled in Guth--Maynard Section 6 is
proved for the actual finite Dirichlet polynomial. For every epsilon>0,
there are C>0 and T0>=1, chosen before N,T,W and the coefficients, such that
for 0<N, T>=T0, a one-separated finite W in [0,T] and |a_n|<=1 on (N,2N],

```
sum[t,u in W] |sum[N<n<=2N] a_n n^(i(t-u))|^2
 <= C T^epsilon (R^2 N + R N^2 + R^(5/4) T^(1/2) N), R=card(W).
```

`Literature.HeathBrownDifferenceMeanSquareBenchmark` independently states
this literal polynomial, distance/interval conditions, three physical terms,
unit coefficient bound and quantifier order. Its closed witness is
`layer4_heath_brown_difference_comparator`, included in the generated Layer 4
consumer. The theorem is exported by ordinary `import Legendre.Layer4`.

## Proved inputs and scope

* `FinitePowers.lean` gives actual convolution coefficients, their support,
  exact polynomial powers, uniform epsilon bounds and dyadic blocks. The
  existing attributed divisor-growth theorem supplies the divisor bound;
  no zero-detector estimate is introduced as a hypothesis.
* `SamplingMeanSquare.lean` proves the discrete sampling mean square with
  the explicit absolute coefficient `3*(2+2*(5*pi+1))`.
* `Localization.lean` proves the sharp polynomial is exactly the sum of three
  smoothed pieces, including masks, one-sided integer rounding and N>=30.
* `HeathBrown.lean` proves positive-kernel majorization, weighted difference
  moments, transfer and powering identities and recurrences. Its narrower
  analytic propositions are specifications; they are closed by the next file.
* `LogarithmicPrefix.lean` retains only the Kusmin--Landau core, logarithmic
  prefix bound and unit-annulus packing required by the analytic proof.
* `HeathBrownReflection.lean` proves smooth reflection, the weighted moment
  recurrence in every scale range, bounded-scale recovery and the closed
  weighted/coefficient-one/arbitrary-bounded-coefficient mean-square theorems.

The source's broad zero-detector, classical-density and terminal-zeta chains
are not dependencies here. Only the elementary interval/phase helpers they
were exporting are retained. Every adapted module compiles from source with
Lean/mathlib 4.35.0. Exact files, pinned MIT-0 source and adaptations are
recorded under source #5 in both READMEs and in
[the provenance map](smccolm-guth-provenance.md).

This is a proved input for the remaining ordered **Poisson-tail** moment.
The conversion of that tail moment through complete reflection and the full
S2 assembly is a subsequent step. S3 and the central Guth--Maynard density
input on (7/10,4/5) remain open. No new prime-gap exponent or historical
prime-existence claim follows from this mean square alone.

Heath--Brown validation (2026-11-15): Lean 4.35.0 full build passes 4,340 jobs.
All 5,999 project theorem declarations, including private/generated declarations,
match the module-data inventory, independent environment-owner inventory, Audit
targets and actual parsed axiom output exactly. Only propext, Classical.choice
and Quot.sound occur. All 340 classified Lean files, including Layers 0--4,
have no executable placeholders/prohibited shortcuts; no PDFs are present.
All 204 independent consumers pass (159 Layer 4, nine Layer 3, 24 generated
literature and 12 literature regressions). New consumers check zeroth powers,
localization rounding at N=30, literal single-column sampling, exact diagonal
mass and a two-point difference set with four actual nonzero contributions.
Three negative guards reject dropping coefficient/separation conditions or
confusing the mean square with central density. The prior Poisson guards also
passed. All eighteen adapted modules retain the exact pinned MIT-0 source and
are compiled from source; the retained license blob is unchanged.

Verified proof commit: [f92c79f91ec713034cc65ae341e97e321d9bdf36](https://github.com/lim-tan90/legendre-conjecture-lean/commit/f92c79f91ec713034cc65ae341e97e321d9bdf36).
