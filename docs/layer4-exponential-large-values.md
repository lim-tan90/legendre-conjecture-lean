# Actual logarithmic-phase cancellation and Halasz energy

This is a proved analytic input for Layer 4. Ingham 1940 density is already
proved. The global Huxley 12/5 exponent is now proved as well; the stronger
curved Huxley target and Guth--Maynard remain open. See
[the final actual density proof](layer4-huxley-density.md).

## Derivative tests and actual Dirichlet phases

The credited Kusmin--Landau test bounds a finite phase sum by 2/beta when its
monotone increments lie between q+beta and q+1-beta for one integer q. The
second-derivative test, including negative derivatives by Darboux and
conjugation, proves

```
|sum_{j<N} exp(2 pi i f(x+j))|
 <= (6 A+15) [N sqrt(lambda)+1/sqrt(lambda)]
```

from actual derivative data on the closed supporting interval, with
0<lambda<=|f''|<=A lambda. There is no assumed exponential-sum bound.

The local phase f(x)=-t log(x)/(2 pi) equals n^(-it) at positive integers.
For 1<=U<=V<=2U and t nonzero, the specialization proves

```
|sum_{U<n<=V} n^(-it)| <= C2 [sqrt(|t|)+U/sqrt(|t|)],
C2 = 69 [sqrt(18 pi)+1/sqrt(18 pi)].
```

When 0<|t|<=U the first-derivative estimate gives the stronger
12 pi U/|t| bound. Conjugation handles negative ordinates. Combining the two
ranges proves the actual correlation-kernel estimate

```
|sum_{U<n<=V} n^(-it)| <= C [sqrt(|t|)+U/|t|],
C = 2 C2+12 pi > 0.
```

## Harmonic packing and Gram duality

A one-separated finite real set with 1<=|x|<=H, H>=1, satisfies
sum_x 1/|x| <= 2(1+log H). The proof uses the existing ordered separation
bound and retains a finite harmonic sum. Both signs are included.

For R one-separated ordinates in [-T,T], T>=1, define

```
E = sum_{U<n<=V} |a(n)|^2,
Gamma(U,T,R) = U+C [R sqrt(2T)+2 U (1+log(2T))].
```

The actual kernel, its diagonal and harmonic rows give

```
sum_j |sum_{U<n<=V} a(n)n^(-it_j)|^2 <= Gamma(U,T,R) E.
```

This uses finite Gram duality; the off-diagonal kernel bound is proved above,
rather than assumed. In particular, when all values have norm at least W>=0,

```
R [W^2-C sqrt(2T) E] <= U [1+2 C(1+log(2T))] E.
```

A cardinality bound follows by division when the displayed bracket is positive.

## Independently varying real parts

For sigma<=beta_j<=b with b-sigma<=1, put
E_sigma=sum_{U<n<=2U}|a(n)|^2 n^(-2 sigma). Parameter variation and the existing
logarithmic derivative energy bound prove

```
sum_j |sum_{U<n<=2U} a(n)n^(-beta_j-it_j)|^2
 <= (2+log^2(2U)) Gamma(U,T,R) E_sigma.
```

No common vertical line is imposed on the samples. This permits use at actual
zeros with varying real parts. Interval subdivision and the optimized two-term
large-value count below are now proved. The global 12/5 density consequence is now proved; the stronger curved target remains open.

## Optimized large values and actual mollifier moments

For T>=1 and W>0, the short-window absorption scale
`H0=W^4/(8 B^2 C^2 E_sigma^2)`, with `B=2+log^2(2U)`, and an exact finite
height cover prove the unconditional count

```
R <= K (1+log(2U))^6 (1+log(2T))
       [U E_sigma/W^2 + U T E_sigma^3/W^6],
K = (18+864 C^2)(1+2C) > 0.
```

Finite Cauchy and unit separation cover the dense and zero-energy cases.
`Literature.layer4_actual_halasz_large_values_comparator` is a closed proof
of the independently stated benchmark. It assumes actual large values,
unit spacing and a strip of width at most one; it assumes no kernel or density bound.

For bounded coefficients, dyadic critical blocks have energy at most one.
The full polynomial P_X then satisfies, for X>=1 and W>=2,

```
#{j: |P_X(1/2+it_j)|>=W}
 <= K0 X (1+log X)^13 (1+log(2T)) [W^(-2)+T W^(-6)],
K0 = 256 K 4^6 (2/log 2)^7 > 0.
```

Twisting coefficients preserves their norms, so the same bound holds for
`t_j+c` for every common real shift c, without enlarging T.
Finite dyadic layer summation proves

```
sum_j x_j^2 <= R V^2+4 A J+8 B/V^4
```

from the actual two-term distribution at levels V*2^j, j<J, amplitudes bounded
by V*2^J. Choosing an amplitude V>=2 proves, for the actual Mobius polynomial,
X<=2^J and A=4+K0 X(1+log X)^13(1+log(2T)),

```
sum_j |M_X(1/2+i(t_j+c))|^2 <= 4 A J+5 R^(2/3) (AT)^(1/3).
```

The bound includes X=1, J=0 and the empty sample family. Integrating the common
shift against `w(u)=(1+abs(u))^(-3)` gives the corresponding packed mollifier
mean. Combined with the proved packed zeta fourth moment and finite product
Cauchy, this proves

```
(sum_j criticalMass(X,t_j))^4
 <= C0 R T log^6(T) [4 A J+5 R^(2/3)(AT)^(1/3)]^2
```

for T>=2, with an existential C0>0 uniform in X,J,T and the sample family.
All quantities are the actual integrals used by the compact detector.
The improved actual detector polynomial count and Huxley parameter balance are
now proved in [the density assembly](layer4-huxley-density.md).

## Sources and public interface

Use `import Legendre.Layer4`; implementation modules are under
`Legendre/Layer4/Exponential/`. The eight derivative-test modules adapt
openai/math commit `4eaee87548250b2682affda7d05d947c05554bae`, source prefix
`lean/OAI/NumberTheory/EgyptianFractions/`, Apache-2.0. The full license is
retained in `licenses/openai-math-Apache-2.0.txt`. Both READMEs and
[the provenance inventory](openai-math-provenance.md) list every exact upstream
filename and destination. Imports are restricted to the required mathlib
modules; namespaces and module visibility are adapted. The logarithmic-phase,
harmonic-packing and Halasz specializations are local deductions using the
already credited finite Gram and parameter-variation interfaces. No additional
PNT+ code is copied.

`Literature.layer4_actual_halasz_comparator` is a closed proof of an independent
energy benchmark retaining the square-root-height and harmonic-row terms.
The separate `layer4_huxley_global_comparator` now proves the global density
benchmark. The stronger curved Huxley target remains open.

Actual large-value and moment validation (2026-11-11): full build 4,262 jobs; all 4,176
project theorem declarations, including private/generated helpers, audited
against exactly propext, Classical.choice and Quot.sound. Both independent
declaration inventories match the audit targets and actual axiom output.
All 264 project Lean files have zero executable placeholders. All 119
standalone consumers pass: 74 Layer 4, 9 Layer 3 and 36 literature checks.
Intentional uses of the nonzero-ordinate kernel at t=0 and the critical
polynomial count below its W>=2 threshold are rejected.
