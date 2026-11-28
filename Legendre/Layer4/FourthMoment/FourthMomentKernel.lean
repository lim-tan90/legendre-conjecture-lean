/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.ExponentialKernel
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set
open scoped Interval

/-- A polynomial weight on the normalized height interval from one to two. -/
def fourthMomentWeight (x : ℝ) : ℝ := ((x-1)*(2-x))^2

theorem continuous_fourthMomentWeight : Continuous fourthMomentWeight := by
  unfold fourthMomentWeight
  fun_prop

theorem fourthMomentWeight_nonneg (x : ℝ) : 0 ≤ fourthMomentWeight x := sq_nonneg _

theorem fourthMomentWeight_le_one {x : ℝ} (hx : x ∈ Icc (1 : ℝ) 2) :
    fourthMomentWeight x ≤ 1 := by
  have h₁ : 0 ≤ x-1 := sub_nonneg.mpr hx.1
  have h₂ : 0 ≤ 2-x := sub_nonneg.mpr hx.2
  have hh : (x-1)*(2-x) ≤ 1 := by
    simpa only [one_mul] using mul_le_mul (show x-1 ≤ 1 by linarith [hx.2])
      (show 2-x ≤ 1 by linarith [hx.1]) h₂ (by norm_num : (0 : ℝ) ≤ 1)
  exact (pow_le_pow_left₀ (mul_nonneg h₁ h₂) hh 2).trans_eq (by norm_num)

/-- Oscillatory transform of the compact height weight. -/
noncomputable def fourthMomentKernel (u : ℝ) : ℂ :=
  ∫ x : ℝ in 1..2, (fourthMomentWeight x : ℂ)*realPhase u x

theorem fourthMomentKernel_zero : fourthMomentKernel 0 = (1/30 : ℂ) := by
  let f := fun x : ℝ => x^5/5-(3/2)*x^4+(13/3)*x^3-6*x^2+4*x
  have h (x : ℝ) : HasDerivAt f (fourthMomentWeight x) x := by
    have h₅ := ((hasDerivAt_id x).pow 5).div_const 5
    have h₄ := ((hasDerivAt_id x).pow 4).const_mul (3/2 : ℝ)
    have h₃ := ((hasDerivAt_id x).pow 3).const_mul (13/3 : ℝ)
    have h₂ := ((hasDerivAt_id x).pow 2).const_mul (6 : ℝ)
    have h₁ := (hasDerivAt_id x).const_mul (4 : ℝ)
    convert ((h₅.sub h₄).add h₃ |>.sub h₂).add h₁ using 1
    · funext z
      rfl
    · simp [fourthMomentWeight]
      ring
  have hval := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun x _ => h x) (continuous_fourthMomentWeight.intervalIntegrable (μ := volume) 1 2)
  simp only [fourthMomentKernel,realPhase,mul_zero,Complex.ofReal_zero,zero_mul,Complex.exp_zero,mul_one]
  rw [intervalIntegral.integral_ofReal,hval]
  norm_num [f]

private def weightFirst (x : ℝ) : ℝ := 2*(x-1)*(2-x)*(3-2*x)

private def weightSecond (x : ℝ) : ℝ := 2*(3-2*x)^2-4*(x-1)*(2-x)

private theorem weight_hasDerivAt (x : ℝ) : HasDerivAt fourthMomentWeight (weightFirst x) x := by
  have ha := (hasDerivAt_id x).sub_const 1
  have hb := (hasDerivAt_const x (2 : ℝ)).sub (hasDerivAt_id x)
  convert (ha.mul hb).pow 2 using 1
  · funext z
    simp [fourthMomentWeight, mul_pow]
  · simp [weightFirst]
    ring

private theorem weightFirst_hasDerivAt (x : ℝ) : HasDerivAt weightFirst (weightSecond x) x := by
  have ha := (hasDerivAt_id x).sub_const 1
  have hb := (hasDerivAt_const x (2 : ℝ)).sub (hasDerivAt_id x)
  have hc := (hasDerivAt_const x (3 : ℝ)).sub ((hasDerivAt_id x).const_mul 2)
  convert ((ha.const_mul (2 : ℝ)).mul hb).mul hc using 1
  · funext z
    rfl
  · simp [weightSecond]
    ring

private theorem abs_weightSecond_le {x : ℝ} (hx : x ∈ Icc (1 : ℝ) 2) :
    |weightSecond x| ≤ 6 := by
  have h₁ : 0 ≤ (x-1)*(2-x) := mul_nonneg (sub_nonneg.mpr hx.1) (sub_nonneg.mpr hx.2)
  have h₂ : (x-1)*(2-x) ≤ 1 := by
    simpa only [one_mul] using mul_le_mul (show x-1 ≤ 1 by linarith [hx.2])
      (show 2-x ≤ 1 by linarith [hx.1]) (sub_nonneg.mpr hx.2) (by norm_num : (0 : ℝ) ≤ 1)
  have h₃ : (3-2*x)^2 ≤ 1 := by
    rw [← sq_abs (3-2*x)]
    exact (pow_le_pow_left₀ (abs_nonneg _) (abs_le.mpr ⟨by linarith [hx.2],by linarith [hx.1]⟩) 2).trans_eq
      (by norm_num : (1 : ℝ)^2 = 1)
  apply abs_le.mpr
  dsimp [weightSecond]
  constructor <;> nlinarith only [h₁,h₂,h₃,sq_nonneg (3-2*x)]

private theorem weightedPhase_integration_by_parts (u : ℝ) {f g : ℝ → ℝ}
    (hf : ∀ x, HasDerivAt f (g x) x) (hg : Continuous g) (h₁ : f 1 = 0) (h₂ : f 2 = 0) :
    ((u : ℂ)*I)*(∫ x : ℝ in 1..2, (f x : ℂ)*realPhase u x) =
      -(∫ x : ℝ in 1..2, (g x : ℂ)*realPhase u x) := by
  let L := (u : ℂ)*I
  have hc : Continuous f := continuous_iff_continuousAt.2 fun x => (hf x).continuousAt
  have hφ (x : ℝ) : realPhase u x = Complex.exp (L*(x : ℂ)) := by
    unfold realPhase
    push_cast
    congr 1
    dsimp only [L]
    ring
  have hd (x : ℝ) : HasDerivAt (realPhase u) (L*realPhase u x) x := by
    have h := (((hasDerivAt_id x).ofReal_comp).const_mul L).cexp
    have he : realPhase u = fun y : ℝ => Complex.exp (L*(y : ℂ)) := funext hφ
    rw [he]
    simpa only [id_eq,Complex.ofReal_one,mul_one,mul_comm (Complex.exp (L*(x : ℂ))) L] using h
  have h := intervalIntegral.integral_mul_deriv_eq_deriv_mul_of_hasDerivAt
    (u := fun x : ℝ => (f x : ℂ)) (v := realPhase u)
    (continuous_ofReal.comp hc).continuousOn (continuous_realPhase u).continuousOn
    (fun x _ => (hf x).ofReal_comp) (fun x _ => hd x)
    ((continuous_ofReal.comp hg).intervalIntegrable (μ := volume) 1 2)
    ((continuous_const.mul (continuous_realPhase u)).intervalIntegrable (μ := volume) 1 2)
  simp only [h₁,h₂,Complex.ofReal_zero,zero_mul,sub_self,zero_sub] at h
  simp_rw [show ∀ x : ℝ, (f x : ℂ)*(L*realPhase u x) = L*((f x : ℂ)*realPhase u x)
    by intro x; ring,intervalIntegral.integral_const_mul] at h
  exact h

/-- Two integrations by parts give inverse-square decay at every nonzero frequency. -/
theorem norm_fourthMomentKernel_le {u : ℝ} (hu : u ≠ 0) :
    ‖fourthMomentKernel u‖ ≤ 6/|u|^2 := by
  let L := (u : ℂ)*I
  have h₁ := weightedPhase_integration_by_parts u weight_hasDerivAt
    (by unfold weightFirst; fun_prop) (by norm_num [fourthMomentWeight]) (by norm_num [fourthMomentWeight])
  have h₂ := weightedPhase_integration_by_parts u weightFirst_hasDerivAt
    (by unfold weightSecond; fun_prop) (by norm_num [weightFirst]) (by norm_num [weightFirst])
  have hrel : L^2*fourthMomentKernel u = ∫ x : ℝ in 1..2, (weightSecond x : ℂ)*realPhase u x := by
    rw [pow_two,mul_assoc]
    change L*(L*fourthMomentKernel u) = _
    rw [fourthMomentKernel,h₁,mul_neg,h₂,neg_neg]
  have hnorm : ‖L‖ = |u| := by dsimp only [L]; rw [norm_mul,norm_I,mul_one,Complex.norm_real,Real.norm_eq_abs]
  have hB := intervalIntegral.norm_integral_le_of_norm_le_const
    (a := (1 : ℝ)) (b := (2 : ℝ)) (C := 6)
    (f := fun x => (weightSecond x : ℂ)*realPhase u x)
    (by
      intro x hx
      have h := abs_weightSecond_le (show x ∈ Icc (1 : ℝ) 2 from by
        apply Ioc_subset_Icc_self
        simpa only [uIoc_of_le (by norm_num : (1 : ℝ) ≤ 2)] using hx)
      simpa only [norm_mul,norm_realPhase,mul_one,Complex.norm_real,Real.norm_eq_abs] using h)
  rw [← hrel,norm_mul,norm_pow,hnorm] at hB
  apply (le_div_iff₀ (sq_pos_of_pos (abs_pos.mpr hu))).2
  rw [mul_comm]
  norm_num at hB ⊢
  exact hB

end Legendre.Density.Moment
