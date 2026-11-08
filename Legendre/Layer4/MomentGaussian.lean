/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityGaussianCauchy.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The Gaussian has variance two, absorbing the xi polynomial shift factor
without an extra power of the base height.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.Layer4.WeightedIntegral

@[expose] public section

/-! # Weighted square bounds for the Gaussian contour integral -/

namespace Legendre.Density.Moment

open MeasureTheory

noncomputable def momentGaussian (u : ℝ) : ℝ := Real.exp (-(u ^ 2) / 4)

theorem momentGaussian_integrable : Integrable momentGaussian := by
  convert integrable_exp_neg_mul_sq (b := (1 / 4 : ℝ)) (by norm_num) using 1
  funext u
  unfold momentGaussian
  congr 1
  ring

theorem momentGaussian_pos (u : ℝ) : 0 < momentGaussian u := Real.exp_pos _

theorem momentGaussian_continuous : Continuous momentGaussian := by
  unfold momentGaussian
  fun_prop

theorem momentGaussian_integral_pos : 0 < ∫ u, momentGaussian u :=
  integral_exp_pos momentGaussian_integrable

theorem gaussian_integral_cauchy (f : ℝ → ℂ) (p : ℝ → ℝ) (M A : ℝ)
    (hp : Continuous p) (hp0 : ∀ u, 0 ≤ p u) (hpA : ∀ u, p u ≤ A)
    (hb : ∀ u, ‖f u‖ ≤ M * momentGaussian u * p u) :
    ‖∫ u, f u‖ ^ 2 ≤ M ^ 2 * (∫ u, momentGaussian u) *
      ∫ u, momentGaussian u * (p u) ^ 2 := by
  have hg := momentGaussian_integrable
  have hc := momentGaussian_continuous
  have hA : 0 ≤ A := (hp0 0).trans (hpA 0)
  have hgp : Integrable (fun u => momentGaussian u * p u) := by
    apply (hg.const_mul A).mono' (hc.mul hp).aestronglyMeasurable
    filter_upwards with u
    simp only [Pi.mul_apply]
    rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg (momentGaussian_pos u).le (hp0 u))]
    nlinarith [momentGaussian_pos u, hpA u]
  have hgpp : Integrable (fun u => momentGaussian u * (p u) ^ 2) := by
    apply (hg.const_mul (A ^ 2)).mono' (hc.mul (hp.pow 2)).aestronglyMeasurable
    filter_upwards with u
    simp only [Pi.mul_apply, Pi.pow_apply]
    rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg (momentGaussian_pos u).le (sq_nonneg _))]
    have hh := pow_le_pow_left₀ (hp0 u) (hpA u) 2
    nlinarith [momentGaussian_pos u]
  have hn : ‖∫ u, f u‖ ≤ M * ∫ u, momentGaussian u * p u := by
    rw [← integral_const_mul]
    apply norm_integral_le_of_norm_le (hgp.const_mul M)
    filter_upwards with u
    simpa only [mul_assoc] using hb u
  have hs := weighted_cauchy momentGaussian p hg hgp hgpp
    (fun u => (momentGaussian_pos u).le) momentGaussian_integral_pos
  calc
    _ ≤ (M * ∫ u, momentGaussian u * p u) ^ 2 :=
      pow_le_pow_left₀ (norm_nonneg _) hn 2
    _ = M ^ 2 * (∫ u, momentGaussian u * p u) ^ 2 := mul_pow _ _ _
    _ ≤ M ^ 2 * ((∫ u, momentGaussian u) * ∫ u, momentGaussian u * (p u) ^ 2) :=
      mul_le_mul_of_nonneg_left hs (sq_nonneg M)
    _ = _ := by ring

end Legendre.Density.Moment

