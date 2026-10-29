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
Finite zero sets here count distinct zeros; no multiplicity-weighted `N(T)`
is defined or estimated. There is no claim of an effective `c/log T` width,
a Perron formula, PNT, or any of the nine deep short-interval results.

Validate with `lake build` and `python3 scripts/audit.py`.
All ten local theorems have entries in `Legendre/Audit.lean` and
`docs/proof-map.md`.
