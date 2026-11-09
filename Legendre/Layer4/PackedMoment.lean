/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityPackedMoment.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.KernelHeightPacking

@[expose] public section
namespace Legendre.Density.Moment

open MeasureTheory
open scoped BigOperators Classical

noncomputable def momentKernelPackingConstant : ℝ := 256 + 27 * (1 + 4 * Real.pi ^ 2 / 3)

 theorem momentKernelPackingConstant_pos : 0 < momentKernelPackingConstant := by
  unfold momentKernelPackingConstant
  positivity

 theorem moment_indexed_kernel_packing {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (T : ℝ) (hT : 1 ≤ T) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i - t j|) (v : ℝ) :
    (∑ i ∈ S, Detector.Smooth.criticalWeight (v - t i)) ≤ momentKernelPackingConstant * momentHeightWeight T v := by
  classical
  have hinj : Set.InjOn t S := by
    intro i hi j hj he
    by_contra hij
    have h := hsep i hi j hj hij
    rw [he, sub_self, abs_zero] at h
    norm_num at h
  have hb := moment_kernel_height_packing (S.image t) T hT
    (by intro x hx; obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hx; exact ht i hi)
    (by
      intro x hx y hy hxy
      obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hx
      obtain ⟨j, hj, rfl⟩ := Finset.mem_image.mp hy
      exact hsep i hi j hj (fun he => hxy (congrArg t he))) v
  rwa [Finset.sum_image (fun _ hi _ hj he => hinj hi hj he)] at hb

 theorem moment_packed_pointwise {ι κ : Type*} (S : Finset ι) (c : ι → κ) (t : ι → ℝ)
    (T : ℝ) (hT : 1 ≤ T) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, c i = c j → i ≠ j → 1 ≤ |t i - t j|)
    (f : κ → ℝ → ℝ) (hf0 : ∀ a v, 0 ≤ f a v) (v : ℝ) :
    (∑ i ∈ S, Detector.Smooth.criticalWeight (v - t i) * f (c i) v) ≤
      momentKernelPackingConstant * (momentHeightWeight T v * ∑ a ∈ S.image c, f a v) := by
  classical
  have hmap : ∀ i ∈ S, c i ∈ S.image c := fun i hi => Finset.mem_image.mpr ⟨i, hi, rfl⟩
  rw [← Finset.sum_fiberwise_of_maps_to hmap]
  calc
    _ = ∑ a ∈ S.image c, (∑ i ∈ S.filter (fun i => c i = a), Detector.Smooth.criticalWeight (v - t i)) * f a v := by
      apply Finset.sum_congr rfl
      intro a _
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro i hi
      rw [(Finset.mem_filter.mp hi).2]
    _ ≤ ∑ a ∈ S.image c, (momentKernelPackingConstant * momentHeightWeight T v) * f a v := by
      apply Finset.sum_le_sum
      intro a _
      apply mul_le_mul_of_nonneg_right _ (hf0 a v)
      apply moment_indexed_kernel_packing _ t T hT
      · intro i hi
        exact ht i (Finset.mem_filter.mp hi).1
      · intro i hi j hj hij
        have hi' := Finset.mem_filter.mp hi
        have hj' := Finset.mem_filter.mp hj
        exact hsep i hi'.1 j hj'.1 (hi'.2.trans hj'.2.symm) hij
    _ = _ := by rw [← Finset.mul_sum]; ring

 theorem moment_packed_moment {ι κ : Type*} (S : Finset ι) (c : ι → κ) (t : ι → ℝ)
    (T : ℝ) (hT : 1 ≤ T) (ht : ∀ i ∈ S, |t i| ≤ T)
    (hsep : ∀ i ∈ S, ∀ j ∈ S, c i = c j → i ≠ j → 1 ≤ |t i - t j|)
    (f : κ → ℝ → ℝ) (hf : ∀ a, Continuous (f a)) (hf0 : ∀ a v, 0 ≤ f a v)
    (hint : Integrable (fun v => momentHeightWeight T v * ∑ a ∈ S.image c, f a v)) :
    (∀ i ∈ S, Integrable (fun v => Detector.Smooth.criticalWeight (v - t i) * f (c i) v)) ∧
    (∑ i ∈ S, ∫ v, Detector.Smooth.criticalWeight (v - t i) * f (c i) v) ≤
      momentKernelPackingConstant * ∫ v, momentHeightWeight T v * ∑ a ∈ S.image c, f a v := by
  classical
  have hc : Continuous Detector.Smooth.criticalWeight := by
    unfold Detector.Smooth.criticalWeight
    exact continuous_const.div ((continuous_const.add continuous_abs).pow 3) (fun _ => by positivity)
  have hi (i : ι) (hi : i ∈ S) : Integrable (fun v => Detector.Smooth.criticalWeight (v - t i) * f (c i) v) := by
    apply (hint.const_mul momentKernelPackingConstant).mono'
      (((hc.comp (continuous_id.sub continuous_const)).mul (hf (c i))).aestronglyMeasurable)
    filter_upwards with v
    change ‖Detector.Smooth.criticalWeight (v - t i) * f (c i) v‖ ≤ _
    rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (hf0 _ _))]
    exact (Finset.single_le_sum
      (f := fun j => Detector.Smooth.criticalWeight (v - t j) * f (c j) v)
      (fun j _ => mul_nonneg (Detector.Smooth.criticalWeight_nonneg _) (hf0 _ _)) hi).trans
      (moment_packed_pointwise S c t T hT ht hsep f hf0 v)
  refine ⟨hi, ?_⟩
  rw [← integral_finsetSum S hi, ← integral_const_mul]
  apply integral_mono (integrable_finsetSum S hi) (hint.const_mul _)
  intro v
  exact moment_packed_pointwise S c t T hT ht hsep f hf0 v

end Legendre.Density.Moment
