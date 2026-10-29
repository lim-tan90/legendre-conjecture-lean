/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.ZetaHalfPlane
public import Mathlib.Analysis.Complex.RemovableSingularity

/-!
# Removing the zeta pole and the logarithmic-derivative principal part

Original deductions from mathlib v4.35.0, commit
56a005855ea17e0b0958f73ec801ae140b0a1679 (Apache-2.0).
The updated-product continuity argument follows the local `G` construction
in `LSeries/Nonvanishing.lean` (Michael Stoll and David Loeffler).
The zeta residue at 1 is David Loeffler's `riemannZeta_residue_one` in
`NumberTheory/LSeries/RiemannZeta.lean`. Removable singularities and analytic
calculus are reused from mathlib; exact sources are recorded in
`docs/zeta-provenance.md`.

The pole-removed function is explicitly updated at 1. It is not the raw
product at that point, and no holomorphic extension of zeta itself is claimed.
The results are local, with no effective neighborhood or logarithmic zero-free
region asserted.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology

/-- The pole-removed zeta function, with its residue 1 inserted at the pole. -/
noncomputable def poleRemovedZeta : ℂ → ℂ :=
  Function.update (fun s ↦ (s - 1) * riemannZeta s) 1 1

/-- The inserted value is the residue, not the raw product at the pole. -/
theorem poleRemovedZeta_one : poleRemovedZeta 1 = 1 := by
  simp [poleRemovedZeta]

/-- Away from 1 the pole-removed function is the usual product. -/
theorem poleRemovedZeta_eq {s : ℂ} (hs : s ≠ 1) :
    poleRemovedZeta s = (s - 1) * riemannZeta s := by
  simp [poleRemovedZeta, Function.update_of_ne hs]

/-- Local equality away from the update point, needed to transfer derivatives. -/
theorem poleRemovedZeta_eventuallyEq {s : ℂ} (hs : s ≠ 1) :
    poleRemovedZeta =ᶠ[𝓝 s] (fun z ↦ (z - 1) * riemannZeta z) := by
  filter_upwards [eventually_ne_nhds hs] with z hz
  exact poleRemovedZeta_eq hz

/-- Differentiability away from the pole follows from the unmodified product. -/
theorem poleRemovedZeta_differentiableAt {s : ℂ} (hs : s ≠ 1) :
    DifferentiableAt ℂ poleRemovedZeta s := by
  apply ((differentiableAt_id.sub_const 1).mul (differentiableAt_riemannZeta hs)).congr_of_eventuallyEq
  exact poleRemovedZeta_eventuallyEq hs

/-- The residue theorem gives continuity of the updated product at 1. -/
theorem poleRemovedZeta_continuousAt_one : ContinuousAt poleRemovedZeta 1 := by
  simpa only [poleRemovedZeta, continuousAt_update_same] using riemannZeta_residue_one

/-- The product's singularity is removable, so the updated function is analytic. -/
theorem poleRemovedZeta_analyticAt_one : AnalyticAt ℂ poleRemovedZeta 1 := by
  apply analyticAt_of_differentiable_on_punctured_nhds_of_continuousAt _
    poleRemovedZeta_continuousAt_one
  filter_upwards [self_mem_nhdsWithin] with s hs
  exact poleRemovedZeta_differentiableAt hs

/-- Its logarithmic derivative is analytic at 1 since the inserted value is nonzero. -/
theorem poleRemovedZeta_logDeriv_analyticAt_one :
    AnalyticAt ℂ (logDeriv poleRemovedZeta) 1 := by
  exact poleRemovedZeta_analyticAt_one.deriv.div poleRemovedZeta_analyticAt_one
    (by simp [poleRemovedZeta_one])

/-- The regular part of ζ'/ζ agrees locally, off 1, with the logarithmic
derivative of the pole-removed function. -/
theorem logDeriv_regularPart_eventuallyEq :
    (fun s : ℂ ↦ logDeriv riemannZeta s + 1 / (s - 1)) =ᶠ[𝓝[≠] 1]
      logDeriv poleRemovedZeta := by
  have hnon : ∀ᶠ s in 𝓝 (1 : ℂ), poleRemovedZeta s ≠ 0 :=
    poleRemovedZeta_continuousAt_one.eventually_ne (by simp [poleRemovedZeta_one])
  filter_upwards [hnon.filter_mono nhdsWithin_le_nhds, self_mem_nhdsWithin] with s hnon hs
  have hs' : s ≠ 1 := hs
  have hz : riemannZeta s ≠ 0 :=
    (mul_ne_zero_iff.mp (by simpa only [poleRemovedZeta_eq hs'] using hnon)).2
  have h := (logDeriv_congr_nhds (poleRemovedZeta_eventuallyEq hs')).eq_of_nhds
  rw [logDeriv_fun_mul (f := fun z : ℂ ↦ z - 1) (g := riemannZeta) s (sub_ne_zero.mpr hs') hz
    (differentiableAt_id.sub_const 1) (differentiableAt_riemannZeta hs')] at h
  have hlinear : logDeriv (fun z : ℂ ↦ z - 1) s = 1 / (s - 1) := by
    simp [logDeriv_apply]
  rw [hlinear] at h
  simpa only [add_comm] using h.symm

/-- Subtracting the principal part leaves a finite limit at the pole. -/
theorem tendsto_logDeriv_regularPart :
    Tendsto (fun s : ℂ ↦ logDeriv riemannZeta s + 1 / (s - 1))
      (𝓝[≠] 1) (𝓝 (logDeriv poleRemovedZeta 1)) :=
  (poleRemovedZeta_logDeriv_analyticAt_one.continuousAt.tendsto.mono_left
    nhdsWithin_le_nhds).congr' logDeriv_regularPart_eventuallyEq.symm

/-- The logarithmic derivative has principal part -1/(s-1). -/
theorem tendsto_sub_mul_logDeriv_at_one :
    Tendsto (fun s : ℂ ↦ (s - 1) * logDeriv riemannZeta s)
      (𝓝[≠] 1) (𝓝 (-1)) := by
  have hlin : Tendsto (fun s : ℂ ↦ s - 1) (𝓝[≠] 1) (𝓝 0) := by
    have hlin0 : Tendsto (fun s : ℂ ↦ s - 1) (𝓝 1) (𝓝 (1 - 1)) :=
      tendsto_id.sub tendsto_const_nhds
    simpa using hlin0.mono_left
      (nhdsWithin_le_nhds : 𝓝[≠] (1 : ℂ) ≤ 𝓝 1)
  have h := (hlin.mul tendsto_logDeriv_regularPart).sub_const 1
  simp only [zero_mul, zero_sub] at h
  apply h.congr'
  filter_upwards [self_mem_nhdsWithin] with s hs
  have hs' : s - 1 ≠ 0 := sub_ne_zero.mpr hs
  field_simp
  ring

/-- In the sign convention used for Perron, the principal coefficient is +1.
This is a local limit, not a contour-integral formula. -/
theorem tendsto_sub_mul_neg_logDeriv_at_one :
    Tendsto (fun s : ℂ ↦ (s - 1) * (-logDeriv riemannZeta s))
      (𝓝[≠] 1) (𝓝 1) := by
  simpa only [mul_neg, neg_neg] using tendsto_sub_mul_logDeriv_at_one.neg

/-- The remainder after removing -1/(s-1) is locally bounded. Neither
an effective bound nor an effective neighborhood is asserted. -/
theorem logDeriv_regularPart_eventually_bounded :
    ∃ C : ℝ, 0 < C ∧ ∀ᶠ s : ℂ in 𝓝[≠] 1,
      ‖logDeriv riemannZeta s + 1 / (s - 1)‖ ≤ C := by
  refine ⟨‖logDeriv poleRemovedZeta 1‖ + 1, by positivity, ?_⟩
  have h := tendsto_logDeriv_regularPart.norm.eventually
    (Iio_mem_nhds (lt_add_one ‖logDeriv poleRemovedZeta 1‖))
  filter_upwards [h] with s hs
  exact hs.le

/-- The sharp simple-pole growth order, locally in the punctured plane.
The constant and neighborhood are non-effective. -/
theorem norm_logDeriv_eventually_le_inv_add :
    ∃ C : ℝ, 0 < C ∧ ∀ᶠ s : ℂ in 𝓝[≠] 1,
      ‖logDeriv riemannZeta s‖ ≤ 1 / ‖s - 1‖ + C := by
  obtain ⟨C, hC, hbound⟩ := logDeriv_regularPart_eventually_bounded
  refine ⟨C, hC, ?_⟩
  filter_upwards [hbound] with s hs
  have htri := norm_sub_le (logDeriv riemannZeta s + 1 / (s - 1)) (1 / (s - 1))
  simp only [add_sub_cancel_right, norm_div, norm_one] at htri
  linarith

end Legendre.Zeta
