/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local deductions: height subdivision turns actual analytic Halasz energy
into a large-value count when the local scale absorbs its R sqrt(H) term.
-/
module
public import Legendre.Layer4.Exponential.HeightSubdivision
public import Legendre.Layer4.Exponential.HalaszTranslation

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def halaszRealPartCost (U : ℕ) : ℝ := 2+(Real.log (2*U))^2

theorem halaszRealPartCost_pos (U : ℕ) : 0 < halaszRealPartCost U := by
  unfold halaszRealPartCost
  positivity

/-- Absorb the sample-count term on one translated window. -/
theorem halasz_complex_window_count {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (center H σ b W : ℝ) (hH : 1 ≤ H) (hW : 0 < W)
    (hσb : σ ≤ b) (hlen : b-σ ≤ 1) (hβ : ∀ i ∈ S, β i ∈ Icc σ b)
    (ht : ∀ i ∈ S, |t i-center| ≤ H)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖)
    (hsmall : halaszRealPartCost U*logarithmicKernelConstant*Real.sqrt (2*H)*
      coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) ≤ W^2/2) :
    (S.card : ℝ) ≤
      (2*halaszRealPartCost U*(U : ℝ)*(1+2*logarithmicKernelConstant*(1+Real.log (2*H)))*
        coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ))/W^2 := by
  have hh := halasz_block_complex_centered S t β U hU a center H σ b hH hσb hlen hβ ht hs
  have hl : (S.card : ℝ)*W^2 ≤ ∑ i ∈ S,
      ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖^2 := by
    have hb := Finset.sum_le_sum (s := S) (fun i hi => pow_le_pow_left₀ hW.le (hw i hi) 2)
    simpa only [Finset.sum_const,nsmul_eq_mul] using hb
  have hsR := mul_le_mul_of_nonneg_left hsmall (Nat.cast_nonneg S.card : (0 : ℝ) ≤ S.card)
  apply (le_div_iff₀ (sq_pos_of_pos hW)).mpr
  simp only [halaszBlockCoefficient,halaszRealPartCost] at hh hsmall hsR ⊢
  nlinarith

/-- A local absorption scale gives a global count with explicit window overhead. -/
theorem halasz_complex_card_of_scale {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (T H σ b W : ℝ)
    (hT : 1 ≤ T) (hH : 1 ≤ H) (hW : 0 < W)
    (hσb : σ ≤ b) (hlen : b-σ ≤ 1) (hβ : ∀ i ∈ S, β i ∈ Icc σ b)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖)
    (hsmall : halaszRealPartCost U*logarithmicKernelConstant*Real.sqrt (2*H)*
      coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) ≤ W^2/2) :
    (S.card : ℝ) ≤ (1+2*T/H)*
      ((2*halaszRealPartCost U*(U : ℝ)*(1+2*logarithmicKernelConstant*(1+Real.log (2*H)))*
        coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ))/W^2) := by
  have hC := logarithmicKernelConstant_pos
  have hB := halaszRealPartCost_pos U
  have hE := coefficientEnergy_nonneg (Finset.Ioc U (2*U)) (verticalCoefficients a σ)
  have hL : 0 ≤ Real.log (2*H) := Real.log_nonneg (by linarith)
  apply height_subdivision_card S t T H _ (by linarith) (by linarith) (by positivity) ht
  intro j hj
  exact halasz_complex_window_count (heightBin S t T H j) t β U hU a
    ((j : ℝ)*H-T) H σ b W hH hW hσb hlen
    (fun i hi => hβ i (heightBin_subset S t T H j hi))
    (fun i hi => heightBin_centered S t T H (by linarith) ht j i hi)
    (fun i hi k hk hik => hs i (heightBin_subset S t T H j hi) k
      (heightBin_subset S t T H j hk) hik)
    (fun i hi => hw i (heightBin_subset S t T H j hi)) hsmall

end Legendre.Density.Oscillation
