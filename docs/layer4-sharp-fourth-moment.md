# Sharp logarithmic order of the zeta fourth moment

For every real `T ≥ 2` the same absolute constant `C > 0` satisfies

```text
∫₀ᵀ |ζ(1/2 + it)|⁴ dt ≤ C T (log T)⁴.
```

The public theorem is `Legendre.Zeta.zeta_fourth_moment_log_four`. Its
symmetric-interval form follows from conjugation, and the independent
`Legendre.Literature.layer4_fourth_moment_log_four_comparator` has type
`ZetaFourthMoment`. The Layer 4 roadmap uses this upper bound. The matching lower bound and
the comparison with Ingham’s leading asymptotic appear below.
[Proof](../Legendre/Layer4/ZetaFourthMomentSharp.lean)
[Comparator](../Legendre/Literature/LayerCoverage.lean)

## Proof

1. On each height shell `[T/2,T]`, choose an integer cutoff `10T ≤ N ≤ 16T`
   and the Mellin line `Re w = 1/log N`. Split the xi-square kernel into
   `N^w exp(w²)/w` and its remainder.
2. For the first term, the scalar integral with `x = log(N/n)` equals
   `√π ∫₀^∞ exp(−(x−v)²/4) dv`. Its absolute value is bounded by the
   full Gaussian integral, uniformly in the contour width and in `n`.
   The resulting polynomial has coefficients given by this bounded
   multiplier times the critical-line divisor coefficients.
   [Gaussian integral](../Legendre/Layer4/GaussianMellinPole.lean)
3. The signed Gamma shift estimate controls the normalized kernel on
   `|w| < 1/4`. The normalized difference vanishes at zero, so the
   Schwarz estimate removes the factor `1/w`. Outside that disk the
   denominator is bounded away from zero. The resulting Gaussian majorant
   for the remainder has no inverse power of the contour width.
   [Signed Gamma shift](../Legendre/Layer4/XiSmallGammaShift.lean)
   [Remainder bound](../Legendre/Layer4/XiMellinRemainder.lean)
4. Apply translated Dirichlet mean square and divisor coefficient energy
   to both pieces. This gives `O((N+T)(log N)⁴)` for the finite head.
   The existing dyadic tail has at most three logarithms. The combined
   estimate is uniform in the truncation, so Fatou’s lemma and the
   pointwise xi-square bound give the zeta fourth moment on the shell.
   A sum over dyadic heights and the fixed integral on `[0,1]` gives
   the full range.
   [Head mean](../Legendre/Layer4/XiSharpHeadMean.lean)
   [Final bound](../Legendre/Layer4/ZetaFourthMomentSharp.lean)

The proof reuses the pinned [openai/math adaptation](../README.md#3-openaimath)
in the xi-square and dyadic-tail infrastructure. The Gaussian pole
transform and its uniform remainder bound are proved locally. Independent
consumers check the endpoint `T=2` and the invariance of the scalar pole
coefficient when the positive Mellin width changes.
[Consumers](../Legendre/Tests/Layer4.lean)

## Matching lower bound

For some absolute constants `c>0` and `T₀≥2`, every `T≥T₀` satisfies

```text
c T (log T)⁴ ≤ ∫_T^{2T} |ζ(1/2 + it)|⁴ dt.
```

Applying the shell estimate at `T/2` gives a lower bound of the same order
on `[0,T]`. The public theorem `Legendre.Zeta.zeta_fourth_moment_order`
combines this with the upper bound. The closed
`layer4_fourth_moment_order_comparator` checks both bounds against the
independent proposition `ZetaFourthMomentOrder`.
[Proof](../Legendre/Layer4/ZetaFourthMomentLower.lean)
[Comparators](../Legendre/Literature/LayerCoverage.lean)

Ingham’s leading asymptotic gives the coefficient `1/(2π²)` after
division by `T (log T)⁴`. The literal proposition
`InghamFourthMomentMainTerm` records that limit as an open refinement.
[Ingham, Proceedings of the London Mathematical Society](https://doi.org/10.1112/plms/s2-27.1.273)

1. Embed quadruples `(a,b,c,d)` with `gcd(b,c)=1` into ordered divisor
   pairs `(ab,ac)` of `abcd`. The gcd of the two divisors recovers `a`.
   The harmonic coprime-pair sum is at least one quarter of the unrestricted
   sum, yielding four logarithms in the divisor-square energy.
   [Divisor energy](../Legendre/Layer4/FourthMoment/DivisorEnergyLower.lean)
2. On `[T,2T]`, truncate the Euler sum at `⌈2T⌉` and pair its square with
   a divisor polynomial of length `M=⌊T^(1/32)⌋⁴`. Their coefficients
   agree through `M`. After rescaling, the weight `((x−1)(2−x))²`
   has integral `1/30` and a Fourier transform bounded by `6/|u|²`
   for `u≠0`. The off-diagonal pairing is bounded uniformly in `T`.
   [Weighted pairing](../Legendre/Layer4/FourthMoment/FourthMomentTestPolynomial.lean)
3. The uniform Euler error is `O(T^(−1/2))`. The Weyl bound and the
   short divisor polynomial bound make the replacement by the actual
   zeta square cost `O(1)` in the pairing. Cauchy–Schwarz and the upper
   divisor energy bound then give the fourth-moment lower bound.
   [Euler comparison](../Legendre/Layer4/FourthMoment/FourthMomentApproximation.lean)

## Leading term of the divisor-square diagonal

For every real cutoff `x≥1`,

```text
∑_{1≤n≤x} d(n)²/n = (log x)⁴/(4π²) + O((1+log x)³).
```

The uniform bound and the normalized limit are exported by
`abs_harmonicDivisorSquare_sub_log_main_le` and
`harmonicDivisorSquare_tendsto_log_four`. The literal diagonal comparator
expands the sum through the integer part of the real cutoff.
[Proof](../Legendre/Layer4/FourthMoment/DivisorSquareAsymptotic.lean)
[Comparator](../Legendre/Literature/LayerCoverage.lean)

The fourth convolution power of the constant-one arithmetic function is
the convolution of `d(n)²` with the positive-square indicator. Its weighted
sum has leading term `(log x)⁴/24` by integral comparison. Square scales
have total weight `ζ(2)=π²/6`, so the diagonal coefficient is
`1/(24ζ(2))=1/(4π²)`. The square scales beyond one have total weight
at most `3/4`, which lets induction absorb their errors. Ingham’s
zeta-integral coefficient remains an open refinement.
[Convolution identity](../Legendre/Layer4/FourthMoment/DivisorSquareEuler.lean)
[Harmonic convolution estimate](../Legendre/Layer4/FourthMoment/HarmonicFactorTuples.lean)
