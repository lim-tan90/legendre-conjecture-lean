/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The growth-bound organization adapts DensityMollifierBound.lean from
openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The local zeta estimate explicitly stays a positive distance from its pole.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorAnalytic

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory Set
open scoped ArithmeticFunction.Moebius

theorem zeta_strip_away_bound {z : ℂ} (hz : 1/2 ≤ z.re) (hz3 : z.re ≤ 3)
    (hd : 1/2 ≤ ‖z-1‖) : ‖riemannZeta z‖ ≤ 4*(3+|z.im|) := by
  have hz1 : z ≠ 1 := by intro h; rw [h] at hd; norm_num at hd
  have h := Zeta.norm_riemannZeta_le_positive_re (by linarith) hz1
  have h1 : ‖z‖/‖z-1‖ ≤ 2*‖z‖ := by
    have hh := div_le_div_of_nonneg_left (norm_nonneg z) (by norm_num : (0 : ℝ) < 1/2) hd
    linarith
  have h2 : ‖z‖/z.re ≤ 2*‖z‖ := by
    have hh := div_le_div_of_nonneg_left (norm_nonneg z) (by norm_num : (0 : ℝ) < 1/2) hz
    linarith
  have hn : ‖z‖ ≤ 3+|z.im| := by
    have hh := norm_le_abs_re_add_abs_im z
    rw [abs_of_pos (by linarith : 0 < z.re)] at hh
    linarith
  linarith

noncomputable def detectorGrowthCost (X : ℕ) (s : ℂ) (Y : ℝ) : ℝ :=
  16*(X : ℝ)*Y^2*(1+|s.im|)

theorem detector_numerator_bound (X : ℕ) (s : ℂ) (hs1 : s.re ≤ 1)
    {Y : ℝ} (hY : 1 ≤ Y) (x u : ℝ) (hx : 1/2-s.re ≤ x) (hx2 : x ≤ 2)
    (hd : 1/2 ≤ ‖s+((x : ℂ)+(u : ℂ)*I)-1‖) :
    ‖riemannZeta (s+((x : ℂ)+(u : ℂ)*I))*
      finiteSeries (μ : ArithmeticFunction ℂ) X (s+((x : ℂ)+(u : ℂ)*I))*
      (Y : ℂ)^((x : ℂ)+(u : ℂ)*I)‖ ≤ detectorGrowthCost X s Y*(1+|u|) := by
  have hz : 1/2 ≤ (s+((x : ℂ)+(u : ℂ)*I)).re := by simp; linarith
  have hz3 : (s+((x : ℂ)+(u : ℂ)*I)).re ≤ 3 := by simp; linarith
  have hL := zeta_strip_away_bound hz hz3 hd
  have hM := norm_mollifier_finiteSeries_le X (by linarith : 0 ≤ (s+((x : ℂ)+(u : ℂ)*I)).re)
  have hpow : ‖(Y : ℂ)^((x : ℂ)+(u : ℂ)*I)‖ ≤ Y^2 := by
    rw [Complex.norm_cpow_eq_rpow_re_of_pos (by linarith : 0 < Y)]
    simp only [add_re,ofReal_re,mul_re,ofReal_im,I_re,I_im,mul_zero,zero_mul,sub_self,add_zero]
    rw [← Real.rpow_two]
    exact Real.rpow_le_rpow_of_exponent_le hY hx2
  have him : |(s+((x : ℂ)+(u : ℂ)*I)).im| ≤ |s.im|+|u| := by
    simpa using abs_add_le s.im u
  have hb : 4*(3+|(s+((x : ℂ)+(u : ℂ)*I)).im|) ≤ 16*(1+|s.im|)*(1+|u|) := by
    nlinarith [abs_nonneg s.im,abs_nonneg u,mul_nonneg (abs_nonneg s.im) (abs_nonneg u)]
  rw [norm_mul,norm_mul]
  have hh := mul_le_mul (mul_le_mul (hL.trans hb) hM (norm_nonneg _) (by positivity)) hpow
    (norm_nonneg _) (by positivity)
  convert hh using 1; unfold detectorGrowthCost; ring

theorem detectorIntegrand_line_continuous (X : ℕ) (s : ℂ) {Y : ℝ} (hY : 0 < Y)
    (x : ℝ) (hsx : s.re+x ≠ 1) (hx0 : x ≠ 0) (hx1 : x ≠ -1) (hx2 : x ≠ -2) :
    Continuous (fun u : ℝ => detectorIntegrand X s Y ((x : ℂ)+(u : ℂ)*I)) := by
  have hline : Continuous (fun u : ℝ => (x : ℂ)+(u : ℂ)*I) := by fun_prop
  have hζ : Continuous (fun u : ℝ => riemannZeta (s+((x : ℂ)+(u : ℂ)*I))) := by
    apply continuous_iff_continuousAt.mpr
    intro u
    apply (differentiableAt_riemannZeta (by
      intro h
      apply hsx
      have := congrArg Complex.re h
      simpa using this)).continuousAt.comp (continuous_const.add hline).continuousAt
  have hM : Continuous (fun w : ℂ => finiteSeries (μ : ArithmeticFunction ℂ) X (s+w)) :=
    continuous_iff_continuousAt.mpr (fun w => (mollifier_shift_analytic X s w).continuousAt)
  have hP : Continuous (fun w : ℂ => (Y : ℂ)^w) :=
    (differentiable_id.const_cpow (Or.inl (by exact_mod_cast hY.ne'))).continuous
  have hK : Continuous (fun u : ℝ => detectorKernel ((x : ℂ)+(u : ℂ)*I)) := by
    unfold detectorKernel
    apply continuous_const.div (by fun_prop)
    intro u
    apply mul_ne_zero
    · apply mul_ne_zero
      · intro h
        apply hx0
        simpa using congrArg Complex.re h
      · intro h
        apply hx1
        have := congrArg Complex.re h
        simp at this
        linarith
    · intro h
      apply hx2
      have := congrArg Complex.re h
      norm_num at this
      linarith
  exact ((hζ.mul (hM.comp hline)).mul (hP.comp hline)).mul hK

end Legendre.Density.Detector.Smooth
