/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local second-derivative bound for actual shifted logarithmic correlations.
-/
module
public import Legendre.Layer4.Exponential.LogShiftDerivatives
public import Legendre.Layer4.Exponential.NaturalDifferencing

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set Tools.ExponentialSum
open scoped BigOperators

theorem logarithmicShiftPhase_correlation (t h x : ℝ) :
    phase (logarithmicShiftPhase t h x) =
      phase (logarithmicPhase t (x+h))*(starRingEnd ℂ) (phase (logarithmicPhase t x)) := by
  rw [logarithmicShiftPhase,sub_eq_add_neg,phase_add,phase_neg]

/-- A positive shifted correlation uses a scale proportional to h abs(t)/U^3. -/
theorem logarithmic_shift_sum_second (U M h : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (hh : 1 ≤ h) (hhU : h ≤ U) (t : ℝ) (ht : t ≠ 0) :
    ‖∑ n ∈ Finset.Icc 1 M, phase (logarithmicShiftPhase t h ((n : ℝ)+U))‖ ≤
      399*((U : ℝ)*Real.sqrt (|t| * h/(64*Real.pi*(U : ℝ)^3))+
        1/Real.sqrt (|t| * h/(64*Real.pi*(U : ℝ)^3))) := by
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have hU1 : (1 : ℝ) ≤ U := by exact_mod_cast hU
  have hhp : (0 : ℝ) < h := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hh)
  have hhUr : (h : ℝ) ≤ U := by exact_mod_cast hhU
  have hMUr : (M : ℝ) ≤ U := by exact_mod_cast hMU
  have hsupport (x : ℝ) (hx : x ∈ Icc ((1 : ℕ) : ℝ) ((M+1 : ℕ) : ℝ)) :
      (U : ℝ) ≤ x+U ∧ x+U ≤ 3*U := by
    have hxlo := hx.1
    have hxhi := hx.2
    norm_num only [Nat.cast_one] at hxlo
    push_cast at hxhi
    constructor <;> linarith
  have hlam : 0 < |t| * h/(64*Real.pi*(U : ℝ)^3) := by positivity
  have hb := second_derivative_test_Ico
    (fun x : ℝ => logarithmicShiftPhase t h (x+U))
    (fun x : ℝ => logarithmicShiftFirst t h (x+U))
    (fun x : ℝ => logarithmicShiftSecond t h (x+U)) 1 (M+1)
    (|t| * h/(64*Real.pi*(U : ℝ)^3)) 64 (by omega) hlam (by norm_num)
    (by
      intro x hx
      have hs := hsupport x hx
      exact (logarithmicShiftPhase_deriv t h (x+U) (by linarith) (by linarith)).comp_add_const x U)
    (by
      intro x hx
      have hs := hsupport x hx
      exact (logarithmicShiftFirst_deriv t h (x+U) (by linarith) (by linarith)).comp_add_const x U)
    (by
      intro x hx
      have hs := hsupport x hx
      exact logarithmicShiftSecond_bounds t h U (x+U) hUp hhp hhUr hs.1 hs.2)
  rw [Finset.Ico_add_one_right_eq_Icc] at hb
  norm_num only [show M+1-1 = M by omega,show (6*64+15 : ℝ) = 399 by norm_num] at hb
  apply hb.trans
  gcongr

/-- The bound concerns the actual complex autocorrelation, including its overlap endpoints. -/
theorem logarithmic_shift_correlation_second (U M h : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (hh : 1 ≤ h) (hhU : h ≤ U) (t : ℝ) (ht : t ≠ 0) :
    ‖∑ n ∈ Finset.Icc 1 M,
      phase (logarithmicPhase t (((n+h : ℕ) : ℝ)+U))*
        (starRingEnd ℂ) (phase (logarithmicPhase t ((n : ℝ)+U)))‖ ≤
      399*((U : ℝ)*Real.sqrt (|t| * h/(64*Real.pi*(U : ℝ)^3))+
        1/Real.sqrt (|t| * h/(64*Real.pi*(U : ℝ)^3))) := by
  have he : (∑ n ∈ Finset.Icc 1 M,
      phase (logarithmicPhase t (((n+h : ℕ) : ℝ)+U))*
        (starRingEnd ℂ) (phase (logarithmicPhase t ((n : ℝ)+U)))) =
      ∑ n ∈ Finset.Icc 1 M, phase (logarithmicShiftPhase t h ((n : ℝ)+U)) := by
    apply Finset.sum_congr rfl
    intro n _
    rw [logarithmicShiftPhase_correlation]
    have hearg : (((n+h : ℕ) : ℝ)+U) = ((n : ℝ)+U)+(h : ℝ) := by push_cast; ring
    rw [hearg]
  rw [he]
  exact logarithmic_shift_sum_second U M h hU hMU hh hhU t ht

end Legendre.Density.Oscillation
