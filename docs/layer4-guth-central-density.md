# Guth–Maynard zero density in Lean

For every `ε > 0` there is a constant `C > 0` such that, for all
`σ ∈ [1/2,1]` and `T ≥ 2`,

```text
N(σ,T) ≤ C T^(15(1−σ)/(3+5σ)+ε).
```

The repository counts analytic multiplicities. One constant covers the whole
real-part range and all heights, including the finite initial range. The
central theorem covers `[7/10,4/5]`. At `σ = 3/4` it gives `5/9+ε`.
The preexisting Ingham and Huxley bounds cover the two outer intervals.
The full proof closes the independently stated `GuthMaynard2024Density`
comparator. Its combination with Ingham proves `HasZeroDensityEstimate (30/13)`.
[Density proof](../Legendre/Layer4/GuthMaynard/CentralDensity.lean)

The central proof uses the project's compact zero detector in the positive
height shell `[T/2,T]`, with `X = ⌈T^(1/200)⌉` and detector scale `√T`.
For the polynomial branch, dyadic decomposition gives a large finite block.
The divisor bound normalizes its actual coefficients. Rational localization
and Phragmén–Lindelöf move a sample to the fixed vertical line with at most
`T^γ` displacement for any fixed positive `γ ≤ 1`. The proof explicitly
extracts separated representatives from the displaced samples and incurs a
cardinality loss of at most `12 T^γ`.

Section 13 selects a power `2 ≤ k ≤ 201` and a powered length
`Q ∈ [T^(10/(6+10σ)), T^(15/(6+10σ))]`. The lower bound
`N ≥ T^(1/200)` accounts for the increase from the source's power cap of
101. The finite proof expands the actual convolution and picks one
dyadic block on a common subset of ordinates. It uses Guth–Maynard
Theorem 1.1 for smaller `Q` and Montgomery's mean square for larger `Q`.
The cutoff and normalization losses are carried through the count and
absorbed into the final `T^ε`.
[Finite powering and count](../Legendre/Layer4/GuthMaynard/Section13Powering.lean)

For the complementary integral branch, the existing critical-line moment
bound applies with a uniform gap of at least `1/5` from the critical line.
Its exponent including the small cutoff is `2−2σ+4/200+ε`, which lies
below the target throughout the central range. The dyadic height cover and
the existing weighted sampling lemma restore the count of all zeros and their
multiplicities. The sharp `T log^4 T` fourth moment and the historical
prime-gap transmission remain separate goals.
[Actual shell proof](../Legendre/Layer4/GuthMaynard/CentralShell.lean)

Selected Section 13 and localization lemmas are adapted from the pinned
MIT-0 **smccolm/Lean** source and compiled from source under Lean 4.35.0.
The fixed cutoff, shared integral detector estimates, displaced-sample
selection and final assembly use the project's local proofs.
[Exact sources and adaptations](smccolm-guth-provenance.md)

The local full build completed 4,375 jobs. All 8,487 theorem declarations
match module data, environment ownership, audit targets and actual axiom
output. The only axioms used are `propext`, `Classical.choice` and
`Quot.sound`. Across 362 classified Lean files the placeholder scan is
clean. The 220 independent consumers include the literal closed endpoint
of Theorem 1.1 and the exponent `5/9+ε` of Theorem 1.2.
