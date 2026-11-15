# Upper-range actual Type I count (2026-11-15)

The actual compact-detector polynomial branch at smoothing scale **Y=T** now
has the curved exponent, uniformly for sigma in [5/6+eta,1] for each fixed
eta>0. This closes the polynomial branch away from the transition point;
it does not yet assert the full curved zero-density benchmark.

## Exact statement

`Moment.huxley_upper_actual_tail_epsilon_count` proves, for eta>0,
0<delta<=eta/16 and every epsilon>0, one C>0 independent of T, sigma,
the cutoff X and the sample family, such that

```
T>=128, 5/6+eta<=sigma<=1, T^delta<=X<=2T^delta,
T/2<=abs(t_i)<=T, sigma<=beta_i<=1,
abs(t_i-t_j)>=1 for distinct indices,
abs(detectorTail X (beta_i+i*t_i) T)>=1/16
  => card(S)<=C*T^(3(1-sigma)/(3*sigma-1)+epsilon).
```

The coefficients, smoothing, complex powers and literal threshold are those
of the actual detector. No zero assumption or unproved analytic estimate is
needed for this branch count. The independent
`Literature.UpperHuxleyTypeIBenchmark` spells out the exponent and all
uniformity conditions; `layer4_upper_typeI_comparator` is a closed witness.

## Short and long blocks

`HuxleyWindowBlockEpsilon.lean` separates the useful powered-length window
from its selection. The powered Halasz count now accepts sigma through one.
`UpperHuxleyShortBlocks.lean` selects a bounded integer power for every block
with T^delta<=U<=T^c, where c=3/(4(3*sigma-1)). The resulting actual short-block
bound is C W^(-6K) T^(curved+epsilon), with K=ceil(1/delta)+2 and one constant
uniform in sigma, lengths and thresholds. The original fixed sqrt(T) window
retains its original restricted real-part range.

`UpperHuxleyPowerBounds.lean` evaluates all exponent margins as real-power
inequalities. `UpperHuxleyCosts.lean` normalizes the actual ordinate range
T/2<=abs(t)<=T, retaining reciprocal-height losses. For T^c<=U<=T^(3/5),
the general Weyl cost gives the saving; for T^(3/5)<=U<=T, the
second-derivative cost gives it. The two ranges include their shared endpoint.

`UpperHuxleyLongBlocks.lean` combines these estimates for the actual
Mobius-smoothed block. For one absolute D>0,

```
norm(actual block)<=D*X*T^(-eta/8)
```

uniformly for beta in [sigma,1], X<=U<=V<=2U and positive smoothing length.
`UpperHuxleyLongExclusion.lean` uses X<=2T^delta, delta<=eta/16 and the actual
cover bound J<=(2/log 2) log T to prove that, above a common height threshold,
these long blocks are strictly smaller than 1/(16J). Negative ordinates are
included through their absolute heights. No assertion at eta=0 is made.

`UpperHuxleyTail.lean` applies the exact detector dyadic decomposition. Short
blocks are counted, long blocks cannot meet its threshold, and blocks starting
above T vanish by compact support. Summation costs only a fixed power of J,
which is absorbed into epsilon. Heights below the common threshold use the
proved unit-separation bound card(S)<=2(T+1), so the final theorem covers
**every T>=128**, rather than only sufficiently large heights.

## Remaining assembly

The full `Huxley1972Density` benchmark stays open. The next deductions are the
common-cutoff Type I/Type II zero-sample split at Y=T, uniform treatment of the
band adjacent to 5/6, a dyadic height cover and analytic multiplicity
restoration above 5/6. The already proved restricted curve, global 12/5
estimate and Ingham theorem remain available. Guth--Maynard, the sharp
log^4 fourth moment and Layer 5 prime-gap results are separate open targets.

This step is a local deduction from modules already attributed in both
READMEs. It introduces no further external code ports.

## Validation

The full build passes 4,315 jobs. All 4,647 theorem declarations, including
private and generated declarations, agree in two independent inventories,
the audit targets and actual axiom output; only the three standard axioms
occur. All 317 classified Lean sources have no executable placeholders or
prohibited shortcuts. All 177 independent consumers pass (132 Layer 4,
nine Layer 3 and 36 literature). Endpoint consumers cover sigma=1, negative
ordinates and the sharp reciprocal shell loss. Deliberate eta=0 and
excessive-cutoff applications are rejected by Lean's type checker.
