# Layer 4: the initial compact Mobius detector

This continues the [proved sixth-log fourth moment](layer4-moment-kernel.md).
The new compact smoothing scale Y is independent of the height and the
Möbius cutoff X. This does not yet replace the earlier actual zero detector:
the contour shift across zeta's principal pole remains to be proved.

All new modules are in `Legendre/Layer4/`, exported by `Legendre.Layer4`.
The namespace is `Legendre.Density.Detector.Smooth`.

## Proved identities and bounds

`DetectorWeight`, `DetectorKernel` and `DetectorKernelLeft` define

```
v(x) = max(1-x,0)^2/2,
k(w) = 1/[w(w+1)(w+2)].
```

The Mellin transform is exactly k(w) for Re(w)>0. Inversion is proved on
every line Re(w)>=1 and x>0. The weight vanishes for x>=1 and has
v(1/Y)>=1/4 for Y>=4. The right kernel has cubic vertical decay. On the
critical-side line w=-delta+iu, 0<delta<=1/2, the proved bound is

```
|k(-delta+iu)| <= (16/delta) (1+|u|)^(-3).
```

`DetectorCoefficients` and `DetectorProduct` define

```
a_X(n) = sum_{d|n, d<=X} mu(d),
M_X(s) = sum_{n<=X} mu(n) n^(-s).
```

For X>=1 and n<=X, a_X(n) is 1 at n=1 and 0 otherwise.
The norm is at most d(n), and both ordinary and harmonic divisor energies
are proved. On Re(s)>1 the absolutely convergent series satisfies

```
sum_n a_X(n) n^(-s) = zeta(s) M_X(s).
```

`DetectorSeries` and `DetectorIntegral` prove, for Re(s)>=0 and Y>0,

```
D_X(s,Y) = sum_{1<=n<=floor Y} a_X(n) n^(-s) v(n/Y)
         = (2*pi)^(-1) integral_{u in R}
             zeta(s+2+iu) M_X(s+2+iu) Y^(2+iu) k(2+iu) du.
```

Every individual vertical term is integrable, and the sum of its integral
norms is finite. These facts justify the exchange of series and integral;
the displayed formula is not an assumed detector property.
For X>=1 and Y>=1, the exact main/tail split is

```
D_X(s,Y) = v(1/Y) + sum_{X<n<=floor Y} a_X(n) n^(-s) v(n/Y).
```

## Remaining analytic obligation

The source nonprincipal-character L-function is entire. Riemann zeta has
a simple pole at s+w=1. Moving this initial right line to
Re(w)=1/2-Re(s) must retain the contribution at w=1-s. Neither the shift
nor its resulting polynomial-or-critical-integral detection alternative is
asserted here. Consequently the Ingham/Huxley density targets remain open.

## Sources and checks

The seven compact-detector files adapt `DensityDetectorWeight.lean`,
`DensityDetectorKernel.lean`, `DensityDetectorKernelLeft.lean`,
`DensityDetectorCoefficients.lean`, `DensityMollifierProduct.lean`,
`DensityDetectorSeries.lean` and `DensityDetectorIntegral.lean` from
[openai/math](https://github.com/openai/math), pinned commit
`4eaee87548250b2682affda7d05d947c05554bae`, under
`lean/OAI/NumberTheory/Ostmann/ZeroDensity/`, Apache-2.0.
The license is retained in `licenses/openai-math-Apache-2.0.txt`.
Both READMEs and [the exact source inventory](openai-math-provenance.md)
list every upstream filename and destination. No additional PNT+ code is copied.

Independent consumers check the support endpoint, exact value D_4(s,4)=9/32,
Y=1, the empty mollifier at the Re(s)=0 boundary, and delta=1/2.

Validation (2026-11-08): full build 4,171 jobs; all 3,615 distinct project
theorem declarations audited against propext, Classical.choice and Quot.sound.
Both independent theorem inventories match the audit and its actual output.
All 196 Lean source files have zero executable placeholders. The 89 standalone
consumers include 44 Layer 4, 9 Layer 3 and 36 literature checks. An intentional
bad consumer is rejected when using the sixth-log proof as the sharp log^4
claim.
