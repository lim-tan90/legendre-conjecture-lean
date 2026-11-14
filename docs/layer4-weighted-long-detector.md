# Weighted Weyl sums and the linear detector scale (2026-11-14)

This checkpoint adds three proved inputs. It does not close the remaining
curved Huxley density range above sigma=5/6. All results are exported by
`import Legendre.Layer4`; no additional upstream code is ported here.

## Monotone weights and actual complex sums

`Exponential/MonotoneWeights.lean` proves finite Abel summation in norm:
if every prefix of a complex sequence has norm at most B, and w is a
nonnegative decreasing real sequence, then the weighted sum has norm at
most B times its first weight. Empty prefixes and the exact final
endpoint are included. The range/block reindexing is an exact finite
bijection.

`Exponential/WeightedLogWeyl.lean` applies this to n^(-beta), uniformly for
every beta>=0. For 1<=U, U<=V<=2U, abs(t)>=1 and U²<=4 abs(t),

```
norm(sum_{U<n<=V} n^(-beta-it)) <= C U^(1/2-beta) abs(t)^(1/6).
```

The sum uses actual complex powers. C is the same explicit positive Weyl
constant as the unweighted theorem and is independent of beta.
`WeightedWeylBenchmark` and `layer4_weighted_weyl_comparator` independently
retain the nonnegative-real-part and length hypotheses.

## General block lengths

`Exponential/WeylBudget.lean` now also retains the terms previously absorbed
using U²<=4 abs(t). `Exponential/GeneralLogWeyl.lean` proves, for every
1<=U, U<=V<=2U and abs(t)>=1,

```
norm(sum_{U<n<=V} n^(-it))
  <= C (sqrt(U) abs(t)^(1/6) + U (U/abs(t))^(1/4) + U/abs(t)^(1/3)).
```

There is no square-root-length hypothesis in this theorem. The other two
terms cannot be discarded from its contract. Its independent specification
is `GeneralWeylBenchmark`, with closed comparator
`layer4_general_weyl_comparator`. Integer-floor and short-prefix cases are
retained in the general square budget.

## Actual Type II zeros with Y=T

`LongDetectorTypeII.lean` specializes the proved individual-fourth-power
estimate to smoothing length Y=T. For sigma>=3/4, T>=2, unit-separated
ordinates of absolute height at most T and independently varying real
parts beta_i in [sigma,1], the literal critical-integral threshold 1/16 gives

```
R <= C X^4 T^(3-4 sigma) log(T)^6.
```

For every epsilon>0, one coefficient works uniformly for delta>=0,
X<=2 T^delta and the same sample conditions:

```
R <= C_epsilon T^(3-4 sigma+4 delta+epsilon).
```

`actual_typeII_linear_cutoff_epsilon` applies this to actual zeta zeros in
the shell T/2<=abs(t_i)<=T, T>=128, which fail the literal polynomial
alternative at Y=T. It explicitly retains 1<=X<=2T, X<=2T^delta and the
principal-pole constraints 4<=T<=(T/2)². Pole exclusion comes from the
nonzero imaginary part. Negative height exponents are retained correctly.

Since 3-4 sigma<=0 on sigma>=3/4, this longer scale is a useful alternative
for completing the upper real-part range. The remaining work is to connect
the actual Mobius-weighted polynomial branch to these short-sum inputs,
extend the bounded-power selection to the shorter useful window, and
assemble the full density count. No missing analytic input is assumed in
any theorem of this checkpoint. Zeta subconvexity is not proved here and
is not being asserted as a necessary intermediate step for this route.

## Verification

New independent consumers cover empty weighted blocks, beta=1/2 and 3/4,
a genuinely long block U=16 at abs(t)=1, a concrete decreasing Abel weight,
the lowest principal-pole scale, negative Type II height exponents,
sigma=3/4 and zero mollifier cutoff. Regression guards reject removing the
beta condition and dropping the general-length error terms. Full audit
counts are recorded in both READMEs and the proof map.

Full validation: 4,302 build jobs; all 4,530 project theorem declarations
in exact agreement between the two independent inventories, Audit targets
and parsed axiom output. Only the three standard axioms occur. All 304
Lean files are free of executable placeholders. All 165 independent
consumers pass (120 Layer 4, 9 Layer 3, 36 literature); all four deliberate
contract/power-confusion guards are rejected for the expected type mismatch.
