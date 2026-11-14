/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local conversion of integer-power selection to actual Dirichlet-block lengths.
The real-part range is retained explicitly.
-/
module
public import Legendre.Layer4.HuxleyPowerSelection
public import Legendre.Layer4.HalaszPoweredBlock

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- Actual short-block lengths admit a uniformly bounded useful integer power. -/
theorem huxley_short_length_power (T δ σ : ℝ) (U : ℕ) (hT : 2 ≤ T) (hδ : 0 < δ)
    (hU : T^δ ≤ (U : ℝ)) (hUt : (U : ℝ) ≤ T^(1/2 : ℝ))
    (hσ : 3/4 ≤ σ) (hσu : σ ≤ 5/6) :
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
  have hu : u ≤ 1/2 := by
    apply (div_le_iff₀ hlT).mpr
    have hh := Real.log_le_log hUp hUt
    rw [Real.log_rpow hTp] at hh
    linarith
  obtain ⟨k,hk,hkK,hkl,hku⟩ := huxley_short_block_power δ u σ hδ hδu hu hσ hσu
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

/-- The actual powered-length window controls both analytic count numerators. -/
theorem huxley_powered_length_terms (T σ : ℝ) (U k K : ℕ) (hT : 2 ≤ T)
    (hU : 1 ≤ U) (hkK : k ≤ K) (hσ : 3/4 ≤ σ) (hσu : σ ≤ 5/6)
    (hlo : T^huxleyPowerLower σ ≤ (U : ℝ)^k)
    (hhi : (U : ℝ)^k ≤ T^huxleyPowerUpper σ) :
    (((2*U : ℕ)^k : ℝ)^(2-2*σ) ≤ (2 : ℝ)^(2*K)*T^huxleyCurvedExponent σ) ∧
      T*(U : ℝ)^((k : ℝ)*(4-6*σ)) ≤ T^huxleyCurvedExponent σ := by
  have hTp : 0 < T := by linarith
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hexps := huxley_power_window_exponents σ (huxleyPowerUpper σ) hσ hσu
    ⟨by
      obtain ⟨hA,_,_,he⟩ := huxley_power_window_bounds σ hσ hσu
      rw [he]
      nlinarith,le_rfl⟩
  constructor
  · have h2exp : 0 ≤ 2-2*σ := by linarith
    have htwo : ((2 : ℝ)^k)^(2-2*σ) ≤ (2 : ℝ)^(2*K) := by
      rw [←Real.rpow_natCast (2 : ℝ) k,←Real.rpow_mul (by norm_num : (0 : ℝ) ≤ 2),
        ←Real.rpow_natCast (2 : ℝ) (2*K)]
      apply Real.rpow_le_rpow_of_exponent_le (by norm_num)
      have hkKr : (k : ℝ) ≤ K := by exact_mod_cast hkK
      have hk0 : (0 : ℝ) ≤ k := Nat.cast_nonneg k
      push_cast
      nlinarith
    have hbase : ((U : ℝ)^k)^(2-2*σ) ≤ T^huxleyCurvedExponent σ := by
      have hh := Real.rpow_le_rpow (by positivity : (0 : ℝ) ≤ (U : ℝ)^k) hhi h2exp
      rw [←Real.rpow_mul hTp.le] at hh
      exact hh.trans (Real.rpow_le_rpow_of_exponent_le (by linarith) hexps.1)
    push_cast
    rw [mul_pow,Real.mul_rpow (by positivity) (by positivity)]
    exact mul_le_mul htwo hbase (by positivity) (by positivity)
  · have hneg : 4-6*σ ≤ 0 := by linarith
    have hh := Real.rpow_le_rpow_of_nonpos (Real.rpow_pos_of_pos hTp _) hlo hneg
    rw [←Real.rpow_natCast (U : ℝ) k,←Real.rpow_mul hUp.le,←Real.rpow_mul hTp.le] at hh
    have hb := mul_le_mul_of_nonneg_left hh hTp.le
    have he : T*T^(huxleyPowerLower σ*(4-6*σ)) = T^huxleyCurvedExponent σ := by
      conv_lhs => lhs; rw [←Real.rpow_one T]
      rw [←Real.rpow_add hTp]
      congr 1
      unfold huxleyPowerLower huxleyCurvedExponent
      have hd : 3*σ-1 ≠ 0 := by linarith
      field_simp [hd]
      ring
    exact hb.trans_eq he

end Legendre.Density.Moment
