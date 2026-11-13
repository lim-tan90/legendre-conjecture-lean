/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deduction of the improved detector-block count from the proved analytic
Halasz estimate and divisor-square energy. No density hypothesis is assumed.
-/
module
public import Legendre.Layer4.Exponential.HalaszTwoTermCount
public import Legendre.Layer4.PolynomialBlockSampling

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem divisor_block_energy_linear (U : ℝ) (hU : 0 < U) (L σ : ℝ) :
    U*(2*U*L^3*U^(-2*σ)) = 2*L^3*U^(2-2*σ) := by
  rw [show (2-2*σ : ℝ) = 2+(-2*σ) by ring,Real.rpow_add hU,Real.rpow_two]
  ring

theorem divisor_block_energy_cubic (U : ℝ) (hU : 0 < U) (L σ : ℝ) :
    U*(2*U*L^3*U^(-2*σ))^3 = 8*L^9*U^(4-6*σ) := by
  have he : U^(4-6*σ) = U^4*(U^(-2*σ))^3 := by
    rw [show (4-6*σ : ℝ) = 4+(-2*σ)*3 by ring,Real.rpow_add hU,
      Real.rpow_mul hU.le,Real.rpow_ofNat,Real.rpow_ofNat]
  rw [he]
  ring

/-- The improved two-term block count preserves the lower-cutoff exponent 4-6 sigma. -/
theorem halasz_divisor_block_count {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (X U : ℕ) (hX : 1 ≤ X) (hXU : X ≤ U) (a : ℕ → ℂ) (T Y σ W : ℝ)
    (hT : 1 ≤ T) (hY : 2 ≤ Y) (hUY : (U : ℝ) ≤ Y)
    (hσ : 2/3 ≤ σ) (hσ1 : σ ≤ 1) (hW : 0 < W)
    (ht : ∀ i ∈ S, |t i| ≤ T) (hβ : ∀ i ∈ S, β i ∈ Icc σ 1)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (ha : ∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ n.divisors.card)
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
      a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) :
    (S.card : ℝ) ≤ 8*Oscillation.halaszCountConstant*(1+Real.log (2*Y+1))^15*
      (1+Real.log (2*T))*(Y^(2-2*σ)/W^2+T*(X : ℝ)^(4-6*σ)/W^6) := by
  have hU : 1 ≤ U := hX.trans hXU
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hXp : (0 : ℝ) < X := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hX)
  let L := 1+Real.log (2*Y+1)
  let E := coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ)
  have hL : 1 ≤ L := by
    have := Real.log_nonneg (show 1 ≤ 2*Y+1 by linarith)
    dsimp [L]; linarith
  have hlu : 0 ≤ 1+Real.log (2*U) := by
    have := Real.log_nonneg (show 1 ≤ 2*(U : ℝ) by exact_mod_cast (show 1 ≤ 2*U by omega))
    linarith
  have hl : 1+Real.log (2*U) ≤ L := by
    have hh := Real.log_le_log (show 0 < 2*(U : ℝ) by positivity)
      (show 2*(U : ℝ) ≤ 2*Y+1 by linarith)
    dsimp [L]; linarith
  have hE : E ≤ 2*(U : ℝ)*L^3*(U : ℝ)^(-2*σ) := by
    have hh := polynomialBlock_divisor_energy U hU a σ (by linarith) ha
    rw [polynomialBlock_energy] at hh
    apply hh.trans
    gcongr
  have hE0 : 0 ≤ E := coefficientEnergy_nonneg _ _
  have hlin : (U : ℝ)*E ≤ 2*L^3*Y^(2-2*σ) := by
    calc
      _ ≤ (U : ℝ)*(2*(U : ℝ)*L^3*(U : ℝ)^(-2*σ)) :=
        mul_le_mul_of_nonneg_left hE hUp.le
      _ = 2*L^3*(U : ℝ)^(2-2*σ) := divisor_block_energy_linear _ hUp L σ
      _ ≤ _ := mul_le_mul_of_nonneg_left (Real.rpow_le_rpow hUp.le hUY (by linarith)) (by positivity)
  have hcub : (U : ℝ)*E^3 ≤ 8*L^9*(X : ℝ)^(4-6*σ) := by
    calc
      _ ≤ (U : ℝ)*(2*(U : ℝ)*L^3*(U : ℝ)^(-2*σ))^3 :=
        mul_le_mul_of_nonneg_left (pow_le_pow_left₀ hE0 hE 3) hUp.le
      _ = 8*L^9*(U : ℝ)^(4-6*σ) := divisor_block_energy_cubic _ hUp L σ
      _ ≤ _ := mul_le_mul_of_nonneg_left
        (Real.rpow_le_rpow_of_nonpos hXp (by exact_mod_cast hXU) (by linarith)) (by positivity)
  have hL3 := pow_le_pow_right₀ hL (by norm_num : (3 : ℕ) ≤ 9)
  have hlin' : (U : ℝ)*E ≤ 8*L^9*Y^(2-2*σ) := by
    have hh := mul_le_mul_of_nonneg_right hL3 (Real.rpow_nonneg (by linarith : 0 ≤ Y) (2-2*σ))
    have hpow : 0 ≤ L^9*Y^(2-2*σ) := by positivity
    nlinarith
  have hh := Oscillation.halasz_complex_large_values_two_term S t β U hU a T σ 1 W hT hW
    hσ1 (by linarith) hβ ht hs hw
  have hK := Oscillation.halaszCountConstant_pos
  have hlogT : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
  have hcost : Oscillation.halaszCountConstant*(1+Real.log (2*U))^6*(1+Real.log (2*T)) ≤
      Oscillation.halaszCountConstant*L^6*(1+Real.log (2*T)) := by gcongr
  have hterm : (U : ℝ)*E/W^2+(U : ℝ)*T*E^3/W^6 ≤
      8*L^9*(Y^(2-2*σ)/W^2+T*(X : ℝ)^(4-6*σ)/W^6) := by
    have h1 := div_le_div_of_nonneg_right hlin' (sq_nonneg W)
    have h2 := div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hcub
      (show 0 ≤ T by linarith)) (show 0 ≤ W^6 by positivity)
    convert add_le_add h1 h2 using 1 <;> ring
  have hp := mul_le_mul hcost hterm (by positivity) (by positivity)
  apply hh.trans
  convert hp using 1 <;> dsimp [E,L] <;> ring

end Legendre.Density.Moment
