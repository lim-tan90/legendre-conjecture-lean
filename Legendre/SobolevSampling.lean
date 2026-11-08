/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
public import Mathlib.Analysis.InnerProductSpace.Calculus

/-!
# Integral control of samples of differentiable real functions

Point evaluations are bounded by their local mean plus total variation.
This is the step needed before summing over separated sampling intervals.
-/

@[expose] public section

namespace Legendre.Density

open MeasureTheory Set

/-- The variation between any two points in an interval is bounded by the derivative integral. -/
theorem abs_sub_le_integral_abs_deriv {f g : ℝ → ℝ} (hg : Continuous g)
    (hf : ∀ t : ℝ, HasDerivAt f (g t) t) {A B x y : ℝ}
    (hx : x ∈ Icc A B) (hy : y ∈ Icc A B) :
    |f x-f y| ≤ ∫ t : ℝ in A..B, |g t| := by
  rcases le_total x y with hxy|hyx
  · have he := intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun t _ht => hf t) (hg.intervalIntegrable (μ := volume) x y)
    have hn := intervalIntegral.norm_integral_le_integral_norm (f := g) (μ := volume) hxy
    rw [he,Real.norm_eq_abs,abs_sub_comm] at hn
    have hm := intervalIntegral.integral_mono_interval hx.1 hxy hy.2
      (Filter.Eventually.of_forall (fun t : ℝ => abs_nonneg (g t)))
      (hg.abs.intervalIntegrable (μ := volume) A B)
    exact hn.trans hm
  · have he := intervalIntegral.integral_eq_sub_of_hasDerivAt
      (fun t _ht => hf t) (hg.intervalIntegrable (μ := volume) y x)
    have hn := intervalIntegral.norm_integral_le_integral_norm (f := g) (μ := volume) hyx
    rw [he,Real.norm_eq_abs] at hn
    have hm := intervalIntegral.integral_mono_interval hy.1 hyx hx.2
      (Filter.Eventually.of_forall (fun t : ℝ => abs_nonneg (g t)))
      (hg.abs.intervalIntegrable (μ := volume) A B)
    exact hn.trans hm

/-- A sample is bounded by the local mean and the total variation, without dividing by length. -/
theorem length_mul_value_le_integral {f g : ℝ → ℝ} (hg : Continuous g)
    (hf : ∀ t : ℝ, HasDerivAt f (g t) t) {A B x : ℝ}
    (hx : x ∈ Icc A B) :
    (B-A)*f x ≤ (∫ t : ℝ in A..B, f t)+(B-A)*(∫ t : ℝ in A..B, |g t|) := by
  have hc : Continuous f := continuous_iff_continuousAt.2 (fun t => (hf t).continuousAt)
  have hAB : A ≤ B := hx.1.trans hx.2
  have hi := intervalIntegral.integral_mono_on hAB
    (continuous_const.intervalIntegrable (μ := volume) A B)
    ((hc.add continuous_const).intervalIntegrable (μ := volume) A B)
    (fun y hy => show f x ≤ f y+(∫ t : ℝ in A..B, |g t|) from by
      have h := abs_sub_le_integral_abs_deriv hg hf hx hy
      linarith [le_abs_self (f x-f y)])
  dsimp only [Pi.add_apply] at hi
  rw [intervalIntegral.integral_const, intervalIntegral.integral_add
    (hc.intervalIntegrable A B) (continuous_const.intervalIntegrable A B),
    intervalIntegral.integral_const] at hi
  simpa only [smul_eq_mul] using hi

end Legendre.Density
