/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityPolynomialBalanced.lean and DensityIntegralBalanced.lean
in openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The zeta specialization uses X=ceil(T), keeping the principal-pole constraint.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DensityBalance

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem polynomial_alternative_balanced :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ X : ℕ, 1 ≤ X → T ≤ X → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I)
        (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^8 := by
  obtain ⟨C,hC,hb⟩ := polynomial_alternative_count
  refine ⟨2*C*8^8,by positivity,?_⟩
  intro T σ hT hσ hσ1 X hX hTX ι S t β ht hs hβ hlarge
  let Y := T^detectorBalanceExponent σ
  have hY : 2 ≤ Y := by
    have hh := Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
      (balance_exponent_ge_one σ hσ hσ1)
    rw [Real.rpow_one] at hh
    exact hT.trans hh
  have h := hb X hX Y T σ hY (by linarith) hσ hσ1 S t β ht hs hβ hlarge
  have hlog := balanced_log_cost T σ hT hσ hσ1
  have hpow := balanced_polynomial_powers T X σ (by linarith) hTX hσ hσ1
  apply h.trans
  calc
    _ ≤ C*(8*Real.log T)^8*(2*T^balancedDensityExponent σ) := by
      apply mul_le_mul _ hpow (by positivity) (by positivity)
      exact mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (by
        have hh := Real.log_nonneg (by linarith : 1 ≤ 2*Y+1)
        linarith : 0 ≤ 1+Real.log (2*Y+1)) hlog 8) hC.le
    _ = _ := by ring

theorem integral_alternative_balanced :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 < σ → σ ≤ 1 →
      1/Real.log T ≤ σ-1/2 →
      ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ {ι : Type*} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X
        ((β i : ℂ)+(t i : ℂ)*I) (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^4 := by
  obtain ⟨C,hC,hb⟩ := integral_alternative_count
  let D := C*256^4*3^2*4^2
  have hD : 0 < D := by dsimp [D]; positivity
  refine ⟨D+1,by positivity,?_⟩
  intro T σ hT hσ hσ1 hgap
  obtain ⟨X,hX,hTX,hX2,hsize,hlogX⟩ := balanced_detector_cutoff T hT
  refine ⟨X,hX,hTX,hX2,?_⟩
  intro ι S β t ht hs hβ hlarge
  let Y := T^detectorBalanceExponent σ
  have hTp : 0 < T := by linarith
  have hY : 1 ≤ Y := Real.one_le_rpow (by linarith)
    (le_trans zero_le_one (balance_exponent_ge_one σ hσ.le hσ1))
  have hYp : 0 < Y := lt_of_lt_of_le zero_lt_one hY
  have hL : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have hXlog : 0 ≤ 1+Real.log X := by
    have hh := Real.log_nonneg (show (1 : ℝ) ≤ X by exact_mod_cast hX)
    linarith
  have hK : 256*Y^(1/2-σ)/(σ-1/2) ≤ 256*Y^(1/2-σ)*Real.log T := by
    have h := mul_le_mul_of_nonneg_left (balanced_inverse_gap T σ hT hσ hgap)
      (show 0 ≤ 256*Y^(1/2-σ) by positivity)
    convert h using 1
    ring
  have hpow : (Y^(1/2-σ))^(4 : ℕ) = Y^(2-4*σ) := by
    rw [← Real.rpow_natCast,← Real.rpow_mul hYp.le]
    congr 1
    ring
  have hK4 : (256*Y^(1/2-σ)/(σ-1/2))^4 ≤ 256^4*Y^(2-4*σ)*(Real.log T)^4 := by
    have h := pow_le_pow_left₀ (by positivity) hK 4
    simpa only [mul_pow,hpow] using h
  have hcount := hb X hX T σ Y hT hσ hY S β t ht hs hβ hlarge
  have hcube : (S.card : ℝ)^3 ≤ D*(T^balancedDensityExponent σ)^3*(Real.log T)^12 := by
    apply hcount.trans
    calc
      _ ≤ C*(256^4*Y^(2-4*σ)*(Real.log T)^4)*T*(3*T)^2*(Real.log T)^6*(4*Real.log T)^2 := by
        gcongr
      _ = D*(T^3*Y^(2-4*σ))*(Real.log T)^12 := by dsimp [D]; ring
      _ = _ := by rw [balanced_power_identity T σ hTp (by linarith)]
  exact balanced_count_from_cube D S.card T σ (Real.log T) hD.le (Nat.cast_nonneg _) hTp.le hcube

end Legendre.Density.Moment
