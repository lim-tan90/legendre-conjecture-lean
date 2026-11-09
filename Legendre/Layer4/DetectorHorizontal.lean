/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorHorizontal.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
For zeta the horizontal estimate is restricted to |u| >= |Im(s)|+1,
so that its principal pole is avoided uniformly across the strip.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorVertical

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory Filter Set
open scoped Topology Interval

theorem detector_high_bound (X : ℕ) (s : ℂ) (hs1 : s.re ≤ 1) {Y : ℝ} (hY : 1 ≤ Y)
    (x u : ℝ) (hx : 1/2-s.re ≤ x) (hx2 : x ≤ 2) (hu : |s.im|+1 ≤ |u|) :
    ‖detectorIntegrand X s Y ((x : ℂ)+(u : ℂ)*I)‖ ≤ 2*detectorGrowthCost X s Y/|u|^2 := by
  let K := detectorGrowthCost X s Y
  have hK : 0 ≤ K := by dsimp [K,detectorGrowthCost]; positivity
  have hup : 0 < |u| := by linarith [abs_nonneg s.im]
  have hzu : 1 ≤ |s.im+u| := by
    have hh := abs_sub_le u (s.im+u) 0
    rw [show u-(s.im+u) = -s.im by ring,sub_zero,sub_zero,abs_neg] at hh
    linarith
  have hd : 1/2 ≤ ‖s+((x : ℂ)+(u : ℂ)*I)-1‖ := by
    have hh := Complex.abs_im_le_norm (s+((x : ℂ)+(u : ℂ)*I)-1)
    simp only [sub_im,add_im,ofReal_im,mul_im,ofReal_re,I_im,I_re,mul_one,
      mul_zero,add_zero,zero_add,one_im,sub_zero] at hh
    linarith
  have hn := detector_numerator_bound X s hs1 hY x u hx hx2 hd
  have hk := detectorKernel_high_bound x u hup
  rw [detectorIntegrand,norm_mul]
  calc
    _ ≤ (K*(1+|u|))*(|u|^3)⁻¹ := mul_le_mul hn hk (norm_nonneg _) (by positivity)
    _ ≤ (K*(2*|u|))*(|u|^3)⁻¹ := by
      apply mul_le_mul_of_nonneg_right _ (by positivity)
      apply mul_le_mul_of_nonneg_left _ hK
      linarith [abs_nonneg s.im]
    _ = 2*K/|u|^2 := by field_simp

theorem detector_horizontal_bound (X : ℕ) (s : ℂ) (hs : 1/2 ≤ s.re) (hs1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) (u : ℝ) (hu : |s.im|+1 ≤ |u|) :
    ‖∫ x in (1/2-s.re)..2, detectorIntegrand X s Y ((x : ℂ)+(u : ℂ)*I)‖ ≤
      (2*detectorGrowthCost X s Y*|2-(1/2-s.re)|)/|u|^2 := by
  have hab : 1/2-s.re ≤ 2 := by linarith
  have h := intervalIntegral.norm_integral_le_of_norm_le_const
    (fun x (hx : x ∈ Ι (1/2-s.re) 2) => detector_high_bound X s hs1 hY x u
      (by rw [uIoc_of_le hab] at hx; exact hx.1.le)
      (by rw [uIoc_of_le hab] at hx; exact hx.2) hu)
  convert h using 1
  ring

theorem detector_horizontal_tendsto (X : ℕ) (s : ℂ) (hs : 1/2 ≤ s.re) (hs1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) :
    Tendsto (fun u : ℝ => ∫ x in (1/2-s.re)..2,
      detectorIntegrand X s Y ((x : ℂ)+(u : ℂ)*I)) atTop (𝓝 0) ∧
    Tendsto (fun u : ℝ => ∫ x in (1/2-s.re)..2,
      detectorIntegrand X s Y ((x : ℂ)+(-u)*I)) atTop (𝓝 0) := by
  let K := 2*detectorGrowthCost X s Y*|2-(1/2-s.re)|
  have ht : Tendsto (fun u : ℝ => K/u^2) atTop (𝓝 0) := by
    simpa only [div_eq_mul_inv,mul_zero,Function.comp_apply] using
      (tendsto_inv_atTop_zero.comp (tendsto_pow_atTop (by norm_num : (2 : ℕ) ≠ 0))).const_mul K
  constructor
  · rw [tendsto_zero_iff_norm_tendsto_zero]
    apply squeeze_zero' (Filter.Eventually.of_forall (fun _ => norm_nonneg _)) _ ht
    filter_upwards [eventually_ge_atTop (|s.im|+1)] with u hu
    have hup : 0 ≤ u := by linarith [abs_nonneg s.im]
    simpa only [abs_of_nonneg hup] using
      detector_horizontal_bound X s hs hs1 hY u (by rwa [abs_of_nonneg hup])
  · rw [tendsto_zero_iff_norm_tendsto_zero]
    apply squeeze_zero' (Filter.Eventually.of_forall (fun _ => norm_nonneg _)) _ ht
    filter_upwards [eventually_ge_atTop (|s.im|+1)] with u hu
    have hup : 0 ≤ u := by linarith [abs_nonneg s.im]
    simpa only [abs_neg,abs_of_nonneg hup,Complex.ofReal_neg] using
      detector_horizontal_bound X s hs hs1 hY (-u) (by simpa only [abs_neg,abs_of_nonneg hup] using hu)

end Legendre.Density.Detector.Smooth
