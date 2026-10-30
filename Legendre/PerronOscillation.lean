/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronKernel

/-!
# Oscillation in the scalar Perron numerator

Original deductions from mathlib v4.35.0 (Apache-2.0). For y>0, y≠1,
the primitive of y^(σ+it) has a bound independent of the finite endpoints.
This is input for later integration by parts with 1/(σ+it), not an
evaluation of the scalar Perron integral or its infinite-height limit.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory

/-- Separate the real magnitude from the purely oscillatory height dependence. -/
theorem cpow_vertical_eq_exp {y : ℝ} (hy : 0 < y) (σ t : ℝ) :
    (y : ℂ) ^ ((σ : ℂ) + (t : ℂ) * I) =
      (y ^ σ : ℝ) * exp (((Real.log y : ℂ) * I) * (t : ℂ)) := by
  rw [cpow_add _ _ (ofReal_ne_zero.mpr hy.ne'), ← ofReal_cpow hy.le,
    cpow_def_of_ne_zero (ofReal_ne_zero.mpr hy.ne'), ← ofReal_log hy.le]
  congr 2
  ring

/-- Oscillatory representation of the scalar Perron weight. -/
theorem perronWeight_vertical_eq_exp {y : ℝ} (hy : 0 < y) (σ t : ℝ) :
    perronWeight y ((σ : ℂ) + (t : ℂ) * I) =
      (y ^ σ : ℝ) * (exp (((Real.log y : ℂ) * I) * (t : ℂ)) /
        ((σ : ℂ) + (t : ℂ) * I)) := by
  rw [perronWeight, cpow_vertical_eq_exp hy]
  ring

/-- The finite numerator integral has an explicit oscillatory primitive away from y=1. -/
theorem integral_cpow_vertical {y : ℝ} (hy : 0 < y) (hyone : y ≠ 1) (σ a b : ℝ) :
    (∫ t : ℝ in a..b, (y : ℂ) ^ ((σ : ℂ) + (t : ℂ) * I)) =
      (y ^ σ : ℝ) *
        (exp (((Real.log y : ℂ) * I) * (b : ℂ)) -
          exp (((Real.log y : ℂ) * I) * (a : ℂ))) / ((Real.log y : ℂ) * I) := by
  have hc : (Real.log y : ℂ) * I ≠ 0 :=
    mul_ne_zero (ofReal_ne_zero.mpr (Real.log_ne_zero_of_pos_of_ne_one hy hyone)) I_ne_zero
  simp_rw [cpow_vertical_eq_exp hy]
  rw [intervalIntegral.integral_const_mul, integral_exp_mul_complex hc]
  ring

/-- Bounded primitives, uniformly in both finite endpoints. The logarithm in the
denominator records the loss near the separate endpoint case y=1. -/
theorem norm_integral_cpow_vertical_le {y : ℝ} (hy : 0 < y) (hyone : y ≠ 1) (σ a b : ℝ) :
    ‖∫ t : ℝ in a..b, (y : ℂ) ^ ((σ : ℂ) + (t : ℂ) * I)‖ ≤
      2 * y ^ σ / |Real.log y| := by
  rw [integral_cpow_vertical hy hyone, norm_div, norm_mul,
    Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (Real.rpow_nonneg hy.le _)]
  have he (t : ℝ) : ‖exp (((Real.log y : ℂ) * I) * (t : ℂ))‖ = 1 := by
    simp [norm_exp, mul_re]
  have hb := norm_sub_le (exp (((Real.log y : ℂ) * I) * (b : ℂ)))
    (exp (((Real.log y : ℂ) * I) * (a : ℂ)))
  rw [he b, he a] at hb
  simp only [norm_mul, Complex.norm_real, Real.norm_eq_abs, norm_I, mul_one]
  calc
    _ ≤ y ^ σ * (1 + 1) / |Real.log y| :=
      div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hb (Real.rpow_nonneg hy.le _))
        (abs_nonneg _)
    _ = _ := by ring

end Legendre.Zeta
