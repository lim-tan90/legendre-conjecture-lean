/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local actual logarithmic-phase van der Corput bound, before scale optimization.
-/
module
public import Legendre.Layer4.Exponential.LogShiftBudget

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set Tools.ExponentialSum
open scoped BigOperators

/-- Differencing is applied to the actual phase values, with exact shortened overlaps. -/
theorem logarithmic_prefix_vdc_square (U M H : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (hH : 1 ≤ H) (hHM : H ≤ M) (t : ℝ) (ht : t ≠ 0) :
    ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))‖^2 ≤
      2*(U : ℝ)^2/H+2*(U : ℝ)*logarithmicShiftConstant*
        (Real.sqrt (|t| * H/(U : ℝ))+(U : ℝ)*Real.sqrt ((U : ℝ)/|t|)) := by
  have hC := logarithmicShiftConstant_pos
  have hMUr : (M : ℝ) ≤ U := by exact_mod_cast hMU
  have hb := Tools.van_der_corput_nat_interval
    (fun n => phase (logarithmicPhase t ((n : ℝ)+U))) M H hH hHM
    (logarithmicShiftConstant*(Real.sqrt (|t| * H/(U : ℝ))+
      (U : ℝ)*Real.sqrt ((U : ℝ)/|t|))) (by positivity)
    (by intro n hn; exact le_of_eq (phase_norm _))
    (by
      intro h hh hhH
      exact logarithmic_shift_correlation_uniform U (M-h) h H hU
        ((Nat.sub_le M h).trans hMU) hh hhH.le (hHM.trans hMU) t ht)
  apply hb.trans
  have hM2 := pow_le_pow_left₀ (Nat.cast_nonneg M : (0 : ℝ) ≤ M) hMUr 2
  have h1 := div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hM2 (by norm_num : (0 : ℝ) ≤ 2))
    (Nat.cast_nonneg H : (0 : ℝ) ≤ H)
  have h2 := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hMUr (by norm_num : (0 : ℝ) ≤ 2))
    (show 0 ≤ logarithmicShiftConstant*(Real.sqrt (|t| * H/(U : ℝ))+
      (U : ℝ)*Real.sqrt ((U : ℝ)/|t|)) by positivity)
  convert add_le_add h1 h2 using 1 <;> ring

/-- The prefix-phase sum is the actual complex Dirichlet block, without approximation. -/
theorem logarithmic_prefix_eq_block (U M : ℕ) (hU : 1 ≤ U) (t : ℝ) :
    (∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))) =
      ∑ n ∈ Finset.Ioc U (U+M), (n : ℂ)^(-(t : ℂ)*I) := by
  apply Finset.sum_bij (fun n _ => U+n)
  · intro n hn
    have hh := Finset.mem_Icc.mp hn
    exact Finset.mem_Ioc.mpr ⟨by omega,by omega⟩
  · intro n hn m hm he
    omega
  · intro n hn
    have hh := Finset.mem_Ioc.mp hn
    refine ⟨n-U,Finset.mem_Icc.mpr ⟨by omega,by omega⟩,by omega⟩
  · intro n hn
    have hh := Finset.mem_Icc.mp hn
    have he : (n : ℝ)+U = ((U+n : ℕ) : ℝ) := by push_cast; ring
    rw [he]
    simpa only [Complex.ofReal_natCast] using logarithmicPhase_eq_cpow t ((U+n : ℕ) : ℝ)
      (by exact_mod_cast (show 0 < U+n by omega))

end Legendre.Density.Oscillation
