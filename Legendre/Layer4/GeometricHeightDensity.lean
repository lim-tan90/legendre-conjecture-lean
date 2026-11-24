/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Layer4.DyadicHeightDensity
public import Mathlib.Algebra.Field.GeomSum

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set

/-- A positive lower bound for the height exponent makes the dyadic
height sum geometric, without a logarithmic loss. -/
theorem height_shell_rpow_geometric (J : ℕ) (T e η : ℝ) (hT : 2 ≤ T)
    (hη : 0 < η) (hηe : η ≤ e) (he : e ≤ 1)
    (hJ : (2 : ℝ)^J ≤ 2*T) :
    (∑ j ∈ Finset.range J, (128*(2 : ℝ)^j)^e) ≤
      (256/((2 : ℝ)^η-1))*T^e := by
  have he₀ : 0 ≤ e := hη.le.trans hηe
  have hη2 : (1 : ℝ) < 2^η := Real.one_lt_rpow (by norm_num) hη
  have heη : (2 : ℝ)^η ≤ 2^e := Real.rpow_le_rpow_of_exponent_le (by norm_num) hηe
  have he2 : (1 : ℝ) < 2^e := hη2.trans_le heη
  have hden : 0 < (2 : ℝ)^η-1 := sub_pos.mpr hη2
  have hgeom :
      (∑ j ∈ Finset.range J, ((2 : ℝ)^e)^j) ≤ ((2 : ℝ)^e)^J/((2 : ℝ)^η-1) := by
    rw [geom_sum_eq he2.ne']
    calc
      _ ≤ ((2 : ℝ)^e)^J/((2 : ℝ)^e-1) :=
        div_le_div_of_nonneg_right (sub_le_self _ zero_le_one) (sub_nonneg.mpr he2.le)
      _ ≤ _ := div_le_div_of_nonneg_left (by positivity) hden (sub_le_sub_right heη _)
  have hpow (j : ℕ) : (128*(2 : ℝ)^j)^e = (128 : ℝ)^e*((2 : ℝ)^e)^j := by
    rw [Real.mul_rpow (by norm_num) (by positivity), ← Real.rpow_natCast_mul (by norm_num : (0 : ℝ) ≤ 2),
      mul_comm (j : ℝ) e, Real.rpow_mul (by norm_num), Real.rpow_natCast]
  have h128 : (128 : ℝ)^e ≤ 128 := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 128) he
  have h2 : (2 : ℝ)^e ≤ 2 := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 2) he
  have hlast : ((2 : ℝ)^e)^J ≤ 2*T^e := by
    have h := Real.rpow_le_rpow (by positivity : 0 ≤ (2 : ℝ)^J) hJ he₀
    rw [← Real.rpow_natCast_mul (by norm_num : (0 : ℝ) ≤ 2), mul_comm (J : ℝ) e,
      Real.rpow_mul (by norm_num), Real.rpow_natCast, Real.mul_rpow (by norm_num) (by linarith)] at h
    exact h.trans (mul_le_mul_of_nonneg_right h2 (by positivity))
  simp_rw [hpow]
  rw [← Finset.mul_sum]
  calc
    _ ≤ (128 : ℝ)^e*(((2 : ℝ)^e)^J/((2 : ℝ)^η-1)) :=
      mul_le_mul_of_nonneg_left hgeom (by positivity)
    _ ≤ 128*(2*T^e/((2 : ℝ)^η-1)) := by
      apply mul_le_mul h128 (div_le_div_of_nonneg_right hlast hden.le) (by positivity) (by norm_num)
    _ = _ := by ring

/-- Away from real part one, the shell estimate keeps its fifth logarithm
after summing over height. -/
theorem separated_high_density_log_five_away_one (τ : ℝ) (hτ : τ < 1) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 1/2 ≤ σ → σ ≤ τ →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^5 := by
  obtain ⟨C,hC,hc⟩ := separated_high_shell_density_uniform_log_five
  let η := 2*(1-τ)
  have hη : 0 < η := by dsimp [η]; linarith
  have hden : 0 < (2 : ℝ)^η-1 := sub_pos.mpr (Real.one_lt_rpow (by norm_num) hη)
  refine ⟨C*8^5*(256/((2 : ℝ)^η-1)),by positivity,?_⟩
  intro T σ hT hσ hστ ι S t β ht hs hz
  have hσ1 := hστ.trans hτ.le
  have hT₀ : 2 ≤ T := by linarith
  have hL : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have he := balancedDensityExponent_ge_two_defect σ hσ hσ1
  have hηe : η ≤ balancedDensityExponent σ := by dsimp [η]; linarith
  obtain ⟨J,hJl,hJu,_⟩ := real_height_dyadic_cover T hT₀
  have hS := separated_high_density_shell_sum 5 C hC.le hc S t β T σ J
    hT₀ hσ hσ1 hJl hJu ht hs hz
  have hG := height_shell_rpow_geometric J T (balancedDensityExponent σ) η hT₀ hη hηe
    (balancedDensityExponent_le_one σ hσ hσ1) hJu
  apply hS.trans
  calc
    _ ≤ (C*(8*Real.log T)^5)*((256/((2 : ℝ)^η-1))*T^balancedDensityExponent σ) :=
      mul_le_mul_of_nonneg_left hG (by positivity)
    _ = _ := by ring

end Legendre.Density.Moment
