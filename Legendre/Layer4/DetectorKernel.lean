/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorKernel.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
This is a compact Mellin kernel; the zeta pole must be treated separately.
-/
module
public import Legendre.Layer4.DetectorWeight

@[expose] public section
namespace Legendre.Density.Detector.Smooth

open Complex MeasureTheory

 theorem detectorKernel_line_bound (σ t : ℝ) (hσ : 1 ≤ σ) :
    ‖detectorKernel ((σ : ℂ) + (t : ℂ) * I)‖ ≤
      8 * (1 + |t|) ^ (-(3 : ℝ)) := by
  let s : ℂ := (σ : ℂ) + (t : ℂ) * I
  have hr : s.re = σ := by simp [s]
  have hi : s.im = t := by simp [s]
  have h0 : 1 + |t| ≤ 2 * ‖s‖ := by
    have ha := Complex.re_le_norm s
    have hb := Complex.abs_im_le_norm s
    rw [hr] at ha
    rw [hi] at hb
    linarith
  have h1 : 1 + |t| ≤ 2 * ‖s + 1‖ := by
    have ha := Complex.re_le_norm (s + 1)
    have hb := Complex.abs_im_le_norm (s + 1)
    simp only [add_re, one_re, hr, add_im, one_im, add_zero, hi] at ha hb
    linarith
  have h2 : 1 + |t| ≤ 2 * ‖s + 2‖ := by
    have ha := Complex.re_le_norm (s + 2)
    have hb := Complex.abs_im_le_norm (s + 2)
    norm_num [hr, hi] at ha hb
    linarith
  have hp : (1 + |t|) ^ 3 ≤ 8 * (‖s‖ * ‖s + 1‖ * ‖s + 2‖) := by
    have h01 := mul_le_mul h0 h1 (by positivity) (by positivity)
    have h012 := mul_le_mul h01 h2 (by positivity) (by positivity)
    nlinarith
  have hn0 : 0 < ‖s‖ := by linarith [abs_nonneg t]
  have hn1 : 0 < ‖s + 1‖ := by linarith [abs_nonneg t]
  have hn2 : 0 < ‖s + 2‖ := by linarith [abs_nonneg t]
  change ‖1 / (s * (s + 1) * (s + 2))‖ ≤ _
  rw [norm_div, norm_one, norm_mul, norm_mul, Real.rpow_neg (by positivity : 0 ≤ 1 + |t|),
    Real.rpow_ofNat, ← div_eq_mul_inv]
  apply (div_le_div_iff₀ (by positivity : 0 < ‖s‖ * ‖s + 1‖ * ‖s + 2‖)
    (by positivity : 0 < (1 + |t|) ^ 3)).mpr
  nlinarith

 theorem detectorKernel_verticalIntegrable (σ : ℝ) (hσ : 1 ≤ σ) :
    Complex.VerticalIntegrable detectorKernel σ := by
  have hmajor : Integrable (fun t : ℝ => 8 * (1 + ‖t‖) ^ (-(3 : ℝ))) :=
    (integrable_one_add_norm (E := ℝ) (by norm_num : (Module.finrank ℝ ℝ : ℝ) < 3)).const_mul 8
  have hc : Continuous (fun t : ℝ => detectorKernel ((σ : ℂ) + (t : ℂ) * I)) := by
    unfold detectorKernel
    apply continuous_const.div
    · fun_prop
    · intro t
      apply mul_ne_zero
      · apply mul_ne_zero
        · intro h
          have hr := congrArg Complex.re h
          simp at hr
          linarith
        · intro h
          have hr := congrArg Complex.re h
          simp at hr
          linarith
      · intro h
        have hr := congrArg Complex.re h
        simp at hr
        linarith
  apply hmajor.mono' hc.aestronglyMeasurable
  filter_upwards with t
  simpa only [Real.norm_eq_abs] using detectorKernel_line_bound σ t hσ

 theorem detectorWeight_mellin_inversion (σ x : ℝ) (hσ : 1 ≤ σ) (hx : 0 < x) :
    mellinInv σ detectorKernel x = detectorWeight x := by
  have hσp : 0 < σ := by linarith
  have hF : Complex.VerticalIntegrable (mellin detectorWeight) σ := by
    have he : (fun t : ℝ => mellin detectorWeight ((σ : ℂ) + (t : ℂ) * I)) =
        (fun t : ℝ => detectorKernel ((σ : ℂ) + (t : ℂ) * I)) := by
      funext t
      exact (detectorWeight_hasMellin _ (by simpa using hσp)).2
    change Integrable (fun t : ℝ => mellin detectorWeight ((σ : ℂ) + (t : ℂ) * I))
    rw [he]
    exact detectorKernel_verticalIntegrable σ hσ
  have hi := mellinInv_mellin_eq σ detectorWeight hx
    (detectorWeight_hasMellin (σ : ℂ) hσp).1 hF detectorWeight_continuous.continuousAt
  rw [← hi]
  unfold mellinInv
  congr 1
  apply integral_congr_ae
  filter_upwards with t
  rw [(detectorWeight_hasMellin ((σ : ℂ) + (t : ℂ) * I) (by simpa using hσp)).2]

end Legendre.Density.Detector.Smooth
