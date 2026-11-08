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
| 4 | Linear mean-square error, actual detection, weighted sampling, normalized xi-square pointwise reduction | Proved prerequisites; fourth moment and the Ingham/Huxley density bounds remain open |

The two curved density specifications retain uniformity in σ and additive
epsilon in the height exponent. The verified `huxley_global_comparator` combines
Ingham below σ=3/4 with Huxley above σ=3/4 to recover the global `12/5` target.
The corresponding Guth–Maynard comparison combines its curved exponent with
Ingham at σ=7/10 to recover `30/13`. These are conditional comparison bridges:
the analytic density inputs are not supplied. A pointwise fourth-power reduction
does not supply `ZetaFourthMoment`. No Layer 4 completion status is upgraded.

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

The complete build has 4,139 jobs and the axiom audit covers all 3,422 distinct
project theorem declarations. All 164 Lean source files are free of executable
placeholders. The 24 catalog/closed-proof consumers, 12 literature regression
guards, 33 Layer 4 consumers and 9 Layer 3 consumers compile independently.
The independent module-data and full-environment theorem inventories are checked
against the parsed audit output. Intentional bad fixtures verify that Lean
rejects the old unsupported exponent, an open density bridge used as a closed
proof, and a forged historical-proof label. Catalog checks reject missing
historical IDs, unclassified source files and inconsistent proof labels.
