# Layer 4: the initial compact Mobius detector

This continues the [proved sixth-log fourth moment](layer4-moment-kernel.md).
The new compact smoothing scale Y is independent of the height and the
Möbius cutoff X. The critical-line shift and a high-zero detection alternative are now proved,
with the exact principal-pole contribution retained.

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

## Compensated critical-line shift

`DetectorAnalytic` forms the entire numerator

```
N(w) = poleRemovedZeta(s+w) M_X(s+w) Y^w.
```

At an actual zero s!=1, N(0)=0. Its divided difference at zero is entire.
After division by (w+1)(w+2), the remaining pole is at w=1-s, with coefficient

```
P_X(s,Y) = M_X(1) Y^(1-s) k(1-s).
```

`DetectorRectangle` proves the exact rectangle residue 2*pi*i*P_X(s,Y).
`DetectorVertical` proves integrability on the right and critical-side lines;
`DetectorHorizontal` proves that both horizontal edges vanish, using
|Im(w)|>=|Im(s)|+1 to stay away from the shifted zeta pole. `DetectorShift`
therefore proves, when 1/2<Re(s)<=1, s!=1, zeta(s)=0 and Y>=1,

```
D_X(s,Y) = P_X(s,Y) + J_X(s,Y),
J_X(s,Y) = (2*pi)^(-1) integral_{u in R}
  zeta(s+a+iu) M_X(s+a+iu) Y^(a+iu) k(a+iu) du,
a = 1/2-Re(s).
```

The pole contribution has a positive sign. Neither zeta nor its original
integrand is declared entire: the removable origin is regularized, and the
remaining principal pole is evaluated separately.

## Explicit high-zero alternative and critical masses

`DetectorPoleBound` gives |P_X(s,Y)|<=4/T when Re(s)>=1/2, T>0,
|Im(s)|>=T, X<=4T and 1<=Y<=T^2. In particular it is <=1/16 for T>=64.
Combining the exact shift with the main/tail split and v(1/Y)>=1/4 gives
`DetectorAlternative.detector_high_zero_dichotomy`: for T>=64,
|Im(s)|>=T, 1<=X<=4T, 4<=Y<=T^2 and an actual zero with 1/2<Re(s)<=1,
either the compact tail polynomial or |J_X(s,Y)| is at least 1/16.
This is proved from zeta vanishing and explicit numerical hypotheses, not
from an assumed detection property.

`DetectorCriticalMass` uses the original ordinate convention and proves
integrability of

```
B_X(t) = integral_u (1+|u|)^(-3)
  |zeta(1/2+i(t+u)) M_X(1/2+i(t+u))| du.
```

For every 1/2<sigma<=Re(s)<=1 and Y>=1, it proves the uniform bound

```
|J_X(s,Y)| <= [16 Y^(1/2-sigma)/(sigma-1/2)] B_X(Im(s)).
```

The next analytic obligations are packing these masses, proving whole-line
weighted moments, sharply counting the polynomial branch, and balancing
the parameters. The Ingham/Huxley density targets and Layer 4 completion
remain open. The literature comparison now includes the proved compensated
detector benchmark with its exact numerical range.

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

The compensated addition also adapts `DensityDetectorAnalytic.lean`,
`DensityMollifierBound.lean`, `DensityDetectorVertical.lean`,
`DensityDetectorHorizontal.lean`, `DensityDetectorShift.lean`,
`DensityDetectorDichotomy.lean` and `DensityCriticalDetector.lean` at that same
pin and license. `DetectorRectangle.lean` and `DetectorPoleBound.lean` are
local deductions using the already credited residue API and kernel bound.

Independent consumers check the support endpoint, exact value D_4(s,4)=9/32,
Y=1, the empty mollifier at the Re(s)=0 boundary, and delta=1/2. New checks
cover zero and nonzero principal residues, T=64 with maximal cutoffs, the
positive sign of the residue, high zeros of either ordinate sign, and
integrability of the critical mass at t=0.

Validation (2026-11-08): full build 4,171 jobs; all 3,615 distinct project
theorem declarations audited against propext, Classical.choice and Quot.sound.
Both independent theorem inventories match the audit and its actual output.
All 196 Lean source files have zero executable placeholders. The 89 standalone
consumers include 44 Layer 4, 9 Layer 3 and 36 literature checks. An intentional
bad consumer is rejected when using the sixth-log proof as the sharp log^4
claim.

Compensated-detector validation (2026-11-09): 4,180 full-build jobs; all 3,701
project theorem declarations audited; 205 Lean sources without executable
placeholders. Both independent declaration inventories match the audit and
its actual axiom output. All 95 independent consumers pass: 50 Layer 4,
9 Layer 3 and 36 literature checks. Ingham/Huxley remain open.
