/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local exact algebra for the classical global 12/5 density balance. These
parameter identities are not themselves a zero-density theorem.
-/
module
public import Legendre.Layer4.HalaszPolynomialAlternative
public import Legendre.Layer4.HalaszIntegralAlternative
public import Legendre.Layer4.DensityBalance

@[expose] public section
namespace Legendre.Density.Moment

noncomputable def huxleyBalanceDenominator (σ : ℝ) : ℝ := 2*(σ^2+σ-1)
noncomputable def huxleyMollifierExponent (σ : ℝ) : ℝ := (2*σ-1)/huxleyBalanceDenominator σ
noncomputable def huxleyDetectorExponent (σ : ℝ) : ℝ := (5*σ-3)/huxleyBalanceDenominator σ
noncomputable def huxleyBookExponent (σ : ℝ) : ℝ := (5*σ-3)*(1-σ)/(σ^2+σ-1)

theorem huxley_denominator_pos (σ : ℝ) (hσ : 3/4 ≤ σ) :
    0 < huxleyBalanceDenominator σ := by
  unfold huxleyBalanceDenominator
  nlinarith [sq_nonneg (σ-3/4)]

theorem huxley_mollifier_exponent_bounds (σ : ℝ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    1/2 ≤ huxleyMollifierExponent σ ∧ huxleyMollifierExponent σ ≤ 4/5 := by
  have hd := huxley_denominator_pos σ hσ
  unfold huxleyMollifierExponent
  constructor
  · apply (le_div_iff₀ hd).mpr
    unfold huxleyBalanceDenominator
    nlinarith [mul_nonneg (show 0 ≤ σ by linarith) (show 0 ≤ 1-σ by linarith)]
  · apply (div_le_iff₀ hd).mpr
    unfold huxleyBalanceDenominator
    nlinarith [mul_nonneg (show 0 ≤ σ-3/4 by linarith) (show 0 ≤ σ+1/2 by linarith)]

theorem huxley_detector_exponent_bounds (σ : ℝ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    1 ≤ huxleyDetectorExponent σ ∧ huxleyDetectorExponent σ ≤ 6/5 := by
  have hd := huxley_denominator_pos σ hσ
  unfold huxleyDetectorExponent
  constructor
  · apply (le_div_iff₀ hd).mpr
    unfold huxleyBalanceDenominator
    nlinarith [mul_nonneg (show 0 ≤ 2*σ-1 by linarith) (show 0 ≤ 1-σ by linarith)]
  · apply (div_le_iff₀ hd).mpr
    unfold huxleyBalanceDenominator
    nlinarith [mul_nonneg (show 0 ≤ σ-3/4 by linarith) (show 0 ≤ σ-1/3 by linarith)]

theorem huxley_book_exponent_bounds (σ : ℝ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    0 ≤ huxleyBookExponent σ ∧ huxleyBookExponent σ ≤ (12/5)*(1-σ) := by
  have hd : 0 < σ^2+σ-1 := by have := huxley_denominator_pos σ hσ; unfold huxleyBalanceDenominator at this; linarith
  constructor
  · unfold huxleyBookExponent
    exact div_nonneg (mul_nonneg (by linarith) (by linarith)) hd.le
  · unfold huxleyBookExponent
    apply (div_le_iff₀ hd).mpr
    have hpoly : 0 ≤ 12*σ^2-13*σ+3 := by
      nlinarith [mul_nonneg (show 0 ≤ σ-3/4 by linarith) (show 0 ≤ σ-1/3 by linarith)]
    nlinarith [mul_nonneg hpoly (show 0 ≤ 1-σ by linarith)]

theorem huxley_book_exponent_le_one (σ : ℝ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    huxleyBookExponent σ ≤ 1 := by
  have := (huxley_book_exponent_bounds σ hσ hσ1).2
  linarith

theorem huxley_polynomial_exponents (σ : ℝ) (hσ : 3/4 ≤ σ) :
    huxleyDetectorExponent σ*(2-2*σ) = huxleyBookExponent σ ∧
    1+huxleyMollifierExponent σ*(4-6*σ) = huxleyBookExponent σ := by
  have hd := (huxley_denominator_pos σ hσ).ne'
  unfold huxleyDetectorExponent huxleyMollifierExponent huxleyBookExponent
  have hq : σ^2+σ-1 ≠ 0 := by
    have := huxley_denominator_pos σ hσ
    unfold huxleyBalanceDenominator at this
    linarith
  unfold huxleyBalanceDenominator at *
  ring_nf at hq
  constructor <;> field_simp [hq] <;> ring_nf <;> field_simp <;> ring

theorem huxley_integral_exponents (σ : ℝ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    1+2*huxleyMollifierExponent σ+(2-4*σ)*huxleyDetectorExponent σ ≤ 3*huxleyBookExponent σ ∧
    5/3+(2/3)*huxleyMollifierExponent σ+(2-4*σ)*huxleyDetectorExponent σ = (5/3)*huxleyBookExponent σ := by
  have hd := huxley_denominator_pos σ hσ
  have hq : 0 < σ^2+σ-1 := by unfold huxleyBalanceDenominator at hd; linarith
  constructor
  · apply (mul_le_mul_iff_left₀ hd).mp
    have hq0 := hq.ne'
    ring_nf at hq0
    have he : huxleyBalanceDenominator σ*(3*huxleyBookExponent σ-
        (1+2*huxleyMollifierExponent σ+(2-4*σ)*huxleyDetectorExponent σ)) =
        4*(3*σ-2)*(1-σ) := by
      unfold huxleyBookExponent huxleyMollifierExponent huxleyDetectorExponent huxleyBalanceDenominator
      field_simp [hq0]
      ring_nf
      field_simp [hq0]
      ring
    have hp : 0 ≤ 4*(3*σ-2)*(1-σ) :=
      mul_nonneg (mul_nonneg (by norm_num) (by linarith)) (by linarith)
    rw [←he] at hp
    nlinarith
  · have hq0 := hq.ne'
    ring_nf at hq0
    unfold huxleyBookExponent huxleyMollifierExponent huxleyDetectorExponent huxleyBalanceDenominator
    field_simp [hq0]
    ring_nf
    field_simp [hq0]
    ring

theorem huxley_polynomial_powers (T X σ : ℝ) (hT : 1 ≤ T)
    (hX : T^huxleyMollifierExponent σ ≤ X) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    (T^huxleyDetectorExponent σ)^(2-2*σ)+T*X^(4-6*σ) ≤ 2*T^huxleyBookExponent σ := by
  have hTp : 0 < T := by linarith
  obtain ⟨hy,hx⟩ := huxley_polynomial_exponents σ hσ
  have he : (T^huxleyDetectorExponent σ)^(2-2*σ) = T^huxleyBookExponent σ := by
    rw [←Real.rpow_mul hTp.le,hy]
  have hh := Real.rpow_le_rpow_of_nonpos (Real.rpow_pos_of_pos hTp _) hX
    (show 4-6*σ ≤ 0 by linarith)
  have hp : T*(T^huxleyMollifierExponent σ)^(4-6*σ) = T^huxleyBookExponent σ := by
    rw [←Real.rpow_mul hTp.le,←hx,Real.rpow_add hTp,Real.rpow_one]
  rw [he]
  have hm := (mul_le_mul_of_nonneg_left hh hTp.le).trans_eq hp
  linarith

theorem huxley_integral_power_bounds (T X σ : ℝ) (hT : 1 ≤ T)
    (hX : 0 ≤ X) (hXu : X ≤ 2*T^huxleyMollifierExponent σ)
    (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    T*X^2*(T^huxleyDetectorExponent σ)^(2-4*σ) ≤ 4*(T^huxleyBookExponent σ)^3 ∧
    T*X^(2/3 : ℝ)*T^(2/3 : ℝ)*(T^huxleyDetectorExponent σ)^(2-4*σ) ≤
      2*(T^huxleyBookExponent σ)^(5/3 : ℝ) := by
  have hTp : 0 < T := by linarith
  obtain ⟨ha,hb⟩ := huxley_integral_exponents σ hσ hσ1
  constructor
  · have hp := pow_le_pow_left₀ hX hXu 2
    have he : T*(T^huxleyMollifierExponent σ)^2*(T^huxleyDetectorExponent σ)^(2-4*σ) =
        T^(1+2*huxleyMollifierExponent σ+(2-4*σ)*huxleyDetectorExponent σ) := by
      rw [←Real.rpow_natCast,←Real.rpow_mul hTp.le,←Real.rpow_mul hTp.le]
      conv_lhs => lhs; lhs; rw [←Real.rpow_one T]
      rw [←Real.rpow_add hTp,←Real.rpow_add hTp]
      congr 1; ring
    have hm := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hp hTp.le)
      (show 0 ≤ (T^huxleyDetectorExponent σ)^(2-4*σ) by positivity)
    have hpow := Real.rpow_le_rpow_of_exponent_le hT ha
    have he3 : T^(3*huxleyBookExponent σ) = (T^huxleyBookExponent σ)^3 := by
      rw [←Real.rpow_natCast,←Real.rpow_mul hTp.le]; congr 1; ring
    rw [he3] at hpow
    have hhe := mul_le_mul_of_nonneg_left (he.le.trans hpow) (by norm_num : (0 : ℝ) ≤ 4)
    nlinarith
  · have hp := Real.rpow_le_rpow hX hXu (by norm_num : (0 : ℝ) ≤ 2/3)
    rw [Real.mul_rpow (by norm_num : (0 : ℝ) ≤ 2) (Real.rpow_nonneg hTp.le _)] at hp
    have htwo : (2 : ℝ)^(2/3 : ℝ) ≤ 2 := by
      have := Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2) (by norm_num : (2/3 : ℝ) ≤ 1)
      simpa only [Real.rpow_one] using this
    have hx := hp.trans (mul_le_mul_of_nonneg_right htwo (by positivity))
    have he : T*(T^huxleyMollifierExponent σ)^(2/3 : ℝ)*T^(2/3 : ℝ)*
        (T^huxleyDetectorExponent σ)^(2-4*σ) = (T^huxleyBookExponent σ)^(5/3 : ℝ) := by
      rw [←Real.rpow_mul hTp.le,←Real.rpow_mul hTp.le,←Real.rpow_mul hTp.le]
      conv_lhs => lhs; lhs; lhs; rw [←Real.rpow_one T]
      rw [←Real.rpow_add hTp,←Real.rpow_add hTp,←Real.rpow_add hTp]
      congr 1
      linarith [hb]
    have hm := mul_le_mul_of_nonneg_right
      (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hx hTp.le) (show 0 ≤ T^(2/3 : ℝ) by positivity))
      (show 0 ≤ (T^huxleyDetectorExponent σ)^(2-4*σ) by positivity)
    convert hm using 1 <;> rw [←he] <;> ring

end Legendre.Density.Moment
