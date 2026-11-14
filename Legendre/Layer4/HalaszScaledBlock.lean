/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local coefficient normalization for the proved analytic block count.
-/
module
public import Legendre.Layer4.HalaszDivisorBlock

@[expose] public section
namespace Legendre.Density.Moment
open Complex Set
open scoped BigOperators

/-- Explicit coefficient amplitude is retained in the literal large-value threshold. -/
theorem halasz_scaled_divisor_block_count {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (X U : ℕ) (hX : 1 ≤ X) (hXU : X ≤ U) (a : ℕ → ℂ) (T Y σ W A : ℝ)
    (hT : 1 ≤ T) (hY : 2 ≤ Y) (hUY : (U : ℝ) ≤ Y)
    (hσ : 2/3 ≤ σ) (hσ1 : σ ≤ 1) (hW : 0 < W) (hA : 0 < A)
    (ht : ∀ i ∈ S, |t i| ≤ T) (hβ : ∀ i ∈ S, β i ∈ Icc σ 1)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (ha : ∀ n ∈ Finset.Ioc U (2*U), ‖a n‖ ≤ A*(n.divisors.card : ℝ))
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
      a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) :
    (S.card : ℝ) ≤ 8*Oscillation.halaszCountConstant*(1+Real.log (2*Y+1))^15*
      (1+Real.log (2*T))*(Y^(2-2*σ)/(W/A)^2+T*(X : ℝ)^(4-6*σ)/(W/A)^6) := by
  let b : ℕ → ℂ := fun n => a n/(A : ℂ)
  have hnorm (n : ℕ) : ‖b n‖ = ‖a n‖/A := by
    simp only [b,norm_div,Complex.norm_real,Real.norm_eq_abs,abs_of_pos hA]
  have hb (n : ℕ) (hn : n ∈ Finset.Ioc U (2*U)) : ‖b n‖ ≤ (n.divisors.card : ℝ) := by
    rw [hnorm,div_le_iff₀ hA]
    simpa only [mul_comm] using ha n hn
  have hlarge (i : ι) (hi : i ∈ S) : W/A ≤ ‖∑ n ∈ Finset.Ioc U (2*U),
      b n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖ := by
    have he : (∑ n ∈ Finset.Ioc U (2*U),
        b n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))) =
        (∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I)))/(A : ℂ) := by
      rw [Finset.sum_div]
      apply Finset.sum_congr rfl
      intro n _
      dsimp [b]
      ring
    rw [he,norm_div,Complex.norm_real,Real.norm_eq_abs,abs_of_pos hA]
    exact div_le_div_of_nonneg_right (hw i hi) hA.le
  exact halasz_divisor_block_count S t β X U hX hXU b T Y σ (W/A)
    hT hY hUY hσ hσ1 (div_pos hW hA) ht hβ hs hb hlarge

end Legendre.Density.Moment
