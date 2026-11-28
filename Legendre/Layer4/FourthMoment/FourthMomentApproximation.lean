/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.FourthMoment.FourthMomentTestPolynomial
public import Legendre.Layer4.ZetaSecondMoment
public import Legendre.Layer4.ZetaWeyl
public import Mathlib.MeasureTheory.Function.L2Space

@[expose] public section
namespace Legendre.Zeta
open Complex MeasureTheory Set Density Density.Moment

/-- The height-length Euler polynomial approximates the critical line
uniformly over the normalized shell. -/
theorem critical_euler_error_on_dyadic_window :
    ∃ D : ℝ, 0 < D ∧ ∀ T : ℝ, 2 ≤ T → ∀ t ∈ Icc T (2*T),
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)-
        ∑ n ∈ Finset.Icc 1 ⌈2*T⌉₊, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))‖ ≤
      D*T^(-(1/2 : ℝ)) := by
  obtain ⟨P,hP,hb⟩ := norm_critical_euler_error_le
  refine ⟨P+2,by positivity,?_⟩
  intro T hT t ht
  let N := ⌈2*T⌉₊
  have hT₀ : 0 < T := by linarith only [hT]
  have ht₀ : 0 < t := hT₀.trans_le ht.1
  have hNlo : 2*T ≤ N := Nat.le_ceil _
  have hNhi : (N : ℝ) ≤ 3*T := (Nat.ceil_lt_add_one (by positivity : 0 ≤ 2*T)).le.trans
    (by linarith only [hT])
  have hTN : T ≤ (N : ℝ) := by linarith only [hT,hNlo]
  have hN₁ : 1 ≤ N := by exact_mod_cast (show (1 : ℝ) ≤ N by linarith only [hT,hTN])
  have hpw : (N : ℝ)^(-(1/2 : ℝ)) ≤ T^(-(1/2 : ℝ)) :=
    Real.rpow_le_rpow_of_nonpos hT₀ hTN (by norm_num)
  have hq : √(N : ℝ)/t ≤ 2*T^(-(1/2 : ℝ)) := by
    have hNroot : √(N : ℝ) ≤ 2*√T := by
      apply (Real.sqrt_le_iff).2 ⟨by positivity,?_⟩
      rw [mul_pow,Real.sq_sqrt hT₀.le]
      linarith only [hT,hNhi]
    calc
      _ ≤ (2*√T)/T := div_le_div₀ (by positivity) hNroot hT₀ ht.1
      _ = _ := by
        rw [mul_div_assoc,Real.sqrt_eq_rpow,← Real.rpow_sub_one hT₀.ne']
        norm_num
  exact (hb N t hN₁ ht₀ (ht.2.trans hNlo)).trans
    ((add_le_add (mul_le_mul_of_nonneg_left hpw hP.le) hq).trans_eq (by ring))

/-- Replacing the Euler polynomial square by the zeta square in the short
divisor polynomial pairing costs an absolute bounded error. -/
theorem norm_weighted_zeta_square_sub_euler_pairing_le :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T → ∀ M : ℕ, (M : ℝ)^2 ≤ T^(1/4 : ℝ) →
      ‖(∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*
        riemannZeta ((1/2 : ℂ)+((T*x : ℝ) : ℂ)*I)^2*
        star (subsetPolynomial (Finset.Icc 1 M) criticalDivisorCoefficient (T*x))) -
        (∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*
        (∑ n ∈ Finset.Icc 1 ⌈2*T⌉₊, (n : ℂ)^(-((1/2 : ℂ)+((T*x : ℝ) : ℂ)*I)))^2*
        star (subsetPolynomial (Finset.Icc 1 M) criticalDivisorCoefficient (T*x)))‖ ≤ C := by
  obtain ⟨D,hD,hE⟩ := critical_euler_error_on_dyadic_window
  obtain ⟨P,hP,hW⟩ := riemannZeta_critical_weyl_epsilon (1/12) (by norm_num)
  refine ⟨D*(4*P+D),by positivity,?_⟩
  intro T hT M hM
  let z := fun t : ℝ => riemannZeta ((1/2 : ℂ)+(t : ℂ)*I)
  let e := fun t : ℝ => ∑ n ∈ Finset.Icc 1 ⌈2*T⌉₊, (n : ℂ)^(-((1/2 : ℂ)+(t : ℂ)*I))
  let b := subsetPolynomial (Finset.Icc 1 M) criticalDivisorCoefficient
  let w := fun x : ℝ => (fourthMomentWeight x : ℂ)
  have hT₀ : 0 < T := by linarith only [hT]
  have hT₁ : 1 ≤ T := by linarith only [hT]
  have hTc : Continuous fun x : ℝ => T*x := by fun_prop
  have hzc : Continuous z := zeta_critical_continuous
  have hec : Continuous e := continuous_critical_euler_sum _
  have hbc : Continuous b := subsetPolynomial_continuous _ _
  have hwc : Continuous w := continuous_ofReal.comp continuous_fourthMomentWeight
  change ‖(∫ x : ℝ in 1..2, w x*z (T*x)^2*star (b (T*x))) -
    (∫ x : ℝ in 1..2, w x*e (T*x)^2*star (b (T*x)))‖ ≤ _
  have hconj : Continuous (fun x : ℝ => star (b (T*x))) := (hbc.comp hTc).star
  have hzI : IntervalIntegrable (fun x : ℝ => w x*z (T*x)^2*star (b (T*x))) volume 1 2 :=
    ((hwc.mul ((hzc.comp hTc).pow 2)).mul hconj).intervalIntegrable 1 2
  have heI : IntervalIntegrable (fun x : ℝ => w x*e (T*x)^2*star (b (T*x))) volume 1 2 :=
    ((hwc.mul ((hec.comp hTc).pow 2)).mul hconj).intervalIntegrable 1 2
  rw [← intervalIntegral.integral_sub hzI heI]
  have hpoint (x : ℝ) (hx : x ∈ Set.uIoc (1 : ℝ) 2) :
      ‖w x*z (T*x)^2*star (b (T*x))-(w x*e (T*x)^2*star (b (T*x)))‖ ≤ D*(4*P+D) := by
    have hx' : x ∈ Icc (1 : ℝ) 2 := by
      apply Ioc_subset_Icc_self
      simpa only [uIoc_of_le (by norm_num : (1 : ℝ) ≤ 2)] using hx
    have ht : T*x ∈ Icc T (2*T) :=
      ⟨by simpa only [mul_one] using mul_le_mul_of_nonneg_left hx'.1 hT₀.le,
        by simpa only [mul_comm T 2] using mul_le_mul_of_nonneg_left hx'.2 hT₀.le⟩
    have ht₀ : 0 < T*x := hT₀.trans_le ht.1
    have hDiff : ‖z (T*x)-e (T*x)‖ ≤ D*T^(-(1/2 : ℝ)) := hE T hT _ ht
    have hZ : ‖z (T*x)‖ ≤ 2*P*T^(1/4 : ℝ) := by
      have h := hW (T*x) (by rw [abs_of_pos ht₀]; exact hT.trans ht.1)
      rw [abs_of_pos ht₀,show (1/6+1/12 : ℝ) = 1/4 by norm_num] at h
      apply h.trans
      calc
        _ ≤ P*(2*T)^(1/4 : ℝ) := mul_le_mul_of_nonneg_left
          (Real.rpow_le_rpow ht₀.le ht.2 (by norm_num)) hP.le
        _ ≤ _ := by
          rw [Real.mul_rpow (by norm_num : (0 : ℝ) ≤ 2) hT₀.le]
          have hp := Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2)
            (show (1/4 : ℝ) ≤ 1 by norm_num)
          rw [Real.rpow_one] at hp
          have hh := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hp hP.le)
            (Real.rpow_nonneg hT₀.le (1/4 : ℝ))
          simpa only [mul_assoc,mul_comm P 2] using hh
    have hplus : ‖z (T*x)+e (T*x)‖ ≤ (4*P+D)*T^(1/4 : ℝ) := by
      rw [show z (T*x)+e (T*x) = (z (T*x)+z (T*x))-(z (T*x)-e (T*x)) by ring]
      apply (norm_sub_le _ _).trans
      apply (add_le_add ((norm_add_le _ _).trans (add_le_add hZ hZ)) (hDiff.trans
        (mul_le_mul_of_nonneg_left
        (Real.rpow_le_rpow_of_exponent_le hT₁ (show (-(1/2) : ℝ) ≤ 1/4 by norm_num)) hD.le))).trans_eq
      ring
    have hB := (subsetPolynomial_norm (Finset.Icc 1 M) criticalDivisorCoefficient (T*x)).trans
      ((sum_norm_criticalDivisorCoefficient_le M).trans hM)
    have hw : ‖w x‖ ≤ 1 := by
      simpa [w,Complex.norm_real,Real.norm_eq_abs,abs_of_nonneg (fourthMomentWeight_nonneg x)] using
        fourthMomentWeight_le_one hx'
    rw [show w x*z (T*x)^2*star (b (T*x))-w x*e (T*x)^2*star (b (T*x)) =
      w x*((z (T*x)-e (T*x))*(z (T*x)+e (T*x)))*star (b (T*x)) by ring]
    simp only [norm_mul,norm_star]
    calc
      _ ≤ 1*((D*T^(-(1/2 : ℝ)))*((4*P+D)*T^(1/4 : ℝ)))*T^(1/4 : ℝ) := by
        gcongr
      _ = _ := by
        rw [show 1*((D*T^(-(1/2 : ℝ)))*((4*P+D)*T^(1/4 : ℝ)))*T^(1/4 : ℝ) =
          (D*(4*P+D))*(T^(-(1/2 : ℝ))*(T^(1/4 : ℝ)*T^(1/4 : ℝ))) by ring,
          ← Real.rpow_add hT₀,← Real.rpow_add hT₀]
        norm_num
  have hh := intervalIntegral.norm_integral_le_of_norm_le_const hpoint
  rwa [show |(2 : ℝ)-1| = 1 by norm_num,mul_one] at hh

end Legendre.Zeta
