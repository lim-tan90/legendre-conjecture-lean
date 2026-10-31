/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronOscillation

/-!
# The 3–4–1 positivity inequality for the zeta logarithmic derivative

Original deductions from mathlib v4.35.0 (Apache-2.0). The nonnegative
trigonometric polynomial 3+4 cos θ+cos(2θ) gives the classical positivity
input for a quantitative zero-free-region argument. No zero-free width
is asserted here.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex ArithmeticFunction
open scoped LSeries.notation

/-- Real part of an individual von Mangoldt term on a vertical line. -/
theorem vonMangoldt_term_re {n : ℕ} (hn : n ≠ 0) (σ t : ℝ) :
    (LSeries.term (↗vonMangoldt) ((σ : ℂ) + (t : ℂ) * I) n).re =
      vonMangoldt n * (n : ℝ) ^ (-σ) * Real.cos (t * Real.log n) := by
  have hnpos : (0 : ℝ) < n := Nat.cast_pos.mpr (Nat.pos_of_ne_zero hn)
  rw [LSeries.term_of_ne_zero hn, div_eq_mul_inv, ← cpow_neg]
  have he : -((σ : ℂ) + (t : ℂ) * I) = ((-σ : ℝ) : ℂ) + ((-t : ℝ) : ℂ) * I := by
    push_cast
    ring
  rw [he]
  have hp := cpow_vertical_eq_exp hnpos (-σ) (-t)
  simp only [ofReal_natCast] at hp
  rw [hp]
  simp only [mul_re, mul_im, neg_re, neg_im, ofReal_re, ofReal_im, ofReal_neg, I_re, I_im,
    zero_mul, mul_zero, zero_add, add_zero, sub_zero, neg_zero, mul_neg, exp_re,
    Real.exp_zero, one_mul, mul_one, Real.cos_neg]
  rw [mul_comm (Real.log n) t]
  ring

/-- Each Dirichlet term satisfies the nonnegative 3–4–1 combination. -/
theorem vonMangoldt_term_three_four_one_nonneg (n : ℕ) (σ t : ℝ) :
    0 ≤ 3 * (LSeries.term (↗vonMangoldt) (σ : ℂ) n).re +
      4 * (LSeries.term (↗vonMangoldt) ((σ : ℂ) + (t : ℂ) * I) n).re +
      (LSeries.term (↗vonMangoldt) ((σ : ℂ) + ((2 * t : ℝ) : ℂ) * I) n).re := by
  by_cases hn : n = 0
  · subst n
    simp
  · have hzero := vonMangoldt_term_re hn σ 0
    simp only [ofReal_zero, zero_mul, add_zero, Real.cos_zero, mul_one] at hzero
    rw [hzero, vonMangoldt_term_re hn, vonMangoldt_term_re hn]
    rw [show 2 * t * Real.log n = 2 * (t * Real.log n) by ring, Real.cos_two_mul]
    have hnpos : (0 : ℝ) < n := Nat.cast_pos.mpr (Nat.pos_of_ne_zero hn)
    calc
      0 ≤ 2 * (vonMangoldt n * (n : ℝ) ^ (-σ)) * (Real.cos (t * Real.log n) + 1) ^ 2 := by
        positivity
      _ = _ := by ring

/-- The zeta logarithmic derivative satisfies the classical 3–4–1 inequality on Re(s)>1. -/
theorem neg_logDeriv_three_four_one_nonneg {σ : ℝ} (hσ : 1 < σ) (t : ℝ) :
    0 ≤ 3 * (-logDeriv riemannZeta (σ : ℂ)).re +
      4 * (-logDeriv riemannZeta ((σ : ℂ) + (t : ℂ) * I)).re +
      (-logDeriv riemannZeta ((σ : ℂ) + ((2 * t : ℝ) : ℂ) * I)).re := by
  have hsum (u : ℝ) : HasSum
      (fun n : ℕ ↦ LSeries.term (↗vonMangoldt) ((σ : ℂ) + (u : ℂ) * I) n)
      (-logDeriv riemannZeta ((σ : ℂ) + (u : ℂ) * I)) := by
    have hs : 1 < ((σ : ℂ) + (u : ℂ) * I).re := by simpa using hσ
    rw [neg_logDeriv_eq_vonMangoldt_series hs]
    exact (vonMangoldt_series_summable hs).hasSum
  have hzero := hasSum_re (hsum 0)
  simp only [ofReal_zero, zero_mul, add_zero] at hzero
  have h := ((hzero.mul_left 3).add ((hasSum_re (hsum t)).mul_left 4)).add
    (hasSum_re (hsum (2 * t)))
  rw [← h.tsum_eq]
  exact tsum_nonneg (fun n ↦ vonMangoldt_term_three_four_one_nonneg n σ t)

end Legendre.Zeta
