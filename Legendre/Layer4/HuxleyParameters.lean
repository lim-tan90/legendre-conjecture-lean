/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local integer cutoffs and principal-pole constraints for the Huxley balance.
-/
module
public import Legendre.Layer4.HuxleyBalance
public import Legendre.Layer4.HalaszUniformCosts

@[expose] public section
namespace Legendre.Density.Moment

theorem huxley_integer_cutoffs (T σ : ℝ) (hT : 2 ≤ T) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    ∃ X J : ℕ, 1 ≤ X ∧ T^huxleyMollifierExponent σ ≤ X ∧
      (X : ℝ) ≤ 2*T^huxleyMollifierExponent σ ∧ (X : ℝ) ≤ 2*T ∧
      X ≤ 2^J ∧ (J : ℝ) ≤ halaszUniformCoverConstant*(1+Real.log T) := by
  let X := ⌈T^huxleyMollifierExponent σ⌉₊
  have hTp : 0 < T := by linarith
  have hb := huxley_mollifier_exponent_bounds σ hσ hσ1
  have hpow : 1 ≤ T^huxleyMollifierExponent σ := Real.one_le_rpow (by linarith) (by linarith [hb.1])
  have hxl : T^huxleyMollifierExponent σ ≤ X := Nat.le_ceil _
  have hX : 1 ≤ X := by exact_mod_cast hpow.trans hxl
  have hxu : (X : ℝ) ≤ 2*T^huxleyMollifierExponent σ := by
    have hh := Nat.ceil_lt_add_one (Real.rpow_nonneg hTp.le (huxleyMollifierExponent σ))
    change (X : ℝ) < T^huxleyMollifierExponent σ+1 at hh
    linarith
  have hX2 : (X : ℝ) ≤ 2*T := by
    have hp := Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
      (show huxleyMollifierExponent σ ≤ 1 by linarith [hb.2])
    rw [Real.rpow_one] at hp
    linarith
  obtain ⟨J,hcover,hJ⟩ := halasz_uniform_cover X hX T hT hX2
  exact ⟨X,J,hX,hxl,hxu,hX2,hcover,hJ⟩

theorem huxley_detector_scale (T σ : ℝ) (hT : 128 ≤ T) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    4 ≤ T^huxleyDetectorExponent σ ∧ T^huxleyDetectorExponent σ ≤ (T/2)^2 ∧
      1+Real.log (2*T^huxleyDetectorExponent σ+1) ≤ 8*(1+Real.log T) := by
  have hTp : 0 < T := by linarith
  have hb := huxley_detector_exponent_bounds σ hσ hσ1
  have hyl : T ≤ T^huxleyDetectorExponent σ := by
    have hh := Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T) hb.1
    simpa only [Real.rpow_one] using hh
  have hyu : T^huxleyDetectorExponent σ ≤ T^(3/2 : ℝ) :=
    Real.rpow_le_rpow_of_exponent_le (by linarith) (by linarith [hb.2])
  have hmax : T^(3/2 : ℝ) ≤ (T/2)^2 := by
    convert! balanced_scale_below_half_height_square T 1 (by linarith) le_rfl using 1
    norm_num [detectorBalanceExponent]
  refine ⟨by linarith,hyu.trans hmax,?_⟩
  have hlogT : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have hlY : Real.log (T^huxleyDetectorExponent σ) ≤ 2*Real.log T := by
    rw [Real.log_rpow hTp]
    nlinarith [hb.2]
  have hlog4 : Real.log (4 : ℝ) ≤ 2 := by
    have he : Real.log (4 : ℝ) = 2*Real.log 2 := by
      simpa only [show (2 : ℝ)^2 = 4 by norm_num,Nat.cast_ofNat] using Real.log_pow (2 : ℝ) 2
    rw [he]
    have hh := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
    linarith
  have hh := Real.log_le_log (show 0 < 2*T^huxleyDetectorExponent σ+1 by positivity)
    (show 2*T^huxleyDetectorExponent σ+1 ≤ 4*T^huxleyDetectorExponent σ by linarith)
  rw [Real.log_mul (by norm_num : (4 : ℝ) ≠ 0) (Real.rpow_pos_of_pos hTp _).ne'] at hh
  linarith

/-- A harmless fixed logarithmic power can dominate a fractional-root count. -/
theorem count_le_of_rpow_log_bound (R C M L p : ℝ) (k : ℕ)
    (hR : 0 ≤ R) (hC : 0 ≤ C) (hM : 0 ≤ M) (hL : 1 ≤ L) (hp : 1 ≤ p)
    (h : R^p ≤ C*M^p*L^k) : R ≤ (C+1)*M*L^k := by
  have hcp : C ≤ (C+1)^p := by
    have hh := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ C+1 by linarith) hp
    rw [Real.rpow_one] at hh
    linarith
  have hlk : 1 ≤ L^k := one_le_pow₀ hL
  have hlp : L^k ≤ (L^k)^p := by
    have hh := Real.rpow_le_rpow_of_exponent_le hlk hp
    simpa only [Real.rpow_one] using hh
  have hh : R^p ≤ ((C+1)*M*L^k)^p := by
    apply h.trans
    rw [Real.mul_rpow (by positivity : 0 ≤ (C+1)*M) (by positivity),
      Real.mul_rpow (by positivity : 0 ≤ C+1) hM]
    exact mul_le_mul (mul_le_mul_of_nonneg_right hcp (Real.rpow_nonneg hM p)) hlp
      (by positivity) (by positivity)
  exact (Real.rpow_le_rpow_iff hR (by positivity) (by linarith : 0 < p)).mp hh

end Legendre.Density.Moment
