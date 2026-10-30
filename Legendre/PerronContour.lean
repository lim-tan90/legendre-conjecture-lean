/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Legendre.PerronFoundation
public import Mathlib.Analysis.Complex.CauchyIntegral
public import Mathlib.Analysis.SpecialFunctions.ExpDeriv

/-!
# The local Perron contour at the zeta pole

Original deductions from the pole-removed zeta function and mathlib's Cauchy
integral formula (mathlib v4.35.0, Apache-2.0). For x>0, the numerator below
extends (s-1)K(x,s) analytically at 1. A sufficiently small circle therefore
has integral 2πix. The radius is non-effective. This is not Perron inversion,
a rectangular contour shift, or a truncated formula with an error term.
-/

@[expose] public section

namespace Legendre.Zeta

open Complex Filter Topology Metric
open scoped Real

/-- An analytic extension of the pole-cancelled weighted kernel near 1. -/
noncomputable def perronPoleNumerator (x : ℝ) (s : ℂ) : ℂ :=
  (1 - (s - 1) * logDeriv poleRemovedZeta s) * perronWeight x s

/-- The extended numerator takes the expected residue value at 1. -/
theorem perronPoleNumerator_one (x : ℝ) : perronPoleNumerator x 1 = x := by
  simp [perronPoleNumerator, perronWeight_one]

/-- The Perron weight is analytic at 1 for positive x. -/
theorem perronWeight_analyticAt_one {x : ℝ} (hx : 0 < x) :
    AnalyticAt ℂ (perronWeight x) 1 := by
  have h : AnalyticAt ℂ (fun s : ℂ ↦ exp (log (x : ℂ) * s) / s) 1 :=
    ((analyticAt_const.mul analyticAt_id).cexp).div analyticAt_id (by norm_num)
  change AnalyticAt ℂ (fun s : ℂ ↦ (x : ℂ) ^ s / s) 1
  simpa only [cpow_def_of_ne_zero (ofReal_ne_zero.mpr hx.ne')] using h

/-- Pole cancellation is analytic, stronger than merely having a finite limit. -/
theorem perronPoleNumerator_analyticAt_one {x : ℝ} (hx : 0 < x) :
    AnalyticAt ℂ (perronPoleNumerator x) 1 := by
  exact (analyticAt_const.sub ((analyticAt_id.sub analyticAt_const).mul
    poleRemovedZeta_logDeriv_analyticAt_one)).mul (perronWeight_analyticAt_one hx)

/-- Locally off the pole, the original kernel is this analytic numerator divided by s-1. -/
theorem perronIntegrand_eventuallyEq_poleNumerator (x : ℝ) :
    perronIntegrand x =ᶠ[𝓝[≠] 1] (fun s ↦ perronPoleNumerator x s / (s - 1)) := by
  filter_upwards [logDeriv_regularPart_eventuallyEq, self_mem_nhdsWithin] with s hs hne
  have hn : s - 1 ≠ 0 := sub_ne_zero.mpr hne
  dsimp [perronIntegrand, perronPoleNumerator]
  rw [← hs]
  field_simp
  ring

/-- Every sufficiently small positively oriented circle around 1 contributes 2πix.
The existence of the radius is qualitative; other poles and distant contours
are outside this local assertion. -/
theorem exists_perronIntegrand_circleIntegral {x : ℝ} (hx : 0 < x) :
    ∃ δ : ℝ, 0 < δ ∧ ∀ r : ℝ, 0 < r → r < δ →
      (∮ s in C(1, r), perronIntegrand x s) = 2 * Real.pi * I * (x : ℂ) := by
  have ha := (perronPoleNumerator_analyticAt_one hx).eventually_analyticAt
  have he := perronIntegrand_eventuallyEq_poleNumerator x
  change ∀ᶠ s : ℂ in 𝓝[≠] 1,
    perronIntegrand x s = perronPoleNumerator x s / (s - 1) at he
  rw [eventually_nhdsWithin_iff] at he
  obtain ⟨δ, hδ, hball⟩ := Metric.eventually_nhds_iff.mp (ha.and he)
  refine ⟨δ, hδ, fun r hr hrd ↦ ?_⟩
  have hdiff : DifferentiableOn ℂ (perronPoleNumerator x) (closedBall 1 r) := by
    intro s hs
    exact ((hball (lt_of_le_of_lt hs hrd)).1.differentiableAt).differentiableWithinAt
  have hc := hdiff.circleIntegral_sub_inv_smul (by simpa using hr : (1 : ℂ) ∈ ball 1 r)
  have heq : (∮ s in C(1, r), perronIntegrand x s) =
      ∮ s in C(1, r), (s - 1)⁻¹ • perronPoleNumerator x s := by
    apply circleIntegral.integral_congr hr.le
    intro s hs
    have hne : s ≠ 1 := by
      intro h
      subst s
      simp only [mem_sphere, dist_self] at hs
      linarith
    have h := (hball (by rw [mem_sphere] at hs; linarith)).2 hne
    simpa only [div_eq_inv_mul, smul_eq_mul] using h
  rw [heq, hc, perronPoleNumerator_one, smul_eq_mul]

end Legendre.Zeta
