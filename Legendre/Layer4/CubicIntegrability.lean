/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityCubicIntegrability.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.PackedZetaMoment
public import Legendre.Layer4.ProductCauchy

@[expose] public section
namespace Legendre.Density.Moment
open MeasureTheory
 theorem criticalWeight_integrable : Integrable Detector.Smooth.criticalWeight := by
  have h : Integrable (fun v : ℝ => (1 + ‖v‖) ^ (-(3 : ℝ))) :=
    integrable_one_add_norm (E := ℝ) (by norm_num : (Module.finrank ℝ ℝ : ℝ) < 3)
  simpa only [Real.norm_eq_abs, ← Detector.Smooth.criticalWeight_eq_rpow] using h

 theorem criticalWeight_shift_integrable (t : ℝ) :
    Integrable (fun v => Detector.Smooth.criticalWeight (v - t)) :=
  criticalWeight_integrable.comp_sub_right t

 theorem criticalWeight_shift_integral (t : ℝ) :
    (∫ v, Detector.Smooth.criticalWeight (v - t)) = ∫ v, Detector.Smooth.criticalWeight v :=
  integral_sub_right_eq_self Detector.Smooth.criticalWeight t

 theorem moment_cubic_mixed_integrable (f g : ℝ → ℝ) (hf : Continuous f) (hg : Continuous g)
    (hf0 : ∀ v, 0 ≤ f v) (hg0 : ∀ v, 0 ≤ g v) (t : ℝ)
    (h4 : Integrable (fun v => Detector.Smooth.criticalWeight (v - t) * f v ^ 4))
    (h2g : Integrable (fun v => Detector.Smooth.criticalWeight (v - t) * g v ^ 2)) :
    Integrable (fun v => Detector.Smooth.criticalWeight (v - t) * f v ^ 2) ∧
    Integrable (fun v => Detector.Smooth.criticalWeight (v - t) * f v * g v) := by
  have hwc : Continuous (fun v => Detector.Smooth.criticalWeight (v - t)) :=
    Detector.Smooth.criticalWeight_continuous.comp (continuous_id.sub continuous_const)
  have h2 : Integrable (fun v => Detector.Smooth.criticalWeight (v - t) * f v ^ 2) := by
    apply ((criticalWeight_shift_integrable t).add h4).mono'
      (hwc.mul (hf.pow 2)).aestronglyMeasurable
    filter_upwards with v
    change ‖Detector.Smooth.criticalWeight (v - t) * f v ^ 2‖ ≤ _
    rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (sq_nonneg _))]
    have h : f v ^ 2 ≤ 1 + f v ^ 4 := by nlinarith [sq_nonneg (f v ^ 2 - 1)]
    have hh := mul_le_mul_of_nonneg_left h (Detector.Smooth.criticalWeight_nonneg (v - t))
    simpa only [mul_add, mul_one, Pi.add_apply] using hh
  refine ⟨h2, ?_⟩
  apply (h2.add h2g).mono' ((hwc.mul hf).mul hg).aestronglyMeasurable
  filter_upwards with v
  change ‖Detector.Smooth.criticalWeight (v - t) * f v * g v‖ ≤ _
  rw [Real.norm_eq_abs, abs_of_nonneg
    (mul_nonneg (mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (hf0 v)) (hg0 v))]
  have h : f v * g v ≤ f v ^ 2 + g v ^ 2 := by nlinarith [sq_nonneg (f v - g v)]
  have hh := mul_le_mul_of_nonneg_left h (Detector.Smooth.criticalWeight_nonneg (v - t))
  simpa only [mul_add, mul_assoc, Pi.add_apply] using hh

end Legendre.Density.Moment
