/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronSeries
public import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds

/-!
# The endpoint of the scalar Perron kernel

Original deductions from mathlib v4.35.0 (Apache-2.0). For σ>0 the kernel
at y=1 is arctan(T/σ)/π and tends to 1/2. This fixes the boundary convention
needed at integer endpoints; it does not evaluate the kernel for y≠1 or
justify an infinite-height limit under the von Mangoldt sum.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex MeasureTheory Filter Topology

/-- The reciprocal vertical kernel is continuous on the whole height axis. -/
theorem perronReciprocal_vertical_continuous {σ : ℝ} (hσ : 0 < σ) :
    Continuous (fun t : ℝ ↦ (1 : ℂ) / ((σ : ℂ) + (t : ℂ) * I)) := by
  apply continuous_const.div (continuous_const.add (continuous_ofReal.mul_const I))
  intro t ht
  have h := congrArg Complex.re ht
  simp at h
  linarith

/-- Exact finite-height integral at the scalar kernel's boundary y=1. -/
theorem integral_perronReciprocal {σ : ℝ} (hσ : 0 < σ) (T : ℝ) :
    (∫ t : ℝ in -T..T, (1 : ℂ) / ((σ : ℂ) + (t : ℂ) * I)) =
      (2 * Real.arctan (T / σ) : ℝ) := by
  have hi := (perronReciprocal_vertical_continuous hσ).intervalIntegrable
    (μ := volume) (-T) T
  have hre (t : ℝ) : ((1 : ℂ) / ((σ : ℂ) + (t : ℂ) * I)).re =
      σ / (σ ^ 2 + t ^ 2) := by
    simp [Complex.normSq_apply, pow_two]
  have him (t : ℝ) : ((1 : ℂ) / ((σ : ℂ) + (t : ℂ) * I)).im =
      -(t / (σ ^ 2 + t ^ 2)) := by
    simp [Complex.normSq_apply, pow_two, neg_div]
  apply Complex.ext
  · change reCLM (∫ t : ℝ in -T..T, (1 : ℂ) / ((σ : ℂ) + (t : ℂ) * I)) =
      2 * Real.arctan (T / σ)
    rw [← reCLM.intervalIntegral_comp_comm hi]
    change (∫ t : ℝ in -T..T, ((1 : ℂ) / ((σ : ℂ) + (t : ℂ) * I)).re) = _
    simp_rw [hre]
    rw [integral_div_sq_add_sq]
    simp only [neg_div, Real.arctan_neg, sub_neg_eq_add]
    ring
  · change imCLM (∫ t : ℝ in -T..T, (1 : ℂ) / ((σ : ℂ) + (t : ℂ) * I)) = 0
    rw [← imCLM.intervalIntegral_comp_comm hi]
    change (∫ t : ℝ in -T..T, ((1 : ℂ) / ((σ : ℂ) + (t : ℂ) * I)).im) = _
    simp_rw [him]
    rw [intervalIntegral.integral_neg, integral_id_div_sq_add_sq hσ.ne']
    simp

/-- The scalar kernel has a real arctangent value at y=1. -/
theorem truncatedPerronKernel_one {σ : ℝ} (hσ : 0 < σ) (T : ℝ) :
    truncatedPerronKernel 1 σ T = (Real.arctan (T / σ) / Real.pi : ℝ) := by
  simp only [truncatedPerronKernel, perronWeight, ofReal_one, one_cpow]
  rw [integral_perronReciprocal hσ]
  push_cast
  field_simp

/-- The boundary value of Perron inversion is one half, independently of σ>0. -/
theorem tendsto_truncatedPerronKernel_one {σ : ℝ} (hσ : 0 < σ) :
    Tendsto (fun T : ℝ ↦ truncatedPerronKernel 1 σ T) atTop (𝓝 (1 / 2 : ℂ)) := by
  have h := (Real.tendsto_arctan_atTop.mono_right nhdsWithin_le_nhds).comp
    (tendsto_id.atTop_div_const hσ)
  have hreal := h.div_const Real.pi
  have hc := continuous_ofReal.continuousAt.tendsto.comp hreal
  convert hc using 1
  · funext T
    exact truncatedPerronKernel_one hσ T
  · push_cast
    field_simp

/-- Explicit boundary truncation error. This estimate is only for y=1. -/
theorem norm_truncatedPerronKernel_one_sub_half_le {σ T : ℝ} (hσ : 0 < σ) (hT : 0 < T) :
    ‖truncatedPerronKernel 1 σ T - 1 / 2‖ ≤ σ / (Real.pi * T) := by
  rw [truncatedPerronKernel_one hσ]
  have hi : Real.arctan (σ / T) = Real.pi / 2 - Real.arctan (T / σ) := by
    simpa only [inv_div] using Real.arctan_inv_of_pos (div_pos hT hσ)
  rw [show (1 / 2 : ℂ) = ((1 / 2 : ℝ) : ℂ) by norm_num,
    ← ofReal_sub, norm_real, Real.norm_eq_abs]
  have he : Real.arctan (T / σ) / Real.pi - 1 / 2 =
      -(Real.arctan (σ / T) / Real.pi) := by
    rw [hi]
    field_simp
    ring
  rw [he, abs_neg, abs_of_nonneg
    (div_nonneg (Real.arctan_nonneg.mpr (div_nonneg hσ.le hT.le)) Real.pi_pos.le)]
  calc
    Real.arctan (σ / T) / Real.pi ≤ (σ / T) / Real.pi :=
      div_le_div_of_nonneg_right (Real.arctan_le_self (by positivity)) Real.pi_pos.le
    _ = σ / (Real.pi * T) := by ring

end Legendre.Zeta
