/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local restricted curved Huxley density theorem. The height-cover and
multiplicity interfaces are the same proved interfaces used by HuxleyDensity.
The real-part range ends at 5/6; this is not the full literature benchmark.
-/
module
public import Legendre.Layer4.HuxleyCurvedShell
public import Legendre.Layer4.DyadicHeightDensity

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

theorem huxley_curved_exponent_bounds (σ : ℝ) (hσ : 3/4 ≤ σ) (hσu : σ ≤ 5/6) :
    0 ≤ huxleyCurvedExponent σ ∧ huxleyCurvedExponent σ ≤ 1 := by
  have hd : 0 < 3*σ-1 := by linarith
  unfold huxleyCurvedExponent
  constructor
  · exact div_nonneg (by linarith) hd.le
  · apply (div_le_one hd).mpr
    linarith

/-- A full high-height cover retains a single logarithmic loss. -/
theorem huxley_curved_separated_high_density (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 3/4 ≤ σ → σ ≤ 5/6 →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, 64 < |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^(huxleyCurvedExponent σ+ε)*(1+Real.log T) := by
  classical
  obtain ⟨C,hC,hc⟩ := huxley_curved_separated_high_shell_density ε hε
  let D := (128 : ℝ)^(1+ε)
  have hD : 0 < D := by dsimp [D]; positivity
  refine ⟨C*D*(2/Real.log 2),by positivity,?_⟩
  intro T σ hT hσ hσu ι S t β ht hs hz
  obtain ⟨J,hJl,hJu,hJlog⟩ := real_height_dyadic_cover T (by linarith)
  have hcard := height_shell_card_le S t J (fun i hi => (ht i hi).1)
    (by intro i hi; exact (ht i hi).2.trans (by nlinarith))
  have hsum : ∀ j ∈ Finset.range J,
      ((S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)).card : ℝ) ≤
        C*D*T^(huxleyCurvedExponent σ+ε) := by
    intro j hj
    let F := S.filter (fun i => 64*(2 : ℝ)^j < |t i| ∧ |t i| ≤ 128*(2 : ℝ)^j)
    have hpow : (1 : ℝ) ≤ 2^j := one_le_pow₀ (by norm_num)
    have hupper : 128*(2 : ℝ)^j ≤ 128*T := by
      have hp : (2 : ℝ)^(j+1) ≤ 2^J := pow_le_pow_right₀ (by norm_num) (Finset.mem_range.mp hj)
      rw [pow_succ] at hp
      nlinarith
    have hf := hc (128*(2 : ℝ)^j) σ (by nlinarith) hσ hσu F t β
      (by intro i hi; have hh := (Finset.mem_filter.mp hi).2; constructor <;> linarith [hh.1,hh.2])
      (fun i hi k hk hik => hs i (Finset.mem_filter.mp hi).1 k (Finset.mem_filter.mp hk).1 hik)
      (fun i hi => hz i (Finset.mem_filter.mp hi).1)
    have hb := huxley_curved_exponent_bounds σ hσ hσu
    have hp : (128*(2 : ℝ)^j)^(huxleyCurvedExponent σ+ε) ≤ D*T^(huxleyCurvedExponent σ+ε) := by
      calc
        _ ≤ (128*T)^(huxleyCurvedExponent σ+ε) :=
          Real.rpow_le_rpow (by positivity) hupper (by linarith)
        _ = (128 : ℝ)^(huxleyCurvedExponent σ+ε)*T^(huxleyCurvedExponent σ+ε) :=
          Real.mul_rpow (by norm_num) (by linarith)
        _ ≤ _ := mul_le_mul_of_nonneg_right
          (Real.rpow_le_rpow_of_exponent_le (by norm_num : (1 : ℝ) ≤ 128) (by linarith)) (by positivity)
    exact hf.trans (by nlinarith [mul_le_mul_of_nonneg_left hp hC.le])
  apply (hcard.trans (Finset.sum_le_sum hsum)).trans
  rw [Finset.sum_const,Finset.card_range,nsmul_eq_mul]
  have hJ : (J : ℝ) ≤ (2/Real.log 2)*(1+Real.log T) := by
    apply hJlog.trans
    exact mul_le_mul_of_nonneg_left (by linarith : Real.log T ≤ 1+Real.log T) (by positivity)
  have hh := mul_le_mul_of_nonneg_right hJ (show 0 ≤ C*D*T^(huxleyCurvedExponent σ+ε) by positivity)
  convert hh using 1 <;> ring

end Legendre.Density.Moment

namespace Legendre.Zeta
open Complex Set Density.Moment
open scoped BigOperators

/-- Restricted curved density with all analytic multiplicities and every T>=2. -/
theorem huxley_curved_middle_density_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (3/4 : ℝ) (5/6), ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^(3*(1-σ)/(3*σ-1)+ε) := by
  intro ε hε
  obtain ⟨C,hC,hc⟩ := huxley_curved_separated_high_density (ε/2) (by linarith)
  obtain ⟨E,hE,hlogs⟩ := exists_one_add_log_pow_le_rpow 2 (ε/2) (by linarith)
  let D := (zeroCount 128 : ℝ)+1
  let A := 2*densitySelectionConstant*C
  have hD : 0 < D := by dsimp [D]; positivity
  have hA : 0 < A := by have := densitySelectionConstant_pos; dsimp [A]; positivity
  refine ⟨D+A*E,by positivity,?_⟩
  intro σ hσ T hT
  have hTp : 0 < T := by linarith
  have hb := huxley_curved_exponent_bounds σ hσ.1 hσ.2
  have hunit : 1 ≤ T^(huxleyCurvedExponent σ+ε) := Real.one_le_rpow (by linarith) (by linarith)
  have hlow : (zeroCount 128 : ℝ) ≤ D*T^(huxleyCurvedExponent σ+ε) := by
    have hh := mul_le_mul_of_nonneg_left hunit hD.le
    dsimp [D] at hh ⊢
    nlinarith
  change (zeroDensityCount σ T : ℝ) ≤ (D+A*E)*T^(huxleyCurvedExponent σ+ε)
  by_cases hlarge : 128 ≤ T
  · have hcount := zeroDensityCount_le_of_cutoff_sample_bound σ 64 (by linarith : 7 ≤ T)
      (B := C*T^(huxleyCurvedExponent σ+ε/2)*(1+Real.log T)) (by
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
    have hL : 1 ≤ 1+Real.log T := (height_log_costs T hT).1
    have hu : 2*densitySelectionConstant*Real.log T*
        (C*T^(huxleyCurvedExponent σ+ε/2)*(1+Real.log T)) ≤
          (A*E)*T^(huxleyCurvedExponent σ+ε) := by
      calc
        _ ≤ A*T^(huxleyCurvedExponent σ+ε/2)*(1+Real.log T)^2 := by
          have hh := mul_le_mul_of_nonneg_left (show Real.log T ≤ 1+Real.log T by linarith)
            (show 0 ≤ 2*densitySelectionConstant*C*T^(huxleyCurvedExponent σ+ε/2)*(1+Real.log T) by positivity)
          convert hh using 1 <;> (try dsimp [A]) <;> ring
        _ ≤ A*T^(huxleyCurvedExponent σ+ε/2)*(E*T^(ε/2)) :=
          mul_le_mul_of_nonneg_left (hlogs T hT) (by positivity)
        _ = _ := by
          have he : T^(huxleyCurvedExponent σ+ε/2)*T^(ε/2) = T^(huxleyCurvedExponent σ+ε) := by
            rw [←Real.rpow_add hTp]
            congr 1
            ring
          calc
            _ = (A*E)*(T^(huxleyCurvedExponent σ+ε/2)*T^(ε/2)) := by ring
            _ = _ := by rw [he]
    have hh := hcount.trans (add_le_add hlown hu)
    nlinarith
  · have hn : (zeroDensityCount σ T : ℝ) ≤ (zeroCount 128 : ℝ) := by
      exact_mod_cast (zeroDensityCount_le σ T).trans (zeroCount_mono (le_of_not_ge hlarge))
    have ha : 0 ≤ A*E*T^(huxleyCurvedExponent σ+ε) := by positivity
    nlinarith

/-- Ingham fills the lower real parts, retaining one coefficient on [1/2,5/6]. -/
theorem huxley_curved_restricted_density_epsilon :
    ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, 0 < C ∧ ∀ σ ∈ Icc (1/2 : ℝ) (5/6), ∀ T : ℝ, 2 ≤ T →
      (zeroDensityCount σ T : ℝ) ≤ C*T^(3*(1-σ)/(3*σ-1)+ε) := by
  intro ε hε
  obtain ⟨CI,hCI,hi⟩ := ingham_density_epsilon ε hε
  obtain ⟨CH,hCH,hh⟩ := huxley_curved_middle_density_epsilon ε hε
  refine ⟨CI+CH,by positivity,?_⟩
  intro σ hσ T hT
  have hσlo := hσ.1
  have hσhi := hσ.2
  by_cases hlow : σ ≤ 3/4
  · have hexp : 3*(1-σ)/(2-σ) ≤ 3*(1-σ)/(3*σ-1) := by
      exact div_le_div₀ (by linarith) le_rfl (by linarith) (by linarith)
    have hc := hi σ ⟨hσ.1,by linarith [hσ.2]⟩ T hT
    have hp := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith)
      (add_le_add hexp (le_rfl : ε ≤ ε))
    have hC : CI ≤ CI+CH := by linarith
    exact hc.trans (mul_le_mul hC hp (by positivity) (by positivity))
  · have hc := hh σ ⟨by linarith,hσ.2⟩ T hT
    exact hc.trans (mul_le_mul_of_nonneg_right (show CH ≤ CI+CH by linarith) (by positivity))

end Legendre.Zeta
