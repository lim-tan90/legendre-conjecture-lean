/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local uniform assembly across the transition real part 5/6. The upper
shell count is proved using actual detector branches, not assumed.
-/
module
public import Legendre.Layer4.UpperHuxleyShell
public import Legendre.Layer4.HuxleyCurvedShell

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- The curved exponent is nonnegative and at most one on the full upper range. -/
theorem huxley_full_curved_exponent_bounds (σ : ℝ) (hσ : 3/4 ≤ σ) (hσ1 : σ ≤ 1) :
    0 ≤ huxleyCurvedExponent σ ∧ huxleyCurvedExponent σ ≤ 1 := by
  have hd : 0 < 3*σ-1 := by linarith
  unfold huxleyCurvedExponent
  constructor
  · exact div_nonneg (by linarith) hd.le
  · apply (div_le_one hd).mpr
    linarith

/-- Moving right from 5/6 loses at most 8/3 times the real-part displacement. -/
theorem huxley_transition_exponent_loss (σ : ℝ) (hσ : 5/6 ≤ σ) :
    1/3-huxleyCurvedExponent σ ≤ (8/3)*(σ-5/6) := by
  have hd : 0 < 3*σ-1 := by linarith
  have he : 1/3-huxleyCurvedExponent σ = 4*(σ-5/6)/(3*σ-1) := by
    unfold huxleyCurvedExponent
    field_simp
    ring
  rw [he]
  apply (div_le_iff₀ hd).mpr
  nlinarith [sq_nonneg (σ-5/6)]

/-- One coefficient covers all sigma in [3/4,1], including the transition band. -/
theorem huxley_full_separated_high_shell_density (ε : ℝ) (hε : 0 < ε) :
    ∃ C : ℝ, 0 < C ∧ ∀ T σ : ℝ, 128 ≤ T → 3/4 ≤ σ → σ ≤ 1 →
      ∀ {ι : Type*} (S : Finset ι) (t β : ι → ℝ),
      (∀ i ∈ S, T/2 ≤ |t i| ∧ |t i| ≤ T) →
      (∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) →
      (∀ i ∈ S, σ ≤ β i ∧ β i ≤ 1 ∧ riemannZeta ((β i : ℂ)+(t i : ℂ)*I) = 0) →
      (S.card : ℝ) ≤ C*T^(huxleyCurvedExponent σ+ε) := by
  let η := ε/16
  have hη : 0 < η := by dsimp [η]; linarith
  obtain ⟨C,hC,hm⟩ := huxley_curved_separated_high_shell_density (ε/2) (by linarith)
  obtain ⟨D,hD,hu⟩ := huxley_upper_separated_shell_density η (ε/2) hη (by linarith)
  refine ⟨C+D,by positivity,?_⟩
  intro T σ hT hσ hσ1 ι S t β ht hs hz
  by_cases hmid : σ ≤ 5/6
  · have hc := hm T σ hT hσ hmid S t β ht hs hz
    have hp := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith)
      (show huxleyCurvedExponent σ+ε/2 ≤ huxleyCurvedExponent σ+ε by linarith)
    exact hc.trans (mul_le_mul (show C ≤ C+D by linarith) hp (by positivity) (by positivity))
  · by_cases hupper : 5/6+η ≤ σ
    · have hc := hu T σ hT hupper hσ1 S t β ht hs hz
      have hp := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith)
        (show huxleyCurvedExponent σ+ε/2 ≤ huxleyCurvedExponent σ+ε by linarith)
      exact hc.trans (mul_le_mul (show D ≤ C+D by linarith) hp (by positivity) (by positivity))
    · have hc := hm T (5/6) hT (by norm_num) le_rfl S t β ht hs
        (fun i hi => ⟨by linarith [(hz i hi).1],(hz i hi).2⟩)
      norm_num [huxleyCurvedExponent] at hc
      have hloss := huxley_transition_exponent_loss σ (le_of_not_ge hmid)
      have hexp : (1/3 : ℝ)+ε/2 ≤ huxleyCurvedExponent σ+ε := by
        dsimp [η] at hupper
        linarith [lt_of_not_ge hupper]
      have hp := Real.rpow_le_rpow_of_exponent_le (show 1 ≤ T by linarith) hexp
      exact hc.trans (mul_le_mul (show C ≤ C+D by linarith) hp (by positivity) (by positivity))

end Legendre.Density.Moment
