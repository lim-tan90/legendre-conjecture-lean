/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronTail
public import Mathlib.Analysis.Complex.CauchyIntegral
public import Mathlib.Analysis.SpecialFunctions.Pow.Deriv

/-!
# Moving a scalar Perron contour within the right half-plane

Original deductions using mathlib v4.35.0 (Apache-2.0). The rectangle
identity and vanishing horizontal sides compare positive vertical lines.
No contour is moved across the pole at zero in these results.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Topology
open scoped Interval

/-- A horizontal side of a finite scalar Perron rectangle. -/
noncomputable def perronHorizontal (y σ ρ t : ℝ) : ℂ :=
  ∫ u : ℝ in σ..ρ, perronWeight y ((u : ℂ) + (t : ℂ) * I)

/-- The scalar weight is differentiable away from its denominator's pole. -/
theorem perronWeight_differentiableAt {y : ℝ} (hy : 0 < y) {s : ℂ} (hs : s ≠ 0) :
    DifferentiableAt ℂ (perronWeight y) s := by
  exact (differentiableAt_id.const_cpow (.inl (ofReal_ne_zero.mpr hy.ne'))).div
    differentiableAt_id hs

/-- Cauchy-Goursat on a rectangle between two positive vertical lines. -/
theorem perronWeight_rectangle {y σ ρ : ℝ} (hy : 0 < y) (hσ : 0 < σ)
    (hσρ : σ ≤ ρ) (T : ℝ) :
    perronHorizontal y σ ρ (-T) - perronHorizontal y σ ρ T +
      I * (∫ t : ℝ in -T..T, perronWeight y ((ρ : ℂ) + (t : ℂ) * I)) -
      I * (∫ t : ℝ in -T..T, perronWeight y ((σ : ℂ) + (t : ℂ) * I)) = 0 := by
  have hd : DifferentiableOn ℂ (perronWeight y)
      ([[σ, ρ]] ×ℂ [[-T, T]]) := by
    intro z hz
    apply (perronWeight_differentiableAt hy ?_).differentiableWithinAt
    have hzre : z.re ∈ Set.Icc σ ρ := by
      simpa only [Set.uIcc_of_le hσρ, Set.mem_preimage] using! hz.1
    have hre := hzre.1
    intro he
    simp [he] at hre
    linarith
  have h := integral_boundary_rect_eq_zero_of_differentiableOn (perronWeight y)
    ((σ : ℂ) + ((-T : ℝ) : ℂ) * I) ((ρ : ℂ) + (T : ℂ) * I)
  simp only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im, mul_zero,
    sub_self, add_zero, add_im, mul_im, zero_add, mul_one, smul_eq_mul] at h
  simpa only [perronHorizontal] using h hd

/-- Powers on a finite real interval are bounded by the maximum of the endpoint powers. -/
theorem rpow_le_max_endpoints {y σ ρ u : ℝ} (hy : 0 < y) (hu : u ∈ Set.Icc σ ρ) :
    y ^ u ≤ max (y ^ σ) (y ^ ρ) := by
  by_cases hyone : 1 ≤ y
  · exact (Real.rpow_le_rpow_of_exponent_le hyone hu.2).trans (le_max_right _ _)
  · exact (Real.rpow_le_rpow_of_exponent_ge hy (le_of_not_ge hyone) hu.1).trans
      (le_max_left _ _)

/-- Horizontal kernel bound at every nonzero height. -/
theorem norm_perronWeight_horizontal_le {y σ ρ u t : ℝ} (hy : 0 < y)
    (hu : u ∈ Set.Icc σ ρ) (ht : t ≠ 0) :
    ‖perronWeight y ((u : ℂ) + (t : ℂ) * I)‖ ≤
      max (y ^ σ) (y ^ ρ) / |t| := by
  rw [norm_perronWeight hy]
  have hn : |t| ≤ ‖(u : ℂ) + (t : ℂ) * I‖ := by
    simpa using abs_im_le_norm ((u : ℂ) + (t : ℂ) * I)
  have hre : ((u : ℂ) + (t : ℂ) * I).re = u := by simp
  rw [hre]
  calc
    _ ≤ y ^ u / |t| := div_le_div_of_nonneg_left (Real.rpow_nonneg hy.le _) (abs_pos.mpr ht) hn
    _ ≤ _ := div_le_div_of_nonneg_right (rpow_le_max_endpoints hy hu) (abs_nonneg _)

/-- The norm of a horizontal side decays like the inverse of its height. -/
theorem norm_perronHorizontal_le {y σ ρ t : ℝ} (hy : 0 < y) (hσρ : σ ≤ ρ) (ht : t ≠ 0) :
    ‖perronHorizontal y σ ρ t‖ ≤ max (y ^ σ) (y ^ ρ) * |ρ - σ| / |t| := by
  have hb := intervalIntegral.norm_integral_le_of_norm_le_const (a := σ) (b := ρ)
    (fun u hu ↦ norm_perronWeight_horizontal_le hy
      (show u ∈ Set.Icc σ ρ from ⟨(Set.uIoc_of_le hσρ ▸ hu).1.le,
        (Set.uIoc_of_le hσρ ▸ hu).2⟩) ht)
  dsimp [perronHorizontal]
  convert hb using 1
  ring

/-- Horizontal sides at positive height vanish as the height grows. -/
theorem perronHorizontal_tendsto_zero {y σ ρ : ℝ} (hy : 0 < y) (hσρ : σ ≤ ρ) :
    Tendsto (fun T : ℝ ↦ perronHorizontal y σ ρ T) atTop (𝓝 0) := by
  apply squeeze_zero_norm' (a := fun T : ℝ ↦ max (y ^ σ) (y ^ ρ) * |ρ - σ| / T)
  · filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
    simpa only [abs_of_pos hT] using norm_perronHorizontal_le hy hσρ hT.ne'
  · exact tendsto_const_nhds.div_atTop tendsto_id

/-- Horizontal sides at negative height also vanish. -/
theorem perronHorizontal_neg_tendsto_zero {y σ ρ : ℝ} (hy : 0 < y) (hσρ : σ ≤ ρ) :
    Tendsto (fun T : ℝ ↦ perronHorizontal y σ ρ (-T)) atTop (𝓝 0) := by
  apply squeeze_zero_norm' (a := fun T : ℝ ↦ max (y ^ σ) (y ^ ρ) * |ρ - σ| / T)
  · filter_upwards [eventually_gt_atTop (0 : ℝ)] with T hT
    simpa only [abs_neg, abs_of_pos hT] using
      norm_perronHorizontal_le (t := -T) hy hσρ (neg_ne_zero.mpr hT.ne')
  · exact tendsto_const_nhds.div_atTop tendsto_id

/-- Exact finite-height change of vertical line, without crossing zero. -/
theorem truncatedPerronKernel_sub_eq_horizontal {y σ ρ : ℝ} (hy : 0 < y)
    (hσ : 0 < σ) (hσρ : σ ≤ ρ) (T : ℝ) :
    truncatedPerronKernel y ρ T - truncatedPerronKernel y σ T =
      (perronHorizontal y σ ρ T - perronHorizontal y σ ρ (-T)) / (2 * Real.pi * I) := by
  have hr := perronWeight_rectangle hy hσ hσρ T
  have hc : (2 * Real.pi * I : ℂ) ≠ 0 := by simp [Real.pi_ne_zero]
  apply (eq_div_iff hc).mpr
  dsimp only [truncatedPerronKernel]
  field_simp
  simp_rw [mul_comm (I : ℂ)] at hr ⊢
  linear_combination hr

/-- The difference of truncated kernels on positive vertical lines tends to zero. -/
theorem tendsto_truncatedPerronKernel_sub {y σ ρ : ℝ} (hy : 0 < y)
    (hσ : 0 < σ) (hσρ : σ ≤ ρ) :
    Tendsto (fun T : ℝ ↦ truncatedPerronKernel y ρ T - truncatedPerronKernel y σ T)
      atTop (𝓝 0) := by
  have h := ((perronHorizontal_tendsto_zero hy hσρ).sub
    (perronHorizontal_neg_tendsto_zero hy hσρ)).div_const (2 * Real.pi * I : ℂ)
  simp only [sub_self, zero_div] at h
  apply h.congr'
  filter_upwards [] with T
  exact (truncatedPerronKernel_sub_eq_horizontal hy hσ hσρ T).symm

/-- Any limits on two positive vertical lines agree. -/
theorem perronKernel_limit_independent_line {y σ ρ : ℝ} {L M : ℂ} (hy : 0 < y)
    (hσ : 0 < σ) (hρ : 0 < ρ)
    (hL : Tendsto (fun T : ℝ ↦ truncatedPerronKernel y σ T) atTop (𝓝 L))
    (hM : Tendsto (fun T : ℝ ↦ truncatedPerronKernel y ρ T) atTop (𝓝 M)) : L = M := by
  by_cases hσρ : σ ≤ ρ
  · have h := tendsto_nhds_unique (hM.sub hL) (tendsto_truncatedPerronKernel_sub hy hσ hσρ)
    exact (sub_eq_zero.mp h).symm
  · have h := tendsto_nhds_unique (hL.sub hM)
      (tendsto_truncatedPerronKernel_sub hy hρ (le_of_not_ge hσρ))
    exact sub_eq_zero.mp h

end Legendre.Zeta
