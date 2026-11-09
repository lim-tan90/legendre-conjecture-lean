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

Whole-line moments, mass packing and the integral-branch count are now supplied
below. The next obligations are the sharp polynomial count and balancing
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

## Whole-line moments and the integral-branch count

The weight W_T(v)=(1+|v/T|)^(-3) transfers compact-height moment bounds to
the whole line by disjoint dyadic shells. The weighted zeta fourth moment
is <=C T log^6 T; the weighted Mobius second moment is
<=C(X+T)(1+log X), with actual integrability in both cases.

For one-separated ordinates t_i in [-T,T], the cubic kernels satisfy
sum_i (1+|v-t_i|)^(-3) <= K W_T(v), for one absolute K. This packing bound
has no factor R=card(S). Weighted Cauchy inequalities then prove

```
(sum_i B_X(t_i))^4 <= C R T (X+T)^2 (log T)^6 (1+log X)^2.
```

The exact mass bound on J_X implies, for points in the integral branch
with threshold 1/16 and sigma<=Re(s)<=1,

```
R^3 <= C [256 Y^(1/2-sigma)/(sigma-1/2)]^4
         T (X+T)^2 (log T)^6 (1+log X)^2.
```

All constants precede the point set and parameters. This is an actual branch
count derived from the proved moments, not an assumed zero-density bound.
The logarithmic fourth moment remains the sixth-log variant. The polynomial
branch and the final Ingham/Huxley estimates remain open.

The additional `Layer4` files adapt the dyadic-height, weighted-moment,
kernel-packing, product-Cauchy and integral-alternative slices of the same
openai/math pin and Apache-2.0 license. Both READMEs and the provenance
inventory list all exact source filenames and destinations.

Weighted-moment and integral-branch validation (2026-11-09): full build 4,193
jobs, all 3,788 project theorem declarations audited, 218 Lean sources without
executable placeholders. Both independent inventories match the axiom audit.
All 101 standalone consumers pass: 56 Layer 4, 9 Layer 3 and 36 literature.
The tests include zero height in the dyadic cover, adjacent separated samples,
T=2 weighted moments, X=1 and the singleton packed critical mass.

## Polynomial counts and the proved Ingham exponent (2026-11-09)

The actual compact tail splits into dyadic blocks. The sharp varying-real-part
sample bound and divisor energy imply, for its large-value branch,

```
R <= C (1+log(2Y+1))^8 [Y^(2-2sigma)+T X^(1-2sigma)].
```

Taking X=ceil(T), Y=T^(3/(2(2-sigma))) balances this with the integral
alternative. On each high shell [T/2,T], T>=128, both branches give
R <= C T^(3(1-sigma)/(2-sigma)) log^8 T. The factor 1/(sigma-1/2)
is controlled outside the band sigma-1/2 <= 1/log T; inside it, unit
separation supplies the same exponent with an absolute constant. This also
includes sigma=1/2. The balance respects X<=4(T/2), Y<=(T/2)^2.

A real dyadic cover with T<=2^J<=2T costs one logarithm and no power of T.
Weighted representative selection restores every analytic zero multiplicity,
costing one further logarithm. Zeros with ordinate <=64 are retained as
zeroCount(64); the remaining bounded range 2<=T<128 is bounded by
zeroCount(128). Consequently `Zeta.ingham_density_log_bound` proves

```
N(sigma,T) <= C T^(3(1-sigma)/(2-sigma)) (log T)^10
           (1/2 <= sigma <= 1, T>=2),
```

with C uniform in sigma and T. `Zeta.ingham_density_epsilon` absorbs the
logarithm for every positive epsilon. `Literature.layer4_ingham_comparator`
is a closed proof of `Ingham1940Density`, rather than a conditional bridge.
The logarithmic power is not claimed sharp. Huxley, Guth–Maynard, the sharp
fourth-moment log^4, and Layer 4 completion remain open. Ingham's different
1937 short-interval results remain open, including their stronger zero-free
input. Exact adaptation paths appear in both READMEs and the provenance list.

Ingham density validation (2026-11-10): full build 4,206 jobs. All 3,874
project theorem declarations, including private/generated helpers, are audited
against propext, Classical.choice and Quot.sound. Both independent declaration
inventories match the audit targets and actual axiom output exactly. All 231
Lean sources have zero executable sorry, admit or sorryAx. All 107 standalone
consumers pass: 62 Layer 4, 9 Layer 3 and 36 literature. The added consumers
cover the real-height top boundary, the balanced sigma=3/4 powers, density
exponents at sigma=1/2 and 3/4, T=2 uniformly in sigma, and linear exponent
three. An intentional Ingham-as-Huxley consumer is rejected by Lean.
