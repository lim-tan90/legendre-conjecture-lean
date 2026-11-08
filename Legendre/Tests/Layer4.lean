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


/-- The finite large sieve works with arbitrary complex coefficients at a negative shift. -/
theorem layer4_additive_sieve_shift_consumer (a : Fin 3 → ℂ) :
    (∑ q ∈ Finset.Icc 1 2, ∑ h ∈ LargeSieve.reducedNumerators q,
      ‖LargeSieve.additiveSieveSum a (-17) q h‖^2) ≤ 7*(∑ n, ‖a n‖^2) := by
  convert! LargeSieve.additive_large_sieve 3 2 (-17) a using 1; norm_num

/-- Adjacent unit sampling intervals may meet at an endpoint without being counted twice. -/
theorem layer4_touching_samples_consumer (N : ℕ) (a : ℕ → ℂ) :
    (∑ i : Fin 2, ‖dirichletPolynomial N a (i.val : ℝ)‖^2) ≤
      (2+(Real.log N)^2)*(2+4*(N : ℝ)*(1+Real.log N))*
        coefficientEnergy (Finset.Icc 1 N) a := by
  have h := sum_dirichletPolynomial_samples_le (Finset.univ : Finset (Fin 2))
    (fun i => (i.val : ℝ)) N a (δ := 1) (L := 0) (U := 2) (by norm_num) (by norm_num)
    (by intro i hi; fin_cases i <;> norm_num)
    (by intro i hi j hj hij; fin_cases i <;> fin_cases j <;> norm_num at *)
  convert! h using 1; norm_num

/-- No positive large sample can come from the zero polynomial. -/
theorem layer4_zero_large_samples_consumer {ι : Type*} (s : Finset ι) (t : ι → ℝ)
    (a : ℕ → ℂ) {δ L U V : ℝ} (hδ : 0 < δ) (hLU : L ≤ U) (hV : 0 < V)
    (hinside : ∀ i ∈ s, L ≤ t i ∧ t i+δ ≤ U)
    (hsep : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → δ ≤ |t i-t j|)
    (hlarge : ∀ i ∈ s, V ≤ ‖dirichletPolynomial 0 a (t i)‖) : s = ∅ := by
  have h := dirichlet_large_sample_card_le s t 0 a hδ hLU hV hinside hsep hlarge
  simp only [coefficientEnergy, Finset.Icc_eq_empty_of_lt (by norm_num : (0 : ℕ) < 1),
    Finset.sum_empty, mul_zero, zero_div] at h
  apply Finset.card_eq_zero.1
  exact Nat.eq_zero_of_le_zero (by exact_mod_cast h)

/-- The n=1 term has derivative zero, with no nonvanishing assumption on its coefficient. -/
theorem layer4_constant_derivative_consumer (a : ℕ → ℂ) (t : ℝ) :
    HasDerivAt (dirichletPolynomial 1 a) 0 t := by
  convert! dirichletPolynomial_hasDerivAt 1 a t using 1
  simp [dirichletPolynomial, exponentialSum, dirichletDerivativeCoefficients]

/-- Phase normalization agrees at a half-turn: n=1, x=1/2 yields -1. -/
theorem layer4_phase_normalization_consumer :
    realPhase (2*Real.pi*(1/2)) 1 = (-1 : ℂ) := by
  rw [show (2 : ℝ)*Real.pi*(1/2) = Real.pi by ring]
  norm_num [realPhase, Complex.exp_ofReal_mul_I]


/-- Coincident ordinates cluster into one representative while their natural weights are retained. -/
theorem layer4_weighted_cluster_consumer : ∃ r : Finset (Fin 2), r.card = 1 ∧
    (14 : ℝ) ≤ 28*(r.card : ℝ) := by
  have hlocal (t : ℝ) :
      ((∑ i ∈ (Finset.univ : Finset (Fin 2)).filter (fun _i => |(0 : ℝ)-t| ≤ 1/2),
        (7 : ℕ) : ℕ) : ℝ) ≤ 14 := by
    by_cases ht : |t| ≤ 1/2
    · norm_num [ht,abs_neg]
    · norm_num [ht,abs_neg]
  obtain ⟨r,_hrs,hsep,hcount⟩ := exists_weighted_separated_representatives
    (Finset.univ : Finset (Fin 2)) (fun _ => (0 : ℝ)) (fun _ => 7) hlocal
  have hone : r.card ≤ 1 := by
    apply Finset.card_le_one.2
    intro i hi j hj
    by_contra hne
    have h := hsep i hi j hj hne
    norm_num at h
  norm_num at hcount
  have hpos : 1 ≤ r.card := by
    by_contra h
    have he : r.card = 0 := by omega
    rw [he] at hcount
    norm_num at hcount
  exact ⟨r,by omega,hcount⟩

/-- A zero-length positive-threshold detector forces the entire weighted density count to vanish. -/
theorem layer4_zero_detector_consumer (σ : ℝ) {T : ℝ} (hT : 7 ≤ T)
    {V : ℝ} (hV : 0 < V)
    (hdetect : ∀ ρ : ℂ, ρ ∈ Zeta.zerosRightOf σ T →
      V ≤ ‖dirichletPolynomial 0 (fun _ => 1) ρ.im‖) : Zeta.zeroDensityCount σ T = 0 := by
  have h := Zeta.zeroDensityCount_le_of_dirichlet_detector σ hT 0 (fun _ => 1) hV hdetect
  simp only [coefficientEnergy, Finset.Icc_eq_empty_of_lt (by norm_num : (0 : ℕ) < 1),
    Finset.sum_empty, mul_zero, zero_div] at h
  exact Nat.eq_zero_of_le_zero (by exact_mod_cast h)

/-- The sharp theorem also controls reversed intervals and keeps its exact constant. -/
theorem layer4_sharp_reversed_interval_consumer :
    |(∫ t : ℝ in (10 : ℝ)..(-10 : ℝ),
      ‖dirichletPolynomial 2 (fun _ => 1) t‖^2)+40| ≤ 8*Real.pi := by
  have h := abs_integral_dirichletPolynomial_sub_diagonal_le_linear 2 (fun _ => 1) 10 (-10)
  norm_num [coefficientEnergy,Finset.sum_Icc_succ_top] at h
  convert! h using 1
  ring

/-- Optimized sampling still permits touching unit sampling intervals. -/
theorem layer4_sharp_touching_samples_consumer :
    (∑ i : Fin 2, ‖dirichletPolynomial 2 (fun _ => 1) (i.val : ℝ)‖^2) ≤
      (1+2*Real.log 2)*(2+4*Real.pi)*2 := by
  have h := sum_dirichletPolynomial_samples_le_linear_log Finset.univ
    (fun i : Fin 2 => (i.val : ℝ)) 2 (fun _ => 1) (by norm_num)
    (δ := 1) (L := 0) (U := 2) (by norm_num) (by norm_num)
    (by intro i hi; fin_cases i <;> norm_num)
    (by intro i hi j hj hij; fin_cases i <;> fin_cases j <;> norm_num at *)
  norm_num [coefficientEnergy,Finset.sum_Icc_succ_top] at h
  rw [show (2 : ℝ)+2*Real.pi*2 = 2+4*Real.pi by ring] at h
  simpa [Fin.sum_univ_two] using! h

/-- Zero energy cannot detect any counted zero at a positive threshold. -/
theorem layer4_sharp_zero_energy_detector_consumer (σ : ℝ) {T : ℝ} (hT : 7 ≤ T)
    (hdetect : ∀ ρ : ℂ, ρ ∈ Zeta.zerosRightOf σ T →
      1 ≤ ‖dirichletPolynomial 2 (fun _ => 0) ρ.im‖) :
    Zeta.zeroDensityCount σ T = 0 := by
  have h := Zeta.zeroDensityCount_le_of_dirichlet_detector_linear_log σ hT 2
    (fun _ => 0) (by norm_num) (by norm_num : (0 : ℝ) < 1) hdetect
  simp only [coefficientEnergy,norm_zero,zero_pow (by norm_num : (2 : ℕ) ≠ 0),
    Finset.sum_const_zero,mul_zero,zero_div] at h
  exact_mod_cast le_antisymm h (Nat.cast_nonneg (Zeta.zeroDensityCount σ T) :
    (0 : ℝ) ≤ Zeta.zeroDensityCount σ T)

end Legendre.Tests
