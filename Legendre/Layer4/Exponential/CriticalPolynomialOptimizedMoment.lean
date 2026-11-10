/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local optimized sampled mean square for the actual critical-line polynomial.
-/
module
public import Legendre.Layer4.Exponential.CriticalPolynomialMoments
public import Legendre.Layer4.DistributionMomentCutoff

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def criticalPolynomialMomentCost (X : ℕ) (T : ℝ) : ℝ :=
  4+criticalPolynomialCountCost X T

theorem criticalPolynomialMomentCost_ge_four (X : ℕ) (hX : 1 ≤ X) (T : ℝ) (hT : 1 ≤ T) :
    4 ≤ criticalPolynomialMomentCost X T := by
  have := criticalPolynomialCountCost_nonneg X hX T hT
  unfold criticalPolynomialMomentCost
  linarith

/-- The mixed R^(2/3) (AT)^(1/3) term follows from the proved distribution bound. -/
theorem critical_polynomial_optimized_second_moment {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (X J : ℕ) (hX : 1 ≤ X) (hcover : X ≤ 2^J)
    (a : ℕ → ℂ) (ha : ∀ n, ‖a n‖ ≤ 1) (T c : ℝ) (hT : 1 ≤ T)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|) :
    (∑ i ∈ S, ‖complexDirichletPolynomial X a
      ((1/2 : ℂ)+((t i+c : ℝ) : ℂ)*I)‖^2) ≤
      4*criticalPolynomialMomentCost X T*(J : ℝ)+
        5*(S.card : ℝ)^(2/3 : ℝ)*(criticalPolynomialMomentCost X T*T)^(1/3 : ℝ) := by
  classical
  let A := criticalPolynomialMomentCost X T
  have hA4 : 4 ≤ A := criticalPolynomialMomentCost_ge_four X hX T hT
  have hA0 : 0 ≤ criticalPolynomialCountCost X T := criticalPolynomialCountCost_nonneg X hX T hT
  have hAA : criticalPolynomialCountCost X T ≤ A := by dsimp [A,criticalPolynomialMomentCost]; linarith
  by_cases hS : S.Nonempty
  · have hR : (0 : ℝ) < S.card := by exact_mod_cast Finset.card_pos.mpr hS
    have hRT := Moment.indexed_separated_card S t T (by linarith) ht hs
    have hRB : (S.card : ℝ) ≤ A*T := by nlinarith
    obtain ⟨V,hV,hcut⟩ := Moment.exists_balanced_moment_cutoff (S.card : ℝ) (A*T) hR hRB
    have hh := critical_polynomial_second_moment S t X J hX hcover a ha T c V hT hV ht hs
    have hAB : criticalPolynomialCountCost X T*T ≤ A*T := mul_le_mul_of_nonneg_right hAA (by linarith)
    have hb := div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hAB (by norm_num : (0 : ℝ) ≤ 8))
      (by positivity : 0 ≤ V^4)
    have hj := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hAA (by norm_num : (0 : ℝ) ≤ 4))
      (Nat.cast_nonneg J : (0 : ℝ) ≤ J)
    change _ ≤ 4*A*(J : ℝ)+5*(S.card : ℝ)^(2/3 : ℝ)*(A*T)^(1/3 : ℝ)
    linarith
  · have he : S = ∅ := Finset.not_nonempty_iff_eq_empty.mp hS
    rw [he,Finset.sum_empty]
    have hA : 0 ≤ criticalPolynomialMomentCost X T := by linarith
    positivity

end Legendre.Density.Oscillation
