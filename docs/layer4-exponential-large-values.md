# Actual logarithmic-phase cancellation and Halasz energy

This is a proved analytic input for Layer 4. Ingham 1940 density is already
proved. Huxley density, its global 12/5 exponent and Guth--Maynard remain open.

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
zeros with varying real parts. Interval subdivision, optimized large-value
counts and the final Huxley density estimate remain further obligations.

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
It is not a proof of the Huxley density benchmark.

Actual Halasz input validation (2026-11-10): full build 4,242 jobs; all 4,070
project theorem declarations, including private/generated helpers, audited
against exactly propext, Classical.choice and Quot.sound. Both independent
declaration inventories match the audit targets and actual axiom output.
All 246 project Lean files have zero executable placeholders. All 113
standalone consumers pass: 68 Layer 4, 9 Layer 3 and 36 literature checks.
An intentional use of the nonzero-ordinate kernel at t=0 is rejected.
