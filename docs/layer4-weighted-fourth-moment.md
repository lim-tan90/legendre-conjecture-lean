# Sharp weighted fourth moment and zero detection

The symmetric zeta fourth moment can be summed over dyadic height balls
with the existing cubic weight. This gives integrability on the real
line and the bound
`∫ momentHeightWeight(T,v) |ζ(1/2+iv)|⁴ dv ≤ C T (log T)^4`
for every `T≥2`. The separated kernel-packing estimate preserves the
same fourth logarithm when summing the individual detector integrals.
[Weighted moment](../Legendre/Layer4/WeightedZetaMoment.lean)
[Packing](../Legendre/Layer4/PackedZetaMoment.lean)

Write `E(σ)=3(1−σ)/(2−σ)`. At the balanced cutoff
`Y=T^(3/(2(2−σ)))`, the actual compensated integral branch satisfies
`R ≤ C T^E(σ) (σ−1/2)^(−4/3) (log T)^2` for
`1/2<σ≤1`. The sample condition is unit separation, and all samples
pass the literal threshold `1/16`. The cutoff is an integer with
`T≤X≤2T`. This follows by taking the cube root of the count bound with
a fourth-log zeta moment and two logarithms from the mollifier. When
`σ−1/2≥1/log T`, the gap contributes at most `(log T)^(4/3)`,
so the resulting log power is `10/3`.
[Integral count](../Legendre/Layer4/IntegralAlternative.lean)
[Balanced count](../Legendre/Layer4/BalancedAlternatives.lean)
[Independent comparators](../Legendre/Literature/LayerCoverage.lean)

## Cumulative density on inner strips

For each fixed pair `1/2<α≤τ<1`, one constant depending on the endpoints
satisfies
`N(σ,T) ≤ C_{α,τ} T^E(σ) (log T)^4` for all
`σ∈[α,τ]` and `T≥2), with analytic multiplicities. The exponent gap
`E(σ)−(2−2σ)` is bounded below by `(1−τ)(α−1/2)>0).
It absorbs the extra two logarithms in the shorter polynomial term.
The integral branch costs at most two logarithms on this strip, so the
merged shell count costs three. Geometric height summation preserves
that power. Restoring analytic multiplicities costs the fourth logarithm.
[Inner-strip proof](../Legendre/Layer4/InghamMiddleStrip.lean)

The code reuses the credited [openai/math adaptations](../README.md#3-openaimath)
for weighted moments, kernel packing and the compact integral branch.
The updated moment input and the deductions for inner strips are local.
