/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module
public import Legendre.Literature.Comparators

/-!
# Layer 0--4 coverage and exponent guards

An implication with an open density estimate as input is a comparison bridge,
not a proof of that estimate. The completed classical PNT scale is explicitly
kept separate from any fixed sublinear prime-gap exponent.
-/

@[expose] public section
namespace Legendre.Literature
open Filter Set Asymptotics MeasureTheory
open scoped Topology

/-- Exactly the analytic properties supplied by completed Layer 2. -/
def ZetaFoundationBenchmark : Prop :=
  AnalyticOnNhd ℂ riemannZeta ({1}ᶜ : Set ℂ) ∧
  (∀ s : ℂ, completedRiemannZeta (1-s) = completedRiemannZeta s) ∧
  (∀ s : ℂ, 1 ≤ s.re → s ≠ 1 → riemannZeta s ≠ 0) ∧
  (∀ s : ℂ, 3 ≤ |s.im| → 1-1/(2000000*Real.log |s.im|) < s.re →
    riemannZeta s ≠ 0)

theorem layer2_comparator : ZetaFoundationBenchmark :=
  ⟨Zeta.analytic_off_pole,Zeta.completed_functional_equation,
    fun _ hs h1 => Zeta.nonvanishing hs h1,
    fun _ ht hs => Zeta.riemannZeta_ne_zero_of_explicit_log_region ht hs⟩

theorem layer3_comparator : ClassicalPNTError := PNT.pnt_eventual_bound

theorem layer4_fourth_moment_log_six_comparator : ZetaFourthMomentLogSix :=
  Zeta.zeta_fourth_moment_positive_log_six

theorem layer4_fourth_moment_exponent_comparator : ZetaFourthMomentExponent :=
  Zeta.zeta_fourth_moment_epsilon

/-- This rejects an invalid *bound comparison*, not the possibility of a stronger theorem. -/
theorem layer3_no_fixed_power_comparator (c θ : ℝ) (hθ : θ < 1) :
    ¬PNT.classicalError c =O[atTop] (fun x : ℝ => x^θ) :=
  PNT.classicalError_not_isBigO_rpow c hθ

/-- The completed mean-square estimate has length exponent one and no log loss. -/
def LinearMeanSquareBenchmark : Prop :=
  ∀ N : ℕ, ∀ a : ℕ → ℂ, ∀ A B : ℝ,
    |(∫ t : ℝ in A..B, ‖Density.dirichletPolynomial N a t‖^2)-
      (B-A)*Density.coefficientEnergy (Finset.Icc 1 N) a| ≤
        2*Real.pi*(N : ℝ)*Density.coefficientEnergy (Finset.Icc 1 N) a

theorem layer4_mean_comparator : LinearMeanSquareBenchmark :=
  Density.abs_integral_dirichletPolynomial_sub_diagonal_le_linear

/-- Whole-line cubic-weight fourth moment, including actual integrability. -/
def WeightedFourthMomentBenchmark : Prop :=
  ∃ C : ℝ, 0 < C ∧ ∀ T : ℝ, 2 ≤ T →
    Integrable (fun t : ℝ => Density.Moment.momentHeightWeight T t*
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ∧
    (∫ t : ℝ, Density.Moment.momentHeightWeight T t*
      ‖riemannZeta ((1/2 : ℂ)+(t : ℂ)*Complex.I)‖^4) ≤ C*T*(Real.log T)^6

theorem layer4_weighted_moment_comparator : WeightedFourthMomentBenchmark :=
  Density.Moment.weighted_zeta_fourth_moment

/-- A proved actual-zero detector, with its numerical range visible. -/
def CompensatedDetectorBenchmark : Prop :=
  ∀ X : ℕ, 1 ≤ X → ∀ σ t T Y : ℝ, 1/2 < σ → σ ≤ 1 →
    64 ≤ T → T ≤ |t| → (X : ℝ) ≤ 4*T → 4 ≤ Y → Y ≤ T^2 →
    riemannZeta ((σ : ℂ)+(t : ℂ)*Complex.I) = 0 →
    (1/16 : ℝ) ≤ ‖Density.Detector.Smooth.detectorTail X ((σ : ℂ)+(t : ℂ)*Complex.I) Y‖ ∨
      (1/16 : ℝ) ≤ ‖Density.Detector.Smooth.detectorCriticalIntegral X ((σ : ℂ)+(t : ℂ)*Complex.I) Y‖

theorem layer4_compensated_detector_comparator : CompensatedDetectorBenchmark := by
  intro X hX σ t T Y hσ hσ1 hT ht hXT hY hY2 hz
  have hs : (σ : ℂ)+(t : ℂ)*Complex.I ≠ 1 := by
    intro he
    have hh := congrArg Complex.im he
    simp at hh
    rw [hh] at ht
    norm_num at ht
    linarith
  exact Density.Detector.Smooth.detector_high_zero_dichotomy X hX hs hz
    (by simpa using hσ) (by simpa using hσ1) hT (by simpa using ht) hXT hY hY2

/-- Actual analytic Halasz energy, with the square-root-height and harmonic-row terms. -/
def ActualHalaszBenchmark : Prop :=
  ∃ C : ℝ, 0 < C ∧ ∀ (U V : ℕ), 1 ≤ U → U ≤ V → V ≤ 2*U →
    ∀ T : ℝ, 1 ≤ T → ∀ {ι : Type*} [Fintype ι] (t : ι → ℝ) (a : ℕ → ℂ),
    (∀ i, |t i| ≤ T) → (∀ i j, i ≠ j → 1 ≤ |t i-t j|) →
    (∑ i, ‖∑ n ∈ Finset.Ioc U V, a n*(n : ℂ)^(-(t i : ℂ)*Complex.I)‖^2) ≤
      ((U : ℝ)+C*((Fintype.card ι : ℝ)*Real.sqrt (2*T)+2*(U : ℝ)*(1+Real.log (2*T))))*
        Density.coefficientEnergy (Finset.Ioc U V) a

theorem layer4_actual_halasz_comparator : ActualHalaszBenchmark := by
  refine ⟨Density.Oscillation.logarithmicKernelConstant,
    Density.Oscillation.logarithmicKernelConstant_pos,?_⟩
  intro U V hU hUV hV T hT ι inst t a ht hs
  exact Density.Oscillation.halasz_block_energy t U V hU hUV hV a T hT ht hs

/-- The actual two-term analytic large-value count, with variable real parts. -/
def ActualHalaszLargeValuesBenchmark : Prop :=
  ∃ C : ℝ, 0 < C ∧ ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ), 1 ≤ U → ∀ (a : ℕ → ℂ) (T σ b W : ℝ), 1 ≤ T → 0 < W →
    σ ≤ b → b-σ ≤ 1 → (∀ i ∈ S, β i ∈ Icc σ b) →
    (∀ i ∈ S, |t i| ≤ T) → (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
    (∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*Complex.I))‖) →
    (S.card : ℝ) ≤ C*(1+Real.log (2*U))^6*(1+Real.log (2*T))*
      ((U : ℝ)*Density.coefficientEnergy (Finset.Ioc U (2*U)) (Density.verticalCoefficients a σ)/W^2+
        (U : ℝ)*T*(Density.coefficientEnergy (Finset.Ioc U (2*U)) (Density.verticalCoefficients a σ))^3/W^6)

theorem layer4_actual_halasz_large_values_comparator : ActualHalaszLargeValuesBenchmark := by
  refine ⟨Density.Oscillation.halaszCountConstant,Density.Oscillation.halaszCountConstant_pos,?_⟩
  intro ι S t β U hU a T σ b W hT hW hσb hlen hβ ht hs hw
  exact Density.Oscillation.halasz_complex_large_values_two_term S t β U hU a T σ b W
    hT hW hσb hlen hβ ht hs hw

/-- Closed proof of the 1940 curved density exponent, with multiplicities and uniform sigma. -/
theorem layer4_ingham_comparator : Ingham1940Density := Zeta.ingham_density_epsilon

/-- Closed proof of global 12/5, retaining uniform sigma, all heights and multiplicities. -/
theorem layer4_huxley_global_comparator : HuxleyGlobalDensity :=
  Zeta.hasZeroDensityEstimate_twelve_fifths

/-- Closed restricted curved proof; its real-part range stops at 5/6. -/
theorem layer4_huxley_restricted_comparator : Huxley1972RestrictedDensity :=
  Zeta.huxley_curved_restricted_density_epsilon

/-- The full independent curved benchmark is closed, uniformly through sigma=1. -/
theorem layer4_huxley_comparator : Huxley1972Density :=
  Zeta.huxley_curved_density_epsilon

/-- Closed actual short-sum bound, with the square-root-length hypothesis explicit. -/
theorem layer4_weyl_short_sum_comparator : WeylShortSumBenchmark := by
  refine ⟨Density.Oscillation.logarithmicWeylConstant,
    Density.Oscillation.logarithmicWeylConstant_pos,?_⟩
  exact Density.Oscillation.logarithmic_block_weyl

theorem layer4_weighted_weyl_comparator : WeightedWeylBenchmark := by
  refine ⟨Density.Oscillation.logarithmicWeylConstant,
    Density.Oscillation.logarithmicWeylConstant_pos,?_⟩
  exact Density.Oscillation.logarithmic_block_weighted_weyl

theorem layer4_general_weyl_comparator : GeneralWeylBenchmark := by
  refine ⟨Density.Oscillation.logarithmicWeylConstant,
    Density.Oscillation.logarithmicWeylConstant_pos,?_⟩
  exact Density.Oscillation.logarithmic_block_general_weyl

/-- Both analytic inputs now control the actual detector, with one uniform coefficient. -/
theorem layer4_actual_mobius_pointwise_comparator : ActualMobiusPointwiseBenchmark := by
  have hW := Density.Oscillation.logarithmicWeylConstant_pos
  have hS := Density.Oscillation.logarithmicSecondConstant_pos
  let D := Density.Oscillation.logarithmicWeylConstant+Density.Oscillation.logarithmicSecondConstant+1
  have hD : 0 < D := by dsimp [D]; linarith
  refine ⟨2*D,by positivity,?_⟩
  intro X U V hU hXU hUV hV β t Y hβ hβ1 ht hY
  let A := Real.sqrt (U : ℝ)*|t|^(1/6 : ℝ)+(U : ℝ)*((U : ℝ)/|t|)^(1/4 : ℝ)+
    (U : ℝ)/|t|^(1/3 : ℝ)
  let B := Real.sqrt |t|+(U : ℝ)/Real.sqrt |t|
  have hA : 0 ≤ A := by dsimp [A]; positivity
  have hB : 0 ≤ B := by dsimp [B]; positivity
  constructor
  · have hh := Density.Detector.Smooth.polynomial_block_general_weyl X U V hU hXU hUV hV β t Y hβ hβ1 ht hY
    have hb : Density.Oscillation.logarithmicWeylConstant*A+1 ≤ D*(1+A) := by dsimp [D]; nlinarith
    have hp := mul_le_mul_of_nonneg_left hb (show 0 ≤ 2*(X : ℝ)*(U : ℝ)^(-β) by positivity)
    apply hh.trans
    convert hp using 1 <;> (try dsimp [A,D,Density.Oscillation.generalWeylCost]) <;> ring
  · have htp : 0 < |t| := by linarith
    have hh := Density.Detector.Smooth.polynomial_block_second_derivative X U V hU hXU hUV hV β t Y hβ hβ1
      (abs_pos.mp htp) hY
    have hb : Density.Oscillation.logarithmicSecondConstant*B+1 ≤ D*(1+B) := by dsimp [D]; nlinarith
    have hp := mul_le_mul_of_nonneg_left hb (show 0 ≤ 2*(X : ℝ)*(U : ℝ)^(-β) by positivity)
    apply hh.trans
    convert hp using 1 <;> (try dsimp [B,D,Density.Oscillation.secondDerivativeCost]) <;> ring

/-- This is the actual polynomial branch; zero counting and multiplicities are separate. -/
theorem layer4_upper_typeI_comparator : UpperHuxleyTypeIBenchmark := by
  intro η δ ε hη hδ hδη hε
  exact Density.Moment.huxley_upper_actual_tail_epsilon_count η δ ε hη hδ hδη hε

theorem densityPower_iff (b : ℝ) :
    DensityPower (fun σ => b*(1-σ)) ↔ Zeta.HasZeroDensityEstimate b := Iff.rfl

/-- Uniformity in sigma is retained when combining two density exponents. -/
theorem densityPower_of_two {f g h : ℝ → ℝ} (hf : DensityPower f) (hg : DensityPower g)
    (hcover : ∀ σ : ℝ, σ ∈ Icc (1/2) 1 → f σ ≤ h σ ∨ g σ ≤ h σ) :
    DensityPower h := by
  intro ε hε
  obtain ⟨C,hC,hf⟩ := hf ε hε
  obtain ⟨D,hD,hg⟩ := hg ε hε
  refine ⟨max C D,lt_max_of_lt_left hC,fun σ hσ T hT => ?_⟩
  have hT1 : 1 ≤ T := by linarith
  rcases hcover σ hσ with hs | hs
  · exact (hf σ hσ T hT).trans (mul_le_mul (le_max_left _ _)
      (Real.rpow_le_rpow_of_exponent_le hT1 (by linarith))
      (Real.rpow_nonneg (by linarith) _) (le_of_lt (lt_max_of_lt_left hC)))
  · exact (hg σ hσ T hT).trans (mul_le_mul (le_max_right _ _)
      (Real.rpow_le_rpow_of_exponent_le hT1 (by linarith))
      (Real.rpow_nonneg (by linarith) _) (le_of_lt (lt_max_of_lt_left hC)))

/-- Ingham below 3/4 and Huxley above 3/4 give the classical global 12/5 exponent. -/
theorem huxley_global_comparator (hi : Ingham1940Density) (hh : Huxley1972Density) :
    Zeta.HasZeroDensityEstimate (12/5) := by
  apply (densityPower_iff _).1
  apply densityPower_of_two hi hh
  intro σ hσ
  have hnonneg : 0 ≤ 1-σ := by linarith [hσ.2]
  by_cases hs : σ ≤ 3/4
  · left
    have hd : 0 < 2-σ := by linarith
    have hb : (3 : ℝ)/(2-σ) ≤ 12/5 := (div_le_iff₀ hd).2 (by linarith)
    calc
      _ = (3/(2-σ))*(1-σ) := by ring
      _ ≤ _ := mul_le_mul_of_nonneg_right hb hnonneg
  · right
    have hd : 0 < 3*σ-1 := by linarith
    have hb : (3 : ℝ)/(3*σ-1) ≤ 12/5 := (div_le_iff₀ hd).2 (by linarith)
    calc
      _ = (3/(3*σ-1))*(1-σ) := by ring
      _ ≤ _ := mul_le_mul_of_nonneg_right hb hnonneg

/-- Ingham and full Huxley close the two outer real-part intervals. -/
theorem layer4_guth_maynard_outer_comparator : GuthMaynard2024OuterDensity :=
  Zeta.guth_maynard_outer_density_epsilon

/-- The sampling benchmark contains the literal polynomial, coefficient energy and traces. -/
theorem layer4_guth_sampling_trace_comparator : GuthMaynardSamplingTraceBenchmark := by
  intro cutoff N W hW b V hV hLarge
  have hh := Density.GuthMaynard.gm_largeValues_energy_dispersion cutoff N W hW b V hV
    (by simpa only [Density.GuthMaynard.gmSmoothDirichletPoly,
      Density.GuthMaynard.dyadicInterval] using hLarge)
  rw [Density.GuthMaynard.gmCubicSpectralDispersion_eq_trace] at hh
  have he : (∑ n : Density.GuthMaynard.GMColumn N, ‖b n‖^2) =
      ∑ n ∈ Finset.Ioc N (2*N), ‖b n‖^2 := by
    change (∑ n : {n : ℕ // n ∈ Finset.Ioc N (2*N)}, ‖b n‖^2) = _
    rw [Finset.univ_eq_attach]
    exact Finset.sum_attach (Finset.Ioc N (2*N)) (fun n => ‖b n‖^2)
  rw [he] at hh
  exact hh

/-- The first-trace comparison keeps the literal real integral and all quantifiers. -/
theorem layer4_guth_first_trace_comparator : GuthMaynardFirstTraceBenchmark := by
  intro cutoff A J hJ
  simpa only [Density.GuthMaynard.gmCutoffL2Sq] using
    Density.GuthMaynard.gmMatrix_hilbertSchmidt_trace_estimate cutoff A J hJ

/-- A constant selected before t and ξ controls every ordinate and Fourier mode. -/
theorem layer4_guth_uniform_fourier_comparator : GuthMaynardUniformFourierBenchmark :=
  Density.GuthMaynard.gmTraceFourier_uniform_decay

/-- The cubic comparison uses literal distance/interval hypotheses and the actual trace. -/
theorem layer4_guth_cubic_remainder_comparator : GuthMaynardCubicRemainderBenchmark := by
  intro cutoff ε hε
  obtain ⟨K,hK,h⟩ := Density.GuthMaynard.gmMatrix_cubic_trace_two_piece_remainder cutoff ε hε
  refine ⟨K,hK,?_⟩
  intro N W T hN hT hNT hTN hs hi
  simpa only [Density.GuthMaynard.gmCubicDiagonalMain,Density.GuthMaynard.gmCutoffL2Sq] using
    h N W hN hT hNT hTN hs hi

/-- The complete reflection comparator expands the smoothing/length/polynomial definitions. -/
theorem layer4_guth_complete_reflection_comparator : GuthMaynardCompleteReflectionBenchmark := by
  intro cutoff A ε hA hε
  obtain ⟨C,T_min,hC,hT_min,h⟩ :=
    Density.GuthMaynard.gmScaledQuantitativeSmoothReflection_native cutoff A ε hA hε
  refine ⟨C,T_min,hC,hT_min,?_⟩
  intro T T₀ t N hT hN hNT hT₀ hlo hhi ht
  simpa only [Density.GuthMaynard.gmReflectionHeight,Density.GuthMaynard.gmReflectionEta,
    Density.GuthMaynard.gmReflectionLength,Density.GuthMaynard.gmReflectionDirichletPoly] using
    h hT hN hNT hT₀ hlo hhi ht

/-- The remaining second moment is the literal ordered sum over the original finite set. -/
theorem layer4_guth_cubic_moment_comparator : GuthMaynardCubicMomentBenchmark := by
  intro cutoff ε hε
  obtain ⟨K,hK,h⟩ := Density.GuthMaynard.gmMatrix_cubic_trace_moment_remainder cutoff ε hε
  refine ⟨K,hK,?_⟩
  intro N W T hN hT hNT hTN hs hi
  simpa only [Density.GuthMaynard.gmCubicDiagonalMain,Density.GuthMaynard.gmCutoffL2Sq,
    Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_eq_source] using
    h N W hN hT hNT hTN hs hi

/-- The Heath--Brown comparison expands both the source polynomial and its index set. -/
theorem layer4_heath_brown_difference_comparator : HeathBrownDifferenceMeanSquareBenchmark := by
  intro ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := Density.GuthMaynard.heathBrownDifferenceSetMeanSquare_native ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro N T W a hN hT hs hi ha
  simpa only [Density.GuthMaynard.sourceDirichletPoly,Density.GuthMaynard.dyadicInterval] using
    h N T W a hN hT hs hi ha

/-- Closed trace-moment comparison with the finite-set sum unfolded. -/
theorem layer4_guth_poisson_tail_moment_comparator : GuthMaynardPoissonTailMomentBenchmark := by
  intro cutoff k hk ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_estimate cutoff hk ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro N T W hN hT hNT hW hs hi
  simpa only [Density.GuthMaynard.gmTraceNonzeroDifferenceMoment_eq_source,
    Density.GuthMaynard.gmS2TracePaperShape] using h W hN hT hNT hW hs hi

/-- All three literal Proposition 6.1 powers are checked independently. -/
theorem layer4_guth_s2_comparator : GuthMaynardS2Benchmark := by
  intro cutoff k hk ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := Density.GuthMaynard.gmCubicS2_estimate cutoff hk ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro N T W hN hT hNT hs hi
  simpa only [Density.GuthMaynard.gmS2PaperShape_eq] using h W hN hT hNT hs hi

/-- The energy convention and admissible length window are literal in the comparison. -/
theorem layer4_guth_s3_energy_comparator : GuthMaynardS3EnergyBenchmark := by
  intro cutoff ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := Density.GuthMaynard.gmCubicS3_prop8_1_native cutoff ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro N T W hT hN hNT hlo hs hi
  simpa only [Density.GuthMaynard.ApproxAddEnergy,Density.GuthMaynard.approximateAdditiveQuadruples] using
    h hT hN hNT hlo hs hi

/-- The tolerance bridge recovers the paper's literal strict-energy convention. -/
theorem layer4_guth_s3_strict_energy_comparator : GuthMaynardStrictS3EnergyBenchmark := by
  intro cutoff ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := Density.GuthMaynard.gmCubicS3_prop8_1_strict_energy cutoff ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro N T W hT hN hNT hlo hs hi
  simpa only [Density.GuthMaynard.strictAddEnergy] using h hT hN hNT hlo hs hi

open Density.GuthMaynard in
/-- The literal selected-scale integral follows from the proved finite supremum. -/
theorem layer4_guth_affine_comparator : GuthMaynardAffineBenchmark := by
  intro f hf hs ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := gmAffine_proposition9_1_native f hf hs ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro T M A B D hT hM hMT hA hAM hB hBM hD hDM
  have hj := gmAffineTransformIntegral_le_J (f : ℝ → ℝ) hM
    (mem_gmAffineScaleTriples.mpr ⟨hA,hAM,hB,hBM,hD,hDM⟩)
  have hb := hj.trans (h hT hM hMT)
  simpa only [gmAffineTransformIntegral,gmAffineTransformSum,gmAffineTerm,
    gmAffineSignedShell,gmAffinePositiveShell,gmAffineCentralShell,
    Nat.cast_mul,Nat.cast_ofNat] using hb

open Density.GuthMaynard in
/-- The coefficient family is fixed before the varying physical height. -/
theorem layer4_guth_affine_height_comparator : GuthMaynardAffineHeightFamilyBenchmark := by
  intro D hD ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := gmAffine_proposition9_1_height_family_native D hD hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro T hT f hf hs hp M hM hMT
  apply h hT f hf hs _ hM hMT
  intro δ hδ n
  simpa only [GMAffineHeightFourierMassBound, pow_zero, one_mul] using hp δ hδ n

open Density.GuthMaynard in
/-- The actual S3 physical-scale form retains the full negligible error. -/
theorem layer4_guth_refined_s3_comparator : GuthMaynardRefinedS3Benchmark := by
  intro cutoff ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := gmCubicS3_prop10_1_native cutoff ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro N T W hT hN hNT hlo hs hi
  simpa only [ApproxAddEnergy,approximateAdditiveQuadruples] using h hT hN hNT hlo hs hi

open Density.GuthMaynard in
/-- A literal sample/quadruple statement checks all Proposition 11.1 powers. -/
theorem layer4_guth_large_values_energy_comparator : GuthMaynardLargeValuesEnergyBenchmark := by
  intro ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := gmEnergy_prop11_1_native ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro N T σ W b hN hT hNT hlo hs hi hb hv
  simpa only [ApproxAddEnergy,approximateAdditiveQuadruples,sourceDirichletPoly,dyadicInterval] using
    h N T σ W b hN hT hNT hlo hs hi hb hv

open Density.GuthMaynard in
/-- All four terms and source hypotheses remain visible after energy substitution. -/
theorem layer4_guth_energy_s3_comparator : GuthMaynardEnergyS3Benchmark := by
  intro cutoff ε hε
  obtain ⟨C,T₀,hC,hT₀,h⟩ := gmCubicS3_prop11_2_native cutoff ε hε
  refine ⟨C,T₀,hC,hT₀,?_⟩
  intro N T σ W b hN hT hNT hlo hs hi hb hv
  simpa only [sourceDirichletPoly,dyadicInterval] using h N T σ W b hN hT hNT hlo hs hi hb hv

open Density.GuthMaynard in
/-- The literal closed-sum comparator uses the native endpoint bridge. -/
theorem layer4_guth_published_large_values_comparator : GuthMaynardPublishedLargeValuesBenchmark := by
  simpa only [PublishedGuthMaynardLargeValues, GuthMaynardPublishedLargeValuesBenchmark,
    publishedSourceDirichletPoly, publishedDyadicInterval, IsSeparated, InBaseInterval] using
    guthMaynardLargeValues_published_native

/-- Exactly the open middle interval remains; an equivalence does not supply its input. -/
theorem guthMaynard_density_iff_central :
    GuthMaynard2024Density ↔ GuthMaynard2024CentralDensity := by
  constructor
  · intro h ε hε
    obtain ⟨C,hC,hb⟩ := h ε hε
    refine ⟨C,hC,?_⟩
    intro σ hσ T hT
    exact hb σ ⟨by linarith [hσ.1],by linarith [hσ.2]⟩ T hT
  · intro h ε hε
    obtain ⟨C,hC,hout⟩ := layer4_guth_maynard_outer_comparator ε hε
    obtain ⟨D,hD,hmid⟩ := h ε hε
    refine ⟨C+D,by positivity,?_⟩
    intro σ hσ T hT
    by_cases ho : σ ≤ 7/10 ∨ 4/5 ≤ σ
    · have hc := hout σ hσ ho T hT
      exact hc.trans (mul_le_mul_of_nonneg_right (show C ≤ C+D by linarith) (by positivity))
    · have hm := not_or.mp ho
      have hc := hmid σ ⟨lt_of_not_ge hm.1,lt_of_not_ge hm.2⟩ T hT
      exact hc.trans (mul_le_mul_of_nonneg_right (show D ≤ C+D by linarith) (by positivity))

/-- The newer curved bound combines with Ingham to give 30/13, not 12/5. -/
theorem guthMaynard_global_comparator (hi : Ingham1940Density)
    (hg : GuthMaynard2024Density) : Zeta.HasZeroDensityEstimate (30/13) := by
  apply (densityPower_iff _).1
  apply densityPower_of_two hi hg
  intro σ hσ
  have hnonneg : 0 ≤ 1-σ := by linarith [hσ.2]
  by_cases hs : σ ≤ 7/10
  · left
    have hd : 0 < 2-σ := by linarith
    have hb : (3 : ℝ)/(2-σ) ≤ 30/13 := (div_le_iff₀ hd).2 (by linarith)
    calc
      _ = (3/(2-σ))*(1-σ) := by ring
      _ ≤ _ := mul_le_mul_of_nonneg_right hb hnonneg
  · right
    have hd : 0 < 3+5*σ := by linarith
    have hb : (15 : ℝ)/(3+5*σ) ≤ 30/13 := (div_le_iff₀ hd).2 (by linarith)
    calc
      _ = (15/(3+5*σ))*(1-σ) := by ring
      _ ≤ _ := mul_le_mul_of_nonneg_right hb hnonneg

/-- Cramer's conjectural logarithmic gap has every positive power as an upper bound. -/
theorem cramer_positive_exponent {δ : ℝ} (hδ : 0 < δ) (h : CramerGapBound) :
    ShortIntervalExponent δ := by
  obtain ⟨C,hC,hgap⟩ := h
  have hlog : ∀ᶠ x : ℝ in atTop, (Real.log x)^2 ≤ x^δ := by
    have hb := (isLittleO_log_rpow_rpow_atTop (2 : ℝ) hδ).eventuallyLE
    filter_upwards [hb,eventually_gt_atTop (1 : ℝ)] with x hx hx1
    have hh : |(Real.log x)^2| ≤ x^δ := by
      simpa only [Real.norm_eq_abs,Real.rpow_two,
        abs_of_nonneg (Real.rpow_nonneg (by linarith : 0 ≤ x) δ)] using! hx
    exact (le_abs_self _).trans hh
  refine ⟨C,hC,?_⟩
  filter_upwards [hgap,tendsto_natCast_atTop_atTop.eventually hlog] with p hp hplog hprime
  obtain ⟨q,hq,hlo,hhi⟩ := hp hprime
  exact ⟨q,hq,hlo,hhi.trans (mul_le_mul_of_nonneg_left hplog hC.le)⟩

/-- The missing Layer 0 conditional bridge is supplied without assuming Cramer's conjecture. -/
theorem cramer_implies_eventual_legendre (h : CramerGapBound) :
    ∀ᶠ n : ℕ in atTop, LegendreAt n :=
  legendre_eventually_of_shortIntervalExponent_lt_half (by norm_num : (0 : ℝ) ≤ 1/4)
    (by norm_num) (cramer_positive_exponent (by norm_num) h)

/-- The logarithm costs an arbitrary positive epsilon, not an unconditional RH proof. -/
theorem rhGap_exponent_comparator (h : RHGapBound) : ForwardProgress (1/2) := by
  apply (forwardProgress_iff _).2
  apply statement_of_shortIntervalExponentLimit (by norm_num)
  intro ε hε
  obtain ⟨C,hC,hgap⟩ := h
  have hlog : ∀ᶠ x : ℝ in atTop, Real.log x ≤ x^ε := by
    filter_upwards [(isLittleO_log_rpow_atTop hε).eventuallyLE,
      eventually_gt_atTop (0 : ℝ)] with x hx hx0
    have hh : |Real.log x| ≤ x^ε := by
      simpa only [Real.norm_eq_abs,abs_of_pos (Real.rpow_pos_of_pos hx0 ε)] using hx
    exact (le_abs_self _).trans hh
  refine ⟨C,hC,?_⟩
  filter_upwards [tendsto_natCast_atTop_atTop.eventually hgap,
    tendsto_natCast_atTop_atTop.eventually hlog,eventually_ge_atTop (1 : ℕ)]
      with p hp hplog hp1 hprime
  obtain ⟨q,hq,hlo,hhi⟩ := hp
  have hppos : (0 : ℝ) < p := by exact_mod_cast hp1
  have hqp : p < q := by exact_mod_cast hlo
  refine ⟨q,hq,hqp,?_⟩
  have hh : (q : ℝ)-p ≤ C*(p : ℝ)^(1/2 : ℝ)*Real.log p := by
    rw [Real.sqrt_eq_rpow] at hhi
    linarith
  calc
    _ ≤ C*(p : ℝ)^(1/2 : ℝ)*Real.log p := hh
    _ ≤ C*(p : ℝ)^(1/2 : ℝ)*(p : ℝ)^ε :=
      mul_le_mul_of_nonneg_left hplog (by positivity)
    _ = _ := by rw [mul_assoc,← Real.rpow_add hppos]

end Legendre.Literature
