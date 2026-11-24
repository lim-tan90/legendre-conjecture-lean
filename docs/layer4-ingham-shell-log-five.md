# Ingham's separated zero count on a height shell

For `T≥128` and `1/2<σ≤1` with `σ−1/2≥1/log T`, let `S` be a
finite collection of zeta zeros `βᵢ+itᵢ` with `σ≤βᵢ≤1`,
`T/2≤|tᵢ|≤T` and `|tᵢ−tⱼ|≥1` for distinct indices. Then an absolute
constant satisfies
`|S| ≤ C T^(3(1−σ)/(2−σ)) (log T)^5`.
[Independent literal comparator](../Legendre/Literature/LayerCoverage.lean)
[Shell proof](../Legendre/Layer4/SeparatedShellDensity.lean)

A dyadic block `U<n≤2U` can be sampled on the fixed real line `σ`
with coefficients projected onto each prefix of the block. Applying the
proved Montgomery estimate to these masked coefficients gives the same
`O(T+U)` factor for every prefix. For a sample on the line `βᵢ`,
Abel summation removes the factor `(U/n)^(βᵢ−σ)` using prefix
polynomials. Consecutive weights differ by at most `1/U` uniformly for
`0≤βᵢ−σ≤1`. Squaring and summing the resulting prefix bound gives an
absolute sampling cost for varying real parts.
[Dyadic sampling proof](../Legendre/Layer4/DyadicVariableSampling.lean)

Divisor coefficient energy accounts for three logarithms and the finite
dyadic block sum accounts for two. The existing balanced choice of the
detector cutoffs and the fourth-log integral-branch bound give the
fifth-log estimate on the shell. For the cumulative density with analytic
multiplicities, the existing Layer 4 theorem supplies the uniform curved
exponent with arbitrary positive loss.
[Balanced branch estimates](../Legendre/Layer4/BalancedAlternatives.lean)
[Cumulative density](../Legendre/Layer4/InghamDensity.lean)

## Cumulative density

Write `E(σ) = 3(1−σ)/(2−σ)`. The cumulative count
`N(σ,T) ≤ C T^E(σ) (log T)^7` holds for all `T≥2` and
`σ∈[1/2,1]), with one absolute constant and analytic multiplicities.
For each fixed `τ<1`, the bound on `[1/2,τ]` uses six logarithms and a
constant depending only on `τ`.
[Statements and proofs](../Legendre/Layer4/InghamMultiplicity.lean)
[Literal comparator](../Legendre/Literature/LayerCoverage.lean)

Unit separation bounds the sample count by a constant times the height
in the near-critical band `σ−1/2≤1/log T`. In that band the height
is at most a constant times `T^E(σ)`, so the five-log shell estimate
extends to the closed real-part range. Accumulating the shells costs one
logarithm, and restoring analytic multiplicities costs one more.
On a fixed strip `[1/2,τ]` the height exponent is at least
`2(1−τ)>0`, so the dyadic powers sum geometrically and eliminate
the height-summation logarithm. The bounded-height cases are included
using the finite count up to height 128.
[Near-critical band](../Legendre/Layer4/NearCriticalDensity.lean)
[Geometric sum](../Legendre/Layer4/GeometricHeightDensity.lean)

## Fifth-log bound on fixed strips

For every fixed `τ<1`, one constant `Cτ` satisfies
`N(σ,T) ≤ Cτ T^E(σ) (log T)^5` on the closed strip `[1/2,τ]`
for every `T≥2`, counting analytic multiplicities. The full closed interval
through `σ=1` has the uniform seven-log bound above.
[Fixed-strip theorem](../Legendre/Layer4/InghamSharpLogarithms.lean)
[Literal comparator](../Legendre/Literature/LayerCoverage.lean)

The polynomial count keeps the per-block endpoint powers
`U^(2−2σ)` and `T U^(1−2σ)` before summing. Weighted Cauchy–Schwarz with
weights `U^(1−σ)+√T U^(1/2−σ)` keeps the increasing part geometric on
every fixed strip below one. After including the integral branch and
summing heights, the separated count is bounded by a constant times
`T^E(σ) (log T)^4 + T^(2−2σ) (log T)^5`. Multiplicity restoration costs
one logarithm.
[Polynomial estimate](../Legendre/Layer4/PolynomialAlternativeSplit.lean)

If `T^(1−E(σ)) ≤ (log T)^4`, the total-zero bound `O(T log T)`
already gives the fifth-log estimate. Otherwise the identity
`E(σ)−(2−2σ)=(1−σ)(1−E(σ))` absorbs the final logarithm for
`σ≤3/4`. Above `3/4) on a fixed strip it gives a positive lower bound
depending only on `τ` for the exponent difference, which also absorbs
the final logarithm. Low heights are covered by the finite count at 128.
