# Literature timeline: the exponent in Legendre's conjecture

This document collects the published progress on the **prime-gap exponent**
relevant to Legendre's conjecture:

> **Legendre's conjecture.** For every integer `n ≥ 1`, there is a prime `p`
> with `n² < p < (n+1)²`.

Equivalently, if `p_k` is the `k`-th prime,
`p_{k+1} - p_k < 2√p_k` at the square scale.  A bound
`p_{k+1} - p_k ≤ C p_k^θ` with `θ < 1/2` would prove Legendre for all
sufficiently large `n`; the finite range then needs an explicit computation.

**No PDFs are stored in this repository.**  Links below point to publishers,
arXiv, zbMATH/MaRDI, or author pages.

## 1. Unconditional exponent results

Notation: `θ` is a real number such that, for every `ε > 0`,
`p_{k+1} - p_k ≪ p_k^{θ+ε}`; unless stated otherwise the result is for
sufficiently large `p_k`.

The exact quantifier conventions — the `+ε` form, the explicit constants and
the “sufficiently large” threshold — are encoded in `Legendre/Layer5.lean`
(`HoheiselPaper`, `Ingham58Paper`, `Ingham577Paper`, `HuxleyPaper`,
`HeathBrownIwaniecPaper`, `IwaniecPintzPaper`, `MozzochiPaper`,
`BakerHarmanPaper`, `BakerHarmanPintzPaper`), together with proved bridges to
the coarse `Prop`s in `Legendre/Conditional.lean`.  These declarations are
`Prop` definitions: the values below are **not proved** in this repository.

| Year | Author(s) | Exact result | Evidence | Link |
|---:|---|---|---|---|
| 1930 | G. Hoheisel | `θ = 1 - 1/33000 = 32999/33000`; first exponent `< 1` | secondary-authoritative | [zbMATH JFM 56.0172.02](https://zbmath.org/?q=an:56.0172.02) |
| 1937 | A. E. Ingham | `θ = 5/8`, via `ζ(1/2+it) = O(t^{1/6})` and his general theorem | secondary-authoritative | [DOI 10.1093/qmath/os-8.1.255](https://doi.org/10.1093/qmath/os-8.1.255) · [MacTutor](https://mathshistory.st-andrews.ac.uk/Biographies/Ingham/) |
| 1937 | A. E. Ingham | same paper, zero-density route: `θ = 577/925 + ε ≈ 0.62378` | secondary-authoritative | [Starichkova, arXiv:2411.01845](https://arxiv.org/abs/2411.01845) |
| 1972 | M. N. Huxley | `θ = 7/12 + ε ≈ 0.58333` (strict `+ε`; `7/12` is an infimum, not attained) | secondary-authoritative | [DOI 10.1007/BF01418933](https://doi.org/10.1007/BF01418933) · [EuDML](https://eudml.org/doc/142126) |
| 1979 | D. R. Heath-Brown, H. Iwaniec | `θ = 13/23 + ε ≈ 0.56522`, weighted zero-density | secondary-authoritative (single secondary source) | [DOI 10.1007/BF02139702](https://doi.org/10.1007/BF02139702) |
| 1984 | H. Iwaniec, J. Pintz | `θ = 11/20 - 1/406 + ε ≈ 0.54754` | secondary-authoritative | [DOI 10.1007/BF01637280](https://doi.org/10.1007/BF01637280) |
| 1986 | C. J. Mozzochi | `θ = 11/20 - 1/384 + ε ≈ 0.54740` | secondary-authoritative | [DOI 10.1016/0022-314X(86)90101-0](https://doi.org/10.1016/0022-314X\(86\)90101-0) |
| 1996 | R. C. Baker, G. Harman | `θ = 0.535` | secondary-authoritative | [DOI 10.1112/plms/s3-72.2.261](https://doi.org/10.1112/plms/s3-72.2.261) |
| 2001 | R. C. Baker, G. Harman, J. Pintz | `θ = 0.525`; **current record** for existence of a prime in `[x - x^θ, x]` | secondary-authoritative | [DOI 10.1112/plms/83.3.532](https://doi.org/10.1112/plms/83.3.532) |
| 2024 | L. Guth, J. Maynard | zero-density `N(σ,T) ≤ T^{30(1-σ)/13+o(1)}`; short-interval **asymptotic** PNT for `x^{17/30+o(1)}` (`17/30 ≈ 0.5667`). **Not** an improvement of the `0.525` existence record | primary (arXiv) | [arXiv:2405.20552](https://arxiv.org/abs/2405.20552) |

### Notes on the two Ingham values

The commonly quoted `5/8` and the slightly stronger `577/925` are not
contradictory: they come from two routes in the same 1937 paper.  The `5/8`
value uses the then-known Lindelöf-type bound with `c = 1/6`; the `577/925`
value uses Ingham's zero-density estimate with `b = 925/348 + ε`.  Because the
original 1937 paper is not open access, these values are labelled
`secondary-authoritative` here rather than `primary-paper`.

### Why `0.525` is not enough

Take `x = n²` and let `p ≤ n²` be the largest prime not exceeding `n²`.  If
the next prime satisfies

```
q - p ≤ C p^θ ≤ C n^{2θ},
```

then

```
q < n² + C n^{2θ}.
```

To force `q < (n+1)² = n² + 2n + 1`, one needs `C n^{2θ} < 2n` eventually,
which holds exactly when `2θ < 1`, i.e. `θ < 1/2` (or `θ = 1/2` with constant
`C < 2`).  For `θ = 0.525`, `C n^{1.05}` is much larger than `2n`; the bound
allows a gap that jumps over the entire square interval.

This implication is formalized in
`Legendre/Reduction.lean` (`eventually_legendre_of_gap_exponent_lt_half`).

## 2. Current explicit verification

| Result | Meaning | Evidence | Link |
|---|---|---|---|
| Sorenson–Webster (2025): Legendre verified up to `n ≤ 7.05 × 10¹³` | stronger: Oppermann's conjecture verified in that range; equivalent to primes up to about `(7.05×10¹³)² ≈ 4.97×10²⁷` | primary-paper | [DOI 10.1007/s40993-024-00589-4](https://doi.org/10.1007/s40993-024-00589-4) |
| Oliveira e Silva–Herzog–Pardi (2014): prime gaps computed up to `4 × 10¹⁸` | this is a **prime bound**, not `n ≤ 4×10¹⁸`; it gives the older Legendre range `n ≤ 2 × 10⁹` | primary-paper for the computation; the `n ≤ 2×10⁹` reading is an inference | [DOI 10.1090/S0025-5718-2013-02787-1](https://doi.org/10.1090/S0025-5718-2013-02787-1) |

**Correction of a common misreading.** “Verified up to `4×10¹⁸`” refers to the
prime bound in the 2014 computation, not to `n`.  Verifying Legendre for
`n ≤ 4×10¹⁸` would require primality information up to about `1.6×10³⁷`; no
such published computation exists.

## 3. Conditional results

| Hypothesis | Consequence | Enough for Legendre? | Evidence / link |
|---|---|---|---|
| Riemann Hypothesis | maximal gap `G(x) ≪ √x log x` | **No**: `√x log x` is larger than `2√x` by a log factor; Legendre remains open under RH | [CMS 2019, DOI 10.4171/CMH/467](https://doi.org/10.4171/CMH/467); [Ford, arXiv:1907.11994](https://arxiv.org/abs/1907.11994) |
| RH + explicit CMS bound | prime in `[x, x + (22/25)√x log x]` for `x ≥ 4` | No | [CMS 2019](https://doi.org/10.4171/CMH/467) |
| Cramér's conjecture `G(x) = O((log x)²)` | gaps far smaller than `√x` | **Yes**, for all sufficiently large `n`; a finite check would finish | Cramér 1936, [DOI 10.4064/aa-2-1-23-46](https://doi.org/10.4064/aa-2-1-23-46) |

The Lean file `Legendre/Conditional.lean` states `RHGapBound` and
`CramerGapBound` as opaque `Prop`s; neither is proved.

## 4. Almost-prime (P_k) progress

`P_k` means a number with at most `k` prime factors, counted with multiplicity.
The `P_1` case is exactly Legendre's conjecture.

| Year | Author(s) | Result | Evidence | Link |
|---:|---|---|---|---|
| 1920 | V. Brun | for all sufficiently large `n`, `(n²,(n+1)²)` contains a `P₁₁` | secondary-authoritative | cited in [Pintz's survey, DOI 10.5802/jtnb.676](https://doi.org/10.5802/jtnb.676) |
| 1975 | Chen Jing-Run | for all sufficiently large `n`, `(n²,(n+1)²)` contains a `P₂` | secondary-authoritative (as cited by Dudek–Johnston) | [DOI 10.1360/ya1975-18-5-611](https://doi.org/10.1360/ya1975-18-5-611) |
| 2026 | A. W. Dudek, D. R. Johnston | for **all** `n ≥ 1`, `(n²,(n+1)²)` contains a `P₄`; `P₃` for `n` up to about `1.4×10¹⁴` | primary-paper | [arXiv:2501.18048](https://arxiv.org/abs/2501.18048) · [DOI 10.1016/j.jnt.2025.05.009](https://doi.org/10.1016/j.jnt.2025.05.009) |

No published theorem gives `P₂` or `P₃` for **all** `n`.  The Lean file proves
only the exact logical equivalence `P₁ ↔ Legendre`
(`almostPrimeSquareAtMost_one_iff`); the deep `P₂`/`P₄` theorems are not
formalized.

## 5. Evidence levels used in this table

* `primary-paper`: the statement was read in the paper/abstract/publisher page.
* `secondary-authoritative`: the statement is reported by a peer-reviewed
  survey or a paper that cites the original; the original full text was not
  accessible open-access in this session.
* `inference`: a numerical or logical consequence derived here, explicitly
  labelled as such.

Items that could not be verified are **not** presented as theorems.  In
particular:

* there is no published verification “Legendre up to `n = 4×10¹⁸`”;
* the exact `925/348` and `577/925` constants are reported via Starichkova's
  paper, not read in Ingham's original;
* the `13/23` Heath-Brown–Iwaniec value currently has a single secondary
  source in this table.

## 6. Minimal bibliography

1. G. Hoheisel, *Primzahlprobleme in der Analysis*, Sitzungsber. Preuss. Akad.
   Wiss. Berlin (1930), 580–588.
2. A. E. Ingham, *On the difference between consecutive primes*, Quart. J.
   Math. Oxford **os-8** (1937), 255–266.
3. M. N. Huxley, *On the difference between consecutive primes*, Invent. Math.
   **15** (1972), 164–170.
4. D. R. Heath-Brown, H. Iwaniec, *On the difference between consecutive
   primes*, Invent. Math. **55** (1979), 49–69.
5. H. Iwaniec, J. Pintz, *Primes in short intervals*, Monatsh. Math. **98**
   (1984), 115–143.
6. C. J. Mozzochi, *On the difference between consecutive primes*, J. Number
   Theory **24** (1986), 181–187.
7. R. C. Baker, G. Harman, *The difference between consecutive primes*, Proc.
   London Math. Soc. (3) **72** (1996), 261–280.
8. R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive
   primes, II*, Proc. London Math. Soc. (3) **83** (2001), 532–562.
9. J. Sorenson, J. Webster, *An algorithm and computation to verify Legendre's
   conjecture up to 7·10¹³*, Res. Number Theory **11** (2025), Paper 4.
10. A. W. Dudek, D. R. Johnston, *Almost primes between all squares*,
    J. Number Theory **278** (2026), 726–745.
