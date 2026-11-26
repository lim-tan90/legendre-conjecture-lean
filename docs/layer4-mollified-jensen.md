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
`X^δ≥2(2+δ⁻¹)^2`. Every `X≥1` also works at `Re c≥4`.
[Detector and center bounds](../Legendre/Layer4/MollifiedZetaJensen.lean)
[Literal comparator](../Legendre/Literature/LayerCoverage.lean)

The auxiliary function `1−E_X²=(ζM_X)(2−ζM_X)` is analytic away from
the pole and contains all zeta zero orders. On the outer circle its log
norm is at most `|E_X|²`. The negative log norm at the center is at most
`(4/3)|E_X(c)|²`, which implies the displayed `log 2` bound. Jensen's formula with the actual circle
mean then gives the claimed radius factor. To bound the center close to
one, Möbius cancellation removes all terms through `X`. An absolutely
convergent divisor series controls the remaining tail.
[Jensen divisor comparison](../Legendre/Layer4/JensenCircleMean.lean)

The divisor comparison adapts the pinned Apache-2.0 mathlib Jensen
proof. The squared-error factorization and vanishing order adapt the
pinned MIT-0 **smccolm/Lean** `GuthMaynard/ClassicalDensity.lean` proof.
Both sources and their Lean 4.35.0 destinations are recorded in the
[README provenance](../README.md#reused-and-adapted-formalizations).


## Height-integrated density near one

For `δ>0`, `6δ<U≤V`, and `X^δ≥2(2+δ⁻¹)²`, put
`D=X^(−δ)(2+δ⁻¹)²`. Suppose `M` bounds the vertical integral of
`|E_X(a+it)|²` over `[U−6δ,V+6δ]` for every
`a∈[1−3δ,1+7δ]`. Then

```
N(1−δ,V) − N(1−δ,U)
  ≤ (M + (4/3)(V−U+2δ)D²) / (2δ log(5/4)).
```

The disks have real center `1+2δ` and radii `4δ` and `5δ`.
Each zero in the increment contributes its full multiplicity over a
height interval of length `2δ`. Fubini and translation bound the integral
of the outer-circle means by `M`. This step requires a bound on the
vertical second moment as an input. [Implementation](../Legendre/Layer4/MollifiedZetaVertical.lean)
[Literal comparator](../Legendre/Literature/LayerCoverage.lean)


## Finite-energy second moment

Let `0<α≤β`, `0<A≤B`, and let the integer lengths satisfy `1≤X≤N`.
Subtracting the tail polynomial `∑_{X<n≤XN} c_n n^(−s)` from
`E_X` leaves the product of `M_X` and the ζ truncation error. Here
`c_n=∑_{dm=n, d≤X, m≤N} μ(d)`. The uniform vertical moment bound
`mollifiedVerticalBound X N α β A B` is

```
2(B−A+2πXN) ∑_{X<n≤XN} |c_n|² n^(−2α) + 2(B−A)K²

K = (∑_{n≤X} n^(−α)) · [(1/2+(β+B)/(2α))N^(−α)+N^(1−α)/A].
```

The two summands in the brackets bound the Euler remainder and the pole
term, respectively. The bound applies to the vertical integral on every
line with real part in `[α,β]`. For a separate center offset `η>0`,
the proof takes the real center `1+2η`, the radii `δ+3η, δ+4η`, and
the integration strip `α=1−δ−2η, β=1+δ+6η`. With
`δ>0`, `δ+2η<1`, `δ+5η<U≤V`, and `X^η≥2(2+η⁻¹)²`,
the density increment is bounded by the same formula as above with
`M=mollifiedVerticalBound X N α β (U−δ−5η) (V+δ+5η)`, scale
`D=X^(−η)(2+η⁻¹)²`, window length `2η`, and radius factor
`log((δ+4η)/(δ+3η))`. The truncation lengths are explicit parameters.
[Mean-square bound and density theorem](../Legendre/Layer4/MollifiedZetaMeanSquare.lean)


## Weighted dyadic second moment

For `N≤2^J`, partition the finite tail into blocks
`(Q_j,2Q_j]` with `Q_j=2^j X` and `0≤j<J`. With `L=B−A`, the
bound for a block is

```
D_j = (L+4πQ_j) · 2Q_j(1+log(2Q_j))³ Q_j^(−2α).
```

For any positive weights `w_j`, the full vertical moment is at most
`M=2(∑ w_j)(∑ D_j/w_j)+2LK²`, with `K` as above. The square-root
choice `w_j=√D_j` gives `M=2(∑ √D_j)²+2LK²`. The density theorem
uses the same radius factor and bounds the center contribution by
`(4/3)min(M,(V−U+2η)D²)`. Thus the pointwise center estimate is
used to justify Jensen, and the center integral can also be
controlled by the second moment. The height exponent after
choosing the truncations and offsets remains to be optimized.
[Dyadic mean and density theorem](../Legendre/Layer4/MollifiedZetaDyadic.lean)
