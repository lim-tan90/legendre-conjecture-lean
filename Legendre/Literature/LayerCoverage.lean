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

/-- Closed proof of the 1940 curved density exponent, with multiplicities and uniform sigma. -/
theorem layer4_ingham_comparator : Ingham1940Density := Zeta.ingham_density_epsilon

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
