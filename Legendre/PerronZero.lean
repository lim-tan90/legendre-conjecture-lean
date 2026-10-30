/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronShift

/-!
# The scalar Perron kernel below its endpoint

Original deductions using mathlib v4.35.0 (Apache-2.0). A finite-height
integration-by-parts bound, uniform in height, and independence of the
positive vertical line identify the scalar kernel limit as zero for 0<y<1.
The case y>1 and reconstruction of ψ remain separate steps.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Topology

/-- Exact reciprocal-derivative norm, including the horizontal coordinate. -/
theorem norm_perronReciprocalDeriv_eq (σ t : ℝ) :
    ‖perronReciprocalDeriv σ t‖ = 1 / (σ ^ 2 + t ^ 2) := by
  rw [perronReciprocalDeriv, norm_div, norm_neg, norm_I, norm_pow, Complex.sq_norm]
  congr 1
  simp [Complex.normSq_apply, pow_two]

/-- Uniform norm bound for either endpoint term in finite integration by parts. -/
theorem norm_perronTail_boundary_le {y σ : ℝ} (hy : 0 < y) (hσ : 0 < σ) (t : ℝ) :
    ‖(1 / ((σ : ℂ) + (t : ℂ) * I)) * perronOscPrimitive y σ t‖ ≤
      (y ^ σ / |Real.log y|) / σ := by
  rw [norm_mul, norm_div, norm_one, norm_perronOscPrimitive hy]
  have hn : σ ≤ ‖(σ : ℂ) + (t : ℂ) * I‖ := by
    simpa [abs_of_pos hσ] using abs_re_le_norm ((σ : ℂ) + (t : ℂ) * I)
  calc
    _ ≤ (1 / σ) * (y ^ σ / |Real.log y|) :=
      mul_le_mul_of_nonneg_right (one_div_le_one_div_of_le hσ hn)
        (div_nonneg (Real.rpow_nonneg hy.le σ) (abs_nonneg (Real.log y)))
    _ = _ := by ring

/-- A finite symmetric remainder integral has a bound uniform in height. -/
theorem norm_integral_perronTail_remainder_le {y σ T : ℝ} (hy : 0 < y)
    (hσ : 0 < σ) (hT : 0 ≤ T) :
    ‖∫ t : ℝ in -T..T, perronReciprocalDeriv σ t * perronOscPrimitive y σ t‖ ≤
      (y ^ σ / |Real.log y|) * Real.pi / σ := by
  let C : ℝ := y ^ σ / |Real.log y|
  have hC : 0 ≤ C := div_nonneg (Real.rpow_nonneg hy.le σ) (abs_nonneg _)
  have hg : Continuous (fun t : ℝ ↦ C * (σ ^ 2 + t ^ 2)⁻¹) := by
    apply continuous_const.mul
    exact (continuous_const.add (continuous_id.pow 2)).inv₀
      (fun t ↦ ne_of_gt (add_pos_of_pos_of_nonneg (sq_pos_of_pos hσ) (sq_nonneg t)))
  have hb := intervalIntegral.norm_integral_le_of_norm_le (a := -T) (b := T)
    (by linarith : -T ≤ T)
    (Filter.Eventually.of_forall (fun t (_ : t ∈ Set.Ioc (-T) T) ↦
      show ‖perronReciprocalDeriv σ t * perronOscPrimitive y σ t‖ ≤ C * (σ ^ 2 + t ^ 2)⁻¹ from by
        rw [norm_mul, norm_perronReciprocalDeriv_eq, norm_perronOscPrimitive hy]
        dsimp [C]
        simp only [one_div]
        rw [mul_comm]))
    (hg.intervalIntegrable (μ := volume) (-T) T)
  rw [intervalIntegral.integral_const_mul, integral_inv_sq_add_sq hσ.ne'] at hb
  simp only [neg_div, Real.arctan_neg, sub_neg_eq_add] at hb
  calc
    _ ≤ C * (σ⁻¹ * (Real.arctan (T / σ) + Real.arctan (T / σ))) := hb
    _ ≤ C * (σ⁻¹ * Real.pi) :=
      mul_le_mul_of_nonneg_left
        (mul_le_mul_of_nonneg_left (by linarith [Real.arctan_lt_pi_div_two (T / σ)])
          (inv_nonneg.mpr hσ.le)) hC
    _ = _ := by dsimp [C]; ring

/-- Finite scalar kernels have a height-independent bound away from y=1. -/
theorem norm_truncatedPerronKernel_uniform_le {y σ T : ℝ} (hy : 0 < y) (hyone : y ≠ 1)
    (hσ : 0 < σ) (hT : 0 ≤ T) :
    ‖truncatedPerronKernel y σ T‖ ≤
      (y ^ σ / |Real.log y|) * (2 + Real.pi) / (2 * Real.pi * σ) := by
  let C : ℝ := y ^ σ / |Real.log y|
  have hp := integral_perronWeight_parts hy hyone hσ (-T) T
  have hb : ‖∫ t : ℝ in -T..T, perronWeight y ((σ : ℂ) + (t : ℂ) * I)‖ ≤
      C / σ + C / σ + C * Real.pi / σ := by
    rw [hp]
    apply (norm_sub_le _ _).trans
    apply add_le_add
    · exact (norm_sub_le _ _).trans (add_le_add
        (norm_perronTail_boundary_le hy hσ T) (norm_perronTail_boundary_le hy hσ (-T)))
    · exact norm_integral_perronTail_remainder_le hy hσ hT
  rw [truncatedPerronKernel, norm_mul]
  have hn : ‖(1 / (2 * Real.pi) : ℂ)‖ = 1 / (2 * Real.pi) := by
    simp [abs_of_pos Real.pi_pos]
  rw [hn]
  calc
    _ ≤ (1 / (2 * Real.pi)) * (C / σ + C / σ + C * Real.pi / σ) :=
      mul_le_mul_of_nonneg_left hb (by positivity)
    _ = _ := by dsimp [C]; ring

/-- Below the endpoint the finite scalar bound decays as the line moves right. -/
theorem norm_truncatedPerronKernel_le_of_lt_one {y σ T : ℝ} (hy : 0 < y) (hyone : y < 1)
    (hσ : 0 < σ) (hT : 0 ≤ T) :
    ‖truncatedPerronKernel y σ T‖ ≤
      ((2 + Real.pi) / (2 * Real.pi * |Real.log y|)) / σ := by
  have hb := norm_truncatedPerronKernel_uniform_le hy hyone.ne hσ hT
  have hr : y ^ σ ≤ 1 := Real.rpow_le_one hy.le hyone.le hσ.le
  calc
    _ ≤ (y ^ σ / |Real.log y|) * (2 + Real.pi) / (2 * Real.pi * σ) := hb
    _ ≤ (1 / |Real.log y|) * (2 + Real.pi) / (2 * Real.pi * σ) :=
      div_le_div_of_nonneg_right
        (mul_le_mul_of_nonneg_right (div_le_div_of_nonneg_right hr (abs_nonneg _))
          (by positivity)) (by positivity)
    _ = _ := by ring

/-- The scalar Perron kernel tends to zero for 0<y<1 on every positive vertical line. -/
theorem tendsto_truncatedPerronKernel_of_lt_one {y σ : ℝ} (hy : 0 < y) (hyone : y < 1)
    (hσ : 0 < σ) : Tendsto (fun T : ℝ ↦ truncatedPerronKernel y σ T) atTop (𝓝 0) := by
  obtain ⟨L, hL⟩ := exists_tendsto_truncatedPerronKernel hy hyone.ne hσ
  let D : ℝ := (2 + Real.pi) / (2 * Real.pi * |Real.log y|)
  have hb : ∀ᶠ ρ : ℝ in atTop, ‖L‖ ≤ D / ρ := by
    filter_upwards [eventually_gt_atTop (0 : ℝ)] with ρ hρ
    obtain ⟨M, hM⟩ := exists_tendsto_truncatedPerronKernel hy hyone.ne hρ
    have he := perronKernel_limit_independent_line hy hσ hρ hL hM
    have hm : ‖M‖ ≤ D / ρ := le_of_tendsto hM.norm (by
      filter_upwards [eventually_ge_atTop (0 : ℝ)] with T hT
      exact norm_truncatedPerronKernel_le_of_lt_one hy hyone hρ hT)
    simpa only [he] using hm
  have hz : ‖L‖ ≤ 0 := le_of_tendsto_of_tendsto tendsto_const_nhds
    (tendsto_const_nhds.div_atTop tendsto_id) hb
  have he : L = 0 := norm_eq_zero.mp (le_antisymm hz (norm_nonneg L))
  simpa only [he] using hL

end Legendre.Zeta
