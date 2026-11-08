/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The positive-line kernel organization adapts DensitySmoothedKernel.lean,
DensityKernelStrip.lean, DensityKernelLineBound.lean and DensityKernelCost.lean from openai/math,
commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The polynomial shift factor of the entire xi square is absorbed into a wider
Gaussian without changing the base-height exponent.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.XiSquareContour
public import Legendre.Layer4.MomentGaussian
public import Mathlib.Analysis.SpecialFunctions.Gamma.Deligne

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory
open Density.Moment

noncomputable def xiMellinKernel (s w : ℂ) : ℂ := xiSquareKernelWeight s w/w

theorem xiSmoothedZetaSquare_integral {s : ℂ} (hs : s.re = 1/2) :
    xiSmoothedZetaSquare s = (2*(Real.pi : ℂ))⁻¹*
      ∫ u : ℝ, xiMellinKernel s (1+(u : ℂ)*I)*riemannZeta (s+(1+(u : ℂ)*I))^2 := by
  unfold xiSmoothedZetaSquare xiSquareIntegral
  rw [mul_div_assoc,← integral_div]
  congr 1
  apply integral_congr_ae
  filter_upwards with u
  calc
    _ = (xiSquareGaussian s (1+(u : ℂ)*I)/xiSquareNormalizer s)/(1+(u : ℂ)*I) := by
      unfold xiSquareContour
      ring
    _ = _ := by rw [xiSquareGaussian_normalized hs u]; unfold xiMellinKernel; ring

theorem xi_shift_polynomial_bound {c : ℝ} (hc : 0 ≤ c) (hc1 : c ≤ 1) (u : ℝ) :
    (1+2*‖(c : ℂ)+(u : ℂ)*I‖)^4 ≤ 169*(1+u^2)^2 := by
  have hn : ‖(c : ℂ)+(u : ℂ)*I‖ ≤ 1+|u| := by
    have h := norm_add_le (c : ℂ) ((u : ℂ)*I)
    simp only [norm_mul,Complex.norm_real,Real.norm_eq_abs,norm_I,mul_one,
      abs_of_nonneg hc] at h
    linarith
  have hp : 0 ≤ 1+2*‖(c : ℂ)+(u : ℂ)*I‖ := by positivity
  have hsq := pow_le_pow_left₀ hp (by linarith :
    1+2*‖(c : ℂ)+(u : ℂ)*I‖ ≤ 3+2*|u|) 2
  have hb : (1+2*‖(c : ℂ)+(u : ℂ)*I‖)^2 ≤ 13*(1+u^2) := by
    nlinarith [sq_nonneg (3*|u|-2),sq_abs u]
  have h := pow_le_pow_left₀ (sq_nonneg _) hb 2
  nlinarith

theorem polynomial_gaussian_absorb (u : ℝ) :
    (1+u^2)^2*Real.exp (-(u^2)/2) ≤ 64*momentGaussian u := by
  have he := Real.add_one_le_exp (u^2/8)
  have hp : 1+u^2 ≤ 8*Real.exp (u^2/8) := by linarith
  have hsq := pow_le_pow_left₀ (by positivity : 0 ≤ 1+u^2) hp 2
  have hmul := mul_le_mul_of_nonneg_right hsq (Real.exp_nonneg (-(u^2)/2))
  apply hmul.trans_eq
  unfold momentGaussian
  rw [mul_pow,← Real.exp_nat_mul,mul_assoc,← Real.exp_add]
  norm_num
  ring

theorem xiMellinKernel_short_line {s : ℂ} (hs : s.re = 1/2) (c u : ℝ)
    (hc : 0 < c) (hc1 : c ≤ 1) :
    ‖xiMellinKernel s ((c : ℂ)+(u : ℂ)*I)‖ ≤
      (10816*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)^c/c)*momentGaussian u := by
  have hb := xiSquareKernelWeight_bound hs ((c : ℂ)+(u : ℂ)*I)
    (by simp; linarith) (by simp; linarith)
  simp only [add_re,ofReal_re,mul_re,I_re,I_im,ofReal_im,mul_zero,
    sub_self,add_zero,add_im,mul_im,mul_one,zero_add] at hb
  have hn : c ≤ ‖(c : ℂ)+(u : ℂ)*I‖ := by
    simpa using Complex.re_le_norm ((c : ℂ)+(u : ℂ)*I)
  have hC : 0 < Density.GammaBounds.gammaGaussianConstant := by
    unfold Density.GammaBounds.gammaGaussianConstant
    exact Real.exp_pos _
  have hP := mul_le_mul_of_nonneg_right (xi_shift_polynomial_bound hc.le hc1 u)
    (show 0 ≤ Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)^c*
      Real.exp (-(u^2)/2) by positivity)
  have hG := mul_le_mul_of_nonneg_left (polynomial_gaussian_absorb u)
    (show 0 ≤ 169*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)^c by positivity)
  have hTotal : (1+2*‖(c : ℂ)+(u : ℂ)*I‖)^4*
      Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)^c*Real.exp (-(u^2)/2) ≤
      10816*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)^c*momentGaussian u := by
    calc
      _ ≤ 169*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)^c*
          ((1+u^2)^2*Real.exp (-(u^2)/2)) := by convert! hP using 1 <;> ring
      _ ≤ _ := by convert! hG using 1; ring
  rw [xiMellinKernel,norm_div]
  apply (div_le_div_of_nonneg_left (norm_nonneg _) hc hn).trans
  exact ((div_le_div_of_nonneg_right hb hc.le).trans
    (div_le_div_of_nonneg_right hTotal hc.le)).trans_eq (by ring)

theorem gammaReal_analytic_of_re_pos {z : ℂ} (hz : 0 < z.re) : AnalyticAt ℂ Gammaℝ z := by
  have h := (differentiable_Gammaℝ_inv.analyticAt z).inv
    (inv_ne_zero (Gammaℝ_ne_zero_of_re_pos hz))
  simpa only [Pi.inv_def,inv_inv] using! h

theorem xiMellinKernel_analytic {s w : ℂ} (hs : s.re = 1/2) (hw : 0 < w.re) :
    AnalyticAt ℂ (xiMellinKernel s) w := by
  have hg := (gammaReal_analytic_of_re_pos (z := s+w) (by simp only [add_re]; linarith)).comp
    (analyticAt_const.add analyticAt_id)
  have hp : AnalyticAt ℂ (fun z : ℂ => (s+z)*(s+z-1)/(s*(s-1))) w :=
    ((analyticAt_const.add analyticAt_id).mul
      ((analyticAt_const.add analyticAt_id).sub analyticAt_const)).div_const
  have hwn : w ≠ 0 := by intro he; simp [he] at hw
  have hG : AnalyticAt ℂ (fun z : ℂ => (Gammaℝ (s+z)/Gammaℝ s)^2*Complex.exp (z^2)) w :=
    ((hg.div_const (c := Gammaℝ s)).pow 2).mul ((analyticAt_id.pow 2).cexp)
  exact ((hp.pow 2).mul hG).div analyticAt_id hwn

theorem xiMellinKernel_strip_bound {s : ℂ} (hs : s.re = 1/2) (c x u : ℝ)
    (hc : 0 < c) (hcx : c ≤ x) (hx : x ≤ 1) :
    ‖xiMellinKernel s ((x : ℂ)+(u : ℂ)*I)‖ ≤
      (10816*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)/c)*momentGaussian u := by
  have hC : 0 < Density.GammaBounds.gammaGaussianConstant := by
    unfold Density.GammaBounds.gammaGaussianConstant
    exact Real.exp_pos _
  have hpow : (|s.im|+2)^x ≤ |s.im|+2 := by
    apply (Real.rpow_le_rpow_of_exponent_le (by linarith [abs_nonneg s.im] : 1 ≤ |s.im|+2) hx).trans_eq
    exact Real.rpow_one _
  have hnum := mul_le_mul_of_nonneg_left hpow
    (show 0 ≤ 10816*Density.GammaBounds.gammaGaussianConstant by positivity)
  have hden := div_le_div_of_nonneg_left
    (show 0 ≤ 10816*Density.GammaBounds.gammaGaussianConstant*(|s.im|+2)^x by positivity) hc hcx
  apply (xiMellinKernel_short_line hs x u (hc.trans_le hcx) hx).trans
  exact mul_le_mul_of_nonneg_right
    (hden.trans (div_le_div_of_nonneg_right hnum hc.le)) (momentGaussian_pos u).le

noncomputable def xiMellinConstant : ℝ := 10816*Density.GammaBounds.gammaGaussianConstant

noncomputable def xiMellinCost (T c : ℝ) : ℝ := xiMellinConstant*(10*T)^c/c

theorem xiMellinConstant_pos : 0 < xiMellinConstant := by
  unfold xiMellinConstant Density.GammaBounds.gammaGaussianConstant
  positivity

theorem xiMellinCost_pos {T c : ℝ} (hT : 1 ≤ T) (hc : 0 < c) : 0 < xiMellinCost T c := by
  unfold xiMellinCost
  exact div_pos (mul_pos xiMellinConstant_pos (Real.rpow_pos_of_pos (by linarith) c)) hc

theorem xiMellinKernel_common_bound (T c t u : ℝ) (hT : 1 ≤ T) (hc : 0 < c)
    (hc1 : c ≤ 1) (ht : |t| ≤ T) :
    ‖xiMellinKernel ((1/2 : ℂ)+(t : ℂ)*I) ((c : ℂ)+(u : ℂ)*I)‖ ≤
      xiMellinCost T c*momentGaussian u := by
  apply (xiMellinKernel_short_line (s := (1/2 : ℂ)+(t : ℂ)*I) (by simp) c u hc hc1).trans
  apply mul_le_mul_of_nonneg_right _ (momentGaussian_pos u).le
  unfold xiMellinCost xiMellinConstant
  apply div_le_div_of_nonneg_right _ hc.le
  apply mul_le_mul_of_nonneg_left _ (by unfold Density.GammaBounds.gammaGaussianConstant; positivity)
  apply Real.rpow_le_rpow (by positivity) _ hc.le
  simpa using (by linarith : |t|+2 ≤ 10*T)

end Legendre.Zeta
