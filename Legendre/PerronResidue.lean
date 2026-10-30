/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronZero

/-!
# The scalar Perron kernel above its endpoint

Original deductions using mathlib v4.35.0 (Apache-2.0). The divided
difference of y^s at zero removes the simple pole of y^s/s. Cauchy-Goursat
then compares opposite vertical lines, with the known y=1 kernel measuring
the pole contribution. This is scalar kernel inversion, not yet ψ inversion.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Topology
open scoped Interval

/-- Entire extension of (y^s-1)/s through zero. -/
noncomputable def perronRegularizedWeight (y : ℝ) : ℂ → ℂ :=
  dslope (fun s : ℂ ↦ (y : ℂ) ^ s) 0

/-- Removing the reciprocal kernel leaves an entire function. -/
theorem perronRegularizedWeight_differentiable {y : ℝ} (hy : 0 < y) :
    Differentiable ℂ (perronRegularizedWeight y) := by
  apply differentiableOn_univ.mp
  apply (differentiableOn_dslope (c := (0 : ℂ)) (s := Set.univ) Filter.univ_mem).mpr
  intro s _
  exact (differentiableAt_id.const_cpow (.inl (ofReal_ne_zero.mpr hy.ne'))).differentiableWithinAt

/-- Away from zero, the regularization subtracts exactly 1/s. -/
theorem perronRegularizedWeight_eq {y : ℝ} {s : ℂ} (hs : s ≠ 0) :
    perronRegularizedWeight y s = perronWeight y s - perronWeight 1 s := by
  rw [perronRegularizedWeight, dslope_of_ne _ hs, slope_def_field]
  simp only [sub_zero, cpow_zero, perronWeight, ofReal_one, one_cpow]
  ring

/-- Continuity of the scalar weight along any continuous curve avoiding zero. -/
theorem perronWeight_continuous_comp {y : ℝ} {γ : ℝ → ℂ} (hy : 0 < y)
    (hc : Continuous γ) (hn : ∀ t, γ t ≠ 0) : Continuous (fun t ↦ perronWeight y (γ t)) :=
  ((continuous_const_cpow' (ofReal_ne_zero.mpr hy.ne')).comp hc).div hc hn

/-- The regularized integral along a curve avoiding zero is a difference of genuine integrals. -/
theorem integral_perronRegularizedWeight_eq {y : ℝ} {γ : ℝ → ℂ} (hy : 0 < y)
    (hc : Continuous γ) (hn : ∀ t, γ t ≠ 0) (a b : ℝ) :
    (∫ t : ℝ in a..b, perronRegularizedWeight y (γ t)) =
      (∫ t : ℝ in a..b, perronWeight y (γ t)) - (∫ t : ℝ in a..b, perronWeight 1 (γ t)) := by
  simp_rw [perronRegularizedWeight_eq (hn _)]
  exact intervalIntegral.integral_sub
    ((perronWeight_continuous_comp hy hc hn).intervalIntegrable a b)
    ((perronWeight_continuous_comp zero_lt_one hc hn).intervalIntegrable a b)

/-- The weight on the reflected line is minus the reciprocal-base weight. -/
theorem perronWeight_neg_eq_inv {y : ℝ} (hy : 0 < y) (s : ℂ) :
    perronWeight y (-s) = -perronWeight y⁻¹ s := by
  simp only [perronWeight, cpow_neg, ofReal_inv, inv_cpow_ofReal_nonneg hy.le, div_neg]

/-- Exact reflection of the finite scalar kernel across the imaginary axis. -/
theorem truncatedPerronKernel_neg_line {y : ℝ} (hy : 0 < y) (σ T : ℝ) :
    truncatedPerronKernel y (-σ) T = -truncatedPerronKernel y⁻¹ σ T := by
  have he (t : ℝ) : perronWeight y (((-σ : ℝ) : ℂ) + (t : ℂ) * I) =
      -perronWeight y⁻¹ ((σ : ℂ) + ((-t : ℝ) : ℂ) * I) := by
    have hs : ((-σ : ℝ) : ℂ) + (t : ℂ) * I =
        -((σ : ℂ) + ((-t : ℝ) : ℂ) * I) := by push_cast; ring
    rw [hs, perronWeight_neg_eq_inv hy]
  simp only [truncatedPerronKernel]
  simp_rw [he]
  have hn := intervalIntegral.integral_comp_neg
    (f := fun t : ℝ ↦ perronWeight y⁻¹ ((σ : ℂ) + (t : ℂ) * I)) (a := -T) (b := T)
  rw [intervalIntegral.integral_neg, hn]
  simp only [neg_neg, mul_neg]

/-- The pole contribution is isolated by subtracting the y=1 reciprocal kernel.
This finite formula crosses zero only after using an entire regularization. -/
theorem truncatedPerronKernel_crossing_sub_eq {y σ : ℝ} (hy : 0 < y) (hσ : 0 < σ)
    {T : ℝ} (hT : T ≠ 0) :
    (truncatedPerronKernel y σ T - truncatedPerronKernel y (-σ) T) -
      (truncatedPerronKernel 1 σ T - truncatedPerronKernel 1 (-σ) T) =
      ((perronHorizontal y (-σ) σ T - perronHorizontal y (-σ) σ (-T)) -
        (perronHorizontal 1 (-σ) σ T - perronHorizontal 1 (-σ) σ (-T))) /
        (2 * Real.pi * I) := by
  have hr := integral_boundary_rect_eq_zero_of_differentiableOn (perronRegularizedWeight y)
    (((-σ : ℝ) : ℂ) + ((-T : ℝ) : ℂ) * I) ((σ : ℂ) + (T : ℂ) * I)
    (perronRegularizedWeight_differentiable hy).differentiableOn
  simp only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im, mul_zero,
    sub_self, add_zero, add_im, mul_im, zero_add, mul_one, smul_eq_mul] at hr
  have hv (a : ℝ) (ha : a ≠ 0) : ∀ t : ℝ, (a : ℂ) + (t : ℂ) * I ≠ 0 := by
    intro t ht
    have hh := congrArg Complex.re ht
    simp at hh
    exact ha hh
  have hh (t : ℝ) (ht : t ≠ 0) : ∀ a : ℝ, (a : ℂ) + (t : ℂ) * I ≠ 0 := by
    intro a ha
    have hz := congrArg Complex.im ha
    simp at hz
    exact ht hz
  rw [integral_perronRegularizedWeight_eq (γ := fun a : ℝ ↦ (a : ℂ) + ((-T : ℝ) : ℂ) * I) hy
      (continuous_ofReal.add continuous_const) (hh (-T) (neg_ne_zero.mpr hT)),
    integral_perronRegularizedWeight_eq (γ := fun a : ℝ ↦ (a : ℂ) + (T : ℂ) * I) hy
      (continuous_ofReal.add continuous_const) (hh T hT),
    integral_perronRegularizedWeight_eq (γ := fun t : ℝ ↦ (σ : ℂ) + (t : ℂ) * I) hy
      (continuous_const.add (continuous_ofReal.mul_const I)) (hv σ hσ.ne'),
    integral_perronRegularizedWeight_eq (γ := fun t : ℝ ↦ ((-σ : ℝ) : ℂ) + (t : ℂ) * I) hy
      (continuous_const.add (continuous_ofReal.mul_const I)) (hv (-σ) (neg_ne_zero.mpr hσ.ne'))] at hr
  have hc : (2 * Real.pi * I : ℂ) ≠ 0 := by simp [Real.pi_ne_zero]
  apply (eq_div_iff hc).mpr
  dsimp only [truncatedPerronKernel, perronHorizontal]
  field_simp
  simp_rw [mul_comm (I : ℂ)] at hr ⊢
  linear_combination hr

/-- The difference from the reciprocal kernel's pole contribution vanishes at infinite height. -/
theorem tendsto_truncatedPerronKernel_crossing_sub {y σ : ℝ} (hy : 0 < y) (hσ : 0 < σ) :
    Tendsto (fun T : ℝ ↦
      (truncatedPerronKernel y σ T - truncatedPerronKernel y (-σ) T) -
        (truncatedPerronKernel 1 σ T - truncatedPerronKernel 1 (-σ) T)) atTop (𝓝 0) := by
  have ho : -σ ≤ σ := by linarith
  have h := (((perronHorizontal_tendsto_zero hy ho).sub (perronHorizontal_neg_tendsto_zero hy ho)).sub
    ((perronHorizontal_tendsto_zero zero_lt_one ho).sub
      (perronHorizontal_neg_tendsto_zero zero_lt_one ho))).div_const (2 * Real.pi * I : ℂ)
  simp only [sub_self, zero_div] at h
  apply h.congr'
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
  exact (truncatedPerronKernel_crossing_sub_eq hy hσ hT.ne').symm

/-- The scalar Perron kernel tends to one above the endpoint. -/
theorem tendsto_truncatedPerronKernel_of_one_lt {y σ : ℝ} (hy : 1 < y) (hσ : 0 < σ) :
    Tendsto (fun T : ℝ ↦ truncatedPerronKernel y σ T) atTop (𝓝 1) := by
  have hypos : 0 < y := lt_trans zero_lt_one hy
  have hinv := tendsto_truncatedPerronKernel_of_lt_one (inv_pos.mpr hypos)
    (inv_lt_one_of_one_lt₀ hy) hσ
  have hneg : Tendsto (fun T : ℝ ↦ truncatedPerronKernel y (-σ) T) atTop (𝓝 0) := by
    have h := hinv.neg
    simp only [neg_zero] at h
    exact h.congr' (.of_forall (fun T ↦ (truncatedPerronKernel_neg_line hypos σ T).symm))
  have hhalf := tendsto_truncatedPerronKernel_one hσ
  have hhalfneg : Tendsto (fun T : ℝ ↦ truncatedPerronKernel 1 (-σ) T) atTop (𝓝 (-1 / 2 : ℂ)) := by
    have h := hhalf.neg
    have hh : (fun T : ℝ ↦ -truncatedPerronKernel 1 σ T) =ᶠ[atTop]
        (fun T : ℝ ↦ truncatedPerronKernel 1 (-σ) T) := by
      filter_upwards [] with T
      simpa only [inv_one] using (truncatedPerronKernel_neg_line zero_lt_one σ T).symm
    simpa only [neg_div] using! h.congr' hh
  have hrecip := hhalf.sub hhalfneg
  have h := ((tendsto_truncatedPerronKernel_crossing_sub hypos hσ).add hrecip).add hneg
  norm_num at h
  apply h.congr'
  filter_upwards [] with T
  ring

/-- The step function, with half weight at the scalar Perron endpoint. -/
noncomputable def scalarPerronValue (y : ℝ) : ℂ :=
  if y < 1 then 0 else if y = 1 then 1 / 2 else 1

/-- Scalar Perron inversion on every positive vertical line, including the endpoint. -/
theorem tendsto_truncatedPerronKernel {y σ : ℝ} (hy : 0 < y) (hσ : 0 < σ) :
    Tendsto (fun T : ℝ ↦ truncatedPerronKernel y σ T) atTop (𝓝 (scalarPerronValue y)) := by
  rcases lt_trichotomy y 1 with hlt | heq | hgt
  · simpa only [scalarPerronValue, ite_eq_left hlt] using
      tendsto_truncatedPerronKernel_of_lt_one hy hlt hσ
  · subst y
    simpa [scalarPerronValue] using tendsto_truncatedPerronKernel_one hσ
  · simpa only [scalarPerronValue, ite_eq_right (not_lt.mpr hgt.le), ite_eq_right hgt.ne'] using
      tendsto_truncatedPerronKernel_of_one_lt hgt hσ

end Legendre.Zeta
