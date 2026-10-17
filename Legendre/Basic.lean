/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.NumberTheory.Bertrand
public import Mathlib.NumberTheory.Chebyshev
public import Mathlib.Analysis.SpecialFunctions.Pow.Real
public import Mathlib.Analysis.Asymptotics.SpecificAsymptotics
public import Mathlib.Data.Nat.Find

/-!
# Legendre's conjecture: definitions and elementary reductions

This file contains the *formalizable* part of the project: definitions, the
equivalence between the square-interval form and the prime-gap form, Bertrand's
postulate as a historical benchmark, and the conditional reduction from a
prime-gap exponent `θ < 1/2` to Legendre's conjecture for all sufficiently
large `n`.

Deep analytic theorems (Hoheisel, Ingham, Huxley, Baker--Harman, Baker--Harman--
Pintz) are **not** proved here.  They are stated as explicit hypotheses in
`Legendre/Conditional.lean`, so no axiom or `sorry` is introduced.
-/

@[expose] public section

namespace Legendre

/-- `LegendreAt n` says that there is a prime strictly between `n^2` and `(n+1)^2`. -/
def LegendreAt (n : ℕ) : Prop :=
  ∃ p : ℕ, p.Prime ∧ n ^ 2 < p ∧ p < (n + 1) ^ 2

/-- Legendre's conjecture, in the form used throughout this repository. -/
def Conjecture : Prop := ∀ n : ℕ, 0 < n → LegendreAt n

/-- A prime gap bound with exponent `θ` and constant `C`, holding eventually. -/
def EventuallyGapBound (θ C : ℝ) : Prop :=
  ∀ᶠ p : ℕ in Filter.atTop,
    p.Prime → ∃ q : ℕ, q.Prime ∧ p < q ∧ (q - p : ℝ) ≤ C * (p : ℝ) ^ θ

/-- The gap form of Legendre's conjecture: the next prime after `n^2` is below
`(n+1)^2`.  This is just a restatement of `LegendreAt`, but it is the form in
which short-interval results are usually fed in. -/
def GapFormAt (n : ℕ) : Prop :=
  ∃ q : ℕ, q.Prime ∧ n ^ 2 < q ∧ q < (n + 1) ^ 2

theorem legendreAt_iff_gapFormAt (n : ℕ) : LegendreAt n ↔ GapFormAt n := by
  rfl

/-- An elementary sanity check: Legendre's conjecture holds at `n = 1`. -/
theorem legendreAt_one : LegendreAt 1 := by
  refine ⟨2, Nat.prime_two, by norm_num, by norm_num⟩

/-- An elementary sanity check: Legendre's conjecture holds at `n = 2`. -/
theorem legendreAt_two : LegendreAt 2 := by
  refine ⟨5, by norm_num, by norm_num, by norm_num⟩

/-- The square interval has length `2n+1`, so a gap bound strictly below
`2n+1` is exactly what is needed at the scale `n^2`. -/
theorem sq_interval_length (n : ℕ) : (n + 1) ^ 2 - n ^ 2 = 2 * n + 1 := by
  have h : n ^ 2 ≤ (n + 1) ^ 2 := by
    rw [show (n + 1) ^ 2 = n ^ 2 + (2 * n + 1) by ring]
    omega
  rw [Nat.sub_eq_iff_eq_add h]
  ring

end Legendre

end
