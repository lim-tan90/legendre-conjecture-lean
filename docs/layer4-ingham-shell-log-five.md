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
