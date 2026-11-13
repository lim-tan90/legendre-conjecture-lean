/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local uniform logarithmic costs for the improved actual detector estimates.
-/
module
public import Legendre.Layer4.HalaszIntegralAlternative
public import Legendre.Layer4.DyadicHeightDensity

@[expose] public section
namespace Legendre.Density.Moment

noncomputable def halaszUniformMomentConstant : ℝ :=
  4+Oscillation.criticalPolynomialCountConstant*4^14

noncomputable def halaszUniformCoverConstant : ℝ := 6/Real.log 2

theorem halaszUniformMomentConstant_ge_four : 4 ≤ halaszUniformMomentConstant := by
  have := Oscillation.criticalPolynomialCountConstant_pos
  unfold halaszUniformMomentConstant
  linarith

theorem halaszUniformCoverConstant_pos : 0 < halaszUniformCoverConstant := by
  have : 0 < Real.log 2 := Real.log_pos (by norm_num)
  unfold halaszUniformCoverConstant
  positivity

theorem height_log_costs (T : ℝ) (hT : 2 ≤ T) :
    1 ≤ 1+Real.log T ∧ 0 ≤ Real.log T ∧ 1+Real.log (2*T) ≤ 4*(1+Real.log T) := by
  have hl : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have h2 : Real.log 2 ≤ 1 := by
    have hh := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
    linarith
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) (by linarith : T ≠ 0)]
  exact ⟨by linarith,hl,by linarith⟩

theorem halasz_uniform_moment_cost (X : ℕ) (hX : 1 ≤ X) (T : ℝ) (hT : 2 ≤ T)
    (hX2 : (X : ℝ) ≤ 2*T) :
    Oscillation.criticalPolynomialMomentCost X T ≤
      halaszUniformMomentConstant*(X : ℝ)*(1+Real.log T)^14 := by
  have hXr : (1 : ℝ) ≤ X := by exact_mod_cast hX
  have hXp : (0 : ℝ) < X := by linarith
  obtain ⟨hL,hlT,hLT⟩ := height_log_costs T hT
  have hlX0 : 0 ≤ 1+Real.log X := by linarith [Real.log_nonneg hXr]
  have hlX : 1+Real.log X ≤ 4*(1+Real.log T) := by
    have hh := Real.log_le_log hXp hX2
    linarith
  have hK := Oscillation.criticalPolynomialCountConstant_pos
  have hlog2T : 0 ≤ 1+Real.log (2*T) := by linarith [Real.log_nonneg (show 1 ≤ 2*T by linarith)]
  have hh : Oscillation.criticalPolynomialCountCost X T ≤
      Oscillation.criticalPolynomialCountConstant*(X : ℝ)*(4*(1+Real.log T))^13*(4*(1+Real.log T)) := by
    unfold Oscillation.criticalPolynomialCountCost
    gcongr
  have hunit : 1 ≤ (X : ℝ)*(1+Real.log T)^14 := by
    exact one_le_mul_of_one_le_of_one_le hXr (one_le_pow₀ hL)
  unfold Oscillation.criticalPolynomialMomentCost halaszUniformMomentConstant
  nlinarith

theorem halasz_uniform_cover (X : ℕ) (hX : 1 ≤ X) (T : ℝ) (hT : 2 ≤ T)
    (hX2 : (X : ℝ) ≤ 2*T) :
    ∃ J : ℕ, X ≤ 2^J ∧ (J : ℝ) ≤ halaszUniformCoverConstant*(1+Real.log T) := by
  have hXr : (1 : ℝ) ≤ X := by exact_mod_cast hX
  obtain ⟨J,hJl,hJu,hJlog⟩ := real_height_dyadic_cover ((X : ℝ)+1) (by linarith)
  refine ⟨J,by exact_mod_cast (show (X : ℝ) ≤ (2 : ℝ)^J by linarith),?_⟩
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h2 : Real.log 2 ≤ 1 := by
    have hh := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
    linarith
  have hlT := Real.log_nonneg (show 1 ≤ T by linarith)
  have hl : Real.log ((X : ℝ)+1) ≤ 3*(1+Real.log T) := by
    have hh := Real.log_le_log (show 0 < (X : ℝ)+1 by linarith)
      (show (X : ℝ)+1 ≤ 4*T by linarith)
    rw [Real.log_mul (by norm_num : (4 : ℝ) ≠ 0) (by linarith : T ≠ 0),
      show Real.log (4 : ℝ) = 2*Real.log 2 by
        simpa only [show (2 : ℝ)^2 = 4 by norm_num,Nat.cast_ofNat] using Real.log_pow (2 : ℝ) 2] at hh
    linarith
  have hh := hJlog.trans (mul_le_mul_of_nonneg_left hl (show 0 ≤ 2/Real.log 2 by positivity))
  convert hh using 1 <;> unfold halaszUniformCoverConstant <;> ring

theorem halasz_uniform_kernel_cost (σ Y : ℝ) (hσ : 3/4 ≤ σ) (hY : 1 ≤ Y) :
    (256*Y^(1/2-σ)/(σ-1/2))^4 ≤ (1024 : ℝ)^4*Y^(2-4*σ) := by
  have hgap : 0 < σ-1/2 := by linarith
  have hYp : 0 < Y := by linarith
  have hh : 256*Y^(1/2-σ)/(σ-1/2) ≤ 1024*Y^(1/2-σ) := by
    apply (div_le_iff₀ hgap).mpr
    have hn := Real.rpow_nonneg hYp.le (1/2-σ)
    nlinarith
  have hpow := pow_le_pow_left₀ (by positivity) hh 4
  have he : (Y^(1/2-σ))^4 = Y^(2-4*σ) := by
    rw [←Real.rpow_natCast,←Real.rpow_mul hYp.le]
    congr 1; ring
  simpa only [mul_pow,he] using hpow

theorem halasz_uniform_fractional_cost (X : ℕ) (hX : 1 ≤ X) (T : ℝ) (hT : 2 ≤ T)
    (hX2 : (X : ℝ) ≤ 2*T) :
    (Oscillation.criticalPolynomialMomentCost X T*T)^(2/3 : ℝ) ≤
      halaszUniformMomentConstant*(X : ℝ)^(2/3 : ℝ)*T^(2/3 : ℝ)*(1+Real.log T)^10 := by
  let L := 1+Real.log T
  have hL : 1 ≤ L := (height_log_costs T hT).1
  have hK := halaszUniformMomentConstant_ge_four
  have hcost := mul_le_mul_of_nonneg_right (halasz_uniform_moment_cost X hX T hT hX2)
    (show 0 ≤ T by linarith)
  have hp := Real.rpow_le_rpow
    (mul_nonneg (by have := Oscillation.criticalPolynomialMomentCost_ge_four X hX T (by linarith); linarith)
      (show 0 ≤ T by linarith)) hcost (by norm_num : (0 : ℝ) ≤ 2/3)
  have he : (halaszUniformMomentConstant*(X : ℝ)*(1+Real.log T)^14*T)^(2/3 : ℝ) =
      halaszUniformMomentConstant^(2/3 : ℝ)*(X : ℝ)^(2/3 : ℝ)*T^(2/3 : ℝ)*L^(28/3 : ℝ) := by
    rw [Real.mul_rpow (by positivity) (by linarith : 0 ≤ T),
      Real.mul_rpow (by positivity) (by positivity),Real.mul_rpow (by linarith) (by positivity),
      ←Real.rpow_natCast,←Real.rpow_mul (show 0 ≤ 1+Real.log T by linarith)]
    norm_num only [show (14 : ℝ)*(2/3) = 28/3 by norm_num]
    dsimp [L]
    ring
  rw [he] at hp
  have hkpow : halaszUniformMomentConstant^(2/3 : ℝ) ≤ halaszUniformMomentConstant := by
    have hh := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ halaszUniformMomentConstant by linarith)
      (by norm_num : (2/3 : ℝ) ≤ 1)
    simpa only [Real.rpow_one] using hh
  have hlpow : L^(28/3 : ℝ) ≤ L^10 := by
    rw [←Real.rpow_natCast]
    exact Real.rpow_le_rpow_of_exponent_le hL (by norm_num)
  apply hp.trans
  gcongr

end Legendre.Density.Moment
