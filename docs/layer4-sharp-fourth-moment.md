# Sharp logarithmic upper bound for the zeta fourth moment

For every real `T ≥ 2` the same absolute constant `C > 0` satisfies

```text
∫₀ᵀ |ζ(1/2 + it)|⁴ dt ≤ C T (log T)⁴.
```

The public theorem is `Legendre.Zeta.zeta_fourth_moment_log_four`. Its
symmetric-interval form follows from conjugation, and the independent
`Legendre.Literature.layer4_fourth_moment_log_four_comparator` has type
`ZetaFourthMoment`. This is the moment upper bound used in the Layer 4
roadmap. The fourth-moment asymptotic would additionally require a
leading coefficient and an error term.
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
