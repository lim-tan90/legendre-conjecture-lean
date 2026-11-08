/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityMomentCutoff.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.XiHeadMean

@[expose] public section
namespace Legendre.Density.Moment

 theorem moment_cutoff (Q : ℕ) (hQ : 1 ≤ Q) (T : ℝ) (hT : 2 ≤ T) :
    ∃ N : ℕ, 1 ≤ N ∧ 1 ≤ Real.log N ∧ 10 * (Q : ℝ) * T ≤ N ∧
      (N : ℝ) + (Q : ℝ) ^ 2 * T ≤ 17 * (Q : ℝ) ^ 2 * T ∧
      Real.log N ≤ 5 * Real.log ((Q : ℝ) * T) := by
  let N := ⌈10 * (Q : ℝ) * T⌉₊
  have hq : (1 : ℝ) ≤ Q := by exact_mod_cast hQ
  have hqt : 2 ≤ (Q : ℝ) * T := by nlinarith
  have hscale : 10 * (Q : ℝ) * T ≤ N := Nat.le_ceil _
  have hten : (10 : ℝ) ≤ N := by linarith
  have hN : 1 ≤ N := by exact_mod_cast (show (1 : ℝ) ≤ N by linarith)
  have hupper : (N : ℝ) ≤ 16 * ((Q : ℝ) * T) := by
    have h := Nat.ceil_lt_add_one (by positivity : 0 ≤ 10 * (Q : ℝ) * T)
    change (N : ℝ) < 10 * (Q : ℝ) * T + 1 at h
    linarith
  have hlogN : 1 ≤ Real.log N := by
    have hlog10 : (1 : ℝ) ≤ Real.log 10 := by
      have h := Real.le_log_one_add_of_nonneg (by norm_num : (0 : ℝ) ≤ 9)
      norm_num at h
      linarith
    exact hlog10.trans (Real.log_le_log (by norm_num) hten)
  refine ⟨N, hN, hlogN, hscale, ?_, ?_⟩
  · have hqtA : (Q : ℝ) * T ≤ (Q : ℝ) ^ 2 * T := by
      have h := mul_le_mul_of_nonneg_right hq (by positivity : 0 ≤ (Q : ℝ) * T)
      nlinarith
    linarith
  · have hlqt : Real.log 2 ≤ Real.log ((Q : ℝ) * T) := Real.log_le_log (by norm_num) hqt
    have hlog := Real.log_le_log (show (0 : ℝ) < N by linarith) hupper
    rw [Real.log_mul (by norm_num) (by positivity)] at hlog
    have h16 : Real.log 16 = 4 * Real.log 2 := by
      have h := Real.log_pow (2 : ℝ) 4
      norm_num at h
      exact h
    rw [h16] at hlog
    linarith

end Legendre.Density.Moment
