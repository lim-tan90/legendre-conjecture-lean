/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Adapted from DensityWeightedMoment.lean in openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.HeightWeight

@[expose] public section
namespace Legendre.Density.Moment

open MeasureTheory Set
open scoped BigOperators

noncomputable def momentShellBudget (A : ℝ) (k : ℕ) : ℕ → ℝ
  | 0 => A
  | j + 1 => 2 * A * ((j + 2 : ℝ) ^ k * (1 / 4 : ℝ) ^ j)

 theorem momentShellBudget_nonneg (A : ℝ) (hA : 0 ≤ A) (k j : ℕ) :
    0 ≤ momentShellBudget A k j := by
  cases j <;> simp only [momentShellBudget] <;> positivity

 theorem momentShellBudget_summable (A : ℝ) (k : ℕ) : Summable (momentShellBudget A k) := by
  apply (summable_nat_add_iff 1).mp
  exact (moment_height_energy_summable k).mul_left (2 * A)

 theorem momentShellBudget_sum (A : ℝ) (k : ℕ) :
    (∑' j, momentShellBudget A k j) = A * momentHeightEnergyConstant k := by
  rw [(momentShellBudget_summable A k).tsum_eq_zero_add]
  simp only [momentShellBudget]
  rw [tsum_mul_left]
  unfold momentHeightEnergyConstant
  ring

 theorem moment_weighted_shell_bound (f : ℝ → ℝ) (hf : Continuous f)
    (hf0 : ∀ x, 0 ≤ f x) (T : ℝ) (hT : 0 < T) (A : ℝ) (k : ℕ)
    (hball : ∀ j : ℕ, (∫ x in momentHeightBall T j, f x) ≤
      A * (2 : ℝ) ^ j * (j + 1 : ℝ) ^ k) (j : ℕ) :
    (∫ x in momentHeightShell T j, momentHeightWeight T x * f x) ≤
      momentShellBudget A k j := by
  have hi (j : ℕ) : IntegrableOn f (momentHeightBall T j) := hf.continuousOn.integrableOn_Icc
  have hiw (j : ℕ) : IntegrableOn (fun x => momentHeightWeight T x * f x) (momentHeightShell T j) :=
    (((momentHeightWeight_continuous T).mul hf).continuousOn.integrableOn_Icc).mono_set
      (momentHeightShell_subset T j)
  cases j with
  | zero =>
    apply (integral_mono (hiw 0) (hi 0) (fun x => ?_)).trans
    · simpa only [momentHeightShell, momentShellBudget, pow_zero, mul_one, Nat.cast_zero, zero_add, one_pow] using hball 0
    · exact mul_le_of_le_one_left (hf0 x) (criticalWeight_le_one _)
  | succ j =>
    have hsub : (∫ x in momentHeightShell T (j + 1), f x) ≤
        ∫ x in momentHeightBall T (j + 1), f x :=
      setIntegral_mono_set (hi (j + 1)) (Filter.Eventually.of_forall hf0)
        (Filter.Eventually.of_forall (fun _ hx => momentHeightShell_subset T (j + 1) hx))
    calc
      _ ≤ (1 / 8 : ℝ) ^ j * ∫ x in momentHeightShell T (j + 1), f x := by
        rw [← integral_const_mul]
        apply setIntegral_mono_on (hiw (j + 1))
          (((hi (j + 1)).mono_set (momentHeightShell_subset T (j + 1))).const_mul _)
          (momentHeightShell_measurable T (j + 1))
        intro x hx
        exact mul_le_mul_of_nonneg_right (momentHeightWeight_shell T hT j x hx) (hf0 x)
      _ ≤ (1 / 8 : ℝ) ^ j * (A * (2 : ℝ) ^ (j + 1) * (j + 1 + 1 : ℝ) ^ k) :=
        mul_le_mul_of_nonneg_left (hsub.trans (by
          simpa only [Nat.cast_add, Nat.cast_one] using hball (j + 1))) (by positivity)
      _ = momentShellBudget A k (j + 1) := by
        simp only [momentShellBudget, pow_succ]
        have he : (1 / 8 : ℝ) ^ j * (2 : ℝ) ^ j = (1 / 4 : ℝ) ^ j := by
          rw [← mul_pow]
          norm_num
        rw [show (j + 1 + 1 : ℝ) = j + 2 by ring]
        calc
          _ = 2 * A * (j + 2 : ℝ) ^ k * ((1 / 8 : ℝ) ^ j * (2 : ℝ) ^ j) := by ring
          _ = _ := by rw [he]; ring

 theorem moment_weighted_moment (f : ℝ → ℝ) (hf : Continuous f)
    (hf0 : ∀ x, 0 ≤ f x) (T : ℝ) (hT : 0 < T) (A : ℝ) (_hA : 0 ≤ A) (k : ℕ)
    (hball : ∀ j : ℕ, (∫ x in momentHeightBall T j, f x) ≤
      A * (2 : ℝ) ^ j * (j + 1 : ℝ) ^ k) :
    Integrable (fun x => momentHeightWeight T x * f x) ∧
      (∫ x, momentHeightWeight T x * f x) ≤ A * momentHeightEnergyConstant k := by
  let g := fun x => momentHeightWeight T x * f x
  have hg0 (x : ℝ) : 0 ≤ g x := mul_nonneg (momentHeightWeight_nonneg T x) (hf0 x)
  have hi (j : ℕ) : IntegrableOn g (momentHeightShell T j) :=
    (((momentHeightWeight_continuous T).mul hf).continuousOn.integrableOn_Icc).mono_set
      (momentHeightShell_subset T j)
  have hb (j : ℕ) : (∫ x in momentHeightShell T j, g x) ≤ momentShellBudget A k j :=
    moment_weighted_shell_bound f hf hf0 T hT A k hball j
  have hsum : Summable (fun j => ∫ x in momentHeightShell T j, g x) :=
    (momentShellBudget_summable A k).of_nonneg_of_le
      (fun j => integral_nonneg (fun x => hg0 x)) hb
  have hnorm : Summable (fun j => ∫ x in momentHeightShell T j, ‖g x‖) := by
    simpa only [Real.norm_eq_abs, abs_of_nonneg (hg0 _)] using hsum
  have hgi := integrableOn_iUnion_of_summable_integral_norm hi hnorm
  rw [momentHeightShell_cover T hT, integrableOn_univ] at hgi
  refine ⟨hgi, ?_⟩
  have he := integral_iUnion (momentHeightShell_measurable T)
    (momentHeightShell_disjoint T hT.le) (show IntegrableOn g (⋃ j, momentHeightShell T j) by
      rwa [momentHeightShell_cover T hT, integrableOn_univ])
  rw [momentHeightShell_cover T hT, setIntegral_univ] at he
  change (∫ x, g x) ≤ _
  rw [he, ← momentShellBudget_sum A k]
  exact hsum.tsum_le_tsum hb (momentShellBudget_summable A k)

end Legendre.Density.Moment
