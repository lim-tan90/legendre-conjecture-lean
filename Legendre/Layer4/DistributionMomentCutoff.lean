/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local optimization of the splitting amplitude in the finite second moment.
-/
module
public import Legendre.Layer4.FiniteDyadicMoment
public import Mathlib.Analysis.SpecialFunctions.Pow.Real

@[expose] public section
namespace Legendre.Density.Moment

/-- A splitting amplitude at least two achieves the classical mixed-power cost. -/
theorem exists_balanced_moment_cutoff (R B : ℝ) (hR : 0 < R) (hRB : R ≤ B) :
    ∃ V : ℝ, 2 ≤ V ∧ R*V^2+8*B/V^4 ≤ 5*R^(2/3 : ℝ)*B^(1/3 : ℝ) := by
  have hB : 0 < B := hR.trans_le hRB
  let y := (B/R)^(1/3 : ℝ)
  have hy : 0 < y := Real.rpow_pos_of_pos (by positivity) _
  have hy1 : 1 ≤ y := Real.one_le_rpow (by
    apply (le_div_iff₀ hR).mpr
    simpa using hRB) (by norm_num)
  have hy3 : y^3 = B/R := by
    dsimp [y]
    rw [←Real.rpow_natCast,←Real.rpow_mul (by positivity : 0 ≤ B/R)]
    norm_num
  have hRy : R*y = R^(2/3 : ℝ)*B^(1/3 : ℝ) := by
    dsimp [y]
    rw [Real.div_rpow hB.le hR.le]
    have he : R = R^(2/3 : ℝ)*R^(1/3 : ℝ) := by
      rw [←Real.rpow_add hR]
      norm_num
    conv_lhs => lhs; rw [he]
    field_simp
  refine ⟨2*Real.sqrt y,?_,?_⟩
  · have hh := Real.sqrt_le_sqrt hy1
    norm_num only [Real.sqrt_one] at hh
    linarith
  · have hsq := Real.sq_sqrt hy.le
    have h4 : (2*Real.sqrt y)^4 = 16*y^2 := by nlinarith [sq_nonneg ((Real.sqrt y)^2-y)]
    have hdiv : 8*B/(2*Real.sqrt y)^4 = R*y/2 := by
      rw [h4]
      have he : B = R*y^3 := by
        rw [hy3]
        field_simp
      rw [he]
      field_simp
      <;> ring
    rw [hdiv]
    calc
      _ ≤ 5*(R*y) := by nlinarith [mul_pos hR hy]
      _ = _ := by rw [hRy]; ring

end Legendre.Density.Moment
