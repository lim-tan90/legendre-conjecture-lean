/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityCriticalDetector.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Raw zeta ordinates replace the Fourier-scaled character coordinates.
The principal pole is retained separately by DetectorAlternative.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorAlternative

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory
open scoped ArithmeticFunction.Moebius

noncomputable def criticalWeight (u : ℝ) : ℝ := 1/(1+|u|)^3

theorem criticalWeight_nonneg (u : ℝ) : 0 ≤ criticalWeight u := by unfold criticalWeight; positivity

theorem criticalWeight_continuous : Continuous criticalWeight := by
  unfold criticalWeight
  exact continuous_const.div ((continuous_const.add continuous_abs).pow 3) (fun u => by positivity)

theorem criticalWeight_eq_rpow (u : ℝ) : criticalWeight u = (1+|u|)^(-(3 : ℝ)) := by
  rw [Real.rpow_neg (by positivity : 0 ≤ 1+|u|),Real.rpow_ofNat]
  simp only [criticalWeight,one_div]

noncomputable def criticalProduct (X : ℕ) (t u : ℝ) : ℂ :=
  riemannZeta ((1/2 : ℂ)+(t+u : ℝ)*I)*
    finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(t+u : ℝ)*I)

theorem criticalProduct_continuous (X : ℕ) (t : ℝ) : Continuous (criticalProduct X t) := by
  have hline : Continuous (fun u : ℝ => (1/2 : ℂ)+(t+u : ℝ)*I) := by fun_prop
  have hζ : Continuous (fun u : ℝ => riemannZeta ((1/2 : ℂ)+(t+u : ℝ)*I)) := by
    apply continuous_iff_continuousAt.mpr
    intro u
    exact (differentiableAt_riemannZeta (by
      intro he
      have := congrArg Complex.re he
      norm_num at this)).continuousAt.comp hline.continuousAt
  have hM : Continuous (fun z : ℂ => finiteSeries (μ : ArithmeticFunction ℂ) X z) := by
    apply continuous_iff_continuousAt.mpr
    intro z
    simpa only [zero_add] using (mollifier_shift_analytic X 0 z).continuousAt
  exact hζ.mul (hM.comp hline)

theorem criticalProduct_bound (X : ℕ) (t u : ℝ) :
    ‖criticalProduct X t u‖ ≤ (16*(X : ℝ)*(1+|t|))*(1+|u|) := by
  let s : ℂ := (1/2 : ℂ)+(t : ℂ)*I
  have he : s+((0 : ℂ)+(u : ℂ)*I) = (1/2 : ℂ)+(t+u : ℝ)*I := by
    dsimp [s]
    push_cast
    ring
  have hd : 1/2 ≤ ‖s+((0 : ℂ)+(u : ℂ)*I)-1‖ := by
    have hh := Complex.abs_re_le_norm (s+((0 : ℂ)+(u : ℂ)*I)-1)
    norm_num [s] at hh
    simpa only [s,zero_add] using! hh
  have h := detector_numerator_bound X s (by norm_num [s]) (Y := 1) (by norm_num)
    0 u (by norm_num [s]) (by norm_num) hd
  simp only [Complex.ofReal_zero,Complex.ofReal_one,one_cpow,mul_one] at h
  rw [he] at h
  simpa [criticalProduct,detectorGrowthCost,s] using h

theorem criticalProduct_weighted_integrable (X : ℕ) (t : ℝ) :
    Integrable (fun u => criticalWeight u*‖criticalProduct X t u‖) := by
  have hg : Integrable (fun u : ℝ => (1+|u|)^(-(2 : ℝ))) := by
    simpa only [Real.norm_eq_abs] using
      integrable_one_add_norm (E := ℝ) (by norm_num : (Module.finrank ℝ ℝ : ℝ) < 2)
  apply (hg.const_mul (16*(X : ℝ)*(1+|t|))).mono'
    (criticalWeight_continuous.mul (criticalProduct_continuous X t).norm).aestronglyMeasurable
  filter_upwards with u
  simp only [Pi.mul_apply] at ⊢
  rw [Real.norm_eq_abs,abs_of_nonneg (mul_nonneg (criticalWeight_nonneg u) (norm_nonneg _))]
  have h := mul_le_mul_of_nonneg_left (criticalProduct_bound X t u) (criticalWeight_nonneg u)
  apply h.trans_eq
  rw [criticalWeight_eq_rpow]
  have he := detector_decay_mul u
  calc
    _ = (16*(X : ℝ)*(1+|t|))*((1+|u|)*(1+|u|)^(-(3 : ℝ))) := by ring
    _ = _ := by rw [he]

noncomputable def criticalMass (X : ℕ) (t : ℝ) : ℝ :=
  ∫ u : ℝ, criticalWeight u*‖criticalProduct X t u‖

theorem criticalMass_nonneg (X : ℕ) (t : ℝ) : 0 ≤ criticalMass X t :=
  integral_nonneg (fun u => mul_nonneg (criticalWeight_nonneg u) (norm_nonneg _))

theorem detector_critical_point_bound (X : ℕ) (s : ℂ) (hσ : 1/2 < s.re) (hσ1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) (u : ℝ) :
    ‖detectorIntegrand X s Y (((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I)‖ ≤
      (16*Y^(1/2-s.re)/(s.re-1/2))*(criticalWeight u*‖criticalProduct X s.im u‖) := by
  have he : s+(((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I) = (1/2 : ℂ)+(s.im+u : ℝ)*I := by
    apply Complex.ext <;> simp
  have hk := detectorKernel_left_bound (s.re-1/2) u (by linarith) (by linarith)
  rw [← Complex.ofReal_neg,show -(s.re-1/2) = 1/2-s.re by ring,
    ← criticalWeight_eq_rpow] at hk
  rw [detectorIntegrand,mul_assoc,← mul_assoc,← mul_assoc,norm_mul,norm_mul,norm_mul,
    Complex.norm_cpow_eq_rpow_re_of_pos (by linarith : 0 < Y)]
  simp only [add_re,ofReal_re,mul_re,ofReal_im,I_re,I_im,mul_zero,zero_mul,sub_self,add_zero]
  rw [he]
  have hh := mul_le_mul_of_nonneg_left hk
    (show 0 ≤ ‖riemannZeta ((1/2 : ℂ)+(s.im+u : ℝ)*I)‖*
      ‖finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(s.im+u : ℝ)*I)‖*
        Y^(1/2-s.re) by positivity)
  convert hh using 1; simp only [criticalProduct,norm_mul]; ring

theorem detectorCriticalIntegral_bound (X : ℕ) (s : ℂ) (hσ : 1/2 < s.re) (hσ1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) :
    ‖detectorCriticalIntegral X s Y‖ ≤ (16*Y^(1/2-s.re)/(s.re-1/2))*criticalMass X s.im := by
  rw [detectorCriticalIntegral,norm_mul]
  apply (mul_le_of_le_one_left (norm_nonneg _) Zeta.norm_two_pi_inv_le_one).trans
  apply (norm_integral_le_integral_norm _).trans
  unfold criticalMass
  rw [← integral_const_mul]
  apply integral_mono_of_nonneg
  · exact Filter.Eventually.of_forall (fun _ => norm_nonneg _)
  · exact (criticalProduct_weighted_integrable X s.im).const_mul _
  · exact Filter.Eventually.of_forall (detector_critical_point_bound X s hσ hσ1 hY)

theorem detectorCriticalIntegral_uniform_bound (X : ℕ) (s : ℂ) {σ Y : ℝ}
    (hσ : 1/2 < σ) (hσs : σ ≤ s.re) (hσ1 : s.re ≤ 1) (hY : 1 ≤ Y) :
    ‖detectorCriticalIntegral X s Y‖ ≤
      (16*Y^(1/2-σ)/(σ-1/2))*criticalMass X s.im := by
  apply (detectorCriticalIntegral_bound X s (hσ.trans_le hσs) hσ1 hY).trans
  apply mul_le_mul_of_nonneg_right _ (criticalMass_nonneg X s.im)
  calc
    _ ≤ (16*Y^(1/2-σ))/(s.re-1/2) := by
      apply div_le_div_of_nonneg_right _ (by linarith)
      exact mul_le_mul_of_nonneg_left
        (Real.rpow_le_rpow_of_exponent_le hY (by linarith)) (by norm_num)
    _ ≤ _ := div_le_div_of_nonneg_left (by positivity) (by linarith) (by linarith)

end Legendre.Density.Detector.Smooth
