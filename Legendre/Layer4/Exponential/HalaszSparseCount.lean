/-
Copyright (c) 2026 The Legendre formalization contributors.
Released under Apache 2.0 license as described in the file LICENSE.

Local optimization of the actual complex-sample count in the sparse regime.
-/
module
public import Legendre.Layer4.Exponential.HalaszScale

@[expose] public section
namespace Legendre.Density.Oscillation
open Complex Set
open scoped BigOperators

noncomputable def halaszLargeValueBound (U : ℕ) (T E W : ℝ) : ℝ :=
  (3+16*T*(halaszRealPartCost U)^2*logarithmicKernelConstant^2*E^2/W^4)*
    ((2*halaszRealPartCost U*(U : ℝ)*(1+2*logarithmicKernelConstant*(1+Real.log (2*T)))*E)/W^2)

theorem halaszLargeValueBound_nonneg (U : ℕ) (T E W : ℝ) (hT : 1 ≤ T) (hE : 0 ≤ E) :
    0 ≤ halaszLargeValueBound U T E W := by
  have hC := logarithmicKernelConstant_pos
  have hB := halaszRealPartCost_pos U
  have hL : 0 ≤ Real.log (2*T) := Real.log_nonneg (by linarith)
  unfold halaszLargeValueBound
  positivity

/-- Optimize H=min(T,W^4/(8 B^2 C^2 E^2)) when this window is at least one. -/
theorem halasz_complex_sparse_count {ι : Type*} (S : Finset ι) (t β : ι → ℝ)
    (U : ℕ) (hU : 1 ≤ U) (a : ℕ → ℂ) (T σ b W : ℝ) (hT : 1 ≤ T) (hW : 0 < W)
    (hσb : σ ≤ b) (hlen : b-σ ≤ 1) (hβ : ∀ i ∈ S, β i ∈ Icc σ b)
    (ht : ∀ i ∈ S, |t i| ≤ T)
    (hs : ∀ i ∈ S, ∀ j ∈ S, i ≠ j → 1 ≤ |t i-t j|)
    (hw : ∀ i ∈ S, W ≤ ‖∑ n ∈ Finset.Ioc U (2*U), a n*(n : ℂ)^(-((β i : ℂ)+(t i : ℂ)*I))‖)
    (hE : 0 < coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ))
    (hsparse : 4*halaszRealPartCost U*logarithmicKernelConstant*
      coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ) ≤ W^2) :
    (S.card : ℝ) ≤ halaszLargeValueBound U T
      (coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ)) W := by
  let B := halaszRealPartCost U
  let E := coefficientEnergy (Finset.Ioc U (2*U)) (verticalCoefficients a σ)
  let H := min T (halaszAbsorptionScale B E W)
  let A := fun h : ℝ => (2*B*(U : ℝ)*(1+2*logarithmicKernelConstant*(1+Real.log (2*h)))*E)/W^2
  have hB : 0 < B := halaszRealPartCost_pos U
  have hC := logarithmicKernelConstant_pos
  have hHp : 1 ≤ H := le_min hT (one_le_halaszAbsorptionScale B E W hB hE hW hsparse)
  have hHpos : 0 < H := by linarith
  have hHT : H ≤ T := min_le_left _ _
  have hsmall : B*logarithmicKernelConstant*Real.sqrt (2*H)*E ≤ W^2/2 :=
    halasz_scale_absorbs B E W H hB hE hW (min_le_right _ _)
  have hc := halasz_complex_card_of_scale S t β U hU a T H σ b W hT hHp hW
    hσb hlen hβ ht hs hw hsmall
  have hA : A H ≤ A T := by
    dsimp [A]
    gcongr
  have hAnonneg : 0 ≤ A H := by
    have hL : 0 ≤ Real.log (2*H) := Real.log_nonneg (by linarith)
    dsimp [A]
    positivity
  have hglobal : 0 ≤ 3+16*T*B^2*logarithmicKernelConstant^2*E^2/W^4 := by positivity
  have hh := mul_le_mul (halasz_window_overhead B E W T hB hE hW (by linarith)) hA hAnonneg hglobal
  apply hc.trans
  change (1+2*T/H)*A H ≤ _
  simpa only [halaszLargeValueBound,A,B,E] using hh

end Legendre.Density.Oscillation
