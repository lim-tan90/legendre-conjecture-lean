/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaSecondMellin
public import Mathlib.MeasureTheory.Function.Floor

/-!
# Euler summation continued to Re(s)>-1

One-sided integration by parts is valid at the integer jumps. The boundary
term vanishes at infinity because the primitive is bounded. Analytic
continuation then gives a polynomial zeta bound across Re(s)=0.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology MeasureTheory Set

/-- Centered fractional part, with the same right-continuous convention as the primitive. -/
noncomputable def zetaCenteredFractionalPart (t : ℝ) : ℂ := ((Int.fract t-1/2 : ℝ) : ℂ)

/-- Centering preserves boundedness. -/
theorem norm_zetaCenteredFractionalPart_le (t : ℝ) : ‖zetaCenteredFractionalPart t‖ ≤ 1 := by
  rw [zetaCenteredFractionalPart,norm_real,Real.norm_eq_abs,abs_le]
  have h0 := Int.fract_nonneg t
  have h1 := Int.fract_lt_one t
  constructor <;> linarith

/-- The centered term is measurable. -/
theorem zetaCenteredFractionalPart_measurable : Measurable zetaCenteredFractionalPart :=
  measurable_ofReal.comp (measurable_fract.sub_const (1/2))

/-- Nat and Int fractional parts agree on the Euler integration domain. -/
theorem zetaCenteredFractionalPart_eq {t : ℝ} (ht : 0 ≤ t) :
    zetaCenteredFractionalPart t = ((t-(⌊t⌋₊ : ℝ) : ℝ) : ℂ)-1/2 := by
  have hf : (⌊t⌋ : ℝ) = (⌊t⌋₊ : ℝ) := by
    exact_mod_cast (Int.natCast_floor_eq_floor ht).symm
  simp [zetaCenteredFractionalPart,Int.fract,hf]

/-- Differentiation of the power occurring in the second Euler formula. -/
theorem euler_power_hasDerivAt {s : ℂ} (hs : -1 < s.re) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (fun u : ℝ => (u : ℂ)^(-s-1)) ((-s-1)*(t : ℂ)^(-s-2)) t := by
  have he : -s-1 ≠ 0 := by
    intro h
    have hr := congrArg Complex.re h
    simp only [sub_re,neg_re,one_re,zero_re] at hr
    linarith
  convert! hasDerivAt_ofReal_cpow_const ht.ne' he using 1
  congr 2
  ring

/-- Absolute convergence of the centered first-order Euler integral. -/
theorem centeredEuler_integrable {s : ℂ} (hs : 0 < s.re) :
    IntegrableOn (fun t : ℝ => zetaCenteredFractionalPart t*(t : ℂ)^(-s-1)) (Ioi 1) := by
  have hp := integrableOn_Ioi_cpow_of_lt (a := -s-1)
    (by simp only [sub_re,neg_re,one_re]; linarith) zero_lt_one
  have hfrac := zetaMellinRemainder_integrable hs
  rw [show -(s+1) = -s-1 by ring] at hfrac
  apply (hfrac.sub (hp.const_mul (1/2 : ℂ))).congr
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  dsimp only [Pi.sub_apply]
  rw [zetaCenteredFractionalPart_eq (zero_le_one.trans ht.le)]
  ring

/-- Integral value of the centered first-order remainder. -/
theorem centeredEuler_integral {s : ℂ} (hs : 0 < s.re) :
    (∫ t : ℝ in Ioi 1, zetaCenteredFractionalPart t*(t : ℂ)^(-s-1)) =
      zetaMellinRemainder s-(1/2 : ℂ)/s := by
  have hp := integrableOn_Ioi_cpow_of_lt (a := -s-1)
    (by simp only [sub_re,neg_re,one_re]; linarith) zero_lt_one
  have hfrac := zetaMellinRemainder_integrable hs
  rw [show -(s+1) = -s-1 by ring] at hfrac
  calc
    _ = ∫ t : ℝ in Ioi 1,
        (t : ℂ)^(-s-1)*((t-(⌊t⌋₊ : ℝ) : ℝ) : ℂ)-(1/2 : ℂ)*(t : ℂ)^(-s-1) := by
      apply setIntegral_congr_fun measurableSet_Ioi
      intro t ht
      dsimp only
      rw [zetaCenteredFractionalPart_eq (zero_le_one.trans ht.le)]
      ring
    _ = _ := by
      rw [integral_sub hfrac (hp.const_mul _),integral_const_mul]
      rw [zetaMellinRemainder_eq_integral,show -(s+1) = -s-1 by ring]
      congr 1
      rw [integral_Ioi_cpow_of_lt (by simp only [sub_re,neg_re,one_re]; linarith) zero_lt_one,
        ofReal_one,one_cpow,show -s-1+1 = -s by ring]
      simp only [div_neg,neg_div,neg_neg]
      ring

/-- The bounded primitive kills the boundary term at infinity. -/
theorem eulerPrimitive_power_tendsto_zero {s : ℂ} (hs : -1 < s.re) :
    Tendsto (fun t : ℝ => zetaEulerPrimitive t*(t : ℂ)^(-s-1)) atTop (𝓝 0) := by
  have hb : (fun t : ℝ => zetaEulerPrimitive t*(t : ℂ)^(-s-1)) =O[atTop]
      (fun t : ℝ => t^(-s.re-1)) := by
    apply Asymptotics.IsBigO.of_bound 1
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with t ht
    rw [norm_mul,norm_cpow_eq_rpow_re_of_pos ht]
    simp only [sub_re,neg_re,one_re,Real.norm_eq_abs,abs_of_nonneg (Real.rpow_nonneg ht.le _),one_mul]
    exact (mul_le_mul_of_nonneg_right ((norm_zetaEulerPrimitive_le t).trans (by norm_num))
      (Real.rpow_nonneg ht.le _)).trans_eq (one_mul _)
  apply hb.trans_tendsto
  rw [show -s.re-1 = -(s.re+1) by ring]
  exact tendsto_rpow_neg_atTop (by linarith)

/-- Integration by parts gives the exact relation between the two Euler remainders. -/
theorem zetaMellinRemainder_eq_second {s : ℂ} (hs : 0 < s.re) :
    zetaMellinRemainder s = (1/2 : ℂ)/s+(s+1)*zetaSecondMellinRemainder s := by
  let D := fun t : ℝ => zetaCenteredFractionalPart t*(t : ℂ)^(-s-1)-
    (s+1)*((t : ℂ)^(-s-2)*zetaEulerPrimitive t)
  have hD : IntegrableOn D (Ioi 1) :=
    (centeredEuler_integrable hs).sub ((zetaSecondMellinRemainder_integrable (by linarith)).const_mul (s+1))
  have hfinite (b : ℝ) (hb : 1 ≤ b) :
      (∫ t in (1 : ℝ)..b, D t) = zetaEulerPrimitive b*(b : ℂ)^(-s-1) := by
    have hcont : ContinuousOn (fun t : ℝ => zetaEulerPrimitive t*(t : ℂ)^(-s-1)) (Icc 1 b) := by
      apply zetaEulerPrimitive_continuous.continuousOn.mul
      intro t ht
      exact (euler_power_hasDerivAt (by linarith : -1 < s.re) (zero_lt_one.trans_le ht.1)).continuousAt.continuousWithinAt
    have hd (t : ℝ) (ht : t ∈ Ioo (1 : ℝ) b) :
        HasDerivWithinAt (fun u : ℝ => zetaEulerPrimitive u*(u : ℂ)^(-s-1)) (D t) (Ioi t) t := by
      have h := (zetaEulerPrimitive_hasDerivWithinAt_right t).mul
        ((euler_power_hasDerivAt (by linarith : -1 < s.re) (zero_lt_one.trans ht.1)).hasDerivWithinAt)
      convert! h using 1
      dsimp [D,zetaCenteredFractionalPart]
      ring
    have hi : IntervalIntegrable D volume 1 b := by
      rw [intervalIntegrable_iff_integrableOn_Ioc_of_le hb]
      exact hD.mono_set (fun _ ht => ht.1)
    have he := intervalIntegral.integral_eq_sub_of_hasDeriv_right_of_le hb hcont hd hi
    simpa [zetaEulerPrimitive] using he
  have ht := intervalIntegral_tendsto_integral_Ioi (1 : ℝ) hD tendsto_id
  have he : (fun b : ℝ => ∫ t in (1 : ℝ)..b, D t) =ᶠ[atTop]
      (fun b : ℝ => zetaEulerPrimitive b*(b : ℂ)^(-s-1)) := by
    filter_upwards [eventually_ge_atTop (1 : ℝ)] with b hb
    exact hfinite b hb
  have hzero : (∫ t : ℝ in Ioi 1, D t) = 0 :=
    tendsto_nhds_unique (ht.congr' he) (eulerPrimitive_power_tendsto_zero (by linarith))
  dsimp [D] at hzero
  rw [integral_sub (centeredEuler_integrable hs)
    ((zetaSecondMellinRemainder_integrable (by linarith)).const_mul (s+1)),
    integral_const_mul,centeredEuler_integral hs,← zetaSecondMellinRemainder_eq_integral] at hzero
  linear_combination hzero

/-- Holomorphic numerator for the second Euler formula, including the pole point. -/
noncomputable def zetaSecondEulerNumerator (s : ℂ) : ℂ :=
  1+(s-1)*((1/2 : ℂ)-s*(s+1)*zetaSecondMellinRemainder s)

/-- Holomorphy throughout the enlarged half-plane. -/
theorem zetaSecondEulerNumerator_differentiableAt {s : ℂ} (hs : -1 < s.re) :
    DifferentiableAt ℂ zetaSecondEulerNumerator s := by
  exact (differentiableAt_const (1 : ℂ)).add ((differentiableAt_id.sub_const 1).mul
    ((differentiableAt_const (1/2 : ℂ)).sub ((differentiableAt_id.mul (differentiableAt_id.add_const 1)).mul
      (zetaSecondMellinRemainder_differentiableAt hs))))

/-- Integration by parts identifies the new numerator with the old Euler representation. -/
theorem poleRemovedZeta_eq_second_euler_positive {s : ℂ} (hs : 0 < s.re) :
    poleRemovedZeta s = zetaSecondEulerNumerator s := by
  have hs0 : s ≠ 0 := by intro he; simp [he] at hs
  rw [poleRemovedZeta_eq_euler_sum hs,zetaMellinRemainder_eq_second hs]
  unfold zetaSecondEulerNumerator
  field_simp
  ring

/-- Analytic continuation extends second Euler summation across Re(s)=0. -/
theorem poleRemovedZeta_eq_second_euler {s : ℂ} (hs : -1 < s.re) :
    poleRemovedZeta s = zetaSecondEulerNumerator s := by
  let U := {z : ℂ | -1 < z.re}
  have hU : IsOpen U := isOpen_lt continuous_const continuous_re
  have hH : AnalyticOnNhd ℂ poleRemovedZeta U :=
    poleRemovedZeta_differentiable.differentiableOn.analyticOnNhd hU
  have hg : AnalyticOnNhd ℂ zetaSecondEulerNumerator U := by
    apply DifferentiableOn.analyticOnNhd _ hU
    intro z hz
    exact (zetaSecondEulerNumerator_differentiableAt hz).differentiableWithinAt
  have hfg : poleRemovedZeta =ᶠ[𝓝 (2 : ℂ)] zetaSecondEulerNumerator := by
    have he : {z : ℂ | 0 < z.re} ∈ 𝓝 (2 : ℂ) :=
      (isOpen_lt continuous_const continuous_re).mem_nhds (by norm_num)
    filter_upwards [he] with z hz
    exact poleRemovedZeta_eq_second_euler_positive hz
  exact (hH.eqOn_of_preconnected_of_eventuallyEq hg
    (convex_halfSpace_re_gt (-1 : ℝ)).isPreconnected (z₀ := 2) (by norm_num [U]) hfg) hs

/-- Second Euler representation on Re(s)>-1 away from the pole. -/
theorem riemannZeta_eq_second_euler {s : ℂ} (hs : -1 < s.re) (hs1 : s ≠ 1) :
    riemannZeta s = 1/(s-1)+(1/2 : ℂ)-s*(s+1)*zetaSecondMellinRemainder s := by
  have he := poleRemovedZeta_eq_second_euler hs
  rw [poleRemovedZeta_eq hs1,zetaSecondEulerNumerator] at he
  apply mul_left_cancel₀ (sub_ne_zero.mpr hs1)
  rw [he]
  field_simp
  ring

/-- Polynomial growth in the fixed half-plane Re(s)≥-1/2, away from the pole. -/
theorem norm_riemannZeta_le_second_euler {s : ℂ} (hs : -(1/2) ≤ s.re) (hs1 : s ≠ 1) :
    ‖riemannZeta s‖ ≤ 1/‖s-1‖+1/2+2*‖s‖*(‖s‖+1) := by
  have hR := norm_zetaSecondMellinRemainder_le (by linarith : -1 < s.re)
  have hR2 : ‖zetaSecondMellinRemainder s‖ ≤ 2 := by
    apply hR.trans
    apply (div_le_iff₀ (by linarith : 0 < s.re+1)).2
    linarith
  rw [riemannZeta_eq_second_euler (by linarith) hs1]
  calc
    _ ≤ ‖(1 : ℂ)/(s-1)+(1/2 : ℂ)‖+‖s*(s+1)*zetaSecondMellinRemainder s‖ := norm_sub_le _ _
    _ ≤ (‖(1 : ℂ)/(s-1)‖+‖(1/2 : ℂ)‖)+‖s*(s+1)*zetaSecondMellinRemainder s‖ :=
      add_le_add (norm_add_le _ _) le_rfl
    _ ≤ (1/‖s-1‖+1/2)+(‖s‖*(‖s‖+1))*2 := by
      simp only [norm_div,norm_one,norm_mul,norm_ofNat]
      apply add_le_add le_rfl
      exact mul_le_mul (mul_le_mul_of_nonneg_left (by simpa using norm_add_le s 1) (norm_nonneg s))
        hR2 (norm_nonneg _) (by positivity)
    _ = _ := by ring

end Legendre.Zeta
