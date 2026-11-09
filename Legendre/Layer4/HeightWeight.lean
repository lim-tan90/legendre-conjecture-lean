/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityHeightWeight.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Mathlib.Analysis.SpecificLimits.Normed
public import Legendre.Layer4.DyadicHeightShells
public import Legendre.Layer4.DetectorCriticalMass

@[expose] public section
namespace Legendre.Density.Moment

open Set

theorem criticalWeight_le_one (u : ℝ) : Detector.Smooth.criticalWeight u ≤ 1 := by
  unfold Detector.Smooth.criticalWeight
  exact (div_le_one (by positivity)).mpr (one_le_pow₀ (by linarith [abs_nonneg u]))

noncomputable def momentHeightWeight (T x : ℝ) : ℝ := Detector.Smooth.criticalWeight (x / T)

 theorem momentHeightWeight_nonneg (T x : ℝ) : 0 ≤ momentHeightWeight T x :=
  Detector.Smooth.criticalWeight_nonneg _

 theorem momentHeightWeight_continuous (T : ℝ) : Continuous (momentHeightWeight T) := by
  unfold momentHeightWeight Detector.Smooth.criticalWeight
  exact continuous_const.div
    ((continuous_const.add (continuous_id.div_const T).abs).pow 3) (fun x => by positivity)

 theorem momentHeightWeight_shell (T : ℝ) (hT : 0 < T) (j : ℕ) (x : ℝ)
    (hx : x ∈ momentHeightShell T (j + 1)) :
    momentHeightWeight T x ≤ (1 / 8 : ℝ) ^ j := by
  have ha : (2 : ℝ) ^ j * T < |x| := by
    have h := hx.2
    rw [momentHeightBall_mem] at h
    exact lt_of_not_ge h
  have hd : (2 : ℝ) ^ j ≤ 1 + |x / T| := by
    rw [abs_div, abs_of_pos hT]
    have hh : (2 : ℝ) ^ j < |x| / T := (lt_div_iff₀ hT).mpr ha
    linarith
  calc
    momentHeightWeight T x ≤ 1 / ((2 : ℝ) ^ j) ^ 3 := by
      apply one_div_le_one_div_of_le (by positivity)
      exact pow_le_pow_left₀ (by positivity) hd 3
    _ = (1 / 8 : ℝ) ^ j := by
      rw [← pow_mul, Nat.mul_comm, pow_mul, one_div_pow]
      norm_num

 theorem moment_height_energy_summable (k : ℕ) :
    Summable (fun j : ℕ => (j + 2 : ℝ) ^ k * (1 / 4 : ℝ) ^ j) := by
  have h0 : Summable (fun j : ℕ => (j : ℝ) ^ k * (1 / 4 : ℝ) ^ j) :=
    summable_pow_mul_geometric_of_norm_lt_one k (by norm_num : ‖(1 / 4 : ℝ)‖ < 1)
  have h : Summable (fun j : ℕ => ((j + 2 : ℕ) : ℝ) ^ k * (1 / 4 : ℝ) ^ (j + 2)) :=
    (summable_nat_add_iff 2).mpr h0
  have hm := h.mul_right (16 : ℝ)
  convert hm using 1
  funext j
  push_cast
  rw [pow_add]
  ring

noncomputable def momentHeightEnergyConstant (k : ℕ) : ℝ :=
  1 + 2 * ∑' j : ℕ, (j + 2 : ℝ) ^ k * (1 / 4 : ℝ) ^ j

 theorem momentHeightEnergyConstant_pos (k : ℕ) : 0 < momentHeightEnergyConstant k := by
  have hh : 0 ≤ ∑' j : ℕ, (j + 2 : ℝ) ^ k * (1 / 4 : ℝ) ^ j := tsum_nonneg (fun _ => by positivity)
  unfold momentHeightEnergyConstant
  linarith

end Legendre.Density.Moment
