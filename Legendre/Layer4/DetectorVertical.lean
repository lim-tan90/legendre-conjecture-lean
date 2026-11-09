/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorVertical.lean and the right-integrability argument
of DensityDetectorShift.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Zeta's principal pole is excluded from each vertical line by its real part.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorGrowth

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory

theorem detector_decay_mul (u : ℝ) :
    (1+|u|)*(1+|u|)^(-(3 : ℝ)) = (1+|u|)^(-(2 : ℝ)) := by
  rw [show -(2 : ℝ) = 1+(-(3 : ℝ)) by ring,
    Real.rpow_add (by positivity : 0 < 1+|u|),Real.rpow_one]

theorem detector_left_bound (X : ℕ) (s : ℂ) (hs : 1/2 < s.re) (hs1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) (u : ℝ) :
    ‖detectorIntegrand X s Y (((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I)‖ ≤
      detectorGrowthCost X s Y*(16/(s.re-1/2))*(1+|u|)^(-(2 : ℝ)) := by
  have hd : 1/2 ≤ ‖s+(((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I)-1‖ := by
    have hh := Complex.abs_re_le_norm (s+(((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I)-1)
    norm_num at hh
    simpa only [Complex.ofReal_sub,Complex.ofReal_div,Complex.ofReal_one,Complex.ofReal_ofNat] using! hh
  have hn := detector_numerator_bound X s hs1 hY (1/2-s.re) u le_rfl (by linarith) hd
  have hk := detectorKernel_left_bound (s.re-1/2) u (by linarith) (by linarith)
  rw [← Complex.ofReal_neg,show -(s.re-1/2) = 1/2-s.re by ring] at hk
  rw [detectorIntegrand,norm_mul]
  apply (mul_le_mul hn hk (norm_nonneg _) (by unfold detectorGrowthCost; positivity)).trans_eq
  calc
    _ = detectorGrowthCost X s Y*(16/(s.re-1/2))*((1+|u|)*(1+|u|)^(-(3 : ℝ))) := by ring
    _ = _ := by rw [detector_decay_mul]

theorem detector_left_integrable (X : ℕ) (s : ℂ) (hs : 1/2 < s.re) (hs1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) :
    Integrable (fun u : ℝ => detectorIntegrand X s Y (((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I)) := by
  have hg : Integrable (fun u : ℝ => (1+|u|)^(-(2 : ℝ))) := by
    simpa only [Real.norm_eq_abs] using
      integrable_one_add_norm (E := ℝ) (by norm_num : (Module.finrank ℝ ℝ : ℝ) < 2)
  apply (hg.const_mul (detectorGrowthCost X s Y*(16/(s.re-1/2)))).mono'
  · exact (detectorIntegrand_line_continuous X s (by linarith) (1/2-s.re)
      (by linarith) (by linarith) (by linarith) (by linarith)).aestronglyMeasurable
  · exact Filter.Eventually.of_forall (detector_left_bound X s hs hs1 hY)

theorem detector_right_bound (X : ℕ) (s : ℂ) (hs : 1/2 ≤ s.re) (hs1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) (u : ℝ) :
    ‖detectorIntegrand X s Y (2+(u : ℂ)*I)‖ ≤
      detectorGrowthCost X s Y*8*(1+|u|)^(-(2 : ℝ)) := by
  have hd : 1/2 ≤ ‖s+(2+(u : ℂ)*I)-1‖ := by
    have hh := Complex.re_le_norm (s+(2+(u : ℂ)*I)-1)
    norm_num at hh
    linarith
  have hn := detector_numerator_bound X s hs1 hY 2 u (by linarith) le_rfl hd
  have hk := detectorKernel_line_bound 2 u (by norm_num)
  rw [detectorIntegrand,norm_mul]
  apply (mul_le_mul hn hk (norm_nonneg _) (by unfold detectorGrowthCost; positivity)).trans_eq
  calc
    _ = detectorGrowthCost X s Y*8*((1+|u|)*(1+|u|)^(-(3 : ℝ))) := by ring
    _ = _ := by rw [detector_decay_mul]

theorem detector_right_integrable (X : ℕ) (s : ℂ) (hs : 1/2 ≤ s.re) (hs1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) :
    Integrable (fun u : ℝ => detectorIntegrand X s Y (2+(u : ℂ)*I)) := by
  have hg : Integrable (fun u : ℝ => (1+|u|)^(-(2 : ℝ))) := by
    simpa only [Real.norm_eq_abs] using
      integrable_one_add_norm (E := ℝ) (by norm_num : (Module.finrank ℝ ℝ : ℝ) < 2)
  apply (hg.const_mul (detectorGrowthCost X s Y*8)).mono'
  · exact (detectorIntegrand_line_continuous X s (by linarith) 2
      (by linarith) (by norm_num) (by norm_num) (by norm_num)).aestronglyMeasurable
  · exact Filter.Eventually.of_forall (detector_right_bound X s hs hs1 hY)

end Legendre.Density.Detector.Smooth
