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

/-- The minimal cover has no block whose left endpoint is past the support. -/
theorem detector_dyadic_cover_support (X : ℕ) (hX : 1 ≤ X) (Y : ℝ) (hY : 2 ≤ Y) :
    ∃ J : ℕ, ⌊Y⌋₊ ≤ 2^J*X ∧ (J : ℝ) ≤ (2/Real.log 2)*Real.log Y ∧
      (∀ j ∈ Finset.range J, (2 : ℝ)^j*(X : ℝ) ≤ Y) ∧
      (J = 0 ∨ (2 : ℝ)^J*(X : ℝ) ≤ 2*Y) := by
  obtain ⟨M,_,hM,hMlog⟩ := moment_detector_dyadic_cover X hX Y hY
  let h : ∃ j : ℕ, ⌊Y⌋₊ ≤ 2^j*X := ⟨M,hM⟩
  let J := Nat.find h
  have hJ : J ≤ M := Nat.find_min' h hM
  have hleft (j : ℕ) (hj : j ∈ Finset.range J) : (2 : ℝ)^j*(X : ℝ) ≤ Y := by
    have hf : 2^j*X < ⌊Y⌋₊ := Nat.lt_of_not_ge (Nat.find_min h (Finset.mem_range.mp hj))
    have hf' : (2 : ℝ)^j*(X : ℝ) ≤ (⌊Y⌋₊ : ℝ) := by exact_mod_cast hf.le
    exact hf'.trans (Nat.floor_le (by linarith : 0 ≤ Y))
  refine ⟨J,Nat.find_spec h,(by exact_mod_cast hJ : (J : ℝ) ≤ M).trans hMlog,hleft,?_⟩
  by_cases hz : J = 0
  · exact Or.inl hz
  · right
    have hprev : J-1 ∈ Finset.range J := Finset.mem_range.mpr (by omega)
    have hp := hleft (J-1) hprev
    rw [show J = J-1+1 from by omega, pow_succ]
    nlinarith

end Legendre.Density.Moment
