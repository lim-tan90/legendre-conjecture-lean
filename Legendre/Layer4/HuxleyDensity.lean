/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions from the actual compact detector and analytic Halasz bounds.
Restore analytic multiplicities and low heights before combining with Ingham.
The global 12/5 exponent is distinct from the stronger curved Huxley target.
-/
module
public import Legendre.Layer4.HuxleyHeightDensity
public import Legendre.Layer4.InghamDensity

@[expose] public section
namespace Legendre.Zeta
open Complex Set Density.Moment
open scoped BigOperators

/-- All analytic multiplicities and the retained low-height range are included. -/
theorem huxley_book_density_log_bound :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (3/4 : ℝ) 1, ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^huxleyBookExponent σ*(1+Real.log T)^38 := by
  obtain ⟨C,hC,hc⟩ := huxley_separated_high_density
  let D := (zeroCount 128 : ℝ)+1
  let A := 2*densitySelectionConstant*C
  have hD : 0 < D := by dsimp [D]; positivity
  have hA : 0 < A := by have := densitySelectionConstant_pos; dsimp [A]; positivity
  refine ⟨D+A,by positivity,?_⟩
  intro σ hσ T hT
  have hL : 1 ≤ 1+Real.log T := (height_log_costs T hT).1
  have hM : 1 ≤ T^huxleyBookExponent σ := Real.one_le_rpow (by linarith)
    (huxley_book_exponent_bounds σ hσ.1 hσ.2).1
  have hunit : 1 ≤ T^huxleyBookExponent σ*(1+Real.log T)^38 :=
    one_le_mul_of_one_le_of_one_le hM (one_le_pow₀ hL)
  have hlow : (zeroCount 128 : ℝ) ≤ D*T^huxleyBookExponent σ*(1+Real.log T)^38 := by
    have hh := mul_le_mul_of_nonneg_left hunit hD.le
    dsimp [D] at hh ⊢
    nlinarith
  by_cases hlarge : 128 ≤ T
  · have hcount := zeroDensityCount_le_of_cutoff_sample_bound σ 64 (by linarith : 7 ≤ T)
      (B := C*T^huxleyBookExponent σ*(1+Real.log T)^37) (by
        intro S hS hheight hsep
        apply hc T σ hlarge hσ.1 hσ.2 S Complex.im Complex.re
        · intro ρ hρ
          rw [abs_of_pos (hS ρ hρ).1.2.1]
          exact ⟨hheight ρ hρ,(hS ρ hρ).1.2.2⟩
        · exact hsep
        · intro ρ hρ
          have hz := hS ρ hρ
          exact ⟨hz.2,hz.1.1.2.2.le,by simpa only [Complex.re_add_im] using hz.1.1.1⟩)
    have hlown : (zeroCount 64 : ℝ) ≤ (zeroCount 128 : ℝ) := by
      exact_mod_cast zeroCount_mono (show (64 : ℝ) ≤ 128 by norm_num)
    have hu : 2*densitySelectionConstant*Real.log T*
        (C*T^huxleyBookExponent σ*(1+Real.log T)^37) ≤ A*T^huxleyBookExponent σ*(1+Real.log T)^38 := by
      have hh := mul_le_mul_of_nonneg_left (show Real.log T ≤ 1+Real.log T by linarith)
        (show 0 ≤ 2*densitySelectionConstant*C*T^huxleyBookExponent σ*(1+Real.log T)^37 by positivity)
      convert hh using 1 <;> (try dsimp [A]) <;> ring
    have hh := hcount.trans (add_le_add hlown hu)
    nlinarith
  · have hn : (zeroDensityCount σ T : ℝ) ≤ (zeroCount 128 : ℝ) := by
      exact_mod_cast (zeroDensityCount_le σ T).trans (zeroCount_mono (le_of_not_ge hlarge))
    have ha : 0 ≤ A*T^huxleyBookExponent σ*(1+Real.log T)^38 := by positivity
    nlinarith

theorem ingham_exponent_le_twelve_fifths (σ : ℝ) (hσ : 1/2 ≤ σ) (hσu : σ ≤ 3/4) :
    balancedDensityExponent σ ≤ (12/5)*(1-σ) := by
  unfold balancedDensityExponent
  apply (div_le_iff₀ (show 0 < 2-σ by linarith)).mpr
  nlinarith [mul_nonneg (show 0 ≤ 1-σ by linarith) (show 0 ≤ 3/4-σ by linarith)]

/-- Uniform global density with the classical 12/5 exponent and a fixed log loss. -/
theorem huxley_global_density_log_bound :
    ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (1/2 : ℝ) 1, ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^((12/5 : ℝ)*(1-σ))*(1+Real.log T)^38 := by
  obtain ⟨CI,hCI,hi⟩ := ingham_density_log_bound
  obtain ⟨CH,hCH,hh⟩ := huxley_book_density_log_bound
  refine ⟨CI+CH,by positivity,?_⟩
  intro σ hσ T hT
  have hL : 1 ≤ 1+Real.log T := (height_log_costs T hT).1
  have hlogT : 0 ≤ Real.log T := (height_log_costs T hT).2.1
  by_cases hsmall : σ ≤ 3/4
  · have hp := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith)
      (ingham_exponent_le_twelve_fifths σ hσ.1 hsmall)
    have hl : (Real.log T)^10 ≤ (1+Real.log T)^38 :=
      (pow_le_pow_left₀ hlogT (show Real.log T ≤ 1+Real.log T by linarith) 10).trans
        (pow_le_pow_right₀ hL (by norm_num : (10 : ℕ) ≤ 38))
    have hprod := mul_le_mul (mul_le_mul_of_nonneg_left hp hCI.le) hl (by positivity) (by positivity)
    have hc : CI ≤ CI+CH := by linarith
    exact (hi σ hσ T hT).trans (hprod.trans
      (mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right hc (by positivity)) (by positivity)))
  · have hσhigh : σ ∈ Icc (3/4 : ℝ) 1 := ⟨by linarith,hσ.2⟩
    have hp := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith)
      (huxley_book_exponent_bounds σ hσhigh.1 hσhigh.2).2
    have hc : CH ≤ CI+CH := by linarith
    have hprod := mul_le_mul_of_nonneg_right (mul_le_mul hc hp (by positivity) (by positivity))
      (show 0 ≤ (1+Real.log T)^38 by positivity)
    exact (hh σ hσhigh T hT).trans hprod

/-- The global 12/5 zero-density estimate is proved, uniformly in sigma. -/
theorem hasZeroDensityEstimate_twelve_fifths : HasZeroDensityEstimate (12/5) := by
  intro ε hε
  obtain ⟨C,hC,hb⟩ := huxley_global_density_log_bound
  obtain ⟨D,hD,hlog⟩ := exists_log_pow_le_rpow 38 hε
  refine ⟨C*3^38*D,by positivity,?_⟩
  intro σ hσ T hT
  have hlT : 0 ≤ Real.log T := Real.log_nonneg (by linarith)
  have hlogcost : (1+Real.log T)^38 ≤ 3^38*(D*T^ε) := by
    have hp := pow_le_pow_left₀ (show 0 ≤ 1+Real.log T by linarith)
      (show 1+Real.log T ≤ 3*Real.log T by linarith [one_le_two_log T hT]) 38
    rw [mul_pow] at hp
    exact hp.trans (mul_le_mul_of_nonneg_left (hlog T hT) (by positivity))
  calc
    _ ≤ C*T^((12/5 : ℝ)*(1-σ))*(1+Real.log T)^38 := hb σ hσ T hT
    _ ≤ C*T^((12/5 : ℝ)*(1-σ))*(3^38*(D*T^ε)) :=
      mul_le_mul_of_nonneg_left hlogcost (by positivity)
    _ = _ := by rw [Real.rpow_add (by linarith : 0 < T)]; ring

end Legendre.Zeta
