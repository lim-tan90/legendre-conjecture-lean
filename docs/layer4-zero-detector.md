# Layer 4: finite Euler summation and an actual two-branch zero detector

This continues the [linear mean-square development](layer4-linear-mean-value.md).
The analytic detector and the sample-energy reduction below are proved. The
Ingham and Huxley density exponents remain open: the present detector length
and large-value bounds do not yet yield their required powers of height.

## Finite Euler formula and its pole contribution

[ZetaFiniteEuler.lean](../Legendre/ZetaFiniteEuler.lean) proves, for every
integer N≥1, Re(s)>0 and s≠1,

```
ζ(s) = Σ[1≤n≤N] n^(−s) + N^(1−s)/(s−1) − (1/2)N^(−s) − s R_N(s),
R_N(s) = ∫[N,∞) (fract(t)−1/2)t^(−s−1) dt,
|R_N(s)| ≤ N^(−Re(s))/(2 Re(s)).
```

In particular the error after subtracting the finite sum **and the pole term**
is at most `(1/2+|s|/(2 Re(s)))N^(−Re(s))`. The proof invokes the existing
attributed first-order Euler--Maclaurin theorem and the locally proved Euler
continuation, then splits an absolutely convergent remainder at N. It includes
N=1. No nonprincipal Dirichlet-character tail bound is applied to zeta.

## Finite Möbius cancellation

Write M_X(s)=Σ[1≤d≤X] μ(d)d^(−s) and Z_N(s)=Σ[1≤n≤N] n^(−s).
Let c_{X,N} be the Dirichlet convolution of μ truncated at X and the constant
arithmetic zeta coefficients truncated at N. Then c(1)=1, c(n)=0 for
2≤n≤X≤N, c(n)=0 for n>XN, and |c(n)|≤d(n). The exact finite identity is

```
M_X(s) Z_N(s) = 1+D_{X,N}(s),
D_{X,N}(s) = Σ[X<n≤XN] c_{X,N}(n)n^(−s).
```

This holds at every complex s, since all series used to multiply the finite
arithmetic functions have finite support. The proof is in
[Mollifier.lean](../Legendre/ZeroDetector/Mollifier.lean) and
[FiniteMollifier.lean](../Legendre/ZeroDetector/FiniteMollifier.lean).

## An actual detector at zeros

For natural H,X≥1 put N=(32HX)² and

```
P_{X,N}(s) = M_X(s) N^(1−s)/(s−1).
```

If ζ(ρ)=0, ρ≠1, 1/2≤Re(ρ)≤1 and |Im(ρ)|≤H, then
[ActualZetaDetector.lean](../Legendre/ZeroDetector/ActualZetaDetector.lean)
proves

```
|1+D_{X,N}(ρ)+P_{X,N}(ρ)| ≤ 9/64,
|D_{X,N}(ρ)| ≥ 3/8  OR  |P_{X,N}(ρ)| ≥ 3/8.
```

The smallness bound follows from the proved Euler error and |M_X(ρ)|≤X;
there is no hypothesized detector property. The polar compensation is a
separate branch. Both are retained in the sample bound below.

## Samples with independently varying real parts

[ComplexDirichlet.lean](../Legendre/ComplexDirichlet.lean) connects
F_N(s)=Σ a(n)n^(−s) with the earlier imaginary-axis convention, using
vertical coefficients a(n)n^(−σ). It proves differentiation with respect to
σ, the logarithmic derivative-energy bound and monotonicity of energy as
σ increases. [BetaVariation.lean](../Legendre/ZeroDetector/BetaVariation.lean)
controls evaluation at a different real part for every sample.

For N>1, sample ordinates t_i separated by δ>0, intervals
[t_i,t_i+δ]⊆[L,U], and σ≤β_i≤b with b−σ≤1,
[ComplexDirichletSampling.lean](../Legendre/ComplexDirichletSampling.lean)
proves

```
Σ_i |F_N(β_i+it_i)|²
  ≤ (2+log²N)(δ⁻¹+2 log N)(U−L+2πN) E_σ(a),
E_σ(a) = Σ[1≤n≤N] |a(n)|² n^(−2σ).
```

No common vertical line is assumed for the sampled zeros.

## Actual separated zero samples

Let X≥2, H≥1, σ∈[1/2,1], N=(32HX)² and L=XN. Put

```
K_H(m) = (2+log²m)(1+2 log m)(H+1+2πm).
```

For a finite set S of actual nontrivial zeros with Re(ρ)≥σ, ordinate in
[1,H], and pairwise ordinate spacing at least one,
[DetectorSamples.lean](../Legendre/ZeroDetector/DetectorSamples.lean) proves

```
|S| ≤ (64/9) [ K_H(L) E_σ(c·1_(X,∞))
              + N^(2(1−σ)) K_H(X) E_σ(μ) ].
```

The factor N^(2(1−σ)) bounds the polar branch away from height zero.
The formula displays both coefficient energies. It counts a separated set
of zero locations; the previously proved weighted selection is the interface
for restoring analytic multiplicities. The large detector length remains a
limitation for reaching a useful density exponent.

## Arithmetic coefficient input

[FrequencyLCM.lean](../Legendre/ZeroDetector/FrequencyLCM.lean) proves the
reciprocal-lcm sum bound by the cube of a harmonic sum.
[DivisorSquareMean.lean](../Legendre/ZeroDetector/DivisorSquareMean.lean)
then proves

```
Σ[1≤n≤M] d(n)² ≤ M(1+log M)³.
```

[CoefficientEnergy.lean](../Legendre/ZeroDetector/CoefficientEnergy.lean)
proves the dyadic consequence, for U≥1 and σ≥0,

```
Σ[U<n≤2U] |c_{X,N}(n)|² n^(−2σ)
  ≤ 2U(1+log(2U))³ U^(−2σ).
```

The [source inventory](openai-math-provenance.md), file headers and both
READMEs record every new adaptation, the fixed upstream commit and retained
license. No dependency pin or lockfile changes are required.

Validation of this slice: 4,113 full-build jobs; all 3,158 distinct project
theorem declarations audited against the three standard axioms; 141 Lean
files without executable `sorry`, `admit` or `sorryAx`; twenty-three Layer 4
and nine Layer 3 consumers pass compiled and standalone checks. The module-data
theorem inventory matches the parsed audit output exactly.
