# Historical literature comparators and Layer 0–4 coverage

This comparison follows the historical-progress table in both READMEs: its 16
rows plus Legendre’s target, for 17 entries. The goal is the **prime-gap exponent**:
positive epsilon losses, harmless multiplicative constants and a change between
forward/backward intervals are allowed. Hypotheses, positive-index ranges,
eventual versus finite scope, and the distinction between primes and almost
primes are retained. A comparator is an independently stated specification plus
a kernel-checked correspondence or implication. It is not a proof of an open input.

Import `Legendre.Literature`; run `python3 scripts/check_literature.py`.
The machine-readable catalog is [literature-comparators.json](literature-comparators.json).
Its numeric expectations are compiled independently of the historical definitions.
Both READMEs must contain exactly the same complete set of comparator IDs.

## Historical checklist

| Comparator | Exponent / scope | Historical proof in this project | Source check |
|---|---|---|---|
| [Legendre 1808](#legendre1808) | `square intervals` | conjecture | historical target |
| [Bertrand / Chebyshev 1845/1852](#bertrand1852) | `1` | proved | primary bibliographic record + mathlib proof |
| [Nagura 1952](#nagura1952) | `1 (constant improvement)` | proved | primary paper |
| [Hoheisel 1930](#hoheisel1930) | `32999/33000` | open | authoritative secondary (author survey/paper) |
| [Ingham 1937 (Lindelöf route)](#ingham1937lindelof) | `5/8` | open | authoritative secondary (author survey/paper) |
| [Ingham 1937 (density route)](#ingham1937density) | `577/925` | open | authoritative secondary (author survey/paper) |
| [Huxley 1972](#huxley1972) | `7/12` | open | authoritative secondary (author survey/paper) |
| [Heath-Brown–Iwaniec 1979](#heathbrowniwaniec1979) | `11/20` | open | authoritative secondary (author survey/paper) |
| [Iwaniec–Pintz 1984](#iwaniecpintz1984) | `23/42` | open | primary publisher abstract + author survey |
| [Mozzochi 1986](#mozzochi1986) | `11/20-1/384` | open | authoritative secondary (author survey/paper) |
| [Baker–Harman 1996](#bakerharman1996) | `535/1000` | open | authoritative secondary (author survey) |
| [Baker–Harman–Pintz 2001](#bakerharmanpintz2001) | `525/1000` | open | primary paper |
| [Cramér 1920 (RH consequence)](#cramer1920rh) | `1/2 + epsilon` | conditional_open | authoritative secondary quotation of original Theorem I |
| [Cramér 1936 conjecture](#cramer1936) | `0 + epsilon` | conjecture | authoritative secondary (author survey) |
| [Sorenson–Webster 2025](#sorensonwebster2025) | `finite n ≤ 70500000000000` | computation_unverified | primary final journal article |
| [Chen 1975](#chen1975) | `eventual P2` | open | authoritative secondary citation |
| [Dudek–Johnston 2026](#dudekjohnston2026) | `P4 for all n ≥ 1` | open | primary paper |

Only Bertrand and Nagura are closed historical prime-interval proofs here.
The eleven open analytic claims, the RH conditional claim, two conjectural
claims and the unverified large computation stay in their respective categories.
“Comparison passed” must never be read as “historical theorem proved”.

## Corrections and source limitations

- **Heath-Brown–Iwaniec 1979:** corrected `13/23` to `11/20`. Pintz’s author
  survey §3, (3.13) gives `11/20`; its preceding discussion associates `13/23`
  with Iwaniec–Jutila 1979. The original Heath-Brown–Iwaniec full text was not
  accessible here, so this remains explicitly an author-survey source check.
- **Iwaniec–Pintz 1984:** corrected the unsupported `11/20−1/406` to `23/42`,
  supported by the publisher abstract and Pintz’s author survey §3, (3.13).
  The old value is strictly smaller, so this is not a harmless weakening.
- **Legacy `*Paper` labels:** these are normalized exponent specifications,
  not copies of all stronger count asymptotics or the exact interval coefficient.
  The public names are retained; the descriptions and README labels are corrected.
- **BHP 2001:** Theorem 1 uses `[x−x^0.525,x]`. Its comparison proves a
  one-way implication to the existing gap exponent and then permits `+epsilon`.
  It does not assert equality with the original coefficient-one statement.
- **Sorenson–Webster:** the final journal abstract reports `7.05×10^13`,
  whereas arXiv `2401.13753v1` reports `3.33×10^13`. Runtime statements use
  Cramér’s probabilistic model; the finite prime certificate is not imported.
  Oppermann starts at index 2; the Legendre index-1 case is proved separately.
- **Cramér:** `O(log²p)` is a conjectural input for primes, not a theorem
  obtained by applying results about independent random variables to primes.
- **Ingham 1937 / 1940:** the `577/925` short-interval route and the later
  curved density exponent `3(1−σ)/(2−σ)` are separate source results.
- **Starichkova v1 introductory direction:** §1.1 renders the Hoheisel range
  as `0≤θ<1−1/33000`; the normalized comparator uses exponents **above** the
  cutoff. The same note’s Theorem 2.1 has the consistent lower-cutoff direction.
  This is an apparent introductory typo, not evidence that its analytic proof
  or Hoheisel’s theorem fails. Its historical `13/23` attribution is superseded
  here by the more precise author-survey check above.

No mathematical proof gap in the original prime-gap theorems has been established
in this review. The identified repository/source-reporting problems are repaired
by correcting expectations, retaining hypotheses and adding typed comparisons.
Paywalled originals are not described as directly verified.

## Completed layers and remaining exponent obligations

| Layer | What is checked | Correspondence to historical exponent claims |
|---|---|---|
| 0 | Open square intervals, prime-gap reductions, P1 equivalence; new Cramér-to-eventual-Legendre bridge | Logical correspondence only; no proof of Legendre or Cramér |
| 1 | Strict Bertrand and strict real Nagura, including the finite threshold | Closed proofs; both are linear-scale results, with different constants |
| 2 | Analytic continuation, completed reflection, nonvanishing, explicit logarithmic zero-free region | Proved prerequisites for the analytic papers; not a short-interval power theorem |
| 3 | Classical PNT error, prime-interval and explicit-formula infrastructure | Proved prerequisite; `x exp(−c sqrt(log x))` is not `O(x^θ)` for any fixed `θ<1` |
| 4 | Linear mean-square error, actual detection, weighted sampling, fourth moment O(T log^4 T), height exponent 1+epsilon, and the compensated high-zero detector | Ingham 1940, global Huxley 12/5 and the full curved Huxley exponent proved, uniformly in sigma, with all heights and analytic multiplicities; the Guth–Maynard curve and combined global 30/13 are proved |

A further source-input distinction matters for fixed exponents. Ingham 1937
Theorem 1, as quoted in Starichkova Theorem 2.1, uses a zero-free width
`A log log T / log T` and an explicit density-logarithm loss. The completed
Layer 2 benchmark supplies only a classical `c/log T` width. It cannot simply
be substituted for that stronger source input. A stronger zero-free theorem,
or a different fully proved transmission argument, remains an analytic
obligation. “Documented Layer 2 complete” refers to its stated classical
scope, not every hypothesis of every later paper.

The two curved density specifications retain uniformity in σ and additive
epsilon in the height exponent. The verified `huxley_global_comparator` combines
Ingham below σ=3/4 with Huxley above σ=3/4 to recover the global `12/5` target.
The corresponding Guth–Maynard comparison combines its curved exponent with
Ingham at σ=7/10 to recover `30/13`. The closed Ingham, Huxley and Guth–Maynard comparators supply the analytic
inputs to these density comparisons. The sharp fourth-moment upper bound
closes `ZetaFourthMoment` while the existing public comparisons also cover
`ZetaFourthMomentLogSix` and `ZetaFourthMomentExponent`. The 1937
short-interval comparators remain open.
[Fourth-moment proof scope](layer4-sharp-fourth-moment.md).

### Complete source coverage

The catalog classifies every project Lean file, including adapted dependencies
and validation modules. This is a source/benchmark map; it does not assert that
every helper theorem is itself a paper’s main theorem. New/unclassified files
fail the coverage check. Layer 5 historical specifications stay statement-only.

| Group | Files |
|---|---:|
| comparison | 4 |
| facade | 1 |
| layer0 | 4 |
| layer1 | 6 |
| layer2 | 33 |
| layer3 | 38 |
| layer4 | 71 |
| statements_only | 2 |
| verification | 5 |

## Individual source locators and comparison declarations

<a id="legendre1808"></a>
### Legendre 1808

- Expected specification: `Legendre.Literature.Legendre1808`.
- Exponent/scope: `square intervals`; historical claim status: **conjecture**.
- Source: Essai sur la théorie des nombres, 2nd ed. (1808) (historical target).
- Comparison: `Legendre1808 ↔ Legendre.Conjecture`.
- Note: Target specification only; no unconditional proof.

<a id="bertrand1852"></a>
### Bertrand / Chebyshev 1845/1852

- Expected specification: `Legendre.Literature.Bertrand1852`.
- Exponent/scope: `1`; historical claim status: **proved**.
- Source: [Chebyshev, pp. 366–390](https://www.numdam.org/item/JMPA_1852_1_17__366_0/) (primary bibliographic record + mathlib proof).
- Comparison: `∀ n : ℕ, 2 ≤ n → ∃ p : ℕ, p.Prime ∧ n < p ∧ p < 2*n`.
- Note: Strict upper endpoint recovered from primality; n=1 is excluded.

<a id="nagura1952"></a>
### Nagura 1952

- Expected specification: `Legendre.Literature.Nagura1952`.
- Exponent/scope: `1 (constant improvement)`; historical claim status: **proved**.
- Source: [main theorem, pp. 177–181](https://www.jstage.jst.go.jp/article/pjab1945/28/4/28_4_177/_pdf) (primary paper).
- Comparison: `∀ x : ℝ, 25 ≤ x → ∃ p : ℕ, p.Prime ∧ x < p ∧ (p : ℝ) < 6*x/5`.
- Note: The comparator preserves the strict upper endpoint and includes x=25.

<a id="hoheisel1930"></a>
### Hoheisel 1930

- Expected specification: `Legendre.Literature.Hoheisel1930Progress`.
- Exponent/scope: `32999/33000`; historical claim status: **open**.
- Source: [§3, (3.6)](https://www.renyi.hu/~pintz/pjapr.pdf) (authoritative secondary (author survey/paper)).
- Comparison: `ForwardProgress (32999/33000) ↔ Legendre.Hoheisel`.
- Note: Prime-count asymptotics are stronger than this exponent projection.

<a id="ingham1937lindelof"></a>
### Ingham 1937 (Lindelöf route)

- Expected specification: `Legendre.Literature.Ingham1937LindelofProgress`.
- Exponent/scope: `5/8`; historical claim status: **open**.
- Source: [§3, (3.6)–(3.7)](https://www.renyi.hu/~pintz/pjapr.pdf) (authoritative secondary (author survey/paper)).
- Comparison: `ForwardProgress (5/8) ↔ Legendre.Ingham58`.
- Note: Original paper DOI 10.1093/qmath/os-8.1.255; exponent projection, allowing epsilon.

<a id="ingham1937density"></a>
### Ingham 1937 (density route)

- Expected specification: `Legendre.Literature.Ingham1937DensityProgress`.
- Exponent/scope: `577/925`; historical claim status: **open**.
- Source: [§2.1 after Theorem 2.1](https://arxiv.org/html/2411.01845) (authoritative secondary (author survey/paper)).
- Comparison: `ForwardProgress (577/925) ↔ Legendre.Ingham577`.
- Note: 925/348 gives 1−348/925=577/925; this is distinct from the 1940 curved density theorem.

<a id="huxley1972"></a>
### Huxley 1972

- Expected specification: `Legendre.Literature.Huxley1972Progress`.
- Exponent/scope: `7/12`; historical claim status: **open**.
- Source: [§3, (3.6)–(3.7)](https://www.renyi.hu/~pintz/pjapr.pdf) (authoritative secondary (author survey/paper)).
- Comparison: `ForwardProgress (7/12) ↔ Legendre.Huxley`.
- Note: PNT asymptotic implies this weaker prime-existence progress; no endpoint claim.

<a id="heathbrowniwaniec1979"></a>
### Heath-Brown–Iwaniec 1979

- Expected specification: `Legendre.Literature.HeathBrownIwaniec1979Progress`.
- Exponent/scope: `11/20`; historical claim status: **open**.
- Source: [§3, (3.13)](https://www.renyi.hu/~pintz/pjapr.pdf) (authoritative secondary (author survey/paper)).
- Comparison: `ForwardProgress (11/20) ↔ Legendre.HeathBrownIwaniec`.
- Note: Corrected from 13/23; that value is attributed to Iwaniec–Jutila 1979 in the same survey.

<a id="iwaniecpintz1984"></a>
### Iwaniec–Pintz 1984

- Expected specification: `Legendre.Literature.IwaniecPintz1984Progress`.
- Exponent/scope: `23/42`; historical claim status: **open**.
- Source: [publisher abstract; Pintz §3 (3.13)](https://link.springer.com/article/10.1007/BF01637280) (primary publisher abstract + author survey).
- Comparison: `ForwardProgress (23/42) ↔ Legendre.IwaniecPintz`.
- Note: Corrected from unsupported 11/20−1/406; the source gives a positive-proportion prime count.

<a id="mozzochi1986"></a>
### Mozzochi 1986

- Expected specification: `Legendre.Literature.Mozzochi1986Progress`.
- Exponent/scope: `11/20-1/384`; historical claim status: **open**.
- Source: [§3, (3.13)](https://www.renyi.hu/~pintz/pjapr.pdf) (authoritative secondary (author survey/paper)).
- Comparison: `ForwardProgress (11/20-1/384) ↔ Legendre.Mozzochi`.
- Note: Original DOI 10.1016/0022-314X(86)90101-0; exponent projection.

<a id="bakerharman1996"></a>
### Baker–Harman 1996

- Expected specification: `Legendre.Literature.BakerHarman1996Progress`.
- Exponent/scope: `535/1000`; historical claim status: **open**.
- Source: [§3, (3.13)](https://www.renyi.hu/~pintz/pjapr.pdf) (authoritative secondary (author survey)).
- Comparison: `GapProgress (535/1000) ↔ Legendre.BakerHarman`.
- Note: The endpoint gap implies the same exponent with arbitrary positive epsilon.

<a id="bakerharmanpintz2001"></a>
### Baker–Harman–Pintz 2001

- Expected specification: `Legendre.Literature.BakerHarmanPintz2001`.
- Exponent/scope: `525/1000`; historical claim status: **open**.
- Source: [Theorem 1, p. 532](https://www.cs.umd.edu/~gasarch/BLOGPAPERS/BakerHarmanPintz.pdf) (primary paper).
- Comparison: `BackwardProgress (525/1000) → Legendre.BakerHarmanPintz`.
- Note: One-way comparison: coefficient-one backward intervals imply the normalized gap exponent; epsilon weakening is also proved.

<a id="cramer1920rh"></a>
### Cramér 1920 (RH consequence)

- Expected specification: `Legendre.Literature.Cramer1920Progress`.
- Exponent/scope: `1/2 + epsilon`; historical claim status: **conditional_open**.
- Source: [Theorem 2.2](https://arxiv.org/html/2411.01845) (authoritative secondary quotation of original Theorem I).
- Comparison: `(RiemannHypothesis → RHGapProgress) ↔ (RiemannHypothesis → Legendre.RHGapBound)`.
- Note: RH remains explicit. The stronger source count implies this progress; the logarithm is absorbed into epsilon.

<a id="cramer1936"></a>
### Cramér 1936 conjecture

- Expected specification: `Legendre.Literature.Cramer1936Conjecture`.
- Exponent/scope: `0 + epsilon`; historical claim status: **conjecture**.
- Source: [§4, (4.2)](https://www.renyi.hu/~pintz/pjapr.pdf) (authoritative secondary (author survey)).
- Comparison: `Cramer1936Conjecture ↔ Legendre.CramerGapBound`.
- Note: The prime gap claim is conjectural; results in a probabilistic model do not prove it for primes.

<a id="sorensonwebster2025"></a>
### Sorenson–Webster 2025

- Expected specification: `Legendre.Literature.SorensonWebster2025`.
- Exponent/scope: `finite n ≤ 70500000000000`; historical claim status: **computation_unverified**.
- Source: [abstract and §1](https://link.springer.com/article/10.1007/s40993-024-00589-4) (primary final journal article).
- Comparison: `FiniteOppermann 70500000000000 → FiniteLegendre 70500000000000`.
- Note: Final article has 7.05×10^13; arXiv v1 only 3.33×10^13. No computational certificate imported. The n=1 Legendre case is separate.

<a id="chen1975"></a>
### Chen 1975

- Expected specification: `Legendre.Literature.Chen1975Progress`.
- Exponent/scope: `eventual P2`; historical claim status: **open**.
- Source: [§1.1, Chen [5]](https://arxiv.org/html/2501.18048v2) (authoritative secondary citation).
- Comparison: `Chen1975Progress ↔ Legendre.AlmostPrimeSquareEventually 2`.
- Note: Omega counts factors with multiplicity; the scope is sufficiently large n, not all n.

<a id="dudekjohnston2026"></a>
### Dudek–Johnston 2026

- Expected specification: `Legendre.Literature.DudekJohnston2026`.
- Exponent/scope: `P4 for all n ≥ 1`; historical claim status: **open**.
- Source: [Theorem 1.2](https://arxiv.org/html/2501.18048v2) (primary paper).
- Comparison: `DudekJohnston2026 ↔ Legendre.AlmostPrimeSquareAtMost 4`.
- Note: This comparator does not turn P4 into a prime claim or a Layer 0 proof.


## Future layer layout

Layer 5 implementations are under `Legendre/Layer5/`; the existing public
`Legendre.Layer5` import is retained. Layer 6 and 7 have reserved directories.
The directory rule is grouped with the existing contribution requirements at
the top of both READMEs and in CONTRIBUTING. Future source additions must
also be added to the complete module coverage map.

## Validation

The complete build has 4,193 jobs and the axiom audit covers all 3,788 distinct
project theorem declarations. All 218 Lean source files are free of executable
placeholders. The 24 catalog/closed-proof consumers, 12 literature regression
guards, 56 Layer 4 consumers and 9 Layer 3 consumers compile independently.
The independent module-data and full-environment theorem inventories are checked
against the parsed audit output. Intentional bad fixtures verify that Lean
rejects the old unsupported exponent, an open density bridge used as a closed
proof, and a forged historical-proof label. Catalog checks reject missing
historical IDs, unclassified source files and inconsistent proof labels.

Ingham density validation (2026-11-10): full build 4,206 jobs. All 3,874
project theorem declarations, including private/generated helpers, are audited
against propext, Classical.choice and Quot.sound. Both independent declaration
inventories match the audit targets and actual axiom output exactly. All 231
Lean sources have zero executable sorry, admit or sorryAx. All 107 standalone
consumers pass: 62 Layer 4, 9 Layer 3 and 36 literature. The added consumers
cover the real-height top boundary, the balanced sigma=3/4 powers, density
exponents at sigma=1/2 and 3/4, T=2 uniformly in sigma, and linear exponent
three. An intentional Ingham-as-Huxley consumer is rejected by Lean.

The closed 1940 density comparator matches the height exponent cited in
Chourasiya–Simonič, [arXiv:2507.15184v2, introduction](https://arxiv.org/html/2507.15184v2).
The original result is Ingham, *On the estimation of N(σ,T)*, Quart. J. Math.
os-11 (1940), [DOI 10.1093/qmath/os-11.1.201](https://doi.org/10.1093/qmath/os-11.1.201).
The cumulative bound has seven logarithms uniformly on `[1/2,1]`.
Every fixed strip ending below one has five logarithms, and every fixed
inner strip has four. The 1937 short-interval theorem remains a Layer 5 goal.
[Exact logarithmic statements](layer4-ingham-shell-log-five.md#cumulative-density).

The closed `layer4_actual_halasz_comparator` also checks the proved actual
logarithmic-phase Halasz energy, retaining its explicit R sqrt(T) and harmonic
row terms. The mixed-real-part extension is proved. This is an analytic input;
it does not close Huxley or Guth--Maynard density.

Actual Halasz input validation (2026-11-10): full build 4,242 jobs; all 4,070
project theorem declarations, including private/generated helpers, audited
against exactly propext, Classical.choice and Quot.sound. Both independent
declaration inventories match the audit targets and actual axiom output.
All 246 project Lean files have zero executable placeholders. All 113
standalone consumers pass: 68 Layer 4, 9 Layer 3 and 36 literature checks.
An intentional use of the nonzero-ordinate kernel at t=0 is rejected.

### Restricted curved Huxley proof (2026-11-14)

`Huxley1972RestrictedDensity` independently specifies the curved exponent
3(1−σ)/(3σ−1)+epsilon, uniformly for σ∈[1/2,5/6], T>=2, with analytic
multiplicities. `layer4_huxley_restricted_comparator` is a closed proof and is
included in the generated Layer 4 consumer. The full `Huxley1972Density`
benchmark is now also proved above σ=5/6, as documented below. This does not close the Huxley 1972
prime-gap theorem, whose Layer 5 proof is a separate obligation.

### Actual short-sum Weyl input (2026-11-14)

`WeylShortSumBenchmark` independently specifies norm of the actual complex
sum <= C sqrt(U) abs(t)^(1/6) on U<=V<=2U, abs(t)>=1 and U²<=4 abs(t).
`layer4_weyl_short_sum_comparator` is closed and included in the generated
Layer 4 consumer. Its range does not assert zeta subconvexity or close the
remaining curved-density real parts above sigma=5/6.

### Weighted and general-length Weyl inputs (2026-11-14)

`WeightedWeylBenchmark` preserves beta>=0 and the short-length hypothesis;
`GeneralWeylBenchmark` allows every dyadic length and keeps all three costs.
Their closed comparators are included in the generated Layer 4 consumer.
The actual Type II estimate at Y=T is documented separately and remains
one branch of the detector, not a full density theorem.

### Actual Mobius pointwise inputs (2026-11-15)

`ActualMobiusPointwiseBenchmark` independently specifies both actual smoothed
polynomial bounds with a common X U^(−beta) cost, beta∈[0,1], Y>0 and
abs(t)>=1. `layer4_actual_mobius_pointwise_comparator` is closed and included
in the generated Layer 4 consumer. Integer floors and the extra divided
endpoint are proved. The full upper-range curved-density theorem is now
proved by the assembly below.

### Full curved Huxley proof (2026-11-15)

`layer4_huxley_comparator : Huxley1972Density` is a closed witness for the
independently stated exponent 3(1-sigma)/(3sigma-1)+epsilon, uniformly on
sigma in [1/2,1], for every T>=2 and all analytic multiplicities. The actual
Y=T detector branches use one integer cutoff; an epsilon-sized transition
band avoids pointwise-in-sigma constants. The proved height cover and
multiplicity selector complete the count. No open analytic hypothesis is
used. The full target is removed from `open_analytic_targets` in the catalog,
while Guth–Maynard and the sharp log^4 fourth moment stay open. Huxley 1972's
7/12 prime-gap comparator remains a separate open Layer 5 claim.
See [the proof and exact scope](layer4-full-curved-huxley.md).

### Guth–Maynard outer range and central reduction (2026-11-15)

`GuthMaynard2024OuterDensity` is proved on [1/2,7/10] union [4/5,1],
with one coefficient for all real parts, T>=2 and analytic multiplicities.
`layer4_guth_maynard_outer_comparator` is a closed witness. The full target
is equivalent to the explicitly open `GuthMaynard2024CentralDensity` on
(7/10,4/5); both appear as open targets in the catalog. This equivalence
does not supply its input. At sigma=3/4, the classical curves give 3/5 and
the desired exponent is 5/9. See [the exact reduction](layer4-guth-maynard-range.md).

### Finite Guth–Maynard sampling comparator (2026-11-15)

`GuthMaynardSamplingTraceBenchmark` independently states the actual finite
polynomial, arbitrary coefficient energy and centered cubic Gram trace.
`layer4_guth_sampling_trace_comparator` is closed. Its source modules are
pinned to smccolm/Lean commit 4c8fb7f7816508825089230e3730b69165e5e303,
MIT-0, and all five destinations are adapted to Lean 4.35.0. The full
Guth–Maynard and central density targets remain open: the finite sampling
inequality does not supply the required analytic off-diagonal trace bound.
See [exact sources and adaptations](smccolm-guth-provenance.md).

### Guth–Maynard Poisson and cubic remainders (2026-11-15)

Five new independent closed benchmarks retain the actual first trace and real
cutoff integral, two-parameter Fourier decay, and the cubic trace minus its
diagonal term and S2/S3. Their constants are selected before all scale/sample
parameters. The cubic comparator preserves positive epsilon, N<=T<=N^2 and
T^epsilon-separated ordinates in [0,T]. It is an analytic remainder estimate;
it does not prove the S2/S3 bounds or the full density theorem. Complete
quantitative reflection is independently compared with literal smoothing and
ceiling length, and the final cubic comparator leaves the literal ordered
nonzero-tail moment and S3, after removing the negligible S2 off-diagonal.
See [exact statements and source scope](layer4-guth-poisson-trace.md).

### Heath–Brown ordered difference-set mean square (2026-11-15)

`HeathBrownDifferenceMeanSquareBenchmark` uses the literal polynomial and
three physical terms R^2 N, R N^2 and R^(5/4)T^(1/2)N, allowing every positive
epsilon with a constant and threshold before all scales. It retains unit
coefficient bounds, one-separated ordinates and W in [0,T]. The comparator
is closed. This input is distinct from the Poisson-tail moment assembled in
Guth–Maynard Proposition 6.1 and from any prime-gap exponent result.
See [scope and verification](layer4-heath-brown-difference.md).

### Complete S2 and the S3 energy input (2026-11-17)

The closed S2 and Poisson-tail moment comparators preserve all three powers
parameterized by k>=1, positive epsilon, T^epsilon separation, and one uniform
constant/threshold. The S3 energy comparator preserves T^(2/3)<=N<=T and
T^-90. The source's closed tolerance <=1 and the paper's strict <1 are recorded
separately; a proved factor-three comparison changes only the absolute
constant. Sharper energy/affine refinement and central density remain open.
See [statements and boundary conventions](layer4-guth-s2-s3.md).

## Guth--Maynard affine and energy refinement (2026-11-17)

Five additional closed independent benchmarks check the literal finite affine
integral (Proposition9.1), the uniform height-family profile, the physical S3
Proposition10.1, the actual large-value energy Proposition11.1 and substituted
S3 Proposition11.2. The height-family constant is fixed before heights and source
functions; its Fourier derivative profile retains T^(n+2) and source mass.
All physical scale, separation, support-only coefficient and sample conditions
remain explicit, as does the T^-90 error. Source closed energy is a literal
quadruple filter; its relation to the paper's strict energy is already proved.
The final large-values and central density assembly remain open.
See [exact formulas and scope](layer4-guth-affine-energy.md).


## Guth–Maynard Theorems 1.1 and 1.2 (2026-11-18)

The literal closed-sum large-values comparator, central and full uniform
zero-density comparators, and the combined global `30/13` comparator are closed.
They retain the actual support and sample conditions for Theorem 1.1 and
analytic multiplicities, a uniform constant, and all heights `T ≥ 2` for
Theorem 1.2. The independent central consumer specializes to `σ=3/4`,
where the exponent is `5/9+ε`.
[Proof scope](layer4-guth-central-density.md).

## Ingham separated height-shell count (2026-11-19)

The separated detector-shell comparator has the exponent
`3(1−σ)/(2−σ)` and a fifth power of `log T`. It states the required
gap `σ−1/2 ≥ 1/log T` and unit separation. The existing cumulative
multiplicity-weighted Ingham comparator continues to cover all
`σ∈[1/2,1]` and `T≥2` with an arbitrary positive exponent loss.
[Exact theorem scope](layer4-ingham-shell-log-five.md).

The cumulative logarithmic comparator supplies seven logarithms uniformly on
`σ∈[1/2,1]`, five on each fixed `[1/2,τ]` with `τ<1`, and four on every fixed `[α,τ] ⊂ (1/2,1)`. All statements
count analytic multiplicities at every `T≥2`.
[Exact statements](layer4-ingham-shell-log-five.md#cumulative-density). The shrinking-strip comparator gives the
fifth-log bound with one absolute constant in its three explicit ranges.
[Exact scope](layer4-ingham-shell-log-five.md#explicit-shrinking-strip).

The sharper weighted fourth-moment and balanced integral-branch comparators
retain whole-line integrability, the actual compensated detector, the fixed
cutoff range and the dependence on the real-part gap.
[Proof and exact statements](layer4-weighted-fourth-moment.md).

The local mollified-Jensen comparison proves a bound on the analytic
multiplicities in a disk using a literal circle average of the squared
Möbius mollifier error. The radii, pole-exclusion, and center cutoff
conditions remain explicit. [Exact statement](layer4-mollified-jensen.md). The height-integrated comparator bounds the
full near-one density increment from the uniform vertical mollified second
moment. [Exact statement](layer4-mollified-jensen.md#height-integrated-density-near-one). The finite-energy comparison retains the Euler
and pole terms and permits an independent center offset.
[Finite-energy estimate](layer4-mollified-jensen.md#finite-energy-second-moment). The weighted dyadic comparison
retains each block’s length and bounds the center integral by the smaller
of two explicit quantities.
[Dyadic comparison](layer4-mollified-jensen.md#weighted-dyadic-second-moment).
The index-weighted comparator charges each Dirichlet coefficient by
`T+n`. The compact smoothing comparators retain both residues and
the exact logarithmic cost of the critical product.
[Weighted and smoothed estimates](layer4-mollified-jensen.md#index-weighted-second-moment). The height-convolution and shell comparators
verify the actual mollified second moment up to real part `7/6`, with the
exact curved exponent under the explicit near-one condition.
[Fourth-log shell moment](layer4-mollified-jensen.md#fourth-log-smoothed-second-moment-on-high-shells).
