# Layer 2 provenance and limits

Validated against Lean `v4.35.0` and mathlib `v4.35.0`, commit
[`56a005855ea17e0b0958f73ec801ae140b0a1679`](https://github.com/leanprover-community/mathlib4/tree/56a005855ea17e0b0958f73ec801ae140b0a1679),
under Apache-2.0. The latest stable Lean release was checked as `v4.35.0`
on 2026-10-29. No dependency pins or lockfiles were changed.

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
