# Guth--Maynard S2 and the S3 energy input (2026-11-17)

Put R=card(W), Q=sum[t,u in W] norm(tail_N(t-u))^2, where tail_N is the
complete scaled nonzero-frequency Poisson series already used by the actual
sampling Gram trace. The new step uses the proved Heath--Brown difference-set
mean square through literal reflection, dyadic difference bins, powered
coefficients and a uniform epsilon budget.

## Complete S2 input

For every integer k>=1 and epsilon>0, constants C>0 and T0>=2 are chosen
before the scales and sample set. For 0<N<=T, T>=T0 and T^epsilon-separated
W in [0,T], the actual two-tail trace satisfies

```
norm(S2) <= C*T^epsilon*(N^2*R^2 + T*N*R^(2-1/k)
                       + N^2*R^(2-3/(4k))*T^(1/(2k))).
```

For nonempty W the complete tail moment Q is bounded by the same expression
with one outer factor N removed. This is a proved analytic estimate, with no
Heath--Brown, reflection or moment proposition assumed as an input. The source
positive k and epsilon, separation exponent and height window are retained.
The S2 estimate also includes W empty. The independent statements
`GuthMaynardPoissonTailMomentBenchmark` and `GuthMaynardS2Benchmark` spell out
the finite sum and all three physical powers; their comparison witnesses close.

## S3 energy estimate and the tolerance boundary

For epsilon>0, sufficiently large T, T^(2/3)<=N<=T and one-separated W in
[0,T], the actual three-tail trace satisfies the Proposition 8.1 energy form

```
norm(S3) <= C*T^(2+epsilon)*sqrt(R)*sqrt(E(W)) + C/T^90.
```

The port initially uses E_closed, counting ordered quadruples of additive
defect <=1. The paper uses E_strict with defect <1. The local `EnergyTolerance`
extension proves, for every finite real W without separation assumptions,

```
E_strict(W) <= E_closed(W) <= 3*E_strict(W).
```

Equal pair-sum floor bins have strict defect <1. Every shifted floor-bin
correlation is bounded by this strict energy via finite Cauchy--Schwarz.
A closed unit defect crosses at most one floor-bin boundary, so summing the
three possible shifts gives the factor three. This pays only an absolute
constant in the square-root energy bound and preserves every power of T,R,N.
The two energy definitions are not equated: for W={0,1}, they are 6 and 14.

The strict and closed literal independent benchmarks retain the length window,
real coefficient energy and T^-90 remainder. Further affine/energy refinement
and final large-value/density assembly remain open. In particular this step
does not close central density on (7/10,4/5) or prove a prime-gap exponent.

## Sources and adaptation

All new adapted code uses the existing source #5, **smccolm/Lean**, fixed
commit `4c8fb7f7816508825089230e3730b69165e5e303`, MIT-0, with the retained
license. The complete mapping is in [the provenance table](smccolm-guth-provenance.md)
and both READMEs, under independently collapsible default-open source details.
`CubicTwoTailEstimate` adapts the remaining `LargeValuesS2`; `CubicThreeTail`
adapts `LargeValuesS3`. Previously ported identities are reused.
`CubicThreeTailSupport` retains only a harmonic bound, unit bump and separated
reciprocal-distance lemma from the original broad dependency chain.
`EnergyTolerance` adapts the floor-correlation proof and adds the local
strict/closed comparison. Every file is checked from source under Lean 4.35.0.

S2/S3 validation (2026-11-17): Lean 4.35.0 full build passes 4,345 jobs.
All 6,688 project theorem declarations, including private/generated declarations,
agree exactly between module-data inventory, independent environment ownership,
Audit targets and parsed axiom output. Only propext, Classical.choice and
Quot.sound occur. All 344 classified Lean files, including Layers 0--4, have
zero executable placeholders/prohibited shortcuts; no PDFs are present.
All 210 independent consumers pass (165 Layer 4, nine Layer 3, 24 generated
literature, 12 literature regressions). Added consumers cover k=2 exponents,
complete actual tail moment, empty S2, singleton S3, strict/closed boundary
energies 6 and 14 and the factor-three bridge without separation assumptions.
Four negative checks reject missing S3 length/remainder conditions, false
energy equality and confusion with central density. All22 adapted modules
(including the local tolerance extension) retain fixed MIT-0 source metadata
and compile from source under Lean4.35.0; all five visible repository headings
and default-open source details are preserved in both READMEs.

Verified proof commit: [0d99ae4c69fa8fd04faa9620936cabf18ba5e231](https://github.com/lim-tan90/legendre-conjecture-lean/commit/0d99ae4c69fa8fd04faa9620936cabf18ba5e231).
