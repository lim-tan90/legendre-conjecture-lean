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

/-- A minimal nontrivial mollifier has a surviving upper endpoint coefficient. -/
theorem layer4_mollifier_endpoint_consumer (s : ℂ) :
    Detector.detectorPolynomial 2 2 s = -(4 : ℂ)^(-s) := by
  have h := Detector.finite_mollifier_identity (X := 2) (N := 2) (by norm_num) (by norm_num) s
  have hm : Detector.finiteSeries (ArithmeticFunction.moebius : ArithmeticFunction ℂ) 2 s =
      1-(2 : ℂ)^(-s) := by
    norm_num [Detector.finiteSeries,Finset.sum_Icc_succ_top,
      ArithmeticFunction.intCoe_apply,ArithmeticFunction.moebius_apply_prime Nat.prime_two]
    ring
  have hz : Detector.finiteSeries (ArithmeticFunction.zeta : ArithmeticFunction ℂ) 2 s =
      1+(2 : ℂ)^(-s) := by
    rw [Detector.finiteSeries_zeta_eq]
    norm_num [Finset.sum_Icc_succ_top]
  rw [hm,hz] at h
  have hp : (2 : ℂ)^(-s)*(2 : ℂ)^(-s) = (4 : ℂ)^(-s) := by
    convert! (Complex.natCast_mul_natCast_cpow 2 2 (-s)).symm using 1
    norm_num
  linear_combination -h-hp

/-- The finite Euler formula at cutoff one agrees with the earlier centered formula. -/
theorem layer4_euler_cutoff_one_consumer {s : ℂ} (hs : 0 < s.re) (hs1 : s ≠ 1) :
    riemannZeta s = 1/(s-1)+(1/2 : ℂ)-s*Zeta.zetaEulerTail 1 s := by
  have h := Zeta.riemannZeta_eq_finite_euler (N := 1) (by norm_num) hs hs1
  norm_num at h
  convert! h using 1
  ring

/-- Actual counted zeros trigger the detector alternative through the public interface. -/
theorem layer4_actual_zero_detector_consumer {H : ℕ} (hH : 1 ≤ H) {σ : ℝ}
    (hσ : 1/2 ≤ σ) {ρ : ℂ} (hρ : ρ ∈ Zeta.zerosRightOf σ H) :
    3/8 ≤ ‖Detector.detectorPolynomial 2 (Detector.zetaDetectorLength H 2) ρ‖ ∨
      3/8 ≤ ‖Detector.poleCompensation 2 (Detector.zetaDetectorLength H 2) ρ‖ := by
  have hρ1 : ρ ≠ 1 := by
    intro he
    have hh := hρ.1.1.2.2
    simp only [he,Complex.one_re,lt_self_iff_false] at hh
  exact Detector.actual_zero_detector_alternative hH (by norm_num) hρ.1.1.1 hρ1
    (hσ.trans hρ.2) hρ.1.1.2.2.le (by rw [abs_of_pos hρ.1.2.1]; exact hρ.1.2.2)

/-- Two distinct real parts, including both strip boundaries, are permitted. -/
theorem layer4_varying_real_parts_consumer (a : ℕ → ℂ) :
    (∑ i : Fin 2, ‖complexDirichletPolynomial 2 a
      (((if i = 0 then (1/2 : ℝ) else 1) : ℂ)+(i.val : ℂ)*Complex.I)‖^2) ≤
      (2+(Real.log 2)^2)*(1+2*Real.log 2)*(2+4*Real.pi)*
        coefficientEnergy (Finset.Icc 1 2) (verticalCoefficients a (1/2)) := by
  have h := sum_complexDirichletPolynomial_samples_le Finset.univ
    (fun i : Fin 2 => (i.val : ℝ)) (fun i : Fin 2 => if i = 0 then (1/2 : ℝ) else 1)
    2 a (by norm_num) (δ := 1) (L := 0) (U := 2) (σ := 1/2) (b := 1)
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)
    (by intro i hi; fin_cases i <;> norm_num)
    (by intro i hi; fin_cases i <;> norm_num)
    (by intro i hi j hj hij; fin_cases i <;> fin_cases j <;> norm_num at *)
  norm_num only [inv_one,sub_zero,Complex.ofReal_natCast] at h
  rw [show (2 : ℝ)+2*Real.pi*2 = 2+4*Real.pi by ring] at h
  exact h

/-- The Möbius-energy theorem also handles the empty polynomial at the critical line. -/
theorem layer4_empty_mollifier_energy_consumer :
    coefficientEnergy (Finset.Icc 1 0)
      (verticalCoefficients (ArithmeticFunction.moebius : ArithmeticFunction ℂ) (1/2)) ≤ 1 := by
  simpa only [Nat.cast_zero,Real.log_zero,add_zero] using
    Detector.mollifier_vertical_energy_le 0 (by norm_num : (1/2 : ℝ) ≤ 1/2)

/-- The full density bound restores multiplicities without any detector hypothesis. -/
theorem layer4_actual_density_consumer {H : ℕ} (hH : 7 ≤ H) :
    (Zeta.zeroDensityCount (3/4) H : ℝ) ≤ (Zeta.zeroCount 1 : ℝ)+
      2*Zeta.densitySelectionConstant*Real.log H*Detector.actualDetectorSampleBound H 2 (3/4) :=
  Zeta.zeroDensityCount_le_actual_detector hH (by norm_num) (by norm_num) (by norm_num)

/-- Absence of high zeros retains the low-height multiplicity contribution. -/
theorem layer4_low_height_retained_consumer (σ : ℝ) {T : ℝ} (hT : 7 ≤ T)
    (hnoHigh : ∀ ρ : ℂ, ρ ∈ Zeta.zerosRightOf σ T → ρ.im < 1) :
    Zeta.zeroDensityCount σ T ≤ Zeta.zeroCount 1 := by
  have h := Zeta.zeroDensityCount_le_of_high_sample_bound σ (B := 0) hT (by
    intro S hS hheight _hsep
    have he : S = ∅ := by
      apply Finset.eq_empty_iff_forall_notMem.2
      intro ρ hρ
      exact (not_le_of_gt (hnoHigh ρ (hS ρ hρ))) (hheight ρ hρ)
    simp [he])
  simp only [mul_zero,add_zero] at h
  exact_mod_cast h

/-- Removing the two completed poles retains finite nonzero endpoint values. -/
theorem layer4_xi_pole_values_consumer : Zeta.zetaXi 0 = 1 ∧ Zeta.zetaXi 1 = 1 := by
  simp

/-- Purely imaginary Gamma shifts incur no base-height power. -/
theorem layer4_gamma_vertical_shift_consumer (t u : ℝ) :
    ‖Complex.Gammaℝ ((1/2 : ℂ)+(t+u : ℝ)*Complex.I)/
      Complex.Gammaℝ ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖ ≤
        Real.exp ((59+|Real.eulerMascheroniConstant|)*(1+|u|)) := by
  have h := GammaBounds.sharp_gammaReal_shift
    ((1/2 : ℂ)+(t : ℂ)*Complex.I) ((u : ℂ)*Complex.I)
    (by norm_num) (by norm_num) (by simp) (by simp)
  have he : (1/2 : ℂ)+(t : ℂ)*Complex.I+(u : ℂ)*Complex.I =
      (1/2 : ℂ)+(t+u : ℝ)*Complex.I := by push_cast; ring
  rw [he] at h
  simpa using h

/-- The normalized xi kernel is exactly one at zero shift on the critical line. -/
theorem layer4_xi_kernel_zero_shift_consumer (t : ℝ) :
    Zeta.xiSquareKernelWeight ((1/2 : ℂ)+(t : ℂ)*Complex.I) 0 = 1 := by
  let s : ℂ := (1/2 : ℂ)+(t : ℂ)*Complex.I
  have hs : s.re = 1/2 := by simp [s]
  have hs0 : s ≠ 0 := by intro he; simp [he] at hs
  have hs1 : s-1 ≠ 0 := by
    intro he
    have hh := sub_eq_zero.1 he
    simp [hh] at hs
  have hg : Complex.Gammaℝ s ≠ 0 := Complex.Gammaℝ_ne_zero_of_re_pos (by rw [hs]; norm_num)
  change Zeta.xiSquareKernelWeight s 0 = 1
  simp [Zeta.xiSquareKernelWeight,GammaBounds.gammaSquareGaussianWeight,
    mul_ne_zero hs0 hs1,hg]

/-- The residue formula includes the removed completed pole s=0. -/
theorem layer4_xi_rectangle_pole_consumer :
    Zeta.xiRectangleIntegral (Zeta.xiSquareContour 0) (-1) 1 (-2) 2 =
      2*(Real.pi : ℂ)*Complex.I := by
  simpa using Zeta.xiSquareGaussian_rectangle 0 (-1) 1 (-2) 2
    (by norm_num) (by norm_num) (by norm_num) (by norm_num)

/-- At the real critical point reflection makes the two contours equal. -/
theorem layer4_xi_real_center_consumer :
    Zeta.zetaXi (1/2)^2 = 2*Zeta.xiSquareIntegral (1/2) := by
  have h := Zeta.zetaXi_square_equation (1/2) (by norm_num)
  norm_num at h ⊢
  linear_combination h

/-- The fourth-power reduction holds at every positive or negative ordinate. -/
theorem layer4_zeta_fourth_reduction_consumer (t : ℝ) :
    ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4 ≤
      4*‖Zeta.xiSmoothedZetaSquare ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^2 :=
  Zeta.riemannZeta_fourth_le_smoothed _ (by simp)

/-- Entire xi conjugation includes both removed poles. -/
theorem layer4_xi_conjugation_endpoints_consumer :
    Zeta.zetaXi (starRingEnd ℂ 0) = starRingEnd ℂ (Zeta.zetaXi 0) ∧
    Zeta.zetaXi (starRingEnd ℂ 1) = starRingEnd ℂ (Zeta.zetaXi 1) :=
  ⟨Zeta.zetaXi_conj 0,Zeta.zetaXi_conj 1⟩

/-- The harmonic divisor energy includes the empty cutoff. -/
theorem layer4_divisor_energy_zero_consumer :
    (∑ n ∈ Finset.Icc 1 (0 : ℕ), (n.divisors.card : ℝ)^2/n) ≤ 1 := by
  simp

/-- The smallest nonempty head has exactly unit coefficient energy. -/
theorem layer4_divisor_energy_one_consumer :
    (∑ n ∈ Finset.Icc 1 1,
      ‖verticalCoefficients Zeta.zetaSquareCoefficient (1/2 : ℝ) n‖^2) = 1 := by
  norm_num [verticalCoefficients,Zeta.zetaSquareCoefficient]

/-- Translation does not alter the coefficient energy or add an ordinate loss. -/
theorem layer4_translated_subset_mean_consumer (a : ℕ → ℂ) (u T : ℝ) (hT : 0 ≤ T) :
    (∫ t in Set.Icc (-T) T, ‖Moment.subsetPolynomial {1} a (t+u)‖^2) ≤
      (2*T+2*Real.pi)*‖a 1‖^2 := by
  have h := Moment.subsetPolynomial_shifted_mean {1} a 1 (by simp) T u hT
  simpa [coefficientEnergy] using h

/-- The n=0 term is exactly zero, including before the series limit. -/
theorem layer4_smoothed_zero_term_consumer (t : ℝ) :
    Zeta.xiSquareIntegralTerm ((1/2 : ℂ)+(t : ℂ)*Complex.I) 0 = 0 := by simp

/-- The moment theorem includes its smallest permitted height. -/
theorem layer4_fourth_moment_height_two_consumer :
    ∃ C : ℝ, 0 < C ∧
      (∫ t : ℝ in 0..2, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ≤
        C*2*(Real.log 2)^6 := by
  obtain ⟨C,hC,h⟩ := Zeta.zeta_fourth_moment_positive_log_six
  exact ⟨C,hC,h 2 (by norm_num)⟩

/-- A concrete height exponent follows without any density hypothesis. -/
theorem layer4_fourth_moment_exponent_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (∫ t : ℝ in 0..T, ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ≤ C*T^(5/4 : ℝ) := by
  have h := Zeta.zeta_fourth_moment_epsilon (1/4) (by norm_num)
  norm_num at h
  exact h

/-- The compact smoothing weight vanishes exactly at its support endpoint. -/
theorem layer4_compact_weight_endpoint_consumer :
    Detector.Smooth.detectorWeight 1 = 0 ∧ Detector.Smooth.detectorWeight 2 = 0 :=
  ⟨Detector.Smooth.detectorWeight_zero 1 le_rfl,
    Detector.Smooth.detectorWeight_zero 2 (by norm_num)⟩

/-- The first nontrivial smoothing cutoff retains its exact main coefficient. -/
theorem layer4_compact_head_consumer (s : ℂ) :
    Detector.Smooth.detectorMean 4 s 4 = 9/32 := by
  rw [Detector.Smooth.detectorMean_split 4 (by norm_num) s 4 (by norm_num)]
  have he : (Finset.Icc 1 4).filter (fun n : ℕ => 4 < n) = ∅ := by
    ext n
    simp only [Finset.mem_filter,Finset.mem_Icc,Finset.notMem_empty,iff_false]
    omega
  norm_num [Detector.Smooth.detectorWeight]
  rw [he,Finset.sum_empty]

/-- Cutoff one has empty smoothed support, even with a nonempty Mobius head. -/
theorem layer4_compact_cutoff_one_consumer (X : ℕ) (s : ℂ) :
    Detector.Smooth.detectorMean X s 1 = 0 := by
  simp [Detector.Smooth.detectorMean,Detector.Smooth.detectorWeight]

/-- The initial contour formula holds on Re(s)=0, including the empty mollifier. -/
theorem layer4_compact_initial_contour_consumer (Y : ℝ) (hY : 0 < Y) :
    Detector.Smooth.detectorMean 0 0 Y = ((1/(2*Real.pi) : ℝ) : ℂ)*
      ∫ t : ℝ, riemannZeta (2+(t : ℂ)*Complex.I)*
        Detector.finiteSeries (ArithmeticFunction.moebius : ArithmeticFunction ℂ) 0
          (2+(t : ℂ)*Complex.I)*
        (Y : ℂ)^(2+(t : ℂ)*Complex.I)*Detector.Smooth.detectorKernel (2+(t : ℂ)*Complex.I) := by
  simpa using Detector.Smooth.detectorMean_eq_integral 0 0 (by simp) Y hY

/-- The critical-side kernel bound includes the extreme shift delta=1/2. -/
theorem layer4_compact_left_endpoint_consumer (u : ℝ) :
    ‖Detector.Smooth.detectorKernel ((-(1/2 : ℝ) : ℂ)+(u : ℂ)*Complex.I)‖ ≤
      32*(1+|u|)^(-(3 : ℝ)) := by
  convert! Detector.Smooth.detectorKernel_left_bound (1/2) u (by norm_num) le_rfl using 1; norm_num

/-- Empty Mobius truncation has no principal-pole contribution, at any center. -/
theorem layer4_principal_pole_empty_consumer (s : ℂ) (Y : ℝ) :
    Detector.Smooth.detectorPrincipalPole 0 s Y = 0 := by
  simp [Detector.Smooth.detectorPrincipalPole,Detector.finiteSeries]

/-- The actual principal-pole coefficient generally is nonzero. -/
theorem layer4_principal_pole_nonzero_consumer (t : ℝ) :
    Detector.Smooth.detectorPrincipalPole 1 ((3/4 : ℂ)+(t : ℂ)*Complex.I) 1 ≠ 0 := by
  norm_num [Detector.Smooth.detectorPrincipalPole,Detector.finiteSeries,
    Detector.Smooth.detectorKernel,Complex.ext_iff]

/-- The small-pole estimate includes the exact height and cutoff endpoints. -/
theorem layer4_principal_pole_height64_consumer :
    ‖Detector.Smooth.detectorPrincipalPole 256 ((1/2 : ℂ)+(64 : ℂ)*Complex.I) 4096‖ ≤ 1/16 := by
  apply Detector.Smooth.detectorPrincipalPole_small 256 _ (T := 64)
  all_goals norm_num

/-- The shifted mean keeps the principal residue with a positive sign. -/
theorem layer4_compensated_mean_consumer (X : ℕ) (t : ℝ)
    (hz : riemannZeta ((3/4 : ℂ)+(t : ℂ)*Complex.I) = 0) :
    Detector.Smooth.detectorMean X ((3/4 : ℂ)+(t : ℂ)*Complex.I) 4 =
      Detector.Smooth.detectorPrincipalPole X ((3/4 : ℂ)+(t : ℂ)*Complex.I) 4+
        Detector.Smooth.detectorCriticalIntegral X ((3/4 : ℂ)+(t : ℂ)*Complex.I) 4 := by
  apply Detector.Smooth.detectorMean_at_zero X _ hz
  all_goals norm_num [Complex.ext_iff]

/-- Both ordinate signs are included in the genuine high-zero alternative. -/
theorem layer4_compact_high_zero_consumer (t : ℝ) (ht : 64 ≤ |t|)
    (hz : riemannZeta ((3/4 : ℂ)+(t : ℂ)*Complex.I) = 0) :
    (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorTail 64 ((3/4 : ℂ)+(t : ℂ)*Complex.I) 64‖ ∨
      (1/16 : ℝ) ≤ ‖Detector.Smooth.detectorCriticalIntegral 64 ((3/4 : ℂ)+(t : ℂ)*Complex.I) 64‖ := by
  exact Detector.Smooth.detector_high_zero_dichotomy 64 (by norm_num)
    (by norm_num [Complex.ext_iff]) hz (by norm_num) (by norm_num)
    (T := 64) (by norm_num) (by simpa using ht) (by norm_num) (by norm_num) (by norm_num)

/-- The cubic critical mass is genuinely integrable, including at ordinate zero. -/
theorem layer4_critical_mass_integrable_consumer :
    Integrable (fun u : ℝ => Detector.Smooth.criticalWeight u*
      ‖Detector.Smooth.criticalProduct 1 0 u‖) :=
  Detector.Smooth.criticalProduct_weighted_integrable 1 0

/-- The whole-line weight retains unit mass at ordinate zero, for every scale. -/
theorem layer4_height_weight_origin_consumer (T : ℝ) : Moment.momentHeightWeight T 0 = 1 := by
  simp [Moment.momentHeightWeight,Detector.Smooth.criticalWeight]

/-- Zero height is excluded from the shell-cover theorem for a reason. -/
theorem layer4_height_shell_zero_scale_consumer :
    (⋃ j : ℕ, Moment.momentHeightShell 0 j) = ({0} : Set ℝ) := by
  ext x
  constructor
  · intro hx
    obtain ⟨j,hj⟩ := Set.mem_iUnion.mp hx
    have hB := Moment.momentHeightShell_subset 0 j hj
    simpa [Moment.momentHeightBall] using hB
  · intro hx
    apply Set.mem_iUnion.mpr
    refine ⟨0,?_⟩
    simpa [Moment.momentHeightShell,Moment.momentHeightBall] using hx

/-- Adjacent ordinates achieve the permitted unit separation. -/
theorem layer4_cubic_kernel_adjacent_consumer (v : ℝ) :
    (∑ x ∈ ({0,1} : Finset ℝ), Detector.Smooth.criticalWeight (v-x)) ≤ 1+4*Real.pi^2/3 := by
  apply Moment.criticalWeight_separated_sum
  intro x hx y hy hxy
  simp only [Finset.mem_insert,Finset.mem_singleton] at hx hy
  rcases hx with rfl | rfl <;> rcases hy with rfl | rfl <;> norm_num at *

/-- The exact lower height bound is covered by the weighted fourth moment. -/
theorem layer4_weighted_fourth_height_two_consumer :
    ∃ C : ℝ, 0 < C ∧ Integrable (fun t : ℝ => Moment.momentHeightWeight 2 t*
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ∧
      (∫ t : ℝ, Moment.momentHeightWeight 2 t*
        ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ≤ C*2*(Real.log 2)^6 := by
  obtain ⟨C,hC,h⟩ := Moment.weighted_zeta_fourth_moment
  exact ⟨C,hC,h 2 (by norm_num)⟩

/-- Cutoff one is included in the weighted Mobius second moment. -/
theorem layer4_weighted_mollifier_one_consumer :
    ∃ C : ℝ, 0 < C ∧
      (∫ t : ℝ, Moment.momentHeightWeight 2 t*
        ‖Detector.finiteSeries (ArithmeticFunction.moebius : ArithmeticFunction ℂ) 1
          ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^2) ≤ 3*C := by
  obtain ⟨C,hC,h⟩ := Moment.weighted_mollifier_mean
  refine ⟨C,hC,?_⟩
  have hh := (h 1 le_rfl 2 (by norm_num)).2
  norm_num at hh
  nlinarith

/-- The packed critical mass is bounded even for a single point at height zero. -/
theorem layer4_packed_mass_singleton_consumer :
    ∃ C : ℝ, 0 < C ∧ Detector.Smooth.criticalMass 1 0^4 ≤ C*18*(Real.log 2)^6 := by
  obtain ⟨C,hC,h⟩ := Moment.packed_critical_mass_fourth
  refine ⟨C,hC,?_⟩
  have hh := h 1 le_rfl 2 (by norm_num) ({0} : Finset ℝ) id
    (by intro i hi; simp only [Finset.mem_singleton] at hi; subst i; norm_num)
    (by intro i hi j hj hij; simp_all)
  norm_num at hh
  nlinarith

/-- The dyadic cover includes its top boundary and excludes the retained low range. -/
theorem layer4_shell_boundary_consumer :
    ∃ j ∈ Finset.range 1, 64*(2 : ℝ)^j < 128 ∧ 128 ≤ 128*(2 : ℝ)^j := by
  exact Moment.height_shell_mem 1 128 (by norm_num) (by norm_num)

/-- The balance at sigma=3/4 has the claimed height and density powers. -/
theorem layer4_ingham_balance_consumer :
    Moment.detectorBalanceExponent (3/4) = 6/5 ∧
      Moment.balancedDensityExponent (3/4) = 3/5 := by
  norm_num [Moment.detectorBalanceExponent,Moment.balancedDensityExponent]

/-- Actual counts at sigma=3/4 have exponent 3/5+1/100, without a density hypothesis. -/
theorem layer4_ingham_three_quarters_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (Zeta.zeroDensityCount (3/4) T : ℝ) ≤ C*T^(61/100 : ℝ) := by
  obtain ⟨C,hC,h⟩ := Zeta.ingham_density_epsilon (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro T hT
  convert! h (3/4) (by norm_num) T hT using 1 <;> norm_num

/-- The included critical-line endpoint has exponent one plus epsilon. -/
theorem layer4_ingham_critical_line_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (Zeta.zeroDensityCount (1/2) T : ℝ) ≤ C*T^(101/100 : ℝ) := by
  obtain ⟨C,hC,h⟩ := Zeta.ingham_density_epsilon (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro T hT
  convert! h (1/2) (by norm_num) T hT using 1 <;> norm_num

/-- The lower height endpoint retains the SAME constant for every sigma. -/
theorem layer4_ingham_height_two_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Set.Icc (1/2 : ℝ) 1,
      (Zeta.zeroDensityCount σ 2 : ℝ) ≤ C*2^(3*(1-σ)/(2-σ)+(1/100 : ℝ)) := by
  obtain ⟨C,hC,h⟩ := Zeta.ingham_density_epsilon (1/100) (by norm_num)
  exact ⟨C,hC,fun σ hσ => h σ hσ 2 (by norm_num)⟩

/-- The proved curved theorem supplies a closed linear density input as well. -/
theorem layer4_density_three_consumer : Zeta.HasZeroDensityEstimate 3 :=
  Zeta.hasZeroDensityEstimate_three

/-- Alternating phases have a bound independent of the number of samples. -/
theorem layer4_first_derivative_phase_consumer (N : ℕ) :
    ‖∑ n ∈ Finset.range (N+1), Oscillation.Tools.ExponentialSum.phase ((n : ℝ)/2)‖ ≤ 4 := by
  have hh := Oscillation.Tools.ExponentialSum.first_derivative_sum_bound_succ
    (fun n : ℕ => (n : ℝ)/2) N (1/2) (by norm_num)
    (by intro i hi; push_cast; linarith)
    (by intro i hi; push_cast; linarith)
    (by intro i hi j hj hij; dsimp only; push_cast; linarith)
  convert! hh using 1 <;> norm_num

/-- Negative ordinates use the same actual first-derivative bound. -/
theorem layer4_log_negative_height_consumer :
    ‖∑ n ∈ (Finset.Ioc 4 8 : Finset ℕ), (n : ℂ)^(-(-3 : ℂ)*Complex.I)‖ ≤ 16*Real.pi := by
  have hh := Oscillation.logarithmic_block_first_abs 4 8 (by norm_num) (by norm_num)
    (-3) (by norm_num) (by norm_num)
  convert! hh using 1 <;> norm_num <;> ring

/-- The dyadic boundary V=U is genuinely the empty block. -/
theorem layer4_log_empty_block_consumer (t : ℝ) :
    Oscillation.blockDirichletPolynomial 4 4 (fun _ => 1) t = 0 := by
  simp [Oscillation.blockDirichletPolynomial]

/-- Both signs attain the complete harmonic row at the smallest height. -/
theorem layer4_reciprocal_height_one_consumer :
    (∑ x ∈ ({-1,1} : Finset ℝ), 1/|x|) ≤ 2 := by
  have hh := Oscillation.separated_reciprocals ({-1,1} : Finset ℝ) 1 le_rfl
    (by intro x hx; simp only [Finset.mem_insert,Finset.mem_singleton] at hx
        rcases hx with rfl | rfl <;> norm_num)
    (by intro x hx; simp only [Finset.mem_insert,Finset.mem_singleton] at hx
        rcases hx with rfl | rfl <;> norm_num)
    (by intro x hx y hy hxy; simp only [Finset.mem_insert,Finset.mem_singleton] at hx hy
        rcases hx with rfl | rfl <;> rcases hy with rfl | rfl <;> norm_num at *)
  simpa only [Real.log_one,add_zero,mul_one] using hh

/-- The analytic energy bound applies at exactly unit-separated touching ordinates. -/
theorem layer4_halasz_two_samples_consumer (a : ℕ → ℂ) :
    (∑ i : Fin 2, ‖Oscillation.blockDirichletPolynomial 1 2 a ((i.val : ℝ)-1/2)‖^2) ≤
      Oscillation.halaszBlockCoefficient 1 1 2*coefficientEnergy (Finset.Ioc 1 2) a := by
  have hh := Oscillation.halasz_block_energy (fun i : Fin 2 => (i.val : ℝ)-1/2)
    1 2 (by norm_num) (by norm_num) (by norm_num) a 1 le_rfl
    (by intro i; fin_cases i <;> norm_num)
    (by intro i j hij; fin_cases i <;> fin_cases j <;> norm_num at *)
  simpa only [Fintype.card_fin,Nat.cast_ofNat] using hh

/-- Mixed real parts, including the endpoint one, use the ACTUAL analytic kernel. -/
theorem layer4_halasz_mixed_real_parts_consumer (a : ℕ → ℂ) :
    (∑ i ∈ (Finset.univ : Finset (Fin 2)),
      ‖∑ n ∈ Finset.Ioc 1 2, a n*(n : ℂ)^(-((((1/2 : ℝ)+(i.val : ℝ)/2 : ℝ) : ℂ)+
        ((i.val : ℝ) : ℂ)*Complex.I))‖^2) ≤
      (2+(Real.log 2)^2)*Oscillation.halaszBlockCoefficient 1 1 2*
        coefficientEnergy (Finset.Ioc 1 2) (verticalCoefficients a (1/2)) := by
  have hh := Oscillation.halasz_block_complex_energy (Finset.univ : Finset (Fin 2))
    (fun i => (i.val : ℝ)) (fun i => (1/2 : ℝ)+(i.val : ℝ)/2)
    1 (by norm_num) a 1 (1/2) 1 le_rfl (by norm_num) (by norm_num)
    (by intro i hi; fin_cases i <;> norm_num)
    (by intro i hi; fin_cases i <;> norm_num)
    (by intro i hi j hj hij; fin_cases i <;> fin_cases j <;> norm_num at *)
  simpa only [Finset.card_univ,Fintype.card_fin,Nat.cast_ofNat,Nat.cast_one,mul_one] using! hh


/-- Zero coefficient energy is included in the unconditional count. -/
theorem layer4_halasz_zero_energy_count_consumer {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (ht : ∀ i ∈ S, |t i| ≤ 1)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, (1 : ℝ) ≤ ‖∑ n ∈ (Finset.Ioc 1 2 : Finset ℕ),
      (0 : ℂ)*(n : ℂ)^(-((t i : ℂ)*Complex.I))‖) : S = ∅ := by
  have hh := Oscillation.halasz_complex_large_values S t (fun _ => 0)
    1 le_rfl (fun _ => 0) 1 0 0 1 le_rfl zero_lt_one le_rfl (by norm_num)
    (fun _ _ => ⟨le_rfl,le_rfl⟩) ht hs (by simpa using hw)
  simp only [coefficientEnergy,verticalCoefficients,zero_mul,norm_zero,zero_pow (by norm_num : (2 : ℕ) ≠ 0),
    Finset.sum_const_zero,Oscillation.halaszLargeValueBound,mul_zero,zero_div,add_zero] at hh
  exact Finset.card_eq_zero.mp (by exact_mod_cast (le_antisymm hh (Nat.cast_nonneg S.card)))

/-- A common translate can be arbitrarily far outside the original ordinate window. -/
theorem layer4_halasz_shifted_mollifier_head_consumer (c : ℝ) :
    (∑ i ∈ (Finset.univ : Finset (Fin 2)),
      ‖Detector.finiteSeries (ArithmeticFunction.moebius : ArithmeticFunction ℂ) 1
        ((1/2 : ℂ)+(((i.val : ℝ)+c : ℝ) : ℂ)*Complex.I)‖^2) ≤
      Moment.halaszMollifierMomentBound 1 0 1 2 := by
  have hh := Moment.mollifier_sampled_halasz (Finset.univ : Finset (Fin 2))
    (fun i => (i.val : ℝ)) 1 0 le_rfl (by norm_num) 1 c le_rfl
    (by intro i hi; fin_cases i <;> norm_num)
    (by intro i hi j hj hij; fin_cases i <;> fin_cases j <;> norm_num at *)
  simpa only [Finset.card_univ,Fintype.card_fin,Nat.cast_ofNat] using! hh

/-- The packed analytic bound retains the lower allowed height T=2 and cutoff X=1. -/
theorem layer4_halasz_packed_height_two_consumer :
    (∑ i ∈ (Finset.univ : Finset (Fin 2)), ∫ v : ℝ,
      Detector.Smooth.criticalWeight (v-(i.val : ℝ))*
      ‖Detector.finiteSeries (ArithmeticFunction.moebius : ArithmeticFunction ℂ) 1
        ((1/2 : ℂ)+(v : ℂ)*Complex.I)‖^2) ≤
      (∫ u : ℝ, Detector.Smooth.criticalWeight u)*Moment.halaszMollifierMomentBound 1 0 2 2 := by
  have hh := (Moment.packed_mollifier_halasz (Finset.univ : Finset (Fin 2))
    (fun i => (i.val : ℝ)) 1 0 le_rfl (by norm_num) 2 le_rfl
    (by intro i hi; fin_cases i <;> norm_num)
    (by intro i hi j hj hij; fin_cases i <;> fin_cases j <;> norm_num at *)).2
  simpa only [Finset.card_univ,Fintype.card_fin,Nat.cast_ofNat] using! hh

/-- No dyadic levels are required when amplitudes include the splitting endpoint. -/
theorem layer4_dyadic_amplitude_endpoint_consumer (x : Fin 2 → ℝ)
    (hx : ∀ i, 0 ≤ x i ∧ x i ≤ 2) : (∑ i, (x i)^2) ≤ 8 := by
  have hh := Moment.finite_dyadic_second_moment (Finset.univ : Finset (Fin 2)) x
    0 2 0 0 (by norm_num) le_rfl le_rfl
    (by intro i hi; simpa only [pow_zero,mul_one] using hx i)
    (by intro j hj; simp at hj)
  convert! hh using 1 <;> norm_num

/-- The optimized cutoff includes equality B=R, rather than demanding a strict gap. -/
theorem layer4_balanced_moment_cutoff_consumer :
    ∃ V : ℝ, 2 ≤ V ∧ V^2+8/V^4 ≤ 5 := by
  simpa using! Moment.exists_balanced_moment_cutoff 1 1 zero_lt_one le_rfl

/-- Empty sample families need no positivity assumption on the coefficient energy. -/
theorem layer4_halasz_empty_polynomial_count_consumer :
    ((∅ : Finset ℕ).card : ℝ) ≤ Oscillation.criticalPolynomialCountCost 1 1*
      (1/(2 : ℝ)^2+1/(2 : ℝ)^6) := by
  exact Oscillation.critical_polynomial_shifted_count (∅ : Finset ℕ) (fun _ => 0)
    1 le_rfl (fun _ => 0) (by intro n; norm_num) 1 100 2 le_rfl le_rfl
    (by simp) (by simp) (by simp)


/-- The new global estimate improves the previous Ingham exponent at sigma=9/10. -/
theorem layer4_huxley_nine_tenths_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (Zeta.zeroDensityCount (9/10) T : ℝ) ≤ C*T^(1/4 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Zeta.hasZeroDensityEstimate_twelve_fifths (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro T hT
  convert! hb (9/10) (by norm_num) T hT using 1 <;> norm_num

/-- The switching endpoint sigma=3/4 is included in the closed global theorem. -/
theorem layer4_huxley_three_quarters_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (Zeta.zeroDensityCount (3/4) T : ℝ) ≤ C*T^(61/100 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Zeta.hasZeroDensityEstimate_twelve_fifths (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro T hT
  convert! hb (3/4) (by norm_num) T hT using 1 <;> norm_num

/-- Height two retains one constant for the entire closed sigma interval. -/
theorem layer4_huxley_height_two_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Set.Icc (1/2 : ℝ) 1,
      (Zeta.zeroDensityCount σ 2 : ℝ) ≤ C*2^((12/5 : ℝ)*(1-σ)+1/100) := by
  obtain ⟨C,hC,hb⟩ := Zeta.hasZeroDensityEstimate_twelve_fifths (1/100) (by norm_num)
  exact ⟨C,hC,fun σ hσ => hb σ hσ 2 (by norm_num)⟩

/-- The real-part endpoint one is included without discarding the low heights. -/
theorem layer4_huxley_sigma_one_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (Zeta.zeroDensityCount 1 T : ℝ) ≤ C*T^(1/100 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Zeta.hasZeroDensityEstimate_twelve_fifths (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro T hT
  convert! hb 1 (by norm_num) T hT using 1 <;> norm_num

/-- Exact balance powers at the switching endpoint. -/
theorem layer4_huxley_balance_three_quarters_consumer :
    Moment.huxleyMollifierExponent (3/4) = 4/5 ∧
    Moment.huxleyDetectorExponent (3/4) = 6/5 ∧ Moment.huxleyBookExponent (3/4) = 3/5 := by
  norm_num [Moment.huxleyMollifierExponent,Moment.huxleyDetectorExponent,
    Moment.huxleyBookExponent,Moment.huxleyBalanceDenominator]

/-- Exact balance powers at the real-part endpoint one. -/
theorem layer4_huxley_balance_one_consumer :
    Moment.huxleyMollifierExponent 1 = 1/2 ∧
    Moment.huxleyDetectorExponent 1 = 1 ∧ Moment.huxleyBookExponent 1 = 0 := by
  norm_num [Moment.huxleyMollifierExponent,Moment.huxleyDetectorExponent,
    Moment.huxleyBookExponent,Moment.huxleyBalanceDenominator]

/-- Integer rounding preserves the useful square-root mollifier at sigma=1. -/
theorem layer4_huxley_integer_cutoff_consumer (T : ℝ) (hT : 2 ≤ T) :
    ∃ X J : ℕ, 1 ≤ X ∧ T^(1/2 : ℝ) ≤ X ∧ (X : ℝ) ≤ 2*T^(1/2 : ℝ) ∧
      (X : ℝ) ≤ 2*T ∧ X ≤ 2^J ∧
      (J : ℝ) ≤ Moment.halaszUniformCoverConstant*(1+Real.log T) := by
  have hh := Moment.huxley_integer_cutoffs T 1 hT (by norm_num) le_rfl
  simpa only [show Moment.huxleyMollifierExponent 1 = 1/2 by
    norm_num [Moment.huxleyMollifierExponent,Moment.huxleyBalanceDenominator]] using! hh

/-- The lowest high-shell height satisfies the literal principal-pole scale constraints. -/
theorem layer4_huxley_principal_pole_consumer :
    4 ≤ (128 : ℝ)^(6/5 : ℝ) ∧ (128 : ℝ)^(6/5 : ℝ) ≤ 4096 ∧
      1+Real.log (2*(128 : ℝ)^(6/5 : ℝ)+1) ≤ 8*(1+Real.log 128) := by
  have hh := Moment.huxley_detector_scale 128 (3/4) le_rfl (by norm_num) (by norm_num)
  convert! hh using 1 <;> norm_num [Moment.huxleyDetectorExponent,Moment.huxleyBalanceDenominator]

/-- Taking individual powers does not introduce a spurious nonzero mass at X=0. -/
theorem layer4_individual_fourth_zero_cutoff_consumer :
    ∀ T : ℝ, 2 ≤ T → ∀ {ι : Type*} (S : Finset ι) (t : ι → ℝ),
      (∀ i ∈ S, |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∑ i ∈ S, (Detector.Smooth.criticalMass 0 (t i))^4) ≤ 0 := by
  obtain ⟨C,_,hb⟩ := Moment.sum_critical_mass_fourth
  intro T hT ι S t ht hs
  simpa using hb 0 T hT S t ht hs

/-- All actual-zero and pole constraints are valid for an empty family at T=128. -/
theorem layer4_typeII_empty_consumer :
    ∃ C : ℝ, 0 < C ∧ ((∅ : Finset ℕ).card : ℝ) ≤ C*(128 : ℝ)^(1/10 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Moment.actual_typeII_given_cutoff_count (1/10) (by norm_num)
  refine ⟨C,hC,?_⟩
  have hh := hb 0 128 1 (by norm_num) le_rfl (by norm_num) 1 le_rfl
    (by norm_num) (by norm_num) (∅ : Finset ℕ) (fun _ => 1) (fun _ => 0)
    (by simp) (by simp) (by simp) (by simp)
  convert! hh using 1 <;> norm_num

/-- The selected integer cutoff includes equality at delta=0. -/
theorem layer4_small_mollifier_zero_exponent_consumer (T : ℝ) (hT : 2 ≤ T) :
    ∃ X : ℕ, 1 ≤ X ∧ (1 : ℝ) ≤ X ∧ (X : ℝ) ≤ 2 ∧ (X : ℝ) ≤ 2*T := by
  simpa using! Moment.small_integer_mollifier T 0 hT le_rfl (by norm_num)

/-- The first permissible high shell satisfies the square-root detector constraints. -/
theorem layer4_sqrt_detector_minimum_height_consumer :
    4 ≤ (128 : ℝ)^(1/2 : ℝ) ∧ (128 : ℝ)^(1/2 : ℝ) ≤ 4096 := by
  convert! Moment.sqrt_detector_scale 128 le_rfl using 1 <;> norm_num

/-- A singleton at n=2 convolves to n=4; this detects pointwise-power coercions. -/
theorem layer4_convolution_power_consumer :
    ((Moment.Powers.blockArithmeticCoefficient (fun _ => (1 : ℂ)) 1 2)^2) 4 = 1 ∧
    ((Moment.Powers.blockArithmeticCoefficient (fun _ => (1 : ℂ)) 1 2)^2) 2 = 0 := by
  have hd4 : Nat.divisorsAntidiagonal 4 = {(1,4),(2,2),(4,1)} := by decide
  have hd2 : Nat.divisorsAntidiagonal 2 = {(1,2),(2,1)} := by decide
  constructor
  · rw [pow_two,ArithmeticFunction.mul_apply,hd4]
    norm_num [Moment.Powers.blockArithmeticCoefficient_apply]
  · rw [pow_two,ArithmeticFunction.mul_apply,hd2]
    norm_num [Moment.Powers.blockArithmeticCoefficient_apply]

/-- Power zero is the convolution unit even when the original block is empty. -/
theorem layer4_empty_block_power_zero_consumer (s : ℂ) :
    Detector.finiteSeries ((Moment.Powers.blockArithmeticCoefficient (fun _ => (1 : ℂ)) 2 1)^0)
      1 s = 1 := by
  simpa using! (Moment.Powers.block_polynomial_power (fun _ => (1 : ℂ)) 2 1 0 s).symm

/-- The lower endpoint is excluded from every positive convolution power. -/
theorem layer4_power_support_boundary_consumer (a : ℕ → ℂ) :
    ((Moment.Powers.blockArithmeticCoefficient a 2 4)^3) 8 = 0 := by
  exact Moment.Powers.positive_power_vanish_below _ 2
    (Moment.Powers.blockArithmeticCoefficient_below a 2 4) 2 8 (by norm_num)

/-- The subpower constant is uniform in the coefficients and includes the maximal power. -/
theorem layer4_uniform_power_coefficients_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ f : ArithmeticFunction ℂ,
      (∀ n, ‖f n‖ ≤ (n.divisors.card : ℝ)) → ∀ n : ℕ, 0 < n →
      ‖(f^4) n‖ ≤ C*(n : ℝ)^(1/100 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Moment.Powers.bounded_powers_coefficients_subpower 1 4 (1/100)
    (by norm_num)
  exact ⟨C,hC,fun f hf n hn => hb f (by simpa using hf) 4 le_rfl n hn⟩

/-- The endpoint sigma=5/6 still permits a power of length exponent exactly one. -/
theorem layer4_huxley_power_window_endpoint_consumer :
    Moment.huxleyPowerUpper (5/6) = 1 ∧
    (2 : ℝ)*(1/2) ≤ Moment.huxleyPowerUpper (5/6) ∧
    Moment.huxleyPowerLower (5/6) ≤ (2 : ℝ)*(1/2) := by
  norm_num [Moment.huxleyPowerUpper,Moment.huxleyPowerLower]

/-- The bounded selection theorem retains a strictly positive lower length. -/
theorem layer4_huxley_short_power_consumer :
    ∃ k : ℕ, 1 ≤ k ∧ k ≤ Moment.huxleyPowerBudget (1/100) ∧
      Moment.huxleyPowerLower (3/4) ≤ (k : ℝ)*(1/100) ∧
      (k : ℝ)*(1/100) ≤ Moment.huxleyPowerUpper (3/4) := by
  exact Moment.huxley_short_block_power (1/100) (1/100) (3/4)
    (by norm_num) le_rfl (by norm_num) le_rfl (by norm_num)

/-- Both large-value exponents fit the curved exponent at sigma=5/6. -/
theorem layer4_huxley_power_exponents_endpoint_consumer :
    (2/3 : ℝ)*(2-2*(5/6)) ≤ 1/3 ∧ 1+(2/3 : ℝ)*(4-6*(5/6)) ≤ 1/3 := by
  have hh := Moment.huxley_power_window_exponents (5/6) (2/3)
    (by norm_num) le_rfl (by norm_num [Moment.huxleyPowerLower,Moment.huxleyPowerUpper])
  convert! hh using 1 <;> norm_num [Moment.huxleyCurvedExponent]

/-- The k=1 decomposition preserves the original, single dyadic block exactly. -/
theorem layer4_power_one_block_consumer (a : ℕ → ℂ) (s : ℂ) :
    (∑ n ∈ Finset.Ioc 1 2, a n*(n : ℂ)^(-s)) =
      ∑ j ∈ Finset.range 1, ∑ n ∈ Finset.Ioc (2^j*1^1) (2*(2^j*1^1)),
        ((Moment.Powers.blockArithmeticCoefficient a 1 2)^1) n*(n : ℂ)^(-s) := by
  simpa only [pow_one] using! Moment.Powers.powered_block_dyadic_decomposition a 1 1
    le_rfl le_rfl s

/-- The curved theorem improves global 12/5 at sigma=4/5. -/
theorem layer4_curved_four_fifths_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (Zeta.zeroDensityCount (4/5) T : ℝ) ≤ C*T^(307/700 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Zeta.huxley_curved_restricted_density_epsilon (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro T hT
  convert! hb (4/5) (by norm_num) T hT using 1 <;> norm_num

/-- The endpoint sigma=5/6 is retained in the full, multiplicity-weighted count. -/
theorem layer4_curved_five_sixths_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
      (Zeta.zeroDensityCount (5/6) T : ℝ) ≤ C*T^(103/300 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Zeta.huxley_curved_restricted_density_epsilon (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro T hT
  convert! hb (5/6) (by norm_num) T hT using 1 <;> norm_num

/-- One common coefficient includes height two for the entire restricted sigma range. -/
theorem layer4_curved_height_two_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Set.Icc (1/2 : ℝ) (5/6),
      (Zeta.zeroDensityCount σ 2 : ℝ) ≤ C*2^(3*(1-σ)/(3*σ-1)+1/100) := by
  obtain ⟨C,hC,hb⟩ := Zeta.huxley_curved_restricted_density_epsilon (1/100) (by norm_num)
  exact ⟨C,hC,fun σ hσ => hb σ hσ 2 (by norm_num)⟩

/-- Empty short-block samples are valid at the exact square-root length. -/
theorem layer4_curved_empty_short_block_consumer :
    ∃ C : ℝ, 0 < C ∧ ((∅ : Finset ℕ).card : ℝ) ≤ C*(4 : ℝ)^(103/300 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Moment.huxley_short_block_epsilon_count 1 (1/2) (1/100)
    (by norm_num) (by norm_num)
  refine ⟨C,hC,?_⟩
  have hh := hb 4 (5/6) (by norm_num) (by norm_num) le_rfl 2
    (by norm_num [←Real.sqrt_eq_rpow]) (by norm_num [←Real.sqrt_eq_rpow])
    (fun _ => 0) (by intro n hn; simp) 1 zero_lt_one le_rfl
    (∅ : Finset ℕ) (fun _ => 0) (fun _ => 1) (by simp) (by simp) (by simp) (by simp)
  convert! hh using 1 <;> norm_num [Moment.huxleyCurvedExponent]

/-- Log absorption includes the zero-th logarithmic power. -/
theorem layer4_one_add_log_zero_power_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T → 1 ≤ C*T^(1/100 : ℝ) := by
  simpa only [pow_zero] using! Moment.exists_one_add_log_pow_le_rpow 0 (1/100) (by norm_num)

/-- The coefficient-amplitude theorem includes K=0 and the convolution unit. -/
theorem layer4_powered_amplitude_zero_budget_consumer :
    ∃ C : ℝ, 0 < C ∧ ∀ a : ℕ → ℂ, ∀ U : ℕ, 1 ≤ U →
      (∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ (n.divisors.card : ℝ)^0) → ∀ n : ℕ,
      ‖((Moment.Powers.blockArithmeticCoefficient a U (2*U))^0) n‖ ≤ C*(n.divisors.card : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Moment.powered_block_uniform_amplitude 0 0 (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  intro a U hU ha n
  simpa using hb a U 0 hU le_rfl ha n

/-- The merged detector branches include the first high shell and an empty family. -/
theorem layer4_curved_first_shell_empty_consumer :
    ∃ C : ℝ, 0 < C ∧ ((∅ : Finset ℕ).card : ℝ) ≤ C*(128 : ℝ)^(103/300 : ℝ) := by
  obtain ⟨C,hC,hb⟩ := Moment.huxley_curved_separated_high_shell_density (1/100) (by norm_num)
  refine ⟨C,hC,?_⟩
  have hh := hb 128 (5/6) le_rfl (by norm_num) le_rfl
    (∅ : Finset ℕ) (fun _ => 0) (fun _ => 1) (by simp) (by simp) (by simp)
  convert! hh using 1 <;> norm_num [Moment.huxleyCurvedExponent]

/-- Real block-length selection includes both square-root equalities at T=4. -/
theorem layer4_curved_real_length_selection_consumer :
    ∃ k : ℕ, 1 ≤ k ∧ k ≤ Moment.huxleyPowerBudget (1/2) ∧
      (4 : ℝ)^Moment.huxleyPowerLower (5/6) ≤ (2 : ℝ)^k ∧
      (2 : ℝ)^k ≤ (4 : ℝ)^Moment.huxleyPowerUpper (5/6) := by
  exact Moment.huxley_short_length_power 4 (1/2) (5/6) 2 (by norm_num) (by norm_num)
    (by norm_num [←Real.sqrt_eq_rpow]) (by norm_num [←Real.sqrt_eq_rpow]) (by norm_num) le_rfl

end Legendre.Tests
