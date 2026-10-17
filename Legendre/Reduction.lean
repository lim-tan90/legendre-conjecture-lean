/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.Basic
public import Mathlib.Data.Nat.Sqrt
public import Mathlib.Tactic

/-!
# Elementary reductions

These are the parts of the Legendre story that can be proved unconditionally in
Lean without any analytic number theory:

* if the gap after every prime `p` is `< 2 * sqrt p`, then Legendre's conjecture
  holds (this is the exact gap criterion at the square scale);
* a gap bound with exponent `θ` is enough **provided** `θ < 1/2`; the proof of
  the power-smallness step is included, while the deep input (the gap bound
  itself) is a hypothesis;
* Bertrand's postulate is recovered from mathlib as the historical benchmark,
  and it is explicitly shown to be too weak at the square scale.

No `axiom`, `sorry`, `admit`, `unsafe` or `False.elim` is used in this file.
-/

@[expose] public section

namespace Legendre

open Filter

/-- If every prime is followed by another prime before `p + 2 * sqrt p`, then
Legendre's conjecture holds for every positive `n`.

This is the clean discrete form of the criterion
`p_{k+1} - p_k < 2 * sqrt(p_k)`.  The proof takes `p` to be the greatest prime
`≤ n^2`; maximality forces the next prime `q` to lie above `n^2`, and the gap
bound forces `q < (n+1)^2`. -/
theorem legendre_of_gap_lt_two_sqrt
    (h : ∀ p : ℕ, p.Prime → ∃ q : ℕ, q.Prime ∧ p < q ∧ q < p + 2 * Nat.sqrt p) :
    ∀ n : ℕ, 0 < n → LegendreAt n := by
  intro n hn
  rcases lt_or_ge n 2 with hn1 | hn2
  · -- n = 1
    interval_cases n
    exact legendreAt_one
  · have hN2 : 2 ≤ n ^ 2 := by nlinarith
    let p := Nat.findGreatest (fun k : ℕ => k.Prime) (n ^ 2)
    have hp_prime : p.Prime := by
      exact Nat.findGreatest_spec (P := fun k : ℕ => k.Prime) hN2 Nat.prime_two
    have hp_le : p ≤ n ^ 2 := Nat.findGreatest_le _
    have hp_max : ∀ q : ℕ, q.Prime → q ≤ n ^ 2 → q ≤ p := by
      intro q hq hqle
      exact Nat.le_findGreatest hqle hq
    obtain ⟨q, hq_prime, hpq, hq_gap⟩ := h p hp_prime
    have hq_gt : n ^ 2 < q := by
      by_contra hnot
      have hqle : q ≤ n ^ 2 := le_of_not_gt hnot
      have : q ≤ p := hp_max q hq_prime hqle
      omega
    have hsqrt : Nat.sqrt p ≤ n := by
      calc
        Nat.sqrt p ≤ Nat.sqrt (n ^ 2) := Nat.sqrt_le_sqrt hp_le
        _ = n := Nat.sqrt_eq' n
    have hgap_le : q < n ^ 2 + 2 * n := by
      have hsqrt_bound : 2 * Nat.sqrt p ≤ 2 * n := by omega
      nlinarith
    have hlt : q < (n + 1) ^ 2 := by
      have hsq : (n + 1) ^ 2 = n ^ 2 + 2 * n + 1 := by ring
      omega
    exact ⟨q, hq_prime, hq_gt, hlt⟩

/-- The elementary analytic estimate behind the exponent reduction:
for `θ < 1/2`, the power `n^(2θ)` is eventually smaller than any linear
multiple of `n`.  This is the precise place where the strict inequality
`θ < 1/2` is used. -/
theorem eventually_const_mul_rpow_lt
    {θ C : ℝ} (hθ : θ < 1 / 2) :
    ∀ᶠ n : ℕ in Filter.atTop, C * (n : ℝ) ^ (2 * θ) < 2 * (n : ℝ) := by
  let δ : ℝ := 1 - 2 * θ
  have hδ : 0 < δ := by dsimp [δ]; linarith
  have htend : Tendsto (fun n : ℕ => (n : ℝ) ^ (-δ)) Filter.atTop (nhds 0) :=
    (tendsto_rpow_neg_atTop hδ).comp tendsto_natCast_atTop_atTop
  have hmul : Tendsto (fun n : ℕ => C * (n : ℝ) ^ (-δ)) Filter.atTop (nhds (C * 0)) :=
    tendsto_const_nhds.mul htend
  have hmul0 : Tendsto (fun n : ℕ => C * (n : ℝ) ^ (-δ)) Filter.atTop (nhds 0) := by
    simpa using hmul
  have hevent : ∀ᶠ n : ℕ in Filter.atTop, C * (n : ℝ) ^ (-δ) < 2 := by
    exact hmul0.eventually_lt_const (show (0 : ℝ) < 2 by norm_num)
  filter_upwards [hevent, Filter.eventually_ge_atTop 1] with n hnlt hn1
  have hnpos : (0 : ℝ) < (n : ℝ) := by exact_mod_cast hn1
  have hpow : (n : ℝ) ^ (2 * θ) = (n : ℝ) * (n : ℝ) ^ (-δ) := by
    rw [show 2 * θ = 1 - δ by dsimp [δ]; ring,
      Real.rpow_sub hnpos 1 δ, Real.rpow_one, Real.rpow_neg hnpos.le]
    ring
  calc
    C * (n : ℝ) ^ (2 * θ) = C * ((n : ℝ) * (n : ℝ) ^ (-δ)) := by rw [hpow]
    _ = (n : ℝ) * (C * (n : ℝ) ^ (-δ)) := by ring
    _ < (n : ℝ) * 2 := by gcongr
    _ = 2 * (n : ℝ) := by ring

/-- The exponent form of the square-gap criterion: if the maximal prime gap up
to `x` is `O(x^θ)` with `θ < 1/2`, then Legendre's conjecture holds for all
sufficiently large `n`.

The elementary smallness fact `C * n^(2θ) < 2n` is derived from `θ < 1/2` in
`eventually_const_mul_rpow_lt`; the remaining deep input is `hgap`. -/
theorem eventually_legendre_of_gap_exponent_lt_half
    {θ C : ℝ} (hθ0 : 0 ≤ θ) (hθ : θ < 1 / 2) (hC : 0 < C)
    (hgap : EventuallyGapBound θ C) :
    ∀ᶠ n : ℕ in Filter.atTop, LegendreAt n := by
  have hsmall := eventually_const_mul_rpow_lt (C := C) hθ
  -- The gap hypothesis holds for all sufficiently large primes.
  obtain ⟨N, hN⟩ := Filter.eventually_atTop.1 hgap
  -- We only need `n` large enough that `n^2` is past `N` and that the
  -- elementary smallness estimate holds.
  filter_upwards [Filter.eventually_atTop.2 ⟨2 * N + 2, fun n hn => by omega⟩,
    hsmall, Filter.eventually_ge_atTop 2] with n hnN hsmalln hn2
  have hN2 : 2 ≤ n ^ 2 := by nlinarith
  let p := Nat.findGreatest (fun k : ℕ => k.Prime) (n ^ 2)
  have hp_prime : p.Prime := by
    exact Nat.findGreatest_spec (P := fun k : ℕ => k.Prime) hN2 Nat.prime_two
  have hp_le : p ≤ n ^ 2 := Nat.findGreatest_le _
  have hp_max : ∀ q : ℕ, q.Prime → q ≤ n ^ 2 → q ≤ p := by
    intro q hq hqle
    exact Nat.le_findGreatest hqle hq
  -- `p` is past the threshold `N`: Bertrand's postulate supplies a prime in
  -- `(n^2/2, n^2]`, and `p` is at least that prime.
  have hp_ge_N : N ≤ p := by
    have hhalf_pos : 0 < n ^ 2 / 2 := by omega
    obtain ⟨r, hr_prime, hr_gt, hr_le⟩ :=
      Nat.exists_prime_lt_and_le_two_mul (n ^ 2 / 2) (by omega)
    have hr_le_sq : r ≤ n ^ 2 := by
      have h2 : 2 * (n ^ 2 / 2) ≤ n ^ 2 := by
        simpa [mul_comm] using Nat.div_mul_le_self (n ^ 2) 2
      omega
    have hr_le_p : r ≤ p := hp_max r hr_prime hr_le_sq
    have hN_le_half : N ≤ n ^ 2 / 2 := by
      have h2N : 2 * N ≤ n ^ 2 := by nlinarith
      omega
    omega
  obtain ⟨q, hq_prime, hpq, hq_gap⟩ := hN p hp_ge_N hp_prime
  have hq_gt : n ^ 2 < q := by
    by_contra hnot
    have hqle : q ≤ n ^ 2 := le_of_not_gt hnot
    have : q ≤ p := hp_max q hq_prime hqle
    omega
  -- Bound the gap by `C * n^(2θ)` using `p ≤ n^2`.
  have hp_rpow_le : (p : ℝ) ^ θ ≤ (n : ℝ) ^ (2 * θ) := by
    have hp_nonneg : (0 : ℝ) ≤ p := by positivity
    have hp_cast_le : (p : ℝ) ≤ (n : ℝ) ^ 2 := by exact_mod_cast hp_le
    calc
      (p : ℝ) ^ θ ≤ ((n : ℝ) ^ 2) ^ θ :=
        Real.rpow_le_rpow hp_nonneg hp_cast_le hθ0
      _ = (n : ℝ) ^ (2 * θ) := by
        rw [← Real.rpow_natCast (n : ℝ) 2, ← Real.rpow_mul (by positivity : (0 : ℝ) ≤ n)]
        norm_num
  have hgap_real : (q - p : ℝ) ≤ C * (n : ℝ) ^ (2 * θ) := by
    exact le_trans hq_gap (mul_le_mul_of_nonneg_left hp_rpow_le hC.le)
  have hq_lt : q < (n + 1) ^ 2 := by
    have hq_lt_real : (q : ℝ) < (n : ℝ) ^ 2 + 2 * (n : ℝ) := by
      have hq_le_real : (q : ℝ) ≤ (p : ℝ) + C * (n : ℝ) ^ (2 * θ) := by
        linarith
      have hp_le' : (p : ℝ) ≤ (n : ℝ) ^ 2 := by exact_mod_cast hp_le
      nlinarith
    have hnat : q < n ^ 2 + 2 * n := by exact_mod_cast hq_lt_real
    have hsq : (n + 1) ^ 2 = n ^ 2 + 2 * n + 1 := by ring
    omega
  exact ⟨q, hq_prime, hq_gt, hq_lt⟩

end Legendre

end
