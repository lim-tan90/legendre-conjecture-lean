/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronFoundation
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# Finite vertical Perron integrals

Original deductions from the existing right-half-plane bound, using mathlib
v4.35.0 (Apache-2.0) complex norms and interval integrals. The normalization
is the real parametrization of (2πi)⁻¹∫ K(x,s) ds on s=σ+it.
Integrability is proved before estimating the integral. The bound is a crude
finite-height bound, not an inversion theorem or a truncation-error estimate.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory

/-- The norm of the Perron weight for a positive real base. -/
theorem norm_perronWeight {x : ℝ} (hx : 0 < x) (s : ℂ) :
    ‖perronWeight x s‖ = x ^ s.re / ‖s‖ := by
  simp only [perronWeight, norm_div, norm_cpow_eq_rpow_re_of_pos hx]

/-- The weighted kernel inherits explicit right-half-plane control. -/
theorem norm_perronIntegrand_le {x : ℝ} (hx : 0 < x) {s : ℂ} (hs : 1 < s.re) :
    ‖perronIntegrand x s‖ ≤
      ((2 / (s.re - 1)) * (1 + 2 / (s.re - 1))) * x ^ s.re / ‖s‖ := by
  rw [perronIntegrand, norm_mul, norm_neg, norm_perronWeight hx]
  simpa only [mul_div_assoc] using
    mul_le_mul_of_nonneg_right (norm_logDeriv_le_re_sub_one hs)
      (div_nonneg (Real.rpow_nonneg hx.le _) (norm_nonneg _))

/-- Continuity on the right of 1, where neither zeta nor the weight has a pole. -/
theorem perronIntegrand_continuousAt {x : ℝ} (hx : 0 < x) {s : ℂ}
    (hs : 1 < s.re) : ContinuousAt (perronIntegrand x) s := by
  have hne : s ≠ 1 := by
    intro h
    simp [h] at hs
  have ha := analytic_off_pole s (by simpa using hne)
  have hz := nonvanishing hs.le hne
  have hlog : ContinuousAt (logDeriv riemannZeta) s :=
    (ha.deriv.div ha hz).continuousAt
  have hzero : s ≠ 0 := by
    intro h
    norm_num [h] at hs
  exact hlog.neg.mul
    ((continuousAt_const_cpow (ofReal_ne_zero.mpr hx.ne')).div continuousAt_id hzero)

/-- Along σ+it the denominator norm is at least σ. -/
theorem norm_perronIntegrand_vertical_le {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ) (t : ℝ) :
    ‖perronIntegrand x ((σ : ℂ) + (t : ℂ) * I)‖ ≤
      ((2 / (σ - 1)) * (1 + 2 / (σ - 1))) * x ^ σ / σ := by
  have hre : ((σ : ℂ) + (t : ℂ) * I).re = σ := by simp
  have hn : σ ≤ ‖(σ : ℂ) + (t : ℂ) * I‖ := by
    simpa [hre, abs_of_pos (lt_trans zero_lt_one hσ)] using
      abs_re_le_norm ((σ : ℂ) + (t : ℂ) * I)
  have hb := norm_perronIntegrand_le hx (s := (σ : ℂ) + (t : ℂ) * I) (by simpa using hσ)
  rw [hre] at hb
  apply hb.trans
  apply div_le_div_of_nonneg_left _ (by linarith : 0 < σ) hn
  positivity

/-- Away from height zero, the same kernel has explicit inverse-height decay.
This bound alone does not imply absolute integrability on an infinite vertical line. -/
theorem norm_perronIntegrand_vertical_le_div_abs {x σ t : ℝ} (hx : 0 < x)
    (hσ : 1 < σ) (ht : t ≠ 0) :
    ‖perronIntegrand x ((σ : ℂ) + (t : ℂ) * I)‖ ≤
      ((2 / (σ - 1)) * (1 + 2 / (σ - 1))) * x ^ σ / |t| := by
  have hn : |t| ≤ ‖(σ : ℂ) + (t : ℂ) * I‖ := by
    simpa using abs_im_le_norm ((σ : ℂ) + (t : ℂ) * I)
  have hb := norm_perronIntegrand_le hx (s := (σ : ℂ) + (t : ℂ) * I) (by simpa using hσ)
  simp only [add_re, ofReal_re, mul_re, I_re, mul_zero, ofReal_im, I_im,
    zero_mul, sub_self, add_zero] at hb
  apply hb.trans
  apply div_le_div_of_nonneg_left _ (abs_pos.mpr ht) hn
  positivity

/-- The finite vertical kernel is genuinely integrable for every pair of heights. -/
theorem perronIntegrand_vertical_intervalIntegrable {x σ : ℝ} (hx : 0 < x) (hσ : 1 < σ)
    (a b : ℝ) : IntervalIntegrable
      (fun t : ℝ ↦ perronIntegrand x ((σ : ℂ) + (t : ℂ) * I)) volume a b := by
  have hc : Continuous (fun t : ℝ ↦ perronIntegrand x ((σ : ℂ) + (t : ℂ) * I)) := by
    apply continuous_iff_continuousAt.mpr
    intro t
    exact (perronIntegrand_continuousAt hx (by simpa using hσ)).comp
      (continuousAt_const.add (continuous_ofReal.continuousAt.mul_const I))
  exact hc.intervalIntegrable a b

/-- Normalized finite vertical integral; no equality with ψ is asserted. -/
noncomputable def truncatedPerron (x σ T : ℝ) : ℂ :=
  (1 / (2 * Real.pi) : ℂ) *
    ∫ t : ℝ in -T..T, perronIntegrand x ((σ : ℂ) + (t : ℂ) * I)

/-- A uniform finite-height norm bound. This does not estimate the error relative to ψ. -/
theorem norm_truncatedPerron_le {x σ T : ℝ} (hx : 0 < x) (hσ : 1 < σ) (hT : 0 ≤ T) :
    ‖truncatedPerron x σ T‖ ≤
      (1 / (2 * Real.pi)) *
        ((((2 / (σ - 1)) * (1 + 2 / (σ - 1))) * x ^ σ / σ) * (2 * T)) := by
  have hb := intervalIntegral.norm_integral_le_of_norm_le_const
    (a := -T) (b := T) (fun t _ ↦ norm_perronIntegrand_vertical_le hx hσ t)
  have ht : |T - -T| = 2 * T := by rw [abs_of_nonneg (by linarith)]; ring
  rw [ht] at hb
  rw [truncatedPerron, norm_mul]
  have hn : ‖(1 / (2 * Real.pi) : ℂ)‖ = 1 / (2 * Real.pi) := by
    simp [abs_of_pos Real.pi_pos]
  rw [hn]
  exact mul_le_mul_of_nonneg_left hb (by positivity)

end Legendre.Zeta
