/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local epsilon-loss count for actual short Dirichlet blocks with divisor-type
coefficients. The constant is uniform in the block, real parts and threshold.
-/
module
public import Legendre.Layer4.HuxleyPoweredCount

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem exists_one_add_log_pow_le_rpow (j : ℕ) (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T → (1+Real.log T)^j ≤ C*T^ε := by
  obtain ⟨C,hC,hb⟩ := Zeta.exists_log_pow_le_rpow j hε
  have hl2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  let D := 1+1/Real.log 2
  have hD : 0 < D := by dsimp [D]; positivity
  refine ⟨D^j*C,by positivity,?_⟩
  intro T hT
  have hlT : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have h2T : Real.log 2 ≤ Real.log T := Real.log_le_log (by norm_num) hT
  have hL : 1+Real.log T ≤ D*Real.log T := by
    have hh : 1 ≤ Real.log T/Real.log 2 := (le_div_iff₀ hl2).mpr (by simpa using h2T)
    rw [div_eq_mul_inv] at hh
    dsimp [D]
    simp only [one_div]
    nlinarith
  calc
    _ ≤ (D*Real.log T)^j := pow_le_pow_left₀ (by linarith) hL j
    _ = D^j*(Real.log T)^j := mul_pow _ _ _
    _ ≤ D^j*(C*T^ε) := mul_le_mul_of_nonneg_left (hb T hT) (by positivity)
    _ = _ := by ring

/-- Classical curved exponent for actual short blocks, with a uniform bounded-power loss. -/
theorem huxley_short_block_epsilon_count (r : ℕ) (δ ε : ℝ) (hδ : 0 < δ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 3/4 ≤ σ → σ ≤ 5/6 →
      ∀ U : ℕ, T^δ ≤ (U : ℝ) → (U : ℝ) ≤ T^(1/2 : ℝ) →
      ∀ a : ℕ → ℂ, (∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ (n.divisors.card : ℝ)^r) →
      ∀ W : ℝ, 0 < W → W ≤ 1 → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
        a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) →
      (S.card : ℝ) ≤ C/W^(6*huxleyPowerBudget δ)*T^(huxleyCurvedExponent σ+ε) := by
  let K := huxleyPowerBudget δ
  let η := ε/24
  have hη : 0 < η := by dsimp [η]; linarith
  obtain ⟨C,hC,hamp⟩ := powered_block_uniform_amplitude r K η hη
  obtain ⟨E,hE,hlogs⟩ := exists_one_add_log_pow_le_rpow 16 (ε/2) (by linarith)
  let D := 1+C*((2 : ℝ)^K)^η
  let B := 32*Oscillation.halaszCountConstant*(K : ℝ)^7*((K : ℝ)+4)^15*((2 : ℝ)^(2*K)+1)
  have hK : 1 ≤ K := by dsimp [K,huxleyPowerBudget]; omega
  have hKp : (0 : ℝ) < K := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hK)
  have hD : 1 ≤ D := by
    dsimp [D]
    have hh : 0 < C*((2 : ℝ)^K)^η := by positivity
    linarith
  have hDp : 0 < D := by linarith
  have hB : 0 < B := by dsimp [B]; have := Oscillation.halaszCountConstant_pos; positivity
  refine ⟨B*D^6*E,by positivity,?_⟩
  intro T σ hT hσ hσu U hUlo hUhi a ha W hW hW1 ι S t β ht hβ hs hw
  have hTp : 0 < T := by linarith
  have hU1 : 1 ≤ U := by
    have hh := (Real.one_le_rpow (show 1 ≤ T by linarith) hδ.le).trans hUlo
    exact_mod_cast hh
  obtain ⟨k,hk,hkK,hlo,hhi⟩ := huxley_short_length_power T δ σ U hT hδ hUlo hUhi hσ hσu
  have hB2 : huxleyPowerUpper σ ≤ 2 := by
    unfold huxleyPowerUpper
    apply (div_le_iff₀ (show 0 < 2*(3*σ-1) by linarith)).mpr
    linarith
  have hNk : (U : ℝ)^k ≤ T^2 := by
    apply hhi.trans
    simpa only [Real.rpow_two] using Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith) hB2
  let A := D*T^(2*η)
  have hA : 1 ≤ A := by
    have hh : 1 ≤ T^(2*η) := Real.one_le_rpow (by linarith) (by positivity)
    dsimp [A]
    nlinarith
  have haA (n : ℕ) : ‖((Powers.blockArithmeticCoefficient a U (2*U))^k) n‖ ≤
      A*(n.divisors.card : ℝ) := by
    have hh := hamp a U k hU1 hkK ha n
    apply hh.trans
    apply mul_le_mul_of_nonneg_right _ (Nat.cast_nonneg _)
    have hp : C*((2 : ℝ)^K*(U : ℝ)^k)^η ≤ C*(((2 : ℝ)^K)^η*T^(2*η)) := by
      have hbase := Real.rpow_le_rpow (by positivity : (0 : ℝ) ≤ (2 : ℝ)^K*(U : ℝ)^k)
        (mul_le_mul_of_nonneg_left hNk (by positivity : (0 : ℝ) ≤ (2 : ℝ)^K)) hη.le
      have he : ((2 : ℝ)^K*T^2)^η = ((2 : ℝ)^K)^η*T^(2*η) := by
        rw [Real.mul_rpow (by positivity) (by positivity),←Real.rpow_natCast T 2,
          ←Real.rpow_mul hTp.le]
        norm_num
      rw [he] at hbase
      exact mul_le_mul_of_nonneg_left hbase hC.le
    apply hp.trans
    change C*(((2 : ℝ)^K)^η*T^(2*η)) ≤ D*T^(2*η)
    dsimp [D]
    nlinarith [Real.rpow_pos_of_pos hTp (2*η)]
  have hc := halasz_powered_window_count S t β a U k K hU1 hk hkK T σ W A hT hσ hσu
    hW hW1 hA hlo hhi ht hβ hs haA hw
  change (S.card : ℝ) ≤ B*A^6/W^(6*K)*T^huxleyCurvedExponent σ*(1+Real.log T)^16 at hc
  have hA6 : A^6 = D^6*T^(ε/2) := by
    dsimp [A]
    rw [mul_pow,←Real.rpow_natCast (T^(2*η)) 6,←Real.rpow_mul hTp.le]
    congr 2
    dsimp [η]
    ring
  rw [hA6] at hc
  have hp := mul_le_mul_of_nonneg_left (hlogs T hT)
    (show 0 ≤ B*(D^6*T^(ε/2))/W^(6*K)*T^huxleyCurvedExponent σ by positivity)
  apply hc.trans
  have he : T^(ε/2)*T^huxleyCurvedExponent σ*T^(ε/2) = T^(huxleyCurvedExponent σ+ε) := by
    rw [←Real.rpow_add hTp,←Real.rpow_add hTp]
    congr 1
    ring
  calc
    _ ≤ B*(D^6*T^(ε/2))/W^(6*K)*T^huxleyCurvedExponent σ*(E*T^(ε/2)) := hp
    _ = (B*D^6*E/W^(6*K))*(T^(ε/2)*T^huxleyCurvedExponent σ*T^(ε/2)) := by ring
    _ = _ := by rw [he]

end Legendre.Density.Moment
