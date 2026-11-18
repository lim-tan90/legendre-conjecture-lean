# McColm Guth--Maynard sampling, Poisson and cubic trace ports

Upstream: https://github.com/smccolm/Lean

Fixed commit: `4c8fb7f7816508825089230e3730b69165e5e303`.
The original files are under
`Riemann Zeta/9. Zero Density, Large Values and Prime Transfer/71 Guth-Maynard, 2026/GuthMaynard/`.
The upstream MIT-0 license is retained verbatim in
[`licenses/smccolm-Lean-MIT-0.txt`](../licenses/smccolm-Lean-MIT-0.txt).
The original copyright is 2026 S. McColm. Each adapted module records the
source, commit, source filename, license and local changes in its header.

| Upstream file | Destination under `Legendre/Layer4/GuthMaynard/` | Scope |
|---|---|---|
| `DirichletPolynomial.lean` | `Polynomial.lean` | Actual dyadic polynomials, exact closed/half-open endpoint bridge, phase conjugation and normalized coefficients |
| `LargeValuesDefinitions.lean` | `Definitions.lean` | Nonempty smooth cutoff, actual sampling entries, exponential sum and closed-tolerance additive energy |
| `LargeValuesMatrix.lean` | `SamplingMatrix.lean` | Matrix action, coefficient/sample energies, L2 operator norm, actual Gram kernel and spectral trace identities |
| `TraceDispersion.lean` | `TraceDispersion.lean` | Finite Jensen inequality, sixth-moment alternatives and the sampling singular-value/operator-norm bounds |
| `LargeValuesPoisson.lean`: `gmMatrix_gram_trace_eq_cutoff_sum` | `SamplingDispersion.lean` | Selected finite first-trace identity only |
| `LargeValuesFinal.lean`: cutoff column mass, first spectral moment, dispersion nonnegativity and `gm_largeValues_raw_dispersion` | `SamplingDispersion.lean` | Selected finite count only; the final Theorem 1.1 assembly is not imported |
| `LargeValuesPoisson.lean` (remaining statements; first-trace identity reused) | `TracePoisson.lean` | Actual smooth kernel, Poisson/Mellin formulas, complete-mode summability and arbitrary inverse-power first-trace error |
| `LargeValuesReflection.lean` | `TraceReflection.lean` | Uniform Fourier decay, exact signed finite-mode Mellin reflection, cancellation-preserving dual-polynomial integral bound; finite-mode identity; complete-mode bound is in QuantitativeReflection |
| `Separated.lean`: `IsSeparated`, `InBaseInterval`; `LargeValuesLanguage.lean`: `floorImage`, `floor_injective_on_of_separated`; `HeathBrown.lean`: elementary `abs_sub_le_height_of_mem_baseInterval` | `Separation.lean` | Only the real-distance, interval and floor-bin language required by the cubic estimates |
| `LargeValuesCubic.lean` | `CubicTrace.lean` | Exact cubic Poisson expansion and S1/S2/S3 split, negligible S1 and all-zero-mode remainder |
| `TypeIIFourthMomentReduction.lean`: `integral_abs_rpow_compl_Icc`, `integrableOn_abs_rpow_compl_Icc` | `PowerTail.lean` | Only two symmetric real-power tail helpers; no contour or zero-family dependencies |
| `QuantitativeSmoothReflection.lean` | `QuantitativeReflection.lean` | Complete-frequency Lemma 6.2 with arbitrary power error, explicit smoothing/ceiling scale and actual scaled cubic tail consumer |
| `LargeValuesS2.lean`: conjugation/cyclic/diagonal identities, ordered difference moment, `gmCubicS2FirstOffDiagonal_quantitative`, `gmCubicS2FirstOffDiagonal_power_decay` | `CubicTwoTail.lean` | Cyclic reduction and negligible off-diagonal zero-mode terms only; no Heath--Brown moment bound or Proposition 6.1 assembly |
| `PolynomialPowers.lean`: finite tuple/support and wide-block lemmas; `ArithmeticCoefficients.lean`: factorization count; `ClassicalPowering.lean`: finite coefficient core through line-weight norm bound | `FinitePowers.lean` | Actual arbitrary convolution coefficients; local divisor-bound bridge reuses `Moment.DivisorGrowth.divisors_card_le_rpow` |
| `MeanValueCS.lean`, `MeanValue.lean`, `MeanValueProof.lean` | `SamplingMeanSquare.lean` | Complete finite Cauchy--Schwarz and discrete mean-square proof with the literal Montgomery constant |
| `LargeValuesLocalization.lean` | `Localization.lean` | Three sharp-to-smooth pieces, exact masks, integer rounding, N>=30 |
| `HeathBrown.lean` (elementary interval-difference lemma already in Separation reused) | `HeathBrown.lean` | Weighted moments, actual positive-kernel majorization, powering/transfer identities and recurrence |
| `VanDerCorput.lean`: phase/Kusmin--Landau core (unused logarithmic derivative lemmas omitted); `TerminalTypeI.lean`: logarithmic prefix bound; `ClassicalLargeValues.lean`: annulus packing and private helper | `LogarithmicPrefix.lean` | Only the finite cancellation/packing inputs; no classical detector or terminal zeta dependency |
| `HeathBrownReflection.lean`; `LogarithmicKernel.lean`: `dyadicInterval_eq_Ico_succ` | `HeathBrownReflection.lean` | Closed Heath--Brown weighted/coefficient-one/arbitrary bounded-coefficient difference-set mean squares, including all physical scale regimes |
| `LargeValuesS2.lean` (remaining statements; existing cyclic/diagonal/off-diagonal identities reused) | `CubicTwoTailEstimate.lean` | Complete actual Poisson-tail moment, epsilon budget and Proposition 6.1 S2 bound for every positive integer k |
| `LargeValuesS3.lean` | `CubicThreeTail.lean` | Actual cubic three-frequency integral, Fourier decay and Proposition 8.1 energy estimate on T^(2/3)<=N<=T |
| `DFIDivisorEpsilon.lean`: harmonic bound; `DFISourceCutoffs.lean`: unit bump; `ClassicalLargeValues.lean`: `sum_inv_distance_near_le_harmonic` | `CubicThreeTailSupport.lean` | Only these three elementary helpers; no general DFI/Kloosterman or zeta dependency chain |
| `LargeValuesS3.lean`: floor-correlation proof, extended locally | `EnergyTolerance.lean` | Strict/closed energy comparison by factor three and paper-convention S3 consequence; local extension is explicit |

| `LargeValuesLanguage.lean` | `AffineLanguage.lean` | Finite translations, signed scalings, affine images and floor energy; existing floor image/injectivity reused |
| `LargeValuesAffine.lean` | `AffineTransform.lean` | Actual finite affine sum/J, sharp-to-smooth majorant, complete Poisson and convolution identities |
| `LargeValuesAffineIteration.lean` | `AffineIteration.lean` | Lemma9.2 three-region/tail estimates and explicit finite natural-number descent; fixed-source Proposition9.1 |
| `LargeValuesAffineHeight.lean` | `AffineHeight.lean` | Height-aware Fourier mass family, stable smoothing profiles and uniform Proposition9.1 |
| `LargeValuesS3Refined.lean` | `CubicThreeTailRefined.lean` | Actual normalized R-square Schwartz source, complete reflected centers and selected-block Proposition10.1 |
| `LargeValuesEnergy.lean` | `EnergyDecomposition.lean` | Coefficient-preserving reflection, difference-bin energy, exact gcd decomposition and small/large-gcd slices |
| `LargeValuesEnergyFinal.lean` | `EnergyFinal.lean` | Natural-division endpoint correction, gcd summation, physical Propositions10.1/11.1/11.2; existing interval-cardinality lemma reused |
| `LargeValuesFinal.lean` (smooth assembly and Section 12) | `SmoothAssembly.lean` | Diagonal cancellation, root inequalities, separated sample selection and full-height smooth Proposition 3.1 |
| `LargeValuesFinal.lean` (complementary ranges and final assembly), `Statements.lean` (Theorem 1.1 interfaces) | `LargeValueAssembly.lean` | Exact localization and three complementary ranges; positive- and negative-phase half-open block forms |
| `../PublicationContract.lean` (Theorem 1.1 only) | `PublishedLargeValues.lean` | Closed interval sum and support-only coefficient bound, including the small-threshold case |

`CubicRemainder.lean` is a local assembly, not an additional source port. It
bounds the actual cubic trace minus its diagonal main term and S2/S3 by
O_epsilon(T^-10), preserving the scale, interval and separation hypotheses.
It additionally proves an exact diagonal identity and removes the negligible
S2 off-diagonal part, leaving the literal ordered tail moment and S3.

## Lean 4.35.0 adaptation

Every destination is compiled from source with the repository's pinned
`leanprover/lean4:v4.35.0`, against its pinned mathlib. No upstream compiled
artifacts are used. Adaptations include modern `module` visibility with
public imports/sections; the namespace becomes `Legendre.Density.GuthMaynard`.
The existing attributed `Legendre.PNT.SmoothExistence` supplies the cutoff.
`Polynomial.lean` removes the unrelated PNat-polynomial compatibility theorem
and its standalone dependency, and updates deprecated basic imports and if lemmas.

Complex conjugation explicitly identifies `star` with `starRingEnd` before
using `cpow_conj`; spectral calculations explicitly identify the RCLike real
embedding with `Complex.ofReal`. The coefficient-energy cardinality proof
uses `Fintype.card_of_subtype` and the exact dyadic cardinality, rather than
relying on hidden unfolding of the finite-column instance. All these changes
preserve the statements. Poisson explicitly imports `Mathlib.Analysis.PSeries`; all old if lemmas are
updated. Reflection makes Schwartz-to-function equalities explicit beneath
iterated derivatives, normalizes zero-order Fourier sum indices, conjugation
under Bochner/interval integrals, real-to-complex natural casts and derivative
function equalities. Cubic summability explicitly exposes its function and
casts. The full project checks also compile every private
and generated theorem used by the adapted files.

The Heath--Brown ports additionally adapt natural versus nonnegative-real
finite-product inequalities, explicit function lambdas in interval-integral
rewrites, complex derivative casts, dyadic index unfolding and natural-number
cast normalization in floor/ceiling/cardinality bounds. The existing divisor
bound supplies the local arithmetic bridge without re-porting a detector.
Weighted-moment nonnegativity is explicit where the newer positivity tactic
requires it. No upstream .olean files are copied.

The S2/S3 ports make real norms, Mellin functions beneath integrability,
Schwartz functions beneath iterated derivatives, zero-order Fourier indices,
product volume measures, finite-filter membership, measurable absolute values
and Holder factor order explicit. Two branch-elimination expressions in the
source frequency-box complement are replaced by direct De Morgan equivalences.
The local strict-energy extension supplies the boundary comparison missing
from a literal identification of the source's closed-tolerance energy.

The affine ports additionally normalize real scalar multiplication under change
of variables, equality of Schwartz functions below integrability/continuity,
zero-order Fourier index projections, product-volume Fubini, explicit Holder
output exponents and finite reciprocal telescoping. Deprecated application and
MemLp multiplication APIs are updated. Existing finite-sum Cauchy--Schwarz,
log-power absorption, interval-cardinality and floor-injectivity proofs are
reused. Two zero-guard branches use direct `ite_eq_right` proofs; the energy
bin-injectivity contradiction is discharged by its explicit floor/separation
inequalities. No unrelated DFI or detector/zeta dependency chain is imported.
Every original source blob for these seven files matches the exact pinned
upstream Git tree. See [affine/energy scope](layer4-guth-affine-energy.md).

## Local additions and exact limits

The local coefficient-energy extension permits arbitrary coefficients and
retains their actual energy cubed. A proved equality rewrites spectral
centering as the literal real part of the cubic Gram trace minus the cube
of its first trace divided by the squared row count. The independently typed
`GuthMaynardSamplingTraceBenchmark` retains the actual finite polynomial,
coefficient energy and traces; `layer4_guth_sampling_trace_comparator` is closed.

The source cutoff equals one on [6/5,9/5] and has support in [1,2]. Matrix
columns are (N,2N]; the printed paper's closed sum has a separate exact
left-endpoint term. Approximate energy in `Definitions.lean` uses <= eta,
so it is not silently identified with the paper's strict <1 convention.
The new EnergyTolerance extension proves E_strict<=E_closed<=3 E_strict
and recovers the strict-energy S3 estimate up to an absolute constant.
The finite matrix bounds need no ordinate separation; a future analytic
large-value estimate must retain its additional separation and height conditions.

Thirty-two destination modules are adapted (including the local energy-tolerance extension), with two additional Apache-2.0 modules.
The larger candidate analytic dependency chain stays outside the repository.
The first-trace, one-tail, complete quantitative reflection and S2 off-diagonal
estimates are now proved. Heath--Brown’s actual Dirichlet-polynomial difference-set mean square is also
proved. The complete Poisson-tail moment and S2 assembly are now proved, together
with the Proposition8.1 S3 energy input. The affine/height-family and gcd-energy
chain now proves Propositions9.1,10.1,11.1 and11.2. Theorem 1.1 is now proved. Central density and prime-gap transmission remain open. See [the precise new scope](layer4-guth-poisson-trace.md).

Initial five-module sampling-trace validation (2026-11-15): all five ported modules and their
consumers compile from source under Lean 4.35.0 (commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc).
The full build passes 4,324 jobs. All 4,787 project theorem declarations,
including private/generated declarations from every port, match the two
independent inventories, audit targets and actual axiom output exactly.
Only propext, Classical.choice and Quot.sound occur. All 326 classified
Lean sources have no executable placeholders or prohibited shortcuts.
All 186 consumers pass (141 Layer 4, nine Layer 3, 36 literature). New
consumers cover a nonzero matrix plateau, the literal left endpoint, a flat
spectrum and negative reciprocal arguments. Lean rejects dropping the
average branch or using the finite count as the open central density input.
The retained MIT-0 license has the exact upstream Git blob hash
34f468585a9582c8a1d0f9440b6c0f8b5f98f2e8.

Poisson/reflection/cubic validation (2026-11-15): the complete build passes
4,332 jobs under Lean 4.35.0. All 5,180 project theorem declarations,
including every private/generated declaration, agree exactly between the
module-data inventory, independent environment ownership inventory, audit
targets and parsed axiom output. Only propext, Classical.choice and Quot.sound
occur. All 334 classified Lean files are free of executable placeholders and
prohibited shortcuts, including Layers 0--4. All 199 independent consumers pass
(154 Layer 4, nine Layer 3, 24 generated literature and 12 literature regressions).
Three additional negative contract checks reject confusing reflection with
central density, dropping the Fourier ordinate factor and removing the cubic
scale window. Both READMEs retain five numbered repository headings with
individually expandable default-open details. The exact upstream MIT-0 license
blob remains 34f468585a9582c8a1d0f9440b6c0f8b5f98f2e8.

Heath--Brown validation (2026-11-15): Lean 4.35.0 full build passes 4,340 jobs.
All 5,999 project theorem declarations, including private/generated declarations,
match the module-data inventory, independent environment-owner inventory, Audit
targets and actual parsed axiom output exactly. Only propext, Classical.choice
and Quot.sound occur. All 340 classified Lean files, including Layers 0--4,
have no executable placeholders/prohibited shortcuts; no PDFs are present.
All 204 independent consumers pass (159 Layer 4, nine Layer 3, 24 generated
literature and 12 literature regressions). New consumers check zeroth powers,
localization rounding at N=30, literal single-column sampling, exact diagonal
mass and a two-point difference set with four actual nonzero contributions.
Three negative guards reject dropping coefficient/separation conditions or
confusing the mean square with central density. The prior Poisson guards also
passed. All eighteen adapted modules retain the exact pinned MIT-0 source and
are compiled from source; the retained license blob is unchanged.

S2/S3 validation (2026-11-17): Lean 4.35.0 full build passes 4,345 jobs.
All 6,688 project theorem declarations, including private/generated declarations,
agree exactly between module-data inventory, independent environment ownership,
Audit targets and parsed axiom output. Only propext, Classical.choice and
Quot.sound occur. All 344 classified Lean files, including Layers 0--4, have
zero executable placeholders/prohibited shortcuts; no PDFs are present.
All 210 independent consumers pass (165 Layer 4, nine Layer 3, 24 generated
literature, 12 literature regressions). Added consumers cover k=2 exponents,
complete actual tail moment, empty S2, singleton S3, strict/closed boundary
energies 6 and 14 and the factor-three bridge without separation assumptions.
Four negative checks reject missing S3 length/remainder conditions, false
energy equality and confusion with central density. All22 adapted modules
(including the local tolerance extension) retain fixed MIT-0 source metadata
and compile from source under Lean4.35.0; all five visible repository headings
and default-open source details are preserved in both READMEs.


Affine/energy validation (2026-11-17): Lean4.35.0 full build passes 4,362 jobs.
All 8,268 project theorem declarations, including private/generated declarations,
agree exactly between module-data enumeration, independent environment ownership,
Audit targets and parsed axiom output. Only propext, Classical.choice and
Quot.sound occur. All 351 classified Lean files, including Layers 0--4, contain
no executable placeholders/prohibited shortcuts; no PDFs are present.
All 218 independent consumers pass (173 Layer 4, nine Layer 3, 24 generated
literature and 12 literature regressions). Eight new consumers check negative
scaling, translated boundary energy, zero source, exact smoothing mass,
natural-division endpoints, singleton refined S3 and sigma=3/4 energy/S3 powers.
Six negative contract checks reject deleting coefficient, separation, T^(3/4)
window, Fourier-family or T^-90 remainder conditions, or confusing the affine
bound with central density. All 29 adapted modules retain the exact source pin
and MIT-0 metadata; the license blob is unchanged. The seven new original
source blobs match the pinned Git tree. Both READMEs retain the same five
prominent numbered repository headings and individual default-open details.


For Theorem 1.1, the Lean 4.35.0 port reuses the existing spectral moments,
weighted separated representatives, cutoff localization, and the bound
`|W| ≤ 2T`. It specializes the local weighted selection to unit weights
after rescaling, and proves translation directly on finite images.
`ClassicalAdapter.lean` derives the minimum of the two classical branches
from `SamplingMeanSquare` and `HalaszTwoTermCount` without porting another
classical detector. The publication bridge adapts the fixed-pinned
`PublicationContract.lean` in the parent directory of the analytic sources.
