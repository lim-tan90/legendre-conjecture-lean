/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

import Legendre.Layer4

/-!
# Independent consumers of the initial Layer 4 interface

The empty/singleton/two-term cases, coincident frequencies, translated
intervals, positive large-value thresholds, and uniform density conventions
are checked using only an ordinary import of the public facade.
-/

namespace Legendre.Tests

open Density MeasureTheory Filter Topology

/-- Empty polynomials contribute exactly zero, without a positive-length assumption. -/
theorem layer4_empty_consumer (a : ℕ → ℂ) (A B : ℝ) :
    (∫ t : ℝ in A..B, ‖dirichletPolynomial 0 a t‖^2) = 0 := by
  simp [dirichletPolynomial, exponentialSum]

/-- The index n=1 has zero frequency and gives exactly the energy diagonal. -/
theorem layer4_singleton_consumer (a : ℕ → ℂ) (A B : ℝ) :
    (∫ t : ℝ in A..B, ‖dirichletPolynomial 1 a t‖^2) = (B-A)*‖a 1‖^2 := by
  simp [dirichletPolynomial, exponentialSum, realPhase]

/-- Two distinct logarithmic frequencies give a concrete endpoint-independent error of 24. -/
theorem layer4_two_term_consumer (A B : ℝ) :
    |(∫ t : ℝ in A..B, ‖dirichletPolynomial 2 (fun _ => 1) t‖^2)-2*(B-A)| ≤ 24 := by
  have h := abs_integral_dirichletPolynomial_sub_diagonal_le 2 (fun _ => 1) A B
  norm_num [coefficientEnergy, harmonic, Finset.sum_Icc_succ_top] at h
  simpa only [mul_comm] using! h

/-- Coincident frequencies must retain their cross term; their squared amplitude is four. -/
theorem layer4_coincident_frequency_consumer (A B : ℝ) :
    (∫ t : ℝ in A..B,
      ‖exponentialSum ({0,1} : Finset ℕ) (fun _ => 1) (fun _ => 0) t‖^2) = 4*(B-A) := by
  norm_num [exponentialSum, realPhase, intervalIntegral.integral_const]
  ring

/-- Positive-threshold large-value bounds work on an interval containing negative times. -/
theorem layer4_large_values_consumer (N : ℕ) (a : ℕ → ℂ) :
    (volume.restrict (Set.Ioc (-10 : ℝ) 10)).real
        {t : ℝ | 2 ≤ ‖dirichletPolynomial N a t‖} ≤
      ((20+4*(N : ℝ)*(1+Real.log N))*coefficientEnergy (Finset.Icc 1 N) a)/4 := by
  convert! dirichlet_large_values_measure_le N a
    (by norm_num : (-10 : ℝ) ≤ 10) (by norm_num : (0 : ℝ) < 2) using 1; norm_num

/-- The long-interval mean is the exact energy, including arbitrary complex coefficients. -/
theorem layer4_mean_limit_consumer (N : ℕ) (a : ℕ → ℂ) :
    Tendsto (fun T : ℝ => (∫ t : ℝ in 0..T, ‖dirichletPolynomial N a t‖^2)/T)
      atTop (𝓝 (∑ n ∈ Finset.Icc 1 N, ‖a n‖^2)) :=
  tendsto_dirichletPolynomial_mean_square N a

/-- The rational near-one cutoff uses a fixed compact count, rather than a height-dependent one. -/
theorem layer4_near_one_count_consumer :
    Zeta.zeroDensityCount (1-1/(4000000*Real.log 10)) 10 ≤ Zeta.zeroCount 3 :=
  Zeta.zeroDensityCount_rational_near_one (by norm_num)

/-- Even a high logarithmic loss can be absorbed uniformly into a small fixed T-power. -/
theorem layer4_log_loss_consumer : ∃ D > 0, ∀ T : ℝ, 2 ≤ T →
    (Real.log T)^44 ≤ D*T^((1 : ℝ)/100) :=
  Zeta.exists_log_pow_le_rpow 44 (by norm_num)

/-- Exponent weakening consumes a hypothesis and does not assert the density hypothesis. -/
theorem layer4_density_weaken_consumer (h : Zeta.HasZeroDensityEstimate 2) :
    Zeta.HasZeroDensityEstimate (12/5) := h.mono (by norm_num)

end Legendre.Tests
