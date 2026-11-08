/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityDetectorCoefficients.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
The full divisor convolution has no second truncation parameter.
-/
module
public import Legendre.Layer4.DivisorEnergy
public import Legendre.ZeroDetector.FiniteMollifier

@[expose] public section
namespace Legendre.Density.Detector.Smooth

open scoped BigOperators Classical

noncomputable def mobiusCutoff (X n : ℕ) : ℂ :=
  if n ≤ X then (ArithmeticFunction.moebius n : ℂ) else 0

noncomputable def detectorCoefficient (X n : ℕ) : ℂ :=
  ∑ d ∈ n.divisors, mobiusCutoff X d

 theorem mobiusCutoff_norm (X n : ℕ) : ‖mobiusCutoff X n‖ ≤ 1 := by
  unfold mobiusCutoff
  split_ifs
  · norm_cast
    exact ArithmeticFunction.abs_moebius_le_one
  · simp

 theorem detectorCoefficient_norm (X n : ℕ) :
    ‖detectorCoefficient X n‖ ≤ n.divisors.card := by
  apply (norm_sum_le _ _).trans
  calc
    _ ≤ ∑ d ∈ n.divisors, (1 : ℝ) :=
      Finset.sum_le_sum (fun d _ => mobiusCutoff_norm X d)
    _ = _ := by simp

 theorem detectorCoefficient_initial (X n : ℕ) (hn : n ≤ X) :
    detectorCoefficient X n = if n = 1 then 1 else 0 := by
  have he : detectorCoefficient X n = ∑ d ∈ n.divisors,
      (ArithmeticFunction.moebius d : ℂ) := by
    apply Finset.sum_congr rfl
    intro d hd
    unfold mobiusCutoff
    exact ite_eq_left ((Nat.le_of_dvd (Nat.pos_of_ne_zero (Nat.mem_divisors.mp hd).2) (Nat.dvd_of_mem_divisors hd)).trans hn)
  rw [he]
  have hm := congrArg (fun f : ArithmeticFunction ℂ => f n)
    (ArithmeticFunction.coe_zeta_mul_coe_moebius (R := ℂ))
  rw [ArithmeticFunction.coe_zeta_mul_apply] at hm
  simpa only [ArithmeticFunction.intCoe_apply, ArithmeticFunction.one_apply] using hm

 theorem detectorCoefficient_one {X : ℕ} (hX : 1 ≤ X) :
    detectorCoefficient X 1 = 1 := by
  rw [detectorCoefficient_initial X 1 hX, ite_eq_left rfl]

 theorem detectorCoefficient_small {X n : ℕ} (hn : 2 ≤ n) (hX : n ≤ X) :
    detectorCoefficient X n = 0 := by
  rw [detectorCoefficient_initial X n hX, ite_eq_right (by omega)]

 theorem detectorCoefficient_energy (X N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, ‖detectorCoefficient X n‖ ^ 2) ≤
      (N : ℝ) * (1 + Real.log N) ^ 3 := by
  apply (Finset.sum_le_sum (fun n _ =>
    pow_le_pow_left₀ (norm_nonneg _) (detectorCoefficient_norm X n) 2)).trans
  exact Detector.Arithmetic.DivisorSquareMean.divisor_square_mean N

 theorem detectorCoefficient_harmonic_energy (X N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, ‖detectorCoefficient X n‖ ^ 2 / n) ≤
      (1 + Real.log N) ^ 4 := by
  apply (Finset.sum_le_sum (fun n _ =>
    div_le_div_of_nonneg_right
      (pow_le_pow_left₀ (norm_nonneg _) (detectorCoefficient_norm X n) 2)
      (Nat.cast_nonneg n))).trans
  exact Moment.divisor_square_harmonic N

end Legendre.Density.Detector.Smooth
