/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions: optimize the analytic Halasz bound on short windows;
finite Cauchy and unit separation handle the complementary dense regime.
-/
module
public import Legendre.Layer4.Exponential.HalaszSparseCount
public import Legendre.Layer4.Exponential.HalaszPointwise
public import Legendre.Layer4.NearCriticalDensity

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

/-- Unconditional large-value count, including independently varying real parts. -/
theorem halasz_complex_large_values {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (T σ b W : ℝ) (hT : 1 ≤ T) (hW : 0 < W)
    (hσb : σ ≤ b) (hlen : b-σ ≤ 1) (hβ : ∀ i ∈ S, β i ∈ Icc σ b)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖) :
    (S.card : ℝ) ≤ halaszLargeValueBound U T
      (coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ)) W := by
  classical
  let E := coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ)
  let B := halaszRealPartCost U
  have hC := logarithmicKernelConstant_pos
  have hB := halaszRealPartCost_pos U
  by_cases hS : S.Nonempty
  · obtain ⟨i,hi⟩ := hS
    have hpoint : W^2 ≤ (U : ℝ)*E :=
      (pow_le_pow_left₀ hW.le (hw i hi) 2).trans
        (complex_block_pointwise_sq U a σ (β i) (t i) (hβ i hi).1)
    have hE : 0 < E := by
      by_contra hh
      have he := mul_nonpos_of_nonneg_of_nonpos (Nat.cast_nonneg U : (0 : ℝ) ≤ U)
        (le_of_not_gt hh)
      nlinarith [sq_pos_of_pos hW]
    by_cases hsparse : 4*B*logarithmicKernelConstant*E ≤ W^2
    · exact halasz_complex_sparse_count S t β U hU a T σ b W hT hW hσb hlen hβ ht hs hw hE hsparse
    · have hd : W^2 ≤ 4*B*logarithmicKernelConstant*E := le_of_lt (lt_of_not_ge hsparse)
      have hR := Moment.indexed_separated_card S t T (by linarith) ht hs
      have hRT : (S.card : ℝ) ≤ 4*T := by nlinarith
      have hBtwo : (2 : ℝ) ≤ B := by dsimp [B,halaszRealPartCost]; nlinarith [sq_nonneg (Real.log (2*U))]
      have hL0 : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
      have hL : 1 ≤ 1+2*logarithmicKernelConstant*(1+Real.log (2*T)) := by
        have hh : 0 ≤ 2*logarithmicKernelConstant*(1+Real.log (2*T)) := by positivity
        linarith
      have hUE : 1 ≤ (U : ℝ)*E/W^2 := (le_div_iff₀ (sq_pos_of_pos hW)).mpr (by simpa using hpoint)
      have hA : 4 ≤ (2*B*(U : ℝ)*(1+2*logarithmicKernelConstant*(1+Real.log (2*T)))*E)/W^2 := by
        calc
          4 = 2*(2 : ℝ)*1*1 := by norm_num
          _ ≤ 2*B*(1+2*logarithmicKernelConstant*(1+Real.log (2*T)))*((U : ℝ)*E/W^2) := by gcongr
          _ = _ := by ring
      have hd2 := pow_le_pow_left₀ (sq_nonneg W) hd 2
      have hTd := mul_le_mul_of_nonneg_left hd2 (by linarith : 0 ≤ T)
      have hratio : T ≤ 16*T*B^2*logarithmicKernelConstant^2*E^2/W^4 := by
        apply (le_div_iff₀ (pow_pos hW 4)).mpr
        nlinarith
      have hbracket : T ≤ 3+16*T*B^2*logarithmicKernelConstant^2*E^2/W^4 := by linarith
      have hprod := mul_le_mul hbracket hA (by norm_num : (0 : ℝ) ≤ 4)
        (by positivity : 0 ≤ 3+16*T*B^2*logarithmicKernelConstant^2*E^2/W^4)
      apply hRT.trans
      change 4*T ≤ (3+16*T*B^2*logarithmicKernelConstant^2*E^2/W^4)*
        ((2*B*(U : ℝ)*(1+2*logarithmicKernelConstant*(1+Real.log (2*T)))*E)/W^2)
      nlinarith
  · have he : S = ∅ := Finset.not_nonempty_iff_eq_empty.mp hS
    rw [he,Finset.card_empty,Nat.cast_zero]
    exact halaszLargeValueBound_nonneg U T _ W hT (coefficientEnergy_nonneg _ _)

end Legendre.Density.Oscillation
