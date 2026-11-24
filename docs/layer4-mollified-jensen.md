# Local zero multiplicities from a mollified circle mean

Let `M_X` be the finite Möbius Dirichlet series through the integer
`X≥1`. Write `E_X(s)=ζ(s)M_X(s)−1`. For an outer closed disk with
center `c` and radius `R` excluding the pole `1`, let `0<r<R` and
let `S` be any finite set in the closed inner disk of radius `r`.
If `|E_X(c)|≤1/2`, the total zeta multiplicity in `S` satisfies

```
∑_{ρ∈S} mζ(ρ) ≤ (circleAverage(|E_X|²,c,R) + log 2) / log(R/r).
```

The local comparator also supplies an explicit sufficient condition:
for `δ>0` and `Re c≥1+2δ`, the center bound follows from
`X^δ≥2(2+δ⁻¹)^2`. Every `X≥1` also works at `Re c≥4).
[Detector and center bounds](../Legendre/Layer4/MollifiedZetaJensen.lean)
[Literal comparator](../Legendre/Literature/LayerCoverage.lean)

The auxiliary function `1−E_X²=(ζM_X)(2−ζM_X)` is analytic away from
the pole and contains all zeta zero orders. On the outer circle its log
norm is at most `|E_X|²`. The center estimate bounds the negative log
norm at the center by `log 2`. Jensen's formula with the actual circle
mean then gives the claimed radius factor. To bound the center close to
one, Möbius cancellation removes all terms through `X`. An absolutely
convergent divisor series controls the remaining tail.
[Jensen divisor comparison](../Legendre/Layer4/JensenCircleMean.lean)

The divisor comparison adapts the pinned Apache-2.0 mathlib Jensen
proof. The squared-error factorization and vanishing order adapt the
pinned MIT-0 **smccolm/Lean** `GuthMaynard/ClassicalDensity.lean` proof.
Both sources and their Lean 4.35.0 destinations are recorded in the
[README provenance](../README.md#reused-and-adapted-formalizations).
