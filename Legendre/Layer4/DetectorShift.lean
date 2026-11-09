/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The vertical-limit organization adapts DensityDetectorShift.lean in openai/math,
commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The zeta specialization adds the principal-pole term with its exact sign.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorRectangle
public import Legendre.Layer4.DetectorHorizontal

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory Filter Set
open scoped Topology

theorem detector_zero_contour_shift (X : ℕ) {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s = 0) (hσ : 1/2 < s.re) (hσ1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) :
    (∫ u : ℝ, detectorIntegrand X s Y (2+(u : ℂ)*I)) =
      (∫ u : ℝ, detectorIntegrand X s Y (((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I))+
        (2*(Real.pi : ℂ))*detectorPrincipalPole X s Y := by
  let a := 1/2-s.re
  let f := detectorIntegrand X s Y
  have hab : a ≤ 2 := by dsimp [a]; linarith
  obtain ⟨htop,hbot⟩ := detector_horizontal_tendsto X s hσ.le hσ1 hY
  have hr := intervalIntegral_tendsto_integral (detector_right_integrable X s hσ.le hσ1 hY)
    tendsto_neg_atTop_atBot tendsto_id
  have hl := intervalIntegral_tendsto_integral (detector_left_integrable X s hσ hσ1 hY)
    tendsto_neg_atTop_atBot tendsto_id
  have hlim : Tendsto (fun T : ℝ => Zeta.xiRectangleIntegral f a 2 (-T) T) atTop
      (𝓝 (I*(∫ u : ℝ, f (2+(u : ℂ)*I))-
        I*(∫ u : ℝ, f ((a : ℂ)+(u : ℂ)*I)))) := by
    simpa [f,a,Zeta.xiRectangleIntegral,RectangleIntegral,HIntegral,VIntegral,smul_eq_mul] using
      ((hbot.sub htop).add (hr.const_mul I)).sub (hl.const_mul I)
  have hrect : ∀ᶠ T : ℝ in atTop,
      Zeta.xiRectangleIntegral f a 2 (-T) T = (2*(Real.pi : ℂ)*I)*detectorPrincipalPole X s Y := by
    filter_upwards [eventually_gt_atTop (|s.im|+1)] with T hT
    have hTp : 0 < T := by linarith [abs_nonneg s.im]
    have hnhds (p : ℂ) (hpa : a < p.re) (hpb : p.re < 2)
        (hpc : -T < p.im) (hpd : p.im < T) :
        Rectangle ((a : ℂ)+(-T : ℝ)*I) (2+(T : ℂ)*I) ∈ 𝓝 p := by
      rw [rectangle_mem_nhds_iff,Complex.mem_reProdIm]
      simp only [add_re,ofReal_re,mul_re,I_re,I_im,ofReal_im,mul_zero,
        sub_self,add_zero,add_im,mul_im,mul_one,zero_add,re_ofNat,im_ofNat]
      rw [uIoo_of_le hab,uIoo_of_le (by linarith : -T ≤ T)]
      exact ⟨⟨hpa,hpb⟩,hpc,hpd⟩
    apply detector_rectangle_principal X hs hz (by linarith)
      ((a : ℂ)+(-T : ℝ)*I) (2+(T : ℂ)*I)
    · simpa using hab
    · simp; linarith
    · simp [a]; linarith
    · exact hnhds 0 (by simp [a]; linarith) (by norm_num) (by simp; linarith) (by simp; linarith)
    · apply hnhds (1-s)
      · simp [a]; linarith
      · simp; linarith
      · simp; linarith [le_abs_self s.im]
      · simp; linarith [neg_abs_le s.im]
  have hcongr : (fun _ : ℝ => (2*(Real.pi : ℂ)*I)*detectorPrincipalPole X s Y) =ᶠ[atTop]
      (fun T : ℝ => Zeta.xiRectangleIntegral f a 2 (-T) T) := by
    filter_upwards [hrect] with T hT
    exact hT.symm
  have he := tendsto_nhds_unique hlim (tendsto_const_nhds.congr' hcongr)
  change (∫ u : ℝ, f (2+(u : ℂ)*I)) =
    (∫ u : ℝ, f ((a : ℂ)+(u : ℂ)*I))+(2*(Real.pi : ℂ))*detectorPrincipalPole X s Y
  apply sub_eq_zero.mp
  apply mul_left_cancel₀ I_ne_zero
  linear_combination he

theorem detectorMean_at_zero (X : ℕ) {s : ℂ} (hs : s ≠ 1) (hz : riemannZeta s = 0)
    (hσ : 1/2 < s.re) (hσ1 : s.re ≤ 1) {Y : ℝ} (hY : 1 ≤ Y) :
    detectorMean X s Y = detectorPrincipalPole X s Y+
      (2*(Real.pi : ℂ))⁻¹*∫ u : ℝ,
        detectorIntegrand X s Y (((1/2-s.re : ℝ) : ℂ)+(u : ℂ)*I) := by
  rw [detectorMean_eq_integral X s (by linarith) Y (by linarith)]
  have hc : (((1/(2*Real.pi) : ℝ) : ℂ)) = (2*(Real.pi : ℂ))⁻¹ := by simp
  rw [hc]
  change (2*(Real.pi : ℂ))⁻¹*(∫ u : ℝ, detectorIntegrand X s Y (2+(u : ℂ)*I)) = _
  rw [detector_zero_contour_shift X hs hz hσ hσ1 hY,mul_add]
  have hp : (2*(Real.pi : ℂ)) ≠ 0 := by simp [Real.pi_ne_zero]
  field_simp
  simp_rw [mul_comm I]
  ring

end Legendre.Density.Detector.Smooth
