/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorIntegral.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
This is the initial right contour only. Moving it across the zeta pole is
not asserted; that requires a separate principal-pole contribution.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.DetectorSeries
public import Legendre.Layer4.XiFiniteMellin

@[expose] public section
namespace Legendre.Density.Detector.Smooth

open Complex MeasureTheory
open scoped BigOperators Classical ArithmeticFunction.Moebius

noncomputable def detectorVerticalTerm (X : ℕ)
    (s : ℂ) (Y : ℝ) (n : ℕ) (t : ℝ) : ℂ :=
  LSeries.term (detectorCoefficient X) (s + (2 + (t : ℂ) * I)) n *
    (Y : ℂ) ^ (2 + (t : ℂ) * I) * detectorKernel (2 + (t : ℂ) * I)

 theorem detectorVerticalTerm_norm (X : ℕ)
    (s : ℂ) (Y : ℝ) (hY : 0 < Y) (n : ℕ) (t : ℝ) :
    ‖detectorVerticalTerm X s Y n t‖ =
      (‖LSeries.term (detectorCoefficient X) (s + 2) n‖ * Y ^ 2) *
        ‖detectorKernel (2 + (t : ℂ) * I)‖ := by
  unfold detectorVerticalTerm
  rw [norm_mul, norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos hY]
  have he : (2 + (t : ℂ) * I).re = (2 : ℝ) := by simp
  rw [he, Real.rpow_two]
  have hn : ‖LSeries.term (detectorCoefficient X) (s + (2 + (t : ℂ) * I)) n‖ =
      ‖LSeries.term (detectorCoefficient X) (s + 2) n‖ := by
    simp only [LSeries.norm_term_eq]
    congr 2
    simp
  rw [hn]

 theorem detectorVerticalTerm_continuous (X : ℕ)
    (s : ℂ) (Y : ℝ) (hY : 0 < Y) (n : ℕ) :
    Continuous (detectorVerticalTerm X s Y n) := by
  have hk : Continuous (fun t : ℝ => detectorKernel (2 + (t : ℂ) * I)) := by
    unfold detectorKernel
    apply continuous_const.div (by fun_prop)
    intro t
    apply mul_ne_zero
    · apply mul_ne_zero <;> norm_num [Complex.ext_iff]
    · norm_num [Complex.ext_iff]
  have hpow : Continuous (fun t : ℝ => (Y : ℂ) ^ (2 + (t : ℂ) * I)) :=
    (differentiable_id.const_cpow (Or.inl (by exact_mod_cast hY.ne'))).continuous.comp (by fun_prop)
  apply Continuous.mul _ hk
  apply Continuous.mul _ hpow
  by_cases hn : n = 0
  · subst n
    simp only [LSeries.term_zero]
    exact continuous_const
  · simp only [LSeries.term_of_ne_zero hn]
    apply continuous_const.div
    · exact (differentiable_id.const_cpow (Or.inl (by exact_mod_cast hn))).continuous.comp (by fun_prop)
    · intro t
      exact Complex.cpow_ne_zero_iff.mpr (Or.inl (by exact_mod_cast hn))

 theorem detectorVerticalTerm_integrable (X : ℕ)
    (s : ℂ) (Y : ℝ) (hY : 0 < Y) (n : ℕ) :
    Integrable (detectorVerticalTerm X s Y n) := by
  have hk := (detectorKernel_verticalIntegrable 2 (by norm_num)).norm
  apply (hk.const_mul (‖LSeries.term (detectorCoefficient X) (s + 2) n‖ * Y ^ 2)).mono'
    (detectorVerticalTerm_continuous X s Y hY n).aestronglyMeasurable
  exact Filter.Eventually.of_forall (fun t => (detectorVerticalTerm_norm X s Y hY n t).le)

 theorem detectorVerticalTerm_summable_norm (X : ℕ)
    (s : ℂ) (hs : 0 ≤ s.re) (Y : ℝ) (hY : 0 < Y) :
    Summable (fun n : ℕ => ∫ t : ℝ, ‖detectorVerticalTerm X s Y n t‖) := by
  have hsum := (detectorCoefficient_summable X (s := s+2)
    (by simp; linarith)).norm
  have h := (hsum.mul_right (Y ^ 2)).mul_right
    (∫ t : ℝ, ‖detectorKernel (2 + (t : ℂ) * I)‖)
  apply h.congr
  intro n
  simp only [detectorVerticalTerm_norm X s Y hY, integral_const_mul]

 theorem detectorVerticalTerm_inversion (X : ℕ)
    (s : ℂ) (Y : ℝ) (hY : 0 < Y) (n : ℕ) :
    ((1 / (2 * Real.pi) : ℝ) : ℂ) * (∫ t : ℝ, detectorVerticalTerm X s Y n t) =
      LSeries.term (detectorCoefficient X) s n * detectorWeight (n / Y) := by
  by_cases hn : n = 0
  · subst n
    simp [detectorVerticalTerm]
  have hnR : 0 < (n : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero hn
  have he (t : ℝ) : detectorVerticalTerm X s Y n t =
      LSeries.term (detectorCoefficient X) s n *
        (((n : ℝ) / Y : ℝ) : ℂ) ^ (-(2 + (t : ℂ) * I)) *
          detectorKernel (2 + (t : ℂ) * I) := by
    rw [detectorVerticalTerm, Legendre.Zeta.LSeries_term_add, Complex.cpow_neg,
      Complex.ofReal_div, Complex.div_cpow_ofReal_nonneg hnR.le hY.le, inv_div]
    push_cast
    ring
  simp_rw [he, mul_assoc]
  rw [integral_const_mul]
  have hinv := detectorWeight_mellin_inversion 2 ((n : ℝ) / Y) (by norm_num) (div_pos hnR hY)
  change ((1 / (2 * Real.pi) : ℝ) : ℂ) * (∫ t : ℝ,
    (((n : ℝ) / Y : ℝ) : ℂ) ^ (-(2 + (t : ℂ) * I)) *
      detectorKernel (2 + (t : ℂ) * I)) = _ at hinv
  rw [← hinv]
  ring

 theorem detectorMean_eq_integral (X : ℕ)
    (s : ℂ) (hs : 0 ≤ s.re) (Y : ℝ) (hY : 0 < Y) :
    detectorMean X s Y = ((1 / (2 * Real.pi) : ℝ) : ℂ) * ∫ t : ℝ,
      riemannZeta (s + (2 + (t : ℂ) * I)) *
        finiteSeries (μ : ArithmeticFunction ℂ) X (s + (2 + (t : ℂ) * I)) *
          (Y : ℂ) ^ (2 + (t : ℂ) * I) * detectorKernel (2 + (t : ℂ) * I) := by
  rw [detectorMean_tsum X s Y hY]
  simp_rw [← detectorVerticalTerm_inversion X s Y hY]
  rw [tsum_mul_left, integral_tsum_of_summable_integral_norm
    (fun n => detectorVerticalTerm_integrable X s Y hY n)
    (detectorVerticalTerm_summable_norm X s hs Y hY)]
  congr 1
  apply integral_congr_ae
  filter_upwards with t
  simp only [detectorVerticalTerm, tsum_mul_right]
  rw [show (∑' n, LSeries.term (detectorCoefficient X)
      (s + (2 + (t : ℂ) * I)) n) =
      riemannZeta (s + (2 + (t : ℂ) * I)) * finiteSeries (μ : ArithmeticFunction ℂ) X (s + (2 + (t : ℂ) * I)) from
    mollifier_zeta_product X (by simp; linarith)]

end Legendre.Density.Detector.Smooth
