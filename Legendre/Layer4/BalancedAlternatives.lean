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

universe u

theorem polynomial_alternative_balanced_of_count (k : ℕ)
    (hcount : ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ Y T σ : ℝ,
      2 ≤ Y → 1 ≤ T → 1/2 ≤ σ → σ ≤ 1 → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ) ≤ C*(1+Real.log (2*Y+1))^k*
        (Y^(2-2*σ)+T*(X : ℝ)^(1-2*σ))) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ X : ℕ, 1 ≤ X → T ≤ X → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I)
        (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^k := by
  obtain ⟨C,hC,hb⟩ := hcount
  refine ⟨2*C*8^k,by positivity,?_⟩
  intro T σ hT hσ hσ1 X hX hTX ι S t β ht hs hβ hlarge
  let Y := T^detectorBalanceExponent σ
  have hY : 2 ≤ Y := by
    have hh := Real.rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ T)
      (balance_exponent_ge_one σ hσ hσ1)
    rw [Real.rpow_one] at hh
    exact hT.trans hh
  have h := hb X hX Y T σ hY (by linarith) hσ hσ1 S t β ht hs hβ hlarge
  have hlog := balanced_log_cost T σ hT hσ hσ1
  have hL0 : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have hpow := balanced_polynomial_powers T X σ (by linarith) hTX hσ hσ1
  apply h.trans
  calc
    _ ≤ C*(8*Real.log T)^k*(2*T^balancedDensityExponent σ) := by
      apply mul_le_mul _ hpow (by positivity) (by positivity)
      exact mul_le_mul_of_nonneg_left (pow_le_pow_left₀ (by
        have hh := Real.log_nonneg (by linarith : 1 ≤ 2*Y+1)
        linarith : 0 ≤ 1+Real.log (2*Y+1)) hlog k) hC.le
    _ = _ := by rw [mul_pow]; ring

theorem polynomial_alternative_balanced :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ X : ℕ, 1 ≤ X → T ≤ X → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I)
        (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^8 :=
  polynomial_alternative_balanced_of_count 8 polynomial_alternative_count

theorem polynomial_alternative_balanced_log_five :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 ≤ σ → σ ≤ 1 →
      ∀ X : ℕ, 1 ≤ X → T ≤ X → ∀ {ι : Type u} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail X ((β i : ℂ)+(t i : ℂ)*I)
        (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^5 :=
  polynomial_alternative_balanced_of_count 5 polynomial_alternative_count_log_five

theorem integral_alternative_balanced_by_gap_of_count (k : ℕ) (hinput : ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T σ Y : ℝ,
      2 ≤ T → 1/2 < σ → 1 ≤ Y → ∀ {ι : Type u} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ)^3 ≤ C*(256*Y^(1/2-σ)/(σ-1/2))^4*T*((X : ℝ)+T)^2*
        (Real.log T)^k*(1+Real.log X)^2) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 < σ → σ ≤ 1 →
      ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ {ι : Type u} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X
        ((β i : ℂ)+(t i : ℂ)*I) (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(1/(σ-1/2))^(4/3 : ℝ)*(Real.log T)^(((k : ℝ)+2)/3) := by
  obtain ⟨C,hC,hb⟩ := hinput
  let D := C*256^4*3^2*4^2
  have hD : 0 < D := by dsimp [D]; positivity
  refine ⟨D+1,by positivity,?_⟩
  intro T σ hT hσ hσ1
  obtain ⟨X,hX,hTX,hX2,hsize,hlogX⟩ := balanced_detector_cutoff T hT
  refine ⟨X,hX,hTX,hX2,?_⟩
  intro ι S β t ht hs hβ hlarge
  let Y := T^detectorBalanceExponent σ
  have hTp : 0 < T := by linarith
  have hY : 1 ≤ Y := Real.one_le_rpow (by linarith)
    (le_trans zero_le_one (balance_exponent_ge_one σ hσ.le hσ1))
  have hYp : 0 < Y := lt_of_lt_of_le zero_lt_one hY
  have hL : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  let Δ := 1/(σ-1/2)
  have hΔ : 0 < Δ := one_div_pos.mpr (by linarith)
  have hXlog : 0 ≤ 1+Real.log X := by
    have hh := Real.log_nonneg (show (1 : ℝ) ≤ X by exact_mod_cast hX)
    linarith
  have hpow : (Y^(1/2-σ))^(4 : ℕ) = Y^(2-4*σ) := by
    rw [← Real.rpow_natCast,← Real.rpow_mul hYp.le]
    congr 1
    ring
  have hK4 : (256*Y^(1/2-σ)/(σ-1/2))^4 = 256^4*Y^(2-4*σ)*Δ^4 := by
    rw [show 256*Y^(1/2-σ)/(σ-1/2) = 256*Y^(1/2-σ)*Δ by dsimp [Δ]; ring,
      mul_pow,mul_pow,hpow]
  have hcount := hb X hX T σ Y hT hσ hY S β t ht hs hβ hlarge
  have hcube : (S.card : ℝ)^3 ≤ D*(T^balancedDensityExponent σ)^3*Δ^4*(Real.log T)^(k+2) := by
    apply hcount.trans
    rw [hK4]
    calc
      _ ≤ C*(256^4*Y^(2-4*σ)*Δ^4)*T*(3*T)^2*(Real.log T)^k*(4*Real.log T)^2 := by
        gcongr
      _ = D*(T^3*Y^(2-4*σ))*Δ^4*(Real.log T)^(k+2) := by rw [pow_add]; dsimp [D]; ring
      _ = _ := by rw [balanced_power_identity T σ hTp (by linarith)]
  have hΔpow : (Δ^(4/3 : ℝ))^3 = Δ^4 := by
    rw [← Real.rpow_mul_natCast hΔ.le]
    norm_num [show (4 : ℝ) = ((4 : ℕ) : ℝ) by norm_num, Real.rpow_natCast]
  have hLpow : ((Real.log T)^(((k : ℝ)+2)/3))^3 = (Real.log T)^(k+2) := by
    rw [← Real.rpow_mul_natCast hL, Nat.cast_ofNat, div_mul_cancel₀ _ (by norm_num),
      ← Nat.cast_ofNat (n := 2), ← Nat.cast_add, Real.rpow_natCast]
  have hc : D ≤ (D+1)^3 := by nlinarith [sq_nonneg D]
  apply (pow_le_pow_iff_left₀ (Nat.cast_nonneg _) (by positivity) (by decide : (3 : ℕ) ≠ 0)).mp
  apply hcube.trans
  rw [mul_pow,mul_pow,mul_pow,hLpow,hΔpow]
  have h := mul_le_mul_of_nonneg_right hc
    (show 0 ≤ (T^balancedDensityExponent σ)^3*Δ^4*(Real.log T)^(k+2) by positivity)
  convert h using 1 <;> ring

theorem integral_alternative_balanced_of_count (k : ℕ) (hinput : ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T σ Y : ℝ,
      2 ≤ T → 1/2 < σ → 1 ≤ Y → ∀ {ι : Type u} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤
        ‖Detector.Smooth.detectorCriticalIntegral X ((β i : ℂ)+(t i : ℂ)*I) Y‖) →
      (S.card : ℝ)^3 ≤ C*(256*Y^(1/2-σ)/(σ-1/2))^4*T*((X : ℝ)+T)^2*
        (Real.log T)^k*(1+Real.log X)^2) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 < σ → σ ≤ 1 →
      1/Real.log T ≤ σ-1/2 →
      ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ {ι : Type u} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X
        ((β i : ℂ)+(t i : ℂ)*I) (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^(((k : ℝ)+6)/3) := by
  obtain ⟨C,hC,hb⟩ := integral_alternative_balanced_by_gap_of_count k hinput
  refine ⟨C,hC,?_⟩
  intro T σ hT hσ hσ1 hgap
  obtain ⟨X,hX,hTX,hX2,hbX⟩ := hb T σ hT hσ hσ1
  refine ⟨X,hX,hTX,hX2,?_⟩
  intro ι S β t ht hs hβ hlarge
  have hlog : 0 < Real.log T := Real.log_pos (by linarith)
  have hdelta := balanced_inverse_gap T σ hT hσ hgap
  have hΔ : 0 ≤ 1/(σ-1/2) := (one_div_pos.mpr (by linarith : 0 < σ-1/2)).le
  apply (hbX S β t ht hs hβ hlarge).trans
  calc
    _ ≤ C*T^balancedDensityExponent σ*(Real.log T)^(4/3 : ℝ)*(Real.log T)^(((k : ℝ)+2)/3) :=
      mul_le_mul_of_nonneg_right
        (mul_le_mul_of_nonneg_left (Real.rpow_le_rpow hΔ hdelta (by norm_num)) (by positivity))
        (by positivity)
    _ = _ := by
      rw [mul_assoc, ← Real.rpow_add hlog,
        show (4/3 : ℝ)+((k : ℝ)+2)/3 = ((k : ℝ)+6)/3 by ring]

theorem integral_alternative_balanced :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 < σ → σ ≤ 1 →
      1/Real.log T ≤ σ-1/2 →
      ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ {ι : Type u} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X
        ((β i : ℂ)+(t i : ℂ)*I) (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^4 := by
  have h := integral_alternative_balanced_of_count 6 integral_alternative_count
  norm_num only [Nat.cast_ofNat, show ((6 : ℝ)+6)/3 = 4 by norm_num,
    ← Real.rpow_natCast _ 4] at *
  exact h

theorem integral_alternative_balanced_log_ten_thirds :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 < σ → σ ≤ 1 →
      1/Real.log T ≤ σ-1/2 →
      ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ {ι : Type u} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X
        ((β i : ℂ)+(t i : ℂ)*I) (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(Real.log T)^(10/3 : ℝ) := by
  have h := integral_alternative_balanced_of_count 4 integral_alternative_count_log_four
  norm_num only [Nat.cast_ofNat, show ((4 : ℝ)+6)/3 = 10/3 by norm_num] at h
  exact h

theorem integral_alternative_balanced_fourth_moment_by_gap :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 1/2 < σ → σ ≤ 1 →
      ∃ X : ℕ, 1 ≤ X ∧ T ≤ X ∧ (X : ℝ) ≤ 2*T ∧
      ∀ {ι : Type u} (S : Finset ι) (β t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral X
        ((β i : ℂ)+(t i : ℂ)*I) (T^detectorBalanceExponent σ)‖) →
      (S.card : ℝ) ≤ C*T^balancedDensityExponent σ*(1/(σ-1/2))^(4/3 : ℝ)*(Real.log T)^2 := by
  have h := integral_alternative_balanced_by_gap_of_count 4 integral_alternative_count_log_four
  norm_num only [Nat.cast_ofNat, show ((4 : ℝ)+2)/3 = 2 by norm_num,
    ← Real.rpow_natCast _ 2] at *
  exact h

end Legendre.Density.Moment
