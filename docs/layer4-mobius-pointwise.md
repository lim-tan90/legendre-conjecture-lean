# Actual Mobius detector cancellation (2026-11-15)

The Weyl and second-derivative estimates now apply to the **actual** compact
detector coefficients, uniformly in the positive smoothing scale. These
pointwise estimates and the upper-range power-selection algebra do not yet
close the full curved-density benchmark above sigma=5/6.

## Exact arithmetic and smoothing

All results are exported by `import Legendre.Layer4`.
`Exponential/WeightedLogBlocks.lean` transfers a bound for block prefixes to
nonnegative decreasing real weights, with exact range/block endpoints.
It gives the real-part weighted general Weyl and second-derivative inputs.
`DetectorMonotoneWeight.lean` proves that the actual compact weight is the
complex embedding of the nonnegative antitone real function
`max(1-x,0)^2/2`; for x>=0 this weight is at most one. Finite Abel summation
therefore preserves the prefix bound under actual compact smoothing.

`DetectorDivisorBlocks.lean` proves the exact expansion of a block with
lower endpoint U>=X into positive divisors d<=X and inner indices

```
floor(U/d) < k <= floor(V/d),   n=d*k.
```

The same common coefficient sequence, Mobius cutoff, smoothing argument
and complex powers are retained. This is an exact finite identity, not an
inequality for a replacement polynomial.

`DetectorDividedPrefixes.lean` proves that for d<=U and V<=2U,

```
m=floor(U/d)>=1, floor(V/d)<=2m+1, U<=2*d*m.
```

The possible extra endpoint 2m+1 is counted. For beta in [0,1], the divided
real-part weights satisfy `d^(-beta) m^(-beta)<=2 U^(-beta)`. Dilating the
smoothing argument changes only its positive scale Y/d.

## Actual pointwise bounds

In namespace `Legendre.Density.Detector.Smooth`,
`polynomial_block_general_weyl` and `polynomial_block_second_derivative`
prove the two bounds below for the actual block P. The hypotheses are
1<=U, X<=U, U<=V<=2U, beta in [0,1], abs(t)>=1 and Y>0:

```
P=sum_{U<n<=V} polynomialCoefficient(X,Y,n) n^(-beta-it),

norm(P) <= C X U^(-beta)
  (1 + sqrt(U) abs(t)^(1/6) + U (U/abs(t))^(1/4) + U/abs(t)^(1/3)),

norm(P) <= C X U^(-beta) (1 + sqrt(abs(t)) + U/sqrt(abs(t))).
```

One positive coefficient works for both estimates, independently of every
parameter. The formulas are independently specified in
`ActualMobiusPointwiseBenchmark`; the closed
`layer4_actual_mobius_pointwise_comparator` supplies them. The implementation
also keeps the separate explicit constants and the literal factor 2X.
The X=0 case is included. All six new implementation modules are local
deductions; no additional third-party formalization is copied.

## Upper-range parameters

`UpperHuxleyParameters.lean` proves bounded power selection on the whole
sigma range [3/4,1] when the short-block length exponent satisfies

```
delta<=u<=c(sigma), c(sigma)=3/(4(3*sigma-1)), delta>0.
```

The selected integer is at most `ceil(1/delta)+2`; its length exponent is
between `1/(3*sigma-1)` and `3/(2(3*sigma-1))`. The cutoff varies between
3/8 and 3/5. This does not extend the previous square-root-length selection
without changing its upper length hypothesis.

For eta>=0 and 5/6+eta<=sigma<=1, the actual long-block parameter exponents
are each at most `-eta/8`:

```
1/6+(1/2-sigma)c(sigma),
-1/4+(5/4-sigma)*3/5,
-1/3+(1-sigma)*3/5,
-sigma*c(sigma),
1/2-sigma.
```

Strict saving needs eta>0. The remaining density proof must translate
these algebraic margins into height-uniform block bounds, absorb the
small cutoff and threshold costs, join the short/long Type I estimates,
and combine them with the already proved Type II bound at Y=T. The
known restricted curved theorem and all historical Layer 5 proof statuses
are unchanged by this prerequisite checkpoint.

## Verification

New standalone consumers cover a divided block with the extra endpoint
(d=3, U=5, V=10), zero Mobius cutoff, the real-part rounding loss at
beta=1, smoothing of a cancelling pair, nonempty actual detector blocks,
negative ordinates, power selection at sigma=1, both varying-cutoff
endpoints and strict upper exponent margins. Full inventory and audit
results are recorded in both READMEs and the proof map.

Full validation: 4,308 build jobs; all 4,618 project theorem declarations,
including private/generated ones, in exact agreement across both independent
inventories, Audit targets and parsed axiom output. Only the three standard
axioms occur. All 310 Lean files have zero executable proof placeholders.
All 174 standalone consumers pass (129 Layer 4, 9 Layer 3, 36 literature).
All four deliberate contract/power-confusion guards are rejected for the
expected type mismatch.
