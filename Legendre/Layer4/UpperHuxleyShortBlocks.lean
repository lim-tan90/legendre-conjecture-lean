/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local actual short-block count using the varying useful cutoff through sigma=1.
No long-block cancellation or density estimate is assumed.
-/
module
public import Legendre.Layer4.HuxleyWindowBlockEpsilon

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- The upper-range power selection concerns actual integer block lengths. -/
theorem huxley_varying_cutoff_length_power (T δ σ : ℝ) (U : ℕ) (hT : 2 ≤ T)
    (hδ : 0 < δ) (hU : T^δ ≤ (U : ℝ)) (hUt : (U : ℝ) ≤ T^huxleyShortCutoff σ)
    (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    ∃ k : ℕ, 1 ≤ k ∧ k ≤ huxleyPowerBudget δ ∧
      T^huxleyPowerLower σ ≤ (U : ℝ)^k ∧
      (U : ℝ)^k ≤ T^huxleyPowerUpper σ := by
  have hTp : 0 < T := by linarith
  have hlT : 0 < Real.log T := Real.log_pos (by linarith)
  have hUp : (0 : ℝ) < U := (Real.rpow_pos_of_pos hTp δ).trans_le hU
  let u := Real.log (U : ℝ)/Real.log T
  have hδu : δ ≤ u := by
    apply (le_div_iff₀ hlT).mpr
    have hh := Real.log_le_log (Real.rpow_pos_of_pos hTp _) hU
    rw [Real.log_rpow hTp] at hh
    linarith
  have hu : u ≤ huxleyShortCutoff σ := by
    apply (div_le_iff₀ hlT).mpr
    have hh := Real.log_le_log hUp hUt
    rw [Real.log_rpow hTp] at hh
    linarith
  obtain ⟨k,hk,hkK,hkl,hku⟩ := huxley_general_short_power δ u σ hδ hδu hu hσ hσ1
  have he : (U : ℝ)^k = T^((k : ℝ)*u) := by
    rw [←Real.rpow_natCast (U : ℝ) k,Real.rpow_def_of_pos hUp,Real.rpow_def_of_pos hTp]
    congr 1
    dsimp [u]
    field_simp
  refine ⟨k,hk,hkK,?_,?_⟩
  · rw [he]
    exact Real.rpow_le_rpow_of_exponent_le (by linarith) hkl
  · rw [he]
    exact Real.rpow_le_rpow_of_exponent_le (by linarith) hku

/-- Actual short blocks in the varying window have the curved exponent through sigma=1. -/
theorem huxley_varying_short_block_epsilon_count (r : ℕ) (δ ε : ℝ) (hδ : 0 < δ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 2 ≤ T → 3/4 ≤ σ → σ ≤ 1 →
      ∀ U : ℕ, T^δ ≤ (U : ℝ) → (U : ℝ) ≤ T^huxleyShortCutoff σ →
      ∀ a : ℕ → ℂ, (∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ (n.divisors.card : ℝ)^r) →
      ∀ W : ℝ, 0 < W → W ≤ 1 → ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, β i ∈ Icc σ 1) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
        a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) →
      (S.card : ℝ) ≤ C/W^(6*huxleyPowerBudget δ)*T^(huxleyCurvedExponent σ+ε) := by
  obtain ⟨C,hC,hb⟩ := huxley_window_block_epsilon_count r (huxleyPowerBudget δ)
    (by unfold huxleyPowerBudget; omega) ε hε
  refine ⟨C,hC,?_⟩
  intro T σ hT hσ hσ1 U hUlo hUhi a ha W hW hW1 ι S t β ht hβ hs hw
  have hU1 : 1 ≤ U := by
    exact_mod_cast (Real.one_le_rpow (show 1 ≤ T by linarith) hδ.le).trans hUlo
  obtain ⟨k,hk,hkK,hlo,hhi⟩ := huxley_varying_cutoff_length_power T δ σ U hT hδ hUlo hUhi hσ hσ1
  exact hb T σ hT hσ hσ1 U k hU1 hk hkK hlo hhi a ha W hW hW1 S t β ht hβ hs hw

end Legendre.Density.Moment
