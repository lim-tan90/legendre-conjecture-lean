/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityPackedMoment.lean and DensityPackedCharacterMoments.lean
in openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
This specialization has a single zeta function and the actual Mobius polynomial.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.PackedMoment
public import Legendre.Layer4.WeightedZetaMoment

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory
open scoped BigOperators ArithmeticFunction.Moebius

theorem packed_scalar_moment {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (T : ℝ) (hT : 1 ≤ T) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (f : ℝ → ℝ) (hf : Continuous f) (hf0 : ∀ v, 0 ≤ f v)
    (hi : Integrable (fun v => momentHeightWeight T v*f v)) :
    (∀ i ∈ S, Integrable (fun v => Detector.Smooth.criticalWeight (v-t i)*f v)) ∧
    (∑ i ∈ S, ∫ v, Detector.Smooth.criticalWeight (v-t i)*f v) ≤
      momentKernelPackingConstant*∫ v, momentHeightWeight T v*f v := by
  have hpoint (v : ℝ) : (∑ i ∈ S, Detector.Smooth.criticalWeight (v-t i)*f v) ≤
      momentKernelPackingConstant*(momentHeightWeight T v*f v) := by
    rw [← Finset.sum_mul]
    exact (mul_le_mul_of_nonneg_right (moment_indexed_kernel_packing S t T hT ht hsep v)
      (hf0 v)).trans_eq (by ring)
  have hpi (i : ι) (hiS : i ∈ S) :
      Integrable (fun v => Detector.Smooth.criticalWeight (v-t i)*f v) := by
    have hc : Continuous (fun v : ℝ => Detector.Smooth.criticalWeight (v-t i)*f v) :=
      (Detector.Smooth.criticalWeight_continuous.comp
      (continuous_id.sub continuous_const)).mul hf
    apply (hi.const_mul momentKernelPackingConstant).mono' hc.aestronglyMeasurable
    filter_upwards with v
    change ‖Detector.Smooth.criticalWeight (v-t i)*f v‖ ≤ _
    rw [Real.norm_eq_abs,abs_of_nonneg (mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (hf0 v))]
    exact (Finset.single_le_sum (f := fun j => Detector.Smooth.criticalWeight (v-t j)*f v)
      (fun j _ => mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (hf0 v)) hiS).trans (hpoint v)
  refine ⟨hpi,?_⟩
  rw [← integral_finsetSum S hpi,← integral_const_mul]
  exact integral_mono (integrable_finsetSum S hpi) (hi.const_mul _) hpoint

theorem packed_zeta_fourth_moment :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T → ∀ {ι : Type*} (S : Finset ι) (t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, Integrable (fun v => Detector.Smooth.criticalWeight (v-t i)*
        ‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖^4)) ∧
      (∑ i ∈ S, ∫ v, Detector.Smooth.criticalWeight (v-t i)*
        ‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖^4) ≤ C*T*(Real.log T)^6 := by
  obtain ⟨C,hC,hb⟩ := weighted_zeta_fourth_moment
  refine ⟨momentKernelPackingConstant*C,mul_pos momentKernelPackingConstant_pos hC,?_⟩
  intro T hT ι S t ht hs
  obtain ⟨hi,hm⟩ := hb T hT
  obtain ⟨hpi,hpm⟩ := packed_scalar_moment S t T (by linarith) ht hs
    (fun v : ℝ => ‖riemannZeta ((1/2 : ℂ)+(v : ℂ)*I)‖^4)
    (zeta_critical_continuous.norm.pow 4) (fun _ => by positivity) hi
  refine ⟨hpi,hpm.trans ?_⟩
  have h := mul_le_mul_of_nonneg_left hm momentKernelPackingConstant_pos.le
  convert h using 1; ring

theorem packed_mollifier_mean :
    ∃ C : ℝ, 0 < C ∧ ∀ X : ℕ, 1 ≤ X → ∀ T : ℝ, 2 ≤ T →
      ∀ {ι : Type*} (S : Finset ι) (t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, Integrable (fun v => Detector.Smooth.criticalWeight (v-t i)*
        ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖^2)) ∧
      (∑ i ∈ S, ∫ v, Detector.Smooth.criticalWeight (v-t i)*
        ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖^2) ≤
          C*((X : ℝ)+T)*(1+Real.log X) := by
  obtain ⟨C,hC,hb⟩ := weighted_mollifier_mean
  refine ⟨momentKernelPackingConstant*C,mul_pos momentKernelPackingConstant_pos hC,?_⟩
  intro X hX T hT ι S t ht hs
  obtain ⟨hi,hm⟩ := hb X hX T hT
  obtain ⟨hpi,hpm⟩ := packed_scalar_moment S t T (by linarith) ht hs
    (fun v : ℝ => ‖Detector.finiteSeries (μ : ArithmeticFunction ℂ) X ((1/2 : ℂ)+(v : ℂ)*I)‖^2)
    ((mollifier_critical_continuous X).norm.pow 2) (fun _ => sq_nonneg _) hi
  refine ⟨hpi,hpm.trans ?_⟩
  have h := mul_le_mul_of_nonneg_left hm momentKernelPackingConstant_pos.le
  convert h using 1; ring

end Legendre.Density.Moment
