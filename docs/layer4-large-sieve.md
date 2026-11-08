# Layer 4: finite large sieve, separated samples and weighted zero detection

This records the next verified slice after the [initial mean-value development](layer4-mean-values.md).
The public import remains `import Legendre.Layer4`. Layer 4 is **in progress**:
Ingham and Huxley density estimates remain to be proved.

## Finite additive large sieve

For any natural M,Q, any integer shift J and any complex coefficients c on Fin M,
`Legendre.LargeSieve.additive_large_sieve` proves

```text
Σ_{1≤q≤Q} Σ_{0≤h<q, gcd(h,q)=1}
  |Σ_{0≤n<M} c(n) exp(2πi (J+n)h/q)|²
  ≤ (M+Q²) Σ_n |c(n)|².
```

Both M=0 and Q=0 are included. The separated-frequency form has coefficient
`M+δ⁻¹`, where distinct frequencies have circle distance at least δ>0.
The coefficient shown here is the proved version, with no claim of the
additional minus-one improvement. A public phase bridge proves agreement
with the existing `realPhase` convention.

The proof slice includes the finite cosecant Hilbert inequality, inverse-square
spacing bounds, Hermitian spectral estimates, a concrete kernel-square identity,
finite matrix duality and the reduced-fraction separation argument.
The [source inventory and license record](openai-math-provenance.md) list every
ported module and the two local generalizations.

## Actual separated sampling points

For `P(t)=Σ_{1≤n≤N} a(n)n^(−it)` and `E=Σ|a(n)|²`, let a finite sample family
have points t_i with pairwise distances at least δ>0. Assume
`L≤t_i` and `t_i+δ≤U`, with L≤U. The proved estimate is

```text
Σ_i |P(t_i)|²
 ≤ (δ⁻¹+1+log²N) (U−L+4N(1+log N)) E.
```

Consequently, when |P(t_i)|≥V>0 for every sample,

```text
#samples ≤ (δ⁻¹+1+log²N) (U−L+4N(1+log N)) E / V².
```

This controls an actual finite cardinality. The proof uses a Sobolev sampling
inequality and disjoint half-open intervals, rather than attempting to count
points using only a continuous-time measure bound. Differentiation gives the
same Dirichlet polynomial with coefficients `−i log(n)a(n)`, whose energy is
at most log²N E. The squared modulus is differentiable even at zeros of P.
Empty support and touching sampling-interval endpoints are covered.

## Gram and Halasz--Montgomery interfaces

For a finite complex sample matrix F, an absolute row bound
`Σ_j |(FF*)_{ij}|≤R` implies `Σ_i |(Fa)_i|²≤R Σ_n|a_n|²`.
The proof expands the quadratic form, symmetrizes its absolute kernel and
uses finite matrix duality; no spectral or density conclusion is assumed.

For Dirichlet polynomials the correlation kernel is exactly
`K(i,j)=Σ_{1≤n≤N} n^(−i(t_i−t_j))`. If |K(i,j)|≤B for i≠j and B≥0, then

```text
Σ_i |P(t_i)|² ≤ [N+(#samples−1)B] E.
```

The predecessor in the formal expression is natural-number subtraction,
so the empty-family case is included. If all samples have size at least V≥0,

```text
#samples · (V²−BE) ≤ NE.
```

When V²>BE, division yields `#samples≤NE/(V²−BE)`.
The bound on the off-diagonal kernel is an explicit analytic hypothesis;
it is not replaced by an asserted zero-density theorem.

## Selecting zeros without discarding multiplicity

A general finite weighted-cover theorem proves that half-unit-window mass
at most B gives a set of one-separated representatives r with
`total weight≤2B·#r`. Natural weights can exceed one.

Apply this to `zeroMultiplicity` on `zerosRightOf σ T`. The low windows are
bounded by the fixed count N(5), and the high windows by the proved unit-height
Jensen bound. With an absolute positive `densitySelectionConstant=C_sel`,
for every real σ and T≥7 there is a finite set r of density zeros such that

```text
ρ,z∈r, ρ≠z  ⇒ |Im(ρ)−Im(z)|≥1,
N(σ,T) ≤ 2 C_sel log T · #r.
```

The explicit coefficient is

```text
C_sel = N(5)/log 2 + 2(1+log 80/log 2)/log(14/13) + 1.
```

N(5) is finite and not numerically evaluated here. All counts use analytic
multiplicities, the real boundary Re(ρ)≥σ, and the closed upper height boundary.

## Detector-to-density reduction

Suppose V>0 and a Dirichlet polynomial satisfies the **detector property**
`|P(Im(ρ))|≥V` for every ρ counted in N(σ,T), with T≥7. Combining the proved
selection and sampling bounds gives

```text
N(σ,T) ≤ 2 C_sel log T ·
  (2+log²N)(T+1+4N(1+log N)) E / V².
```

The proof supplies separated representatives and all local multiplicity and
sampling estimates. The analytic construction of a detector with parameters
strong enough for Ingham/Huxley remains open; the displayed property is an
explicit hypothesis of a conditional theorem.

## Source/proof map

| Step | Module/interface |
|---|---|
| Selected upstream Hilbert, spectral, duality, spacing and additive large-sieve proofs | [Exact 23-module inventory](openai-math-provenance.md) |
| Empty-case-safe and phase-compatible public large sieve | [LargeSieve.lean](../Legendre/LargeSieve.lean) |
| Integral control of arbitrary local samples | [SobolevSampling.lean](../Legendre/SobolevSampling.lean) |
| Dirichlet derivative and derivative energy | [DirichletDerivative.lean](../Legendre/DirichletDerivative.lean) |
| Separated-point energy and cardinality bounds | [DirichletSampling.lean](../Legendre/DirichletSampling.lean) |
| Complex Gram row bound and actual correlation kernel | [GramLargeValues.lean](../Legendre/GramLargeValues.lean) |
| Diagonal/off-diagonal energy and large-value count | [HalaszMontgomery.lean](../Legendre/HalaszMontgomery.lean) |
| General natural-weight representatives | [WeightedSeparation.lean](../Legendre/WeightedSeparation.lean) |
| Uniform logarithmic multiplicity loss for actual zeta zeros | [ZetaDensitySelection.lean](../Legendre/ZetaDensitySelection.lean) |
| Conditional detector-to-N(σ,T) theorem | [ZeroDetectionReduction.lean](../Legendre/ZeroDetectionReduction.lean) |

## Checkpoint validation (2026-11-08)

Verified source checkpoint: [`897139fbb45d`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/897139fbb45d96b98270f24bf5b196c411df1c19).

Full build: **4,097 jobs**. The audit covers **all 3,022 project theorem
declarations**, including private/generated helpers. It adds 176 declarations
to the previous 2,846-target audit. Independent module-data and full-environment
enumerations match the parsed output exactly. Only the three standard axioms
occur. All **125 project Lean files**, including Layer 0–4, have zero executable
`sorry`, `admit` or `sorryAx`; source-token and no-PDF checks pass.

Sixteen Layer 4 consumers and nine Layer 3 regression consumers pass compiled
and standalone source checks. The additional cases check a negative-shift
large sieve, touching intervals, empty large-sample sets at N=0, a zero derivative
at n=1, the half-turn phase normalization, a coincident-ordinate cluster carrying
weight 14, and the conditional zero-length-detector reduction. No dependencies
or version pins changed.
