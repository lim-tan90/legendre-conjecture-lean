/-
Adapted from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae.
Original: lean/OAI/NumberTheory/Ostmann/ZeroDensity/DigammaTailEstimate.lean.
Apache-2.0; retained license: licenses/openai-math-Apache-2.0.txt.
Changes: local imports/namespace, selected dependencies and v4.35.0 visibility.
-/
module

public import Legendre.PNT.Mathlib.Analysis.SpecialFunctions.Gamma.DigammaSeries
public import Mathlib.Tactic


/-! # A bounded tail in the sharp positive-strip digamma comparison -/

@[expose] public section

namespace Legendre.Density.GammaBounds

open Complex
open scoped BigOperators

noncomputable def densityDigammaTerm (z : ℂ) (n : ℕ) : ℂ :=
  ((n : ℂ) + 1)⁻¹ - (z + n)⁻¹

 theorem density_digamma_hasSum (z : ℂ) (hz : 0 < z.re) :
    HasSum (densityDigammaTerm z) (Complex.digamma z + Real.eulerMascheroniConstant) := by
  have h := Complex.hasSum_digamma_of_re_pos hz
  apply h.congr
  intro n
  simp only [densityDigammaTerm]

 theorem density_digamma_tail_bound (z : ℂ) (hz : 1 / 8 ≤ z.re) (N : ℕ) (hN : 1 ≤ N) :
    ‖∑' i : ℕ, densityDigammaTerm z (i + N)‖ ≤
      8 * (‖z‖ + 1) / N := by
  have hpos : 0 < z.re := by linarith
  have hsum := (density_digamma_hasSum z hpos).summable
  have hnorm := (summable_nat_add_iff N).mpr hsum.norm
  have hmajor := (summable_nat_add_iff N).mpr Complex.summable_one_div_natCast_add_one_sq
  have hp (i : ℕ) : ‖densityDigammaTerm z (i + N)‖ ≤
      8 * (‖z‖ + 1) * (1 / (((i + N : ℕ) : ℝ) + 1) ^ 2) := by
    have h := Complex.norm_inv_add_one_sub_inv_le (a := 1 / 8) (R := ‖z‖)
      (by norm_num) (by norm_num) hz le_rfl (i + N)
    change ‖densityDigammaTerm z (i + N)‖ ≤ _ at h
    convert h using 1
    field_simp
  calc
    _ ≤ ∑' i : ℕ, ‖densityDigammaTerm z (i + N)‖ := norm_tsum_le_tsum_norm hnorm
    _ ≤ ∑' i : ℕ, 8 * (‖z‖ + 1) * (1 / (((i + N : ℕ) : ℝ) + 1) ^ 2) :=
      hnorm.tsum_le_tsum hp (hmajor.mul_left _)
    _ = 8 * (‖z‖ + 1) * ∑' i : ℕ, 1 / (((i + N : ℕ) : ℝ) + 1) ^ 2 := tsum_mul_left
    _ ≤ 8 * (‖z‖ + 1) * (N : ℝ)⁻¹ :=
      mul_le_mul_of_nonneg_left (Complex.tsum_one_div_natCast_add_add_one_sq_le hN) (by positivity)
    _ = _ := by ring

end Legendre.Density.GammaBounds
