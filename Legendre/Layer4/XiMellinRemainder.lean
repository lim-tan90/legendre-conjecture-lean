/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.XiSmallGammaShift
public import Mathlib.Analysis.SpecialFunctions.Complex.Analytic

/-! Gaussian domination for the xi Mellin kernel after removal of its simple pole. -/

@[expose] public section
open Complex Metric
open Legendre.Density.Moment Legendre.Density.GammaBounds
namespace Legendre.Zeta

noncomputable def xiGaussianPole (N : ℝ) (w : ℂ) : ℂ :=
  (N : ℂ)^w*Complex.exp (w^2)/w

noncomputable def xiPoleRemainder (N : ℝ) (s w : ℂ) : ℂ :=
  xiMellinKernel s w-xiGaussianPole N w

noncomputable def xiPoleNormalizedDifference (N : ℝ) (s w : ℂ) : ℂ :=
  (N : ℂ)^(-w)*xiSquareKernelWeight s w-Complex.exp (w^2)

theorem xiPoleNormalizedDifference_zero (N : ℝ) {s : ℂ} (hs : s.re = 1/2) :
    xiPoleNormalizedDifference N s 0 = 0 := by
  have hn : s*(s-1) ≠ 0 := by
    apply mul_ne_zero
    · intro h; simp [h] at hs
    · intro h
      have h' := sub_eq_zero.mp h
      simp [h'] at hs
  simp [xiPoleNormalizedDifference, xiSquareKernelWeight, gammaSquareGaussianWeight,
    hn,Gammaℝ_ne_zero_of_re_pos (by linarith : 0 < s.re)]

theorem xiPoleNormalizedDifference_analytic (N : ℝ) (hN : 0 < N) {s w : ℂ}
    (h : 0 < (s+w).re) : AnalyticAt ℂ (xiPoleNormalizedDifference N s) w := by
  have hg := (gammaReal_analytic_of_re_pos h).comp (analyticAt_const.add analyticAt_id)
  have hp : AnalyticAt ℂ (fun z : ℂ => (s+z)*(s+z-1)/(s*(s-1))) w :=
    ((analyticAt_const.add analyticAt_id).mul
      ((analyticAt_const.add analyticAt_id).sub analyticAt_const)).div_const
  have hpow : AnalyticAt ℂ (fun z : ℂ => (N : ℂ)^(-z)) w :=
    analyticAt_const.cpow analyticAt_id.neg
      (Complex.ofReal_mem_slitPlane.mpr hN)
  have he : AnalyticAt ℂ (fun z : ℂ => Complex.exp (z^2)) w := (analyticAt_id.pow 2).cexp
  exact (hpow.mul ((hp.pow 2).mul ((hg.div_const.pow 2).mul he))).sub he

/-- The near-pole cancellation is uniform on a shell where the height is
comparable to the finite head length. -/
theorem xiPoleNormalizedDifference_ball_bound {N T : ℝ} (hT : 1 ≤ T)
    (hNlo : 10*T ≤ N) (hNhi : N ≤ 16*T) {s w : ℂ}
    (hs : s.re = 1/2) (ht₁ : T/2 ≤ |s.im|) (ht₂ : |s.im| ≤ T)
    (hw : ‖w‖ < 1/4) :
    ‖xiPoleNormalizedDifference N s w‖ ≤
      1024*Real.pi*Real.exp (60+|Real.eulerMascheroniConstant|)+Real.exp 1 := by
  have hN : 0 < N := by linarith
  have hP := pow_le_pow_left₀ (norm_nonneg _)
    (xi_polynomial_shift_ratio_le hs w) 2
  have hP' : ‖((s+w)*(s+w-1)/(s*(s-1)))‖^2 ≤ 16 := by
    have he : (1+2*‖w‖)^4 ≤ (2 : ℝ)^4 := by gcongr; linarith
    have hp : ((1+2*‖w‖)^2)^2 ≤ 16 := by rw [← pow_mul]; exact he.trans_eq (by norm_num)
    exact hP.trans hp
  have hE : ‖Complex.exp (w^2)‖ ≤ Real.exp 1 := by
    rw [Complex.norm_exp]
    apply Real.exp_le_exp.mpr
    exact (re_le_norm _).trans (by rw [norm_pow]; nlinarith [norm_nonneg w])
  have hγ := gammaReal_small_shift_signed hs hw
  let X := |s.im|/2+2
  have hX : 0 < X := by dsimp [X]; positivity
  have hXlo : (1/64 : ℝ) ≤ X/N := (le_div_iff₀ hN).2 (by dsimp [X]; linarith)
  have hXhi : X/N ≤ 1 := (div_le_one hN).2 (by dsimp [X]; linarith)
  have hx := (abs_re_le_norm w).trans_lt hw
  have hXp : (X/N)^w.re ≤ 64 := by
    calc
      _ ≤ (X/N)^(-1 : ℝ) := Real.rpow_le_rpow_of_exponent_ge
        (div_pos hX hN) hXhi (by linarith [abs_lt.mp hx])
      _ ≤ (1/64 : ℝ)^(-1 : ℝ) :=
        Real.rpow_le_rpow_of_nonpos (by norm_num) hXlo (by norm_num)
      _ = _ := by norm_num
  have hQ : X^w.re*N^(-w.re) = (X/N)^w.re := by
    rw [Real.div_rpow hX.le hN.le, Real.rpow_neg hN.le, div_eq_mul_inv]
  have hterm : ‖(N : ℂ)^(-w)*xiSquareKernelWeight s w‖ ≤
      1024*Real.pi*Real.exp (60+|Real.eulerMascheroniConstant|) := by
    rw [xiSquareKernelWeight, gammaSquareGaussianWeight, norm_mul, norm_mul, norm_mul,
      norm_pow,norm_pow,norm_cpow_eq_rpow_re_of_pos hN,neg_re]
    calc
      _ ≤ N^(-w.re)*(16*((Real.pi*Real.exp (59+|Real.eulerMascheroniConstant|))*X^w.re
          *Real.exp 1)) := by gcongr
      _ = (16*Real.pi*Real.exp (60+|Real.eulerMascheroniConstant|))*(X/N)^w.re := by
        rw [← hQ, show (60 : ℝ)+|Real.eulerMascheroniConstant| =
            (59+|Real.eulerMascheroniConstant|)+1 by ring, Real.exp_add (59+|Real.eulerMascheroniConstant|) 1]
        ring
      _ ≤ _ := by
        have hh := mul_le_mul_of_nonneg_left hXp
          (show 0 ≤ 16*Real.pi*Real.exp (60+|Real.eulerMascheroniConstant|) by positivity)
        convert hh using 1
        ring
  refine (norm_sub_le _ _).trans ?_
  exact add_le_add hterm hE

theorem xiPoleRemainder_small {N T : ℝ} (hT : 1 ≤ T)
    (hNlo : 10*T ≤ N) (hNhi : N ≤ 16*T) {s w : ℂ}
    (hs : s.re = 1/2) (ht₁ : T/2 ≤ |s.im|) (ht₂ : |s.im| ≤ T)
    (hw : ‖w‖ < 1/4) (hw0 : w ≠ 0) :
    ‖xiPoleRemainder N s w‖ ≤
      4*(1024*Real.pi*Real.exp (60+|Real.eulerMascheroniConstant|)+Real.exp 1)*N^w.re := by
  have hN : 0 < N := by linarith
  let F := xiPoleNormalizedDifference N s
  let B := 1024*Real.pi*Real.exp (60+|Real.eulerMascheroniConstant|)+Real.exp 1
  have hF0 : F 0 = 0 := xiPoleNormalizedDifference_zero N hs
  have hd : DifferentiableOn ℂ F (ball (0 : ℂ) (1/4)) := by
    intro z hz
    have hn : ‖z‖ < 1/4 := by simpa [Metric.mem_ball,dist_zero_right] using hz
    have hr := (abs_re_le_norm z).trans_lt hn
    apply (xiPoleNormalizedDifference_analytic N hN _).differentiableAt.differentiableWithinAt
    simp only [add_re]
    linarith [(abs_lt.mp hr).1]
  have hm : Set.MapsTo F (ball (0 : ℂ) (1/4)) (closedBall (F 0) B) := by
    intro z hz
    have hn : ‖z‖ < 1/4 := by simpa [Metric.mem_ball,dist_zero_right] using hz
    simpa [Metric.mem_closedBall,hF0,dist_zero_right] using
      xiPoleNormalizedDifference_ball_bound hT hNlo hNhi hs ht₁ ht₂ hn
  have ha := Complex.norm_dslope_le_div_of_mapsTo_ball hd hm
    (show w ∈ ball (0 : ℂ) (1/4) by simpa [Metric.mem_ball,dist_zero_right] using hw)
  rw [dslope_of_ne _ hw0,slope_def_module,sub_zero,hF0,sub_zero,smul_eq_mul,← div_eq_inv_mul] at ha
  have he : xiPoleRemainder N s w = (N : ℂ)^w*(F w/w) := by
    have hpow : (N : ℂ)^w*(N : ℂ)^(-w) = 1 := by
      rw [← Complex.cpow_add _ _ (by exact_mod_cast hN.ne'),add_neg_cancel,cpow_zero]
    dsimp [xiPoleRemainder, xiMellinKernel, xiGaussianPole, F, xiPoleNormalizedDifference]
    rw [← sub_div, ← mul_div_assoc, mul_sub, ← mul_assoc, hpow, one_mul]
  rw [he,norm_mul,norm_cpow_eq_rpow_re_of_pos hN]
  have hh := mul_le_mul_of_nonneg_left ha (Real.rpow_nonneg hN.le w.re)
  convert hh using 1
  dsimp [B]
  ring

/-- On a height shell the pole-subtracted Mellin kernel is dominated by a
fixed Gaussian, without any inverse factor in the contour width. -/
theorem xiPoleRemainder_gaussian_bound :
    ∃ K : ℝ, 0 < K ∧ ∀ (N T c t u : ℝ), 1 ≤ T → 10*T ≤ N → N ≤ 16*T →
      0 < c → c ≤ 1 → T/2 ≤ |t| → |t| ≤ T →
      ‖xiPoleRemainder N ((1/2 : ℂ)+(t : ℂ)*I) ((c : ℂ)+(u : ℂ)*I)‖ ≤
        K*N^c*momentGaussian u := by
  let B := 1024*Real.pi*Real.exp (60+|Real.eulerMascheroniConstant|)+Real.exp 1
  have hB : 0 < B := by dsimp only [B]; positivity
  refine ⟨4*B*Real.exp 1+4*(xiMellinConstant+Real.exp 1),
    by have := xiMellinConstant_pos; positivity,?_⟩
  intro N T c t u hT hNlo hNhi hc hc1 ht₁ ht₂
  let s : ℂ := (1/2 : ℂ)+(t : ℂ)*I
  let w : ℂ := (c : ℂ)+(u : ℂ)*I
  have hs : s.re = 1/2 := by simp [s]
  have hsi : s.im = t := by simp [s]
  have hwr : w.re = c := by simp [w]
  have hwi : w.im = u := by simp [w]
  have hw0 : w ≠ 0 := by
    intro h
    have hz := congrArg Complex.re h
    rw [hwr,zero_re] at hz
    linarith
  have hN : 0 < N := by linarith
  have hG : 0 < momentGaussian u := momentGaussian_pos _
  have hdiv : ‖xiPoleRemainder N s w‖ =
      ‖xiSquareKernelWeight s w-(N : ℂ)^w*Complex.exp (w^2)‖/‖w‖ := by
    rw [xiPoleRemainder,xiMellinKernel,xiGaussianPole,← sub_div,norm_div]
  change ‖xiPoleRemainder N s w‖ ≤ _
  by_cases hn : ‖w‖ < 1/4
  · have h := xiPoleRemainder_small hT hNlo hNhi hs
      (by simpa only [hsi] using ht₁) (by simpa only [hsi] using ht₂) hn hw0
    rw [hwr] at h
    have hu := (abs_im_le_norm w).trans_lt hn
    rw [hwi] at hu
    have hge : Real.exp (-1) ≤ momentGaussian u := by
      unfold momentGaussian
      apply Real.exp_le_exp.mpr
      have hsq := pow_le_pow_left₀ (abs_nonneg u) hu.le 2
      rw [sq_abs] at hsq
      linarith
    have hp := mul_le_mul_of_nonneg_left hge (show 0 ≤ Real.exp 1 by positivity)
    rw [← Real.exp_add,add_neg_cancel,Real.exp_zero] at hp
    calc
      _ ≤ 4*B*N^c := h
      _ ≤ 4*B*N^c*(Real.exp 1*momentGaussian u) := by
        simpa only [mul_one] using mul_le_mul_of_nonneg_left hp (by positivity : 0 ≤ 4*B*N^c)
      _ ≤ _ := by
        have hc₀ : 0 ≤ 4*(xiMellinConstant+Real.exp 1) := by
          have := xiMellinConstant_pos
          positivity
        nlinarith [mul_nonneg hc₀ (show 0 ≤ N^c*momentGaussian u by positivity)]
  · have hwide : (1/4 : ℝ) ≤ ‖w‖ := le_of_not_gt hn
    have hRe : (w^2).re = c^2-u^2 := by
      rw [pow_two,mul_re,hwr,hwi]
      ring
    have he : ‖Complex.exp (w^2)‖ ≤ Real.exp 1*momentGaussian u := by
      rw [Complex.norm_exp,hRe,momentGaussian,← Real.exp_add]
      exact Real.exp_le_exp.mpr (by nlinarith)
    have hb := xiSquareKernelWeight_bound hs w (by rw [hwr]; exact hc.le)
      (by rw [hwr]; linarith)
    rw [hsi,hwi,hwr] at hb
    have hP := xi_shift_polynomial_bound hc.le hc1 u
    have hNpow := Real.rpow_le_rpow (by positivity : 0 ≤ |t|+2)
      (by linarith : |t|+2 ≤ N) hc.le
    have hprod :=
      mul_le_mul (mul_le_mul (mul_le_mul_of_nonneg_right hP
        (show 0 ≤ gammaGaussianConstant by unfold gammaGaussianConstant; positivity)) hNpow
        (by positivity) (by unfold gammaGaussianConstant; positivity))
        (le_rfl : Real.exp (-(u^2)/2) ≤ Real.exp (-(u^2)/2))
        (by positivity) (by unfold gammaGaussianConstant; positivity)
    have hW : ‖xiSquareKernelWeight s w‖ ≤ xiMellinConstant*N^c*momentGaussian u := by
      calc
        _ ≤ 169*(1+u^2)^2*gammaGaussianConstant*N^c*Real.exp (-(u^2)/2) := hb.trans hprod
        _ = (169*gammaGaussianConstant*N^c)*((1+u^2)^2*Real.exp (-(u^2)/2)) := by ring
        _ ≤ (169*gammaGaussianConstant*N^c)*(64*momentGaussian u) :=
          mul_le_mul_of_nonneg_left (polynomial_gaussian_absorb u)
            (by unfold gammaGaussianConstant; positivity)
        _ = _ := by unfold xiMellinConstant; ring
    have hGpole : ‖(N : ℂ)^w*Complex.exp (w^2)‖ ≤ N^c*(Real.exp 1*momentGaussian u) := by
      rw [norm_mul,norm_cpow_eq_rpow_re_of_pos hN,hwr]
      exact mul_le_mul_of_nonneg_left he (Real.rpow_nonneg hN.le c)
    have hsum := (norm_sub_le (xiSquareKernelWeight s w) ((N : ℂ)^w*Complex.exp (w^2))).trans
      (add_le_add hW hGpole)
    rw [hdiv]
    calc
      _ ≤ ‖xiSquareKernelWeight s w-(N : ℂ)^w*Complex.exp (w^2)‖/(1/4 : ℝ) :=
        div_le_div_of_nonneg_left (norm_nonneg _) (by norm_num) hwide
      _ ≤ (xiMellinConstant*N^c*momentGaussian u+N^c*(Real.exp 1*momentGaussian u))/(1/4 : ℝ) :=
        div_le_div_of_nonneg_right hsum (by norm_num)
      _ ≤ _ := by
        nlinarith [mul_nonneg (show 0 ≤ 4*B*Real.exp 1 by positivity)
          (show 0 ≤ N^c*momentGaussian u by positivity)]

end Legendre.Zeta
