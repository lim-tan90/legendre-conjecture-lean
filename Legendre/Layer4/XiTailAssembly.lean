/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityTailAssembly.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiDyadicMean
public import Legendre.Layer4.BlockWeights

@[expose] public section
namespace Legendre.Zeta

open Complex MeasureTheory Set
open Density Density.Moment
open scoped BigOperators Classical

 theorem xiFiniteSquare_tail_assembly :
    ∃ C : ℝ, 0 < C ∧ ∀ N : ℕ, 1 ≤ N → ∀ T : ℝ, 1 ≤ T →
      10 * T ≤ N → ∀ J : ℕ,
      (∫ t in Icc (-T) T,
        ‖∑ j ∈ Finset.range J, ∑ n ∈ Finset.Ioc (2 ^ j * N) (2 ^ (j + 1) * N),
          xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖ ^ 2) ≤
          C * ((N : ℝ) + T) * (1 + Real.log N) ^ 3 := by
  obtain ⟨C, hC, hb⟩ := xiFiniteSquare_dyadic_mean
  refine ⟨4 * C * momentBlockEnergyConstant, by
    have := momentBlockEnergyConstant_pos
    positivity, ?_⟩
  intro N hN T hT hscale J
  let K := ((N : ℝ) + T) * (1 + Real.log N) ^ 3
  have hK : 0 ≤ K := by
    have hNl := Real.log_nonneg (show (1 : ℝ) ≤ N by exact_mod_cast hN)
    dsimp [K]
    positivity
  let f := fun (j : ℕ) (t : ℝ) =>
    ∑ n ∈ Finset.Ioc (2 ^ j * N) (2 ^ (j + 1) * N),
      xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n
  have hf (j : ℕ) : ContinuousOn (f j) (Icc (-T) T) := by
    apply xiFiniteSquare_continuousOn _ _ T hT
    intro n hn
    have hnp : 0 < n := lt_of_le_of_lt (Nat.zero_le _) (Finset.mem_Ioc.mp hn).1
    omega
  have hs : (∑ j ∈ Finset.range J,
      (∫ t in Icc (-T) T, ‖f j t‖ ^ 2) / (3 / 4 : ℝ) ^ j) ≤
      C * K * momentBlockEnergyConstant := by
    calc
      _ ≤ ∑ j ∈ Finset.range J,
          (C * K * (j + 2 : ℝ) ^ 3 / (2 : ℝ) ^ j) / (3 / 4 : ℝ) ^ j := by
        apply Finset.sum_le_sum
        intro j _
        have hj : (∫ t in Icc (-T) T, ‖f j t‖ ^ 2) ≤
            C * K * (j + 2 : ℝ) ^ 3 / (2 : ℝ) ^ j := by
          simpa only [f, K, mul_assoc] using hb N hN T hT hscale j
        exact div_le_div_of_nonneg_right hj (by positivity)
      _ = C * K * ∑ j ∈ Finset.range J,
          ((j + 2 : ℝ) ^ 3 / (2 : ℝ) ^ j) / (3 / 4 : ℝ) ^ j := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro j _
        ring
      _ ≤ _ := mul_le_mul_of_nonneg_left (moment_block_energy_sum J) (mul_nonneg hC.le hK)
  have h := moment_weighted_block_mean {()} (Finset.range J) (fun _ : Unit => f) (fun j => (3 / 4 : ℝ) ^ j)
    (fun j _ => by positivity) T (fun χ _ j _ => hf j)
  simp only [Finset.sum_singleton] at h
  apply h.trans
  calc
    _ ≤ (∑ j ∈ Finset.range J, (3 / 4 : ℝ) ^ j) * (C * K * momentBlockEnergyConstant) :=
      mul_le_mul_of_nonneg_left hs (Finset.sum_nonneg (fun _ _ => by positivity))
    _ ≤ 4 * (C * K * momentBlockEnergyConstant) :=
      mul_le_mul_of_nonneg_right (moment_block_weight_sum J)
        (mul_nonneg (mul_nonneg hC.le hK) momentBlockEnergyConstant_pos.le)
    _ = _ := by dsimp [K]; ring

end Legendre.Zeta
