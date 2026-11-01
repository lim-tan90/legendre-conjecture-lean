# Quantitative good heights and horizontal Perron bounds

The six modules `ZetaUnitCounting.lean`, `FiniteHeightAvoidance.lean`,
`ZetaGoodHeight.lean`, `ZetaLogDerivativeSeparated.lean`,
`ZetaGoodHeightBounds.lean`, and `PerronGoodHeight.lean` extend the Layer 3
contour estimates with original local proofs. They reuse existing mathlib and
project interfaces; no additional external code or dependency is introduced.
All theorem names below are in `Legendre.Zeta`.

## Unit-height zero counts

`unitZeroCount H` sums analytic multiplicities over the closed cell
`{ρ : NontrivialZero ρ ∧ H ≤ Im ρ ∧ Im ρ ≤ H+1}`. For H≥4:

`N(H+1)−N(H) ≤ unitZeroCount H ≤ 2 log(40(H+3))/log(14/13)`.

The subtraction on the left is natural-number subtraction. Closed endpoints
may add zeros to the cell but do not weaken this upper bound. Reflection
preserves multiplicities and injects the whole cell into two signed Jensen
disks; zeros left of the critical line are included. The main interfaces are
`zeroCount_increment_le_unitZeroCount` and `unitZeroCount_le_log`.

## Quantitative avoidance

`exists_height_avoiding_finset` proves that for any finite set S of n real
ordinates, some T∈(H,H+1) has distance at least `1/(4(n+1))` from every element
of S. The proof bounds the Lebesgue measure of the union of the forbidden
intervals by a quantity strictly less than one.

Three unit-height cells contain every zero ordinate within distance one of
(H,H+1). Their number of distinct ordinates is bounded by their total
multiplicity. Consequently `exists_good_height_quantitative`, for H≥5,
provides T∈(H,H+1) such that every nontrivial zero ρ satisfies

`|T−|Im ρ|| ≥ 1/[4(6 log(40(H+4))/log(14/13)+1)]`.

Set

`A = 1+log(80)/log(2)`,

`c = 1/[4(6A/log(14/13)+1/log(2))] > 0`.

`exists_good_height_log_separation` strengthens the displayed interpretation:
for H≥7 the same separation is at least `c/log H`. This handles both signs of
height without assuming simple zeros or the Riemann hypothesis.

## Logarithmic derivative and Perron integrals

Set `d=log(6/5)` and `K=1+log(5)/d`. The explicit positive constant
`goodHeightLogDerivativeConstant` is

`C = 608 K A + A/(d c) + 6`.

For every H≥7, `exists_good_height_logDeriv_bound` provides a single
T∈(H,H+1) such that for **both** t=T and t=−T and **every** u≥7/8:

`ζ(u+it) ≠ 0`,

`|ζ′/ζ(u+it)| ≤ C (log H)²`.

The proof bounds the logarithmic derivative of the regularized local zeta
function by `608 localZetaLogBound t`. The finite principal parts contribute
at most the local multiplicity divided by `c/log H`. The local Cauchy estimate
reaches distance 9/8 from 2+it; u≥2 is covered by the existing absolutely
convergent Dirichlet-series bound.

`exists_good_height_perron_horizontal_bound` supplies a common T working
uniformly for all x>0 and 7/8≤α≤σ. Each horizontal kernel is proved interval
integrable, and the normalized integral satisfies

`|HIntegral′ Kₓ α σ (±T)| ≤ [C(log H)²(σ−α)/(2πT)] max(x^α,x^σ)`,

where `Kₓ(s)=−(ζ′/ζ)(s)x^s/s` and the prime includes the normalization 1/(2πi).
The selection of T precedes x, α and σ.

`exists_truncated_explicit_formula_good_height` uses these quantitatively
separated heights for the full finite multiplicity-weighted explicit formula.
Its remainder still retains the original contour-dependent constant M.

## Remaining limits

The horizontal estimate covers **Re(s)≥7/8**. The full zero-sum rectangle has
an existential left cutoff a∈(0,1), chosen strictly to the left of all included
zeros; it need not satisfy a≥7/8. Therefore the new estimate does not control
its entire horizontal sides or its left vertical side. It does not justify
replacing the full-boundary M by C(log H)² in the existing remainder theorem.
A classical uniform truncation error and shifting through zero or the trivial
zeros remain further work. See [the exact formula](perron-explicit-formula.md).

## Validation

On 2026-11-01, full `lake build` passed 4,036 jobs, followed by
`python3 scripts/audit.py --skip-build` passing all 1,970 expected targets.
All 52 theorem declarations from these six modules, including generated
helpers, are audited. The only axioms are `propext`, `Classical.choice` and
`Quot.sound`; source-token and no-PDF checks passed. Dependency pins and the
lockfile are unchanged.
