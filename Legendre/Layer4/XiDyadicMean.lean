/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDyadicMean.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiTailMean
public import Legendre.Layer4.DyadicArithmetic

@[expose] public section
namespace Legendre.Zeta

open Complex MeasureTheory Set
open Density Density.Moment
open scoped BigOperators Classical

 theorem xiFiniteSquare_dyadic_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ N : ℕ, 1 ≤ N → ∀ T : ℝ, 1 ≤ T →
      10 * T ≤ N → ∀ j : ℕ,
      (∫ t in Icc (-T) T,
        ‖∑ n ∈ Finset.Ioc (2 ^ j * N) (2 ^ (j + 1) * N),
          xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*I) n‖ ^ 2) ≤
          C * ((N : ℝ) + T) * (1 + Real.log N) ^ 3 *
            (j + 2 : ℝ) ^ 3 / (2 : ℝ) ^ j := by
  obtain ⟨C, hC, hb⟩ := xiFiniteSquare_tail_mean
  refine ⟨4 * C, by positivity, ?_⟩
  intro N hN T hT hscale j
  have hM : 1 ≤ 2 ^ j * N := one_le_mul (by exact_mod_cast (one_le_pow₀ (by norm_num : 1 ≤ (2 : ℕ)) : 1 ≤ (2 : ℕ) ^ j)) hN
  have hS : Finset.Ioc (2 ^ j * N) (2 ^ (j + 1) * N) ⊆
      Finset.Icc (2 ^ j * N) (2 ^ (j + 1) * N) := by
    intro n hn
    exact Finset.mem_Icc.mpr ⟨(Finset.mem_Ioc.mp hn).1.le, (Finset.mem_Ioc.mp hn).2⟩
  have h := hb (2 ^ j * N) (2 ^ (j + 1) * N) hM T hT
    (Finset.Ioc (2 ^ j * N) (2 ^ (j + 1) * N)) hS
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hr : (1 : ℝ) ≤ 2 ^ j := one_le_pow₀ (by norm_num)
  have hNl : 0 ≤ Real.log N := Real.log_nonneg (by exact_mod_cast hN)
  have hlog0 : 0 ≤ 1 + Real.log ((2 : ℝ) ^ (j + 1) * N) := by
    apply le_trans (by norm_num : (0 : ℝ) ≤ 1) (le_add_of_nonneg_right _)
    apply Real.log_nonneg
    have hp : (1 : ℝ) ≤ 2 ^ (j + 1) := one_le_pow₀ (by norm_num)
    have hn : (1 : ℝ) ≤ N := by exact_mod_cast hN
    nlinarith
  have hlog := pow_le_pow_left₀ hlog0 (moment_dyadic_log_bound N j hN) 3
  have hend : (2 : ℝ) ^ (j + 1) * N = 2 * (2 : ℝ) ^ j * N := by rw [pow_succ]; ring
  simp only [Nat.cast_mul, Nat.cast_pow, Nat.cast_ofNat] at h
  calc
    _ ≤ C * ((10 * T) ^ 2 *
        ((2 : ℝ) ^ (j + 1) * N + T) *
          (((2 : ℝ) ^ (j + 1) * N) * (1 + Real.log ((2 : ℝ) ^ (j + 1) * N)) ^ 3 /
            ((2 : ℝ) ^ j * N) ^ 3)) := by
      convert h using 1
      ring
    _ ≤ C * (4 * ((N : ℝ) + T) *
        (1 + Real.log ((2 : ℝ) ^ (j + 1) * N)) ^ 3 / (2 : ℝ) ^ j) := by
      apply mul_le_mul_of_nonneg_left _ hC.le
      rw [hend]
      exact moment_dyadic_fraction_bound _ _ _ _ _ (by positivity) hscale hNp
        (by positivity) hr (by simpa only [hend] using hlog0)
    _ ≤ C * (4 * ((N : ℝ) + T) *
        (((j + 2 : ℝ) * (1 + Real.log N)) ^ 3) / (2 : ℝ) ^ j) := by
      apply mul_le_mul_of_nonneg_left _ hC.le
      exact div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hlog (by positivity)) (by positivity)
    _ = _ := by ring

end Legendre.Zeta
