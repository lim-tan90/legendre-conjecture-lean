/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions combining the proved logarithmic-phase derivative tests.
-/
module
public import Legendre.Layer4.Exponential.LogFirstDerivative

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open Tools.ExponentialSum
open scoped BigOperators

theorem logarithmic_block_neg (U V : ℕ) (t : ℝ) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(-t : ℂ)*I)‖ =
      ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)‖ := by
  have he : (∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(-t : ℂ)*I)) =
      (starRingEnd ℂ) (∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)) := by
    rw [map_sum]
    apply Finset.sum_congr rfl
    intro n hn
    have hnp : (0 : ℝ) < n := by
      exact_mod_cast (lt_of_le_of_lt (Nat.zero_le U) (Finset.mem_Ioc.mp hn).1)
    have hpos := logarithmicPhase_eq_cpow t (n : ℝ) hnp
    have hneg := logarithmicPhase_eq_cpow (-t) (n : ℝ) hnp
    simp only [Complex.ofReal_natCast,Complex.ofReal_neg] at hpos hneg
    rw [←hpos,←hneg]
    rw [show logarithmicPhase (-t) (n : ℝ) = -logarithmicPhase t n by
      unfold logarithmicPhase; ring,phase_neg]
  rw [he,Complex.norm_conj]

theorem logarithmic_block_first_abs (U V : ℕ) (hU : 1 ≤ U) (hV : V ≤ 2*U)
    (t : ℝ) (ht : t ≠ 0) (htU : |t| ≤ U) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)‖ ≤ 12*Real.pi*(U : ℝ)/|t| := by
  rcases lt_or_gt_of_ne ht with ht | ht
  · have hh := logarithmic_block_first U V hU hV (-t) (by linarith)
      (by simpa only [abs_of_neg ht] using htU)
    simpa only [Complex.ofReal_neg,logarithmic_block_neg,abs_of_neg ht] using hh
  · simpa only [abs_of_pos ht] using logarithmic_block_first U V hU hV t ht
      (by simpa only [abs_of_pos ht] using htU)

noncomputable def logarithmicKernelConstant : ℝ := 2*logarithmicSecondConstant+12*Real.pi

theorem logarithmicKernelConstant_pos : 0 < logarithmicKernelConstant := by
  have h := logarithmicSecondConstant_pos
  unfold logarithmicKernelConstant
  positivity

/-- The actual unweighted dyadic correlation kernel has the classical shape. -/
theorem logarithmic_block_kernel (U V : ℕ) (hU : 1 ≤ U) (hUV : U ≤ V) (hV : V ≤ 2*U)
    (t : ℝ) (ht : t ≠ 0) :
    ‖∑ n ∈ Finset.Ioc U V, (n : ℂ)^(-(t : ℂ)*I)‖ ≤
      logarithmicKernelConstant*(Real.sqrt |t|+(U : ℝ)/|t|) := by
  have hp := logarithmicSecondConstant_pos
  have hUp : (0 : ℝ) < U := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU)
  have htp := abs_pos.mpr ht
  by_cases hlong : |t| ≤ U
  · have hh := logarithmic_block_first_abs U V hU hV t ht hlong
    apply hh.trans
    unfold logarithmicKernelConstant
    have ha : 0 ≤ 2*logarithmicSecondConstant*(Real.sqrt |t|+(U : ℝ)/|t|) := by positivity
    have hb : 0 ≤ 12*Real.pi*Real.sqrt |t| := by positivity
    simp only [div_eq_mul_inv] at ha hb ⊢
    nlinarith
  · have hh := logarithmic_block_sqrt U V hU hUV hV t ht
    have hs : 0 < Real.sqrt |t| := Real.sqrt_pos.mpr htp
    have hUS : (U : ℝ)/Real.sqrt |t| ≤ Real.sqrt |t| := by
      apply (div_le_iff₀ hs).mpr
      nlinarith [Real.sq_sqrt htp.le]
    apply hh.trans
    unfold logarithmicKernelConstant
    have ha : 0 ≤ (2*logarithmicSecondConstant+12*Real.pi)*((U : ℝ)/|t|) := by positivity
    have hb : 0 ≤ 12*Real.pi*Real.sqrt |t| := by positivity
    nlinarith

end Legendre.Density.Oscillation
