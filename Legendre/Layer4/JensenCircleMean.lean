/-
Copyright (c) 2025 Stefan Kebekus. All rights reserved.
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from the divisor comparison in Mathlib/Analysis/Complex/JensenFormula.lean
in leanprover-community/mathlib4, commit 56a005855ea17e0b0958f73ec801ae140b0a1679
(Apache-2.0). This form retains the actual circle average.
-/
module
public import Mathlib.Analysis.Complex.JensenFormula

@[expose] public section
namespace Legendre.Zeta
open Complex Metric MeromorphicOn Function Real

/-- Jensen's inequality with the actual circular mean retained. -/
theorem sum_divisor_le_circle_log_norm {c : ℂ} {r R : ℝ} {f : ℂ → ℂ}
    (hr : 0 < r) (hrR : r < R)
    (hf : AnalyticOnNhd ℂ f (closedBall c R)) (hc : f c ≠ 0) :
    (∑ᶠ z, (divisor f (closedBall c r) z : ℝ)) ≤
      (circleAverage (fun z => Real.log ‖f z‖) c R - Real.log ‖f c‖) /
        Real.log (R/r) := by
  have hR : 0 < R := hr.trans hrR
  have hrgap : 0 < Real.log (R/r) := Real.log_pos ((one_lt_div hr).mpr hrR)
  apply (le_div_iff₀ hrgap).mpr
  have hj := AnalyticOnNhd.circleAverage_log_norm (c := c) (R := R) hR.ne' (by simpa [abs_of_pos hR] using hf) hc
  have hsmall := hf.mono (closedBall_subset_closedBall hrR.le)
  rw [finsum_mul, hj, add_sub_cancel_right, abs_of_pos hR]
  refine finsum_le_finsum ?_ ?_ fun z => ?_
  · exact (divisor f (closedBall c r)).finiteSupport (isCompact_closedBall ..) |>.subset
      fun _ _ => (by simp_all)
  · exact (divisor f (closedBall c R)).finiteSupport (isCompact_closedBall ..) |>.subset
      fun _ _ => (by simp_all)
  have hd : 0 ≤ (divisor f (closedBall c R) z : ℝ) := by
    have h : (0 : ℤ) ≤ divisor f (closedBall c R) z := hf.divisor_nonneg z
    exact_mod_cast h
  by_cases hzR : z ∈ closedBall c R
  · by_cases hzr : z ∈ closedBall c r
    · rw [hsmall.divisor_apply hzr, hf.divisor_apply hzR]
      by_cases hzc : z = c
      · rw [hzc, (hf c (mem_closedBall_self hR.le)).analyticOrderAt_eq_zero.mpr hc]
        simp
      · have hnorm : 0 < ‖c-z‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (Ne.symm hzc))
        have hsmallnorm : ‖c-z‖ ≤ r := by simpa only [mem_closedBall, dist_eq_norm'] using hzr
        have hlog : Real.log (R/r) ≤ Real.log (R*‖c-z‖⁻¹) := by
          rw [← div_eq_mul_inv]
          exact Real.log_le_log (by positivity) (div_le_div_of_nonneg_left hR.le hnorm hsmallnorm)
        rw [hf.divisor_apply hzR] at hd
        exact mul_le_mul_of_nonneg_left hlog hd
    · rw [Function.locallyFinsuppWithin.apply_eq_zero_of_notMem _ hzr, Int.cast_zero, zero_mul]
      apply mul_nonneg hd
      have hn : ‖c-z‖ ≤ R := by simpa only [mem_closedBall,dist_eq_norm'] using hzR
      have h₀ : 0 < ‖c-z‖ := by
        apply norm_pos_iff.mpr
        intro he
        have he' := (sub_eq_zero.mp he).symm
        exact hzr (he' ▸ mem_closedBall_self hr.le)
      rw [← div_eq_mul_inv]
      exact Real.log_nonneg ((one_le_div h₀).mpr hn)
  · have hzr : z ∉ closedBall c r :=
      fun h => hzR (closedBall_subset_closedBall hrR.le h)
    simp [Function.locallyFinsuppWithin.apply_eq_zero_of_notMem _ hzr,
      Function.locallyFinsuppWithin.apply_eq_zero_of_notMem _ hzR]

end Legendre.Zeta
