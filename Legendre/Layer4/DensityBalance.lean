/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityBalanceParameters.lean and DensityPolynomialBalance.lean
in openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The zeta cutoff ceil(T) also meets the explicit principal-pole constraints.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.IntegralAlternative
public import Legendre.Layer4.PolynomialAlternative

@[expose] public section
namespace Legendre.Density.Moment

noncomputable def balancedDensityExponent (σ : ℝ) : ℝ := 3*(1-σ)/(2-σ)
noncomputable def detectorBalanceExponent (σ : ℝ) : ℝ := 3/(2*(2-σ))

theorem balance_exponent_ge_one (σ : ℝ) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    1 ≤ detectorBalanceExponent σ := by
  unfold detectorBalanceExponent
  apply (le_div_iff₀ (by linarith : 0 < 2*(2-σ))).mpr
  linarith

theorem balance_exponent_le_three_halves (σ : ℝ) (hσ1 : σ ≤ 1) :
    detectorBalanceExponent σ ≤ 3/2 := by
  unfold detectorBalanceExponent
  apply (div_le_iff₀ (by linarith : 0 < 2*(2-σ))).mpr
  linarith

theorem balancedDensityExponent_nonneg (σ : ℝ) (hσ1 : σ ≤ 1) :
    0 ≤ balancedDensityExponent σ := by
  unfold balancedDensityExponent
  exact div_nonneg (by linarith) (by linarith)

theorem balancedDensityExponent_le_one (σ : ℝ) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    balancedDensityExponent σ ≤ 1 := by
  unfold balancedDensityExponent
  exact (div_le_one (by linarith : 0 < 2-σ)).mpr (by linarith)

theorem balancedDensityExponent_ge_two_defect (σ : ℝ) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    2-2*σ ≤ balancedDensityExponent σ := by
  unfold balancedDensityExponent
  apply (le_div_iff₀ (by linarith : 0 < 2-σ)).mpr
  nlinarith [mul_nonneg (show 0 ≤ σ-1/2 by linarith) (show 0 ≤ 1-σ by linarith)]

theorem one_le_two_log (T : ℝ) (hT : 2 ≤ T) : 1 ≤ 2*Real.log T := by
  have h := Real.le_log_one_add_of_nonneg (by norm_num : (0 : ℝ) ≤ 1)
  norm_num at h
  have hh := Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT
  linarith

theorem balanced_detector_cutoff (T : ℝ) (hT : 2 ≤ T) :
    ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      (X : ℝ)+T ≤ 3*T ∧ 1+Real.log X ≤ 4*Real.log T := by
  let X := ⌈T⌉₊
  have hlower : T ≤ X := Nat.le_ceil T
  have hXp : (0 : ℝ) < X := by linarith
  have hupper : (X : ℝ) < T+1 := Nat.ceil_lt_add_one (by linarith : 0 ≤ T)
  have hX2 : (X : ℝ) ≤ 2*T := by linarith
  have hX : 1 ≤ X := by exact_mod_cast (show (1 : ℝ) ≤ X by linarith)
  refine ⟨X,hX,hlower,hX2,by linarith,?_⟩
  have hh := Real.log_le_log hXp hX2
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) (by linarith : T ≠ 0)] at hh
  have hlog2 := Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT
  linarith [one_le_two_log T hT]

theorem balanced_power_identity (T σ : ℝ) (hT : 0 < T) (hσ : σ < 2) :
    T^3*(T^detectorBalanceExponent σ)^(2-4*σ) =
      (T^balancedDensityExponent σ)^(3 : ℕ) := by
  rw [← Real.rpow_natCast T 3,← Real.rpow_natCast (T^balancedDensityExponent σ) 3,
    ← Real.rpow_mul hT.le,← Real.rpow_mul hT.le,← Real.rpow_add hT]
  congr 1
  unfold balancedDensityExponent detectorBalanceExponent
  have hd : 2-σ ≠ 0 := by linarith
  field_simp [hd]
  ring

theorem balanced_polynomial_powers (T X σ : ℝ) (hT : 1 ≤ T) (hTX : T ≤ X)
    (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    (T^detectorBalanceExponent σ)^(2-2*σ)+T*X^(1-2*σ) ≤ 2*T^balancedDensityExponent σ := by
  have hTp : 0 < T := lt_of_lt_of_le zero_lt_one hT
  have he : (T^detectorBalanceExponent σ)^(2-2*σ) = T^balancedDensityExponent σ := by
    rw [← Real.rpow_mul hTp.le]
    congr 1
    unfold detectorBalanceExponent balancedDensityExponent
    have hd : 2-σ ≠ 0 := by linarith
    field_simp [hd]
  have hx := Real.rpow_le_rpow_of_nonpos hTp hTX (by linarith : 1-2*σ ≤ 0)
  have hb : T*T^(1-2*σ) = T^(2-2*σ) := by
    rw [show 2-2*σ = 1+(1-2*σ) by ring,Real.rpow_add hTp,Real.rpow_one]
  have ht := Real.rpow_le_rpow_of_exponent_le hT (balancedDensityExponent_ge_two_defect σ hσ hσ1)
  rw [he]
  have h := (mul_le_mul_of_nonneg_left hx hTp.le).trans (hb.le.trans ht)
  linarith

theorem balanced_log_cost (T σ : ℝ) (hT : 2 ≤ T) (hσ : 1/2 ≤ σ) (hσ1 : σ ≤ 1) :
    1+Real.log (2*T^detectorBalanceExponent σ+1) ≤ 8*Real.log T := by
  let Y := T^detectorBalanceExponent σ
  have hTp : 0 < T := by linarith
  have hY : 2 ≤ Y := by
    have h := Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
      (balance_exponent_ge_one σ hσ hσ1)
    rw [Real.rpow_one] at h
    exact hT.trans h
  have hlogY : Real.log Y ≤ 3*Real.log T := by
    rw [show Real.log Y = detectorBalanceExponent σ*Real.log T from Real.log_rpow hTp _]
    have hh := mul_le_mul_of_nonneg_right (balance_exponent_le_three_halves σ hσ1)
      (Real.log_nonneg (by linarith : 1 ≤ T))
    nlinarith [Real.log_nonneg (by linarith : 1 ≤ T)]
  have hlog4 : Real.log 4 = 2*Real.log 2 := by
    simpa only [show (2 : ℝ)^2 = 4 by norm_num,Nat.cast_ofNat] using Real.log_pow (2 : ℝ) 2
  have hlog : Real.log (2*Y+1) ≤ Real.log 4+Real.log Y := by
    rw [← Real.log_mul (by norm_num : (4 : ℝ) ≠ 0) (by linarith : Y ≠ 0)]
    exact Real.log_le_log (by linarith) (by linarith)
  rw [hlog4] at hlog
  have hh := Real.log_le_log (by norm_num : (0 : ℝ) < 2) hT
  change 1+Real.log (2*Y+1) ≤ 8*Real.log T
  linarith [one_le_two_log T hT]

theorem balanced_scale_below_half_height_square (T σ : ℝ) (hT : 16 ≤ T) (hσ1 : σ ≤ 1) :
    T^detectorBalanceExponent σ ≤ (T/2)^2 := by
  have hTp : 0 < T := by linarith
  have hsqrt : Real.sqrt T ≤ T/4 := by
    apply (pow_le_pow_iff_left₀ (Real.sqrt_nonneg T) (by linarith : 0 ≤ T/4)
      (by decide : (2 : ℕ) ≠ 0)).mp
    rw [Real.sq_sqrt hTp.le]
    nlinarith
  calc
    _ ≤ T^(3/2 : ℝ) := Real.rpow_le_rpow_of_exponent_le (by linarith)
      (balance_exponent_le_three_halves σ hσ1)
    _ = T*Real.sqrt T := by
      rw [Real.sqrt_eq_rpow,show (3/2 : ℝ) = 1+1/2 by norm_num,
        Real.rpow_add hTp,Real.rpow_one]
    _ ≤ T*(T/4) := mul_le_mul_of_nonneg_left hsqrt hTp.le
    _ = _ := by ring

theorem balanced_inverse_gap (T σ : ℝ) (hT : 2 ≤ T) (hσ : 1/2 < σ)
    (hgap : 1/Real.log T ≤ σ-1/2) : 1/(σ-1/2) ≤ Real.log T := by
  have hl : 0 < Real.log T := Real.log_pos (by linarith)
  have hh := mul_le_mul_of_nonneg_right hgap hl.le
  rw [div_mul_cancel₀ _ hl.ne'] at hh
  exact (div_le_iff₀ (by linarith : 0 < σ-1/2)).mpr (by nlinarith)

theorem balanced_count_from_cube (C R T σ L : ℝ) (hC : 0 ≤ C) (hR : 0 ≤ R) (hT : 0 ≤ T)
    (h : R^3 ≤ C*(T^balancedDensityExponent σ)^3*L^12) :
    R ≤ (C+1)*T^balancedDensityExponent σ*L^4 := by
  have hc : C ≤ (C+1)^3 := by nlinarith [sq_nonneg C]
  have hh : R^3 ≤ ((C+1)*T^balancedDensityExponent σ*L^4)^3 := by
    apply h.trans
    have hm := mul_le_mul_of_nonneg_right hc
      (show 0 ≤ (T^balancedDensityExponent σ)^3*L^12 by positivity)
    convert hm using 1 <;> ring
  exact (pow_le_pow_iff_left₀ hR (by positivity) (by decide : (3 : ℕ) ≠ 0)).mp hh

end Legendre.Density.Moment
