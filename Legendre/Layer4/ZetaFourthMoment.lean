/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityFourthMoment.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The xi functional equation supplies the pointwise zeta bound.
This is a sixth-log estimate; it does not prove the sharp fourth-log formula.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiSmoothedMean
public import Legendre.Layer4.MomentCutoff
public import Legendre.ZeroDensity

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set
open Density Density.Moment

theorem zeta_critical_fourth_integrable (T : ℝ) :
    Integrable (fun t : ℝ => ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4)
      (volume.restrict (Icc (-T) T)) := by
  have hs : Continuous (fun t : ℝ => (1/2 : ℂ)+(t : ℂ)*I) := by fun_prop
  have hζ : Continuous (fun t : ℝ => riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)) := by
    apply continuous_iff_continuousAt.mpr
    intro t
    apply (differentiableAt_riemannZeta (by
      intro h
      have := congrArg Complex.re h
      norm_num at this)).continuousAt.comp hs.continuousAt
  exact (hζ.norm.pow 4).continuousOn.integrableOn_Icc

theorem zeta_fourth_moment_log_six :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (∫ t in Icc (-T) T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^6 := by
  obtain ⟨C,hC,hb⟩ := xiSmoothedZetaSquare_mean
  refine ⟨4*C*17*5^6, by positivity, ?_⟩
  intro T hT
  obtain ⟨N,hN,hL,hscale,hsize,hlog⟩ := moment_cutoff 1 (by norm_num) T hT
  norm_num only [Nat.cast_one,one_mul,one_pow] at hscale hsize hlog
  obtain ⟨hi,hm⟩ := hb N hN T (by linarith) hL hscale
  have hfirst : (∫ t in Icc (-T) T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
      4*(∫ t in Icc (-T) T, ‖xiSmoothedZetaSquare ((1/2 : ℂ)+(t : ℂ)*I)‖^2) := by
    rw [← integral_const_mul]
    apply integral_mono (zeta_critical_fourth_integrable T) (hi.const_mul 4)
    intro t
    exact riemannZeta_fourth_le_smoothed _ (by simp)
  have hlog0 : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  calc
    _ ≤ 4*(C*((N : ℝ)+T)*(Real.log N)^6) :=
      hfirst.trans (mul_le_mul_of_nonneg_left hm (by norm_num))
    _ ≤ 4*(C*(17*T)*(5*Real.log T)^6) := by
      apply mul_le_mul_of_nonneg_left _ (by norm_num)
      apply mul_le_mul _ (pow_le_pow_left₀ (by linarith) hlog 6) (by positivity) (by positivity)
      exact mul_le_mul_of_nonneg_left hsize hC.le
    _ = _ := by ring

/-- The positive-height interval inherits the symmetric fourth-moment bound. -/
theorem zeta_fourth_moment_positive_log_six :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤
        C*T*(Real.log T)^6 := by
  obtain ⟨C,hC,hb⟩ := zeta_fourth_moment_log_six
  refine ⟨C,hC,fun T hT => ?_⟩
  rw [intervalIntegral.integral_of_le (by linarith : (0 : ℝ) ≤ T),
    ← integral_Icc_eq_integral_Ioc]
  apply (setIntegral_mono_set (zeta_critical_fourth_integrable T)
    (by filter_upwards with t; positivity) ?_).trans (hb T hT)
  exact Filter.Eventually.of_forall (fun t ht => ⟨by linarith [ht.1],ht.2⟩)

/-- The height exponent is one with an arbitrarily small positive loss. -/
theorem zeta_fourth_moment_epsilon (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)‖^4) ≤ C*T^(1+ε) := by
  obtain ⟨C,hC,hb⟩ := zeta_fourth_moment_positive_log_six
  obtain ⟨D,hD,hlog⟩ := exists_log_pow_le_rpow 6 hε
  refine ⟨C*D,mul_pos hC hD,fun T hT => ?_⟩
  calc
    _ ≤ C*T*(Real.log T)^6 := hb T hT
    _ ≤ C*T*(D*T^ε) := mul_le_mul_of_nonneg_left (hlog T hT) (by positivity)
    _ = _ := by rw [Real.rpow_add (by linarith : 0 < T),Real.rpow_one]; ring

end Legendre.Zeta
