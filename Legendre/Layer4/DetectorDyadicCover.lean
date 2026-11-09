/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorDyadicCover.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Mathlib.Tactic

@[expose] public section
namespace Legendre.Density.Moment

 theorem moment_detector_dyadic_cover (X : ℕ) (hX : 1 ≤ X) (Y : ℝ) (hY : 2 ≤ Y) :
    ∃ J : ℕ, 1 ≤ J ∧ ⌊Y⌋₊ ≤ 2 ^ J * X ∧
      (J : ℝ) ≤ (2 / Real.log 2) * Real.log Y := by
  have hl2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hlY : Real.log 2 ≤ Real.log Y := Real.log_le_log (by norm_num) hY
  have hratio : 1 ≤ Real.log Y / Real.log 2 := (le_div_iff₀ hl2).mpr (by simpa using hlY)
  let J := ⌈Real.log Y / Real.log 2⌉₊
  have hj : Real.log Y / Real.log 2 ≤ J := Nat.le_ceil _
  have hj1 : 1 ≤ J := by exact_mod_cast (hratio.trans hj)
  have hjup : (J : ℝ) < Real.log Y / Real.log 2 + 1 :=
    Nat.ceil_lt_add_one (by linarith : 0 ≤ Real.log Y / Real.log 2)
  have hlog : Real.log Y ≤ (J : ℝ) * Real.log 2 := (div_le_iff₀ hl2).mp hj
  have hpow : Y ≤ (2 : ℝ) ^ J := by
    apply (Real.log_le_log_iff (by linarith : 0 < Y) (by positivity)).mp
    simpa only [Real.log_pow] using hlog
  have hx : (1 : ℝ) ≤ X := by exact_mod_cast hX
  have hfloor : (⌊Y⌋₊ : ℝ) ≤ (2 : ℝ) ^ J * X := by
    apply (Nat.floor_le (by linarith : 0 ≤ Y)).trans
    exact hpow.trans (le_mul_of_one_le_right (by positivity) hx)
  refine ⟨J, hj1, by exact_mod_cast hfloor, ?_⟩
  have hratio2 : Real.log Y / Real.log 2 + 1 ≤ 2 * (Real.log Y / Real.log 2) := by linarith
  have he : 2 * (Real.log Y / Real.log 2) = (2 / Real.log 2) * Real.log Y := by ring
  exact hjup.le.trans (hratio2.trans_eq he)

end Legendre.Density.Moment
