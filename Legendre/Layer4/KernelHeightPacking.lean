/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityKernelHeightPacking.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.KernelPacking
public import Legendre.LargeSieve.SeparatedSampling

@[expose] public section
namespace Legendre.Density.Moment

open MeasureTheory Set
open scoped BigOperators

theorem moment_separated_card (S : Finset ℝ) (T : ℝ) (hT : 0 ≤ T)
    (hS : ∀ x ∈ S, |x| ≤ T)
    (hsep : ∀ x ∈ S, ∀ y ∈ S, x ≠ y → 1 ≤ |x-y|) :
    (S.card : ℝ) ≤ 2*(T+1) := by
  have h := LargeSieve.sum_local_integrals_le S id (δ := 1) (L := -T) (U := T+1)
    (by norm_num) (by linarith)
    (fun x hx => ⟨(abs_le.mp (hS x hx)).1,by change x+1 ≤ T+1; linarith [(abs_le.mp (hS x hx)).2]⟩)
    hsep (f := fun _ : ℝ => 1) continuous_const (fun _ => by norm_num)
  simp only [id_eq,intervalIntegral.integral_const,smul_eq_mul,mul_one,
    add_sub_cancel_left,Finset.sum_const,nsmul_eq_mul,mul_one] at h
  linarith

 theorem momentHeightWeight_eq (T x : ℝ) (hT : 0 < T) :
    momentHeightWeight T x = T ^ 3 / (T + |x|) ^ 3 := by
  unfold momentHeightWeight Detector.Smooth.criticalWeight
  rw [abs_div, abs_of_pos hT]
  field_simp

 theorem moment_kernel_far_bound (T v x : ℝ) (hT : 0 < T)
    (hx : |x| ≤ T) (hv : 2 * T < |v|) :
    Detector.Smooth.criticalWeight (v - x) ≤ 64 / (T + |v|) ^ 3 := by
  have ht : |v| ≤ |v - x| + |x| := by
    simpa only [sub_add_cancel] using abs_add_le (v - x) x
  have hd : T + |v| ≤ 4 * (1 + |v - x|) := by linarith [abs_nonneg (v - x)]
  have hp := pow_le_pow_left₀ (by positivity : 0 ≤ T + |v|) hd 3
  unfold Detector.Smooth.criticalWeight
  apply (div_le_div_iff₀ (by positivity) (by positivity)).mpr
  nlinarith

 theorem moment_kernel_height_packing (S : Finset ℝ) (T : ℝ) (hT : 1 ≤ T)
    (hS : ∀ x ∈ S, |x| ≤ T)
    (hsep : ∀ x ∈ S, ∀ y ∈ S, x ≠ y → 1 ≤ |x - y|) (v : ℝ) :
    (∑ x ∈ S, Detector.Smooth.criticalWeight (v - x)) ≤
      (256 + 27 * (1 + 4 * Real.pi ^ 2 / 3)) * momentHeightWeight T v := by
  have hTp : 0 < T := by linarith
  have hw : 0 ≤ momentHeightWeight T v := momentHeightWeight_nonneg T v
  have hK : 0 ≤ 1 + 4 * Real.pi ^ 2 / 3 := by positivity
  by_cases hv : |v| ≤ 2 * T
  · have hh : |v / T| ≤ 2 := by
      rw [abs_div, abs_of_pos hTp]
      exact (div_le_iff₀ hTp).mpr hv
    have hweight : 1 ≤ 27 * momentHeightWeight T v := by
      unfold momentHeightWeight Detector.Smooth.criticalWeight
      have hd : (1 + |v / T|) ^ 3 ≤ 27 := by
        have h := pow_le_pow_left₀ (by positivity : 0 ≤ 1 + |v / T|)
          (by linarith : 1 + |v / T| ≤ 3) 3
        norm_num at h ⊢
        exact h
      rw [mul_one_div]
      apply (le_div_iff₀ (by positivity : 0 < (1 + |v / T|) ^ 3)).mpr
      nlinarith
    calc
      _ ≤ 1 + 4 * Real.pi ^ 2 / 3 := criticalWeight_separated_sum S hsep v
      _ ≤ (1 + 4 * Real.pi ^ 2 / 3) * (27 * momentHeightWeight T v) :=
        le_mul_of_one_le_right hK hweight
      _ ≤ _ := by nlinarith
  · have hv' : 2 * T < |v| := lt_of_not_ge hv
    have hc : (S.card : ℝ) ≤ 4 * T := (moment_separated_card S T hTp.le hS hsep).trans (by linarith)
    have hTc : T ≤ T ^ 3 := by nlinarith [sq_nonneg (T - 1)]
    calc
      _ ≤ ∑ _x ∈ S, 64 / (T + |v|) ^ 3 :=
        Finset.sum_le_sum (fun x hx => moment_kernel_far_bound T v x hTp (hS x hx) hv')
      _ = (S.card : ℝ) * (64 / (T + |v|) ^ 3) := by simp
      _ ≤ (4 * T) * (64 / (T + |v|) ^ 3) := mul_le_mul_of_nonneg_right hc (by positivity)
      _ = 256 * T / (T + |v|) ^ 3 := by ring
      _ ≤ 256 * T ^ 3 / (T + |v|) ^ 3 :=
        div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hTc (by norm_num)) (by positivity)
      _ = 256 * momentHeightWeight T v := by rw [momentHeightWeight_eq T v hTp]; ring
      _ ≤ _ := by nlinarith

end Legendre.Density.Moment
