# Layer 2 provenance and limits

Validated against Lean `v4.35.0` and mathlib `v4.35.0`, commit
[`56a005855ea17e0b0958f73ec801ae140b0a1679`](https://github.com/leanprover-community/mathlib4/tree/56a005855ea17e0b0958f73ec801ae140b0a1679),
under Apache-2.0. The latest stable Lean and mathlib releases were rechecked as `v4.35.0`
on 2026-10-30. No dependency pins or lockfiles were changed.

These are direct imports and hypothesis-preserving namespace interfaces,
not copied analytic proofs. Module imports explicitly expose the required
complex p-series API under Lean 4.35's module system.

| Local interface in `Legendre.Zeta` | Upstream declaration | Upstream module / authors |
|---|---|---|
| `series_norm_summable` | `Complex.summable_one_div_nat_cpow`, `Summable.norm` | `Analysis/PSeriesComplex.lean`, David Loeffler |
| `eq_series` | `zeta_eq_tsum_one_div_nat_add_one_cpow` | `NumberTheory/LSeries/RiemannZeta.lean`, David Loeffler |
| `euler_product` | `riemannZeta_eulerProduct_hasProd` | `NumberTheory/EulerProduct/DirichletLSeries.lean`, Michael Stoll |
| `euler_product_limit` | `riemannZeta_eulerProduct` | same |
| `analytic_off_pole` | `analyticOn_riemannZeta` | `NumberTheory/LSeries/RiemannZeta.lean`, David Loeffler |
| `completed_functional_equation` | `completedRiemannZeta_one_sub` | same |
| `nonvanishing` | `riemannZeta_ne_zero_of_one_le_re` | `NumberTheory/LSeries/Nonvanishing.lean`, Michael Stoll and David Loeffler |
| `finite_zeros_on_compact` | `IsCompact.inter_riemannZetaZeros_finite` | `NumberTheory/LSeries/ZetaZeros.lean`, Huanyu Zheng |

`exists_zero_free_band` and `exists_zero_free_strip` are new deductions here.
The segment `{Re(s)=1, |Im(s)|≤T}` is compact and disjoint from the closed
zero set; an open neighborhood of a compact set contains a positive-radius
metric thickening. Horizontal projection onto the segment turns that
neighborhood into a uniform band. The known nonvanishing right half-plane
then extends this to a left-hand strip. This is qualitative compactness,
not a transplantation of a quantitative analytic zero-free-region proof.

The intermediate band includes mathlib's nonzero junk value at the pole.
The analytic interface and final strip explicitly exclude `s=1`.
The foundational compact-finiteness lemma counts distinct zeros; the new
counting module below uses finite analytic multiplicities. There is no claim of an effective `c/log T` width,
a Perron formula, PNT, or any of the nine deep short-interval results.

Validate with `lake build` and `python3 scripts/audit.py`.
All local theorems have entries in `Legendre/Audit.lean` and
`docs/proof-map.md`.

## Multiplicity-weighted counting

`Legendre/ZetaCounting.lean` is a new construction using the same fixed
mathlib version. Analytic orders are imported from `Analysis/Analytic/Order.lean`
(Apache-2.0, Vincent Beffara and Stefan Kebekus). The proof of finite order
uses `AnalyticOnNhd.analyticOrderAt_ne_top_of_isPreconnected` on the connected
punctured plane and the known nonzero value at 2. `Nat.cast_analyticOrderNatAt`
then proves that `zeroMultiplicity` recovers the ENat-valued analytic order
without dropping an infinite order. `ENat.toNat_pos` yields positive multiplicity
at every critical-strip zero. No simplicity of zeta zeros is assumed.

`NontrivialZero` means a zero with `0 < Re(s) < 1`; this definition is not a
classification theorem for the entire zero set. `zerosUpTo T` further requires
`0 < Im(s) ≤ T`; `zerosRightOf σ T` includes the boundary `σ ≤ Re(s)`.
Both are finite subsets of zeros in the compact rectangle `[0,1] × [0,T]`.
`zeroCount` and `zeroDensityCount` sum analytic multiplicities over these sets.
Proofs show monotonicity in height, antitonicity in σ, domination by `zeroCount`,
positive-count/existence equivalences, `N(T)=0` for `T≤0`, `N(σ,T)=0` for
`σ≥1`, and `N(σ,T)=N(T)` for `σ≤0`.

These definitions and proofs are original to this repository, built from
upstream analytic-order, zero-set and finite-sum APIs. No external quantitative
zero-counting or density theorem has been transplanted or asserted.

## Logarithmic derivative and counting bridge

`Legendre/ZetaLogDerivative.lean` uses the same fixed mathlib commit:

| Local theorem / input | Upstream declaration | Source and authors |
|---|---|---|
| `vonMangoldt_series_summable` | `ArithmeticFunction.LSeriesSummable_vonMangoldt` | `NumberTheory/LSeries/Dirichlet.lean`, Michael Stoll |
| `neg_logDeriv_eq_vonMangoldt_series` | `ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div` | same |
| Half-plane norm comparison | `LSeries.norm_term_le_of_re_le_re`, summable-series norm and order APIs | `NumberTheory/LSeries/Basic.lean`, Aaron Anderson and Michael Stoll |
| Coefficient estimate | `ArithmeticFunction.vonMangoldt_le_log`, `Real.log_le_sub_one_of_pos` | von Mangoldt and real logarithm APIs |
| Basel sum | `hasSum_zeta_two` | `NumberTheory/ZetaValues.lean`, David Loeffler |

Only the first two local theorems are interfaces to the existing analytic
von Mangoldt identity. The remaining six are deductions here. In particular,
`norm_logDeriv_le_pi_sq_div_six` bounds each norm by `1/n²`: for a positive
integer n, `Λ(n) ≤ log n ≤ n`, while `Re(s)≥3` gives denominator at least
`n³`; the zero-index term is handled separately. Summability justifies
both the norm-of-sum comparison and the sum of termwise bounds.

`zeroDensityCount_eq_zero_of_zero_free` uses positive multiplicities to
exclude a positive count when every candidate point is nonzero.
`exists_zero_density_cutoff` selects `σ = 1 - min(width,1)/2`, so `0<σ<1`
and the closed cutoff lies strictly inside the previously proved open
zero-free strip. The width remains non-effective. This is not a quantitative
zero-density estimate, and the explicit logarithmic-derivative bound is only
for `Re(s)≥3`; neither result supplies the missing near-line estimates or Perron.

## Explicit ε-bound on right half-planes

`Legendre/ZetaHalfPlane.lean` contains six new deductions using the same
pinned mathlib version, without transplanting a separate external proof.
Its upstream ingredients are:

| Input | Upstream declaration | Source / authors |
|---|---|---|
| Integral test for the tail from n=2 | `AntitoneOn.tsum_comp_add_le_integral` | `Analysis/SumIntegralComparisons.lean`, Kevin H. Wilson and Alastair Irving |
| Improper power integral and integrability | `integral_Ioi_rpow_of_lt`, `integrableOn_Ioi_rpow_of_lt` | `Analysis/SpecialFunctions/ImproperIntegrals.lean`, David Loeffler |
| Logarithm/power comparison | `Real.log_natCast_le_rpow_div` | `Analysis/SpecialFunctions/Pow/Real.lean` |
| Power-series convergence | `Real.summable_nat_rpow` | `Analysis/PSeries.lean` |
| Von Mangoldt series majorant | `Legendre.Zeta.norm_logDeriv_le_majorant` | previous local milestone, based on mathlib's convergent von Mangoldt identity |

For p>1, the decreasing function x^(-p) has integral 1/(p-1) on (1,∞).
The tail n≥2 is bounded by this integral; the terms n=0,1 contribute 0,1,
respectively. This proves `tsum_nat_rpow_neg_le` including the endpoint terms.
For a>0, `Λ(n)≤log n≤n^a/a` bounds the term at real part 1+2a by
`a⁻¹ n^(-(1+a))`. Both series are proved summable before their sums are
compared. Hence the majorant is at most `a⁻¹(1+a⁻¹)`.
Setting a=ε/2 yields `(2/ε)(1+2/ε)` for `Re(s)≥1+ε`, independently of Im(s).
For `0<ε≤1`, elementary ordered-field algebra gives `6/ε²`.
The pointwise interface substitutes ε=Re(s)-1.

No bound is asserted at Re(s)=1 or to its left. This is not a sharp pole
asymptotic, a logarithmic zero-free region, a zero-counting asymptotic, or Perron.

## Pole removal and logarithmic-derivative principal part

`Legendre/ZetaPole.lean` uses the same pinned mathlib version. The updated
product construction and its continuity argument follow the local auxiliary
G in `NumberTheory/LSeries/Nonvanishing.lean` (Michael Stoll and David Loeffler,
Apache-2.0). The new public interface then proves its analyticity and derives
the logarithmic-derivative principal part and local bounds.

| Input | Upstream declaration | Source / authors |
|---|---|---|
| Zeta residue at 1 | `riemannZeta_residue_one` | `NumberTheory/LSeries/RiemannZeta.lean`, David Loeffler |
| Continuity after replacing a single value | `continuousAt_update_same` | mathlib function-update continuity API |
| Removable singularity | `Complex.analyticAt_of_differentiable_on_punctured_nhds_of_continuousAt` | `Analysis/Complex/RemovableSingularity.lean`, Yury Kudryashov |
| Analytic derivatives and quotients | `AnalyticAt.deriv`, `AnalyticAt.div` | mathlib analytic-calculus API |
| Logarithmic product rule and local congruence | `logDeriv_fun_mul`, `logDeriv_congr_nhds` | `Analysis/Calculus/LogDeriv.lean`, Chris Birkbeck |

Lean 4.35's module system requires an explicit import of the removable-singularity
module; the private imports used in upstream auxiliary proofs are not treated
as exported interfaces. The point update is essential: at 1 the raw product
is 0, whereas the inserted value H(1) is 1. The residue theorem proves the
continuity needed for removal; analytic calculus and H(1)≠0 then make `logDeriv H`
analytic there. Local equality away from the update transfers the product rule:
`ζ′/ζ(s)+1/(s-1)=logDeriv H(s)`, eventually off 1.

The right side has a finite limit. Multiplication by (s-1) proves the coefficient
-1 for `ζ′/ζ`, and negation proves +1 for the Perron convention `-ζ′/ζ`.
Continuity supplies a bound on the regular part; the triangle inequality gives
`|ζ′/ζ(s)|≤1/|s-1|+C` locally. These deductions do not evaluate the finite
regular-part constant or provide an effective C or neighborhood radius.
There is no assertion at the pole for ζ itself and no Perron contour identity.

## Forward Abel integral and weighted pole coefficient

`Legendre/PerronFoundation.lean` uses the same pinned mathlib commit.
It supplies project-local identifications and growth/integrability proofs
before specializing the upstream analytic representation.

| Input | Upstream declaration | Source / authors |
|---|---|---|
| Forward Abel representation | `LSeries_eq_mul_integral_of_nonneg` | `NumberTheory/LSeries/SumCoeff.lean`, Xavier Roblot |
| Abel summation / integral foundation | upstream Abel summation development | `NumberTheory/AbelSummation.lean`, Xavier Roblot |
| Linear Chebyshev bound | `Chebyshev.psi_le_const_mul_self` | `NumberTheory/Chebyshev.lean`, Alastair Irving, Terry Tao, Ruben Van de Velde |
| ψ measurability | `Chebyshev.psi_mono` and monotone-function measurability | Chebyshev and measure-theory APIs |
| Majorant integrability | `integrableOn_Ioi_rpow_of_lt` | `Analysis/SpecialFunctions/ImproperIntegrals.lean`, David Loeffler |
| Complex power continuity | `Complex.continuousAt_const_cpow`, `continuousAt_ofReal_cpow_const` | `Analysis/SpecialFunctions/Pow/Continuity.lean`, Chris Hughes and coauthors |

The equality of `Icc 1 floor(t)` partial sums and ψ's `Ioc 0 floor(t)`
convention is proved explicitly, in both real and complex coefficient types.
The bound ψ(n)≤(log 4+4)n supplies the O(n) hypothesis required by the
upstream Abel theorem; no PNT is assumed. The integral is separately proved
Bochner integrable on (1,∞) for Re(s)>1, by measurability and domination by
`(log 4+4)t^(-Re(s))`. This prevents a divergent integral's default value
from being mistaken for an integral representation.

For x>0, x^s/s is continuous at 1 with value x. Combining this with the
previously proved `(s-1)(-ζ′/ζ(s))→1` yields the local weighted coefficient x.
No contour-integral residue theorem or inverse Mellin theorem is invoked.
There is no Perron inversion, truncation bound, or consequent PNT claim.

## Local Perron circle integral

`Legendre/PerronContour.lean` contains original deductions using the same
pinned mathlib commit; no proof was copied from an external project.

| Input | Upstream declaration | Source / authors |
|---|---|---|
| Analytic exponential and complex power identity | `AnalyticAt.cexp`, `Complex.cpow_def_of_ne_zero` | `Analysis/SpecialFunctions/ExpDeriv.lean`, Chris Hughes and coauthors; complex power API |
| Analytic neighborhood | `AnalyticAt.eventually_analyticAt` | `Analysis/Analytic/ChangeOrigin.lean` |
| Cauchy integral formula | `DifferentiableOn.circleIntegral_sub_inv_smul` | `Analysis/Complex/CauchyIntegral.lean`, Yury Kudryashov |
| Equality on the integration circle | `circleIntegral.integral_congr` | `MeasureTheory/Integral/CircleIntegral.lean` |

The numerator F(x,s)=(1-(s-1)logDeriv H(s))x^s/s is analytic at 1 for x>0
and equals x there. The existing logarithmic-derivative principal-part
identity gives K(x,s)=F(x,s)/(s-1) locally off 1. A neighborhood where both
analyticity and this identity hold supplies δ>0. For each 0<r<δ, F is
differentiable on the closed disk, and the circle excludes the pole.
Cauchy's formula evaluates the positively oriented integral as 2πix.
The radius is non-effective. No rectangular deformation, inverse Mellin
formula, truncated error estimate, zero-counting asymptotic or PNT is claimed.

## Finite vertical integral and kernel bounds

`Legendre/PerronTruncated.lean` contains original deductions against the same
pinned mathlib commit, with no transplanted external proof. Inputs are the
local `norm_logDeriv_le_re_sub_one`, the complex norm inequalities
`Complex.abs_re_le_norm` and `Complex.abs_im_le_norm`, and
`Complex.norm_cpow_eq_rpow_re_of_pos`. Analytic derivatives and quotient
continuity give continuity of K where Re(s)>1; nonvanishing of ζ and s is
proved before the quotient rules are applied.

The finite integral uses mathlib's `Continuous.intervalIntegrable` and
`intervalIntegral.norm_integral_le_of_norm_le_const` from
`MeasureTheory/Integral/IntervalIntegral/Basic.lean` (Apache-2.0).
Its normalization is the parametrization ds=i dt of the upward vertical
contour with factor (2πi)⁻¹. The integral's existence is proved independently
of its norm bound. The resulting O(T) bound is deliberately only a finite
norm estimate: no ψ identification, truncation error, or infinite-line
convergence is asserted. In particular the separate inverse-height bound
alone is insufficient for absolute integrability over the whole line.

## Finite integral / Dirichlet series exchange

`Legendre/PerronSeries.lean` contains original deductions using the same
pinned mathlib commit, without copying an external formalization.

| Input | Upstream declaration | Source / authors |
|---|---|---|
| Summable von Mangoldt series and vertical majorant | `vonMangoldt_series_summable` (local interface), `LSeries.norm_term_le_of_re_le_re` | `NumberTheory/LSeries/Dirichlet.lean` and `Basic.lean`, Michael Stoll and Aaron Anderson |
| Positive-real quotient power | `Complex.div_cpow_ofReal_nonneg` | `Analysis/SpecialFunctions/Pow/Complex.lean`, Chris Hughes |
| Term continuity | `Complex.continuous_const_cpow'`, `Complex.cpow_ne_zero_iff` | complex power APIs |
| Series / interval integral exchange | `intervalIntegral.hasSum_integral_of_dominated_convergence` | `MeasureTheory/Integral/DominatedConvergence.lean`, Yury Kudryashov and coauthors |
| Integral norm bound and constant extraction | `intervalIntegral.norm_integral_le_of_norm_le_const`, `intervalIntegral.integral_const_mul` | interval integral API |

At fixed σ>1, the series `∑‖LSeries.term Λ σ n‖` converges. Multiplication
by x^σ/σ gives a majorant for every height. Each weighted term is continuous
on the entire real height axis, hence measurable on the integration interval.
The sum of the majorant is constant and thus integrable on every finite
interval. Dominated convergence then gives a HasSum statement for the
integrated terms. A separate comparison proves absolute convergence of
their integrals. No infinite-height limit is taken.

The quotient power identity for nonnegative real bases rewrites each term
as Λ(n)(x/n)^s/s. The case n=0 is handled separately using Λ(0)=0, so it
does not assume a nonzero denominator there. Extracting the coefficient
from the finite integral yields `P=∑Λ(n)J(x/n)`. There is still no scalar
kernel evaluation, truncation error, interchange with an infinite-height
limit, ψ reconstruction, or PNT claim.
