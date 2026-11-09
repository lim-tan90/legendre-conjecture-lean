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
open scoped Topology

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

theorem detector_rectangle_principal (X : ℕ) {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s = 0) {Y : ℝ} (hY : 0 < Y) (z v : ℂ)
    (hre : z.re ≤ v.re) (him : z.im ≤ v.im) (ha : -1 < z.re)
    (h0 : Rectangle z v ∈ 𝓝 (0 : ℂ)) (hp : Rectangle z v ∈ 𝓝 (1-s)) :
    RectangleIntegral (detectorIntegrand X s Y) z v =
      (2*(Real.pi : ℂ)*I)*detectorPrincipalPole X s Y := by
  have hf : ∀ w ∈ Rectangle z v, AnalyticAt ℂ (detectorRegularFactor X s Y) w := by
    intro w hw
    have hr := (Complex.mem_reProdIm.mp hw).1
    rw [uIcc_of_le hre] at hr
    exact detectorRegularFactor_analytic X s hY (ha.trans_le hr.1)
  have h := rectangle_analytic_quotient (detectorRegularFactor X s Y) z v (1-s) hre him hp hf
  rw [detectorRegularFactor_at_principal_pole X hs hz Y] at h
  have he : RectangleIntegral (detectorIntegrand X s Y) z v =
      RectangleIntegral (fun w => detectorRegularFactor X s Y w/(w-(1-s))) z v := by
    apply RectangleIntegral_congr
    intro w hw
    have hw0 : w ≠ 0 := by
      intro he
      exact not_mem_rectangleBorder_of_rectangle_mem_nhds h0 (he ▸ hw)
    have hwp : w ≠ 1-s := by
      intro he
      exact not_mem_rectangleBorder_of_rectangle_mem_nhds hp (he ▸ hw)
    exact detectorIntegrand_regularized X hs hz Y hw0 hwp
  rw [he]
  have hc : (2*(Real.pi : ℂ)*I) ≠ 0 := by simp [Real.pi_ne_zero]
  have hh : (2*(Real.pi : ℂ)*I)⁻¹*
      RectangleIntegral (fun w => detectorRegularFactor X s Y w/(w-(1-s))) z v =
        detectorPrincipalPole X s Y := by
    simpa only [RectangleIntegral',smul_eq_mul,one_div] using h
  exact (inv_mul_eq_iff_eq_mul₀ hc).mp hh

end Legendre.Density.Detector.Smooth
