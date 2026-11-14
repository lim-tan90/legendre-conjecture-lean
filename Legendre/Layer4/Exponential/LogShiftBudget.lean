/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local scale algebra for differenced logarithmic sums.
-/
module
public import Legendre.Layer4.Exponential.LogShiftCorrelation
public import Mathlib.Analysis.Real.Pi.Bounds

@[expose] public section
namespace Legendre.Density.Oscillation
open scoped BigOperators

noncomputable def logarithmicShiftConstant : ℝ := 399*(1+Real.sqrt (64*Real.pi))

theorem logarithmicShiftConstant_pos : 0 < logarithmicShiftConstant := by
  unfold logarithmicShiftConstant
  positivity

theorem logarithmic_shift_uniform_budget (t U h H : ℝ) (ht : 0 < t) (hU : 0 < U)
    (hh : 1 ≤ h) (hhH : h ≤ H) :
    399*(U*Real.sqrt (t*h/(64*Real.pi*U^3))+1/Real.sqrt (t*h/(64*Real.pi*U^3))) ≤
      logarithmicShiftConstant*(Real.sqrt (t*H/U)+U*Real.sqrt (U/t)) := by
  have hhp : 0 < h := by linarith
  have hHp : 0 < H := hhp.trans_le hhH
  have hlam : 0 < t*h/(64*Real.pi*U^3) := by positivity
  have hC : (1 : ℝ) ≤ 64*Real.pi := by linarith [Real.pi_gt_three]
  have hlin : U*Real.sqrt (t*h/(64*Real.pi*U^3)) ≤ Real.sqrt (t*H/U) := by
    apply (Real.le_sqrt (by positivity) (by positivity)).mpr
    rw [mul_pow,Real.sq_sqrt hlam.le]
    have he : U^2*(t*h/(64*Real.pi*U^3)) = t*h/(64*Real.pi*U) := by field_simp
    rw [he]
    exact div_le_div₀ (by positivity) (mul_le_mul_of_nonneg_left hhH ht.le) hU (by nlinarith)
  have hinv : 1/Real.sqrt (t*h/(64*Real.pi*U^3)) ≤
      Real.sqrt (64*Real.pi)*U*Real.sqrt (U/t) := by
    apply (sq_le_sq₀ (by positivity) (by positivity)).mp
    rw [div_pow,Real.sq_sqrt hlam.le,one_pow,mul_pow,mul_pow,
      Real.sq_sqrt (by positivity : 0 ≤ 64*Real.pi),Real.sq_sqrt (by positivity : 0 ≤ U/t)]
    have he : 1/(t*h/(64*Real.pi*U^3)) = 64*Real.pi*U^3/(t*h) := by field_simp
    rw [he]
    have hb := div_le_div_of_nonneg_left (show 0 ≤ 64*Real.pi*U^3 by positivity)
      ht (show t ≤ t*h by nlinarith)
    convert hb using 1 <;> ring
  calc
    _ ≤ 399*(Real.sqrt (t*H/U)+Real.sqrt (64*Real.pi)*U*Real.sqrt (U/t)) := by gcongr
    _ ≤ 399*((1+Real.sqrt (64*Real.pi))*(Real.sqrt (t*H/U)+U*Real.sqrt (U/t))) := by
      have he : 0 ≤ Real.sqrt (64*Real.pi)*Real.sqrt (t*H/U)+U*Real.sqrt (U/t) := by positivity
      nlinarith
    _ = _ := by unfold logarithmicShiftConstant; ring

/-- Uniform positive-shift input for the finite interval differencing inequality. -/
theorem logarithmic_shift_correlation_uniform (U M h H : ℕ) (hU : 1 ≤ U) (hMU : M ≤ U)
    (hh : 1 ≤ h) (hhH : h ≤ H) (hHU : H ≤ U) (t : ℝ) (ht : t ≠ 0) :
    ‖∑ n ∈ Finset.Icc 1 M,
      Tools.ExponentialSum.phase (logarithmicPhase t (((n+h : ℕ) : ℝ)+U))*
        (starRingEnd ℂ) (Tools.ExponentialSum.phase (logarithmicPhase t ((n : ℝ)+U)))‖ ≤
      logarithmicShiftConstant*(Real.sqrt (|t| * H/(U : ℝ))+
        (U : ℝ)*Real.sqrt ((U : ℝ)/|t|)) := by
  have hb := logarithmic_shift_correlation_second U M h hU hMU hh (hhH.trans hHU) t ht
  exact hb.trans (logarithmic_shift_uniform_budget |t| U h H (abs_pos.mpr ht)
    (by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hU))
    (by exact_mod_cast hh) (by exact_mod_cast hhH))

end Legendre.Density.Oscillation
