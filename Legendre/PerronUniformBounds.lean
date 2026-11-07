/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronGoodHeight
public import Legendre.ZetaPerronLeft
public import Legendre.ZetaFullGoodHeightBounds

/-!
# Uniform bounds for all three retained Perron sides

The fixed negative vertical side contributes O(x^(-1/8) log^2(T+5)).
The complete horizontal sides contribute O(log^2(H) max(x^(-1/8),x^σ)/T).
All coefficients are independent of H,T,x and σ.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology MeasureTheory Set

/-- The elementary even reciprocal integral governing the left side. -/
theorem integral_one_div_one_add_abs {T : ℝ} (hT : 0 ≤ T) :
    (∫ t : ℝ in -T..T, 1/(1+|t|)) = 2*Real.log (1+T) := by
  have hc : Continuous (fun t : ℝ => 1/(1+|t|)) :=
    continuous_const.div (continuous_const.add continuous_abs) (fun t => by positivity)
  have hi : IntervalIntegrable (fun t : ℝ => 1/(1+t)) volume 0 T := by
    apply ContinuousOn.intervalIntegrable
    intro t ht
    rw [uIcc_of_le hT] at ht
    exact (continuousAt_const.div (continuousAt_const.add continuousAt_id)
      (by linarith [ht.1] : 1+t ≠ 0)).continuousWithinAt
  have hd (t : ℝ) (ht : t ∈ uIcc (0 : ℝ) T) :
      HasDerivAt (fun u : ℝ => Real.log (1+u)) (1/(1+t)) t := by
    rw [uIcc_of_le hT] at ht
    convert! (Real.hasDerivAt_log (by linarith [ht.1] : 1+t ≠ 0)).comp t
      ((hasDerivAt_id t).const_add 1) using 1
    simp
  have hpos : (∫ t : ℝ in 0..T, 1/(1+|t|)) = Real.log (1+T) := by
    calc
      _ = ∫ t : ℝ in 0..T, 1/(1+t) := by
        apply intervalIntegral.integral_congr
        intro t ht
        rw [uIcc_of_le hT] at ht
        dsimp only
        rw [abs_of_nonneg ht.1]
      _ = _ := by simpa using intervalIntegral.integral_eq_sub_of_hasDerivAt hd hi
  have hneg : (∫ t : ℝ in -T..0, 1/(1+|t|)) = ∫ t : ℝ in 0..T, 1/(1+|t|) := by
    have hh := intervalIntegral.integral_comp_neg (f := fun t : ℝ => 1/(1+|t|)) (a := -T) (b := 0)
    simpa only [abs_neg,neg_zero,neg_neg] using hh
  rw [← intervalIntegral.integral_add_adjacent_intervals (hc.intervalIntegrable (-T) 0)
    (hc.intervalIntegrable 0 T),hneg,hpos]
  ring

/-- The fixed negative real part controls both small and large imaginary parts. -/
theorem perron_left_norm_geometry (t : ℝ) :
    1+|t| ≤ 9*‖(-(1/8) : ℂ)+(t : ℂ)*I‖ := by
  have hr := abs_re_le_norm ((-(1/8) : ℂ)+(t : ℂ)*I)
  norm_num at hr
  have hi : |t| ≤ ‖(-(1/8) : ℂ)+(t : ℂ)*I‖ := by
    simpa using abs_im_le_norm ((-(1/8) : ℂ)+(t : ℂ)*I)
  linarith

/-- The kernel is continuous on the whole fixed left line. -/
theorem continuous_perronIntegrand_left {x : ℝ} (hx : 0 < x) :
    Continuous (fun t : ℝ => perronIntegrand x ((-(1/8) : ℂ)+(t : ℂ)*I)) := by
  apply continuous_iff_continuousAt.2
  intro t
  have hs0 : (-(1/8) : ℂ)+(t : ℂ)*I ≠ 0 := by
    intro he
    have hr := congrArg Complex.re he
    norm_num at hr
  have hs1 : (-(1/8) : ℂ)+(t : ℂ)*I ≠ 1 := by
    intro he
    have hr := congrArg Complex.re he
    norm_num at hr
  have hc : ContinuousAt (fun u : ℝ => (-(1/8) : ℂ)+(u : ℂ)*I) t :=
    continuousAt_const.add (continuous_ofReal.continuousAt.mul_const I)
  exact (perronIntegrand_analyticAt hx hs0 hs1 (riemannZeta_ne_zero_perron_left t)).continuousAt.comp
    (f := fun u : ℝ => (-(1/8) : ℂ)+(u : ℂ)*I) hc

/-- Pointwise integrable majorant for the fixed left kernel. -/
theorem norm_perronIntegrand_left_le {x T C t : ℝ} (hx : 0 < x) (hT : 0 ≤ T) (hC : 0 ≤ C)
    (hb : ∀ u : ℝ, ‖logDeriv riemannZeta ((-(1/8) : ℂ)+(u : ℂ)*I)‖ ≤ C*Real.log (|u|+5))
    (ht : t ∈ Icc (-T) T) :
    ‖perronIntegrand x ((-(1/8) : ℂ)+(t : ℂ)*I)‖ ≤
      (9*C*Real.log (T+5)*x^(-(1/8 : ℝ)))/(1+|t|) := by
  have hlog0 : 0 ≤ Real.log (T+5) := Real.log_nonneg (by linarith)
  have hlog := Real.log_le_log (by positivity : 0 < |t|+5)
    (by linarith [abs_le.2 ht] : |t|+5 ≤ T+5)
  have hL := (hb t).trans (mul_le_mul_of_nonneg_left hlog hC)
  have hg := perron_left_norm_geometry t
  have hn : 0 < ‖(-(1/8) : ℂ)+(t : ℂ)*I‖ := by linarith [abs_nonneg t]
  have hfrac : x^(-(1/8 : ℝ))/‖(-(1/8) : ℂ)+(t : ℂ)*I‖ ≤
      9*x^(-(1/8 : ℝ))/(1+|t|) := by
    apply (div_le_div_iff₀ hn (by positivity : 0 < 1+|t|)).2
    nlinarith [mul_le_mul_of_nonneg_left hg (Real.rpow_nonneg hx.le (-(1/8 : ℝ)))]
  rw [perronIntegrand,norm_mul,norm_neg,norm_perronWeight hx]
  rw [show ((-(1/8) : ℂ)+(t : ℂ)*I).re = -(1/8 : ℝ) by norm_num]
  calc
    _ ≤ (C*Real.log (T+5))*(9*x^(-(1/8 : ℝ))/(1+|t|)) :=
      mul_le_mul hL hfrac (by positivity) (mul_nonneg hC hlog0)
    _ = _ := by ring

/-- Uniform normalized left-side bound, with no height-dependent coefficient. -/
theorem norm_perron_left_uniform {x T C : ℝ} (hx : 0 < x) (hT : 0 ≤ T) (hC : 0 ≤ C)
    (hb : ∀ t : ℝ, ‖logDeriv riemannZeta ((-(1/8) : ℂ)+(t : ℂ)*I)‖ ≤ C*Real.log (|t|+5)) :
    ‖VIntegral' (perronIntegrand x) (-(1/8)) (-T) T‖ ≤
      (9*C/Real.pi)*(Real.log (T+5))^2*x^(-(1/8 : ℝ)) := by
  let A := 9*C*Real.log (T+5)*x^(-(1/8 : ℝ))
  have hlog0 : 0 ≤ Real.log (T+5) := Real.log_nonneg (by linarith)
  have hA : 0 ≤ A := by dsimp [A]; positivity
  have hk := (continuous_perronIntegrand_left hx).intervalIntegrable (μ := volume) (-T) T
  have hf := (show Continuous (fun t : ℝ => 1/(1+|t|)) from
    continuous_const.div (continuous_const.add continuous_abs) (fun t => by positivity)).intervalIntegrable (μ := volume) (-T) T
  have hi : ‖∫ t : ℝ in -T..T, perronIntegrand x ((-(1/8) : ℂ)+(t : ℂ)*I)‖ ≤
      A*(2*Real.log (1+T)) := by
    apply (intervalIntegral.norm_integral_le_integral_norm (by linarith : -T ≤ T)).trans
    calc
      _ ≤ ∫ t : ℝ in -T..T, A*(1/(1+|t|)) := by
        apply intervalIntegral.integral_mono_on (by linarith : -T ≤ T) hk.norm (hf.const_mul A)
        intro t ht
        have hh := norm_perronIntegrand_left_le hx hT hC hb ht
        simpa only [A,div_eq_mul_inv,mul_one,one_mul] using hh
      _ = _ := by rw [intervalIntegral.integral_const_mul,integral_one_div_one_add_abs hT]
  have hlogs : Real.log (1+T) ≤ Real.log (T+5) := Real.log_le_log (by linarith) (by linarith)
  simp only [VIntegral',VIntegral,smul_eq_mul,norm_mul,norm_I,one_mul,norm_perron_normalization,
    ofReal_neg,ofReal_div,ofReal_one,ofReal_ofNat]
  calc
    _ ≤ (1/(2*Real.pi))*(A*(2*Real.log (1+T))) := mul_le_mul_of_nonneg_left hi (by positivity)
    _ ≤ (1/(2*Real.pi))*(A*(2*Real.log (T+5))) := by
      gcongr
    _ = _ := by dsimp [A]; ring

/-- A complete horizontal side obeys the log-squared good-height estimate. -/
theorem norm_perron_full_horizontal_le {H T t x σ : ℝ} (hH : 7 ≤ H)
    (hT : T ∈ Ioo H (H+1)) (ht : t = T ∨ t = -T) (hx : 0 < x) (hσ : 1 < σ)
    (hgood : ∀ ρ : ℂ, NontrivialZero ρ → goodHeightSeparationConstant/Real.log H ≤ abs (T-|ρ.im|)) :
    ‖HIntegral' (perronIntegrand x) (-(1/8)) σ t‖ ≤
      fullGoodHeightLogDerivativeConstant*(Real.log H)^2*(σ+1/8)/(2*Real.pi*T)*
        max (x^(-(1/8 : ℝ))) (x^σ) := by
  have hTpos : 0 < T := by linarith [hT.1]
  have htabs : |t| = T := by rcases ht with rfl|rfl <;> simp [abs_of_pos hTpos]
  have ht0 : t ≠ 0 := by intro he; rw [he,abs_zero] at htabs; linarith
  have hh := norm_perron_horizontal_le_of_segment_bound hx (by linarith : -(1/8 : ℝ) ≤ σ) ht0
    (mul_nonneg fullGoodHeightLogDerivativeConstant_pos.le (sq_nonneg (Real.log H)))
    (fun u hu => norm_logDeriv_le_at_full_good_height hH hT htabs hu.1 hgood)
  convert! hh using 1
  rw [htabs]
  ring

end Legendre.Zeta
