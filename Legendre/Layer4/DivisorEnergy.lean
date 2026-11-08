/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The divisor estimates adapt DensityHarmonicDivisors.lean and
DensityShiftedDivisorEnergy.lean from
openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
The local proof reuses the existing untwisted divisor-square and LCM slice.
The retained upstream license is licenses/openai-math-Apache-2.0.txt.
-/
module

public import Legendre.ZeroDetector.DivisorSquareMean
public import Legendre.ComplexDirichlet
public import Legendre.ZeroDetector.TailEnergy
public import Mathlib.Tactic

@[expose] public section

/-! # The harmonic second moment of the divisor function -/

namespace Legendre.Density.Moment

open scoped BigOperators Classical

theorem divisor_square_as_sum (N n : ℕ) (hn : n ∈ Finset.Icc 1 N) :
    (n.divisors.card : ℝ)^2 = ∑ d ∈ Finset.Icc 1 N, ∑ e ∈ Finset.Icc 1 N,
      if d.lcm e ∣ n then (1 : ℝ) else 0 := by
  have h := Detector.Arithmetic.DivisorSquareMean.divisor_square_eq_double_sum
    (Finset.mem_Icc.1 hn).1 (Finset.mem_Icc.1 hn).2
  simp_rw [← Nat.lcm_dvd_iff] at h
  exact_mod_cast h

theorem harmonic_multiples (N d : ℕ) (hd : 0 < d) :
    (∑ n ∈ (Finset.Icc 1 N).filter (fun n => d ∣ n), (n : ℝ)⁻¹) =
      (d : ℝ)⁻¹ * ∑ k ∈ Finset.Icc 1 (N / d), (k : ℝ)⁻¹ := by
  rw [Finset.mul_sum]
  symm
  apply Finset.sum_bij (fun k _ => d * k)
  · intro k hk
    obtain ⟨hk1, hkN⟩ := Finset.mem_Icc.mp hk
    have hu := (Nat.le_div_iff_mul_le hd).mp hkN
    exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr
      ⟨Nat.mul_pos hd hk1, by simpa only [mul_comm] using hu⟩, dvd_mul_right d k⟩
  · intro k _ l _ hkl
    exact Nat.eq_of_mul_eq_mul_left hd hkl
  · intro n hn
    obtain ⟨hnN, hdn⟩ := Finset.mem_filter.mp hn
    have hn1 := (Finset.mem_Icc.mp hnN).1
    have hdle : d ≤ n := Nat.le_of_dvd hn1 hdn
    refine ⟨n / d, Finset.mem_Icc.mpr ⟨Nat.div_pos hdle hd,
      Nat.div_le_div_right (Finset.mem_Icc.mp hnN).2⟩, ?_⟩
    exact Nat.mul_div_cancel' hdn
  · intro k _
    rw [Nat.cast_mul, mul_inv_rev, mul_comm]

theorem harmonic_multiples_le (N d : ℕ) (hd : 0 < d) :
    (∑ n ∈ (Finset.Icc 1 N).filter (fun n => d ∣ n), (n : ℝ)⁻¹) ≤
      (d : ℝ)⁻¹ * ∑ k ∈ Finset.Icc 1 N, (k : ℝ)⁻¹ := by
  rw [harmonic_multiples N d hd]
  apply mul_le_mul_of_nonneg_left _ (inv_nonneg.mpr (Nat.cast_nonneg _))
  exact Finset.sum_le_sum_of_subset_of_nonneg
    (Finset.Icc_subset_Icc_right (Nat.div_le_self N d)) (fun _ _ _ => by positivity)

theorem divisor_square_harmonic (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, (n.divisors.card : ℝ) ^ 2 / n) ≤
      (1 + Real.log N) ^ 4 := by
  let H : ℝ := ∑ k ∈ Finset.Icc 1 N, (k : ℝ)⁻¹
  have hH : 0 ≤ H := Finset.sum_nonneg (fun _ _ => by positivity)
  have hHlog : H ≤ 1 + Real.log N := by
    simpa only [H, harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
      using harmonic_le_one_add_log N
  have hexp (n : ℕ) (hn : n ∈ Finset.Icc 1 N) :
      (n.divisors.card : ℝ) ^ 2 / n =
      ∑ d ∈ Finset.Icc 1 N, ∑ e ∈ Finset.Icc 1 N,
        if d.lcm e ∣ n then (n : ℝ)⁻¹ else 0 := by
    rw [divisor_square_as_sum N n hn, div_eq_mul_inv]
    simp only [Finset.sum_mul, ite_mul, one_mul, zero_mul]
  calc
    _ = ∑ d ∈ Finset.Icc 1 N, ∑ e ∈ Finset.Icc 1 N,
        ∑ n ∈ (Finset.Icc 1 N).filter (fun n => d.lcm e ∣ n), (n : ℝ)⁻¹ := by
      rw [Finset.sum_congr rfl hexp, Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro d _
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro e _
      rw [Finset.sum_filter]
    _ ≤ ∑ d ∈ Finset.Icc 1 N, ∑ e ∈ Finset.Icc 1 N,
        ((d.lcm e : ℕ) : ℝ)⁻¹ * H := by
      apply Finset.sum_le_sum
      intro d hd
      apply Finset.sum_le_sum
      intro e he
      apply harmonic_multiples_le
      exact Nat.lcm_pos (Finset.mem_Icc.mp hd).1 (Finset.mem_Icc.mp he).1
    _ = (∑ d ∈ Finset.Icc 1 N, ∑ e ∈ Finset.Icc 1 N,
        ((d.lcm e : ℕ) : ℝ)⁻¹) * H := by simp only [Finset.sum_mul]
    _ ≤ (1 + Real.log N) ^ 3 * H :=
      mul_le_mul_of_nonneg_right (Detector.Arithmetic.FrequencyLCM.reciprocal_lcm_sum_le_log N) hH
    _ ≤ (1 + Real.log N) ^ 3 * (1 + Real.log N) :=
      mul_le_mul_of_nonneg_left hHlog (pow_nonneg (hH.trans hHlog) 3)
    _ = _ := by ring

theorem verticalCoefficients_square_div (a : ℕ → ℂ) (σ : ℝ) (n : ℕ) (hn : 0 < n) :
    ‖verticalCoefficients a σ n‖^2 = ‖a n‖^2/(n : ℝ)^(2*σ) := by
  rw [Detector.norm_verticalCoefficients_sq a σ hn]
  rw [show (-2 : ℝ)*σ = -(2*σ) by ring,Real.rpow_neg (Nat.cast_nonneg n),div_eq_mul_inv]

 theorem divisor_shifted_head (N : ℕ) (c : ℝ) (hc : 0 ≤ c) :
    (∑ n ∈ Finset.Icc 1 N,
      ‖verticalCoefficients (fun n : ℕ => (n.divisors.card : ℂ)) (1 / 2 + c) n‖ ^ 2) ≤
        (1 + Real.log N) ^ 4 := by
  apply (Finset.sum_le_sum (fun n hn => ?_)).trans (divisor_square_harmonic N)
  have hnR : (1 : ℝ) ≤ n := by exact_mod_cast (Finset.mem_Icc.mp hn).1
  rw [verticalCoefficients_square_div _ _ n (Finset.mem_Icc.mp hn).1]
  simp only [Complex.norm_natCast]
  apply div_le_div_of_nonneg_left (sq_nonneg _) (by positivity)
  calc
    (n : ℝ) = (n : ℝ) ^ (1 : ℝ) := (Real.rpow_one _).symm
    _ ≤ (n : ℝ) ^ (2 * (1 / 2 + c)) :=
      Real.rpow_le_rpow_of_exponent_le hnR (by linarith)

theorem divisor_shifted_tail (S : Finset ℕ) (M N : ℕ) (hM : 1 ≤ M)
    (hS : S ⊆ Finset.Icc M N) :
    (∑ n ∈ S,
      ‖verticalCoefficients (fun n : ℕ => (n.divisors.card : ℂ)) (1 / 2 + (1 : ℝ)) n‖ ^ 2) ≤
        (N : ℝ) * (1 + Real.log N) ^ 3 / (M : ℝ) ^ 3 := by
  have hMp : (0 : ℝ) < M := by exact_mod_cast (show 0 < M by omega)
  calc
    _ ≤ ∑ n ∈ S, (n.divisors.card : ℝ) ^ 2 / (M : ℝ) ^ 3 := by
      apply Finset.sum_le_sum
      intro n hn
      have hMn := (Finset.mem_Icc.mp (hS hn)).1
      have hnpos : 0 < n := lt_of_lt_of_le (by omega : 0 < M) hMn
      rw [verticalCoefficients_square_div _ _ n hnpos]
      norm_num only [Complex.norm_natCast, show (2 : ℝ) * (1 / 2 + 1) = 3 by norm_num,
        Real.rpow_natCast]
      have hp : (M : ℝ) ^ 3 ≤ (n : ℝ) ^ 3 :=
        pow_le_pow_left₀ hMp.le (by exact_mod_cast hMn) 3
      convert div_le_div_of_nonneg_left (sq_nonneg (n.divisors.card : ℝ)) (pow_pos hMp 3) hp using 1
      simp only [Real.rpow_ofNat]
    _ = (∑ n ∈ S, (n.divisors.card : ℝ) ^ 2) / (M : ℝ) ^ 3 := by rw [Finset.sum_div]
    _ ≤ (∑ n ∈ Finset.Icc 1 N, (n.divisors.card : ℝ) ^ 2) / (M : ℝ) ^ 3 := by
      apply div_le_div_of_nonneg_right _ (pow_nonneg hMp.le 3)
      apply Finset.sum_le_sum_of_subset_of_nonneg
      · intro n hn
        exact Finset.mem_Icc.mpr ⟨hM.trans (Finset.mem_Icc.mp (hS hn)).1,
          (Finset.mem_Icc.mp (hS hn)).2⟩
      · intro n _ _
        positivity
    _ ≤ _ := div_le_div_of_nonneg_right (Detector.Arithmetic.DivisorSquareMean.divisor_square_mean N) (pow_nonneg hMp.le 3)

end Legendre.Density.Moment


