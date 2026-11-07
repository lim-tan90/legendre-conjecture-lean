# Uniform finite explicit formula: full contour

`import Legendre.Layer3` exports
`Legendre.Zeta.exists_full_truncated_explicit_formula` from
[`PerronFullExplicit.lean`](../Legendre/PerronFullExplicit.lean).
This completes the previously open left-contour refinement of Layer 3.

## Exact statement and quantifiers

There is **one absolute C>0** such that for every H≥7 there is a
T∈(H,H+1) such that, for **every σ>1 and every x>0**, some E∈ℂ satisfies

```text
ψ₀(x) = x − Σ_{ρ∈Z(T)} m(ρ) x^ρ/ρ − log(2π) + E,

|E| ≤ U(x,σ)/T + C log²(H+6) ·
        [x^(−1/8) + (σ+1/8) max(x^(−1/8),x^σ)/T].
```

Here Z(T) is the finite set of **all** zeros with 0<Re(ρ)<1 and
|Im(ρ)|≤T, and m(ρ) is the analytic multiplicity. No simple-zero or
Riemann-hypothesis assumption is made. The summatory function ψ₀ has
half-weight at an integer endpoint. `U(x,σ)=perronErrorUpper x σ` is the
existing finite coefficient sum plus closed Dirichlet-tail majorant from
`PerronError.lean`; it is independent of T.

The order is C, H, T, σ, x, E. In particular, the same selected T works at
multiple x, including x=1 and 0<x<1, and at multiple right endpoints σ.
The left edge is **fixed at −1/8**. All three retained contour pieces have
proved bounds with a height-independent coefficient. This replaces the
old existential positive cutoff a and contour-dependent maximum M in the
stronger interface. The original interface remains available.

## Proof chain

| Module | Verified step |
|---|---|
| [`ZetaEulerPrimitive`](../Legendre/ZetaEulerPrimitive.lean) | Continuous periodic primitive (fract²−fract)/2, including right derivatives at integers |
| [`ZetaSecondMellin`](../Legendre/ZetaSecondMellin.lean) | Second Euler remainder R₂, absolutely convergent and analytic on Re(s)>−1 |
| [`ZetaSecondEuler`](../Legendre/ZetaSecondEuler.lean) | Integration by parts and analytic continuation: ζ(s)=1/(s−1)+1/2−s(s+1)R₂(s) |
| [`ZetaNegativeStrip`](../Legendre/ZetaNegativeStrip.lean) | No zeros for −1<Re(s)≤0, via the functional equation and ζ(0)=−1/2 |
| [`ZetaWideLocalBound`](../Legendre/ZetaWideLocalBound.lean) | Polynomial ζ bound and Jensen count on radius-5/2 disks around 2+it |
| [`ZetaWideZeroRemoval`](../Legendre/ZetaWideZeroRemoval.lean) | Remove the finite divisor on radius 9/4, retaining analytic multiplicities |
| [`ZetaWideRegularizedBound`](../Legendre/ZetaWideRegularizedBound.lean) | Analytic logarithm and Cauchy derivative estimate reaching radius 17/8 |
| [`ZetaWideSeparated`](../Legendre/ZetaWideSeparated.lean) | Logarithmic derivative bounded by regularized part plus degree/separation |
| [`ZetaFullGoodHeightBounds`](../Legendre/ZetaFullGoodHeightBounds.lean) | Both ±T have explicit Cₕ log²H bounds for every Re(s)≥−1/8 |
| [`ZetaPerronLeft`](../Legendre/ZetaPerronLeft.lean) | On Re(s)=−1/8, one absolute Cₗ bounds ‖ζ′/ζ‖ by Cₗ log(abs(t)+5) for all real t |
| [`PerronOriginResidue`](../Legendre/PerronOriginResidue.lean) | Meromorphic kernel across zero, at most simple poles, origin residue −ζ′(0)/ζ(0) |
| [`ZetaOriginValue`](../Legendre/ZetaOriginValue.lean) | Differentiate the functional equation twice: ζ′(0)=−log(2π)/2 and ζ′(0)/ζ(0)=log(2π) |
| [`PerronFullRectangle`](../Legendre/PerronFullRectangle.lean) | Rectangle residue identity with candidates {0,1}∪Z(T); removable candidates contribute zero |
| [`PerronUniformBounds`](../Legendre/PerronUniformBounds.lean) | Genuine side integrability and uniform bounds on the left and both horizontal sides |
| [`PerronFullExplicit`](../Legendre/PerronFullExplicit.lean) | Combine residues, side bounds and Perron inversion/error with the displayed quantifier order |

For the full good-height logarithmic derivative bound, the explicit constant is

```text
A = 2 + log(32)/log(2), d = log(10/9), K = 1 + log(9)/d,
Cₕ = 1120 K A + A/(d c) + 6,
```

where c=`goodHeightSeparationConstant` is the already proved positive
height-separation constant. The fixed left line is separated from each
critical-strip zero by at least 1/8. Large |t| uses the wide-disk estimate;
the remaining compact interval gives a single finite Cₗ, independent of
H,T,x,σ. The final theorem uses `C=9Cₗ/π+Cₕ/π+1`.

The normalized left integral is bounded by
`(9Cₗ/π) x^(−1/8) log²(T+5)`. This uses
`1+|t|≤9|−1/8+it|` and the proved identity
`∫_{−T}^T dt/(1+|t|)=2 log(1+T)`.
Each horizontal integral is at most
`Cₕ log²H (σ+1/8) max(x^(−1/8),x^σ)/(2πT)`.

## Validation and provenance (2026-11-07)

Verified proof commit: [`5c4be2780255`](https://github.com/lim-tan90/legendre-conjecture-lean/commit/5c4be2780255ef78fd03bff6976596287d007c06).

The full build passed **4,054 jobs**. A complete Lean-environment enumeration
found **2,756 project theorem declarations**, including private/generated
helpers. Exactly these 2,756 distinct declarations are listed in the audit;
the parsed axiom output matches the enumeration, and only `propext`,
`Classical.choice`, and `Quot.sound` occur. The 204 declarations added since
the preceding verification pass are all covered.

The nine consumer checks in [`Tests/Layer3.lean`](../Legendre/Tests/Layer3.lean)
use an ordinary `import Legendre.Layer3`. They are compiled and also checked
as standalone source. The four new cases check a common C and T at x=1 and
x=1/2, the evaluated origin residue, integrability for x<1, and both negative
horizontal endpoints. All test declarations are audited.

All **85 project Lean files**, including Layer 0–3 and the adapted PNT+
slice, have zero executable `sorry`, `admit`, or `sorryAx`. The general
forbidden-source scan and no-PDF check also pass. No dependency pin,
lockfile, or upstream port was added. These fifteen modules are local proofs
using mathlib and the previously attributed project/PNT+ infrastructure;
[upstream attribution](pnt-provenance.md) is unchanged. Upstream communication
remains assigned separately by the repository owner.

## Precise limits

The displayed U is the proved Perron majorant, rather than an additional
unproved simplification to a sharp textbook `x log²(xT)/T` expression.
The absolute contour coefficient is existential because of the fixed
low-height compact estimate; no numerical Dusart constant is asserted.
The rectangle crosses the origin but no trivial zero (the first is at −2).
There is no infinite explicit-formula claim obtained by shifting the line
to −∞. Layer 4 zero density, fixed polynomial short-interval exponents,
and Legendre's conjecture remain separate tasks.
