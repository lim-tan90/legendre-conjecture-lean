/-
Adapted from openai/math, commit 4eaee87548250b2682affda7d05d947c05554bae.
Original: lean/OAI/NumberTheory/Ostmann/ZeroDensity/CoefficientEnergy.lean.
Apache-2.0; retained license: licenses/openai-math-Apache-2.0.txt.
Changes: select the two character-independent dyadic-energy lemmas,
local imports/namespaces and Lean/mathlib v4.35.0 visibility.
-/
module

public import Legendre.ZeroDetector.Mollifier
public import Legendre.ZeroDetector.DivisorSquareMean
public import Mathlib.Analysis.SpecialFunctions.Pow.Real

@[expose] public section
open scoped BigOperators

namespace Legendre.Density.Detector

theorem dyadic_coefficient_energy_le (a : ℕ → ℂ) {C σ : ℝ} (_hC : 0 ≤ C)
    (hσ : 0 ≤ σ) {U : ℕ} (hU : 1 ≤ U)
    (ha : ∀ n ∈ Finset.Ioc U (2 * U), ‖a n‖ ≤ C * (n.divisors.card : ℝ)) :
    (∑ n ∈ Finset.Ioc U (2 * U), ‖a n‖ ^ 2 * (n : ℝ) ^ (-2 * σ)) ≤
      C ^ 2 * (2 * U * (1 + Real.log (2 * U)) ^ 3 * (U : ℝ) ^ (-2 * σ)) := by
  have hUR : (0 : ℝ) < U := by exact_mod_cast (Nat.zero_lt_one.trans_le hU)
  have hpoint : ∀ n ∈ Finset.Ioc U (2 * U),
      ‖a n‖ ^ 2 * (n : ℝ) ^ (-2 * σ) ≤
        C ^ 2 * (n.divisors.card : ℝ) ^ 2 * (U : ℝ) ^ (-2 * σ) := by
    intro n hn
    have hnU : (U : ℝ) ≤ n := by exact_mod_cast (Finset.mem_Ioc.mp hn).1.le
    have hpow : (n : ℝ) ^ (-2 * σ) ≤ (U : ℝ) ^ (-2 * σ) :=
      Real.rpow_le_rpow_of_nonpos hUR hnU (by nlinarith)
    have hnorm : ‖a n‖ ^ 2 ≤ C ^ 2 * (n.divisors.card : ℝ) ^ 2 := by
      simpa only [mul_pow] using pow_le_pow_left₀ (norm_nonneg _) (ha n hn) 2
    exact mul_le_mul hnorm hpow (Real.rpow_nonneg (Nat.cast_nonneg _) _)
      (by positivity)
  have hdivisors : (∑ n ∈ Finset.Ioc U (2 * U), (n.divisors.card : ℝ) ^ 2) ≤
      (2 * U : ℝ) * (1 + Real.log (2 * U)) ^ 3 := by
    calc
      (∑ n ∈ Finset.Ioc U (2 * U), (n.divisors.card : ℝ) ^ 2) ≤
          ∑ n ∈ Finset.Icc 1 (2 * U), (n.divisors.card : ℝ) ^ 2 := by
        apply Finset.sum_le_sum_of_subset_of_nonneg
        · intro n hn
          exact Finset.mem_Icc.mpr ⟨by have := (Finset.mem_Ioc.mp hn).1; omega,
            (Finset.mem_Ioc.mp hn).2⟩
        · intro n _ _
          positivity
      _ ≤ _ := by simpa only [Nat.cast_mul, Nat.cast_ofNat] using
        Arithmetic.DivisorSquareMean.divisor_square_mean (2 * U)
  calc
    (∑ n ∈ Finset.Ioc U (2 * U), ‖a n‖ ^ 2 * (n : ℝ) ^ (-2 * σ)) ≤
        ∑ n ∈ Finset.Ioc U (2 * U),
          C ^ 2 * (n.divisors.card : ℝ) ^ 2 * (U : ℝ) ^ (-2 * σ) :=
      Finset.sum_le_sum hpoint
    _ = C ^ 2 * (∑ n ∈ Finset.Ioc U (2 * U), (n.divisors.card : ℝ) ^ 2) *
        (U : ℝ) ^ (-2 * σ) := by rw [← Finset.sum_mul, ← Finset.mul_sum]
    _ ≤ C ^ 2 * ((2 * U : ℝ) * (1 + Real.log (2 * U)) ^ 3) *
        (U : ℝ) ^ (-2 * σ) := by gcongr
    _ = _ := by ring

theorem mollifier_dyadic_energy_le (X N : ℕ) {σ : ℝ} (hσ : 0 ≤ σ)
    {U : ℕ} (hU : 1 ≤ U) :
    (∑ n ∈ Finset.Ioc U (2 * U), ‖mollifierCoefficient X N n‖ ^ 2 *
      (n : ℝ) ^ (-2 * σ)) ≤
      2 * U * (1 + Real.log (2 * U)) ^ 3 * (U : ℝ) ^ (-2 * σ) := by
  simpa only [one_pow, one_mul] using
    dyadic_coefficient_energy_le (mollifierCoefficient X N) (C := 1) zero_le_one hσ hU
      (fun n _ => by simpa using norm_mollifierCoefficient_le X N n)

end Legendre.Density.Detector
