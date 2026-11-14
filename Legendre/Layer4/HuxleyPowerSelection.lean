/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local integer-power selection for the classical curved density strategy.
The range [3/4,5/6] is explicit; no density bound is asserted by this algebra.
-/
module
public import Legendre.Layer4.HuxleyDensity
public import Legendre.Layer4.Arithmetic.BlockPolynomialPowers

@[expose] public section
namespace Legendre.Density.Moment

noncomputable def huxleyCurvedExponent (σ : ℝ) : ℝ := 3*(1-σ)/(3*σ-1)
noncomputable def huxleyPowerLower (σ : ℝ) : ℝ := 1/(3*σ-1)
noncomputable def huxleyPowerUpper (σ : ℝ) : ℝ := 3/(2*(3*σ-1))
noncomputable def huxleyPowerBudget (δ : ℝ) : ℕ := ⌈1/δ⌉₊+2

theorem huxley_power_window_bounds (σ : ℝ) (hσ : 3/4 ≤ σ) (hσu : σ ≤ 5/6) :
    0 < huxleyPowerLower σ ∧ huxleyPowerLower σ ≤ 1 ∧
      1 ≤ huxleyPowerUpper σ ∧ huxleyPowerUpper σ = (3/2)*huxleyPowerLower σ := by
  have hd : 0 < 3*σ-1 := by linarith
  refine ⟨by unfold huxleyPowerLower; positivity,?_,?_,?_⟩
  · unfold huxleyPowerLower
    apply (div_le_one hd).mpr
    linarith
  · unfold huxleyPowerUpper
    apply (le_div_iff₀ (show 0 < 2*(3*σ-1) by positivity)).mpr
    linarith
  · unfold huxleyPowerUpper huxleyPowerLower
    field_simp

/-- One bounded integer power puts every short block into the useful length window. -/
theorem huxley_short_block_power (δ u σ : ℝ) (hδ : 0 < δ) (hδu : δ ≤ u)
    (hu : u ≤ 1/2) (hσ : 3/4 ≤ σ) (hσu : σ ≤ 5/6) :
    ∃ k : ℕ, 1 ≤ k ∧ k ≤ huxleyPowerBudget δ ∧
      huxleyPowerLower σ ≤ (k : ℝ)*u ∧ (k : ℝ)*u ≤ huxleyPowerUpper σ := by
  have hup : 0 < u := hδ.trans_le hδu
  obtain ⟨hA,hA1,hB1,hBA⟩ := huxley_power_window_bounds σ hσ hσu
  by_cases hsmall : u ≤ huxleyPowerLower σ/2
  · let k := ⌈huxleyPowerLower σ/u⌉₊
    have hkl : huxleyPowerLower σ/u ≤ k := Nat.le_ceil _
    have hku : (k : ℝ) < huxleyPowerLower σ/u+1 := Nat.ceil_lt_add_one (by positivity)
    have hkp : 0 < (k : ℝ) := (div_pos hA hup).trans_le hkl
    have hk1 : 1 ≤ k := by exact_mod_cast hkp
    have hlow : huxleyPowerLower σ ≤ (k : ℝ)*u := (div_le_iff₀ hup).mp hkl
    have hhigh : (k : ℝ)*u ≤ huxleyPowerUpper σ := by
      have hh := (lt_div_iff₀ hup).mp (show (k : ℝ)-1 < huxleyPowerLower σ/u by linarith)
      rw [hBA]
      nlinarith
    have hratio : huxleyPowerLower σ/u ≤ 1/δ := by
      exact div_le_div₀ (by positivity) hA1 hδ hδu
    have hkK : k ≤ huxleyPowerBudget δ := by
      have hh : 1/δ ≤ (⌈1/δ⌉₊ : ℝ) := Nat.le_ceil _
      have huK : (k : ℝ) ≤ (⌈1/δ⌉₊ : ℝ)+2 := by linarith
      exact_mod_cast huK
    exact ⟨k,hk1,hkK,hlow,hhigh⟩
  · refine ⟨2,by norm_num,?_,?_,?_⟩
    · unfold huxleyPowerBudget
      omega
    · norm_num only [Nat.cast_ofNat]
      linarith
    · norm_num only [Nat.cast_ofNat]
      linarith

/-- Both terms of the proved classical large-value estimate fit the curved exponent. -/
theorem huxley_power_window_exponents (σ v : ℝ) (hσ : 3/4 ≤ σ) (hσu : σ ≤ 5/6)
    (hv : huxleyPowerLower σ ≤ v ∧ v ≤ huxleyPowerUpper σ) :
    v*(2-2*σ) ≤ huxleyCurvedExponent σ ∧
      1+v*(4-6*σ) ≤ huxleyCurvedExponent σ := by
  have hd : 0 < 3*σ-1 := by linarith
  have he1 : huxleyPowerUpper σ*(2-2*σ) = huxleyCurvedExponent σ := by
    unfold huxleyPowerUpper huxleyCurvedExponent
    field_simp
  have he2 : 1+huxleyPowerLower σ*(4-6*σ) = huxleyCurvedExponent σ := by
    unfold huxleyPowerLower huxleyCurvedExponent
    field_simp
    ring
  constructor
  · exact (mul_le_mul_of_nonneg_right hv.2 (by linarith : 0 ≤ 2-2*σ)).trans_eq he1
  · have hh := mul_le_mul_of_nonpos_right hv.1 (by linarith : 4-6*σ ≤ 0)
    linarith

end Legendre.Density.Moment
