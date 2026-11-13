# Global Huxley 12/5 density from the actual compact detector

`Zeta.hasZeroDensityEstimate_twelve_fifths` is a closed proof of

```
for every epsilon>0 there is C>0, uniform for sigma in [1/2,1], T>=2:
N(sigma,T) <= C T^((12/5)(1-sigma)+epsilon).
```

`N` counts actual zeta zeros with analytic multiplicities. The proof first gives
`C T^((12/5)(1-sigma)) (1+log T)^38`; the fixed logarithmic loss is absorbed
into arbitrary positive epsilon. Constants are existential and independent of
sigma and T. No numerical coefficient, paper-exact logarithmic loss or
short-interval prime theorem is claimed.

`Literature.HuxleyGlobalDensity` states this benchmark independently;
`layer4_huxley_global_comparator` is its unconditional proof. The stronger
`Huxley1972Density` exponent `3(1-sigma)/(3 sigma-1)` is unchanged and remains
open, as do the curved Guth--Maynard target and the sharp log^4 fourth moment.
The existing roadmap acceptance criteria ask for the global 12/5 estimate and
permit explicitly labelled stronger open analytic Props. Those criteria are
now fulfilled; none of the stronger open Props is assumed in this proof.

## Actual detector branch bounds

The proved analytic Halasz two-term count and divisor-square block energy give,
for sigma>=2/3, the actual polynomial alternative

```
R <= C (1+log(2Y+1))^22 (1+log(2T))
       [Y^(2-2 sigma)+T X^(4-6 sigma)].
```

The threshold remains 1/16, matching the literal compact zero detector.
Blocks above the compact support are zero. Finite union bounds, rather than
a selection hypothesis, account for all large blocks.

For the actual critical integral, put
`A=4+criticalPolynomialCountCost(X,T)` and choose X<=2^J. The proved actual
mollifier moment and critical-mass fourth moment imply one of

```
R^3 <= C K^4 T log^6(T) (A J)^2,
R^(5/3) <= C K^4 T log^6(T) (A T)^(2/3),
K=256 Y^(1/2-sigma)/(sigma-1/2).
```

All integrals are the same actual integrals appearing in the compact detector;
no density estimate is an input. On sigma in [3/4,1], the kernel cost is uniform:
`K^4 <= 1024^4 Y^(2-4 sigma)`. With L=1+log T and X<=2T, local proofs give
`A<=C X L^14`, `J<=C L` and `(AT)^(2/3)<=C X^(2/3)T^(2/3)L^10`.

## A common balance with retained integer cutoffs

For sigma in [3/4,1], define

```
q=sigma^2+sigma-1 > 0,
x=(2 sigma-1)/(2q),   1/2<=x<=4/5,
y=(5 sigma-3)/(2q),   1<=y<=6/5,
b=(5 sigma-3)(1-sigma)/q <= (12/5)(1-sigma).
```

The exact identities and inequality are proved in `HuxleyBalance.lean`:

```
y(2-2 sigma) = 1+x(4-6 sigma) = b,
1+2x+y(2-4 sigma) <= 3b,
5/3+(2/3)x+y(2-4 sigma) = (5/3)b.
```

Take X=ceil(T^x), Y=T^y. The proof retains X>=1, T^x<=X<=2T^x,
X<=2T, X<=2^J and a logarithmic bound on J. For T>=128 it also proves
`4<=Y<=(T/2)^2`, so the actual detector's principal-pole constraints hold.
Both alternatives give `R<=C T^b L^36`, with one constant for the entire closed
sigma interval. In particular, the endpoints sigma=3/4 and sigma=1 are included.

## From samples to the actual zero count

The actual high-shell dichotomy splits zeros between the two bounded
alternatives. A finite dyadic height cover retains the upper endpoints and
costs one logarithm, yielding a sample bound with L^37. The already proved
multiplicity-preserving selection theorem restores analytic multiplicities,
costing another logarithm. The fixed low-height count N(128) is retained.
For 2<=T<128, monotonicity gives the same uniform bound.

Below sigma=3/4, the proved Ingham exponent satisfies
`3(1-sigma)/(2-sigma)<=(12/5)(1-sigma)`. Combining the two ranges proves the
global result without any exceptional sigma gap. It does not by itself prove
the Layer 5 Huxley prime-gap exponent 7/12+epsilon.

## Attribution and verification

The new estimates and parameter balance are local deductions from the already
credited analytic kernel, divisor energy, moment and detector APIs.
`HuxleyShellDensity.lean` reuses the finite branch assembly in the repository's
`SeparatedShellDensity.lean`, originally adapted from `DensitySeparatedCount.lean`
in openai/math commit `4eaee87548250b2682affda7d05d947c05554bae`, Apache-2.0.
Its notice is retained, both READMEs list the new destination, and
`licenses/openai-math-Apache-2.0.txt` retains the license.


Global 12/5 density validation (2026-11-13): full build 4,272 jobs. All
4,264 project theorem declarations, including 88 added declarations (52 public
and 36 private/generated), have identical module-data inventory, independent
full-environment inventory, audit-target set and actual parsed axiom output.
Only propext, Classical.choice and Quot.sound occur. All 274 project Lean files
have zero executable sorry/admit/sorryAx and no forbidden proof shortcuts.
All 127 independent consumers pass: 82 Layer 4, 9 Layer 3 and 36 literature.
Lean rejects treating the new global proof as the stronger curved Huxley target,
using the nonzero-ordinate kernel at t=0, and using the critical polynomial
count below W=2. The roadmap acceptance criteria are fulfilled; the stronger
curved Huxley/Guth--Maynard and sharp log^4 targets remain explicitly open.

Locally verified proof commit: `484d8dfc70c24cb715743a2fc6ca811f800f0c67`.
