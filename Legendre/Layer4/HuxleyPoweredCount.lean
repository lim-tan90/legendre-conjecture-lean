/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local curved-exponent count for actual powered blocks in the selected window.
Coefficient and threshold losses remain explicit; no density estimate is assumed.
-/
module
public import Legendre.Layer4.HuxleyPoweredLengths

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem powered_length_log_bound (T Y : ℝ) (K : ℕ) (hT : 2 ≤ T) (hY : 1 ≤ Y)
    (hYu : Y ≤ (2 : ℝ)^K*T^2) :
    1+Real.log (2*Y+1) ≤ ((K : ℝ)+4)*(1+Real.log T) := by
  have hTp : 0 < T := by linarith
  have hD : (1 : ℝ) ≤ 2^K := one_le_pow₀ (by norm_num)
  have hT2 : (1 : ℝ) ≤ T^2 := by nlinarith
  have hprod : (1 : ℝ) ≤ (2 : ℝ)^K*T^2 := by nlinarith
  have harg : 2*Y+1 ≤ 4*(2 : ℝ)^K*T^2 := by linarith
  have hh := Real.log_le_log (by linarith : 0 < 2*Y+1) harg
  rw [Real.log_mul (by positivity : (4 : ℝ)*2^K ≠ 0) (by positivity : T^2 ≠ 0),
    Real.log_mul (by norm_num : (4 : ℝ) ≠ 0) (by positivity : (2 : ℝ)^K ≠ 0),
    Real.log_pow,Real.log_pow] at hh
  have hl4 := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 4)
  have hl2 := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
  have hlT := Real.log_nonneg (show 1 ≤ T by linarith)
  have hK0 : (0 : ℝ) ≤ K := Nat.cast_nonneg K
  norm_num at hh hl4 hl2
  nlinarith

/-- Both analytic terms now have the curved exponent, with every finite loss displayed. -/
theorem halasz_powered_window_count {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (a : ℕ → ℂ) (U k K : ℕ) (hU : 1 ≤ U) (hk : 1 ≤ k) (hkK : k ≤ K)
    (T σ W A : ℝ) (hT : 2 ≤ T) (hσ : 3/4 ≤ σ) (hσu : σ ≤ 5/6)
    (hW : 0 < W) (hW1 : W ≤ 1) (hA : 1 ≤ A)
    (hlo : T^huxleyPowerLower σ ≤ (U : ℝ)^k)
    (hhi : (U : ℝ)^k ≤ T^huxleyPowerUpper σ)
    (ht : ∀ i ∈ S, |t i| ≤ T) (hβ : ∀ i ∈ S, β i ∈ Icc σ 1)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (ha : ∀ n, ‖((Powers.blockArithmeticCoefficient a U (2*U))^k) n‖ ≤ A*(n.divisors.card : ℝ))
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
      a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) :
    (S.card : ℝ) ≤
      (32*Oscillation.halaszCountConstant*(K : ℝ)^7*((K : ℝ)+4)^15*((2 : ℝ)^(2*K)+1))*
        A^6/W^(6*K)*T^huxleyCurvedExponent σ*(1+Real.log T)^16 := by
  have hkp : (0 : ℝ) < k := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hk)
  have hk1 : (1 : ℝ) ≤ k := by exact_mod_cast hk
  have hkKr : (k : ℝ) ≤ K := by exact_mod_cast hkK
  have hAp : 0 < A := by linarith
  have hTp : 0 < T := by linarith
  have hKp : (0 : ℝ) < K := hkp.trans_le hkKr
  let Y : ℝ := ((2*U : ℕ)^k : ℝ)
  let G := T^huxleyCurvedExponent σ
  let L := 1+Real.log T
  let v := (k : ℝ)*A/W^k
  have hWk : 0 < W^k := pow_pos hW k
  have hWk1 : W^k ≤ 1 := pow_le_one₀ hW.le hW1
  have hv : 1 ≤ v := by
    apply (le_div_iff₀ hWk).mpr
    have hm : (1 : ℝ) ≤ (k : ℝ)*A := by nlinarith
    linarith
  have hYeq : Y = (2 : ℝ)^k*(U : ℝ)^k := by dsimp [Y]; push_cast; ring
  have hY1 : 1 ≤ Y := by
    rw [hYeq]
    have h2k : (1 : ℝ) ≤ 2^k := one_le_pow₀ (by norm_num)
    have hUk : (1 : ℝ) ≤ (U : ℝ)^k := one_le_pow₀ (by exact_mod_cast hU)
    nlinarith
  have hB : huxleyPowerUpper σ ≤ 2 := by
    unfold huxleyPowerUpper
    apply (div_le_iff₀ (show 0 < 2*(3*σ-1) by linarith)).mpr
    linarith
  have hYu : Y ≤ (2 : ℝ)^K*T^2 := by
    rw [hYeq]
    apply mul_le_mul (pow_le_pow_right₀ (by norm_num : (1 : ℝ) ≤ 2) hkK)
      (hhi.trans ?_) (by positivity) (by positivity)
    simpa only [Real.rpow_two] using Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith) hB
  have hlog := powered_length_log_bound T Y K hT hY1 hYu
  have hlogT := (height_log_costs T hT).2.2
  have hL : 1 ≤ L := (height_log_costs T hT).1
  have hnum := huxley_powered_length_terms T σ U k K hT hU hkK hσ hσu hlo hhi
  have hterm : Y^(2-2*σ)+T*(U : ℝ)^((k : ℝ)*(4-6*σ)) ≤ ((2 : ℝ)^(2*K)+1)*G := by
    dsimp [Y,G]
    nlinarith [hnum.1,hnum.2]
  have hq : W^k/((k : ℝ)*A) = 1/v := by dsimp [v]; field_simp
  have hrec := halasz_reciprocal_threshold v (Y^(2-2*σ))
    (T*(U : ℝ)^((k : ℝ)*(4-6*σ))) hv (by positivity) (by positivity)
  have hvu : v ≤ (K : ℝ)*A/W^K := by
    exact div_le_div₀ (by positivity) (mul_le_mul_of_nonneg_right hkKr hAp.le)
      (pow_pos hW K) (pow_le_pow_of_le_one hW.le hW1 hkK)
  have hv6 := pow_le_pow_left₀ (by dsimp [v]; positivity : 0 ≤ v) hvu 6
  have hpow : ((K : ℝ)*A/W^K)^6 = (K : ℝ)^6*A^6/W^(6*K) := by
    rw [div_pow,mul_pow,←pow_mul]
    congr 1
    congr 1
    omega
  rw [hpow] at hv6
  have hb := halasz_powered_block_count S t β a U k hU hk T σ W A (by linarith)
    (by linarith) (by linarith) hW hAp ht hβ hs ha hw
  change (S.card : ℝ) ≤ (k : ℝ)*(8*Oscillation.halaszCountConstant*
    (1+Real.log (2*Y+1))^15*(1+Real.log (2*T))*
      (Y^(2-2*σ)/(W^k/((k : ℝ)*A))^2+
        T*(U : ℝ)^((k : ℝ)*(4-6*σ))/(W^k/((k : ℝ)*A))^6)) at hb
  rw [hq] at hb
  have hinner := hrec.trans (mul_le_mul hv6 hterm (by positivity) (by positivity))
  have hcost : (k : ℝ)*(8*Oscillation.halaszCountConstant*(1+Real.log (2*Y+1))^15*
      (1+Real.log (2*T))) ≤ 32*Oscillation.halaszCountConstant*(K : ℝ)*
        ((K : ℝ)+4)^15*L^16 := by
    have hK := Oscillation.halaszCountConstant_pos
    have hlog0 : 0 ≤ 1+Real.log (2*Y+1) := by linarith [Real.log_nonneg (show 1 ≤ 2*Y+1 by linarith)]
    have hlogT0 : 0 ≤ 1+Real.log (2*T) := by linarith [Real.log_nonneg (show 1 ≤ 2*T by linarith)]
    calc
      _ ≤ (K : ℝ)*(8*Oscillation.halaszCountConstant*(((K : ℝ)+4)*L)^15*(4*L)) := by gcongr
      _ = _ := by ring
  have hHal := Oscillation.halaszCountConstant_pos
  have hp := mul_le_mul hcost hinner (by positivity) (by positivity)
  apply hb.trans
  convert hp using 1 <;> (try dsimp [G,L]) <;> ring

end Legendre.Density.Moment
