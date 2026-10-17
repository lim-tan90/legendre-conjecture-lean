/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Basic
public import Mathlib.NumberTheory.Bertrand

/-!
# Bertrand's postulate as the historical elementary benchmark

Mathlib already contains a complete proof of Bertrand's postulate (1845/1852):

> for every `n ≠ 0` there is a prime `p` with `n < p ≤ 2n`.

We expose it here as a *verified* historical step.  The file also records the
elementary arithmetic fact that its gap scale is linear (`θ = 1`), hence far
above the square scale `θ = 1/2`.
-/

@[expose] public section

namespace Legendre

/-- Bertrand's postulate, in mathlib's form. -/
theorem bertrand (n : ℕ) (hn : n ≠ 0) :
    ∃ p : ℕ, p.Prime ∧ n < p ∧ p ≤ 2 * n :=
  Nat.exists_prime_lt_and_le_two_mul n hn

/-- Gap form of Bertrand: after every prime there is another prime no later
than twice it.  This is the `θ = 1` gap bound, in the sharpest elementary form. -/
theorem bertrand_gap_le (p : ℕ) (hp : p.Prime) :
    ∃ q : ℕ, q.Prime ∧ p < q ∧ q ≤ 2 * p := by
  simpa [mul_comm] using Nat.exists_prime_lt_and_le_two_mul p hp.ne_zero

/-- Bertrand's exponent is `1`, which is still far above the `1/2` needed at the
square scale. -/
theorem bertrand_exponent_above_half : (1 / 2 : ℝ) < 1 := by norm_num

/-- The square interval at `n` has length `2n + 1`, while a linear gap bound at
`p ≈ n^2` allows a gap of size `p ≈ n^2` (for `n ≥ 3`).  This is the elementary
reason why Bertrand's postulate does not reach Legendre's conjecture. -/
theorem square_interval_shorter_than_linear_gap (n : ℕ) (hn : 3 ≤ n) :
    2 * n + 1 < n ^ 2 + 1 := by
  nlinarith

end Legendre

end
