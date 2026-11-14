/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local Weyl-type cancellation for actual logarithmic sums at square-root length.
No zeta subconvexity or zero-density conclusion is assumed or asserted here.
-/
module
public import Legendre.Layer4.Exponential.WeylBudget

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set Tools.ExponentialSum
open scoped BigOperators

noncomputable def logarithmicWeylConstant : ℝ := Real.sqrt (4+8*logarithmicShiftConstant)

theorem logarithmicWeylConstant_pos : 0 < logarithmicWeylConstant := by
  have hh := logarithmicShiftConstant_pos
  unfold logarithmicWeylConstant
  positivity

/-- A cube-root choice of the actual integer shift gives a sixth-root phase saving. -/
theorem logarithmic_prefix_weyl_square (U M : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (t : ℝ) (ht : 1 ≤ |t|) (hU2 : (U : ℝ)^2 ≤ 4*|t|) :
    ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))‖^2 ≤
      (4+8*logarithmicShiftConstant)*(U : ℝ)*|t|^(1/3 : ℝ) := by
  have htp : 0 < |t| := by linarith
  have hs3 : (|t|^(1/3 : ℝ))^3 = |t| := by
    rw [←Real.rpow_natCast (|t|^(1/3 : ℝ)) 3,←Real.rpow_mul htp.le]
    norm_num
  have hnorm : ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))‖ ≤ (M : ℝ) := by
    calc
      _ ≤ ∑ n ∈ Finset.Icc 1 M, ‖phase (logarithmicPhase t ((n : ℝ)+U))‖ := norm_sum_le _ _
      _ = _ := by simp only [phase_norm,Finset.sum_const,nsmul_eq_mul,mul_one,Nat.card_Icc]; norm_num
  exact logarithmic_weyl_square_budget U M |t| (|t|^(1/3 : ℝ)) logarithmicShiftConstant _
    hU hMU ht (by positivity) (Real.one_le_rpow ht (by norm_num)) hs3 hU2
    logarithmicShiftConstant_pos.le (norm_nonneg _) hnorm
    (fun H hH hHM => logarithmic_prefix_vdc_square U M H hU hMU hH hHM t (abs_pos.mp htp))

/-- The square-root-length phase bound includes empty and short prefixes. -/
theorem logarithmic_prefix_weyl (U M : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (t : ℝ) (ht : 1 ≤ |t|) (hU2 : (U : ℝ)^2 ≤ 4*|t|) :
    ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicPhase t ((n : ℝ)+U))‖ ≤
      logarithmicWeylConstant*Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ) := by
  have htp : 0 < |t| := by linarith
  have hq : (|t|^(1/6 : ℝ))^2 = |t|^(1/3 : ℝ) := by
    rw [←Real.rpow_natCast (|t|^(1/6 : ℝ)) 2,←Real.rpow_mul htp.le]
    norm_num
  have hC : logarithmicWeylConstant^2 = 4+8*logarithmicShiftConstant := by
    unfold logarithmicWeylConstant
    rw [Real.sq_sqrt (by have hh := logarithmicShiftConstant_pos; positivity)]
  apply (sq_le_sq₀ (norm_nonneg _) (by have hh := logarithmicWeylConstant_pos; positivity)).mp
  rw [mul_pow,mul_pow,hC,Real.sq_sqrt (Nat.cast_nonneg U),hq]
  exact logarithmic_prefix_weyl_square U M hU hMU t ht hU2

/-- Actual complex-power cancellation on every subinterval of a short dyadic block. -/
theorem logarithmic_block_weyl (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V) (hV : V ≤ 2*U)
    (t : ℝ) (ht : 1 ≤ |t|) (hU2 : (U : ℝ)^2 ≤ 4*|t|) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)‖ ≤
      logarithmicWeylConstant*Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ) := by
  have hh := logarithmic_prefix_weyl U (V-U) hU (by omega) t ht hU2
  rw [logarithmic_prefix_eq_block U (V-U) hU t,Nat.add_sub_of_le hUV] at hh
  exact hh

end Legendre.Density.Oscillation
