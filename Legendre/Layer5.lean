/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Conditional
public import Legendre.ExplicitBounds
public import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
public import Mathlib.Tactic

/-!
# Layer 5: statement-level short-interval prime theorems

This module implements the “Statement-level Layer 5” milestone of
`docs/formalization-roadmap.md`: the published short-interval prime results are
encoded with the **exact quantifier shape of the literature**, namely

* a `+ε` convention: the result holds at every exponent strictly larger than
  the quoted exponent `θ`;
* an explicit constant convention: the interval length is `x ^ (θ + ε)` with
  constant `1` for the `+ε` results, while the gap bounds of Baker--Harman and
  Baker--Harman--Pintz carry an explicit `C > 0`;
* an explicit “sufficiently large” threshold, encoded as an existential bound
  `∃ X, 1 ≤ X, ∀ x ≥ X, ...` (respectively `∃ P, ∀ p ≥ P, ...`).

Nothing deep is proved here: the per-paper declarations
`HoheiselPaper`, ..., `BakerHarmanPintzPaper` are **definitions of `Prop`s**,
not theorems.  What *is* proved is the statement-level infrastructure:

* the two conventions (interval and gap) are equivalent
  (`hasPrimeInShortInterval_iff_primeGapBound`);
* the paper-exact statements are equivalent to the coarser `Prop`s of
  `Legendre/Conditional.lean` (`hoheiselPaper_iff_hoheisel`, ...);
* the precise statements feed the verified conditional reduction
  (`legendre_eventually_of_shortIntervalStatement_lt_half`).

No `sorry`, `axiom`, `constant`, `opaque`, `unsafe`, `False.elim` or `absurd`
is used.

## References

The bibliographic data (DOIs, evidence levels) is in `docs/literature.md`.
-/

@[expose] public section

namespace Legendre

open Filter

/-! ## Interval form and gap form, with explicit constants and thresholds -/

/-- `HasPrimeInShortInterval θ C` is the constant-explicit interval form of a
short-interval prime theorem: there is a real threshold `X ≥ 1` such that for
every real `x ≥ X` the interval `(x, x + C * x^θ]` contains a prime.

The interval is half-open on the left and closed on the right, matching the
convention of `Legendre.HasPrimeIn`. -/
def HasPrimeInShortInterval (θ C : ℝ) : Prop :=
  ∃ X : ℝ, 1 ≤ X ∧ ∀ x : ℝ, X ≤ x → HasPrimeIn x (C * x ^ θ)

/-- `ShortIntervalStatement θ` is the paper-exact `+ε` form of a short-interval
prime theorem with constant `1`: for every `ε > 0`, every sufficiently large
real `x` has a prime in `(x, x + x ^ (θ + ε)]`.

This is the quantifier shape used by Hoheisel (1930), Ingham (1937),
Huxley (1972), Heath-Brown--Iwaniec (1979), Iwaniec--Pintz (1984) and
Mozzochi (1986). -/
def ShortIntervalStatement (θ : ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → HasPrimeInShortInterval (θ + ε) 1

/-- `PrimeGapBound θ C` is the constant-explicit form of a prime-gap bound:
there is a threshold `P` such that every prime `p ≥ P` is followed by a prime
`q` with `q - p ≤ C * p^θ`.

This is the quantifier shape used by Baker--Harman (1996) and
Baker--Harman--Pintz (2001). -/
def PrimeGapBound (θ C : ℝ) : Prop :=
  ∃ P : ℕ, ∀ p : ℕ, P ≤ p → p.Prime →
    ∃ q : ℕ, q.Prime ∧ p < q ∧ (q - p : ℝ) ≤ C * (p : ℝ) ^ θ

/-- The explicit-threshold gap form and the eventually form used as the
conditional interface in `Legendre/Conditional.lean` are the same statement. -/
theorem primeGapBound_iff_eventuallyGapBound (θ C : ℝ) :
    PrimeGapBound θ C ↔ EventuallyGapBound θ C := by
  constructor
  · rintro ⟨P, hP⟩
    exact Filter.eventually_atTop.2 ⟨P, fun p hp hprime => hP p hp hprime⟩
  · rintro h
    obtain ⟨P, hP⟩ := Filter.eventually_atTop.1 h
    exact ⟨P, fun p hp hprime => hP p hp hprime⟩

/-- An interval statement implies the corresponding gap bound, with the same
constant and exponent. -/
theorem primeGapBound_of_hasPrimeInShortInterval {θ C : ℝ}
    (h : HasPrimeInShortInterval θ C) : PrimeGapBound θ C := by
  obtain ⟨X, _hX1, hX⟩ := h
  obtain ⟨P, hP⟩ := exists_nat_ge X
  refine ⟨max P 2, ?_⟩
  intro p hp _hp_prime
  have hpX : X ≤ (p : ℝ) :=
    le_trans hP (by exact_mod_cast le_trans (le_max_left P 2) hp)
  obtain ⟨q, hq_prime, hpq, hpq_le⟩ := hX (p : ℝ) hpX
  refine ⟨q, hq_prime, ?_, ?_⟩
  · exact_mod_cast hpq
  · linarith

/-- A gap bound implies the corresponding interval statement, with the same
constant and exponent, provided `θ ≥ 0` and `C ≥ 0`.

The proof takes `p` to be the greatest prime at most `x` and `q` the prime
supplied by the gap bound.  Maximality of `p` forces `q > x`, and the gap bound
gives `q ≤ x + C x^θ`. -/
theorem hasPrimeInShortInterval_of_primeGapBound {θ C : ℝ} (hθ : 0 ≤ θ)
    (hC : 0 ≤ C) (h : PrimeGapBound θ C) : HasPrimeInShortInterval θ C := by
  obtain ⟨P, hP⟩ := h
  refine ⟨max 1 ((2 * P + 2 : ℕ) : ℝ), le_max_left _ _, ?_⟩
  intro x hx
  have hx1 : 1 ≤ x := le_trans (le_max_left _ _) hx
  have hxP : ((2 * P + 2 : ℕ) : ℝ) ≤ x := le_trans (le_max_right _ _) hx
  let n : ℕ := ⌊x⌋₊
  have hnP : 2 * P + 2 ≤ n := Nat.le_floor hxP
  have hn2 : 2 ≤ n := by omega
  let p : ℕ := Nat.findGreatest (fun k : ℕ => k.Prime) n
  have hp_prime : p.Prime :=
    Nat.findGreatest_spec (P := fun k : ℕ => k.Prime) hn2 Nat.prime_two
  have hp_le_n : p ≤ n := Nat.findGreatest_le _
  have hp_max : ∀ q : ℕ, q.Prime → q ≤ n → q ≤ p :=
    fun q hq hqn => Nat.le_findGreatest hqn hq
  have hPp : P ≤ p := by
    have hhalfpos : 0 < n / 2 := by omega
    obtain ⟨r, hr_prime, hr_gt, hr_le⟩ :=
      Nat.exists_prime_lt_and_le_two_mul (n / 2) (by omega)
    have hr_le_n : r ≤ n := by
      have h2 : 2 * (n / 2) ≤ n := by
        simpa [mul_comm] using Nat.div_mul_le_self n 2
      omega
    have hr_le_p : r ≤ p := hp_max r hr_prime hr_le_n
    omega
  obtain ⟨q, hq_prime, hpq, hgap⟩ := hP p hPp hp_prime
  have hq_gt_x : x < (q : ℝ) := by
    by_contra hnot
    have hqx : (q : ℝ) ≤ x := le_of_not_gt hnot
    have hq_le_n : q ≤ n := Nat.le_floor hqx
    have hq_le_p : q ≤ p := hp_max q hq_prime hq_le_n
    omega
  have hp_le_x : (p : ℝ) ≤ x := by
    have := Nat.floor_le (show (0 : ℝ) ≤ x by linarith)
    simp only [n] at hp_le_n
    exact le_trans (by exact_mod_cast hp_le_n) this
  have hCpow : C * (p : ℝ) ^ θ ≤ C * x ^ θ := by
    have hpnn : (0 : ℝ) ≤ (p : ℝ) := by positivity
    exact mul_le_mul_of_nonneg_left (Real.rpow_le_rpow hpnn hp_le_x hθ) hC
  refine ⟨q, hq_prime, hq_gt_x, ?_⟩
  linarith

/-- Under `θ ≥ 0` and `C ≥ 0`, the interval and gap formulations are
equivalent with the same exponent and constant. -/
theorem hasPrimeInShortInterval_iff_primeGapBound {θ C : ℝ} (hθ : 0 ≤ θ)
    (hC : 0 ≤ C) : HasPrimeInShortInterval θ C ↔ PrimeGapBound θ C :=
  ⟨primeGapBound_of_hasPrimeInShortInterval,
    hasPrimeInShortInterval_of_primeGapBound hθ hC⟩

/-- Monotonicity of the interval statement in the exponent, with the same
constant. -/
theorem hasPrimeInShortInterval_mono {θ θ' C : ℝ} (hθ : θ ≤ θ') (hC : 0 ≤ C)
    (h : HasPrimeInShortInterval θ C) : HasPrimeInShortInterval θ' C := by
  obtain ⟨X, hX1, hX⟩ := h
  refine ⟨X, hX1, ?_⟩
  intro x hx
  obtain ⟨p, hp, hxp, hpx⟩ := hX x hx
  refine ⟨p, hp, hxp, le_trans hpx ?_⟩
  have hx1 : 1 ≤ x := le_trans hX1 hx
  have hpow : x ^ θ ≤ x ^ θ' := Real.rpow_le_rpow_of_exponent_le hx1 hθ
  have := mul_le_mul_of_nonneg_left hpow hC
  linarith

/-- Monotonicity of the `+ε` statement in the exponent. -/
theorem shortIntervalStatement_mono {θ θ' : ℝ} (hθ : θ ≤ θ')
    (h : ShortIntervalStatement θ) : ShortIntervalStatement θ' := by
  intro ε hε
  have hε' : 0 < ε + (θ' - θ) := by linarith
  have h' := h (ε + (θ' - θ)) hε'
  have heq : θ + (ε + (θ' - θ)) = θ' + ε := by ring
  simpa [heq] using h'

/-! ## The `+ε` statement and the coarse conditional interface are equivalent -/

/-- A paper-exact `+ε` interval statement implies the coarse exponent-limit
statement used by the conditional reduction. -/
theorem shortIntervalExponentLimit_of_statement {θ : ℝ}
    (h : ShortIntervalStatement θ) : ShortIntervalExponentLimit θ := by
  intro ε hε
  obtain ⟨X, hX1, hX⟩ := h (ε / 2) (by linarith)
  obtain ⟨P, hP⟩ :=
    primeGapBound_of_hasPrimeInShortInterval (θ := θ + ε / 2) (C := 1) ⟨X, hX1, hX⟩
  refine ⟨1, one_pos, Filter.eventually_atTop.2 ⟨max P 2, ?_⟩⟩
  intro p hp hprime
  obtain ⟨q, hq, hpq, hgap⟩ := hP p (le_trans (le_max_left P 2) hp) hprime
  refine ⟨q, hq, hpq, ?_⟩
  have hp2 : (2 : ℝ) ≤ (p : ℝ) := by
    exact_mod_cast le_trans (le_max_right P 2) hp
  have hpow : (p : ℝ) ^ (θ + ε / 2) ≤ (p : ℝ) ^ (θ + ε) :=
    Real.rpow_le_rpow_of_exponent_le (by linarith) (by linarith)
  calc
    (q - p : ℝ) ≤ 1 * (p : ℝ) ^ (θ + ε / 2) := hgap
    _ = (p : ℝ) ^ (θ + ε / 2) := by ring
    _ ≤ (p : ℝ) ^ (θ + ε) := hpow
    _ = 1 * (p : ℝ) ^ (θ + ε) := by ring

/-- Conversely, the coarse exponent-limit statement implies the paper-exact
`+ε` interval statement, for `θ ≥ 0`.  The constant of the gap bound is
absorbed into the `+ε` slack. -/
theorem statement_of_shortIntervalExponentLimit {θ : ℝ} (hθ : 0 ≤ θ)
    (h : ShortIntervalExponentLimit θ) : ShortIntervalStatement θ := by
  intro ε hε
  obtain ⟨C, hC, hgap⟩ := h (ε / 2) (by linarith)
  have hgap' : PrimeGapBound (θ + ε / 2) C :=
    (primeGapBound_iff_eventuallyGapBound (θ + ε / 2) C).2 hgap
  have hθ' : 0 ≤ θ + ε / 2 := by linarith
  obtain ⟨X, hX1, hX⟩ := hasPrimeInShortInterval_of_primeGapBound hθ' hC.le hgap'
  have htend : Tendsto (fun x : ℝ => x ^ (ε / 2)) atTop atTop :=
    tendsto_rpow_atTop (by linarith)
  have hev : ∀ᶠ x : ℝ in atTop, C ≤ x ^ (ε / 2) :=
    htend.eventually_ge_atTop C
  obtain ⟨Y, hY⟩ := Filter.eventually_atTop.1 hev
  refine ⟨max X Y, le_trans hX1 (le_max_left _ _), ?_⟩
  intro x hx
  have hxX : X ≤ x := le_trans (le_max_left _ _) hx
  have hxY : Y ≤ x := le_trans (le_max_right _ _) hx
  obtain ⟨p, hp, hxp, hpx⟩ := hX x hxX
  have hx1 : 1 ≤ x := le_trans hX1 hxX
  have hxpos : 0 < x := by linarith
  have hCx : C ≤ x ^ (ε / 2) := hY x hxY
  have hxpow_nonneg : (0 : ℝ) ≤ x ^ (θ + ε / 2) :=
    Real.rpow_nonneg (le_of_lt hxpos) _
  have habsorb : C * x ^ (θ + ε / 2) ≤ x ^ (θ + ε / 2) * x ^ (ε / 2) := by
    calc
      C * x ^ (θ + ε / 2) ≤ x ^ (ε / 2) * x ^ (θ + ε / 2) :=
        mul_le_mul_of_nonneg_right hCx hxpow_nonneg
      _ = x ^ (θ + ε / 2) * x ^ (ε / 2) := by ring
  have hxpow : x ^ (θ + ε / 2) * x ^ (ε / 2) = x ^ (θ + ε) := by
    rw [← Real.rpow_add hxpos]
    congr 1
    ring
  refine ⟨p, hp, hxp, ?_⟩
  calc
    (p : ℝ) ≤ x + C * x ^ (θ + ε / 2) := hpx
    _ ≤ x + x ^ (θ + ε / 2) * x ^ (ε / 2) := by linarith
    _ = x + x ^ (θ + ε) := by rw [hxpow]
    _ = x + 1 * x ^ (θ + ε) := by ring

/-- The paper-exact `+ε` statement and the coarse exponent-limit interface are
equivalent for `θ ≥ 0`. -/
theorem shortIntervalStatement_iff_exponentLimit {θ : ℝ} (hθ : 0 ≤ θ) :
    ShortIntervalStatement θ ↔ ShortIntervalExponentLimit θ :=
  ⟨shortIntervalExponentLimit_of_statement,
    statement_of_shortIntervalExponentLimit hθ⟩

/-- The precise statement-level form of the conditional reduction: any
short-interval result with exponent `θ < 1/2` implies Legendre's conjecture for
all sufficiently large `n`. -/
theorem legendre_eventually_of_shortIntervalStatement_lt_half {θ : ℝ}
    (hθ0 : 0 ≤ θ) (hθ : θ < 1 / 2) (h : ShortIntervalStatement θ) :
    ∀ᶠ n : ℕ in Filter.atTop, LegendreAt n := by
  let ε : ℝ := (1 / 2 - θ) / 2
  have hε : 0 < ε := by dsimp [ε]; linarith
  have hlt : θ + ε < 1 / 2 := by dsimp [ε]; linarith
  have hθ' : 0 ≤ θ + ε := by linarith
  obtain ⟨X, hX1, hX⟩ := h ε hε
  have hgap : EventuallyGapBound (θ + ε) 1 :=
    (primeGapBound_iff_eventuallyGapBound (θ + ε) 1).1
      (primeGapBound_of_hasPrimeInShortInterval ⟨X, hX1, hX⟩)
  exact eventually_legendre_of_gap_exponent_lt_half hθ' hlt one_pos hgap

/-! ## The published statements, in the exact conventions of the papers

Each declaration below is a `Prop` definition, *not* a theorem: the deep
analytic proofs are not formalized.  The `..._iff_...` theorems prove that each
paper-exact statement is equivalent to the corresponding coarse `Prop` in
`Legendre/Conditional.lean`. -/

/-- Hoheisel (1930): for every `ε > 0`, every sufficiently large real `x` has a
prime in `(x, x ^ (32999/33000 + ε)]`.

Paper: G. Hoheisel, *Primzahlprobleme in der Analysis*, Sitzungsber. Preuss.
Akad. Wiss. Berlin (1930), 580--588. -/
def HoheiselPaper : Prop := ShortIntervalStatement (32999 / 33000)

/-- Hoheisel's paper-exact statement is equivalent to the coarse `Prop`
`Legendre.Hoheisel`. -/
theorem hoheiselPaper_iff : HoheiselPaper ↔ Hoheisel := by
  simpa [HoheiselPaper, Hoheisel] using
    (shortIntervalStatement_iff_exponentLimit (θ := 32999 / 33000) (by norm_num))

/-- Ingham (1937), Lindelöf route: for every `ε > 0`, every sufficiently large
real `x` has a prime in `(x, x ^ (5/8 + ε)]`.

Paper: A. E. Ingham, *On the difference between consecutive primes*, Quart. J.
Math. Oxford **os-8** (1937), 255--266. -/
def Ingham58Paper : Prop := ShortIntervalStatement (5 / 8)

/-- Ingham's `5/8` statement is equivalent to the coarse `Prop`
`Legendre.Ingham58`. -/
theorem ingham58Paper_iff : Ingham58Paper ↔ Ingham58 := by
  simpa [Ingham58Paper, Ingham58] using
    (shortIntervalStatement_iff_exponentLimit (θ := 5 / 8) (by norm_num))

/-- Ingham (1937), zero-density route: for every `ε > 0`, every sufficiently
large real `x` has a prime in `(x, x ^ (577/925 + ε)]`.

Paper: same as `Ingham58Paper`; the value is reported via N. Starichkova,
arXiv:2411.01845. -/
def Ingham577Paper : Prop := ShortIntervalStatement (577 / 925)

/-- Ingham's `577/925` statement is equivalent to the coarse `Prop`
`Legendre.Ingham577`. -/
theorem ingham577Paper_iff : Ingham577Paper ↔ Ingham577 := by
  simpa [Ingham577Paper, Ingham577] using
    (shortIntervalStatement_iff_exponentLimit (θ := 577 / 925) (by norm_num))

/-- Huxley (1972): for every `ε > 0`, every sufficiently large real `x` has a
prime in `(x, x ^ (7/12 + ε)]`.

Paper: M. N. Huxley, *On the difference between consecutive primes*,
Invent. Math. **15** (1972), 164--170. -/
def HuxleyPaper : Prop := ShortIntervalStatement (7 / 12)

/-- Huxley's statement is equivalent to the coarse `Prop` `Legendre.Huxley`. -/
theorem huxleyPaper_iff : HuxleyPaper ↔ Huxley := by
  simpa [HuxleyPaper, Huxley] using
    (shortIntervalStatement_iff_exponentLimit (θ := 7 / 12) (by norm_num))

/-- Heath-Brown--Iwaniec (1979): for every `ε > 0`, every sufficiently large
real `x` has a prime in `(x, x ^ (13/23 + ε)]`.

Paper: D. R. Heath-Brown, H. Iwaniec, *On the difference between consecutive
primes*, Invent. Math. **55** (1979), 49--69. -/
def HeathBrownIwaniecPaper : Prop := ShortIntervalStatement (13 / 23)

/-- Heath-Brown--Iwaniec's statement is equivalent to the coarse `Prop`
`Legendre.HeathBrownIwaniec`. -/
theorem heathBrownIwaniecPaper_iff : HeathBrownIwaniecPaper ↔ HeathBrownIwaniec := by
  simpa [HeathBrownIwaniecPaper, HeathBrownIwaniec] using
    (shortIntervalStatement_iff_exponentLimit (θ := 13 / 23) (by norm_num))

/-- Iwaniec--Pintz (1984): for every `ε > 0`, every sufficiently large real `x`
has a prime in `(x, x ^ (11/20 - 1/406 + ε)]`.

Paper: H. Iwaniec, J. Pintz, *Primes in short intervals*, Monatsh. Math.
**98** (1984), 115--143. -/
def IwaniecPintzPaper : Prop := ShortIntervalStatement (11 / 20 - 1 / 406)

/-- Iwaniec--Pintz's statement is equivalent to the coarse `Prop`
`Legendre.IwaniecPintz`. -/
theorem iwaniecPintzPaper_iff : IwaniecPintzPaper ↔ IwaniecPintz := by
  simpa [IwaniecPintzPaper, IwaniecPintz] using
    (shortIntervalStatement_iff_exponentLimit (θ := 11 / 20 - 1 / 406) (by norm_num))

/-- Mozzochi (1986): for every `ε > 0`, every sufficiently large real `x` has a
prime in `(x, x ^ (11/20 - 1/384 + ε)]`.

Paper: C. J. Mozzochi, *On the difference between consecutive primes*,
J. Number Theory **24** (1986), 181--187. -/
def MozzochiPaper : Prop := ShortIntervalStatement (11 / 20 - 1 / 384)

/-- Mozzochi's statement is equivalent to the coarse `Prop`
`Legendre.Mozzochi`. -/
theorem mozzochiPaper_iff : MozzochiPaper ↔ Mozzochi := by
  simpa [MozzochiPaper, Mozzochi] using
    (shortIntervalStatement_iff_exponentLimit (θ := 11 / 20 - 1 / 384) (by norm_num))

/-- Baker--Harman (1996): there is an explicit constant `C > 0` and a threshold
`P` such that every prime `p ≥ P` is followed by a prime `q` with
`q - p ≤ C p^(0.535)`.

Paper: R. C. Baker, G. Harman, *The difference between consecutive primes*,
Proc. London Math. Soc. (3) **72** (1996), 261--280. -/
def BakerHarmanPaper : Prop :=
  ∃ C : ℝ, 0 < C ∧ PrimeGapBound (535 / 1000) C

/-- Baker--Harman's paper-exact statement is equivalent to the coarse `Prop`
`Legendre.BakerHarman`. -/
theorem bakerHarmanPaper_iff : BakerHarmanPaper ↔ BakerHarman := by
  simp only [BakerHarmanPaper, BakerHarman, ShortIntervalExponent,
    primeGapBound_iff_eventuallyGapBound]

/-- Baker--Harman--Pintz (2001): there is an explicit constant `C > 0` and a
threshold `P` such that every prime `p ≥ P` is followed by a prime `q` with
`q - p ≤ C p^(0.525)`.  This is the current record for the prime-gap exponent.

Paper: R. C. Baker, G. Harman, J. Pintz, *The difference between consecutive
primes, II*, Proc. London Math. Soc. (3) **83** (2001), 532--562. -/
def BakerHarmanPintzPaper : Prop :=
  ∃ C : ℝ, 0 < C ∧ PrimeGapBound (525 / 1000) C

/-- Baker--Harman--Pintz's paper-exact statement is equivalent to the coarse
`Prop` `Legendre.BakerHarmanPintz`. -/
theorem bakerHarmanPintzPaper_iff : BakerHarmanPintzPaper ↔ BakerHarmanPintz := by
  simp only [BakerHarmanPintzPaper, BakerHarmanPintz, ShortIntervalExponent,
    primeGapBound_iff_eventuallyGapBound]

end Legendre

end
