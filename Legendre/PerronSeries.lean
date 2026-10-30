/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronTruncated
public import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-!
# The von Mangoldt series inside a finite Perron integral

Original deductions using mathlib v4.35.0 (Apache-2.0). A summable majorant
independent of height justifies integrating the weighted Dirichlet series
term by term on any finite vertical segment to the right of 1. This does
not evaluate the individual kernels or pass to infinite height.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter
open scoped LSeries.notation

/-- Weighted n-th von Mangoldt Dirichlet term, with the L-series zero-index convention. -/
noncomputable def perronSeriesTerm (n : ℕ) (x : ℝ) (s : ℂ) : ℂ :=
  LSeries.term (↗ArithmeticFunction.vonMangoldt) s n * perronWeight x s

/-- The weighted term has the classical Λ(n)(x/n)^s/s form, including n=0. -/
theorem perronSeriesTerm_eq_vonMangoldt_mul_weight {x : ℝ} (hx : 0 < x)
    (n : ℕ) (s : ℂ) : perronSeriesTerm n x s =
      (ArithmeticFunction.vonMangoldt n : ℂ) * perronWeight (x / n) s := by
  by_cases hn : n = 0
  · subst n
    simp [perronSeriesTerm]
  rw [perronSeriesTerm, LSeries.term_of_ne_zero hn]
  simp only [perronWeight, ofReal_div, ofReal_natCast]
  have hp := div_cpow_ofReal_nonneg hx.le (Nat.cast_nonneg n : (0 : ℝ) ≤ n) s
  simp only [ofReal_natCast] at hp
  rw [hp]
  ring

/-- Absolute convergence of the weighted series identifies its sum with K. -/
theorem perronSeriesTerm_hasSum {x : ℝ} {s : ℂ} (hs : 1 < s.re) :
    HasSum (fun n ↦ perronSeriesTerm n x s) (perronIntegrand x s) := by
  have h := (vonMangoldt_series_summable hs).hasSum
  rw [← neg_logDeriv_eq_vonMangoldt_series hs] at h
  exact h.mul_right (perronWeight x s)

/-- The weight has a height-independent bound on the vertical line. -/
theorem norm_perronWeight_vertical_le {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) (t : ℝ) :
    ‖perronWeight x ((σ : ℂ) + (t : ℂ) * I)‖ ≤ x ^ σ / σ := by
  rw [norm_perronWeight hx]
  have hre : ((σ : ℂ) + (t : ℂ) * I).re = σ := by simp
  rw [hre]
  apply div_le_div_of_nonneg_left (Real.rpow_nonneg hx.le _) (by linarith : 0 < σ)
  simpa [abs_of_pos (lt_trans zero_lt_one hσ)] using
    abs_re_le_norm ((σ : ℂ) + (t : ℂ) * I)

/-- A summable coefficient majorant, constant in the height parameter. -/
theorem norm_perronSeriesTerm_vertical_le {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ)
    (n : ℕ) (t : ℝ) :
    ‖perronSeriesTerm n x ((σ : ℂ) + (t : ℂ) * I)‖ ≤
      ‖LSeries.term (↗ArithmeticFunction.vonMangoldt) (σ : ℂ) n‖ * (x ^ σ / σ) := by
  rw [perronSeriesTerm, norm_mul]
  exact mul_le_mul (LSeries.norm_term_le_of_re_le_re _ (by simp) n)
    (norm_perronWeight_vertical_le hx hσ t) (norm_nonneg _) (norm_nonneg _)

/-- Each weighted term is continuous along the vertical line. -/
theorem perronSeriesTerm_vertical_continuous {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ)
    (n : ℕ) : Continuous (fun t : ℝ ↦ perronSeriesTerm n x ((σ : ℂ) + (t : ℂ) * I)) := by
  by_cases hn : n = 0
  · subst n
    simp only [perronSeriesTerm, LSeries.term_zero, zero_mul]
    exact continuous_const
  have hl : Continuous (fun t : ℝ ↦ (σ : ℂ) + (t : ℂ) * I) :=
    continuous_const.add (continuous_ofReal.mul_const I)
  have hnat : (n : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hn
  have hden : ∀ t : ℝ, (σ : ℂ) + (t : ℂ) * I ≠ 0 := by
    intro t ht
    have h := congrArg Complex.re ht
    simp at h
    linarith
  have hw : Continuous (fun t : ℝ ↦ perronWeight x ((σ : ℂ) + (t : ℂ) * I)) :=
    ((continuous_const_cpow' (ofReal_ne_zero.mpr hx.ne')).comp hl).div hl hden
  have hc : Continuous (fun t : ℝ ↦ LSeries.term (↗ArithmeticFunction.vonMangoldt)
      ((σ : ℂ) + (t : ℂ) * I) n) := by
    simp only [LSeries.term_of_ne_zero hn]
    exact continuous_const.div ((continuous_const_cpow' hnat).comp hl)
      (fun _ ↦ cpow_ne_zero_iff.mpr (.inl hnat))
  exact hc.mul hw

/-- Termwise integration is justified by a summable, integrable constant majorant. -/
theorem perronSeriesTerm_hasSum_intervalIntegral {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ)
    (a b : ℝ) :
    HasSum (fun n ↦ ∫ t : ℝ in a..b, perronSeriesTerm n x ((σ : ℂ) + (t : ℂ) * I))
      (∫ t : ℝ in a..b, perronIntegrand x ((σ : ℂ) + (t : ℂ) * I)) := by
  apply intervalIntegral.hasSum_integral_of_dominated_convergence
    (fun n (_ : ℝ) ↦ ‖LSeries.term (↗ArithmeticFunction.vonMangoldt) (σ : ℂ) n‖ *
      (x ^ σ / σ))
  · intro n
    exact (perronSeriesTerm_vertical_continuous hx hσ n).aestronglyMeasurable
  · intro n
    exact .of_forall (fun t _ ↦ norm_perronSeriesTerm_vertical_le hx hσ n t)
  · exact .of_forall (fun _ _ ↦
      ((vonMangoldt_series_summable (s := (σ : ℂ)) (by simpa using hσ)).norm).mul_right _)
  · exact intervalIntegrable_const
  · exact .of_forall (fun t _ ↦ perronSeriesTerm_hasSum (by simpa using hσ))

/-- The series of integrated terms is absolutely convergent on every finite segment. -/
theorem perronSeriesTerm_integrals_norm_summable {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ)
    (a b : ℝ) : Summable (fun n : ℕ ↦
      ‖∫ t : ℝ in a..b, perronSeriesTerm n x ((σ : ℂ) + (t : ℂ) * I)‖) := by
  have hbase := (vonMangoldt_series_summable (s := (σ : ℂ)) (by simpa using hσ)).norm
  apply Summable.of_nonneg_of_le (fun _ ↦ norm_nonneg _)
    (fun n ↦ intervalIntegral.norm_integral_le_of_norm_le_const
      (fun t _ ↦ norm_perronSeriesTerm_vertical_le hx hσ n t))
    ((hbase.mul_right (x ^ σ / σ)).mul_right |b - a|)

/-- The normalized scalar Perron kernel on a finite vertical segment. -/
noncomputable def truncatedPerronKernel (y σ T : ℝ) : ℂ :=
  (1 / (2 * Real.pi) : ℂ) * ∫ t : ℝ in -T..T,
    perronWeight y ((σ : ℂ) + (t : ℂ) * I)

/-- Exact weighted-series representation of the normalized finite Perron integral.
There is no infinite-height limit or identification with ψ in this theorem. -/
theorem truncatedPerron_eq_tsum_integrals {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) (T : ℝ) :
    truncatedPerron x σ T = ∑' n : ℕ, (1 / (2 * Real.pi) : ℂ) *
      ∫ t : ℝ in -T..T, perronSeriesTerm n x ((σ : ℂ) + (t : ℂ) * I) := by
  exact ((perronSeriesTerm_hasSum_intervalIntegral hx hσ (-T) T).mul_left
    (1 / (2 * Real.pi) : ℂ)).tsum_eq.symm

/-- Reduction to scalar truncated kernels, without yet evaluating their limits. -/
theorem truncatedPerron_eq_tsum_kernels {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) (T : ℝ) :
    truncatedPerron x σ T = ∑' n : ℕ,
      (ArithmeticFunction.vonMangoldt n : ℂ) * truncatedPerronKernel (x / n) σ T := by
  rw [truncatedPerron_eq_tsum_integrals hx hσ]
  apply tsum_congr
  intro n
  simp_rw [perronSeriesTerm_eq_vonMangoldt_mul_weight hx]
  rw [intervalIntegral.integral_const_mul]
  simp only [truncatedPerronKernel]
  ring

end Legendre.Zeta
