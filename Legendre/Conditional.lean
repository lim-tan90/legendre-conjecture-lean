/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Reduction
public import Mathlib.NumberTheory.AlmostPrime

/-!
# Literature statements and conditional consequences

This file records the exact shape of the published short-interval prime
results as Lean `Prop`s, and proves the *conditional* consequence:

> if some future result gives a prime-gap exponent `θ < 1/2`, then Legendre's
> conjecture holds for all sufficiently large `n`.

The published exponents themselves are **not proved here**.  They are opaque
`Prop`-valued definitions (`Hoheisel`, `Ingham58`, ...) so that no axiom and no
`sorry` is introduced.  The file also records the almost-prime (P_k) route and
its exact relation to Legendre at `k = 1`.
-/

@[expose] public section

namespace Legendre

open Filter
open scoped ArithmeticFunction.Omega

/-- A prime-gap exponent result: some constant `C > 0` bounds every sufficiently
large prime gap by `C * p^θ`. -/
def ShortIntervalExponent (θ : ℝ) : Prop :=
  ∃ C : ℝ, 0 < C ∧ EventuallyGapBound θ C

/-- The `+ε` form used by the analytic literature: the estimate holds at every
exponent strictly larger than `θ`.  This is weaker (and more faithful) than
claiming the endpoint exponent itself. -/
def ShortIntervalExponentLimit (θ : ℝ) : Prop :=
  ∀ ε : ℝ, 0 < ε → ShortIntervalExponent (θ + ε)

/-- The exact conditional reduction: a prime-gap exponent strictly below `1/2`
implies Legendre's conjecture for all sufficiently large `n`. -/
theorem legendre_eventually_of_shortIntervalExponent_lt_half
    {θ : ℝ} (hθ0 : 0 ≤ θ) (hθ : θ < 1 / 2) (h : ShortIntervalExponent θ) :
    ∀ᶠ n : ℕ in Filter.atTop, LegendreAt n := by
  obtain ⟨C, hC, hgap⟩ := h
  exact eventually_legendre_of_gap_exponent_lt_half hθ0 hθ hC hgap

/-- The same conditional reduction for the `+ε` form used in the literature:
if the *limit exponent* `θ` is `< 1/2`, choose a small `ε` with `θ + ε < 1/2`
and apply the previous theorem. -/
theorem legendre_eventually_of_shortIntervalExponentLimit_lt_half
    {θ : ℝ} (hθ0 : 0 ≤ θ) (hθ : θ < 1 / 2) (h : ShortIntervalExponentLimit θ) :
    ∀ᶠ n : ℕ in Filter.atTop, LegendreAt n := by
  let ε : ℝ := (1 / 2 - θ) / 2
  have hε : 0 < ε := by dsimp [ε]; linarith
  have hlt : θ + ε < 1 / 2 := by dsimp [ε]; linarith
  have hθ0' : 0 ≤ θ + ε := by linarith
  exact legendre_eventually_of_shortIntervalExponent_lt_half hθ0' hlt (h ε hε)

/-! ## Published unconditional exponents

Each definition is the precise statement “there is a constant `C > 0` such that
`p_{n+1} - p_n ≤ C p_n^θ` for all sufficiently large primes `p_n`”.  The
bibliographic data and proof mechanisms are in `docs/literature.md`. -/

/-- Hoheisel (1930): `θ = 1 - 1/33000 = 32999/33000` (in `+ε` form). -/
def Hoheisel : Prop := ShortIntervalExponentLimit (32999 / 33000)

/-- Ingham (1937), via the Lindelöf-type bound with `c = 1/6`: `θ = 5/8`
(in `+ε` form). -/
def Ingham58 : Prop := ShortIntervalExponentLimit (5 / 8)

/-- Ingham (1937), via his zero-density estimate: `θ = 577/925 + ε`. -/
def Ingham577 : Prop := ShortIntervalExponentLimit (577 / 925)

/-- Huxley (1972): `θ = 7/12 + ε`. -/
def Huxley : Prop := ShortIntervalExponentLimit (7 / 12)

/-- Heath-Brown--Iwaniec (1979), weighted zero-density: `θ = 13/23 + ε`. -/
def HeathBrownIwaniec : Prop := ShortIntervalExponentLimit (13 / 23)

/-- Iwaniec--Pintz (1984): `θ = 11/20 - 1/406 + ε`. -/
def IwaniecPintz : Prop := ShortIntervalExponentLimit (11 / 20 - 1 / 406)

/-- Mozzochi (1986): `θ = 11/20 - 1/384 + ε`. -/
def Mozzochi : Prop := ShortIntervalExponentLimit (11 / 20 - 1 / 384)

/-- Baker--Harman (1996): `θ = 0.535`. -/
def BakerHarman : Prop := ShortIntervalExponent (535 / 1000)

/-- Baker--Harman--Pintz (2001): `θ = 0.525`.  This is the current record for
*existence* of a prime in `[x - x^θ, x]`. -/
def BakerHarmanPintz : Prop := ShortIntervalExponent (525 / 1000)

/-! ## Arithmetic checks: every published exponent is still above `1/2`

These are small verified facts, not claims about the deep theorems.  They show
that the conditional reduction above cannot be applied to any published value. -/

theorem hoheisel_above_half : (1 / 2 : ℝ) < 32999 / 33000 := by norm_num

theorem ingham58_above_half : (1 / 2 : ℝ) < 5 / 8 := by norm_num

theorem ingham577_above_half : (1 / 2 : ℝ) < 577 / 925 := by norm_num

theorem huxley_above_half : (1 / 2 : ℝ) < 7 / 12 := by norm_num

theorem heathBrownIwaniec_above_half : (1 / 2 : ℝ) < 13 / 23 := by norm_num

theorem iwaniecPintz_above_half : (1 / 2 : ℝ) < 11 / 20 - 1 / 406 := by norm_num

theorem mozzochi_above_half : (1 / 2 : ℝ) < 11 / 20 - 1 / 384 := by norm_num

theorem bakerHarman_above_half : (1 / 2 : ℝ) < 535 / 1000 := by norm_num

theorem bakerHarmanPintz_above_half : (1 / 2 : ℝ) < 525 / 1000 := by norm_num

/-- The current record does not satisfy the hypothesis of the conditional
reduction.  This is only a statement about the *exponent*, not a claim that
Legendre's conjecture is false or unprovable by other means. -/
theorem bhp_exponent_not_below_half : ¬ (525 / 1000 : ℝ) < 1 / 2 := by norm_num

/-! ## Conditional inputs that are not exponent results -/

/-- The standard prime-gap bound implied by the Riemann Hypothesis:
`G(x) ≪ sqrt(x) log x`.  Stated abstractly; it is not proved here. -/
def RHGapBound : Prop :=
  ∃ C : ℝ, 0 < C ∧
    ∀ᶠ x : ℝ in Filter.atTop,
      ∃ p : ℕ, p.Prime ∧ x < p ∧ (p : ℝ) ≤ x + C * Real.sqrt x * Real.log x

/-- Cramér's conjecture: `G(x) = O((log x)^2)`.  Stated abstractly; it is not
proved here.  It is *sufficient* for Legendre at large `n`, unlike RH. -/
def CramerGapBound : Prop :=
  ∃ C : ℝ, 0 < C ∧
    ∀ᶠ p : ℕ in Filter.atTop,
      p.Prime → ∃ q : ℕ, q.Prime ∧ p < q ∧ (q - p : ℝ) ≤ C * (Real.log p) ^ 2

/-! ## The almost-prime route -/

/-- For every `n ≥ 1`, the open square interval contains a number with at most
`k` prime factors (counted with multiplicity).  `k = 1` is exactly Legendre. -/
def AlmostPrimeSquareAtMost (k : ℕ) : Prop :=
  ∀ n : ℕ, 0 < n →
    ∃ m : ℕ, n ^ 2 < m ∧ m < (n + 1) ^ 2 ∧ Nat.IsAtMostAlmostPrime k m

/-- Eventually version of `AlmostPrimeSquareAtMost`, matching the quantifier
shape of the published “for all sufficiently large n” almost-prime theorems. -/
def AlmostPrimeSquareEventually (k : ℕ) : Prop :=
  ∀ᶠ n : ℕ in Filter.atTop,
    ∃ m : ℕ, n ^ 2 < m ∧ m < (n + 1) ^ 2 ∧ Nat.IsAtMostAlmostPrime k m

/-- A number with at most one prime factor, larger than `1`, is prime. -/
theorem prime_of_isAtMostAlmostPrime_one {m : ℕ} (hm1 : m ≠ 1)
    (h : Nat.IsAtMostAlmostPrime 1 m) : m.Prime := by
  have homega : Ω m = 1 := by
    have hle : Ω m ≤ 1 := h.2
    have hne : Ω m ≠ 0 := by
      intro h0
      have hm : m = 0 ∨ m = 1 :=
        ArithmeticFunction.cardFactors_eq_zero_iff_eq_zero_or_one.mp h0
      rcases hm with hm0 | hm1'
      · exact (h.1 hm0).elim
      · exact (hm1 hm1').elim
    omega
  exact ArithmeticFunction.cardFactors_eq_one_iff_prime.mp homega

/-- The `P_1` almost-prime square statement is exactly Legendre's conjecture. -/
theorem conjecture_of_almostPrimeSquareAtMost_one
    (h : AlmostPrimeSquareAtMost 1) : Conjecture := by
  intro n hn
  obtain ⟨m, hm_lo, hm_hi, hap⟩ := h n hn
  have hm_ne_one : m ≠ 1 := by
    have : 1 ≤ n ^ 2 := by nlinarith
    omega
  exact ⟨m, prime_of_isAtMostAlmostPrime_one hm_ne_one hap, hm_lo, hm_hi⟩

/-- Conversely, Legendre's conjecture gives the `P_1` almost-prime statement. -/
theorem almostPrimeSquareAtMost_one_of_conjecture
    (h : Conjecture) : AlmostPrimeSquareAtMost 1 := by
  intro n hn
  obtain ⟨p, hp, hlo, hhi⟩ := h n hn
  exact ⟨p, hlo, hhi, hp.isAlmostPrime_one.isAtMost (by norm_num)⟩

/-- Exact equivalence: the `P_1` case of the almost-prime square problem is
Legendre's conjecture. -/
theorem almostPrimeSquareAtMost_one_iff :
    AlmostPrimeSquareAtMost 1 ↔ Conjecture :=
  ⟨conjecture_of_almostPrimeSquareAtMost_one,
    almostPrimeSquareAtMost_one_of_conjecture⟩

end Legendre

end
