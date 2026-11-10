/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local full-polynomial large-value count; all logarithmic losses are explicit.
-/
module
public import Legendre.Layer4.Exponential.CriticalBlockCount

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def criticalPolynomialCountConstant : ℝ :=
  256*halaszCountConstant*4^6*(2/Real.log 2)^7

theorem criticalPolynomialCountConstant_pos : 0 < criticalPolynomialCountConstant := by
  have := halaszCountConstant_pos
  have : 0 < Real.log 2 := Real.log_pos (by norm_num)
  unfold criticalPolynomialCountConstant
  positivity

/-- Actual critical-line values of any polynomial with coefficients bounded by one. -/
theorem critical_polynomial_count {ι : Type*} (S : Finset ι) (t : ι → ℝ)
    (X : ℕ) (hX : 1 ≤ X) (a : ℕ → ℂ) (ha : ∀ n, ‖a n‖ ≤ 1)
    (T W : ℝ) (hT : 1 ≤ T) (hW : 2 ≤ W)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖complexDirichletPolynomial X a
      ((1/2 : ℂ)+(t i : ℂ)*I)‖) :
    (S.card : ℝ) ≤ criticalPolynomialCountConstant*(X : ℝ)*(1+Real.log X)^13*
      (1+Real.log (2*T))*(1/W^2+T/W^6) := by
  have hXr : (1 : ℝ) ≤ X := by exact_mod_cast hX
  have hXp : (0 : ℝ) < X := by linarith
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hlog21 : Real.log 2 ≤ 1 := by
    have := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
    linarith
  let L := 1+Real.log X
  let c := 2/Real.log 2
  have hL : 1 ≤ L := by dsimp [L]; linarith [Real.log_nonneg hXr]
  have hc : 0 < c := by dsimp [c]; positivity
  obtain ⟨J,hJl,hJu,hJlog⟩ := Moment.real_height_dyadic_cover ((X : ℝ)+1) (by linarith)
  have hJ : 1 ≤ J := by
    by_contra hh
    have : J = 0 := by omega
    simp only [this,pow_zero] at hJl
    linarith
  have hcover : X ≤ 2^J := by exact_mod_cast (show (X : ℝ) ≤ (2 : ℝ)^J by linarith)
  have hN : (2 : ℝ)^J ≤ 4*X := by linarith
  have hlogX : Real.log ((X : ℝ)+1) ≤ L := by
    have hh := Real.log_le_log (by linarith : 0 < (X : ℝ)+1) (show (X : ℝ)+1 ≤ 2*X by linarith)
    rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hXp.ne'] at hh
    dsimp [L]
    linarith
  have hJL : (J : ℝ) ≤ c*L := hJlog.trans (mul_le_mul_of_nonneg_left hlogX hc.le)
  have hlogN : 1+Real.log (2*(2 : ℝ)^J) ≤ 4*L := by
    have hh := Real.log_le_log (by positivity : 0 < 2*(2 : ℝ)^J)
      (show 2*(2 : ℝ)^J ≤ 8*X by linarith)
    have h8 : Real.log (8 : ℝ) ≤ 3 := by
      have he : Real.log (8 : ℝ) = 3*Real.log 2 := by
        rw [show (8 : ℝ) = 2^3 by norm_num,Real.log_pow]; norm_num
      rw [he]; linarith
    rw [Real.log_mul (by norm_num : (8 : ℝ) ≠ 0) hXp.ne'] at hh
    dsimp [L]
    linarith [Real.log_nonneg hXr]
  have hh := critical_polynomial_count_dyadic S t X J hX hJ hcover a ha T W hT hW ht hs hw
  have hK := halaszCountConstant_pos
  have hTlog : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
  have hlogN0 : 0 ≤ 1+Real.log (2*(2 : ℝ)^J) := by
    have := Real.log_nonneg (show 1 ≤ 2*(2 : ℝ)^J by
      nlinarith [one_le_pow₀ (by norm_num : (1 : ℝ) ≤ 2) (n := J)])
    linarith
  have hcost : halaszCountConstant*(1+Real.log (2*(2 : ℝ)^J))^6*
      (1+Real.log (2*T))*(2 : ℝ)^J*(2*(J : ℝ))^6*(J : ℝ) ≤
      halaszCountConstant*(4*L)^6*(1+Real.log (2*T))*(4*X)*(2*(c*L))^6*(c*L) := by
    gcongr
  have hb := mul_le_mul_of_nonneg_right hcost
    (show 0 ≤ 1/W^2+T/W^6 by positivity)
  apply hh.trans
  convert hb using 1 <;> dsimp [criticalPolynomialCountConstant,L,c] <;> ring

end Legendre.Density.Oscillation
