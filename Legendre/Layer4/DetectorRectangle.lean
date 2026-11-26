/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions using the already credited PNT+ rectangle residue API.
The divided difference cancels the zero at the contour origin; the principal
zeta pole is retained with its full Mobius and smoothing coefficient.
-/
module
public import Legendre.Layer4.DetectorAnalytic

@[expose] public section
namespace Legendre.Density.Detector.Smooth
open Complex MeasureTheory Set Filter Asymptotics
open scoped Topology ArithmeticFunction.Moebius

theorem rectangle_analytic_quotient (f : ℂ → ℂ) (z v p : ℂ)
    (hre : z.re ≤ v.re) (him : z.im ≤ v.im) (hp : Rectangle z v ∈ 𝓝 p)
    (hf : ∀ w ∈ Rectangle z v, AnalyticAt ℂ f w) :
    RectangleIntegral' (fun w => f w/(w-p)) z v = f p := by
  apply ResidueTheoremOnRectangleWithSimplePole' hre him hp
  · intro w hw
    exact ((hf w hw.1).differentiableAt.div
      (differentiableAt_id.sub_const p) (sub_ne_zero.mpr hw.2)).differentiableWithinAt
  · have hcont : ContinuousAt (dslope f p) p :=
      continuousAt_dslope_same.mpr (hf p (mem_of_mem_nhds hp)).differentiableAt
    have hb : dslope f p =O[𝓝[≠] p] (1 : ℂ → ℂ) := hcont.isBigO.mono nhdsWithin_le_nhds
    apply hb.congr' _ Filter.EventuallyEq.rfl
    filter_upwards [self_mem_nhdsWithin] with w hw
    rw [dslope_of_ne f hw,slope_def_field]
    simp only [Pi.sub_apply]
    ring

/-- The compact detector has both its origin residue and the principal ζ residue
at general arguments. The origin residue vanishes at a zeta zero. -/
theorem detector_rectangle_with_both_poles (X : ℕ) {s : ℂ} (hs : s ≠ 1)
    {Y : ℝ} (hY : 0 < Y) (z v : ℂ) (hre : z.re ≤ v.re) (him : z.im ≤ v.im)
    (ha : -1 < z.re) (h0 : Rectangle z v ∈ 𝓝 (0 : ℂ)) (hp : Rectangle z v ∈ 𝓝 (1-s)) :
    RectangleIntegral (detectorIntegrand X s Y) z v =
      (2*(Real.pi : ℂ)*I)*
        (detectorPrincipalPole X s Y+riemannZeta s*finiteSeries (μ : ArithmeticFunction ℂ) X s/2) := by
  let p := 1-s
  have hpN : Rectangle z v ∈ 𝓝 p := hp
  have hp₀ : p ≠ 0 := sub_ne_zero.mpr hs.symm
  let f := fun w => detectorNumerator X s Y w/((w+1)*(w+2))/p
  have hInt (w : ℂ) (hw : w ∈ Rectangle z v) : -1 < w.re := by
    have h := (Complex.mem_reProdIm.mp hw).1
    rw [uIcc_of_le hre] at h
    exact ha.trans_le h.1
  have hden (w : ℂ) (hw : -1 < w.re) : (w+1)*(w+2) ≠ 0 := by
    apply mul_ne_zero
    · intro he
      have h := congrArg Complex.re he
      simp at h
      linarith
    · intro he
      have h := congrArg Complex.re he
      norm_num at h
      linarith
  have hf (w : ℂ) (hw : w ∈ Rectangle z v) : AnalyticAt ℂ f w :=
    ((detectorNumerator_analytic X s hY w).div
      ((analyticAt_id.add analyticAt_const).mul (analyticAt_id.add analyticAt_const))
      (hden w (hInt w hw))).div_const
  have hfp : f p = detectorPrincipalPole X s Y := by
    dsimp [f, p, detectorNumerator, detectorPrincipalPole, detectorKernel]
    rw [add_sub_cancel, Zeta.poleRemovedZeta_one, one_mul]
    simp only [div_eq_mul_inv, mul_inv_rev, one_mul]
    ring
  have hf₀ : f 0 = -(riemannZeta s*finiteSeries (μ : ArithmeticFunction ℂ) X s/2) := by
    dsimp only [f,p,detectorNumerator]
    simp only [add_zero, cpow_zero, mul_one, zero_add, one_mul, Zeta.poleRemovedZeta_eq hs]
    rw [show (s-1 : ℂ) = -(1-s) by ring]
    field_simp [hp₀]
  have he (w : ℂ) (hw : w ∈ RectangleBorder z v) :
      detectorIntegrand X s Y w = f w/(w-p) - f w/(w-0) := by
    have hw0 : w ≠ 0 := fun he => not_mem_rectangleBorder_of_rectangle_mem_nhds h0 (he ▸ hw)
    have hwp : w ≠ p := fun he => not_mem_rectangleBorder_of_rectangle_mem_nhds hpN (he ▸ hw)
    have hsw : s+w ≠ 1 := by intro h; apply hwp; dsimp [p]; linear_combination h
    have hr := hInt w (rectangleBorder_subset_rectangle z v hw)
    have hne := hden w hr
    have hpw : w-p ≠ 0 := sub_ne_zero.mpr hwp
    have hh : s+w-1 = w-p := by dsimp [p]; ring
    dsimp only [f, detectorNumerator, detectorIntegrand, detectorKernel]
    rw [Zeta.poleRemovedZeta_eq hsw, hh, sub_zero]
    field_simp [hw0, hpw, hp₀, hne]; ring
  have hf1 := rectangle_analytic_quotient f z v p hre him hpN hf
  have hf2 := rectangle_analytic_quotient f z v 0 hre him h0 hf
  -- Both rational terms are continuous on the boundary since their poles are interior.
  have hfc {q : ℂ} (hq : Rectangle z v ∈ 𝓝 q) :
      ContinuousOn (fun w => f w/(w-q)) (RectangleBorder z v) := by
    intro w hw
    have hne : w-q ≠ 0 := sub_ne_zero.mpr (fun he =>
      not_mem_rectangleBorder_of_rectangle_mem_nhds hq (he ▸ hw))
    exact (((hf w (rectangleBorder_subset_rectangle z v hw)).continuousAt).div
      (continuous_id.sub continuous_const).continuousAt hne).continuousWithinAt
  rw [RectangleIntegral_congr he]
  change RectangleIntegral ((fun w => f w/(w-p)) + -(fun w => f w/(w-0))) z v = _
  rw [RectangleBorderIntegrable.add (hfc hpN).rectangleBorder_integrable
    (hfc h0).neg.rectangleBorder_integrable]
  have hneg : RectangleIntegral (-(fun w => f w/(w-0))) z v =
      -RectangleIntegral (fun w => f w/(w-0)) z v := by
    change RectangleIntegral (fun w => -(f w/(w-0))) z v = _
    simpa only [smul_eq_mul, neg_one_mul] using RectangleIntegral.const_smul
      (fun w => f w/(w-0)) z v (-1)
  rw [hneg]
  have hm : (2*(Real.pi : ℂ)*I) ≠ 0 := by simp [Real.pi_ne_zero]
  have hp' : RectangleIntegral (fun w => f w/(w-p)) z v = (2*(Real.pi : ℂ)*I)*f p := by
    rw [← inv_mul_eq_iff_eq_mul₀ hm]
    simpa only [RectangleIntegral', smul_eq_mul, one_div] using hf1
  have h0' : RectangleIntegral (fun w => f w/(w-0)) z v = (2*(Real.pi : ℂ)*I)*f 0 := by
    rw [← inv_mul_eq_iff_eq_mul₀ hm]
    simpa only [RectangleIntegral', smul_eq_mul, one_div] using hf2
  rw [hp', h0', hfp, hf₀]
  ring

theorem detector_rectangle_principal (X : ℕ) {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s = 0) {Y : ℝ} (hY : 0 < Y) (z v : ℂ)
    (hre : z.re ≤ v.re) (him : z.im ≤ v.im) (ha : -1 < z.re)
    (h0 : Rectangle z v ∈ 𝓝 (0 : ℂ)) (hp : Rectangle z v ∈ 𝓝 (1-s)) :
    RectangleIntegral (detectorIntegrand X s Y) z v =
      (2*(Real.pi : ℂ)*I)*detectorPrincipalPole X s Y := by
  simpa only [hz, zero_mul, zero_div, add_zero] using
    detector_rectangle_with_both_poles X hs hY z v hre him ha h0 hp

end Legendre.Density.Detector.Smooth
