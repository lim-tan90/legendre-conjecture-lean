/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

The product-integrability and Fubini organization adapts
DensityGaussianFubini.lean from openai/math, commit
4eaee87548250b2682affda7d05d947c05554bae (Apache-2.0).
Here a proved translated mean-square bound replaces the character large sieve.
Retained license: licenses/openai-math-Apache-2.0.txt.
-/
module
public import Legendre.Layer4.MomentGaussian
public import Legendre.DirichletMeanValueSharp
public import Mathlib.MeasureTheory.Integral.Prod

@[expose] public section
namespace Legendre.Density.Moment
open Complex MeasureTheory Set
open scoped BigOperators

noncomputable def subsetPolynomial (S : Finset ℕ) (a : ℕ → ℂ) (t : ℝ) : ℂ :=
  exponentialSum S a (fun n => -Real.log n) t

theorem subsetPolynomial_continuous (S : Finset ℕ) (a : ℕ → ℂ) :
    Continuous (subsetPolynomial S a) := continuous_exponentialSum _ _ _

theorem subsetPolynomial_norm (S : Finset ℕ) (a : ℕ → ℂ) (t : ℝ) :
    ‖subsetPolynomial S a t‖ ≤ ∑ n ∈ S, ‖a n‖ := by
  apply (norm_sum_le _ _).trans
  apply Finset.sum_le_sum
  intro n _
  rw [norm_mul,norm_realPhase,mul_one]

theorem realPhase_add (ν t u : ℝ) : realPhase ν (t+u) = realPhase ν t*realPhase ν u := by
  unfold realPhase
  rw [← Complex.exp_add]
  congr 1
  push_cast
  ring

theorem subsetPolynomial_add (S : Finset ℕ) (a : ℕ → ℂ) (t u : ℝ) :
    subsetPolynomial S a (t+u) =
      subsetPolynomial S (fun n => a n*realPhase (-Real.log n) u) t := by
  unfold subsetPolynomial exponentialSum
  apply Finset.sum_congr rfl
  intro n _
  rw [realPhase_add]
  ring

theorem subsetPolynomial_mask (S : Finset ℕ) (a : ℕ → ℂ) (N : ℕ)
    (hS : S ⊆ Finset.Icc 1 N) (t : ℝ) :
    subsetPolynomial S a t = dirichletPolynomial N (fun n => if n ∈ S then a n else 0) t := by
  classical
  calc
    _ = ∑ n ∈ S, (if n ∈ S then a n else 0)*realPhase (-Real.log n) t := by
      apply Finset.sum_congr rfl
      intro n hn
      simp [hn]
    _ = _ := Finset.sum_subset hS (fun n _ hn => by simp [hn])

theorem coefficientEnergy_mask (S : Finset ℕ) (a : ℕ → ℂ) (N : ℕ)
    (hS : S ⊆ Finset.Icc 1 N) :
    coefficientEnergy (Finset.Icc 1 N) (fun n => if n ∈ S then a n else 0) =
      coefficientEnergy S a := by
  classical
  symm
  calc
    _ = ∑ n ∈ S, ‖if n ∈ S then a n else 0‖^2 := by
      apply Finset.sum_congr rfl
      intro n hn
      simp [hn]
    _ = _ := Finset.sum_subset hS (fun n _ hn => by simp [hn])

theorem subsetPolynomial_mean (S : Finset ℕ) (a : ℕ → ℂ) (N : ℕ)
    (hS : S ⊆ Finset.Icc 1 N) (A B : ℝ) :
    (∫ t : ℝ in A..B, ‖subsetPolynomial S a t‖^2) ≤
      (B-A+2*Real.pi*(N : ℝ))*coefficientEnergy S a := by
  classical
  have h := integral_dirichletPolynomial_norm_sq_le_linear N
    (fun n => if n ∈ S then a n else 0) A B
  simpa only [← subsetPolynomial_mask S a N hS,coefficientEnergy_mask S a N hS] using h

theorem subsetPolynomial_shifted_mean (S : Finset ℕ) (a : ℕ → ℂ) (N : ℕ)
    (hS : S ⊆ Finset.Icc 1 N) (T u : ℝ) (hT : 0 ≤ T) :
    (∫ t in Icc (-T) T, ‖subsetPolynomial S a (t+u)‖^2) ≤
      (2*T+2*Real.pi*(N : ℝ))*coefficientEnergy S a := by
  let b := fun n => a n*realPhase (-Real.log n) u
  have he : coefficientEnergy S b = coefficientEnergy S a := by
    unfold coefficientEnergy b
    simp only [norm_mul,norm_realPhase,mul_one]
  have h := subsetPolynomial_mean S b N hS (-T) T
  rw [intervalIntegral.integral_of_le (by linarith : -T ≤ T),← integral_Icc_eq_integral_Ioc,he] at h
  simp_rw [subsetPolynomial_add S a] at ⊢
  convert h using 1
  ring

theorem gaussian_subset_integrable (S : Finset ℕ) (a : ℕ → ℂ) (T : ℝ) :
    Integrable (fun z : ℝ × ℝ => momentGaussian z.2*‖subsetPolynomial S a (z.1+z.2)‖^2)
      ((volume.restrict (Icc (-T) T)).prod volume) := by
  let μ := volume.restrict (Icc (-T) T)
  have : IsFiniteMeasure μ := by dsimp [μ]; infer_instance
  have hbase : Integrable (fun z : ℝ × ℝ => momentGaussian z.2) (μ.prod volume) := by
    simpa only [one_mul] using (integrable_const (1 : ℝ) (μ := μ)).mul_prod momentGaussian_integrable
  have hc : Continuous (fun z : ℝ × ℝ => momentGaussian z.2*‖subsetPolynomial S a (z.1+z.2)‖^2) :=
    (momentGaussian_continuous.comp continuous_snd).mul
      (((subsetPolynomial_continuous S a).comp (continuous_fst.add continuous_snd)).norm.pow 2)
  apply (hbase.const_mul ((∑ n ∈ S, ‖a n‖)^2)).mono' hc.aestronglyMeasurable
  filter_upwards with z
  rw [Real.norm_eq_abs,abs_of_nonneg (mul_nonneg (momentGaussian_pos z.2).le (sq_nonneg _))]
  have h := pow_le_pow_left₀ (norm_nonneg _) (subsetPolynomial_norm S a (z.1+z.2)) 2
  nlinarith [momentGaussian_pos z.2]

theorem gaussian_subset_fubini (S : Finset ℕ) (a : ℕ → ℂ) (T : ℝ) :
    (∫ t in Icc (-T) T, ∫ u : ℝ, momentGaussian u*‖subsetPolynomial S a (t+u)‖^2) =
      ∫ u : ℝ, momentGaussian u*∫ t in Icc (-T) T, ‖subsetPolynomial S a (t+u)‖^2 := by
  rw [integral_integral_swap (gaussian_subset_integrable S a T)]
  apply integral_congr_ae
  filter_upwards with u
  rw [integral_const_mul]

theorem gaussian_subset_mean (S : Finset ℕ) (a : ℕ → ℂ) (N : ℕ)
    (hS : S ⊆ Finset.Icc 1 N) (T : ℝ) (hT : 0 ≤ T) :
    (∫ t in Icc (-T) T, ∫ u : ℝ, momentGaussian u*‖subsetPolynomial S a (t+u)‖^2) ≤
      (∫ u : ℝ, momentGaussian u)*(2*T+2*Real.pi*(N : ℝ))*coefficientEnergy S a := by
  rw [gaussian_subset_fubini]
  have hi : Integrable (fun u : ℝ => momentGaussian u*
      ∫ t in Icc (-T) T, ‖subsetPolynomial S a (t+u)‖^2) := by
    simpa only [integral_const_mul] using (gaussian_subset_integrable S a T).integral_prod_right
  have hpoint : ∀ᵐ u : ℝ, momentGaussian u*
      (∫ t in Icc (-T) T, ‖subsetPolynomial S a (t+u)‖^2) ≤
        momentGaussian u*((2*T+2*Real.pi*(N : ℝ))*coefficientEnergy S a) := by
    filter_upwards with u
    exact mul_le_mul_of_nonneg_left (subsetPolynomial_shifted_mean S a N hS T u hT)
      (momentGaussian_pos u).le
  exact (integral_mono_ae hi (momentGaussian_integrable.mul_const
    ((2*T+2*Real.pi*(N : ℝ))*coefficientEnergy S a)) hpoint).trans_eq (by
      rw [integral_mul_const]
      ring)

end Legendre.Density.Moment
