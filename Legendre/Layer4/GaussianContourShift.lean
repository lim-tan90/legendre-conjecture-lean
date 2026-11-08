/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from GaussianContourShift.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Uses the existing PNT+ rectangle API and a Gaussian of variance two.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.XiSquareContour
public import Legendre.Layer4.MomentGaussian

@[expose] public section

/-! # Shifting a vertical Gaussian integral inside an analytic strip -/

namespace Legendre.Zeta

open Complex Filter MeasureTheory Set
open scoped Topology Interval

theorem gaussian_strip_vertical_eq (f : ℂ → ℂ) (a b K : ℝ) (hab : a ≤ b)
    (hf : ∀ z : ℂ, a ≤ z.re → z.re ≤ b → AnalyticAt ℂ f z)
    (hb : ∀ x ∈ Icc a b, ∀ u : ℝ, ‖f ((x : ℂ) + u * I)‖ ≤ K * Real.exp (-(u ^ 2) / 4)) :
    (∫ u : ℝ, f ((a : ℂ) + u * I)) = ∫ u : ℝ, f ((b : ℂ) + u * I) := by
  let g : ℝ → ℝ := fun u => Real.exp (-(u ^ 2) / 4)
  have hg : Integrable g := by
    convert integrable_exp_neg_mul_sq (b := (1 / 4 : ℝ)) (by norm_num) using 1
    funext u
    dsimp [g]
    congr 1
    ring
  have hlim : Tendsto g atTop (𝓝 0) := by
    have hp : Tendsto (fun u : ℝ => u ^ 2 / 4) atTop atTop :=
      (tendsto_pow_atTop (by norm_num : (2 : ℕ) ≠ 0)).atTop_div_const (by norm_num)
    simpa only [g, Function.comp_def, neg_div] using Real.tendsto_exp_neg_atTop_nhds_zero.comp hp
  have hv (x : ℝ) (hx : x ∈ Icc a b) : Integrable (fun u : ℝ => f ((x : ℂ) + u * I)) := by
    have hc : Continuous (fun u : ℝ => f ((x : ℂ) + u * I)) := by
      apply continuous_iff_continuousAt.mpr
      intro u
      exact (hf _ (by simpa using hx.1) (by simpa using hx.2)).continuousAt.comp (by fun_prop)
    apply (hg.const_mul K).mono' hc.aestronglyMeasurable
    filter_upwards with u
    exact hb x hx u
  have hh (u : ℝ) : ‖∫ x in a..b, f ((x : ℂ) + u * I)‖ ≤
      (K * |b - a|) * g u := by
    have h := intervalIntegral.norm_integral_le_of_norm_le_const
      (fun x (hx : x ∈ Ι a b) => hb x
        (by rw [uIoc_of_le hab] at hx; exact ⟨hx.1.le, hx.2⟩) u)
    convert h using 1
    ring
  have htop : Tendsto (fun u : ℝ => ∫ x in a..b, f ((x : ℂ) + u * I)) atTop (𝓝 0) := by
    rw [tendsto_zero_iff_norm_tendsto_zero]
    exact squeeze_zero (fun _ => norm_nonneg _) hh (by simpa using hlim.const_mul (K * |b - a|))
  have hbot : Tendsto (fun u : ℝ => ∫ x in a..b, f ((x : ℂ) + (-u) * I)) atTop (𝓝 0) := by
    rw [tendsto_zero_iff_norm_tendsto_zero]
    apply squeeze_zero (fun _ => norm_nonneg _) _ (by simpa using hlim.const_mul (K * |b - a|))
    intro u
    simpa only [g, neg_sq, Complex.ofReal_neg] using hh (-u)
  have hr := intervalIntegral_tendsto_integral (hv b ⟨hab, le_rfl⟩)
    tendsto_neg_atTop_atBot tendsto_id
  have hl := intervalIntegral_tendsto_integral (hv a ⟨le_rfl, hab⟩)
    tendsto_neg_atTop_atBot tendsto_id
  have hbd : Tendsto (fun T : ℝ => xiRectangleIntegral f a b (-T) T) atTop
      (𝓝 (I * (∫ u : ℝ, f ((b : ℂ) + u * I)) - I * ∫ u : ℝ, f ((a : ℂ) + u * I))) := by
    simpa [xiRectangleIntegral,RectangleIntegral,HIntegral,VIntegral,smul_eq_mul] using ((hbot.sub htop).add (hr.const_mul I)).sub (hl.const_mul I)
  have hz : ∀ T : ℝ, xiRectangleIntegral f a b (-T) T = 0 := by
    intro T
    unfold xiRectangleIntegral
    apply integral_boundary_rect_eq_zero_of_differentiableOn
    intro z hz
    have hre : z.re ∈ Icc a b := by
      have h := (Complex.mem_reProdIm.1 hz).1
      simpa only [add_re,ofReal_re,mul_re,I_re,I_im,ofReal_im,mul_zero,zero_mul,
        sub_self,add_zero,uIcc_of_le hab] using h
    exact (hf z hre.1 hre.2).differentiableAt.differentiableWithinAt
  have he : I * (∫ u : ℝ, f ((b : ℂ) + u * I)) - I * (∫ u : ℝ, f ((a : ℂ) + u * I)) = 0 :=
    tendsto_nhds_unique hbd (tendsto_const_nhds.congr (fun T => (hz T).symm))
  exact (mul_left_cancel₀ I_ne_zero (sub_eq_zero.mp he)).symm

end Legendre.Zeta

