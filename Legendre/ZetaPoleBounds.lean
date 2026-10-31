/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaGrowth
public import Mathlib.Analysis.Complex.Liouville

/-!
# Explicit bounds for the real-axis logarithmic derivative near the pole

Original deductions using mathlib v4.35.0 (Apache-2.0).
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Metric Filter Topology

/-- Cauchy's estimate bounds the derivative of the Mellin remainder on the real axis. -/
theorem norm_deriv_zetaMellinRemainder_le {σ : ℝ} (hσ : 1 ≤ σ) :
    ‖deriv zetaMellinRemainder (σ : ℂ)‖ ≤ 4 := by
  have hcoord {w : ℂ} (hw : w ∈ closedBall (σ : ℂ) (1 / 2)) : 1 / 2 ≤ w.re := by
    have hn : ‖w - (σ : ℂ)‖ ≤ 1 / 2 := by simpa only [mem_closedBall, dist_eq_norm] using hw
    have hr := (abs_re_le_norm (w - (σ : ℂ))).trans hn
    simp only [sub_re, ofReal_re] at hr
    linarith [(abs_le.mp hr).1]
  have hA : AnalyticOnNhd ℂ zetaMellinRemainder (closedBall (σ : ℂ) (1 / 2)) := by
    intro w hw
    rw [Complex.analyticAt_iff_eventually_differentiableAt]
    have hpos : 0 < w.re := by linarith [hcoord hw]
    filter_upwards [(isOpen_lt continuous_const continuous_re).mem_nhds hpos] with v hv
    exact zetaMellinRemainder_differentiableAt hv
  have hd : DiffContOnCl ℂ zetaMellinRemainder (ball (σ : ℂ) (1 / 2)) := by
    refine ⟨hA.differentiableOn.mono ball_subset_closedBall, ?_⟩
    simpa only [closure_ball (σ : ℂ) (by norm_num : (1 / 2 : ℝ) ≠ 0)] using hA.continuousOn
  have h := norm_deriv_le_of_forall_mem_sphere_norm_le (f := zetaMellinRemainder)
    (c := (σ : ℂ)) (R := 1 / 2) (C := 2) (by norm_num) hd (by
      intro w hw
      have hr := hcoord (sphere_subset_closedBall hw)
      have hp : 0 < w.re := by linarith
      apply (norm_zetaMellinRemainder_le hp).trans
      have hb := one_div_le_one_div_of_le (by norm_num : (0 : ℝ) < 1 / 2) hr
      norm_num at hb
      simpa only [one_div] using hb)
  norm_num at h
  exact h

/-- Differentiating the Euler-summation numerator gives an explicit regular-part derivative. -/
theorem deriv_poleRemovedZeta_eq {s : ℂ} (hs : 0 < s.re) :
    deriv poleRemovedZeta s = 1 - (2 * s - 1) * zetaMellinRemainder s -
      s * (s - 1) * deriv zetaMellinRemainder s := by
  have he : poleRemovedZeta =ᶠ[𝓝 s]
      (fun z : ℂ ↦ z - z * (z - 1) * zetaMellinRemainder z) := by
    filter_upwards [(isOpen_lt continuous_const continuous_re).mem_nhds hs] with z hz
    exact poleRemovedZeta_eq_euler_sum hz
  have hd := (hasDerivAt_id s).sub (((hasDerivAt_id s).mul
    ((hasDerivAt_id s).sub_const 1)).mul (zetaMellinRemainder_differentiableAt hs).hasDerivAt)
  rw [he.deriv_eq]
  convert! hd.deriv using 1
  simp only [Pi.mul_apply, id_eq]
  ring

/-- The regularized pole numerator has norm at least 1/2 on the short real interval. -/
theorem one_half_le_norm_poleRemovedZeta {σ : ℝ} (hσ : 1 < σ) (hσupper : σ ≤ 9 / 8) :
    1 / 2 ≤ ‖poleRemovedZeta (σ : ℂ)‖ := by
  have hM : ‖zetaMellinRemainder (σ : ℂ)‖ ≤ 1 := by
    apply (norm_zetaMellinRemainder_le (by simpa using (show (0 : ℝ) < σ by linarith))).trans
    simpa using one_div_le_one_div_of_le zero_lt_one hσ.le
  have he : poleRemovedZeta (σ : ℂ) - 1 =
      ((σ : ℂ) - 1) * (1 - (σ : ℂ) * zetaMellinRemainder (σ : ℂ)) := by
    rw [poleRemovedZeta_eq_euler_sum (by simpa using (show (0 : ℝ) < σ by linarith))]
    ring
  have hsmall : ‖poleRemovedZeta (σ : ℂ) - 1‖ ≤ (σ - 1) * (1 + σ) := by
    rw [he, norm_mul]
    have hnormσ : ‖(σ : ℂ)‖ = σ := by simp [abs_of_pos (show 0 < σ by linarith)]
    have hnormδ : ‖(σ : ℂ) - 1‖ = σ - 1 := by
      rw [← ofReal_one, ← ofReal_sub, norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
    rw [hnormδ]
    apply mul_le_mul_of_nonneg_left _ (by linarith)
    apply (norm_sub_le _ _).trans
    rw [norm_one, norm_mul, hnormσ]
    nlinarith
  have htriangle := norm_le_norm_sub_add (1 : ℂ) (poleRemovedZeta (σ : ℂ))
  rw [norm_one, norm_sub_rev] at htriangle
  nlinarith [mul_self_le_mul_self (by linarith : (0 : ℝ) ≤ σ) hσupper]

/-- The pole numerator derivative is uniformly bounded on 1<σ≤9/8. -/
theorem norm_deriv_poleRemovedZeta_le {σ : ℝ} (hσ : 1 < σ) (hσupper : σ ≤ 9 / 8) :
    ‖deriv poleRemovedZeta (σ : ℂ)‖ ≤ 3 := by
  have hM : ‖zetaMellinRemainder (σ : ℂ)‖ ≤ 1 := by
    apply (norm_zetaMellinRemainder_le (by simpa using (show (0 : ℝ) < σ by linarith))).trans
    simpa using one_div_le_one_div_of_le zero_lt_one hσ.le
  have hD := norm_deriv_zetaMellinRemainder_le hσ.le
  rw [deriv_poleRemovedZeta_eq (by simpa using (show (0 : ℝ) < σ by linarith))]
  have hnormσ : ‖(σ : ℂ)‖ = σ := by simp [abs_of_pos (show 0 < σ by linarith)]
  have hnormδ : ‖(σ : ℂ) - 1‖ = σ - 1 := by
    rw [← ofReal_one, ← ofReal_sub, norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
  have hnorm2 : ‖2 * (σ : ℂ) - 1‖ = 2 * σ - 1 := by
    norm_cast
    rw [Real.norm_eq_abs, abs_of_pos (by linarith)]
  calc
    _ ≤ 1 + (2 * σ - 1) * ‖zetaMellinRemainder (σ : ℂ)‖ +
        σ * (σ - 1) * ‖deriv zetaMellinRemainder (σ : ℂ)‖ := by
      apply (norm_sub_le _ _).trans
      apply add_le_add
      · apply (norm_sub_le _ _).trans
        simp only [norm_one, norm_mul, hnorm2, le_refl]
      · simp only [norm_mul, hnormσ, hnormδ, le_refl]
    _ ≤ 1 + (2 * σ - 1) * 1 + σ * (σ - 1) * 4 := by
      gcongr
      linarith
    _ ≤ 3 := by
      have hp : σ * (σ - 1) ≤ (9 / 8 : ℝ) * (1 / 8) := by
        nlinarith [mul_nonneg (show 0 ≤ 9 / 8 - σ by linarith) (show 0 ≤ σ - 1 by linarith)]
      nlinarith

/-- Uniform logarithmic-derivative bound for the pole numerator. -/
theorem norm_logDeriv_poleRemovedZeta_le {σ : ℝ} (hσ : 1 < σ) (hσupper : σ ≤ 9 / 8) :
    ‖logDeriv poleRemovedZeta (σ : ℂ)‖ ≤ 6 := by
  rw [logDeriv_apply, norm_div]
  calc
    _ ≤ 3 / ‖poleRemovedZeta (σ : ℂ)‖ :=
      div_le_div_of_nonneg_right (norm_deriv_poleRemovedZeta_le hσ hσupper) (norm_nonneg _)
    _ ≤ 3 / (1 / 2 : ℝ) := div_le_div_of_nonneg_left (by norm_num) (by norm_num)
      (one_half_le_norm_poleRemovedZeta hσ hσupper)
    _ = 6 := by norm_num

/-- Explicit sharp-pole upper bound for -Re(ζ'/ζ) on the real axis. -/
theorem neg_logDeriv_real_le_pole {σ : ℝ} (hσ : 1 < σ) (hσupper : σ ≤ 9 / 8) :
    (-logDeriv riemannZeta (σ : ℂ)).re ≤ 1 / (σ - 1) + 6 := by
  have hsne : (σ : ℂ) ≠ 1 := by exact_mod_cast hσ.ne'
  have hζ := riemannZeta_ne_zero_of_one_le_re (s := (σ : ℂ)) (by simpa using hσ.le)
  have he := (logDeriv_congr_nhds (poleRemovedZeta_eventuallyEq hsne)).eq_of_nhds
  rw [logDeriv_fun_mul (f := fun z : ℂ ↦ z - 1) (g := riemannZeta)
    (σ : ℂ) (sub_ne_zero.mpr hsne) hζ
    (differentiableAt_id.sub_const 1) (differentiableAt_riemannZeta hsne)] at he
  have hpart : logDeriv (fun z : ℂ ↦ z - 1) (σ : ℂ) = 1 / ((σ : ℂ) - 1) := by
    simp [logDeriv_apply]
  rw [hpart] at he
  have her := congrArg Complex.re he
  simp only [add_re] at her
  have hreal : ((1 : ℂ) / ((σ : ℂ) - 1)).re = 1 / (σ - 1) := by
    rw [← ofReal_one, ← ofReal_sub, ← ofReal_div, ofReal_re]
  rw [hreal] at her
  have hneg := (neg_le_abs (logDeriv poleRemovedZeta (σ : ℂ)).re).trans (abs_re_le_norm _)
  have hbound := norm_logDeriv_poleRemovedZeta_le hσ hσupper
  simp only [neg_re]
  linarith

end Legendre.Zeta
